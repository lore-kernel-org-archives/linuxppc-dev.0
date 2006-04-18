Return-Path: <olof@lixom.net>
Date: Tue, 18 Apr 2006 11:25:53 -0500
To: sfr@ozlabs.org
Subject: [PATCH] Remove stale iseries global
Message-ID: <20060418162553.GC26746@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Not even the iSeries maintainer seems to have access to this legendary
piranha simulator. It adds a bit of ugliness in the common time init
code, and if it's no longer used we might as well be done with it and
remove the bloat.


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: 2.6/arch/powerpc/kernel/time.c
===================================================================
--- 2.6.orig/arch/powerpc/kernel/time.c
+++ 2.6/arch/powerpc/kernel/time.c
@@ -76,7 +76,6 @@
 
 /* keep track of when we need to update the rtc */
 time_t last_rtc_update;
-extern int piranha_simulator;
 #ifdef CONFIG_PPC_ISERIES
 unsigned long iSeries_recal_titan = 0;
 unsigned long iSeries_recal_tb = 0; 
@@ -1010,10 +1009,7 @@ void __init time_init(void)
 	tb_to_ns_scale = scale;
 	tb_to_ns_shift = shift;
 
-#ifdef CONFIG_PPC_ISERIES
-	if (!piranha_simulator)
-#endif
-		tm = get_boot_time();
+	tm = get_boot_time();
 
 	write_seqlock_irqsave(&xtime_lock, flags);
 
Index: 2.6/arch/powerpc/platforms/iseries/mf.c
===================================================================
--- 2.6.orig/arch/powerpc/platforms/iseries/mf.c
+++ 2.6/arch/powerpc/platforms/iseries/mf.c
@@ -45,7 +45,6 @@
 
 #include "setup.h"
 
-extern int piranha_simulator;
 static int mf_initialized;
 
 /*
@@ -658,7 +657,7 @@ static void mf_clear_src(void)
 
 void __init mf_display_progress(u16 value)
 {
-	if (piranha_simulator || !mf_initialized)
+	if (!mf_initialized)
 		return;
 
 	if (0xFFFF == value)
@@ -1295,9 +1294,6 @@ __initcall(mf_proc_init);
  */
 void iSeries_get_rtc_time(struct rtc_time *rtc_tm)
 {
-	if (piranha_simulator)
-		return;
-
 	mf_get_rtc(rtc_tm);
 	rtc_tm->tm_mon--;
 }
@@ -1316,9 +1312,6 @@ unsigned long iSeries_get_boot_time(void
 {
 	struct rtc_time tm;
 
-	if (piranha_simulator)
-		return 0;
-
 	mf_get_boot_rtc(&tm);
 	return mktime(tm.tm_year + 1900, tm.tm_mon, tm.tm_mday,
 		      tm.tm_hour, tm.tm_min, tm.tm_sec);
Index: 2.6/arch/powerpc/platforms/iseries/setup.c
===================================================================
--- 2.6.orig/arch/powerpc/platforms/iseries/setup.c
+++ 2.6/arch/powerpc/platforms/iseries/setup.c
@@ -80,9 +80,6 @@ extern void iSeries_pci_final_fixup(void
 static void iSeries_pci_final_fixup(void) { }
 #endif
 
-/* Global Variables */
-int piranha_simulator;
-
 extern int rd_size;		/* Defined in drivers/block/rd.c */
 extern unsigned long embedded_sysmap_start;
 extern unsigned long embedded_sysmap_end;
@@ -339,8 +336,6 @@ static void __init iSeries_init_early(vo
 #ifdef CONFIG_SMP
 	smp_init_iSeries();
 #endif
-	if (itLpNaca.xPirEnvironMode == 0)
-		piranha_simulator = 1;
 
 	/* Associate Lp Event Queue 0 with processor 0 */
 	HvCallEvent_setLpEventQueueInterruptProc(0, 0);
