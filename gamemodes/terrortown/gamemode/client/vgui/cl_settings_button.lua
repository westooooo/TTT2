local PANEL = {}

AccessorFunc(PANEL, "m_bBorder", "DrawBorder", FORCE_BOOL)

function PANEL:Init()
	self:SetContentAlignment(5)

	--
	-- These are Lua side commands
	-- Defined above using AccessorFunc
	--
	self:SetDrawBorder(true)
	self:SetPaintBackground(true)

	self:SetTall(75)
	self:SetWide(50)
	self:SetMouseInputEnabled(true)
	self:SetKeyboardInputEnabled(true)

	self:SetCursor("hand")
	self:SetFont("DermaDefault")
end

function PANEL:IsDown()
	return self.Depressed
end

function PANEL:SetImage(img)
	if not img then
		if IsValid(self.m_Image) then
			self.m_Image:Remove()
		end

		return
	end

	if not IsValid(self.m_Image) then
		self.m_Image = vgui.Create("DImage", self)
	end

	self.m_Image:SetImage(img)
	self.m_Image:SizeToContents()

	self:InvalidateLayout()
end
PANEL.SetIcon = PANEL.SetImage

function PANEL:Paint(w, h)
	derma.SkinHook("Paint", "Button", self, w, h)

	--
	-- Draw the button text
	--
	return false
end

function PANEL:PerformLayout()
	--
	-- If we have an image we have to place the image on the left
	-- and make the text align to the left, then set the inset
	-- so the text will be to the right of the icon.
	--
	if IsValid(self.m_Image) then
		self.m_Image:SetPos(4, (self:GetTall() - self.m_Image:GetTall()) * 0.5)

		self:SetTextInset(self.m_Image:GetWide() + 16, 0)
	end

	DLabel.PerformLayout(self)
end

function PANEL:SetConsoleCommand(strName, strArgs)
	self.DoClick = function(self, val)
		RunConsoleCommand(strName, strArgs)
	end
end

function PANEL:SizeToContents()
	local w, h = self:GetContentSize()

	self:SetSize(w + 40, h + 30)
end

local PANEL = derma.DefineControl("DSettingsButton", "A settings Button", PANEL, "DButton")
