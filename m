Message-ID: <094c01c1852b$04d9b8f0$337ceccb@dasan.com>
From: "Young-Han, Kim" <yhkim@da-san.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Cc: <Darth_vapor@mvista.com>
Subject: [PATCH] for ppc405_enet.h, ppc405_phy.c
Date: Sat, 15 Dec 2001 14:40:33 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Reader and Armin Kuster!

  I'm using the linuxppc_2_4_devel(2.4.17pre8).

  I found the serious problem of MDIO write(mk_mii_write).
  And, I was append the PHY relate functionality
for Broadcom BCM5221.
  I'll attach the these patch!


Best Regards
Young-Han, Kim


1.
[yhkim@power net]$ diff -c ppc405_enet.h.org ppc405_enet.h.yhkim
*** ppc405_enet.h.org   Fri Dec 14 11:27:52 2001
--- ppc405_enet.h.yhkim Sat Dec 15 13:35:22 2001
***************
*** 87,93 ****
                                                ~EMAC_STACR_CLK_100MHZ)
  #define mk_mii_write(REG,VAL)         (((EMAC_STACR_WRITE | (REG & 0x1f)) & \
                                                ~EMAC_STACR_CLK_100MHZ) | \
!                                               ((VAL & 0xffff) << 18))
  #define mk_mii_end                    0

  /* MAL Buffer Descriptor structure */
--- 87,93 ----
                                                ~EMAC_STACR_CLK_100MHZ)
  #define mk_mii_write(REG,VAL)         (((EMAC_STACR_WRITE | (REG & 0x1f)) & \
                                                ~EMAC_STACR_CLK_100MHZ) | \
!                                               ((VAL & 0xffff) << 16))
  #define mk_mii_end                    0

  /* MAL Buffer Descriptor structure */


2.
[yhkim@power net]$ diff -c ppc405_phy.c.org ppc405_phy.c.yhkim
*** ppc405_phy.c.org    Wed Dec 12 20:47:04 2001
--- ppc405_phy.c.yhkim  Sat Dec 15 13:43:06 2001
***************
*** 283,288 ****
--- 283,290 ----
        struct fec_enet_private *fep = dev->priv;
        volatile uint *s = &(fep->phy_status);

+       *s &= ~(PHY_CONF_SPMASK);
+
        if (mii_reg & 0x0020)
                *s |= PHY_CONF_10HDX;
        if (mii_reg & 0x0040)
***************
*** 721,726 ****
--- 723,820 ----
  };


+ /* ------------------------------------------------------------------------- */
+ /* The Broadcom BCM5221 */
+
+ /* register definitions */
+
+ #define MII_BCM5221_IER 0x1a
+ #define MII_BCM5221_ISR 0x1a
+ #define MII_BCM5221_SR  0x19
+ #define MII_BCM5221_CSR 0x18
+
+ void mii_parse_bcm5221_sr(uint mii_reg, struct net_device *dev)
+ {
+       struct fec_enet_private *fep = dev->priv;
+       volatile uint *s = &(fep->phy_status);
+
+       *s &= ~(PHY_STAT_LINK | PHY_STAT_FAULT | PHY_STAT_ANC);
+
+       if (mii_reg & 0x0004)
+               *s |= PHY_STAT_LINK;
+       if (mii_reg & 0x0040)
+               *s |= PHY_STAT_FAULT;
+       if (mii_reg & 0x8000)
+               *s |= PHY_STAT_ANC;
+ }
+
+ void mii_parse_bcm5221_csr(uint mii_reg, struct net_device *dev)
+ {
+       struct fec_enet_private *fep = dev->priv;
+       volatile uint *s = &(fep->phy_status);
+
+       *s &= ~(PHY_STAT_SPMASK);
+
+       if (mii_reg & 0x0002) {
+               if (mii_reg & 0x0001)
+                       *s |= PHY_STAT_100FDX;
+               else
+                       *s |= PHY_STAT_100HDX;
+       }
+       else {
+               if (mii_reg & 0x0001)
+                       *s |= PHY_STAT_10FDX;
+               else
+                       *s |= PHY_STAT_10HDX;
+       }
+ }
+
+ static phy_info_t phy_info_bcm5221 = {
+       0x0004061e,
+       "BCM5221",
+       4,
+       (const phy_cmd_t []) {  /* config */
+               { mk_mii_write(MII_REG_CR, 0x8000), NULL }, /* reset */
+               { mk_mii_read(MII_BCM5221_SR), NULL },
+               { mk_mii_read(MII_BCM5221_ISR), NULL },
+               { mk_mii_read(MII_BCM5221_CSR), NULL },
+
+               { mk_mii_read(MII_REG_CR), mii_parse_cr },
+               { mk_mii_read(MII_REG_ANAR), mii_parse_anar },
+               { mk_mii_end, }
+       },
+       (const phy_cmd_t []) {  /* startup - enable interrupts */
+               { mk_mii_read(MII_BCM5221_SR), NULL },
+               { mk_mii_read(MII_BCM5221_ISR), NULL },
+               { mk_mii_read(MII_BCM5221_CSR), NULL },
+
+ #if 0
+               { mk_mii_write(MII_BCM5221_IER, 0x4000), NULL },
+ #endif
+               { mk_mii_write(MII_REG_CR, 0x1200), NULL },     /* autonegotiate */
+               { mk_mii_read(MII_BCM5221_SR), mii_parse_bcm5221_sr },
+               { mk_mii_read(MII_BCM5221_SR), mii_parse_bcm5221_sr },
+               { mk_mii_read(MII_BCM5221_CSR), mii_parse_bcm5221_csr },
+
+               { mk_mii_end, }
+       },
+       (const phy_cmd_t []) {  /* ack_int */
+               /* read SR and ISR to acknowledge */
+               { mk_mii_read(MII_BCM5221_SR), mii_parse_bcm5221_sr },
+               { mk_mii_read(MII_BCM5221_SR), mii_parse_bcm5221_sr },
+               { mk_mii_read(MII_BCM5221_ISR), NULL },
+               /* find out the current status */
+               { mk_mii_read(MII_BCM5221_CSR), mii_parse_bcm5221_csr },
+               { mk_mii_end, }
+       },
+       (const phy_cmd_t []) {  /* shutdown - disable interrupts */
+               { mk_mii_write(MII_BCM5221_IER, 0x0000), NULL },
+               { mk_mii_end, }
+       },
+ };
+
+
+
  static phy_info_t *phy_info[] = {

        &phy_info_dp83843,
***************
*** 729,734 ****
--- 823,829 ----
        &phy_info_dp83846A,
        &phy_info_lu3x31ft,
        &phy_info_Am79C875,
+       &phy_info_bcm5221,
        NULL
  };


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
