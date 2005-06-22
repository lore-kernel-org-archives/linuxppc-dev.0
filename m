Return-Path: <galak@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 0E87B67AA0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Jun 2005 06:39:52 +1000 (EST)
Date: Wed, 22 Jun 2005 15:39:45 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0506221539150.3206@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: Check return of ppc_sys_get_pdata before accessing
 pointer
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ensure that the returned pointer from ppc_sys_get_pdata is not
NULL before we start using it.  This handles any cases where we
have variants of processors on the same board with different
functionality.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit b4b0dd5099cb8f08d57bcbf33fd06997ba993618
tree c176601bbe5bf0692fc6a948787319cb2fa74faa
parent 7d09ea22d5823fde9a508f5e04bd8e93712d6f44
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 22 Jun 2005 10:55:33 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 22 Jun 2005 10:55:33 -0500

 arch/ppc/platforms/83xx/mpc834x_sys.c |   28 ++++++++++++---------
 arch/ppc/platforms/85xx/mpc8540_ads.c |   44 +++++++++++++++++++--------------
 arch/ppc/platforms/85xx/mpc8560_ads.c |   28 ++++++++++++---------
 arch/ppc/platforms/85xx/sbc8560.c     |   28 ++++++++++++---------
 arch/ppc/platforms/85xx/stx_gp3.c     |   26 +++++++++++---------
 5 files changed, 88 insertions(+), 66 deletions(-)

diff --git a/arch/ppc/platforms/83xx/mpc834x_sys.c b/arch/ppc/platforms/83xx/mpc834x_sys.c
--- a/arch/ppc/platforms/83xx/mpc834x_sys.c
+++ b/arch/ppc/platforms/83xx/mpc834x_sys.c
@@ -94,20 +94,24 @@ mpc834x_sys_setup_arch(void)
 
 	/* setup the board related information for the enet controllers */
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC83xx_TSEC1);
-	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-	pdata->interruptPHY = MPC83xx_IRQ_EXT1;
-	pdata->phyid = 0;
-	/* fixup phy address */
-	pdata->phy_reg_addr += binfo->bi_immr_base;
-	memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
+	if (pdata) {
+		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
+		pdata->interruptPHY = MPC83xx_IRQ_EXT1;
+		pdata->phyid = 0;
+		/* fixup phy address */
+		pdata->phy_reg_addr += binfo->bi_immr_base;
+		memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
+	}
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC83xx_TSEC2);
-	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-	pdata->interruptPHY = MPC83xx_IRQ_EXT2;
-	pdata->phyid = 1;
-	/* fixup phy address */
-	pdata->phy_reg_addr += binfo->bi_immr_base;
-	memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
+	if (pdata) {
+		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
+		pdata->interruptPHY = MPC83xx_IRQ_EXT2;
+		pdata->phyid = 1;
+		/* fixup phy address */
+		pdata->phy_reg_addr += binfo->bi_immr_base;
+		memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
+	}
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start)
diff --git a/arch/ppc/platforms/85xx/mpc8540_ads.c b/arch/ppc/platforms/85xx/mpc8540_ads.c
--- a/arch/ppc/platforms/85xx/mpc8540_ads.c
+++ b/arch/ppc/platforms/85xx/mpc8540_ads.c
@@ -92,28 +92,34 @@ mpc8540ads_setup_arch(void)
 
 	/* setup the board related information for the enet controllers */
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC1);
-	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-	pdata->interruptPHY = MPC85xx_IRQ_EXT5;
-	pdata->phyid = 0;
-	/* fixup phy address */
-	pdata->phy_reg_addr += binfo->bi_immr_base;
-	memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
+	if (pdata) {
+		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
+		pdata->interruptPHY = MPC85xx_IRQ_EXT5;
+		pdata->phyid = 0;
+		/* fixup phy address */
+		pdata->phy_reg_addr += binfo->bi_immr_base;
+		memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
+	}
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC2);
-	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-	pdata->interruptPHY = MPC85xx_IRQ_EXT5;
-	pdata->phyid = 1;
-	/* fixup phy address */
-	pdata->phy_reg_addr += binfo->bi_immr_base;
-	memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
+	if (pdata) {
+		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
+		pdata->interruptPHY = MPC85xx_IRQ_EXT5;
+		pdata->phyid = 1;
+		/* fixup phy address */
+		pdata->phy_reg_addr += binfo->bi_immr_base;
+		memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
+	}
 
-	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_FEC);
-	pdata->board_flags = 0;
-	pdata->interruptPHY = MPC85xx_IRQ_EXT5;
-	pdata->phyid = 3;
-	/* fixup phy address */
-	pdata->phy_reg_addr += binfo->bi_immr_base;
-	memcpy(pdata->mac_addr, binfo->bi_enet2addr, 6);
+	if (pdata) {
+		pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_FEC);
+		pdata->board_flags = 0;
+		pdata->interruptPHY = MPC85xx_IRQ_EXT5;
+		pdata->phyid = 3;
+		/* fixup phy address */
+		pdata->phy_reg_addr += binfo->bi_immr_base;
+		memcpy(pdata->mac_addr, binfo->bi_enet2addr, 6);
+	}
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start)
diff --git a/arch/ppc/platforms/85xx/mpc8560_ads.c b/arch/ppc/platforms/85xx/mpc8560_ads.c
--- a/arch/ppc/platforms/85xx/mpc8560_ads.c
+++ b/arch/ppc/platforms/85xx/mpc8560_ads.c
@@ -90,20 +90,24 @@ mpc8560ads_setup_arch(void)
 
 	/* setup the board related information for the enet controllers */
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC1);
-	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-	pdata->interruptPHY = MPC85xx_IRQ_EXT5;
-	pdata->phyid = 0;
-	/* fixup phy address */
-	pdata->phy_reg_addr += binfo->bi_immr_base;
-	memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
+	if (pdata) {
+		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
+		pdata->interruptPHY = MPC85xx_IRQ_EXT5;
+		pdata->phyid = 0;
+		/* fixup phy address */
+		pdata->phy_reg_addr += binfo->bi_immr_base;
+		memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
+	}
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC2);
-	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-	pdata->interruptPHY = MPC85xx_IRQ_EXT5;
-	pdata->phyid = 1;
-	/* fixup phy address */
-	pdata->phy_reg_addr += binfo->bi_immr_base;
-	memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
+	if (pdata) {
+		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
+		pdata->interruptPHY = MPC85xx_IRQ_EXT5;
+		pdata->phyid = 1;
+		/* fixup phy address */
+		pdata->phy_reg_addr += binfo->bi_immr_base;
+		memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
+	}
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start)
diff --git a/arch/ppc/platforms/85xx/sbc8560.c b/arch/ppc/platforms/85xx/sbc8560.c
--- a/arch/ppc/platforms/85xx/sbc8560.c
+++ b/arch/ppc/platforms/85xx/sbc8560.c
@@ -129,20 +129,24 @@ sbc8560_setup_arch(void)
 
 	/* setup the board related information for the enet controllers */
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC1);
-	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-	pdata->interruptPHY = MPC85xx_IRQ_EXT6;
-	pdata->phyid = 25;
-	/* fixup phy address */
-	pdata->phy_reg_addr += binfo->bi_immr_base;
-	memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
+	if (pdata) {
+		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
+		pdata->interruptPHY = MPC85xx_IRQ_EXT6;
+		pdata->phyid = 25;
+		/* fixup phy address */
+		pdata->phy_reg_addr += binfo->bi_immr_base;
+		memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
+	}
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC2);
-	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-	pdata->interruptPHY = MPC85xx_IRQ_EXT7;
-	pdata->phyid = 26;
-	/* fixup phy address */
-	pdata->phy_reg_addr += binfo->bi_immr_base;
-	memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
+	if (pdata) {
+		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
+		pdata->interruptPHY = MPC85xx_IRQ_EXT7;
+		pdata->phyid = 26;
+		/* fixup phy address */
+		pdata->phy_reg_addr += binfo->bi_immr_base;
+		memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
+	}
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start)
diff --git a/arch/ppc/platforms/85xx/stx_gp3.c b/arch/ppc/platforms/85xx/stx_gp3.c
--- a/arch/ppc/platforms/85xx/stx_gp3.c
+++ b/arch/ppc/platforms/85xx/stx_gp3.c
@@ -122,19 +122,23 @@ gp3_setup_arch(void)
 
 	/* setup the board related information for the enet controllers */
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC1);
-/*	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR; */
-	pdata->interruptPHY = MPC85xx_IRQ_EXT5;
-	pdata->phyid = 2;
-	pdata->phy_reg_addr += binfo->bi_immr_base;
-	memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
+	if (pdata) {
+	/*	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR; */
+		pdata->interruptPHY = MPC85xx_IRQ_EXT5;
+		pdata->phyid = 2;
+		pdata->phy_reg_addr += binfo->bi_immr_base;
+		memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
+	}
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC85xx_TSEC2);
-/*	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR; */
-	pdata->interruptPHY = MPC85xx_IRQ_EXT5;
-	pdata->phyid = 4;
-	/* fixup phy address */
-	pdata->phy_reg_addr += binfo->bi_immr_base;
-	memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
+	if (pdata) {
+	/*	pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR; */
+		pdata->interruptPHY = MPC85xx_IRQ_EXT5;
+		pdata->phyid = 4;
+		/* fixup phy address */
+		pdata->phy_reg_addr += binfo->bi_immr_base;
+		memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
+	}
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start)
