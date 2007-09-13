Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 48B3ADE01E
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 07:08:26 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 07/22] [POWERPC] 85xx: Remove unnecessary loops_per_jiffy
	initialization code.
Date: Thu, 13 Sep 2007 16:07:45 -0500
Message-Id: <1189717690413-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <11897176884163-git-send-email-galak@kernel.crashing.org>
References: <11897176803590-git-send-email-galak@kernel.crashing.org>
	<1189717681533-git-send-email-galak@kernel.crashing.org>
	<1189717683471-git-send-email-galak@kernel.crashing.org>
	<11897176841013-git-send-email-galak@kernel.crashing.org>
	<11897176851400-git-send-email-galak@kernel.crashing.org>
	<1189717687832-git-send-email-galak@kernel.crashing.org>
	<11897176884163-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jon Loeliger <jdl@freescale.com>

Signed-off-by: Jon Loeliger <jdl@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/mpc85xx_ads.c |   13 -------------
 arch/powerpc/platforms/85xx/mpc85xx_cds.c |   13 -------------
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |   11 -----------
 3 files changed, 0 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 40a8286..c22bc1c 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -192,7 +192,6 @@ void init_fcc_ioports(struct fs_platform_info *fpi)
 
 static void __init mpc85xx_ads_setup_arch(void)
 {
-	struct device_node *cpu;
 #ifdef CONFIG_PCI
 	struct device_node *np;
 #endif
@@ -200,18 +199,6 @@ static void __init mpc85xx_ads_setup_arch(void)
 	if (ppc_md.progress)
 		ppc_md.progress("mpc85xx_ads_setup_arch()", 0);
 
-	cpu = of_find_node_by_type(NULL, "cpu");
-	if (cpu != 0) {
-		const unsigned int *fp;
-
-		fp = of_get_property(cpu, "clock-frequency", NULL);
-		if (fp != 0)
-			loops_per_jiffy = *fp / HZ;
-		else
-			loops_per_jiffy = 50000000 / HZ;
-		of_node_put(cpu);
-	}
-
 #ifdef CONFIG_CPM2
 	cpm2_reset();
 #endif
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index b46c8d5..665e8df 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -265,7 +265,6 @@ device_initcall(mpc85xx_cds_8259_attach);
  */
 static void __init mpc85xx_cds_setup_arch(void)
 {
-	struct device_node *cpu;
 #ifdef CONFIG_PCI
 	struct device_node *np;
 #endif
@@ -273,18 +272,6 @@ static void __init mpc85xx_cds_setup_arch(void)
 	if (ppc_md.progress)
 		ppc_md.progress("mpc85xx_cds_setup_arch()", 0);
 
-	cpu = of_find_node_by_type(NULL, "cpu");
-	if (cpu != 0) {
-		const unsigned int *fp;
-
-		fp = of_get_property(cpu, "clock-frequency", NULL);
-		if (fp != 0)
-			loops_per_jiffy = *fp / HZ;
-		else
-			loops_per_jiffy = 500000000 / HZ;
-		of_node_put(cpu);
-	}
-
 	cadmus = ioremap(CADMUS_BASE, CADMUS_SIZE);
 	cds_pci_slot = ((cadmus[CM_CSR] >> 6) & 0x3) + 1;
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 66366a0..c379286 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -72,17 +72,6 @@ static void __init mpc85xx_mds_setup_arch(void)
 	if (ppc_md.progress)
 		ppc_md.progress("mpc85xx_mds_setup_arch()", 0);
 
-	np = of_find_node_by_type(NULL, "cpu");
-	if (np != NULL) {
-		const unsigned int *fp =
-		    of_get_property(np, "clock-frequency", NULL);
-		if (fp != NULL)
-			loops_per_jiffy = *fp / HZ;
-		else
-			loops_per_jiffy = 50000000 / HZ;
-		of_node_put(np);
-	}
-
 	/* Map BCSR area */
 	np = of_find_node_by_name(NULL, "bcsr");
 	if (np != NULL) {
-- 
1.5.2.4
