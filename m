Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4198pb6FlrzF0jD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 00:04:23 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>
Cc: Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 y2038@lists.linaro.org, Meelis Roos <mroos@linux.ee>,
 Andreas Schwab <schwab@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/3] [v2] powerpc: mac: fix rtc read/write functions
Date: Tue, 19 Jun 2018 16:02:27 +0200
Message-Id: <20180619140229.3615110-1-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As Mathieu pointed out, my conversion to time64_t was incorrect and resulted
in negative times to be read from the RTC. The problem is that during the
conversion from a byte array to a time64_t, the 'unsigned char' variable
holding the top byte gets turned into a negative signed 32-bit integer
before being assigned to the 64-bit variable for any times after 1972.

This changes the logic to cast to an unsigned 32-bit number first for
the Macintosh time and then convert that to the Unix time, which then gives
us a time in the documented 1904..2040 year range. I decided not to use
the longer 1970..2106 range that other drivers use, for consistency with
the literal interpretation of the register, but that could be easily
changed if we decide we want to support any Mac after 2040.

Just to be on the safe side, I'm also adding a WARN_ON that will trigger
if either the year 2040 has come and is observed by this driver, or we
run into an RTC that got set back to a pre-1970 date for some reason
(the two are indistinguishable).

For the RTC write functions, Andreas found another problem: both
pmu_request() and cuda_request() are varargs functions, so changing
the type of the arguments passed into them from 32 bit to 64 bit
breaks the API for the set_rtc_time functions. This changes it
back to 32 bits.

The same code exists in arch/m68k/ and is patched in an identical way now
in a separate patch.

Fixes: 5bfd643583b2 ("powerpc: use time64_t in read_persistent_clock")
Reported-by: Mathieu Malaterre <malat@debian.org>
Reported-by: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/powermac/time.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/time.c b/arch/powerpc/platforms/powermac/time.c
index 7c968e46736f..12e6e4d30602 100644
--- a/arch/powerpc/platforms/powermac/time.c
+++ b/arch/powerpc/platforms/powermac/time.c
@@ -42,7 +42,11 @@
 #define DBG(x...)
 #endif
 
-/* Apparently the RTC stores seconds since 1 Jan 1904 */
+/*
+ * Offset between Unix time (1970-based) and Mac time (1904-based). Cuda and PMU
+ * times wrap in 2040. If we need to handle later times, the read_time functions
+ * need to be changed to interpret wrapped times as post-2040.
+ */
 #define RTC_OFFSET	2082844800
 
 /*
@@ -97,8 +101,11 @@ static time64_t cuda_get_time(void)
 	if (req.reply_len != 7)
 		printk(KERN_ERR "cuda_get_time: got %d byte reply\n",
 		       req.reply_len);
-	now = (req.reply[3] << 24) + (req.reply[4] << 16)
-		+ (req.reply[5] << 8) + req.reply[6];
+	now = (u32)((req.reply[3] << 24) + (req.reply[4] << 16) +
+		    (req.reply[5] << 8) + req.reply[6]);
+	/* it's either after year 2040, or the RTC has gone backwards */
+	WARN_ON(now < RTC_OFFSET);
+
 	return now - RTC_OFFSET;
 }
 
@@ -106,10 +113,10 @@ static time64_t cuda_get_time(void)
 
 static int cuda_set_rtc_time(struct rtc_time *tm)
 {
-	time64_t nowtime;
+	u32 nowtime;
 	struct adb_request req;
 
-	nowtime = rtc_tm_to_time64(tm) + RTC_OFFSET;
+	nowtime = lower_32_bits(rtc_tm_to_time64(tm) + RTC_OFFSET);
 	if (cuda_request(&req, NULL, 6, CUDA_PACKET, CUDA_SET_TIME,
 			 nowtime >> 24, nowtime >> 16, nowtime >> 8,
 			 nowtime) < 0)
@@ -140,8 +147,12 @@ static time64_t pmu_get_time(void)
 	if (req.reply_len != 4)
 		printk(KERN_ERR "pmu_get_time: got %d byte reply from PMU\n",
 		       req.reply_len);
-	now = (req.reply[0] << 24) + (req.reply[1] << 16)
-		+ (req.reply[2] << 8) + req.reply[3];
+	now = (u32)((req.reply[0] << 24) + (req.reply[1] << 16)	+
+		    (req.reply[2] << 8) + req.reply[3]);
+
+	/* it's either after year 2040, or the RTC has gone backwards */
+	WARN_ON(now < RTC_OFFSET);
+
 	return now - RTC_OFFSET;
 }
 
@@ -149,10 +160,10 @@ static time64_t pmu_get_time(void)
 
 static int pmu_set_rtc_time(struct rtc_time *tm)
 {
-	time64_t nowtime;
+	u32 nowtime;
 	struct adb_request req;
 
-	nowtime = rtc_tm_to_time64(tm) + RTC_OFFSET;
+	nowtime = lower_32_bits(rtc_tm_to_time64(tm) + RTC_OFFSET);
 	if (pmu_request(&req, NULL, 5, PMU_SET_RTC, nowtime >> 24,
 			nowtime >> 16, nowtime >> 8, nowtime) < 0)
 		return -ENXIO;
-- 
2.9.0
