Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 418Y3Q6p5bzF0pl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 00:13:22 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>
Cc: Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 y2038@lists.linaro.org, Meelis Roos <mroos@linux.ee>,
 Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/3] powerpc: mac: fix rtc read functions
Date: Mon, 18 Jun 2018 16:05:16 +0200
Message-Id: <20180618140518.2920804-1-arnd@arndb.de>
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

The same code exists in arch/m68k/ and is patched in an identical way now
in a separate patch.

Fixes: 5bfd643583b2 ("powerpc: use time64_t in read_persistent_clock")
Reported-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/powermac/time.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/time.c b/arch/powerpc/platforms/powermac/time.c
index 7c968e46736f..173a80630169 100644
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
 
-- 
2.9.0
