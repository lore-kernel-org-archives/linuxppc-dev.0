Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 587A868623
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Oct 2005 05:50:58 +1000 (EST)
Date: Thu, 20 Oct 2005 14:50:46 -0500 (CDT)
From: Andy Fleming <afleming@freescale.com>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0510201446420.28712@ld0175-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] 85xx PHY Platform Update
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This patch updates the 85xx platform code to support the new PHY Layer.

Signed-off-by: Andy Fleming <afleming@freescale.com>
Signed-off-by: Kumar Gala <Kumar.gala@freescale.com>


diff --git a/arch/ppc/platforms/85xx/mpc8540_ads.c b/arch/ppc/platforms/85xx/mpc8540_ads.c
--- a/arch/ppc/platforms/85xx/mpc8540_ads.c
+++ b/arch/ppc/platforms/85xx/mpc8540_ads.c
@@ -53,6 +53,10 @@
 
 #include <syslib/ppc85xx_setup.h>
 
+static const char *GFAR_PHY_0 = "phy0:0";
+static const char *GFAR_PHY_1 = "phy0:1";
+static const char *GFAR_PHY_3 = "phy0:3";
+
 /* ************************************************************************
  *
  * Setup the architecture
@@ -64,6 +68,7 @@ mpc8540ads_setup_arch(void)
 	bd_t *binfo = (bd_t *) __res;
 	unsigned int freq;
 	struct gianfar_platform_data *pdata;
+	struct gianfar_mdio_data *mdata;
 
 	/* get the core frequency */
 	freq = binfo->bi_intfreq;
@@ -90,34 +95,35 @@ mpc8540ads_setup_arch(void)
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
 
diff --git a/arch/ppc/platforms/85xx/mpc8560_ads.c b/arch/ppc/platforms/85xx/mpc8560_ads.c
--- a/arch/ppc/platforms/85xx/mpc8560_ads.c
+++ b/arch/ppc/platforms/85xx/mpc8560_ads.c
@@ -57,6 +57,10 @@
 #include <syslib/ppc85xx_setup.h>
 
 
+static const char *GFAR_PHY_0 = "phy0:0";
+static const char *GFAR_PHY_1 = "phy0:1";
+static const char *GFAR_PHY_3 = "phy0:3";
+
 /* ************************************************************************
  *
  * Setup the architecture
@@ -69,6 +73,7 @@ mpc8560ads_setup_arch(void)
 	bd_t *binfo = (bd_t *) __res;
 	unsigned int freq;
 	struct gianfar_platform_data *pdata;
+	struct gianfar_mdio_data *mdata;
 
 	cpm2_reset();
 
@@ -87,24 +92,28 @@ mpc8560ads_setup_arch(void)
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
 
diff --git a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
--- a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
+++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
@@ -395,6 +395,9 @@ mpc85xx_cds_pcibios_fixup(void)
 
 TODC_ALLOC();
 
+static const char *GFAR_PHY_0 = "phy0:0";
+static const char *GFAR_PHY_1 = "phy0:1";
+
 /* ************************************************************************
  *
  * Setup the architecture
@@ -406,6 +409,7 @@ mpc85xx_cds_setup_arch(void)
 	bd_t *binfo = (bd_t *) __res;
 	unsigned int freq;
 	struct gianfar_platform_data *pdata;
+	struct gianfar_mdio_data *mdata;
 
 	/* get the core frequency */
 	freq = binfo->bi_intfreq;
@@ -449,44 +453,42 @@ mpc85xx_cds_setup_arch(void)
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
 
diff --git a/arch/ppc/platforms/85xx/sbc8560.c b/arch/ppc/platforms/85xx/sbc8560.c
--- a/arch/ppc/platforms/85xx/sbc8560.c
+++ b/arch/ppc/platforms/85xx/sbc8560.c
@@ -92,6 +92,9 @@ sbc8560_early_serial_map(void)
 }
 #endif
 
+static const char *GFAR_PHY_25 = "phy0:25";
+static const char *GFAR_PHY_26 = "phy0:26";
+
 /* ************************************************************************
  *
  * Setup the architecture
@@ -103,6 +106,7 @@ sbc8560_setup_arch(void)
 	bd_t *binfo = (bd_t *) __res;
 	unsigned int freq;
 	struct gianfar_platform_data *pdata;
+	struct gianfar_mdio_data *mdata;
 
 	/* get the core frequency */
 	freq = binfo->bi_intfreq;
@@ -127,24 +131,26 @@ sbc8560_setup_arch(void)
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
 
diff --git a/arch/ppc/platforms/85xx/stx_gp3.c b/arch/ppc/platforms/85xx/stx_gp3.c
--- a/arch/ppc/platforms/85xx/stx_gp3.c
+++ b/arch/ppc/platforms/85xx/stx_gp3.c
@@ -92,6 +92,9 @@ static u8 gp3_openpic_initsenses[] __ini
 	0x0,				/* External 11: */
 };
 
+static const char *GFAR_PHY_2 = "phy0:2";
+static const char *GFAR_PHY_4 = "phy0:4";
+
 /*
  * Setup the architecture
  */
@@ -101,6 +104,7 @@ gp3_setup_arch(void)
 	bd_t *binfo = (bd_t *) __res;
 	unsigned int freq;
 	struct gianfar_platform_data *pdata;
+	struct gianfar_mdio_data *mdata;
 
 	cpm2_reset();
 
@@ -119,23 +123,26 @@ gp3_setup_arch(void)
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
 
diff --git a/arch/ppc/syslib/mpc85xx_devices.c b/arch/ppc/syslib/mpc85xx_devices.c
--- a/arch/ppc/syslib/mpc85xx_devices.c
+++ b/arch/ppc/syslib/mpc85xx_devices.c
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
@@ -718,6 +715,12 @@ struct platform_device ppc_sys_platform_
 				.flags	= IORESOURCE_IRQ,
 			},
 		},
+	},
+	[MPC85xx_MDIO] = {
+		.name = "fsl-gianfar_mdio",
+		.id = 0,
+		.dev.platform_data = &mpc85xx_mdio_pdata,
+		.num_resources = 0,
 	},
 };
 
diff --git a/arch/ppc/syslib/mpc85xx_sys.c b/arch/ppc/syslib/mpc85xx_sys.c
--- a/arch/ppc/syslib/mpc85xx_sys.c
+++ b/arch/ppc/syslib/mpc85xx_sys.c
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
diff --git a/include/asm-ppc/mpc85xx.h b/include/asm-ppc/mpc85xx.h
--- a/include/asm-ppc/mpc85xx.h
+++ b/include/asm-ppc/mpc85xx.h
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
diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -47,14 +47,19 @@
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
+};
+
+struct gianfar_mdio_data {
+	/* device specific information */
+	u32 paddr;
+
+	/* board specific information */
+	int irq[32];
 };
 
 /* Flags related to gianfar device features */
