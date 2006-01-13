Return-Path: <galak@gate.crashing.org>
Date: Thu, 12 Jan 2006 21:04:23 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: Updated platforms that use gianfar to match driver
Message-ID: <Pine.LNX.4.44.0601122103470.6008-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The gianfar driver changed how it required MDIO bus and phy id's
to be pasted to it. Also, it no longer passes the physical address
of the MDIO bus.  Instead we have a proper platform device.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 66c0ddd1284ef56bfeb41374b51edfd0c8a980a8
tree 9e1b4052a8930d4c6607eebeb37b8102b1972466
parent 7b621e6ea21564548a09abbf1c2944b41ce55185
author Kumar Gala <galak@kernel.crashing.org> Thu, 12 Jan 2006 21:09:35 -0600
committer Kumar Gala <galak@kernel.crashing.org> Thu, 12 Jan 2006 21:09:35 -0600

 arch/ppc/platforms/83xx/mpc834x_sys.c        |   10 ++++------
 arch/ppc/platforms/85xx/mpc8540_ads.c        |   14 ++++++--------
 arch/ppc/platforms/85xx/mpc8560_ads.c        |   11 ++++-------
 arch/ppc/platforms/85xx/mpc85xx_cds_common.c |   16 ++++++++--------
 arch/ppc/platforms/85xx/sbc8560.c            |   10 ++++------
 arch/ppc/platforms/85xx/stx_gp3.c            |   10 ++++------
 arch/ppc/platforms/85xx/tqm85xx.c            |   16 ++++++----------
 arch/ppc/syslib/mpc83xx_devices.c            |   10 ++++++++--
 arch/ppc/syslib/mpc85xx_devices.c            |   10 ++++++++--
 9 files changed, 52 insertions(+), 55 deletions(-)

diff --git a/arch/ppc/platforms/83xx/mpc834x_sys.c b/arch/ppc/platforms/83xx/mpc834x_sys.c
index 04bdc39..012e1e6 100644
--- a/arch/ppc/platforms/83xx/mpc834x_sys.c
+++ b/arch/ppc/platforms/83xx/mpc834x_sys.c
@@ -51,9 +51,6 @@
 
 #include <syslib/ppc83xx_setup.h>
 
-static const char *GFAR_PHY_0 = "phy0:0";
-static const char *GFAR_PHY_1 = "phy0:1";
-
 #ifndef CONFIG_PCI
 unsigned long isa_io_base = 0;
 unsigned long isa_mem_base = 0;
@@ -129,20 +126,21 @@ mpc834x_sys_setup_arch(void)
 	mdata->irq[1] = MPC83xx_IRQ_EXT2;
 	mdata->irq[2] = -1;
 	mdata->irq[31] = -1;
-	mdata->paddr += binfo->bi_immr_base;
 
 	/* setup the board related information for the enet controllers */
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC83xx_TSEC1);
 	if (pdata) {
 		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-		pdata->bus_id = GFAR_PHY_0;
+		pdata->bus_id = 0;
+		pdata->phy_id = 0;
 		memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
 	}
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC83xx_TSEC2);
 	if (pdata) {
 		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-		pdata->bus_id = GFAR_PHY_1;
+		pdata->bus_id = 0;
+		pdata->phy_id = 1;
 		memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
 	}
 
diff --git a/arch/ppc/platforms/85xx/mpc8540_ads.c b/arch/ppc/platforms/85xx/mpc8540_ads.c
index c5cde97..2eceb1e 100644
--- a/arch/ppc/platforms/85xx/mpc8540_ads.c
+++ b/arch/ppc/platforms/85xx/mpc8540_ads.c
@@ -52,10 +52,6 @@
 
 #include <syslib/ppc85xx_setup.h>
 
-static const char *GFAR_PHY_0 = "phy0:0";
-static const char *GFAR_PHY_1 = "phy0:1";
-static const char *GFAR_PHY_3 = "phy0:3";
-
 /* ************************************************************************
  *
  * Setup the architecture
@@ -102,27 +98,29 @@ mpc8540ads_setup_arch(void)
 	mdata->irq[2] = -1;
 	mdata->irq[3] = MPC85xx_IRQ_EXT5;
 	mdata->irq[31] = -1;
-	mdata->paddr += binfo->bi_immr_base;
 
 	/* setup the board related information for the enet controllers */
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC1);
 	if (pdata) {
 		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-		pdata->bus_id = GFAR_PHY_0;
+		pdata->bus_id = 0;
+		pdata->phy_id = 0;
 		memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
 	}
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC2);
 	if (pdata) {
 		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-		pdata->bus_id = GFAR_PHY_1;
+		pdata->bus_id = 0;
+		pdata->phy_id = 1;
 		memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
 	}
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_FEC);
 	if (pdata) {
 		pdata->board_flags = 0;
-		pdata->bus_id = GFAR_PHY_3;
+		pdata->bus_id = 0;
+		pdata->phy_id = 3;
 		memcpy(pdata->mac_addr, binfo->bi_enet2addr, 6);
 	}
 
diff --git a/arch/ppc/platforms/85xx/mpc8560_ads.c b/arch/ppc/platforms/85xx/mpc8560_ads.c
index 8e39a55..442c7ff 100644
--- a/arch/ppc/platforms/85xx/mpc8560_ads.c
+++ b/arch/ppc/platforms/85xx/mpc8560_ads.c
@@ -56,10 +56,6 @@
 #include <syslib/ppc85xx_setup.h>
 
 
-static const char *GFAR_PHY_0 = "phy0:0";
-static const char *GFAR_PHY_1 = "phy0:1";
-static const char *GFAR_PHY_3 = "phy0:3";
-
 /* ************************************************************************
  *
  * Setup the architecture
@@ -99,20 +95,21 @@ mpc8560ads_setup_arch(void)
 	mdata->irq[2] = -1;
 	mdata->irq[3] = MPC85xx_IRQ_EXT5;
 	mdata->irq[31] = -1;
-	mdata->paddr += binfo->bi_immr_base;
 
 	/* setup the board related information for the enet controllers */
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC1);
 	if (pdata) {
 		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-		pdata->bus_id = GFAR_PHY_0;
+		pdata->bus_id = 0;
+		pdata->phy_id = 0;
 		memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
 	}
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC2);
 	if (pdata) {
 		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-		pdata->bus_id = GFAR_PHY_1;
+		pdata->bus_id = 0;
+		pdata->phy_id = 1;
 		memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
 	}
 
diff --git a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
index 2959e3c..b332eba 100644
--- a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
+++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
@@ -395,9 +395,6 @@ mpc85xx_cds_pcibios_fixup(void)
 
 TODC_ALLOC();
 
-static const char *GFAR_PHY_0 = "phy0:0";
-static const char *GFAR_PHY_1 = "phy0:1";
-
 /* ************************************************************************
  *
  * Setup the architecture
@@ -461,34 +458,37 @@ mpc85xx_cds_setup_arch(void)
 	mdata->irq[2] = -1;
 	mdata->irq[3] = -1;
 	mdata->irq[31] = -1;
-	mdata->paddr += binfo->bi_immr_base;
 
 	/* setup the board related information for the enet controllers */
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC1);
 	if (pdata) {
 		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-		pdata->bus_id = GFAR_PHY_0;
+		pdata->bus_id = 0;
+		pdata->phy_id = 0;
 		memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
 	}
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC2);
 	if (pdata) {
 		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-		pdata->bus_id = GFAR_PHY_1;
+		pdata->bus_id = 0;
+		pdata->phy_id = 1;
 		memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
 	}
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_eTSEC1);
 	if (pdata) {
 		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-		pdata->bus_id = GFAR_PHY_0;
+		pdata->bus_id = 0;
+		pdata->phy_id = 0;
 		memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
 	}
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_eTSEC2);
 	if (pdata) {
 		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-		pdata->bus_id = GFAR_PHY_1;
+		pdata->bus_id = 0;
+		pdata->phy_id = 1;
 		memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
 	}
 
diff --git a/arch/ppc/platforms/85xx/sbc8560.c b/arch/ppc/platforms/85xx/sbc8560.c
index 45a5b81..e777ba8 100644
--- a/arch/ppc/platforms/85xx/sbc8560.c
+++ b/arch/ppc/platforms/85xx/sbc8560.c
@@ -91,9 +91,6 @@ sbc8560_early_serial_map(void)
 }
 #endif
 
-static const char *GFAR_PHY_25 = "phy0:25";
-static const char *GFAR_PHY_26 = "phy0:26";
-
 /* ************************************************************************
  *
  * Setup the architecture
@@ -136,20 +133,21 @@ sbc8560_setup_arch(void)
 	mdata->irq[25] = MPC85xx_IRQ_EXT6;
 	mdata->irq[26] = MPC85xx_IRQ_EXT7;
 	mdata->irq[31] = -1;
-	mdata->paddr += binfo->bi_immr_base;
 
 	/* setup the board related information for the enet controllers */
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC1);
 	if (pdata) {
 		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-		pdata->bus_id = GFAR_PHY_25;
+		pdata->bus_id = 0;
+		pdata->phy_id = 25;
 		memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
 	}
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC2);
 	if (pdata) {
 		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-		pdata->bus_id = GFAR_PHY_26;
+		pdata->bus_id = 0;
+		pdata->phy_id = 26;
 		memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
 	}
 
diff --git a/arch/ppc/platforms/85xx/stx_gp3.c b/arch/ppc/platforms/85xx/stx_gp3.c
index 15ce9d0..061bb7c 100644
--- a/arch/ppc/platforms/85xx/stx_gp3.c
+++ b/arch/ppc/platforms/85xx/stx_gp3.c
@@ -93,9 +93,6 @@ static u8 gp3_openpic_initsenses[] __ini
 	0x0,				/* External 11: */
 };
 
-static const char *GFAR_PHY_2 = "phy0:2";
-static const char *GFAR_PHY_4 = "phy0:4";
-
 /*
  * Setup the architecture
  */
@@ -130,20 +127,21 @@ gp3_setup_arch(void)
 	mdata->irq[2] = MPC85xx_IRQ_EXT5;
 	mdata->irq[4] = MPC85xx_IRQ_EXT5;
 	mdata->irq[31] = -1;
-	mdata->paddr += binfo->bi_immr_base;
 
 	/* setup the board related information for the enet controllers */
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC1);
 	if (pdata) {
 	/*	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR; */
-		pdata->bus_id = GFAR_PHY_2;
+		pdata->bus_id = 0;
+		pdata->phy_id = 2;
 		memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
 	}
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC2);
 	if (pdata) {
 	/*	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR; */
-		pdata->bus_id = GFAR_PHY_4;
+		pdata->bus_id = 0;
+		pdata->phy_id = 4;
 		memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
 	}
 
diff --git a/arch/ppc/platforms/85xx/tqm85xx.c b/arch/ppc/platforms/85xx/tqm85xx.c
index c6dfd8f..b436f4d 100644
--- a/arch/ppc/platforms/85xx/tqm85xx.c
+++ b/arch/ppc/platforms/85xx/tqm85xx.c
@@ -91,12 +91,6 @@ static u_char tqm85xx_openpic_initsenses
 	0x0,				/* External 11: */
 };
 
-static const char *GFAR_PHY_0 = "phy0:2";
-static const char *GFAR_PHY_1 = "phy0:1";
-#ifdef CONFIG_MPC8540
-static const char *GFAR_PHY_3 = "phy0:3";
-#endif
-
 /* ************************************************************************
  *
  * Setup the architecture
@@ -149,20 +143,21 @@ tqm85xx_setup_arch(void)
 	mdata->irq[2] = -1;
 	mdata->irq[3] = MPC85xx_IRQ_EXT8;
 	mdata->irq[31] = -1;
-	mdata->paddr += binfo->bi_immr_base;
 
 	/* setup the board related information for the enet controllers */
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC1);
 	if (pdata) {
 		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-		pdata->bus_id = GFAR_PHY_0;
+		pdata->bus_id = 0;
+		pdata->phy_id = 2;
 		memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
 	}
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC2);
 	if (pdata) {
 		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-		pdata->bus_id = GFAR_PHY_1;
+		pdata->bus_id = 0;
+		pdata->phy_id = 1;
 		memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
 	}
 
@@ -170,7 +165,8 @@ tqm85xx_setup_arch(void)
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_FEC);
 	if (pdata) {
 		pdata->board_flags = 0;
-		pdata->bus_id = GFAR_PHY_3;
+		pdata->bus_id = 0;
+		pdata->phy_id = 3;
 		memcpy(pdata->mac_addr, binfo->bi_enet2addr, 6);
 	}
 #endif
diff --git a/arch/ppc/syslib/mpc83xx_devices.c b/arch/ppc/syslib/mpc83xx_devices.c
index 847df44..f9b95de 100644
--- a/arch/ppc/syslib/mpc83xx_devices.c
+++ b/arch/ppc/syslib/mpc83xx_devices.c
@@ -28,7 +28,6 @@
  */
 
 struct gianfar_mdio_data mpc83xx_mdio_pdata = {
-	.paddr = 0x24520,
 };
 
 static struct gianfar_platform_data mpc83xx_tsec1_pdata = {
@@ -226,7 +225,14 @@ struct platform_device ppc_sys_platform_
 		.name = "fsl-gianfar_mdio",
 		.id = 0,
 		.dev.platform_data = &mpc83xx_mdio_pdata,
-		.num_resources = 0,
+		.num_resources = 1,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x24520,
+				.end	= 0x2453f,
+				.flags	= IORESOURCE_MEM,
+			},
+		},
 	},
 };
 
diff --git a/arch/ppc/syslib/mpc85xx_devices.c b/arch/ppc/syslib/mpc85xx_devices.c
index 69949d2..00e9b6f 100644
--- a/arch/ppc/syslib/mpc85xx_devices.c
+++ b/arch/ppc/syslib/mpc85xx_devices.c
@@ -26,7 +26,6 @@
  * what CCSRBAR is, will get fixed up by mach_mpc85xx_fixup
  */
 struct gianfar_mdio_data mpc85xx_mdio_pdata = {
-	.paddr = MPC85xx_MIIM_OFFSET,
 };
 
 static struct gianfar_platform_data mpc85xx_tsec1_pdata = {
@@ -720,7 +719,14 @@ struct platform_device ppc_sys_platform_
 		.name = "fsl-gianfar_mdio",
 		.id = 0,
 		.dev.platform_data = &mpc85xx_mdio_pdata,
-		.num_resources = 0,
+		.num_resources = 1,
+		.resource = (struct resource[]) {
+			{
+				.start	= 0x24520,
+				.end	= 0x2453f,
+				.flags	= IORESOURCE_MEM,
+			},
+		},
 	},
 };
 
