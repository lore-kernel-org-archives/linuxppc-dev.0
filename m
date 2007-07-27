Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C9768DDF52
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jul 2007 04:24:51 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6RIOk8s013278
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 11:24:46 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l6RIOjfL017035
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 13:24:46 -0500 (CDT)
Subject: [PATCH 2/5] 85xx: Remove unnecessary loops_per_jiffy
	initialization code.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1185560685.8055.175.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Fri, 27 Jul 2007 13:24:45 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Jon Loeliger <jdl@freescale.com>
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
index 6a171e9..44f9cdb 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -266,7 +266,6 @@ device_initcall(mpc85xx_cds_8259_attach);
  */
 static void __init mpc85xx_cds_setup_arch(void)
 {
-	struct device_node *cpu;
 #ifdef CONFIG_PCI
 	struct device_node *np;
 #endif
@@ -274,18 +273,6 @@ static void __init mpc85xx_cds_setup_arch(void)
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
index e8003bf..d0e3153 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -73,17 +73,6 @@ static void __init mpc85xx_mds_setup_arch(void)
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
1.5.0.3
