Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 5103D67B64
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 06:41:17 +1000 (EST)
Date: Fri, 11 Aug 2006 15:41:05 -0500
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] fix gettimeofday vs. update_gtod race
Message-ID: <20060811204105.GK3233@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Userspace can (very, very) occasionally get bogus time values due to
a tiny race between powerpc's do_gettimeofday and timer interrupt:

1. do_gettimeofday does get_tb()

2. decrementer exception on boot cpu which runs timer_recalc_offset,
   which also samples the timebase and updates the do_gtod structure
   with a greater timebase value.

3. do_gettimeofday calls __do_gettimeofday, which leads to the
   negative result from tb_val - temp_varp->tb_orig_stamp.

The fix is to ensure that do_gettimeofday samples the timebase only
after loading do_gtod.varp.


Signed-off-by: Nathan Lynch <ntl@pobox.com>

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 774c0a3..6b690df 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -417,7 +417,7 @@ static __inline__ void timer_check_rtc(v
 /*
  * This version of gettimeofday has microsecond resolution.
  */
-static inline void __do_gettimeofday(struct timeval *tv, u64 tb_val)
+static inline void __do_gettimeofday(struct timeval *tv)
 {
 	unsigned long sec, usec;
 	u64 tb_ticks, xsec;
@@ -431,7 +431,12 @@ static inline void __do_gettimeofday(str
 	 * without a divide (and in fact, without a multiply)
 	 */
 	temp_varp = do_gtod.varp;
-	tb_ticks = tb_val - temp_varp->tb_orig_stamp;
+
+	/* Sampling the time base must be done after loading
+	 * do_gtod.varp in order to avoid racing with update_gtod.
+	 */
+	rmb();
+	tb_ticks = get_tb() - temp_varp->tb_orig_stamp;
 	temp_tb_to_xs = temp_varp->tb_to_xs;
 	temp_stamp_xsec = temp_varp->stamp_xsec;
 	xsec = temp_stamp_xsec + mulhdu(tb_ticks, temp_tb_to_xs);
@@ -464,7 +469,7 @@ void do_gettimeofday(struct timeval *tv)
 		tv->tv_usec = usec;
 		return;
 	}
-	__do_gettimeofday(tv, get_tb());
+	__do_gettimeofday(tv);
 }
 
 EXPORT_SYMBOL(do_gettimeofday);
