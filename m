Return-Path: <bgill@blarg.am.freescale.net>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7EFBEDDF3D
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 07:53:58 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m8OLrpCB019571
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 14:53:52 -0700 (MST)
Received: from blarg.am.freescale.net (blarg.am.freescale.net [10.82.19.176])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	m8OLroLI023114
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 16:53:51 -0500 (CDT)
From: Becky Bruce <becky.bruce@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] Move memory size print into common show_cpuinfo for 32-bit
Date: Wed, 24 Sep 2008 16:53:50 -0500
Message-Id: <1222293230-22725-1-git-send-email-becky.bruce@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Most of the platforms were printing the size of the memory
in their show_cpuinfo implementations. This moves that to
the common show_cpuinfo, so that all 32-bit platforms will
now print the size of memory.  I also update the code
to deal with the fact that total_memory is now a phys_addr_t.

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
---
 arch/powerpc/kernel/setup-common.c             |    7 +++++++
 arch/powerpc/platforms/85xx/ksi8560.c          |    4 ----
 arch/powerpc/platforms/85xx/mpc85xx_ads.c      |    4 ----
 arch/powerpc/platforms/85xx/mpc85xx_cds.c      |    4 ----
 arch/powerpc/platforms/85xx/sbc8548.c          |    4 ----
 arch/powerpc/platforms/85xx/sbc8560.c          |    4 ----
 arch/powerpc/platforms/85xx/tqm85xx.c          |    4 ----
 arch/powerpc/platforms/86xx/gef_sbc610.c       |    2 --
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c     |    2 --
 arch/powerpc/platforms/86xx/sbc8641d.c         |    2 --
 arch/powerpc/platforms/embedded6xx/c2k.c       |    3 ---
 arch/powerpc/platforms/embedded6xx/prpmc2800.c |    3 ---
 12 files changed, 7 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 5ec56ff..705fc4b 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -59,6 +59,7 @@
 #include <asm/mmu.h>
 #include <asm/xmon.h>
 #include <asm/cputhreads.h>
+#include <mm/mmu_decl.h>
 
 #include "setup.h"
 
@@ -190,6 +191,12 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		if (ppc_md.show_cpuinfo != NULL)
 			ppc_md.show_cpuinfo(m);
 
+#ifdef CONFIG_PPC32
+		/* Display the amount of memory */
+		seq_printf(m, "Memory\t\t: %d MB\n",
+			   (unsigned int)(total_memory / (1024 * 1024)));
+#endif
+
 		return 0;
 	}
 
diff --git a/arch/powerpc/platforms/85xx/ksi8560.c b/arch/powerpc/platforms/85xx/ksi8560.c
index 8a3b117..81cee7b 100644
--- a/arch/powerpc/platforms/85xx/ksi8560.c
+++ b/arch/powerpc/platforms/85xx/ksi8560.c
@@ -193,7 +193,6 @@ static void __init ksi8560_setup_arch(void)
 static void ksi8560_show_cpuinfo(struct seq_file *m)
 {
 	uint pvid, svid, phid1;
-	uint memsize = total_memory;
 
 	pvid = mfspr(SPRN_PVR);
 	svid = mfspr(SPRN_SVR);
@@ -215,9 +214,6 @@ static void ksi8560_show_cpuinfo(struct seq_file *m)
 	/* Display cpu Pll setting */
 	phid1 = mfspr(SPRN_HID1);
 	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
-
-	/* Display the amount of memory */
-	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
 }
 
 static struct of_device_id __initdata of_bus_ids[] = {
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 0293e3d..21f0090 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -207,7 +207,6 @@ static void __init mpc85xx_ads_setup_arch(void)
 static void mpc85xx_ads_show_cpuinfo(struct seq_file *m)
 {
 	uint pvid, svid, phid1;
-	uint memsize = total_memory;
 
 	pvid = mfspr(SPRN_PVR);
 	svid = mfspr(SPRN_SVR);
@@ -219,9 +218,6 @@ static void mpc85xx_ads_show_cpuinfo(struct seq_file *m)
 	/* Display cpu Pll setting */
 	phid1 = mfspr(SPRN_HID1);
 	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
-
-	/* Display the amount of memory */
-	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
 }
 
 static struct of_device_id __initdata of_bus_ids[] = {
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 50d7ea8..aeb6a5b 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -307,7 +307,6 @@ static void __init mpc85xx_cds_setup_arch(void)
 static void mpc85xx_cds_show_cpuinfo(struct seq_file *m)
 {
 	uint pvid, svid, phid1;
-	uint memsize = total_memory;
 
 	pvid = mfspr(SPRN_PVR);
 	svid = mfspr(SPRN_SVR);
@@ -320,9 +319,6 @@ static void mpc85xx_cds_show_cpuinfo(struct seq_file *m)
 	/* Display cpu Pll setting */
 	phid1 = mfspr(SPRN_HID1);
 	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
-
-	/* Display the amount of memory */
-	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
 }
 
 
diff --git a/arch/powerpc/platforms/85xx/sbc8548.c b/arch/powerpc/platforms/85xx/sbc8548.c
index b9246ea..7ec77ce 100644
--- a/arch/powerpc/platforms/85xx/sbc8548.c
+++ b/arch/powerpc/platforms/85xx/sbc8548.c
@@ -136,7 +136,6 @@ static void __init sbc8548_setup_arch(void)
 static void sbc8548_show_cpuinfo(struct seq_file *m)
 {
 	uint pvid, svid, phid1;
-	uint memsize = total_memory;
 
 	pvid = mfspr(SPRN_PVR);
 	svid = mfspr(SPRN_SVR);
@@ -149,9 +148,6 @@ static void sbc8548_show_cpuinfo(struct seq_file *m)
 	/* Display cpu Pll setting */
 	phid1 = mfspr(SPRN_HID1);
 	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
-
-	/* Display the amount of memory */
-	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
 }
 
 static struct of_device_id __initdata of_bus_ids[] = {
diff --git a/arch/powerpc/platforms/85xx/sbc8560.c b/arch/powerpc/platforms/85xx/sbc8560.c
index 0c9a856..472f254 100644
--- a/arch/powerpc/platforms/85xx/sbc8560.c
+++ b/arch/powerpc/platforms/85xx/sbc8560.c
@@ -194,7 +194,6 @@ static void __init sbc8560_setup_arch(void)
 static void sbc8560_show_cpuinfo(struct seq_file *m)
 {
 	uint pvid, svid, phid1;
-	uint memsize = total_memory;
 
 	pvid = mfspr(SPRN_PVR);
 	svid = mfspr(SPRN_SVR);
@@ -206,9 +205,6 @@ static void sbc8560_show_cpuinfo(struct seq_file *m)
 	/* Display cpu Pll setting */
 	phid1 = mfspr(SPRN_HID1);
 	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
-
-	/* Display the amount of memory */
-	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
 }
 
 static struct of_device_id __initdata of_bus_ids[] = {
diff --git a/arch/powerpc/platforms/85xx/tqm85xx.c b/arch/powerpc/platforms/85xx/tqm85xx.c
index d850880..2933a8e 100644
--- a/arch/powerpc/platforms/85xx/tqm85xx.c
+++ b/arch/powerpc/platforms/85xx/tqm85xx.c
@@ -138,7 +138,6 @@ static void __init tqm85xx_setup_arch(void)
 static void tqm85xx_show_cpuinfo(struct seq_file *m)
 {
 	uint pvid, svid, phid1;
-	uint memsize = total_memory;
 
 	pvid = mfspr(SPRN_PVR);
 	svid = mfspr(SPRN_SVR);
@@ -150,9 +149,6 @@ static void tqm85xx_show_cpuinfo(struct seq_file *m)
 	/* Display cpu Pll setting */
 	phid1 = mfspr(SPRN_HID1);
 	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
-
-	/* Display the amount of memory */
-	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
 }
 
 static struct of_device_id __initdata of_bus_ids[] = {
diff --git a/arch/powerpc/platforms/86xx/gef_sbc610.c b/arch/powerpc/platforms/86xx/gef_sbc610.c
index 8a9dee2..1fab786 100644
--- a/arch/powerpc/platforms/86xx/gef_sbc610.c
+++ b/arch/powerpc/platforms/86xx/gef_sbc610.c
@@ -66,13 +66,11 @@ static void __init gef_sbc610_setup_arch(void)
 
 static void gef_sbc610_show_cpuinfo(struct seq_file *m)
 {
-	uint memsize = total_memory;
 	uint svid = mfspr(SPRN_SVR);
 
 	seq_printf(m, "Vendor\t\t: GE Fanuc Intelligent Platforms\n");
 
 	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
-	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
 }
 
 
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 2672829..27e0e68 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -101,13 +101,11 @@ mpc86xx_hpcn_setup_arch(void)
 static void
 mpc86xx_hpcn_show_cpuinfo(struct seq_file *m)
 {
-	uint memsize = total_memory;
 	uint svid = mfspr(SPRN_SVR);
 
 	seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
 
 	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
-	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
 }
 
 
diff --git a/arch/powerpc/platforms/86xx/sbc8641d.c b/arch/powerpc/platforms/86xx/sbc8641d.c
index da677a7..5fd7ed4 100644
--- a/arch/powerpc/platforms/86xx/sbc8641d.c
+++ b/arch/powerpc/platforms/86xx/sbc8641d.c
@@ -63,13 +63,11 @@ sbc8641_setup_arch(void)
 static void
 sbc8641_show_cpuinfo(struct seq_file *m)
 {
-	uint memsize = total_memory;
 	uint svid = mfspr(SPRN_SVR);
 
 	seq_printf(m, "Vendor\t\t: Wind River Systems\n");
 
 	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
-	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
 }
 
 
diff --git a/arch/powerpc/platforms/embedded6xx/c2k.c b/arch/powerpc/platforms/embedded6xx/c2k.c
index d0b25b8..32ba0fa 100644
--- a/arch/powerpc/platforms/embedded6xx/c2k.c
+++ b/arch/powerpc/platforms/embedded6xx/c2k.c
@@ -116,10 +116,7 @@ static void c2k_restart(char *cmd)
 
 void c2k_show_cpuinfo(struct seq_file *m)
 {
-	uint memsize = total_memory;
-
 	seq_printf(m, "Vendor\t\t: GEFanuc\n");
-	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
 	seq_printf(m, "coherency\t: %s\n", COHERENCY_SETTING);
 }
 
diff --git a/arch/powerpc/platforms/embedded6xx/prpmc2800.c b/arch/powerpc/platforms/embedded6xx/prpmc2800.c
index 5a19b9a..4c485e9 100644
--- a/arch/powerpc/platforms/embedded6xx/prpmc2800.c
+++ b/arch/powerpc/platforms/embedded6xx/prpmc2800.c
@@ -119,10 +119,7 @@ static void prpmc2800_restart(char *cmd)
 
 void prpmc2800_show_cpuinfo(struct seq_file *m)
 {
-	uint memsize = total_memory;
-
 	seq_printf(m, "Vendor\t\t: Motorola\n");
-	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
 	seq_printf(m, "coherency\t: %s\n", PPRPM2800_COHERENCY_SETTING);
 }
 
-- 
1.5.5.1
