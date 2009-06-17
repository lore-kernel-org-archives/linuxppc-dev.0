Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3BD99B71A6
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 12:43:28 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 17 Jun 2009 12:42:50 +1000
Subject: [PATCH 2/3] powerpc: Use one common impl. of RTAS timebase sync and
	use raw spinlock
Message-Id: <20090617024328.2D466DDDA0@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Several platforms use their own copy of what is essentially the same code,
using RTAS to synchronize the timebases when bringing up new CPUs. This
moves it all into a single common implementation and additionally
turns the spinlock into a raw spinlock since the former can rely on
the timebase not being frozen when spinlock debugging is enabled, and finally
masks interrupts while the timebase is disabled.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/rtas.h      |    3 +++
 arch/powerpc/kernel/rtas.c           |   31 +++++++++++++++++++++++++++++++
 arch/powerpc/platforms/cell/smp.c    |   30 ++----------------------------
 arch/powerpc/platforms/chrp/smp.c    |   30 ++----------------------------
 arch/powerpc/platforms/pseries/smp.c |   30 ++----------------------------
 5 files changed, 40 insertions(+), 84 deletions(-)

--- linux-work.orig/arch/powerpc/platforms/cell/smp.c	2009-06-17 11:56:31.000000000 +1000
+++ linux-work/arch/powerpc/platforms/cell/smp.c	2009-06-17 11:56:42.000000000 +1000
@@ -36,7 +36,6 @@
 #include <asm/prom.h>
 #include <asm/smp.h>
 #include <asm/paca.h>
-#include <asm/time.h>
 #include <asm/machdep.h>
 #include <asm/cputable.h>
 #include <asm/firmware.h>
@@ -140,31 +139,6 @@ static void __devinit smp_cell_setup_cpu
 	mtspr(SPRN_DABRX, DABRX_KERNEL | DABRX_USER);
 }
 
-static DEFINE_SPINLOCK(timebase_lock);
-static unsigned long timebase = 0;
-
-static void __devinit cell_give_timebase(void)
-{
-	spin_lock(&timebase_lock);
-	rtas_call(rtas_token("freeze-time-base"), 0, 1, NULL);
-	timebase = get_tb();
-	spin_unlock(&timebase_lock);
-
-	while (timebase)
-		barrier();
-	rtas_call(rtas_token("thaw-time-base"), 0, 1, NULL);
-}
-
-static void __devinit cell_take_timebase(void)
-{
-	while (!timebase)
-		barrier();
-	spin_lock(&timebase_lock);
-	set_tb(timebase >> 32, timebase & 0xffffffff);
-	timebase = 0;
-	spin_unlock(&timebase_lock);
-}
-
 static void __devinit smp_cell_kick_cpu(int nr)
 {
 	BUG_ON(nr < 0 || nr >= NR_CPUS);
@@ -224,8 +198,8 @@ void __init smp_init_cell(void)
 
 	/* Non-lpar has additional take/give timebase */
 	if (rtas_token("freeze-time-base") != RTAS_UNKNOWN_SERVICE) {
-		smp_ops->give_timebase = cell_give_timebase;
-		smp_ops->take_timebase = cell_take_timebase;
+		smp_ops->give_timebase = rtas_give_timebase;
+		smp_ops->take_timebase = rtas_take_timebase;
 	}
 
 	DBG(" <- smp_init_cell()\n");
Index: linux-work/arch/powerpc/platforms/chrp/smp.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/chrp/smp.c	2009-06-17 11:56:31.000000000 +1000
+++ linux-work/arch/powerpc/platforms/chrp/smp.c	2009-06-17 11:56:42.000000000 +1000
@@ -26,7 +26,6 @@
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/smp.h>
-#include <asm/time.h>
 #include <asm/machdep.h>
 #include <asm/mpic.h>
 #include <asm/rtas.h>
@@ -45,37 +44,12 @@ static void __devinit smp_chrp_setup_cpu
 static DEFINE_SPINLOCK(timebase_lock);
 static unsigned int timebase_upper = 0, timebase_lower = 0;
 
-void __devinit smp_chrp_give_timebase(void)
-{
-	spin_lock(&timebase_lock);
-	rtas_call(rtas_token("freeze-time-base"), 0, 1, NULL);
-	timebase_upper = get_tbu();
-	timebase_lower = get_tbl();
-	spin_unlock(&timebase_lock);
-
-	while (timebase_upper || timebase_lower)
-		barrier();
-	rtas_call(rtas_token("thaw-time-base"), 0, 1, NULL);
-}
-
-void __devinit smp_chrp_take_timebase(void)
-{
-	while (!(timebase_upper || timebase_lower))
-		barrier();
-	spin_lock(&timebase_lock);
-	set_tb(timebase_upper, timebase_lower);
-	timebase_upper = 0;
-	timebase_lower = 0;
-	spin_unlock(&timebase_lock);
-	printk("CPU %i taken timebase\n", smp_processor_id());
-}
-
 /* CHRP with openpic */
 struct smp_ops_t chrp_smp_ops = {
 	.message_pass = smp_mpic_message_pass,
 	.probe = smp_mpic_probe,
 	.kick_cpu = smp_chrp_kick_cpu,
 	.setup_cpu = smp_chrp_setup_cpu,
-	.give_timebase = smp_chrp_give_timebase,
-	.take_timebase = smp_chrp_take_timebase,
+	.give_timebase = rtas_give_timebase,
+	.take_timebase = rtas_take_timebase,
 };
Index: linux-work/arch/powerpc/platforms/pseries/smp.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pseries/smp.c	2009-06-17 11:56:31.000000000 +1000
+++ linux-work/arch/powerpc/platforms/pseries/smp.c	2009-06-17 11:56:42.000000000 +1000
@@ -35,7 +35,6 @@
 #include <asm/prom.h>
 #include <asm/smp.h>
 #include <asm/paca.h>
-#include <asm/time.h>
 #include <asm/machdep.h>
 #include <asm/cputable.h>
 #include <asm/firmware.h>
@@ -118,31 +117,6 @@ static void __devinit smp_xics_setup_cpu
 }
 #endif /* CONFIG_XICS */
 
-static DEFINE_SPINLOCK(timebase_lock);
-static unsigned long timebase = 0;
-
-static void __devinit pSeries_give_timebase(void)
-{
-	spin_lock(&timebase_lock);
-	rtas_call(rtas_token("freeze-time-base"), 0, 1, NULL);
-	timebase = get_tb();
-	spin_unlock(&timebase_lock);
-
-	while (timebase)
-		barrier();
-	rtas_call(rtas_token("thaw-time-base"), 0, 1, NULL);
-}
-
-static void __devinit pSeries_take_timebase(void)
-{
-	while (!timebase)
-		barrier();
-	spin_lock(&timebase_lock);
-	set_tb(timebase >> 32, timebase & 0xffffffff);
-	timebase = 0;
-	spin_unlock(&timebase_lock);
-}
-
 static void __devinit smp_pSeries_kick_cpu(int nr)
 {
 	BUG_ON(nr < 0 || nr >= NR_CPUS);
@@ -209,8 +183,8 @@ static void __init smp_init_pseries(void
 
 	/* Non-lpar has additional take/give timebase */
 	if (rtas_token("freeze-time-base") != RTAS_UNKNOWN_SERVICE) {
-		smp_ops->give_timebase = pSeries_give_timebase;
-		smp_ops->take_timebase = pSeries_take_timebase;
+		smp_ops->give_timebase = rtas_give_timebase;
+		smp_ops->take_timebase = rtas_take_timebase;
 	}
 
 	pr_debug(" <- smp_init_pSeries()\n");
Index: linux-work/arch/powerpc/include/asm/rtas.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/rtas.h	2009-06-17 11:56:31.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/rtas.h	2009-06-17 11:56:42.000000000 +1000
@@ -245,5 +245,8 @@ static inline u32 rtas_config_addr(int b
 			(devfn << 8) | (reg & 0xff);
 }
 
+extern void __cpuinit rtas_give_timebase(void);
+extern void __cpuinit rtas_take_timebase(void);
+
 #endif /* __KERNEL__ */
 #endif /* _POWERPC_RTAS_H */
Index: linux-work/arch/powerpc/kernel/rtas.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/rtas.c	2009-06-17 11:56:31.000000000 +1000
+++ linux-work/arch/powerpc/kernel/rtas.c	2009-06-17 11:59:58.000000000 +1000
@@ -38,6 +38,7 @@
 #include <asm/syscalls.h>
 #include <asm/smp.h>
 #include <asm/atomic.h>
+#include <asm/time.h>
 
 struct rtas_t rtas = {
 	.lock = __RAW_SPIN_LOCK_UNLOCKED
@@ -971,3 +972,33 @@ int __init early_init_dt_scan_rtas(unsig
 	/* break now */
 	return 1;
 }
+
+static raw_spinlock_t timebase_lock;
+static u64 timebase = 0;
+
+void __cpuinit rtas_give_timebase(void)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	hard_irq_disable();
+	__raw_spin_lock(&timebase_lock);
+	rtas_call(rtas_token("freeze-time-base"), 0, 1, NULL);
+	timebase = get_tb();
+	__raw_spin_unlock(&timebase_lock);
+
+	while (timebase)
+		barrier();
+	rtas_call(rtas_token("thaw-time-base"), 0, 1, NULL);
+	local_irq_restore(flags);
+}
+
+void __cpuinit rtas_take_timebase(void)
+{
+	while (!timebase)
+		barrier();
+	__raw_spin_lock(&timebase_lock);
+	set_tb(timebase >> 32, timebase & 0xffffffff);
+	timebase = 0;
+	__raw_spin_unlock(&timebase_lock);
+}
