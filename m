Date: Thu, 29 Nov 2001 11:05:30 -0500
From: Kent Borg <kentborg@borg.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH] New PHY for ppc405_phy.c
Message-ID: <20011129110530.E3091@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I hope I am sending this to the right place, someone please correct me
if I am doing this wrong...


Our 405 board has a different PHY from those supported in the current
sources, the following patch makes our PHY work.  If it looks
sensible, please apply.


Thanks,

-kb



--- linuxppc_2_4_devel/drivers/net/ppc405_phy.c	Thu Nov 29 10:34:53 2001
+++ linux-penguinppc4/drivers/net/ppc405_phy.c	Thu Nov 29 10:48:07 2001
@@ -579,6 +579,75 @@
 	},
 };

+/* ------------------------------------------------------------------------- */
+/* The Lucent Technologies LU3X31FT */
+
+/* register definitions */
+
+#define MII_LU3X31FT_PHYCTRLSTS 0x17    /* PHY Control/Status Register */
+#define MII_LU3X31FT_IER        0x1D    /* PHY interrupt enable Register */
+#define MII_LU3X31FT_ISR        0x1E    /* PHY interrupt status Register */
+
+static void mii_parse_lu3x31ft_pcr(uint mii_reg, struct net_device *dev)
+{
+	struct fec_enet_private *fep = dev->priv;
+	volatile uint *s = &(fep->phy_status);
+
+	*s &= ~(PHY_STAT_SPMASK);
+
+	switch((mii_reg >> 8) & 3) {
+		case 0:
+			*s |= PHY_STAT_10HDX;
+			break;
+		case 1:
+			*s |= PHY_STAT_10FDX;
+			break;
+		case 2:
+			*s |= PHY_STAT_100HDX;
+			break;
+		case 3:
+			*s |= PHY_STAT_100FDX;
+			break;
+	}
+}
+
+static phy_info_t phy_info_lu3x31ft = {
+	0x90307421,
+	"LU3X31FT",
+	0,
+	(const phy_cmd_t []) {	/* config */
+
+		/* parse cr and anar to get some info */
+
+		{ mk_mii_read(MII_REG_CR), mii_parse_cr },
+		{ mk_mii_read(MII_REG_ANAR), mii_parse_anar },
+		{ mk_mii_end, }
+	},
+	(const phy_cmd_t []) {	/* startup - enable interrupts */
+		{ mk_mii_write(MII_LU3X31FT_IER, 0x0000), NULL },
+		{ mk_mii_write(MII_REG_CR, PHY_BMCR_RST_NEG), NULL }, /* autonegotiate */
+		{ mk_mii_end, }
+	},
+	( const phy_cmd_t []) { /* ack_int */
+
+		/* we need to read ISR, SR and ANER to acknowledge */
+
+		{ mk_mii_read(MII_LU3X31FT_ISR), NULL },
+		{ mk_mii_read(MII_REG_SR), mii_parse_sr },
+		{ mk_mii_read(MII_REG_ANAR), mii_parse_anar },
+
+		/* read pcr to get info */
+
+		{ mk_mii_read(MII_LU3X31FT_PHYCTRLSTS), mii_parse_lu3x31ft_pcr },
+		{ mk_mii_end, }
+	},
+	( const phy_cmd_t []) {	/* shutdown - disable interrupts */
+		{ mk_mii_write(MII_LU3X31FT_IER, 0xff80), NULL },
+		{ mk_mii_end, }
+	},
+};
+
+

 /* ------------------------------------------------------------------------- */
 /* The AMD Am79C875*/
@@ -659,6 +728,7 @@
 	&phy_info_lxt971a,
 	&phy_info_cs8952,
 	&phy_info_dp83846A,
+	&phy_info_lu3x31ft,
 	&phy_info_Am79C875,
 	NULL
 };

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
