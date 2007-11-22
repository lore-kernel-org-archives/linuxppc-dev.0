Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id 539BDDDF98
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Nov 2007 02:46:09 +1100 (EST)
Date: Thu, 22 Nov 2007 08:46:07 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 03/10] powerpc: Add kexec support for PPC_85xx platforms
Message-ID: <20071122154607.GA26447@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071122154159.GA24711@xyzzy.farnsworth.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Book E processors need some extra setup in relocate_new_kernel,
because the MMU can't be turned off.  Add the code to create
the required one-to-one memory map.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
---
 arch/powerpc/Kconfig                      |    2 +-
 arch/powerpc/kernel/misc_32.S             |   69 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/mpc85xx_ads.c |    6 +++
 arch/powerpc/platforms/85xx/mpc85xx_cds.c |    6 +++
 arch/powerpc/platforms/85xx/mpc85xx_ds.c  |    6 +++
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    6 +++
 6 files changed, 94 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 191cc2c..9e9581a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -236,7 +236,7 @@ config ARCH_ENABLE_MEMORY_HOTPLUG
 
 config KEXEC
 	bool "kexec system call (EXPERIMENTAL)"
-	depends on PPC_MULTIPLATFORM && EXPERIMENTAL
+	depends on (PPC_MULTIPLATFORM || PPC_85xx) && EXPERIMENTAL
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 8b642ab..db0e749 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -816,6 +816,75 @@ relocate_new_kernel:
 	/* r4 = reboot_code_buffer */
 	/* r5 = start_address      */
 
+#ifdef CONFIG_E500
+	/*
+	 * Since we can't turn off the MMU, we must create an identity
+	 * map for kernel low memory.  We start by invalidating the
+	 * TLB entries we don't need.
+	 *
+	 * First, invalidate the TLB0 entries
+	 */
+	li	r6, 0x04
+	tlbivax	0, r6
+#ifdef CONFIG_SMP
+	tlbsync
+#endif
+	msync
+
+	/*
+	 * Kernel low memory is mapped by TLB1 entries 0, 1, and 2.
+	 * Preserve these, but invalidate all other TLB1 entries.
+	 */
+	li	r7, 3			/* first TLB1 entry */
+	mfspr	r6, SPRN_TLB1CFG
+	andi.	r6, r6, 0xfff
+	mr	r8, r6
+	subf	r6, r7, r6
+	mtctr	r6
+1:
+	rlwinm	r6, r7, 16, 12, 15
+	oris	r6, r6, 0x1000
+	mtspr	SPRN_MAS0, r6
+	tlbre
+	mfspr	r6, SPRN_MAS1
+	rlwinm	r6, r6, 0, 2, 31	/* Clear MAS1 Valid and IPROT */
+	mtspr	SPRN_MAS1, r6
+	tlbwe
+	isync
+	addi	r7, r7, 1
+	bdnz	1b
+
+	/*
+	 * Using TLB1 entries 3, 4, and 5, identity-map kernel low
+	 * memory by copying and modifying the contents of TLB1
+	 * entries 0, 1 and 2, respectively.
+	 */
+	li	r7, 0			/* source TLB entry */
+	li	r8, 3			/* destination TLB entry */
+	li	r6, 3			/* number of TLBs to copy */
+	mtctr	r6
+1:
+	rlwinm	r6, r7, 16, 12, 15
+	oris	r6, r6, 0x1000
+	mtspr	SPRN_MAS0, r6
+	tlbre
+
+	mfspr	r6, SPRN_MAS2
+	lis	r0, PAGE_OFFSET@h
+	subf	r6, r0, r6		/* identity map */
+	mtspr	SPRN_MAS2, r6
+
+	rlwinm	r6, r8, 16, 12, 15
+	oris	r6, r6, 0x1000
+	mtspr	SPRN_MAS0, r6
+	tlbwe
+	sync
+	isync
+	addi	r7, r7, 1
+	addi	r8, r8, 1
+	bdnz	1b
+#endif	/* CONFIG_E500 */
+
 	li	r0, 0
 
 	/*
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index bccdc25..1ade3dd 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/seq_file.h>
 #include <linux/of_platform.h>
+#include <linux/kexec.h>
 
 #include <asm/system.h>
 #include <asm/time.h>
@@ -259,6 +260,11 @@ define_machine(mpc85xx_ads) {
 	.show_cpuinfo		= mpc85xx_ads_show_cpuinfo,
 	.get_irq		= mpic_get_irq,
 	.restart		= fsl_rstcr_restart,
+#ifdef CONFIG_KEXEC
+	.machine_kexec_prepare = default_machine_kexec_prepare,
+	.machine_kexec = default_machine_kexec,
+	.machine_crash_shutdown	= default_machine_crash_shutdown,
+#endif
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 4d063ee..b8a5ed2 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/fsl_devices.h>
+#include <linux/kexec.h>
 
 #include <asm/system.h>
 #include <asm/pgtable.h>
@@ -352,6 +353,11 @@ define_machine(mpc85xx_cds) {
 #else
 	.restart	= fsl_rstcr_restart,
 #endif
+#ifdef CONFIG_KEXEC
+	.machine_kexec_prepare = default_machine_kexec_prepare,
+	.machine_kexec = default_machine_kexec,
+	.machine_crash_shutdown	= default_machine_crash_shutdown,
+#endif
 	.calibrate_decr = generic_calibrate_decr,
 	.progress	= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 59c121a..4c106b6 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/seq_file.h>
 #include <linux/interrupt.h>
+#include <linux/kexec.h>
 
 #include <asm/system.h>
 #include <asm/time.h>
@@ -224,6 +225,11 @@ define_machine(mpc8572_ds) {
 #endif
 	.get_irq		= mpic_get_irq,
 	.restart		= fsl_rstcr_restart,
+#ifdef CONFIG_KEXEC
+	.machine_kexec_prepare = default_machine_kexec_prepare,
+	.machine_kexec = default_machine_kexec,
+	.machine_crash_shutdown	= default_machine_crash_shutdown,
+#endif
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 61b3eed..49f55c1 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -30,6 +30,7 @@
 #include <linux/initrd.h>
 #include <linux/module.h>
 #include <linux/fsl_devices.h>
+#include <linux/kexec.h>
 
 #include <asm/of_device.h>
 #include <asm/of_platform.h>
@@ -202,6 +203,11 @@ define_machine(mpc85xx_mds) {
 	.init_IRQ	= mpc85xx_mds_pic_init,
 	.get_irq	= mpic_get_irq,
 	.restart	= fsl_rstcr_restart,
+#ifdef CONFIG_KEXEC
+	.machine_kexec_prepare = default_machine_kexec_prepare,
+	.machine_kexec = default_machine_kexec,
+	.machine_crash_shutdown	= default_machine_crash_shutdown,
+#endif
 	.calibrate_decr	= generic_calibrate_decr,
 	.progress	= udbg_progress,
 #ifdef CONFIG_PCI
-- 
1.5.3.4
