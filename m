Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18694.59107.371757.322710@cargo.ozlabs.ibm.com>
Date: Tue, 28 Oct 2008 21:18:11 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Eliminate unused do_gtod variable
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since we started using the generic timekeeping code, we haven't had a
powerpc-specific version of do_gettimeofday, and hence there is now
nothing that reads do_gtod variable in arch/powerpc/kernel/time.c.
This therefore removes it and the code that sets it.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index febd581..27ccb76 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -48,26 +48,6 @@ extern unsigned long ppc_proc_freq;
 extern unsigned long ppc_tb_freq;
 #define DEFAULT_TB_FREQ		125000000UL
 
-/*
- * By putting all of this stuff into a single struct we 
- * reduce the number of cache lines touched by do_gettimeofday.
- * Both by collecting all of the data in one cache line and
- * by touching only one TOC entry on ppc64.
- */
-struct gettimeofday_vars {
-	u64 tb_to_xs;
-	u64 stamp_xsec;
-	u64 tb_orig_stamp;
-};
-
-struct gettimeofday_struct {
-	unsigned long tb_ticks_per_sec;
-	struct gettimeofday_vars vars[2];
-	struct gettimeofday_vars * volatile varp;
-	unsigned      var_idx;
-	unsigned      tb_to_us;
-};
-
 struct div_result {
 	u64 result_high;
 	u64 result_low;
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 8389c5b..e1f3a51 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -164,8 +164,6 @@ static u64 tb_to_ns_scale __read_mostly;
 static unsigned tb_to_ns_shift __read_mostly;
 static unsigned long boot_tb __read_mostly;
 
-static struct gettimeofday_struct do_gtod;
-
 extern struct timezone sys_tz;
 static long timezone_offset;
 
@@ -415,31 +413,9 @@ void udelay(unsigned long usecs)
 }
 EXPORT_SYMBOL(udelay);
 
-
-/*
- * There are two copies of tb_to_xs and stamp_xsec so that no
- * lock is needed to access and use these values in
- * do_gettimeofday.  We alternate the copies and as long as a
- * reasonable time elapses between changes, there will never
- * be inconsistent values.  ntpd has a minimum of one minute
- * between updates.
- */
 static inline void update_gtod(u64 new_tb_stamp, u64 new_stamp_xsec,
 			       u64 new_tb_to_xs)
 {
-	unsigned temp_idx;
-	struct gettimeofday_vars *temp_varp;
-
-	temp_idx = (do_gtod.var_idx == 0);
-	temp_varp = &do_gtod.vars[temp_idx];
-
-	temp_varp->tb_to_xs = new_tb_to_xs;
-	temp_varp->tb_orig_stamp = new_tb_stamp;
-	temp_varp->stamp_xsec = new_stamp_xsec;
-	smp_mb();
-	do_gtod.varp = temp_varp;
-	do_gtod.var_idx = temp_idx;
-
 	/*
 	 * tb_update_count is used to allow the userspace gettimeofday code
 	 * to assure itself that it sees a consistent view of the tb_to_xs and
@@ -515,9 +491,7 @@ static int __init iSeries_tb_recal(void)
 				tb_ticks_per_sec   = new_tb_ticks_per_sec;
 				calc_cputime_factors();
 				div128_by_32( XSEC_PER_SEC, 0, tb_ticks_per_sec, &divres );
-				do_gtod.tb_ticks_per_sec = tb_ticks_per_sec;
 				tb_to_xs = divres.result_low;
-				do_gtod.varp->tb_to_xs = tb_to_xs;
 				vdso_data->tb_ticks_per_sec = tb_ticks_per_sec;
 				vdso_data->tb_to_xs = tb_to_xs;
 			}
@@ -989,15 +963,6 @@ void __init time_init(void)
 		sys_tz.tz_dsttime = 0;
         }
 
-	do_gtod.varp = &do_gtod.vars[0];
-	do_gtod.var_idx = 0;
-	do_gtod.varp->tb_orig_stamp = tb_last_jiffy;
-	__get_cpu_var(last_jiffy) = tb_last_jiffy;
-	do_gtod.varp->stamp_xsec = (u64) xtime.tv_sec * XSEC_PER_SEC;
-	do_gtod.tb_ticks_per_sec = tb_ticks_per_sec;
-	do_gtod.varp->tb_to_xs = tb_to_xs;
-	do_gtod.tb_to_us = tb_to_us;
-
 	vdso_data->tb_orig_stamp = tb_last_jiffy;
 	vdso_data->tb_update_count = 0;
 	vdso_data->tb_ticks_per_sec = tb_ticks_per_sec;
