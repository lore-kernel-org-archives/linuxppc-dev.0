Return-Path: <andrew.smirnov@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rz4mW2J3kzDqYp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 14:25:31 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id q2so12552231pap.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 21:25:31 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Scott Wood <oss@buserror.net>,
 Kumar Gala <galak@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alessio Igor Bogani <alessio.bogani@elettra.eu>,
 Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] powerpc: Convert fsl_rstcr_restart to a reset handler
Date: Mon, 25 Jul 2016 21:25:14 -0700
Message-Id: <1469507114-5788-3-git-send-email-andrew.smirnov@gmail.com>
In-Reply-To: <1469507114-5788-1-git-send-email-andrew.smirnov@gmail.com>
References: <1469507114-5788-1-git-send-email-andrew.smirnov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Convert fsl_rstcr_restart into a function to be registered with
register_reset_handler() API and introduce fls_rstcr_restart_register()
function that can be added as an initcall that would do aforementioned
registration.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/powerpc/platforms/85xx/bsc913x_qds.c     |  2 +-
 arch/powerpc/platforms/85xx/bsc913x_rdb.c     |  2 +-
 arch/powerpc/platforms/85xx/c293pcie.c        |  2 +-
 arch/powerpc/platforms/85xx/corenet_generic.c |  2 +-
 arch/powerpc/platforms/85xx/ge_imp3a.c        |  2 +-
 arch/powerpc/platforms/85xx/mpc8536_ds.c      |  2 +-
 arch/powerpc/platforms/85xx/mpc85xx_ads.c     |  2 +-
 arch/powerpc/platforms/85xx/mpc85xx_cds.c     | 26 +++++++++++++++++++-------
 arch/powerpc/platforms/85xx/mpc85xx_ds.c      |  7 ++++---
 arch/powerpc/platforms/85xx/mpc85xx_mds.c     |  7 ++++---
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c     | 21 +++++++++++----------
 arch/powerpc/platforms/85xx/mvme2500.c        |  2 +-
 arch/powerpc/platforms/85xx/p1010rdb.c        |  2 +-
 arch/powerpc/platforms/85xx/p1022_ds.c        |  2 +-
 arch/powerpc/platforms/85xx/p1022_rdk.c       |  3 ++-
 arch/powerpc/platforms/85xx/p1023_rdb.c       |  2 +-
 arch/powerpc/platforms/85xx/ppa8548.c         |  2 +-
 arch/powerpc/platforms/85xx/qemu_e500.c       |  2 +-
 arch/powerpc/platforms/85xx/sbc8548.c         |  2 +-
 arch/powerpc/platforms/85xx/socrates.c        |  2 +-
 arch/powerpc/platforms/85xx/stx_gp3.c         |  2 +-
 arch/powerpc/platforms/85xx/tqm85xx.c         |  2 +-
 arch/powerpc/platforms/85xx/twr_p102x.c       |  2 +-
 arch/powerpc/platforms/85xx/xes_mpc85xx.c     |  7 ++++---
 arch/powerpc/platforms/86xx/gef_ppc9a.c       |  2 +-
 arch/powerpc/platforms/86xx/gef_sbc310.c      |  2 +-
 arch/powerpc/platforms/86xx/gef_sbc610.c      |  2 +-
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c    |  2 +-
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c    |  2 +-
 arch/powerpc/platforms/86xx/sbc8641d.c        |  2 +-
 arch/powerpc/sysdev/fsl_soc.c                 | 22 +++++++++++++++++-----
 arch/powerpc/sysdev/fsl_soc.h                 |  2 +-
 32 files changed, 86 insertions(+), 57 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/bsc913x_qds.c b/arch/powerpc/platforms/85xx/bsc913x_qds.c
index 07dd6ae..14ea7a0 100644
--- a/arch/powerpc/platforms/85xx/bsc913x_qds.c
+++ b/arch/powerpc/platforms/85xx/bsc913x_qds.c
@@ -53,6 +53,7 @@ static void __init bsc913x_qds_setup_arch(void)
 }
 
 machine_arch_initcall(bsc9132_qds, mpc85xx_common_publish_devices);
+machine_arch_initcall(bsc9133_qds, fsl_rstcr_restart_register);
 
 /*
  * Called very early, device-tree isn't unflattened
@@ -72,7 +73,6 @@ define_machine(bsc9132_qds) {
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/bsc913x_rdb.c b/arch/powerpc/platforms/85xx/bsc913x_rdb.c
index e48f671..cd4e717 100644
--- a/arch/powerpc/platforms/85xx/bsc913x_rdb.c
+++ b/arch/powerpc/platforms/85xx/bsc913x_rdb.c
@@ -43,6 +43,7 @@ static void __init bsc913x_rdb_setup_arch(void)
 }
 
 machine_device_initcall(bsc9131_rdb, mpc85xx_common_publish_devices);
+machine_arch_initcall(bsc9131_rdb, fsl_rstcr_restart_register);
 
 /*
  * Called very early, device-tree isn't unflattened
@@ -59,7 +60,6 @@ define_machine(bsc9131_rdb) {
 	.setup_arch		= bsc913x_rdb_setup_arch,
 	.init_IRQ		= bsc913x_rdb_pic_init,
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/c293pcie.c b/arch/powerpc/platforms/85xx/c293pcie.c
index 3b9e3f0..fbd63f9 100644
--- a/arch/powerpc/platforms/85xx/c293pcie.c
+++ b/arch/powerpc/platforms/85xx/c293pcie.c
@@ -48,6 +48,7 @@ static void __init c293_pcie_setup_arch(void)
 }
 
 machine_arch_initcall(c293_pcie, mpc85xx_common_publish_devices);
+machine_arch_initcall(c293_pcie, fsl_rstcr_restart_register);
 
 /*
  * Called very early, device-tree isn't unflattened
@@ -65,7 +66,6 @@ define_machine(c293_pcie) {
 	.setup_arch		= c293_pcie_setup_arch,
 	.init_IRQ		= c293_pcie_pic_init,
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 3a6a84f..297379b 100644
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
@@ -236,6 +235,7 @@ define_machine(corenet_generic) {
 };
 
 machine_arch_initcall(corenet_generic, corenet_gen_publish_devices);
+machine_arch_initcall(corenet_generic, fsl_rstcr_restart_register);
 
 #ifdef CONFIG_SWIOTLB
 machine_arch_initcall(corenet_generic, swiotlb_setup_bus_notifier);
diff --git a/arch/powerpc/platforms/85xx/ge_imp3a.c b/arch/powerpc/platforms/85xx/ge_imp3a.c
index 14af36a..c06cda9 100644
--- a/arch/powerpc/platforms/85xx/ge_imp3a.c
+++ b/arch/powerpc/platforms/85xx/ge_imp3a.c
@@ -203,6 +203,7 @@ static int __init ge_imp3a_probe(void)
 machine_arch_initcall(ge_imp3a, mpc85xx_common_publish_devices);
 
 machine_arch_initcall(ge_imp3a, swiotlb_setup_bus_notifier);
+machine_arch_initcall(ge_imp3a, fsl_rstcr_restart_register);
 
 define_machine(ge_imp3a) {
 	.name			= "GE_IMP3A",
@@ -215,7 +216,6 @@ define_machine(ge_imp3a) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/mpc8536_ds.c b/arch/powerpc/platforms/85xx/mpc8536_ds.c
index 6ba687f..3678b9b 100644
--- a/arch/powerpc/platforms/85xx/mpc8536_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc8536_ds.c
@@ -58,6 +58,7 @@ static void __init mpc8536_ds_setup_arch(void)
 machine_arch_initcall(mpc8536_ds, mpc85xx_common_publish_devices);
 
 machine_arch_initcall(mpc8536_ds, swiotlb_setup_bus_notifier);
+machine_arch_initcall(mpc8536_ds, fsl_rstcr_restart_register);
 
 /*
  * Called very early, device-tree isn't unflattened
@@ -77,7 +78,6 @@ define_machine(mpc8536_ds) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 8756715..8dfab98 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -154,6 +154,7 @@ static void mpc85xx_ads_show_cpuinfo(struct seq_file *m)
 }
 
 machine_arch_initcall(mpc85xx_ads, mpc85xx_common_publish_devices);
+machine_arch_initcall(mpc85xx_ads, fsl_rstcr_restart_register);
 
 /*
  * Called very early, device-tree isn't unflattened
@@ -170,7 +171,6 @@ define_machine(mpc85xx_ads) {
 	.init_IRQ		= mpc85xx_ads_pic_init,
 	.show_cpuinfo		= mpc85xx_ads_show_cpuinfo,
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 62f171c..84bcafa 100644
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
@@ -371,6 +385,7 @@ static int __init mpc85xx_cds_probe(void)
 }
 
 machine_arch_initcall(mpc85xx_cds, mpc85xx_common_publish_devices);
+machine_arch_initcall(mpc85xx_cds, fsl_rstcr_restart_register);
 
 define_machine(mpc85xx_cds) {
 	.name		= "MPC85xx CDS",
@@ -380,11 +395,8 @@ define_machine(mpc85xx_cds) {
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
index 6bc07d8..da8037e 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -178,6 +178,10 @@ machine_arch_initcall(mpc8544_ds, swiotlb_setup_bus_notifier);
 machine_arch_initcall(mpc8572_ds, swiotlb_setup_bus_notifier);
 machine_arch_initcall(p2020_ds, swiotlb_setup_bus_notifier);
 
+machine_arch_initcall(mpc8544_ds, fsl_rstcr_restart_register);
+machine_arch_initcall(mpc8572_ds, fsl_rstcr_restart_register);
+machine_arch_initcall(p2020_ds, fsl_rstcr_restart_register);
+
 /*
  * Called very early, device-tree isn't unflattened
  */
@@ -204,7 +208,6 @@ define_machine(mpc8544_ds) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
@@ -219,7 +222,6 @@ define_machine(mpc8572_ds) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
@@ -234,7 +236,6 @@ define_machine(p2020_ds) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index fa9cd71..dbcb467 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -363,6 +363,10 @@ machine_arch_initcall(mpc8568_mds, swiotlb_setup_bus_notifier);
 machine_arch_initcall(mpc8569_mds, swiotlb_setup_bus_notifier);
 machine_arch_initcall(p1021_mds, swiotlb_setup_bus_notifier);
 
+machine_arch_initcall(mpc8568_mds, fsl_rstcr_restart_register);
+machine_arch_initcall(mpc8569_mds, fsl_rstcr_restart_register);
+machine_arch_initcall(p1021_mds, fsl_rstcr_restart_register);
+
 static void __init mpc85xx_mds_pic_init(void)
 {
 	struct mpic *mpic = mpic_alloc(NULL, 0, MPIC_BIG_ENDIAN |
@@ -385,7 +389,6 @@ define_machine(mpc8568_mds) {
 	.setup_arch	= mpc85xx_mds_setup_arch,
 	.init_IRQ	= mpc85xx_mds_pic_init,
 	.get_irq	= mpic_get_irq,
-	.restart	= fsl_rstcr_restart,
 	.calibrate_decr	= generic_calibrate_decr,
 	.progress	= udbg_progress,
 #ifdef CONFIG_PCI
@@ -405,7 +408,6 @@ define_machine(mpc8569_mds) {
 	.setup_arch	= mpc85xx_mds_setup_arch,
 	.init_IRQ	= mpc85xx_mds_pic_init,
 	.get_irq	= mpic_get_irq,
-	.restart	= fsl_rstcr_restart,
 	.calibrate_decr	= generic_calibrate_decr,
 	.progress	= udbg_progress,
 #ifdef CONFIG_PCI
@@ -426,7 +428,6 @@ define_machine(p1021_mds) {
 	.setup_arch	= mpc85xx_mds_setup_arch,
 	.init_IRQ	= mpc85xx_mds_pic_init,
 	.get_irq	= mpic_get_irq,
-	.restart	= fsl_rstcr_restart,
 	.calibrate_decr	= generic_calibrate_decr,
 	.progress	= udbg_progress,
 #ifdef CONFIG_PCI
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index c1499cb..12ec044 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -142,6 +142,17 @@ machine_arch_initcall(p1021_rdb_pc, mpc85xx_common_publish_devices);
 machine_arch_initcall(p1025_rdb, mpc85xx_common_publish_devices);
 machine_arch_initcall(p1024_rdb, mpc85xx_common_publish_devices);
 
+machine_arch_initcall(p2020_rdb, fsl_rstcr_restart_register);
+machine_arch_initcall(p2020_rdb_pc, fsl_rstcr_restart_register);
+machine_arch_initcall(p1020_mbg_pc, fsl_rstcr_restart_register);
+machine_arch_initcall(p1020_rdb, fsl_rstcr_restart_register);
+machine_arch_initcall(p1020_rdb_pc, fsl_rstcr_restart_register);
+machine_arch_initcall(p1020_rdb_pd, fsl_rstcr_restart_register);
+machine_arch_initcall(p1020_utm_pc, fsl_rstcr_restart_register);
+machine_arch_initcall(p1021_rdb_pc, fsl_rstcr_restart_register);
+machine_arch_initcall(p1025_rdb, fsl_rstcr_restart_register);
+machine_arch_initcall(p1024_rdb, fsl_rstcr_restart_register);
+
 /*
  * Called very early, device-tree isn't unflattened
  */
@@ -213,7 +224,6 @@ define_machine(p2020_rdb) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
@@ -228,7 +238,6 @@ define_machine(p1020_rdb) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
@@ -243,7 +252,6 @@ define_machine(p1021_rdb_pc) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
@@ -258,7 +266,6 @@ define_machine(p2020_rdb_pc) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
@@ -273,7 +280,6 @@ define_machine(p1025_rdb) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
@@ -288,7 +294,6 @@ define_machine(p1020_mbg_pc) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
@@ -303,7 +308,6 @@ define_machine(p1020_utm_pc) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
@@ -318,7 +322,6 @@ define_machine(p1020_rdb_pc) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
@@ -333,7 +336,6 @@ define_machine(p1020_rdb_pd) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
@@ -348,7 +350,6 @@ define_machine(p1024_rdb) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/mvme2500.c b/arch/powerpc/platforms/85xx/mvme2500.c
index acc3d0d..dc826eb 100644
--- a/arch/powerpc/platforms/85xx/mvme2500.c
+++ b/arch/powerpc/platforms/85xx/mvme2500.c
@@ -47,6 +47,7 @@ static void __init mvme2500_setup_arch(void)
 }
 
 machine_arch_initcall(mvme2500, mpc85xx_common_publish_devices);
+machine_arch_initcall(mvme2500, fsl_rstcr_restart_register);
 
 /*
  * Called very early, device-tree isn't unflattened
@@ -66,7 +67,6 @@ define_machine(mvme2500) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/p1010rdb.c b/arch/powerpc/platforms/85xx/p1010rdb.c
index 661d7b5..b836a23 100644
--- a/arch/powerpc/platforms/85xx/p1010rdb.c
+++ b/arch/powerpc/platforms/85xx/p1010rdb.c
@@ -56,6 +56,7 @@ static void __init p1010_rdb_setup_arch(void)
 
 machine_arch_initcall(p1010_rdb, mpc85xx_common_publish_devices);
 machine_arch_initcall(p1010_rdb, swiotlb_setup_bus_notifier);
+machine_arch_initcall(p1010_rdb, fsl_rstcr_restart_register);
 
 /*
  * Called very early, device-tree isn't unflattened
@@ -79,7 +80,6 @@ define_machine(p1010_rdb) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index 63568d6..52c97ee 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -549,6 +549,7 @@ static void __init p1022_ds_setup_arch(void)
 machine_arch_initcall(p1022_ds, mpc85xx_common_publish_devices);
 
 machine_arch_initcall(p1022_ds, swiotlb_setup_bus_notifier);
+machine_arch_initcall(p1022_ds, fsl_rstcr_restart_register);
 
 /*
  * Called very early, device-tree isn't unflattened
@@ -568,7 +569,6 @@ define_machine(p1022_ds) {
 	.pcibios_fixup_phb	= fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/p1022_rdk.c b/arch/powerpc/platforms/85xx/p1022_rdk.c
index 2f29436..9dc99dc 100644
--- a/arch/powerpc/platforms/85xx/p1022_rdk.c
+++ b/arch/powerpc/platforms/85xx/p1022_rdk.c
@@ -130,6 +130,8 @@ machine_arch_initcall(p1022_rdk, mpc85xx_common_publish_devices);
 
 machine_arch_initcall(p1022_rdk, swiotlb_setup_bus_notifier);
 
+machine_arch_initcall(p1022_rdk, fsl_rstcr_restart_register);
+
 /*
  * Called very early, device-tree isn't unflattened
  */
@@ -148,7 +150,6 @@ define_machine(p1022_rdk) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/p1023_rdb.c b/arch/powerpc/platforms/85xx/p1023_rdb.c
index 40d8de5..81e07d4 100644
--- a/arch/powerpc/platforms/85xx/p1023_rdb.c
+++ b/arch/powerpc/platforms/85xx/p1023_rdb.c
@@ -86,6 +86,7 @@ static void __init mpc85xx_rdb_setup_arch(void)
 }
 
 machine_arch_initcall(p1023_rdb, mpc85xx_common_publish_devices);
+machine_arch_initcall(p1023_rdb, fsl_rstcr_restart_register);
 
 static void __init mpc85xx_rdb_pic_init(void)
 {
@@ -110,7 +111,6 @@ define_machine(p1023_rdb) {
 	.setup_arch		= mpc85xx_rdb_setup_arch,
 	.init_IRQ		= mpc85xx_rdb_pic_init,
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 #ifdef CONFIG_PCI
diff --git a/arch/powerpc/platforms/85xx/ppa8548.c b/arch/powerpc/platforms/85xx/ppa8548.c
index 2410167..ab843b1 100644
--- a/arch/powerpc/platforms/85xx/ppa8548.c
+++ b/arch/powerpc/platforms/85xx/ppa8548.c
@@ -75,6 +75,7 @@ static int __init declare_of_platform_devices(void)
 	return 0;
 }
 machine_device_initcall(ppa8548, declare_of_platform_devices);
+machine_arch_initcall(ppa8548, fsl_rstcr_restart_register);
 
 /*
  * Called very early, device-tree isn't unflattened
@@ -91,7 +92,6 @@ define_machine(ppa8548) {
 	.init_IRQ	= ppa8548_pic_init,
 	.show_cpuinfo	= ppa8548_show_cpuinfo,
 	.get_irq	= mpic_get_irq,
-	.restart	= fsl_rstcr_restart,
 	.calibrate_decr = generic_calibrate_decr,
 	.progress	= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/qemu_e500.c b/arch/powerpc/platforms/85xx/qemu_e500.c
index 50d7458..e76566c 100644
--- a/arch/powerpc/platforms/85xx/qemu_e500.c
+++ b/arch/powerpc/platforms/85xx/qemu_e500.c
@@ -66,6 +66,7 @@ static int __init qemu_e500_probe(void)
 }
 
 machine_arch_initcall(qemu_e500, mpc85xx_common_publish_devices);
+machine_arch_initcall(qemu_e500, fsl_rstcr_restart_register);
 
 define_machine(qemu_e500) {
 	.name			= "QEMU e500",
@@ -77,7 +78,6 @@ define_machine(qemu_e500) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_coreint_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/sbc8548.c b/arch/powerpc/platforms/85xx/sbc8548.c
index 62b6c45..dfe0dd8 100644
--- a/arch/powerpc/platforms/85xx/sbc8548.c
+++ b/arch/powerpc/platforms/85xx/sbc8548.c
@@ -114,6 +114,7 @@ static void sbc8548_show_cpuinfo(struct seq_file *m)
 }
 
 machine_arch_initcall(sbc8548, mpc85xx_common_publish_devices);
+machine_arch_initcall(sbc8548, fsl_rstcr_restart_register);
 
 /*
  * Called very early, device-tree isn't unflattened
@@ -130,7 +131,6 @@ define_machine(sbc8548) {
 	.init_IRQ	= sbc8548_pic_init,
 	.show_cpuinfo	= sbc8548_show_cpuinfo,
 	.get_irq	= mpic_get_irq,
-	.restart	= fsl_rstcr_restart,
 #ifdef CONFIG_PCI
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
diff --git a/arch/powerpc/platforms/85xx/socrates.c b/arch/powerpc/platforms/85xx/socrates.c
index cd255ac..aa29cf7 100644
--- a/arch/powerpc/platforms/85xx/socrates.c
+++ b/arch/powerpc/platforms/85xx/socrates.c
@@ -73,6 +73,7 @@ static void __init socrates_setup_arch(void)
 }
 
 machine_arch_initcall(socrates, mpc85xx_common_publish_devices);
+machine_arch_initcall(socrates, fsl_rstcr_restart_register);
 
 /*
  * Called very early, device-tree isn't unflattened
@@ -91,7 +92,6 @@ define_machine(socrates) {
 	.setup_arch		= socrates_setup_arch,
 	.init_IRQ		= socrates_pic_init,
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/stx_gp3.c b/arch/powerpc/platforms/85xx/stx_gp3.c
index 91b824c..880797a 100644
--- a/arch/powerpc/platforms/85xx/stx_gp3.c
+++ b/arch/powerpc/platforms/85xx/stx_gp3.c
@@ -87,6 +87,7 @@ static void stx_gp3_show_cpuinfo(struct seq_file *m)
 }
 
 machine_arch_initcall(stx_gp3, mpc85xx_common_publish_devices);
+machine_arch_initcall(stx_gp3, fsl_rstcr_restart_register);
 
 /*
  * Called very early, device-tree isn't unflattened
@@ -103,7 +104,6 @@ define_machine(stx_gp3) {
 	.init_IRQ		= stx_gp3_pic_init,
 	.show_cpuinfo		= stx_gp3_show_cpuinfo,
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/tqm85xx.c b/arch/powerpc/platforms/85xx/tqm85xx.c
index b7c5445..a4de7be 100644
--- a/arch/powerpc/platforms/85xx/tqm85xx.c
+++ b/arch/powerpc/platforms/85xx/tqm85xx.c
@@ -107,6 +107,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_1520,
 		tqm85xx_ti1520_fixup);
 
 machine_arch_initcall(tqm85xx, mpc85xx_common_publish_devices);
+machine_arch_initcall(tqm85xx, fsl_rstcr_restart_register);
 
 static const char * const board[] __initconst = {
 	"tqc,tqm8540",
@@ -132,7 +133,6 @@ define_machine(tqm85xx) {
 	.init_IRQ		= tqm85xx_pic_init,
 	.show_cpuinfo		= tqm85xx_show_cpuinfo,
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/twr_p102x.c b/arch/powerpc/platforms/85xx/twr_p102x.c
index 1bc02a8..ee80dab 100644
--- a/arch/powerpc/platforms/85xx/twr_p102x.c
+++ b/arch/powerpc/platforms/85xx/twr_p102x.c
@@ -125,6 +125,7 @@ static void __init twr_p1025_setup_arch(void)
 }
 
 machine_arch_initcall(twr_p1025, mpc85xx_common_publish_devices);
+machine_arch_initcall(twr_p1025, fsl_rstcr_restart_register);
 
 static int __init twr_p1025_probe(void)
 {
@@ -140,7 +141,6 @@ define_machine(twr_p1025) {
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/xes_mpc85xx.c b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
index cf0c70f..b504a7a 100644
--- a/arch/powerpc/platforms/85xx/xes_mpc85xx.c
+++ b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
@@ -139,6 +139,10 @@ machine_arch_initcall(xes_mpc8572, mpc85xx_common_publish_devices);
 machine_arch_initcall(xes_mpc8548, mpc85xx_common_publish_devices);
 machine_arch_initcall(xes_mpc8540, mpc85xx_common_publish_devices);
 
+machine_arch_initcall(xes_mpc8572, fsl_rstcr_restart_register);
+machine_arch_initcall(xes_mpc8548, fsl_rstcr_restart_register);
+machine_arch_initcall(xes_mpc8540, fsl_rstcr_restart_register);
+
 /*
  * Called very early, device-tree isn't unflattened
  */
@@ -167,7 +171,6 @@ define_machine(xes_mpc8572) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
@@ -182,7 +185,6 @@ define_machine(xes_mpc8548) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
@@ -197,7 +199,6 @@ define_machine(xes_mpc8540) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/86xx/gef_ppc9a.c b/arch/powerpc/platforms/86xx/gef_ppc9a.c
index ef684af..3571b4c 100644
--- a/arch/powerpc/platforms/86xx/gef_ppc9a.c
+++ b/arch/powerpc/platforms/86xx/gef_ppc9a.c
@@ -196,6 +196,7 @@ static int __init gef_ppc9a_probe(void)
 }
 
 machine_arch_initcall(gef_ppc9a, mpc86xx_common_publish_devices);
+machine_arch_initcall(gef_ppc9a, fsl_rstcr_restart_register);
 
 define_machine(gef_ppc9a) {
 	.name			= "GE PPC9A",
@@ -204,7 +205,6 @@ define_machine(gef_ppc9a) {
 	.init_IRQ		= gef_ppc9a_init_irq,
 	.show_cpuinfo		= gef_ppc9a_show_cpuinfo,
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.time_init		= mpc86xx_time_init,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
diff --git a/arch/powerpc/platforms/86xx/gef_sbc310.c b/arch/powerpc/platforms/86xx/gef_sbc310.c
index 67dd0c2..54f1521 100644
--- a/arch/powerpc/platforms/86xx/gef_sbc310.c
+++ b/arch/powerpc/platforms/86xx/gef_sbc310.c
@@ -183,6 +183,7 @@ static int __init gef_sbc310_probe(void)
 }
 
 machine_arch_initcall(gef_sbc310, mpc86xx_common_publish_devices);
+machine_arch_initcall(gef_sbc310, fsl_rstcr_restart_register);
 
 define_machine(gef_sbc310) {
 	.name			= "GE SBC310",
@@ -191,7 +192,6 @@ define_machine(gef_sbc310) {
 	.init_IRQ		= gef_sbc310_init_irq,
 	.show_cpuinfo		= gef_sbc310_show_cpuinfo,
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.time_init		= mpc86xx_time_init,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
diff --git a/arch/powerpc/platforms/86xx/gef_sbc610.c b/arch/powerpc/platforms/86xx/gef_sbc610.c
index 8050269..f5b25a5 100644
--- a/arch/powerpc/platforms/86xx/gef_sbc610.c
+++ b/arch/powerpc/platforms/86xx/gef_sbc610.c
@@ -173,6 +173,7 @@ static int __init gef_sbc610_probe(void)
 }
 
 machine_arch_initcall(gef_sbc610, mpc86xx_common_publish_devices);
+machine_arch_initcall(gef_sbc610, fsl_rstcr_restart_register);
 
 define_machine(gef_sbc610) {
 	.name			= "GE SBC610",
@@ -181,7 +182,6 @@ define_machine(gef_sbc610) {
 	.init_IRQ		= gef_sbc610_init_irq,
 	.show_cpuinfo		= gef_sbc610_show_cpuinfo,
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.time_init		= mpc86xx_time_init,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index fef0582..7f21a9d 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -111,6 +111,7 @@ static int __init mpc8610_declare_of_platform_devices(void)
 	return 0;
 }
 machine_arch_initcall(mpc86xx_hpcd, mpc8610_declare_of_platform_devices);
+machine_arch_initcall(mpc86xx_hpcd, fsl_rstcr_restart_register);
 
 #if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
 
@@ -331,7 +332,6 @@ define_machine(mpc86xx_hpcd) {
 	.setup_arch		= mpc86xx_hpcd_setup_arch,
 	.init_IRQ		= mpc86xx_init_irq,
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.time_init		= mpc86xx_time_init,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 5ae42a0..fd7258c 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -122,6 +122,7 @@ static int __init declare_of_platform_devices(void)
 }
 machine_arch_initcall(mpc86xx_hpcn, declare_of_platform_devices);
 machine_arch_initcall(mpc86xx_hpcn, swiotlb_setup_bus_notifier);
+machine_arch_initcall(mpc86xx_hpcn, fsl_rstcr_restart_register);
 
 define_machine(mpc86xx_hpcn) {
 	.name			= "MPC86xx HPCN",
@@ -130,7 +131,6 @@ define_machine(mpc86xx_hpcn) {
 	.init_IRQ		= mpc86xx_init_irq,
 	.show_cpuinfo		= mpc86xx_hpcn_show_cpuinfo,
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.time_init		= mpc86xx_time_init,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
diff --git a/arch/powerpc/platforms/86xx/sbc8641d.c b/arch/powerpc/platforms/86xx/sbc8641d.c
index 52af573..4a547b1 100644
--- a/arch/powerpc/platforms/86xx/sbc8641d.c
+++ b/arch/powerpc/platforms/86xx/sbc8641d.c
@@ -74,6 +74,7 @@ static int __init sbc8641_probe(void)
 }
 
 machine_arch_initcall(sbc8641, mpc86xx_common_publish_devices);
+machine_arch_initcall(sbc8641, fsl_rstcr_restart_register);
 
 define_machine(sbc8641) {
 	.name			= "SBC8641D",
@@ -82,7 +83,6 @@ define_machine(sbc8641) {
 	.init_IRQ		= mpc86xx_init_irq,
 	.show_cpuinfo		= sbc8641_show_cpuinfo,
 	.get_irq		= mpic_get_irq,
-	.restart		= fsl_rstcr_restart,
 	.time_init		= mpc86xx_time_init,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index a09ca70..0ba125f 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -29,6 +29,7 @@
 #include <linux/fsl_devices.h>
 #include <linux/fs_enet_pd.h>
 #include <linux/fs_uart_pd.h>
+#include <linux/reboot.h>
 
 #include <linux/atomic.h>
 #include <asm/io.h>
@@ -194,9 +195,6 @@ static int __init setup_rstcr(void)
 		}
 	}
 
-	if (!rstcr && ppc_md.restart == fsl_rstcr_restart)
-		printk(KERN_ERR "No RSTCR register, warm reboot won't work\n");
-
 	of_node_put(np);
 
 	return 0;
@@ -204,15 +202,29 @@ static int __init setup_rstcr(void)
 
 arch_initcall(setup_rstcr);
 
-void __noreturn fsl_rstcr_restart(char *cmd)
+static int fsl_rstcr_restart(struct notifier_block *this,
+			     unsigned long mode, void *cmd)
 {
 	local_irq_disable();
 	if (rstcr)
 		/* set reset control register */
 		out_be32(rstcr, 0x2);	/* HRESET_REQ */
 
-	while (1) ;
+	return NOTIFY_DONE;
 }
+
+int fsl_rstcr_restart_register(void)
+{
+	static struct notifier_block restart_handler;
+
+	restart_handler.notifier_call = fsl_rstcr_restart;
+	restart_handler.priority = 128;
+
+	return register_restart_handler(&restart_handler);
+}
+EXPORT_SYMBOL(fsl_rstcr_restart_register);
+
+
 #endif
 
 #if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
index 433566a..e6c4246 100644
--- a/arch/powerpc/sysdev/fsl_soc.h
+++ b/arch/powerpc/sysdev/fsl_soc.h
@@ -19,7 +19,7 @@ extern u32 fsl_get_sys_freq(void);
 struct spi_board_info;
 struct device_node;
 
-extern void __noreturn fsl_rstcr_restart(char *cmd);
+extern int fsl_rstcr_restart_register(void);
 
 /* The different ports that the DIU can be connected to */
 enum fsl_diu_monitor_port {
-- 
2.5.5
