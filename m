Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 7A453DDEC7
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 15:43:25 +1000 (EST)
Date: Fri, 22 Jun 2007 15:43:24 +1000
To: LinuxPPC-dev <linuxppc-dev@ozlabs.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Move iSeries_tb_recal from do_settimeofday() into it's own
	late_initcall.
Message-ID: <20070622054324.GV9768@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
From: tony@bakeyournoodle.com (Tony Breeds)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Move iSeries_tb_recal from do_settimeofday() into it's own late_initcall.

Currently iSeries will recalibrate the cputime_factors, from the first
settimeofday() call.

It seems the reason for doing this is to ensure a resaonable time delta after
time_init().  On current kernels (with udev), this call is made 40-60 seconds
into the boot process, by moving it to a late initcall it is called
approximately 5 seconds after time_init() is called.  This is sufficient to
recalibrate the timebase.



Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
CC: Stephen Rothwell <sfr@canb.auug.org.au>

---

 arch/powerpc/kernel/time.c             |   30 +++++++++++++++----------
 arch/powerpc/platforms/iseries/setup.c |    7 +----
 include/asm-powerpc/time.h             |    4 +++
 3 files changed, 25 insertions(+), 16 deletions(-)

Index: working/arch/powerpc/kernel/time.c
===================================================================
--- working.orig/arch/powerpc/kernel/time.c	2007-06-22 11:02:24.000000000 +1000
+++ working/arch/powerpc/kernel/time.c	2007-06-22 11:40:44.000000000 +1000
@@ -77,9 +77,8 @@
 /* keep track of when we need to update the rtc */
 time_t last_rtc_update;
 #ifdef CONFIG_PPC_ISERIES
-unsigned long iSeries_recal_titan = 0;
-unsigned long iSeries_recal_tb = 0; 
-static unsigned long first_settimeofday = 1;
+static unsigned long __initdata iSeries_recal_titan;
+static signed long __initdata iSeries_recal_tb;
 #endif
 
 /* The decrementer counts down by 128 every 128ns on a 601. */
@@ -551,10 +550,15 @@ EXPORT_SYMBOL(profile_pc);
  * returned by the service processor for the timebase frequency.  
  */
 
-static void iSeries_tb_recal(void)
+static int __init iSeries_tb_recal(void)
 {
 	struct div_result divres;
 	unsigned long titan, tb;
+
+	/* Make sure we only run on iSeries */
+	if (!firmware_has_feature(FW_FEATURE_ISERIES))
+		return -ENODEV;
+
 	tb = get_tb();
 	titan = HvCallXm_loadTod();
 	if ( iSeries_recal_titan ) {
@@ -595,8 +599,18 @@ static void iSeries_tb_recal(void)
 	}
 	iSeries_recal_titan = titan;
 	iSeries_recal_tb = tb;
+
+	return 0;
 }
-#endif
+late_initcall(iSeries_tb_recal);
+
+/* Called from platforms/iseries/setup.c:iSeries_init_early() */
+void __init iSeries_time_init_early(void)
+{
+	iSeries_recal_tb = get_tb();
+	iSeries_recal_titan = HvCallXm_loadTod();
+}
+#endif /* CONFIG_PPC_ISERIES */
 
 /*
  * For iSeries shared processors, we have to let the hypervisor
@@ -760,12 +774,6 @@ int do_settimeofday(struct timespec *tv)
 	 * to the RTC again, or write to the RTC but then they don't call
 	 * settimeofday to perform this operation.
 	 */
-#ifdef CONFIG_PPC_ISERIES
-	if (firmware_has_feature(FW_FEATURE_ISERIES) && first_settimeofday) {
-		iSeries_tb_recal();
-		first_settimeofday = 0;
-	}
-#endif
 
 	/* Make userspace gettimeofday spin until we're done. */
 	++vdso_data->tb_update_count;
Index: working/arch/powerpc/platforms/iseries/setup.c
===================================================================
--- working.orig/arch/powerpc/platforms/iseries/setup.c	2007-06-22 11:02:42.000000000 +1000
+++ working/arch/powerpc/platforms/iseries/setup.c	2007-06-22 11:10:04.000000000 +1000
@@ -79,8 +79,6 @@ extern void iSeries_pci_final_fixup(void
 static void iSeries_pci_final_fixup(void) { }
 #endif
 
-extern unsigned long iSeries_recal_tb;
-extern unsigned long iSeries_recal_titan;
 
 struct MemoryBlock {
 	unsigned long absStart;
@@ -292,9 +290,8 @@ static void __init iSeries_init_early(vo
 {
 	DBG(" -> iSeries_init_early()\n");
 
-	iSeries_recal_tb = get_tb();
-	iSeries_recal_titan = HvCallXm_loadTod();
-
+	/* Snapshot the timebase, for use in later recalibration */
+	iSeries_time_init_early();
 	/*
 	 * Initialize the DMA/TCE management
 	 */
Index: working/include/asm-powerpc/time.h
===================================================================
--- working.orig/include/asm-powerpc/time.h	2007-06-22 11:03:37.000000000 +1000
+++ working/include/asm-powerpc/time.h	2007-06-22 11:40:59.000000000 +1000
@@ -240,5 +240,9 @@ extern void snapshot_timebases(void);
 #define snapshot_timebases()			do { } while (0)
 #endif
 
+#ifdef CONFIG_PPC_ISERIES
+extern void iSeries_time_init_early(void);
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* __POWERPC_TIME_H */
Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
