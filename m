Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
	[213.199.154.141])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E100BB6F7F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jun 2011 09:10:40 +1000 (EST)
Date: Wed, 22 Jun 2011 18:10:30 -0500
From: Scott Wood <scottwood@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/e500mc: Add support for the wait instruction in
	e500_idle
Message-ID: <20110622231030.GA17242@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

e500mc cannot doze or nap due to an erratum (as well as having a
different mechanism than previous e500), but it has a "wait" instruction
that is similar to doze.

On 64-bit, due to the soft-irq-disable mechanism, the existing
book3e_idle should be used instead.

Signed-off-by: Vakul Garg <vakul@freescale.com>
Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/idle_e500.S        |   12 ++++++++++++
 arch/powerpc/platforms/85xx/p3041_ds.c |    1 +
 arch/powerpc/platforms/85xx/p4080_ds.c |    1 +
 arch/powerpc/platforms/85xx/p5020_ds.c |    5 +++++
 4 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/idle_e500.S b/arch/powerpc/kernel/idle_e500.S
index 47a1a98..3e2b95c 100644
--- a/arch/powerpc/kernel/idle_e500.S
+++ b/arch/powerpc/kernel/idle_e500.S
@@ -26,6 +26,17 @@ _GLOBAL(e500_idle)
 	ori	r4,r4,_TLF_NAPPING	/* so when we take an exception */
 	stw	r4,TI_LOCAL_FLAGS(r3)	/* it will return to our caller */
 
+#ifdef CONFIG_E500MC
+	wrteei	1
+1:	wait
+
+	/*
+	 * Guard against spurious wakeups (e.g. from a hypervisor) --
+	 * any real interrupt will cause us to return to LR due to
+	 * _TLF_NAPPING.
+	 */
+	b	1b
+#else
 	/* Check if we can nap or doze, put HID0 mask in r3 */
 	lis	r3,0
 BEGIN_FTR_SECTION
@@ -72,6 +83,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_L2CSR|CPU_FTR_CAN_NAP)
 	mtmsr	r7
 	isync
 2:	b	2b
+#endif /* !E500MC */
 
 /*
  * Return from NAP/DOZE mode, restore some CPU specific registers,
diff --git a/arch/powerpc/platforms/85xx/p3041_ds.c b/arch/powerpc/platforms/85xx/p3041_ds.c
index 0ed52e1..3611330 100644
--- a/arch/powerpc/platforms/85xx/p3041_ds.c
+++ b/arch/powerpc/platforms/85xx/p3041_ds.c
@@ -55,6 +55,7 @@ define_machine(p3041_ds) {
 	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
+	.power_save		= e500_idle,
 };
 
 machine_device_initcall(p3041_ds, corenet_ds_publish_devices);
diff --git a/arch/powerpc/platforms/85xx/p4080_ds.c b/arch/powerpc/platforms/85xx/p4080_ds.c
index 8417046..98c7e6a 100644
--- a/arch/powerpc/platforms/85xx/p4080_ds.c
+++ b/arch/powerpc/platforms/85xx/p4080_ds.c
@@ -68,6 +68,7 @@ define_machine(p4080_ds) {
 	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
+	.power_save		= e500_idle,
 };
 
 machine_device_initcall(p4080_ds, corenet_ds_publish_devices);
diff --git a/arch/powerpc/platforms/85xx/p5020_ds.c b/arch/powerpc/platforms/85xx/p5020_ds.c
index 7467b71..aa2e494 100644
--- a/arch/powerpc/platforms/85xx/p5020_ds.c
+++ b/arch/powerpc/platforms/85xx/p5020_ds.c
@@ -60,6 +60,11 @@ define_machine(p5020_ds) {
 	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
+#ifdef CONFIG_PPC64
+	.power_save		= book3e_idle,
+#else
+	.power_save		= e500_idle,
+#endif
 };
 
 machine_device_initcall(p5020_ds, corenet_ds_publish_devices);
-- 
1.7.4.1
