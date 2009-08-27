Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 23F10B7BA3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 17:01:07 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 73BD4DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 17:01:05 +1000 (EST)
Subject: [PATCH] powerpc: Properly start decrementer on BookE secondary CPUs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Thu, 27 Aug 2009 17:00:55 +1000
Message-Id: <1251356455.20467.40.camel@pasglop>
Mime-Version: 1.0
Cc: Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This moves the code to start the decrementer on 40x and BookE into
a separate function which is now called from time_init() and
secondary_time_init(), before the respective clock sources are
registered. We also remove the 85xx specific code for doing it
from the platform code.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/time.c        |   30 ++++++++++++++++++++++--------
 arch/powerpc/platforms/85xx/smp.c |   12 ------------
 2 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index edb1edb..e9404b6 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -727,6 +727,18 @@ static int __init get_freq(char *name, int cells, unsigned long *val)
 	return found;
 }
 
+/* should become __cpuinit when start_secondary also is */
+void __devinit start_cpu_decrementer(void)
+{
+#if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
+	/* Clear any pending timer interrupts */
+	mtspr(SPRN_TSR, TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS);
+
+	/* Enable decrementer interrupt */
+	mtspr(SPRN_TCR, TCR_DIE);
+#endif /* defined(CONFIG_BOOKE) || defined(CONFIG_40x) */
+}
+
 void __init generic_calibrate_decr(void)
 {
 	ppc_tb_freq = DEFAULT_TB_FREQ;		/* hardcoded default */
@@ -746,14 +758,6 @@ void __init generic_calibrate_decr(void)
 		printk(KERN_ERR "WARNING: Estimating processor frequency "
 				"(not found)\n");
 	}
-
-#if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
-	/* Clear any pending timer interrupts */
-	mtspr(SPRN_TSR, TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS);
-
-	/* Enable decrementer interrupt */
-	mtspr(SPRN_TCR, TCR_DIE);
-#endif
 }
 
 int update_persistent_clock(struct timespec now)
@@ -914,6 +918,11 @@ static void __init init_decrementer_clockevent(void)
 
 void secondary_cpu_time_init(void)
 {
+	/* Start the decrementer on CPUs that have manual control
+	 * such as BookE
+	 */
+	start_cpu_decrementer();
+
 	/* FIME: Should make unrelatred change to move snapshot_timebase
 	 * call here ! */
 	register_decrementer_clockevent(smp_processor_id());
@@ -1017,6 +1026,11 @@ void __init time_init(void)
 
 	write_sequnlock_irqrestore(&xtime_lock, flags);
 
+	/* Start the decrementer on CPUs that have manual control
+	 * such as BookE
+	 */
+	start_cpu_decrementer();
+
 	/* Register the clocksource, if we're not running on iSeries */
 	if (!firmware_has_feature(FW_FEATURE_ISERIES))
 		clocksource_init();
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 9f526ba..94f901d 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -79,21 +79,9 @@ smp_85xx_kick_cpu(int nr)
 }
 
 static void __init
-smp_85xx_basic_setup(int cpu_nr)
-{
-	/* Clear any pending timer interrupts */
-	mtspr(SPRN_TSR, TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS);
-
-	/* Enable decrementer interrupt */
-	mtspr(SPRN_TCR, TCR_DIE);
-}
-
-static void __init
 smp_85xx_setup_cpu(int cpu_nr)
 {
 	mpic_setup_this_cpu();
-
-	smp_85xx_basic_setup(cpu_nr);
 }
 
 struct smp_ops_t smp_85xx_ops = {
-- 
1.6.1.2.14.gf26b5
