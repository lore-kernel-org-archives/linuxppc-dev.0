Return-Path: <bgill@blarg.am.freescale.net>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 66698DDE22
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 07:53:41 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m8OLraei019440
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 14:53:36 -0700 (MST)
Received: from blarg.am.freescale.net (blarg.am.freescale.net [10.82.19.176])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	m8OLrZel023046
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 16:53:35 -0500 (CDT)
From: Becky Bruce <becky.bruce@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] Drop redundant machine type print in show_cpuinfo
Date: Wed, 24 Sep 2008 16:53:34 -0500
Message-Id: <1222293214-22698-1-git-send-email-becky.bruce@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For many of the embedded boards, "model" and "Machine" are printing
the same thing; remove the redundant code and allow the generic
show_cpuinfo to print the model information.

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_ads.c         |    1 -
 arch/powerpc/platforms/85xx/sbc8560.c             |    1 -
 arch/powerpc/platforms/86xx/gef_sbc610.c          |    8 --------
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c        |    8 --------
 arch/powerpc/platforms/86xx/sbc8641d.c            |    8 --------
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |    1 -
 6 files changed, 0 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index d17807a..0293e3d 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -213,7 +213,6 @@ static void mpc85xx_ads_show_cpuinfo(struct seq_file *m)
 	svid = mfspr(SPRN_SVR);
 
 	seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
-	seq_printf(m, "Machine\t\t: mpc85xx\n");
 	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
 	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
 
diff --git a/arch/powerpc/platforms/85xx/sbc8560.c b/arch/powerpc/platforms/85xx/sbc8560.c
index e0cf060..0c9a856 100644
--- a/arch/powerpc/platforms/85xx/sbc8560.c
+++ b/arch/powerpc/platforms/85xx/sbc8560.c
@@ -200,7 +200,6 @@ static void sbc8560_show_cpuinfo(struct seq_file *m)
 	svid = mfspr(SPRN_SVR);
 
 	seq_printf(m, "Vendor\t\t: Wind River\n");
-	seq_printf(m, "Machine\t\t: SBC8560\n");
 	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
 	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
 
diff --git a/arch/powerpc/platforms/86xx/gef_sbc610.c b/arch/powerpc/platforms/86xx/gef_sbc610.c
index 3543a9e..8a9dee2 100644
--- a/arch/powerpc/platforms/86xx/gef_sbc610.c
+++ b/arch/powerpc/platforms/86xx/gef_sbc610.c
@@ -66,19 +66,11 @@ static void __init gef_sbc610_setup_arch(void)
 
 static void gef_sbc610_show_cpuinfo(struct seq_file *m)
 {
-	struct device_node *root;
 	uint memsize = total_memory;
-	const char *model = "";
 	uint svid = mfspr(SPRN_SVR);
 
 	seq_printf(m, "Vendor\t\t: GE Fanuc Intelligent Platforms\n");
 
-	root = of_find_node_by_path("/");
-	if (root)
-		model = of_get_property(root, "model", NULL);
-	seq_printf(m, "Machine\t\t: %s\n", model);
-	of_node_put(root);
-
 	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
 	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
 }
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index f712d9c..2672829 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -101,19 +101,11 @@ mpc86xx_hpcn_setup_arch(void)
 static void
 mpc86xx_hpcn_show_cpuinfo(struct seq_file *m)
 {
-	struct device_node *root;
 	uint memsize = total_memory;
-	const char *model = "";
 	uint svid = mfspr(SPRN_SVR);
 
 	seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
 
-	root = of_find_node_by_path("/");
-	if (root)
-		model = of_get_property(root, "model", NULL);
-	seq_printf(m, "Machine\t\t: %s\n", model);
-	of_node_put(root);
-
 	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
 	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
 }
diff --git a/arch/powerpc/platforms/86xx/sbc8641d.c b/arch/powerpc/platforms/86xx/sbc8641d.c
index 00e6fad..da677a7 100644
--- a/arch/powerpc/platforms/86xx/sbc8641d.c
+++ b/arch/powerpc/platforms/86xx/sbc8641d.c
@@ -63,19 +63,11 @@ sbc8641_setup_arch(void)
 static void
 sbc8641_show_cpuinfo(struct seq_file *m)
 {
-	struct device_node *root;
 	uint memsize = total_memory;
-	const char *model = "";
 	uint svid = mfspr(SPRN_SVR);
 
 	seq_printf(m, "Vendor\t\t: Wind River Systems\n");
 
-	root = of_find_node_by_path("/");
-	if (root)
-		model = of_get_property(root, "model", NULL);
-	seq_printf(m, "Machine\t\t: %s\n", model);
-	of_node_put(root);
-
 	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
 	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
 }
diff --git a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
index 84e2d78..7a2ba39 100644
--- a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -164,7 +164,6 @@ static void __init mpc7448_hpc2_init_IRQ(void)
 void mpc7448_hpc2_show_cpuinfo(struct seq_file *m)
 {
 	seq_printf(m, "vendor\t\t: Freescale Semiconductor\n");
-	seq_printf(m, "machine\t\t: MPC7448hpc2\n");
 }
 
 void mpc7448_hpc2_restart(char *cmd)
-- 
1.5.5.1
