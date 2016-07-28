Return-Path: <andrew.smirnov@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s0nZP5KStzDrQP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jul 2016 09:07:41 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id ez1so4176900pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 16:07:41 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Scott Wood <oss@buserror.net>,
 Kumar Gala <galak@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alessio Igor Bogani <alessio.bogani@elettra.eu>,
 Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] powerpc: Convert fsl_rstcr_restart to a reset handler
Date: Thu, 28 Jul 2016 16:07:18 -0700
Message-Id: <1469747238-17432-3-git-send-email-andrew.smirnov@gmail.com>
In-Reply-To: <1469747238-17432-1-git-send-email-andrew.smirnov@gmail.com>
References: <1469747238-17432-1-git-send-email-andrew.smirnov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Convert fsl_rstcr_restart into a function to be registered with
register_reset_handler().

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Changes since v1:

	- fsl_rstcr_restart is registered as a reset handler in
          setup_rstcr, replacing per-board arch_initcall approach


 arch/powerpc/platforms/85xx/bsc913x_qds.c     |  1 -
 arch/powerpc/platforms/85xx/bsc913x_rdb.c     |  1 -
 arch/powerpc/platforms/85xx/c293pcie.c        |  1 -
 arch/powerpc/platforms/85xx/corenet_generic.c |  1 -
 arch/powerpc/platforms/85xx/ge_imp3a.c        |  1 -
 arch/powerpc/platforms/85xx/mpc8536_ds.c      |  1 -
 arch/powerpc/platforms/85xx/mpc85xx_ads.c     |  1 -
 arch/powerpc/platforms/85xx/mpc85xx_cds.c     | 25 ++++++++++++++------
 arch/powerpc/platforms/85xx/mpc85xx_ds.c      |  3 ---
 arch/powerpc/platforms/85xx/mpc85xx_mds.c     |  3 ---
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c     | 10 --------
 arch/powerpc/platforms/85xx/mvme2500.c        |  1 -
 arch/powerpc/platforms/85xx/p1010rdb.c        |  1 -
 arch/powerpc/platforms/85xx/p1022_ds.c        |  1 -
 arch/powerpc/platforms/85xx/p1022_rdk.c       |  1 -
 arch/powerpc/platforms/85xx/p1023_rdb.c       |  1 -
 arch/powerpc/platforms/85xx/ppa8548.c         |  1 -
 arch/powerpc/platforms/85xx/qemu_e500.c       |  1 -
 arch/powerpc/platforms/85xx/sbc8548.c         |  1 -
 arch/powerpc/platforms/85xx/socrates.c        |  1 -
 arch/powerpc/platforms/85xx/stx_gp3.c         |  1 -
 arch/powerpc/platforms/85xx/tqm85xx.c         |  1 -
 arch/powerpc/platforms/85xx/twr_p102x.c       |  1 -
 arch/powerpc/platforms/85xx/xes_mpc85xx.c     |  3 ---
 arch/powerpc/platforms/86xx/gef_ppc9a.c       |  1 -
 arch/powerpc/platforms/86xx/gef_sbc310.c      |  1 -
 arch/powerpc/platforms/86xx/gef_sbc610.c      |  1 -
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c    |  1 -
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c    |  1 -
 arch/powerpc/platforms/86xx/sbc8641d.c        |  1 -
 arch/powerpc/sysdev/fsl_soc.c                 | 33 ++++++++++++++++-----------
 arch/powerpc/sysdev/fsl_soc.h                 |  2 --
 32 files changed, 38 insertions(+), 66 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/bsc913x_qds.c b/arch/powerpc/platforms/85xx/bsc913x_qds.c
index 07dd6ae..d2f4556 100644
--- a/arch/powerpc/platforms/85xx/bsc913x_qds.c
+++ b/arch/powerpc/platforms/85xx/bsc913x_qds.c
@@ -72,7 +72,6 @@ define_machine(bsc9132_qds) {
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/bsc913x_rdb.c b/arch/powerpc/platforms/85xx/bsc913x_rdb.c
index e48f671..0ffdb4a 100644
--- a/arch/powerpc/platforms/85xx/bsc913x_rdb.c
+++ b/arch/powerpc/platforms/85xx/bsc913x_rdb.c
@@ -59,7 +59,6 @@ define_machine(bsc9131_rdb) {
 	.setup_arch		= bsc913x_rdb_setup_arch,
 	.init_IRQ		= bsc913x_rdb_pic_init,
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/c293pcie.c b/arch/powerpc/platforms/85xx/c293pcie.c
index 3b9e3f0..4df1b40 100644
--- a/arch/powerpc/platforms/85xx/c293pcie.c
+++ b/arch/powerpc/platforms/85xx/c293pcie.c
@@ -65,7 +65,6 @@ define_machine(c293_pcie) {
 	.setup_arch		= c293_pcie_setup_arch,
 	.init_IRQ		= c293_pcie_pic_init,
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 3a6a84f..1179115 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -225,7 +225,6 @@ define_machine(corenet_generic) {
 #else
 	.get_irq		= mpic_get_coreint_irq,
 #endif
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/platforms/85xx/ge_imp3a.c b/arch/powerpc/platforms/85xx/ge_imp3a.c
index 14af36a..f29c6f0 100644
--- a/arch/powerpc/platforms/85xx/ge_imp3a.c
+++ b/arch/powerpc/platforms/85xx/ge_imp3a.c
@@ -215,7 +215,6 @@ define_machine(ge_imp3a) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/mpc8536_ds.c b/arch/powerpc/platforms/85xx/mpc8536_ds.c
index 6ba687f..94a7f92 100644
--- a/arch/powerpc/platforms/85xx/mpc8536_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc8536_ds.c
@@ -77,7 +77,6 @@ define_machine(mpc8536_ds) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 8756715..f3e055f 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -170,7 +170,6 @@ define_machine(mpc85xx_ads) {
 	.init_IRQ		= mpc85xx_ads_pic_init,
 	.show_cpuinfo		= mpc85xx_ads_show_cpuinfo,
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 62f171c..5a1f413 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -83,7 +83,8 @@ static int mpc85xx_exclude_device(struct pci_controller *hose,
 		return PCIBIOS_SUCCESSFUL;
 }
 
-static void __noreturn mpc85xx_cds_restart(char *cmd)
+static int mpc85xx_cds_restart(struct notifier_block *this,
+			       unsigned long mode, void *cmd)
 {
 	struct pci_dev *dev;
 	u_char tmp;
@@ -108,12 +109,25 @@ static void __noreturn mpc85xx_cds_restart(char *cmd)
 	}
 
 	/*
-	 *  If we can't find the VIA chip (maybe the P2P bridge is disabled)
-	 *  or the VIA chip reset didn't work, just use the default reset.
+	 *  If we can't find the VIA chip (maybe the P2P bridge is
+	 *  disabled) or the VIA chip reset didn't work, just return
+	 *  and let default reset sequence happen.
 	 */
-	fsl_rstcr_restart(NULL);
+	return NOTIFY_DONE;
 }
 
+static int mpc85xx_cds_restart_register(void)
+{
+	static struct notifier_block restart_handler;
+
+	restart_handler.notifier_call = mpc85xx_cds_restart;
+	restart_handler.priority = 192;
+
+	return register_restart_handler(&restart_handler);
+}
+machine_arch_initcall(mpc85xx_cds, mpc85xx_cds_restart_register);
+
+
 static void __init mpc85xx_cds_pci_irq_fixup(struct pci_dev *dev)
 {
 	u_char c;
@@ -380,11 +394,8 @@ define_machine(mpc85xx_cds) {
 	.show_cpuinfo	= mpc85xx_cds_show_cpuinfo,
 	.get_irq	= mpic_get_irq,
 #ifdef CONFIG_PCI
-	.restart	= mpc85xx_cds_restart,
 	.pcibios_fixup_bus	= mpc85xx_cds_fixup_bus,
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
-#else
-	.restart	= fsl_rstcr_restart,
 #endif
 	.calibrate_decr = generic_calibrate_decr,
 	.progress	= udbg_progress,
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 6bc07d8..427ceb0 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -204,7 +204,6 @@ define_machine(mpc8544_ds) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
@@ -219,7 +218,6 @@ define_machine(mpc8572_ds) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
@@ -234,7 +232,6 @@ define_machine(p2020_ds) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index fa9cd71..209f1b2 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -385,7 +385,6 @@ define_machine(mpc8568_mds) {
 	.setup_arch	= mpc85xx_mds_setup_arch,
 	.init_IRQ	= mpc85xx_mds_pic_init,
 	.get_irq	= mpic_get_irq,
-	.restart	= fsl_rstcr_restart,
 	.calibrate_decr	= generic_calibrate_decr,
 	.progress	= udbg_progress,
 #ifdef CONFIG_PCI
@@ -405,7 +404,6 @@ define_machine(mpc8569_mds) {
 	.setup_arch	= mpc85xx_mds_setup_arch,
 	.init_IRQ	= mpc85xx_mds_pic_init,
 	.get_irq	= mpic_get_irq,
-	.restart	= fsl_rstcr_restart,
 	.calibrate_decr	= generic_calibrate_decr,
 	.progress	= udbg_progress,
 #ifdef CONFIG_PCI
@@ -426,7 +424,6 @@ define_machine(p1021_mds) {
 	.setup_arch	= mpc85xx_mds_setup_arch,
 	.init_IRQ	= mpc85xx_mds_pic_init,
 	.get_irq	= mpic_get_irq,
-	.restart	= fsl_rstcr_restart,
 	.calibrate_decr	= generic_calibrate_decr,
 	.progress	= udbg_progress,
 #ifdef CONFIG_PCI
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index c1499cb..1006950 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -213,7 +213,6 @@ define_machine(p2020_rdb) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
@@ -228,7 +227,6 @@ define_machine(p1020_rdb) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
@@ -243,7 +241,6 @@ define_machine(p1021_rdb_pc) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
@@ -258,7 +255,6 @@ define_machine(p2020_rdb_pc) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
@@ -273,7 +269,6 @@ define_machine(p1025_rdb) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
@@ -288,7 +283,6 @@ define_machine(p1020_mbg_pc) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
@@ -303,7 +297,6 @@ define_machine(p1020_utm_pc) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
@@ -318,7 +311,6 @@ define_machine(p1020_rdb_pc) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
@@ -333,7 +325,6 @@ define_machine(p1020_rdb_pd) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
@@ -348,7 +339,6 @@ define_machine(p1024_rdb) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/mvme2500.c b/arch/powerpc/platforms/85xx/mvme2500.c
index acc3d0d..d5af072 100644
--- a/arch/powerpc/platforms/85xx/mvme2500.c
+++ b/arch/powerpc/platforms/85xx/mvme2500.c
@@ -66,7 +66,6 @@ define_machine(mvme2500) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/p1010rdb.c b/arch/powerpc/platforms/85xx/p1010rdb.c
index 661d7b5..78d13b3 100644
--- a/arch/powerpc/platforms/85xx/p1010rdb.c
+++ b/arch/powerpc/platforms/85xx/p1010rdb.c
@@ -79,7 +79,6 @@ define_machine(p1010_rdb) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index 63568d6..0908abd 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -568,7 +568,6 @@ define_machine(p1022_ds) {
 	.pcibios_fixup_phb	= fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/p1022_rdk.c b/arch/powerpc/platforms/85xx/p1022_rdk.c
index 2f29436..276e00a 100644
--- a/arch/powerpc/platforms/85xx/p1022_rdk.c
+++ b/arch/powerpc/platforms/85xx/p1022_rdk.c
@@ -148,7 +148,6 @@ define_machine(p1022_rdk) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/p1023_rdb.c b/arch/powerpc/platforms/85xx/p1023_rdb.c
index 40d8de5..3e8cd032 100644
--- a/arch/powerpc/platforms/85xx/p1023_rdb.c
+++ b/arch/powerpc/platforms/85xx/p1023_rdb.c
@@ -110,7 +110,6 @@ define_machine(p1023_rdb) {
 	.setup_arch		= mpc85xx_rdb_setup_arch,
 	.init_IRQ		= mpc85xx_rdb_pic_init,
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 #ifdef CONFIG_PCI
diff --git a/arch/powerpc/platforms/85xx/ppa8548.c b/arch/powerpc/platforms/85xx/ppa8548.c
index 2410167..33c5ba6 100644
--- a/arch/powerpc/platforms/85xx/ppa8548.c
+++ b/arch/powerpc/platforms/85xx/ppa8548.c
@@ -91,7 +91,6 @@ define_machine(ppa8548) {
 	.init_IRQ	= ppa8548_pic_init,
 	.show_cpuinfo	= ppa8548_show_cpuinfo,
 	.get_irq	= mpic_get_irq,
-	.restart	= fsl_rstcr_restart,
 	.calibrate_decr = generic_calibrate_decr,
 	.progress	= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/qemu_e500.c b/arch/powerpc/platforms/85xx/qemu_e500.c
index 50d7458..b63a854 100644
--- a/arch/powerpc/platforms/85xx/qemu_e500.c
+++ b/arch/powerpc/platforms/85xx/qemu_e500.c
@@ -77,7 +77,6 @@ define_machine(qemu_e500) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_coreint_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/sbc8548.c b/arch/powerpc/platforms/85xx/sbc8548.c
index 62b6c45..2c67084 100644
--- a/arch/powerpc/platforms/85xx/sbc8548.c
+++ b/arch/powerpc/platforms/85xx/sbc8548.c
@@ -130,7 +130,6 @@ define_machine(sbc8548) {
 	.init_IRQ	= sbc8548_pic_init,
 	.show_cpuinfo	= sbc8548_show_cpuinfo,
 	.get_irq	= mpic_get_irq,
-	.restart	= fsl_rstcr_restart,
 #ifdef CONFIG_PCI
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
diff --git a/arch/powerpc/platforms/85xx/socrates.c b/arch/powerpc/platforms/85xx/socrates.c
index cd255ac..8da4ed9 100644
--- a/arch/powerpc/platforms/85xx/socrates.c
+++ b/arch/powerpc/platforms/85xx/socrates.c
@@ -91,7 +91,6 @@ define_machine(socrates) {
 	.setup_arch		= socrates_setup_arch,
 	.init_IRQ		= socrates_pic_init,
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/stx_gp3.c b/arch/powerpc/platforms/85xx/stx_gp3.c
index 91b824c..1a1d44e 100644
--- a/arch/powerpc/platforms/85xx/stx_gp3.c
+++ b/arch/powerpc/platforms/85xx/stx_gp3.c
@@ -103,7 +103,6 @@ define_machine(stx_gp3) {
 	.init_IRQ		= stx_gp3_pic_init,
 	.show_cpuinfo		= stx_gp3_show_cpuinfo,
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/tqm85xx.c b/arch/powerpc/platforms/85xx/tqm85xx.c
index b7c5445..9fc20a3 100644
--- a/arch/powerpc/platforms/85xx/tqm85xx.c
+++ b/arch/powerpc/platforms/85xx/tqm85xx.c
@@ -132,7 +132,6 @@ define_machine(tqm85xx) {
 	.init_IRQ		= tqm85xx_pic_init,
 	.show_cpuinfo		= tqm85xx_show_cpuinfo,
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/twr_p102x.c b/arch/powerpc/platforms/85xx/twr_p102x.c
index 1bc02a8..360f625 100644
--- a/arch/powerpc/platforms/85xx/twr_p102x.c
+++ b/arch/powerpc/platforms/85xx/twr_p102x.c
@@ -140,7 +140,6 @@ define_machine(twr_p1025) {
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/xes_mpc85xx.c b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
index cf0c70f..cd6ce84 100644
--- a/arch/powerpc/platforms/85xx/xes_mpc85xx.c
+++ b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
@@ -167,7 +167,6 @@ define_machine(xes_mpc8572) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
@@ -182,7 +181,6 @@ define_machine(xes_mpc8548) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
@@ -197,7 +195,6 @@ define_machine(xes_mpc8540) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/86xx/gef_ppc9a.c b/arch/powerpc/platforms/86xx/gef_ppc9a.c
index ef684af..6b99300 100644
--- a/arch/powerpc/platforms/86xx/gef_ppc9a.c
+++ b/arch/powerpc/platforms/86xx/gef_ppc9a.c
@@ -204,7 +204,6 @@ define_machine(gef_ppc9a) {
 	.init_IRQ		= gef_ppc9a_init_irq,
 	.show_cpuinfo		= gef_ppc9a_show_cpuinfo,
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.time_init		= mpc86xx_time_init,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
diff --git a/arch/powerpc/platforms/86xx/gef_sbc310.c b/arch/powerpc/platforms/86xx/gef_sbc310.c
index 67dd0c2..8cdeca0 100644
--- a/arch/powerpc/platforms/86xx/gef_sbc310.c
+++ b/arch/powerpc/platforms/86xx/gef_sbc310.c
@@ -191,7 +191,6 @@ define_machine(gef_sbc310) {
 	.init_IRQ		= gef_sbc310_init_irq,
 	.show_cpuinfo		= gef_sbc310_show_cpuinfo,
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.time_init		= mpc86xx_time_init,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
diff --git a/arch/powerpc/platforms/86xx/gef_sbc610.c b/arch/powerpc/platforms/86xx/gef_sbc610.c
index 8050269..da8723a 100644
--- a/arch/powerpc/platforms/86xx/gef_sbc610.c
+++ b/arch/powerpc/platforms/86xx/gef_sbc610.c
@@ -181,7 +181,6 @@ define_machine(gef_sbc610) {
 	.init_IRQ		= gef_sbc610_init_irq,
 	.show_cpuinfo		= gef_sbc610_show_cpuinfo,
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.time_init		= mpc86xx_time_init,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index fef0582..a5d73fa 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -331,7 +331,6 @@ define_machine(mpc86xx_hpcd) {
 	.setup_arch		= mpc86xx_hpcd_setup_arch,
 	.init_IRQ		= mpc86xx_init_irq,
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.time_init		= mpc86xx_time_init,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 5ae42a0..a0e989e 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -130,7 +130,6 @@ define_machine(mpc86xx_hpcn) {
 	.init_IRQ		= mpc86xx_init_irq,
 	.show_cpuinfo		= mpc86xx_hpcn_show_cpuinfo,
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.time_init		= mpc86xx_time_init,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
diff --git a/arch/powerpc/platforms/86xx/sbc8641d.c b/arch/powerpc/platforms/86xx/sbc8641d.c
index 52af573..93db35d 100644
--- a/arch/powerpc/platforms/86xx/sbc8641d.c
+++ b/arch/powerpc/platforms/86xx/sbc8641d.c
@@ -82,7 +82,6 @@ define_machine(sbc8641) {
 	.init_IRQ		= mpc86xx_init_irq,
 	.show_cpuinfo		= sbc8641_show_cpuinfo,
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.time_init		= mpc86xx_time_init,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index a09ca70..d93056e 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -29,6 +29,7 @@
 #include <linux/fsl_devices.h>
 #include <linux/fs_enet_pd.h>
 #include <linux/fs_uart_pd.h>
+#include <linux/reboot.h>
 
 #include <linux/atomic.h>
 #include <asm/io.h>
@@ -180,23 +181,38 @@ EXPORT_SYMBOL(get_baudrate);
 #if defined(CONFIG_FSL_SOC_BOOKE) || defined(CONFIG_PPC_86xx)
 static __be32 __iomem *rstcr;
 
+static int fsl_rstcr_restart(struct notifier_block *this,
+			     unsigned long mode, void *cmd)
+{
+	local_irq_disable();
+	/* set reset control register */
+	out_be32(rstcr, 0x2);	/* HRESET_REQ */
+
+	return NOTIFY_DONE;
+}
+
 static int __init setup_rstcr(void)
 {
 	struct device_node *np;
 
+	static struct notifier_block restart_handler = {
+		.notifier_call = fsl_rstcr_restart,
+		.priority = 128,
+	};
+
 	for_each_node_by_name(np, "global-utilities") {
 		if ((of_get_property(np, "fsl,has-rstcr", NULL))) {
 			rstcr = of_iomap(np, 0) + 0xb0;
-			if (!rstcr)
+			if (!rstcr) {
 				printk (KERN_ERR "Error: reset control "
 						"register not mapped!\n");
+			} else {
+				register_restart_handler(&restart_handler);
+			}
 			break;
 		}
 	}
 
-	if (!rstcr && ppc_md.restart == fsl_rstcr_restart)
-		printk(KERN_ERR "No RSTCR register, warm reboot won't work\n");
-
 	of_node_put(np);
 
 	return 0;
@@ -204,15 +220,6 @@ static int __init setup_rstcr(void)
 
 arch_initcall(setup_rstcr);
 
-void __noreturn fsl_rstcr_restart(char *cmd)
-{
-	local_irq_disable();
-	if (rstcr)
-		/* set reset control register */
-		out_be32(rstcr, 0x2);	/* HRESET_REQ */
-
-	while (1) ;
-}
 #endif
 
 #if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
index 433566a..d73daa4 100644
--- a/arch/powerpc/sysdev/fsl_soc.h
+++ b/arch/powerpc/sysdev/fsl_soc.h
@@ -19,8 +19,6 @@ extern u32 fsl_get_sys_freq(void);
 struct spi_board_info;
 struct device_node;
 
-extern void __noreturn fsl_rstcr_restart(char *cmd);
-
 /* The different ports that the DIU can be connected to */
 enum fsl_diu_monitor_port {
 	FSL_DIU_PORT_DVI,	/* DVI */
-- 
2.5.5
