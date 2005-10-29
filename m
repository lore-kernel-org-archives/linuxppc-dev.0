Return-Path: <akpm@osdl.org>
Message-Id: <200510290046.j9T0kvrA030032@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:27 -0700
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, Kumar.gala@freescale.com,
	linuxppc64-dev@ozlabs.org
Subject: [patch 15/43] ppc32: 85xx PHY Platform Update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Andy Fleming <afleming@freescale.com>

This patch updates the 85xx platform code to support the new PHY Layer.

Signed-off-by: Andy Fleming <afleming@freescale.com>
Signed-off-by: Kumar Gala <Kumar.gala@freescale.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ppc/platforms/85xx/mpc8540_ads.c        |   30 +++++++++++-------
 arch/ppc/platforms/85xx/mpc8560_ads.c        |   25 ++++++++++-----
 arch/ppc/platforms/85xx/mpc85xx_cds_common.c |   34 +++++++++++---------
 arch/ppc/platforms/85xx/sbc8560.c            |   22 ++++++++-----
 arch/ppc/platforms/85xx/stx_gp3.c            |   21 ++++++++----
 arch/ppc/syslib/mpc85xx_devices.c            |   17 ++++++----
 arch/ppc/syslib/mpc85xx_sys.c                |   44 +++++++++++++++++----------
 include/asm-ppc/mpc85xx.h                    |    3 +
 include/linux/fsl_devices.h                  |   13 +++++--
 9 files changed, 131 insertions(+), 78 deletions(-)

diff -puN arch/ppc/platforms/85xx/mpc8540_ads.c~ppc32-85xx-phy-platform-update arch/ppc/platforms/85xx/mpc8540_ads.c
--- devel/arch/ppc/platforms/85xx/mpc8540_ads.c~ppc32-85xx-phy-platform-update	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/arch/ppc/platforms/85xx/mpc8540_ads.c	2005-10-28 17:44:03.000000000 -0700
@@ -52,6 +52,10 @@
 
 #include <syslib/ppc85xx_setup.h>
 
+static const char *GFAR_PHY_0 = "phy0:0";
+static const char *GFAR_PHY_1 = "phy0:1";
+static const char *GFAR_PHY_3 = "phy0:3";
+
 /* ************************************************************************
  *
  * Setup the architecture
@@ -63,6 +67,7 @@ mpc8540ads_setup_arch(void)
 	bd_t *binfo = (bd_t *) __res;
 	unsigned int freq;
 	struct gianfar_platform_data *pdata;
+	struct gianfar_mdio_data *mdata;
 
 	/* get the core frequency */
 	freq = binfo->bi_intfreq;
@@ -89,34 +94,35 @@ mpc8540ads_setup_arch(void)
 	invalidate_tlbcam_entry(num_tlbcam_entries - 1);
 #endif
 
+	/* setup the board related info for the MDIO bus */
+	mdata = (struct gianfar_mdio_data *) ppc_sys_get_pdata(MPC85xx_MDIO);
+
+	mdata->irq[0] = MPC85xx_IRQ_EXT5;
+	mdata->irq[1] = MPC85xx_IRQ_EXT5;
+	mdata->irq[2] = -1;
+	mdata->irq[3] = MPC85xx_IRQ_EXT5;
+	mdata->irq[31] = -1;
+	mdata->paddr += binfo->bi_immr_base;
+
 	/* setup the board related information for the enet controllers */
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC1);
 	if (pdata) {
 		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-		pdata->interruptPHY = MPC85xx_IRQ_EXT5;
-		pdata->phyid = 0;
-		/* fixup phy address */
-		pdata->phy_reg_addr += binfo->bi_immr_base;
+		pdata->bus_id = GFAR_PHY_0;
 		memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
 	}
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC2);
 	if (pdata) {
 		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-		pdata->interruptPHY = MPC85xx_IRQ_EXT5;
-		pdata->phyid = 1;
-		/* fixup phy address */
-		pdata->phy_reg_addr += binfo->bi_immr_base;
+		pdata->bus_id = GFAR_PHY_1;
 		memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
 	}
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_FEC);
 	if (pdata) {
 		pdata->board_flags = 0;
-		pdata->interruptPHY = MPC85xx_IRQ_EXT5;
-		pdata->phyid = 3;
-		/* fixup phy address */
-		pdata->phy_reg_addr += binfo->bi_immr_base;
+		pdata->bus_id = GFAR_PHY_3;
 		memcpy(pdata->mac_addr, binfo->bi_enet2addr, 6);
 	}
 
diff -puN arch/ppc/platforms/85xx/mpc8560_ads.c~ppc32-85xx-phy-platform-update arch/ppc/platforms/85xx/mpc8560_ads.c
--- devel/arch/ppc/platforms/85xx/mpc8560_ads.c~ppc32-85xx-phy-platform-update	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/arch/ppc/platforms/85xx/mpc8560_ads.c	2005-10-28 17:44:03.000000000 -0700
@@ -56,6 +56,10 @@
 #include <syslib/ppc85xx_setup.h>
 
 
+static const char *GFAR_PHY_0 = "phy0:0";
+static const char *GFAR_PHY_1 = "phy0:1";
+static const char *GFAR_PHY_3 = "phy0:3";
+
 /* ************************************************************************
  *
  * Setup the architecture
@@ -68,6 +72,7 @@ mpc8560ads_setup_arch(void)
 	bd_t *binfo = (bd_t *) __res;
 	unsigned int freq;
 	struct gianfar_platform_data *pdata;
+	struct gianfar_mdio_data *mdata;
 
 	cpm2_reset();
 
@@ -86,24 +91,28 @@ mpc8560ads_setup_arch(void)
 	mpc85xx_setup_hose();
 #endif
 
+	/* setup the board related info for the MDIO bus */
+	mdata = (struct gianfar_mdio_data *) ppc_sys_get_pdata(MPC85xx_MDIO);
+
+	mdata->irq[0] = MPC85xx_IRQ_EXT5;
+	mdata->irq[1] = MPC85xx_IRQ_EXT5;
+	mdata->irq[2] = -1;
+	mdata->irq[3] = MPC85xx_IRQ_EXT5;
+	mdata->irq[31] = -1;
+	mdata->paddr += binfo->bi_immr_base;
+
 	/* setup the board related information for the enet controllers */
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC1);
 	if (pdata) {
 		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-		pdata->interruptPHY = MPC85xx_IRQ_EXT5;
-		pdata->phyid = 0;
-		/* fixup phy address */
-		pdata->phy_reg_addr += binfo->bi_immr_base;
+		pdata->bus_id = GFAR_PHY_0;
 		memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
 	}
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC2);
 	if (pdata) {
 		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-		pdata->interruptPHY = MPC85xx_IRQ_EXT5;
-		pdata->phyid = 1;
-		/* fixup phy address */
-		pdata->phy_reg_addr += binfo->bi_immr_base;
+		pdata->bus_id = GFAR_PHY_1;
 		memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
 	}
 
diff -puN arch/ppc/platforms/85xx/mpc85xx_cds_common.c~ppc32-85xx-phy-platform-update arch/ppc/platforms/85xx/mpc85xx_cds_common.c
--- devel/arch/ppc/platforms/85xx/mpc85xx_cds_common.c~ppc32-85xx-phy-platform-update	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2005-10-28 17:44:03.000000000 -0700
@@ -394,6 +394,9 @@ mpc85xx_cds_pcibios_fixup(void)
 
 TODC_ALLOC();
 
+static const char *GFAR_PHY_0 = "phy0:0";
+static const char *GFAR_PHY_1 = "phy0:1";
+
 /* ************************************************************************
  *
  * Setup the architecture
@@ -405,6 +408,7 @@ mpc85xx_cds_setup_arch(void)
 	bd_t *binfo = (bd_t *) __res;
 	unsigned int freq;
 	struct gianfar_platform_data *pdata;
+	struct gianfar_mdio_data *mdata;
 
 	/* get the core frequency */
 	freq = binfo->bi_intfreq;
@@ -448,44 +452,42 @@ mpc85xx_cds_setup_arch(void)
 	invalidate_tlbcam_entry(num_tlbcam_entries - 1);
 #endif
 
+	/* setup the board related info for the MDIO bus */
+	mdata = (struct gianfar_mdio_data *) ppc_sys_get_pdata(MPC85xx_MDIO);
+
+	mdata->irq[0] = MPC85xx_IRQ_EXT5;
+	mdata->irq[1] = MPC85xx_IRQ_EXT5;
+	mdata->irq[2] = -1;
+	mdata->irq[3] = -1;
+	mdata->irq[31] = -1;
+	mdata->paddr += binfo->bi_immr_base;
+
 	/* setup the board related information for the enet controllers */
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC1);
 	if (pdata) {
 		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-		pdata->interruptPHY = MPC85xx_IRQ_EXT5;
-		pdata->phyid = 0;
-		/* fixup phy address */
-		pdata->phy_reg_addr += binfo->bi_immr_base;
+		pdata->bus_id = GFAR_PHY_0;
 		memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
 	}
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC2);
 	if (pdata) {
 		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-		pdata->interruptPHY = MPC85xx_IRQ_EXT5;
-		pdata->phyid = 1;
-		/* fixup phy address */
-		pdata->phy_reg_addr += binfo->bi_immr_base;
+		pdata->bus_id = GFAR_PHY_1;
 		memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
 	}
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_eTSEC1);
 	if (pdata) {
 		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-		pdata->interruptPHY = MPC85xx_IRQ_EXT5;
-		pdata->phyid = 0;
-		/* fixup phy address */
-		pdata->phy_reg_addr += binfo->bi_immr_base;
+		pdata->bus_id = GFAR_PHY_0;
 		memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
 	}
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_eTSEC2);
 	if (pdata) {
 		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-		pdata->interruptPHY = MPC85xx_IRQ_EXT5;
-		pdata->phyid = 1;
-		/* fixup phy address */
-		pdata->phy_reg_addr += binfo->bi_immr_base;
+		pdata->bus_id = GFAR_PHY_1;
 		memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
 	}
 
diff -puN arch/ppc/platforms/85xx/sbc8560.c~ppc32-85xx-phy-platform-update arch/ppc/platforms/85xx/sbc8560.c
--- devel/arch/ppc/platforms/85xx/sbc8560.c~ppc32-85xx-phy-platform-update	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/arch/ppc/platforms/85xx/sbc8560.c	2005-10-28 17:44:03.000000000 -0700
@@ -91,6 +91,9 @@ sbc8560_early_serial_map(void)
 }
 #endif
 
+static const char *GFAR_PHY_25 = "phy0:25";
+static const char *GFAR_PHY_26 = "phy0:26";
+
 /* ************************************************************************
  *
  * Setup the architecture
@@ -102,6 +105,7 @@ sbc8560_setup_arch(void)
 	bd_t *binfo = (bd_t *) __res;
 	unsigned int freq;
 	struct gianfar_platform_data *pdata;
+	struct gianfar_mdio_data *mdata;
 
 	/* get the core frequency */
 	freq = binfo->bi_intfreq;
@@ -126,24 +130,26 @@ sbc8560_setup_arch(void)
 	invalidate_tlbcam_entry(num_tlbcam_entries - 1);
 #endif
 
+	/* setup the board related info for the MDIO bus */
+	mdata = (struct gianfar_mdio_data *) ppc_sys_get_pdata(MPC85xx_MDIO);
+
+	mdata->irq[25] = MPC85xx_IRQ_EXT6;
+	mdata->irq[26] = MPC85xx_IRQ_EXT7;
+	mdata->irq[31] = -1;
+	mdata->paddr += binfo->bi_immr_base;
+
 	/* setup the board related information for the enet controllers */
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC1);
 	if (pdata) {
 		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-		pdata->interruptPHY = MPC85xx_IRQ_EXT6;
-		pdata->phyid = 25;
-		/* fixup phy address */
-		pdata->phy_reg_addr += binfo->bi_immr_base;
+		pdata->bus_id = GFAR_PHY_25;
 		memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
 	}
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC2);
 	if (pdata) {
 		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-		pdata->interruptPHY = MPC85xx_IRQ_EXT7;
-		pdata->phyid = 26;
-		/* fixup phy address */
-		pdata->phy_reg_addr += binfo->bi_immr_base;
+		pdata->bus_id = GFAR_PHY_26;
 		memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
 	}
 
diff -puN arch/ppc/platforms/85xx/stx_gp3.c~ppc32-85xx-phy-platform-update arch/ppc/platforms/85xx/stx_gp3.c
--- devel/arch/ppc/platforms/85xx/stx_gp3.c~ppc32-85xx-phy-platform-update	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/arch/ppc/platforms/85xx/stx_gp3.c	2005-10-28 17:44:03.000000000 -0700
@@ -91,6 +91,9 @@ static u8 gp3_openpic_initsenses[] __ini
 	0x0,				/* External 11: */
 };
 
+static const char *GFAR_PHY_2 = "phy0:2";
+static const char *GFAR_PHY_4 = "phy0:4";
+
 /*
  * Setup the architecture
  */
@@ -100,6 +103,7 @@ gp3_setup_arch(void)
 	bd_t *binfo = (bd_t *) __res;
 	unsigned int freq;
 	struct gianfar_platform_data *pdata;
+	struct gianfar_mdio_data *mdata;
 
 	cpm2_reset();
 
@@ -118,23 +122,26 @@ gp3_setup_arch(void)
 	mpc85xx_setup_hose();
 #endif
 
+	/* setup the board related info for the MDIO bus */
+	mdata = (struct gianfar_mdio_data *) ppc_sys_get_pdata(MPC85xx_MDIO);
+
+	mdata->irq[2] = MPC85xx_IRQ_EXT5;
+	mdata->irq[4] = MPC85xx_IRQ_EXT5;
+	mdata->irq[31] = -1;
+	mdata->paddr += binfo->bi_immr_base;
+
 	/* setup the board related information for the enet controllers */
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC1);
 	if (pdata) {
 	/*	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR; */
-		pdata->interruptPHY = MPC85xx_IRQ_EXT5;
-		pdata->phyid = 2;
-		pdata->phy_reg_addr += binfo->bi_immr_base;
+		pdata->bus_id = GFAR_PHY_2;
 		memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
 	}
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC2);
 	if (pdata) {
 	/*	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR; */
-		pdata->interruptPHY = MPC85xx_IRQ_EXT5;
-		pdata->phyid = 4;
-		/* fixup phy address */
-		pdata->phy_reg_addr += binfo->bi_immr_base;
+		pdata->bus_id = GFAR_PHY_4;
 		memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
 	}
 
diff -puN arch/ppc/syslib/mpc85xx_devices.c~ppc32-85xx-phy-platform-update arch/ppc/syslib/mpc85xx_devices.c
--- devel/arch/ppc/syslib/mpc85xx_devices.c~ppc32-85xx-phy-platform-update	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/arch/ppc/syslib/mpc85xx_devices.c	2005-10-28 17:44:03.000000000 -0700
@@ -25,19 +25,20 @@
 /* We use offsets for IORESOURCE_MEM since we do not know at compile time
  * what CCSRBAR is, will get fixed up by mach_mpc85xx_fixup
  */
+struct gianfar_mdio_data mpc85xx_mdio_pdata = {
+	.paddr = MPC85xx_MIIM_OFFSET,
+};
 
 static struct gianfar_platform_data mpc85xx_tsec1_pdata = {
 	.device_flags = FSL_GIANFAR_DEV_HAS_GIGABIT |
 	    FSL_GIANFAR_DEV_HAS_COALESCE | FSL_GIANFAR_DEV_HAS_RMON |
 	    FSL_GIANFAR_DEV_HAS_MULTI_INTR,
-	.phy_reg_addr = MPC85xx_ENET1_OFFSET,
 };
 
 static struct gianfar_platform_data mpc85xx_tsec2_pdata = {
 	.device_flags = FSL_GIANFAR_DEV_HAS_GIGABIT |
 	    FSL_GIANFAR_DEV_HAS_COALESCE | FSL_GIANFAR_DEV_HAS_RMON |
 	    FSL_GIANFAR_DEV_HAS_MULTI_INTR,
-	.phy_reg_addr = MPC85xx_ENET1_OFFSET,
 };
 
 static struct gianfar_platform_data mpc85xx_etsec1_pdata = {
@@ -46,7 +47,6 @@ static struct gianfar_platform_data mpc8
 	    FSL_GIANFAR_DEV_HAS_MULTI_INTR |
 	    FSL_GIANFAR_DEV_HAS_CSUM | FSL_GIANFAR_DEV_HAS_VLAN |
 	    FSL_GIANFAR_DEV_HAS_EXTENDED_HASH,
-	.phy_reg_addr = MPC85xx_ENET1_OFFSET,
 };
 
 static struct gianfar_platform_data mpc85xx_etsec2_pdata = {
@@ -55,7 +55,6 @@ static struct gianfar_platform_data mpc8
 	    FSL_GIANFAR_DEV_HAS_MULTI_INTR |
 	    FSL_GIANFAR_DEV_HAS_CSUM | FSL_GIANFAR_DEV_HAS_VLAN |
 	    FSL_GIANFAR_DEV_HAS_EXTENDED_HASH,
-	.phy_reg_addr = MPC85xx_ENET1_OFFSET,
 };
 
 static struct gianfar_platform_data mpc85xx_etsec3_pdata = {
@@ -64,7 +63,6 @@ static struct gianfar_platform_data mpc8
 	    FSL_GIANFAR_DEV_HAS_MULTI_INTR |
 	    FSL_GIANFAR_DEV_HAS_CSUM | FSL_GIANFAR_DEV_HAS_VLAN |
 	    FSL_GIANFAR_DEV_HAS_EXTENDED_HASH,
-	.phy_reg_addr = MPC85xx_ENET1_OFFSET,
 };
 
 static struct gianfar_platform_data mpc85xx_etsec4_pdata = {
@@ -73,11 +71,10 @@ static struct gianfar_platform_data mpc8
 	    FSL_GIANFAR_DEV_HAS_MULTI_INTR |
 	    FSL_GIANFAR_DEV_HAS_CSUM | FSL_GIANFAR_DEV_HAS_VLAN |
 	    FSL_GIANFAR_DEV_HAS_EXTENDED_HASH,
-	.phy_reg_addr = MPC85xx_ENET1_OFFSET,
 };
 
 static struct gianfar_platform_data mpc85xx_fec_pdata = {
-	.phy_reg_addr = MPC85xx_ENET1_OFFSET,
+	.device_flags = 0,
 };
 
 static struct fsl_i2c_platform_data mpc85xx_fsl_i2c_pdata = {
@@ -719,6 +716,12 @@ struct platform_device ppc_sys_platform_
 			},
 		},
 	},
+	[MPC85xx_MDIO] = {
+		.name = "fsl-gianfar_mdio",
+		.id = 0,
+		.dev.platform_data = &mpc85xx_mdio_pdata,
+		.num_resources = 0,
+	},
 };
 
 static int __init mach_mpc85xx_fixup(struct platform_device *pdev)
diff -puN arch/ppc/syslib/mpc85xx_sys.c~ppc32-85xx-phy-platform-update arch/ppc/syslib/mpc85xx_sys.c
--- devel/arch/ppc/syslib/mpc85xx_sys.c~ppc32-85xx-phy-platform-update	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/arch/ppc/syslib/mpc85xx_sys.c	2005-10-28 17:44:03.000000000 -0700
@@ -24,19 +24,19 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 		.ppc_sys_name	= "8540",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80300000,
-		.num_devices	= 10,
+		.num_devices	= 11,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC85xx_TSEC1, MPC85xx_TSEC2, MPC85xx_FEC, MPC85xx_IIC1,
 			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
-			MPC85xx_PERFMON, MPC85xx_DUART,
+			MPC85xx_PERFMON, MPC85xx_DUART, MPC85xx_MDIO,
 		},
 	},
 	{
 		.ppc_sys_name	= "8560",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80700000,
-		.num_devices	= 19,
+		.num_devices	= 20,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC85xx_TSEC1, MPC85xx_TSEC2, MPC85xx_IIC1,
@@ -45,14 +45,14 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 			MPC85xx_CPM_SPI, MPC85xx_CPM_I2C, MPC85xx_CPM_SCC1,
 			MPC85xx_CPM_SCC2, MPC85xx_CPM_SCC3, MPC85xx_CPM_SCC4,
 			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2, MPC85xx_CPM_FCC3,
-			MPC85xx_CPM_MCC1, MPC85xx_CPM_MCC2,
+			MPC85xx_CPM_MCC1, MPC85xx_CPM_MCC2, MPC85xx_MDIO,
 		},
 	},
 	{
 		.ppc_sys_name	= "8541",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80720000,
-		.num_devices	= 13,
+		.num_devices	= 14,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC85xx_TSEC1, MPC85xx_TSEC2, MPC85xx_IIC1,
@@ -60,13 +60,14 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 			MPC85xx_PERFMON, MPC85xx_DUART,
 			MPC85xx_CPM_SPI, MPC85xx_CPM_I2C,
 			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2,
+			MPC85xx_MDIO,
 		},
 	},
 	{
 		.ppc_sys_name	= "8541E",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x807A0000,
-		.num_devices	= 14,
+		.num_devices	= 15,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC85xx_TSEC1, MPC85xx_TSEC2, MPC85xx_IIC1,
@@ -74,13 +75,14 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 			MPC85xx_PERFMON, MPC85xx_DUART, MPC85xx_SEC2,
 			MPC85xx_CPM_SPI, MPC85xx_CPM_I2C,
 			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2,
+			MPC85xx_MDIO,
 		},
 	},
 	{
 		.ppc_sys_name	= "8555",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80710000,
-		.num_devices	= 19,
+		.num_devices	= 20,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC85xx_TSEC1, MPC85xx_TSEC2, MPC85xx_IIC1,
@@ -91,13 +93,14 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2,
 			MPC85xx_CPM_SMC1, MPC85xx_CPM_SMC2,
 			MPC85xx_CPM_USB,
+			MPC85xx_MDIO,
 		},
 	},
 	{
 		.ppc_sys_name	= "8555E",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80790000,
-		.num_devices	= 20,
+		.num_devices	= 21,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC85xx_TSEC1, MPC85xx_TSEC2, MPC85xx_IIC1,
@@ -108,6 +111,7 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 			MPC85xx_CPM_FCC1, MPC85xx_CPM_FCC2,
 			MPC85xx_CPM_SMC1, MPC85xx_CPM_SMC2,
 			MPC85xx_CPM_USB,
+			MPC85xx_MDIO,
 		},
 	},
 	/* SVRs on 8548 rev1.0 matches for 8548/8547/8545 */
@@ -115,104 +119,112 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 		.ppc_sys_name	= "8548E",
 		.mask 		= 0xFFFF00F0,
 		.value 		= 0x80390010,
-		.num_devices	= 13,
+		.num_devices	= 14,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC85xx_eTSEC1, MPC85xx_eTSEC2, MPC85xx_eTSEC3,
 			MPC85xx_eTSEC4, MPC85xx_IIC1, MPC85xx_IIC2,
 			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
 			MPC85xx_PERFMON, MPC85xx_DUART, MPC85xx_SEC2,
+			MPC85xx_MDIO,
 		},
 	},
 	{
 		.ppc_sys_name	= "8548",
 		.mask 		= 0xFFFF00F0,
 		.value 		= 0x80310010,
-		.num_devices	= 12,
+		.num_devices	= 13,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC85xx_eTSEC1, MPC85xx_eTSEC2, MPC85xx_eTSEC3,
 			MPC85xx_eTSEC4, MPC85xx_IIC1, MPC85xx_IIC2,
 			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
 			MPC85xx_PERFMON, MPC85xx_DUART,
+			MPC85xx_MDIO,
 		},
 	},
 	{
 		.ppc_sys_name	= "8547E",
 		.mask 		= 0xFFFF00F0,
 		.value 		= 0x80390010,
-		.num_devices	= 13,
+		.num_devices	= 14,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC85xx_eTSEC1, MPC85xx_eTSEC2, MPC85xx_eTSEC3,
 			MPC85xx_eTSEC4, MPC85xx_IIC1, MPC85xx_IIC2,
 			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
 			MPC85xx_PERFMON, MPC85xx_DUART, MPC85xx_SEC2,
+			MPC85xx_MDIO,
 		},
 	},
 	{
 		.ppc_sys_name	= "8547",
 		.mask 		= 0xFFFF00F0,
 		.value 		= 0x80310010,
-		.num_devices	= 12,
+		.num_devices	= 13,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC85xx_eTSEC1, MPC85xx_eTSEC2, MPC85xx_eTSEC3,
 			MPC85xx_eTSEC4, MPC85xx_IIC1, MPC85xx_IIC2,
 			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
 			MPC85xx_PERFMON, MPC85xx_DUART,
+			MPC85xx_MDIO,
 		},
 	},
 	{
 		.ppc_sys_name	= "8545E",
 		.mask 		= 0xFFFF00F0,
 		.value 		= 0x80390010,
-		.num_devices	= 11,
+		.num_devices	= 12,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC85xx_eTSEC1, MPC85xx_eTSEC2,
 			MPC85xx_IIC1, MPC85xx_IIC2,
 			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
 			MPC85xx_PERFMON, MPC85xx_DUART, MPC85xx_SEC2,
+			MPC85xx_MDIO,
 		},
 	},
 	{
 		.ppc_sys_name	= "8545",
 		.mask 		= 0xFFFF00F0,
 		.value 		= 0x80310010,
-		.num_devices	= 10,
+		.num_devices	= 11,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC85xx_eTSEC1, MPC85xx_eTSEC2,
 			MPC85xx_IIC1, MPC85xx_IIC2,
 			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
 			MPC85xx_PERFMON, MPC85xx_DUART,
+			MPC85xx_MDIO,
 		},
 	},
 	{
 		.ppc_sys_name	= "8543E",
 		.mask 		= 0xFFFF00F0,
 		.value 		= 0x803A0010,
-		.num_devices	= 11,
+		.num_devices	= 12,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC85xx_eTSEC1, MPC85xx_eTSEC2,
 			MPC85xx_IIC1, MPC85xx_IIC2,
 			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
 			MPC85xx_PERFMON, MPC85xx_DUART, MPC85xx_SEC2,
+			MPC85xx_MDIO,
 		},
 	},
 	{
 		.ppc_sys_name	= "8543",
 		.mask 		= 0xFFFF00F0,
 		.value 		= 0x80320010,
-		.num_devices	= 10,
+		.num_devices	= 11,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC85xx_eTSEC1, MPC85xx_eTSEC2,
 			MPC85xx_IIC1, MPC85xx_IIC2,
 			MPC85xx_DMA0, MPC85xx_DMA1, MPC85xx_DMA2, MPC85xx_DMA3,
 			MPC85xx_PERFMON, MPC85xx_DUART,
+			MPC85xx_MDIO,
 		},
 	},
 	{	/* default match */
diff -puN include/asm-ppc/mpc85xx.h~ppc32-85xx-phy-platform-update include/asm-ppc/mpc85xx.h
--- devel/include/asm-ppc/mpc85xx.h~ppc32-85xx-phy-platform-update	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/include/asm-ppc/mpc85xx.h	2005-10-28 17:44:03.000000000 -0700
@@ -67,6 +67,8 @@ extern unsigned char __res[];
 #define MPC85xx_DMA3_SIZE	(0x00080)
 #define MPC85xx_ENET1_OFFSET	(0x24000)
 #define MPC85xx_ENET1_SIZE	(0x01000)
+#define MPC85xx_MIIM_OFFSET	(0x24520)
+#define MPC85xx_MIIM_SIZE	(0x00018)
 #define MPC85xx_ENET2_OFFSET	(0x25000)
 #define MPC85xx_ENET2_SIZE	(0x01000)
 #define MPC85xx_ENET3_OFFSET	(0x26000)
@@ -132,6 +134,7 @@ enum ppc_sys_devices {
 	MPC85xx_eTSEC3,
 	MPC85xx_eTSEC4,
 	MPC85xx_IIC2,
+	MPC85xx_MDIO,
 };
 
 /* Internal interrupts are all Level Sensitive, and Positive Polarity */
diff -puN include/linux/fsl_devices.h~ppc32-85xx-phy-platform-update include/linux/fsl_devices.h
--- devel/include/linux/fsl_devices.h~ppc32-85xx-phy-platform-update	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/include/linux/fsl_devices.h	2005-10-28 17:44:03.000000000 -0700
@@ -47,16 +47,21 @@
 struct gianfar_platform_data {
 	/* device specific information */
 	u32 device_flags;
-	u32 phy_reg_addr;
 
 	/* board specific information */
 	u32 board_flags;
-	u32 phy_flags;
-	u32 phyid;
-	u32 interruptPHY;
+	const char *bus_id;
 	u8 mac_addr[6];
 };
 
+struct gianfar_mdio_data {
+	/* device specific information */
+	u32 paddr;
+
+	/* board specific information */
+	int irq[32];
+};
+
 /* Flags related to gianfar device features */
 #define FSL_GIANFAR_DEV_HAS_GIGABIT		0x00000001
 #define FSL_GIANFAR_DEV_HAS_COALESCE		0x00000002
_
