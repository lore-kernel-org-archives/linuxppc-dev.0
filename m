Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 418Xv03Gw3zF0dd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 00:06:04 +1000 (AEST)
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
Subject: [PATCH 2/3] m68k: mac: use time64_t in RTC handling
Date: Mon, 18 Jun 2018 16:05:17 +0200
Message-Id: <20180618140518.2920804-2-arnd@arndb.de>
In-Reply-To: <20180618140518.2920804-1-arnd@arndb.de>
References: <20180618140518.2920804-1-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The real-time clock on m68k (and powerpc) mac systems uses an unsigned
32-bit value starting in 1904, which overflows in 2040, about two years
later than everyone else, but this gets wrapped around in the Linux
code in 2038 already because of the deprecated usage of time_t and/or
long in the conversion.

Getting rid of the deprecated interfaces makes it work until 2040 as
documented, and it could be easily extended by reinterpreting
the resulting time64_t as a positive number. For the moment, I'm
adding a WARN_ON() that triggers if we encounter a time before 1970
or after 2040 (the two are indistinguishable).

This brings it in line with the corresponding code that we have on
powerpc macintosh.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/m68k/mac/misc.c | 58 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index c68054361615..b399a0809e18 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -26,33 +26,40 @@
 
 #include <asm/machdep.h>
 
-/* Offset between Unix time (1970-based) and Mac time (1904-based) */
+/* Offset between Unix time (1970-based) and Mac time (1904-based). Cuda and PMU
+ * times wrap in 2040. If we need to handle later times, the read_time functions
+ * need to be changed to interpret wrapped times as post-2040. */
 
 #define RTC_OFFSET 2082844800
 
 static void (*rom_reset)(void);
 
 #ifdef CONFIG_ADB_CUDA
-static long cuda_read_time(void)
+static time64_t cuda_read_time(void)
 {
 	struct adb_request req;
-	long time;
+	time64_t time;
 
 	if (cuda_request(&req, NULL, 2, CUDA_PACKET, CUDA_GET_TIME) < 0)
 		return 0;
 	while (!req.complete)
 		cuda_poll();
 
-	time = (req.reply[3] << 24) | (req.reply[4] << 16) |
-	       (req.reply[5] << 8) | req.reply[6];
+	time = (u32)((req.reply[3] << 24( | (req.reply[4] << 16) |
+		     (req.reply[5] << 8) | req.reply[6]);
+
+	/* it's either after year 2040, or the RTC has gone backwards */
+	WARN_ON(time < RTC_OFFSET);
+
 	return time - RTC_OFFSET;
 }
 
-static void cuda_write_time(long data)
+static void cuda_write_time(time64_t data)
 {
 	struct adb_request req;
 
 	data += RTC_OFFSET;
+	data &= 0xffffffff;
 	if (cuda_request(&req, NULL, 6, CUDA_PACKET, CUDA_SET_TIME,
 			 (data >> 24) & 0xFF, (data >> 16) & 0xFF,
 			 (data >> 8) & 0xFF, data & 0xFF) < 0)
@@ -86,26 +93,29 @@ static void cuda_write_pram(int offset, __u8 data)
 #endif /* CONFIG_ADB_CUDA */
 
 #ifdef CONFIG_ADB_PMU68K
-static long pmu_read_time(void)
+static time64_t pmu_read_time(void)
 {
 	struct adb_request req;
-	long time;
+	time64_t time;
 
 	if (pmu_request(&req, NULL, 1, PMU_READ_RTC) < 0)
 		return 0;
 	while (!req.complete)
 		pmu_poll();
 
-	time = (req.reply[1] << 24) | (req.reply[2] << 16) |
-	       (req.reply[3] << 8) | req.reply[4];
+	/* it's either after year 2040, or the RTC has gone backwards */
+	time = (u32)((req.reply[1] << 24) | (req.reply[2] << 16) |
+		     (req.reply[3] << 8) | req.reply[4]);
+
 	return time - RTC_OFFSET;
 }
 
-static void pmu_write_time(long data)
+static void pmu_write_time(time64_t data)
 {
 	struct adb_request req;
 
 	data += RTC_OFFSET;
+	data &= 0xffffffff;
 	if (pmu_request(&req, NULL, 5, PMU_SET_RTC,
 			(data >> 24) & 0xFF, (data >> 16) & 0xFF,
 			(data >> 8) & 0xFF, data & 0xFF) < 0)
@@ -269,8 +279,12 @@ static long via_read_time(void)
 		via_pram_command(0x89, &result.cdata[1]);
 		via_pram_command(0x8D, &result.cdata[0]);
 
-		if (result.idata == last_result.idata)
+		if (result.idata == last_result.idata) {
+			if (result.idata < RTC_OFFSET)
+				result.idata += 0x100000000ull;
+
 			return result.idata - RTC_OFFSET;
+		}
 
 		if (++count > 10)
 			break;
@@ -291,11 +305,11 @@ static long via_read_time(void)
  * is basically any machine with Mac II-style ADB.
  */
 
-static void via_write_time(long time)
+static void via_write_time(time64_t time)
 {
 	union {
 		__u8 cdata[4];
-		long idata;
+		__u32 idata;
 	} data;
 	__u8 temp;
 
@@ -585,12 +599,15 @@ void mac_reset(void)
  * This function translates seconds since 1970 into a proper date.
  *
  * Algorithm cribbed from glibc2.1, __offtime().
+ *
+ * This is roughly same as rtc_time64_to_tm(), which we should probably
+ * use here, but it's only available when CONFIG_RTC_LIB is enabled.
  */
 #define SECS_PER_MINUTE (60)
 #define SECS_PER_HOUR  (SECS_PER_MINUTE * 60)
 #define SECS_PER_DAY   (SECS_PER_HOUR * 24)
 
-static void unmktime(unsigned long time, long offset,
+static void unmktime(time64_t time, long offset,
 		     int *yearp, int *monp, int *dayp,
 		     int *hourp, int *minp, int *secp)
 {
@@ -602,11 +619,10 @@ static void unmktime(unsigned long time, long offset,
 		/* Leap years.  */
 		{ 0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 366 }
 	};
-	long int days, rem, y, wday, yday;
+	int days, rem, y, wday, yday;
 	const unsigned short int *ip;
 
-	days = time / SECS_PER_DAY;
-	rem = time % SECS_PER_DAY;
+	days = div_u64_rem(time, SECS_PER_DAY, &rem);
 	rem += offset;
 	while (rem < 0) {
 		rem += SECS_PER_DAY;
@@ -657,7 +673,7 @@ static void unmktime(unsigned long time, long offset,
 
 int mac_hwclk(int op, struct rtc_time *t)
 {
-	unsigned long now;
+	time64_t now;
 
 	if (!op) { /* read */
 		switch (macintosh_config->adb_type) {
@@ -693,8 +709,8 @@ int mac_hwclk(int op, struct rtc_time *t)
 		         __func__, t->tm_year + 1900, t->tm_mon + 1, t->tm_mday,
 		         t->tm_hour, t->tm_min, t->tm_sec);
 
-		now = mktime(t->tm_year + 1900, t->tm_mon + 1, t->tm_mday,
-			     t->tm_hour, t->tm_min, t->tm_sec);
+		now = mktime64(t->tm_year + 1900, t->tm_mon + 1, t->tm_mday,
+			       t->tm_hour, t->tm_min, t->tm_sec);
 
 		switch (macintosh_config->adb_type) {
 		case MAC_ADB_IOP:
-- 
2.9.0
