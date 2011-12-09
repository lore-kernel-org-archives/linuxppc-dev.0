Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:70:0:1:25:1])
 by ozlabs.org (Postfix) with ESMTP id 2D5DE1007D8
 for <linuxppc-dev@ozlabs.org>; Sat, 10 Dec 2011 08:35:13 +1100 (EST)
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
 by mail-out.m-online.net (Postfix) with ESMTP id E41F01C0F590
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Dec 2011 22:35:09 +0100 (CET)
Received: from igel.home (ppp-88-217-106-226.dynamic.mnet-online.de
 [88.217.106.226])
 by mail.mnet-online.de (Postfix) with ESMTPA id 2932F1C00127
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Dec 2011 22:35:09 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: fix wrong divisor in usecs_to_cputime
References: <m2fwgvnwlm.fsf__7616.12257124415$1323342974$gmane$org@igel.home>
Date: Fri, 09 Dec 2011 22:35:08 +0100
In-Reply-To: <m2fwgvnwlm.fsf__7616.12257124415$1323342974$gmane$org@igel.home>
 (Andreas Schwab's message of "Thu, 08 Dec 2011 12:15:01 +0100")
Message-ID: <m2pqfx2zub.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit d57af9b (taskstats: use real microsecond granularity for CPU times)
renamed msecs_to_cputime to usecs_to_cputime, but failed to update all
numbers on the way.  This causes nonsensical cpu idle/iowait values to be
displayed in /proc/stat (the only user of usecs_to_cputime so far).

This also renames __cputime_msec_factor to __cputime_usec_factor, adapting
its value and using it directly in cputime_to_usecs instead of doing two
multiplications.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 arch/powerpc/include/asm/cputime.h |    6 +++---
 arch/powerpc/kernel/time.c         |   10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/cputime.h b/arch/powerpc/include/asm/cputime.h
index 1cf20bd..33a3580 100644
--- a/arch/powerpc/include/asm/cputime.h
+++ b/arch/powerpc/include/asm/cputime.h
@@ -126,11 +126,11 @@ static inline u64 cputime64_to_jiffies64(const cputime_t ct)
 /*
  * Convert cputime <-> microseconds
  */
-extern u64 __cputime_msec_factor;
+extern u64 __cputime_usec_factor;
 
 static inline unsigned long cputime_to_usecs(const cputime_t ct)
 {
-	return mulhdu(ct, __cputime_msec_factor) * USEC_PER_MSEC;
+	return mulhdu(ct, __cputime_usec_factor);
 }
 
 static inline cputime_t usecs_to_cputime(const unsigned long us)
@@ -143,7 +143,7 @@ static inline cputime_t usecs_to_cputime(const unsigned long us)
 	sec = us / 1000000;
 	if (ct) {
 		ct *= tb_ticks_per_sec;
-		do_div(ct, 1000);
+		do_div(ct, 1000000);
 	}
 	if (sec)
 		ct += (cputime_t) sec * tb_ticks_per_sec;
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 522bb1d..69477e5 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -168,13 +168,13 @@ EXPORT_SYMBOL_GPL(ppc_tb_freq);
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 /*
  * Factors for converting from cputime_t (timebase ticks) to
- * jiffies, milliseconds, seconds, and clock_t (1/USER_HZ seconds).
+ * jiffies, microseconds, seconds, and clock_t (1/USER_HZ seconds).
  * These are all stored as 0.64 fixed-point binary fractions.
  */
 u64 __cputime_jiffies_factor;
 EXPORT_SYMBOL(__cputime_jiffies_factor);
-u64 __cputime_msec_factor;
-EXPORT_SYMBOL(__cputime_msec_factor);
+u64 __cputime_usec_factor;
+EXPORT_SYMBOL(__cputime_usec_factor);
 u64 __cputime_sec_factor;
 EXPORT_SYMBOL(__cputime_sec_factor);
 u64 __cputime_clockt_factor;
@@ -192,8 +192,8 @@ static void calc_cputime_factors(void)
 
 	div128_by_32(HZ, 0, tb_ticks_per_sec, &res);
 	__cputime_jiffies_factor = res.result_low;
-	div128_by_32(1000, 0, tb_ticks_per_sec, &res);
-	__cputime_msec_factor = res.result_low;
+	div128_by_32(1000000, 0, tb_ticks_per_sec, &res);
+	__cputime_usec_factor = res.result_low;
 	div128_by_32(1, 0, tb_ticks_per_sec, &res);
 	__cputime_sec_factor = res.result_low;
 	div128_by_32(USER_HZ, 0, tb_ticks_per_sec, &res);
-- 
1.7.8


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
