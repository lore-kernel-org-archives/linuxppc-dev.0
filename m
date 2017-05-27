Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wZbCB0Rj8zDqP0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 May 2017 18:05:10 +1000 (AEST)
Date: Sat, 27 May 2017 18:04:52 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org, Michael Ellerman <michael@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>
Subject: [PATCH] powerpc: Convert VDSO update function to use new
 update_vsyscall interface
Message-ID: <20170527080452.GA14021@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This converts the powerpc VDSO time update function to use the new
interface introduced in commit 576094b7f0aa ("time: Introduce new
GENERIC_TIME_VSYSCALL", 2012-09-11).  Where the old interface gave
us the time as of the last update in seconds and whole nanoseconds,
with the new interface we get the nanoseconds part effectively in
a binary fixed-point format with tk->tkr_mono.shift bits to the
right of the binary point.

With the old interface, the fractional nanoseconds got truncated,
meaning that the value returned by the VDSO clock_gettime function
would have about 1ns of jitter in it compared to the value computed
by the generic timekeeping code in the kernel.

The powerpc VDSO time functions (clock_gettime and gettimeofday)
already work in units of 2^-32 seconds, or 0.23283 ns, because that
makes it simple to split the result into seconds and fractional
seconds, and represent the fractional seconds in either microseconds
or nanoseconds.  This is good enough accuracy for now, so this patch
avoids changing how the VDSO works or the interface in the VDSO data
page.

This patch converts the powerpc update_vsyscall_old to be called
update_vsyscall and use the new interface.  We convert the fractional
second to units of 2^-32 seconds without truncating to whole nanoseconds.
(There is still a conversion to whole nanoseconds for any legacy users
of the vdso_data/systemcfg stamp_xtime field.)

In addition, this improves the accuracy of the computation of tb_to_xs
for those systems with high-frequency timebase clocks (>= 268.5 MHz)
by doing the right shift in two parts, one before the multiplication and
one after, rather than doing the right shift before the multiplication.
(We can't do all of the right shift after the multiplication unless we
use 128-bit arithmetic.)

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/Kconfig       |  2 +-
 arch/powerpc/kernel/time.c | 68 +++++++++++++++++++++++++++++++++++-----------
 2 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index f7c8f99..8fe2dc7 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -163,7 +163,7 @@ config PPC
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
-	select GENERIC_TIME_VSYSCALL_OLD
+	select GENERIC_TIME_VSYSCALL
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_KGDB
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 5d13f06..51a6bed 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -833,28 +833,66 @@ static u64 timebase_read(struct clocksource *cs)
 	return (u64)get_tb();
 }
 
-void update_vsyscall_old(struct timespec *wall_time, struct timespec *wtm,
-			 struct clocksource *clock, u32 mult, u64 cycle_last)
+
+void update_vsyscall(struct timekeeper *tk)
 {
+	struct timespec xt;
+	struct clocksource *clock = tk->tkr_mono.clock;
+	u32 mult = tk->tkr_mono.mult;
+	u32 shift = tk->tkr_mono.shift;
+	u64 cycle_last = tk->tkr_mono.cycle_last;
 	u64 new_tb_to_xs, new_stamp_xsec;
-	u32 frac_sec;
+	u64 frac_sec;
 
 	if (clock != &clocksource_timebase)
 		return;
 
+	xt.tv_sec = tk->xtime_sec;
+	xt.tv_nsec = (long)(tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift);
+
 	/* Make userspace gettimeofday spin until we're done. */
 	++vdso_data->tb_update_count;
 	smp_mb();
 
-	/* 19342813113834067 ~= 2^(20+64) / 1e9 */
-	new_tb_to_xs = (u64) mult * (19342813113834067ULL >> clock->shift);
-	new_stamp_xsec = (u64) wall_time->tv_nsec * XSEC_PER_SEC;
-	do_div(new_stamp_xsec, 1000000000);
-	new_stamp_xsec += (u64) wall_time->tv_sec * XSEC_PER_SEC;
+	/*
+	 * This computes ((2^20 / 1e9) * mult) >> shift as a
+	 * 0.64 fixed-point fraction.
+	 * The computation in the else clause below won't overflow
+	 * (as long as the timebase frequency is >= 1.049 MHz)
+	 * but loses precision because we lose the low bits of the constant
+	 * in the shift.  Note that 19342813113834067 ~= 2^(20+64) / 1e9.
+	 * For a shift of 24 the error is about 0.5e-9, or about 0.5ns
+	 * over a second.  (Shift values are usually 22, 23 or 24.)
+	 * For high frequency clocks such as the 512MHz timebase clock
+	 * on POWER[6789], the mult value is small (e.g. 32768000)
+	 * and so we can shift the constant by 16 initially
+	 * (295147905179 ~= 2^(20+64-16) / 1e9) and then do the
+	 * remaining shifts after the multiplication, which gives a
+	 * more accurate result (e.g. with mult = 32768000, shift = 24,
+	 * the error is only about 1.2e-12, or 0.7ns over 10 minutes).
+	 */
+	if (mult <= 62500000 && clock->shift >= 16)
+		new_tb_to_xs = ((u64) mult * 295147905179ULL) >> (clock->shift - 16);
+	else
+		new_tb_to_xs = (u64) mult * (19342813113834067ULL >> clock->shift);
+
+	/*
+	 * Compute the fractional second in units of 2^-32 seconds.
+	 * The fractional second is tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift
+	 * in nanoseconds, so multiplying that by 2^32 / 1e9 gives
+	 * it in units of 2^-32 seconds.
+	 * We assume shift <= 32 because clocks_calc_mult_shift()
+	 * generates shift values in the range 0 - 32.
+	 */
+	frac_sec = tk->tkr_mono.xtime_nsec << (32 - shift);
+	do_div(frac_sec, NSEC_PER_SEC);
 
-	BUG_ON(wall_time->tv_nsec >= NSEC_PER_SEC);
-	/* this is tv_nsec / 1e9 as a 0.32 fraction */
-	frac_sec = ((u64) wall_time->tv_nsec * 18446744073ULL) >> 32;
+	/*
+	 * Work out new stamp_xsec value for any legacy users of systemcfg.
+	 * stamp_xsec is in units of 2^-20 seconds.
+	 */
+	new_stamp_xsec = frac_sec >> 12;
+	new_stamp_xsec += tk->xtime_sec * XSEC_PER_SEC;
 
 	/*
 	 * tb_update_count is used to allow the userspace gettimeofday code
@@ -864,15 +902,13 @@ void update_vsyscall_old(struct timespec *wall_time, struct timespec *wtm,
 	 * the two values of tb_update_count match and are even then the
 	 * tb_to_xs and stamp_xsec values are consistent.  If not, then it
 	 * loops back and reads them again until this criteria is met.
-	 * We expect the caller to have done the first increment of
-	 * vdso_data->tb_update_count already.
 	 */
 	vdso_data->tb_orig_stamp = cycle_last;
 	vdso_data->stamp_xsec = new_stamp_xsec;
 	vdso_data->tb_to_xs = new_tb_to_xs;
-	vdso_data->wtom_clock_sec = wtm->tv_sec;
-	vdso_data->wtom_clock_nsec = wtm->tv_nsec;
-	vdso_data->stamp_xtime = *wall_time;
+	vdso_data->wtom_clock_sec = tk->wall_to_monotonic.tv_sec;
+	vdso_data->wtom_clock_nsec = tk->wall_to_monotonic.tv_nsec;
+	vdso_data->stamp_xtime = xt;
 	vdso_data->stamp_sec_fraction = frac_sec;
 	smp_wmb();
 	++(vdso_data->tb_update_count);
-- 
2.7.4
