Subject: [PATCH] MPC85XX TSEC driver: support for intel phy
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Cc: Kumar Gala <kumar.gala@freescale.com>
Content-Type: multipart/mixed; boundary="=-G6M81CLr9K86VLVG9kRz"
Message-Id: <1088505754.4834.28.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Date: Tue, 29 Jun 2004 12:42:39 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-G6M81CLr9K86VLVG9kRz
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I've added support for Intel-style PHYs to gianfar,
which is the one attached to the FEC on our module.

I'm a bit unsure on the naming, since the Intel PHYs
970-973 seem to be somewhat compatible, at least the
971 and 972 seem to share the relevant part of the
PHY identifier.
The actual chip that I worked on is a LXT972A.

Maybe some of the more experienced folks around the
list can share some insights on this.

PS: I hand-edited the patch to separate it from what's
    next, so "patch" may not actually like it...

--
Stefan Nickl
Kontron Modular Computers


--=-G6M81CLr9K86VLVG9kRz
Content-Disposition: attachment; filename=gfar_lxt971.patch
Content-Type: text/x-patch; name=gfar_lxt971.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- linuxppc-2.4/drivers/net/gianfar_phy.c	2004-05-18 14:29:35.000000000 +0200
+++ linuxppc-2.4_85xx/drivers/net/gianfar_phy.c	2004-06-29 11:59:54.000000000 +0200
@@ -227,6 +228,28 @@
 	return 0;
 }

+u16 mii_parse_lxt971_sr2(u16 mii_reg, struct net_device *dev)
+{
+	struct gfar_private *priv = (struct gfar_private *) dev->priv;
+
+	if(priv->link) {
+		if (mii_reg & MIIM_LXT971_SR2_DUPLEX)
+			priv->duplexity = 1;
+		else
+			priv->duplexity = 0;
+
+		if(mii_reg & MIIM_LXT971_SR2_SPEED)
+			priv->speed = 100;
+		else
+			priv->speed = 10;
+	} else {
+		priv->speed = 0;
+		priv->duplexity = 0;
+	}
+	return 0;
+}
+
 static struct phy_info phy_info_M88E1011S = {
 	0x01410c6,
 	"Marvell 88E1011S",
@@ -404,11 +444,70 @@
 	},
 };

+static struct phy_info phy_info_lxt971 = {
+	0x001378e,
+	"Intel LXT971",
+	4,
+	(const struct phy_cmd[]) {	/* config */
+		{MIIM_CONTROL, MIIM_CR_INIT, NULL},
+		{miim_end,}
+	},
+	(const struct phy_cmd[]) {	/* startup */
+		/* Status is read once to clear old link state */
+		{MIIM_STATUS, miim_read, NULL},
+		/* Auto-negotiate */
+		{MIIM_STATUS, miim_read, mii_parse_sr},
+		/* Read the status */
+		{MIIM_LXT971_SR2, miim_read, mii_parse_lxt971_sr2},
+		/* Clear the ISR register */
+		{MIIM_LXT971_ISR, miim_read, NULL},
+		/* Set up the mask */
+		{MIIM_LXT971_IER, MIIM_LXT971_IER_INIT, NULL},
+		{miim_end,}
+	},
+	(const struct phy_cmd[]) {	/* ack_int */
+		/* Clear the interrupt */
+		{MIIM_LXT971_ISR, miim_read, NULL},
+		/* Disable interrupts */
+		{MIIM_LXT971_IER, MIIM_LXT971_IER_CLEAR, NULL},
+		{miim_end,}
+	},
+	(const struct phy_cmd[]) {	/* handle_int */
+		/* Read the Status (2x to make sure link is right) */
+		{MIIM_STATUS, miim_read, NULL},
+		/* Check the status */
+		{MIIM_STATUS, miim_read, mii_parse_sr},
+		{MIIM_LXT971_SR2, miim_read, mii_parse_lxt971_sr2},
+		/* Enable Interrupts */
+		{MIIM_LXT971_IER, MIIM_LXT971_IER_INIT, NULL},
+		{miim_end,}
+	},
+	(const struct phy_cmd[]) {	/* shutdown */
+		{MIIM_LXT971_ISR, miim_read, NULL},
+		{MIIM_LXT971_IER, MIIM_LXT971_IER_CLEAR, NULL},
+		{miim_end,}
+	},
+};
+
+
 static struct phy_info *phy_info[] = {
 	&phy_info_cis8201,
 	&phy_info_cis8204,
 	&phy_info_M88E1011S,
 	&phy_info_dm9161,
+	&phy_info_lxt971,
 	NULL
 };


--=-G6M81CLr9K86VLVG9kRz--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
