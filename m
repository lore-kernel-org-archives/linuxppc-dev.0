Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 41R86f4VzTzDqvH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 18:21:46 +1000 (AEST)
Date: Thu, 12 Jul 2018 18:23:09 +1000
To: Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [RFC] macintosh: Use common code to access RTC
ReSent-Message-ID: <alpine.LNX.2.21.1807121822390.18@nippy.intranet>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Message-ID: <20180712082309.YIJi4qwNXth22OCM4KT0NXfAa51Gv41z5hKPg5Whiqs@z>

Once the 68k Mac port adopts the via-pmu driver, it must access
the PMU RTC using the appropriate command format. The same code can
then be used for both m68k and powerpc.

Replace the RTC code that's duplicated in arch/powerpc and arch/m68k
with common RTC accessors for Cuda and PMU devices.

While we're at it, drop the problematic WARN_ON that was introduced in
commit 22db552b50fa ("powerpc/powermac: Fix rtc read/write functions").

---
The patch below hasn't been tested yet and would need to be applied
after my PMU patch series (v4). So I'll probably append it to v5.

The patch below is an alternative both to the patch Arnd posted here,
https://lore.kernel.org/lkml/20180619140229.3615110-2-arnd@arndb.de/
as well as another future patch to remove the WARN_ON from 
arch/powerpc/platforms/powermac/time.c.

---
 arch/m68k/mac/misc.c                   |  75 +++----------------
 arch/powerpc/platforms/powermac/time.c | 130 ++++-----------------------------
 drivers/macintosh/via-cuda.c           |  35 +++++++++
 drivers/macintosh/via-pmu.c            |  33 +++++++++
 include/linux/cuda.h                   |   4 +
 include/linux/pmu.h                    |   4 +
 6 files changed, 99 insertions(+), 182 deletions(-)

diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index 28090a44fa09..21e3afa48de9 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -33,34 +33,6 @@
 static void (*rom_reset)(void);
 
 #ifdef CONFIG_ADB_CUDA
-static long cuda_read_time(void)
-{
-	struct adb_request req;
-	long time;
-
-	if (cuda_request(&req, NULL, 2, CUDA_PACKET, CUDA_GET_TIME) < 0)
-		return 0;
-	while (!req.complete)
-		cuda_poll();
-
-	time = (req.reply[3] << 24) | (req.reply[4] << 16) |
-	       (req.reply[5] << 8) | req.reply[6];
-	return time - RTC_OFFSET;
-}
-
-static void cuda_write_time(long data)
-{
-	struct adb_request req;
-
-	data += RTC_OFFSET;
-	if (cuda_request(&req, NULL, 6, CUDA_PACKET, CUDA_SET_TIME,
-			 (data >> 24) & 0xFF, (data >> 16) & 0xFF,
-			 (data >> 8) & 0xFF, data & 0xFF) < 0)
-		return;
-	while (!req.complete)
-		cuda_poll();
-}
-
 static __u8 cuda_read_pram(int offset)
 {
 	struct adb_request req;
@@ -86,34 +58,6 @@ static void cuda_write_pram(int offset, __u8 data)
 #endif /* CONFIG_ADB_CUDA */
 
 #ifdef CONFIG_ADB_PMU
-static long pmu_read_time(void)
-{
-	struct adb_request req;
-	long time;
-
-	if (pmu_request(&req, NULL, 1, PMU_READ_RTC) < 0)
-		return 0;
-	while (!req.complete)
-		pmu_poll();
-
-	time = (req.reply[1] << 24) | (req.reply[2] << 16) |
-	       (req.reply[3] << 8) | req.reply[4];
-	return time - RTC_OFFSET;
-}
-
-static void pmu_write_time(long data)
-{
-	struct adb_request req;
-
-	data += RTC_OFFSET;
-	if (pmu_request(&req, NULL, 5, PMU_SET_RTC,
-			(data >> 24) & 0xFF, (data >> 16) & 0xFF,
-			(data >> 8) & 0xFF, data & 0xFF) < 0)
-		return;
-	while (!req.complete)
-		pmu_poll();
-}
-
 static __u8 pmu_read_pram(int offset)
 {
 	struct adb_request req;
@@ -291,13 +235,17 @@ static long via_read_time(void)
  * is basically any machine with Mac II-style ADB.
  */
 
-static void via_write_time(long time)
+static void via_set_rtc_time(struct rtc_time *tm)
 {
 	union {
 		__u8 cdata[4];
 		long idata;
 	} data;
 	__u8 temp;
+	unsigned long time;
+
+	time = mktime(tm->tm_year + 1900, tm->tm_mon + 1, tm->tm_mday,
+	              tm->tm_hour, tm->tm_min, tm->tm_sec);
 
 	/* Clear the write protect bit */
 
@@ -635,12 +583,12 @@ int mac_hwclk(int op, struct rtc_time *t)
 #ifdef CONFIG_ADB_CUDA
 		case MAC_ADB_EGRET:
 		case MAC_ADB_CUDA:
-			now = cuda_read_time();
+			now = cuda_get_time();
 			break;
 #endif
 #ifdef CONFIG_ADB_PMU
 		case MAC_ADB_PB2:
-			now = pmu_read_time();
+			now = pmu_get_time();
 			break;
 #endif
 		default:
@@ -659,24 +607,21 @@ int mac_hwclk(int op, struct rtc_time *t)
 		         __func__, t->tm_year + 1900, t->tm_mon + 1, t->tm_mday,
 		         t->tm_hour, t->tm_min, t->tm_sec);
 
-		now = mktime(t->tm_year + 1900, t->tm_mon + 1, t->tm_mday,
-			     t->tm_hour, t->tm_min, t->tm_sec);
-
 		switch (macintosh_config->adb_type) {
 		case MAC_ADB_IOP:
 		case MAC_ADB_II:
 		case MAC_ADB_PB1:
-			via_write_time(now);
+			via_set_rtc_time(t);
 			break;
 #ifdef CONFIG_ADB_CUDA
 		case MAC_ADB_EGRET:
 		case MAC_ADB_CUDA:
-			cuda_write_time(now);
+			cuda_set_rtc_time(t);
 			break;
 #endif
 #ifdef CONFIG_ADB_PMU
 		case MAC_ADB_PB2:
-			pmu_write_time(now);
+			pmu_set_rtc_time(t);
 			break;
 #endif
 		default:
diff --git a/arch/powerpc/platforms/powermac/time.c b/arch/powerpc/platforms/powermac/time.c
index 12e6e4d30602..3f35dcf5cfa8 100644
--- a/arch/powerpc/platforms/powermac/time.c
+++ b/arch/powerpc/platforms/powermac/time.c
@@ -42,13 +42,6 @@
 #define DBG(x...)
 #endif
 
-/*
- * Offset between Unix time (1970-based) and Mac time (1904-based). Cuda and PMU
- * times wrap in 2040. If we need to handle later times, the read_time functions
- * need to be changed to interpret wrapped times as post-2040.
- */
-#define RTC_OFFSET	2082844800
-
 /*
  * Calibrate the decrementer frequency with the VIA timer 1.
  */
@@ -88,98 +81,6 @@ long __init pmac_time_init(void)
 	return delta;
 }
 
-#ifdef CONFIG_ADB_CUDA
-static time64_t cuda_get_time(void)
-{
-	struct adb_request req;
-	time64_t now;
-
-	if (cuda_request(&req, NULL, 2, CUDA_PACKET, CUDA_GET_TIME) < 0)
-		return 0;
-	while (!req.complete)
-		cuda_poll();
-	if (req.reply_len != 7)
-		printk(KERN_ERR "cuda_get_time: got %d byte reply\n",
-		       req.reply_len);
-	now = (u32)((req.reply[3] << 24) + (req.reply[4] << 16) +
-		    (req.reply[5] << 8) + req.reply[6]);
-	/* it's either after year 2040, or the RTC has gone backwards */
-	WARN_ON(now < RTC_OFFSET);
-
-	return now - RTC_OFFSET;
-}
-
-#define cuda_get_rtc_time(tm)	rtc_time64_to_tm(cuda_get_time(), (tm))
-
-static int cuda_set_rtc_time(struct rtc_time *tm)
-{
-	u32 nowtime;
-	struct adb_request req;
-
-	nowtime = lower_32_bits(rtc_tm_to_time64(tm) + RTC_OFFSET);
-	if (cuda_request(&req, NULL, 6, CUDA_PACKET, CUDA_SET_TIME,
-			 nowtime >> 24, nowtime >> 16, nowtime >> 8,
-			 nowtime) < 0)
-		return -ENXIO;
-	while (!req.complete)
-		cuda_poll();
-	if ((req.reply_len != 3) && (req.reply_len != 7))
-		printk(KERN_ERR "cuda_set_rtc_time: got %d byte reply\n",
-		       req.reply_len);
-	return 0;
-}
-
-#else
-#define cuda_get_time()		0
-#define cuda_get_rtc_time(tm)
-#define cuda_set_rtc_time(tm)	0
-#endif
-
-#ifdef CONFIG_ADB_PMU
-static time64_t pmu_get_time(void)
-{
-	struct adb_request req;
-	time64_t now;
-
-	if (pmu_request(&req, NULL, 1, PMU_READ_RTC) < 0)
-		return 0;
-	pmu_wait_complete(&req);
-	if (req.reply_len != 4)
-		printk(KERN_ERR "pmu_get_time: got %d byte reply from PMU\n",
-		       req.reply_len);
-	now = (u32)((req.reply[0] << 24) + (req.reply[1] << 16)	+
-		    (req.reply[2] << 8) + req.reply[3]);
-
-	/* it's either after year 2040, or the RTC has gone backwards */
-	WARN_ON(now < RTC_OFFSET);
-
-	return now - RTC_OFFSET;
-}
-
-#define pmu_get_rtc_time(tm)	rtc_time64_to_tm(pmu_get_time(), (tm))
-
-static int pmu_set_rtc_time(struct rtc_time *tm)
-{
-	u32 nowtime;
-	struct adb_request req;
-
-	nowtime = lower_32_bits(rtc_tm_to_time64(tm) + RTC_OFFSET);
-	if (pmu_request(&req, NULL, 5, PMU_SET_RTC, nowtime >> 24,
-			nowtime >> 16, nowtime >> 8, nowtime) < 0)
-		return -ENXIO;
-	pmu_wait_complete(&req);
-	if (req.reply_len != 0)
-		printk(KERN_ERR "pmu_set_rtc_time: %d byte reply from PMU\n",
-		       req.reply_len);
-	return 0;
-}
-
-#else
-#define pmu_get_time()		0
-#define pmu_get_rtc_time(tm)
-#define pmu_set_rtc_time(tm)	0
-#endif
-
 #ifdef CONFIG_PMAC_SMU
 static time64_t smu_get_time(void)
 {
@@ -189,11 +90,6 @@ static time64_t smu_get_time(void)
 		return 0;
 	return rtc_tm_to_time64(&tm);
 }
-
-#else
-#define smu_get_time()			0
-#define smu_get_rtc_time(tm, spin)
-#define smu_set_rtc_time(tm, spin)	0
 #endif
 
 /* Can't be __init, it's called when suspending and resuming */
@@ -201,12 +97,18 @@ time64_t pmac_get_boot_time(void)
 {
 	/* Get the time from the RTC, used only at boot time */
 	switch (sys_ctrler) {
+#ifdef CONFIG_ADB_CUDA
 	case SYS_CTRLER_CUDA:
 		return cuda_get_time();
+#endif
+#ifdef CONFIG_ADB_PMU
 	case SYS_CTRLER_PMU:
 		return pmu_get_time();
+#endif
+#ifdef CONFIG_PMAC_SMU
 	case SYS_CTRLER_SMU:
 		return smu_get_time();
+#endif
 	default:
 		return 0;
 	}
@@ -215,30 +117,24 @@ time64_t pmac_get_boot_time(void)
 void pmac_get_rtc_time(struct rtc_time *tm)
 {
 	/* Get the time from the RTC, used only at boot time */
-	switch (sys_ctrler) {
-	case SYS_CTRLER_CUDA:
-		cuda_get_rtc_time(tm);
-		break;
-	case SYS_CTRLER_PMU:
-		pmu_get_rtc_time(tm);
-		break;
-	case SYS_CTRLER_SMU:
-		smu_get_rtc_time(tm, 1);
-		break;
-	default:
-		;
-	}
+	rtc_time64_to_tm(pmac_get_boot_time(), tm);
 }
 
 int pmac_set_rtc_time(struct rtc_time *tm)
 {
 	switch (sys_ctrler) {
+#ifdef CONFIG_ADB_CUDA
 	case SYS_CTRLER_CUDA:
 		return cuda_set_rtc_time(tm);
+#endif
+#ifdef CONFIG_ADB_PMU
 	case SYS_CTRLER_PMU:
 		return pmu_set_rtc_time(tm);
+#endif
+#ifdef CONFIG_PMAC_SMU
 	case SYS_CTRLER_SMU:
 		return smu_set_rtc_time(tm, 1);
+#endif
 	default:
 		return -ENODEV;
 	}
diff --git a/drivers/macintosh/via-cuda.c b/drivers/macintosh/via-cuda.c
index 98dd702eb867..bbd5a81ba262 100644
--- a/drivers/macintosh/via-cuda.c
+++ b/drivers/macintosh/via-cuda.c
@@ -766,3 +766,38 @@ cuda_input(unsigned char *buf, int nb)
 	               buf, nb, false);
     }
 }
+
+/* Offset between Unix time (1970-based) and Mac time (1904-based) */
+#define RTC_OFFSET	2082844800
+
+time64_t cuda_get_time(void)
+{
+	struct adb_request req;
+	time64_t now;
+
+	if (cuda_request(&req, NULL, 2, CUDA_PACKET, CUDA_GET_TIME) < 0)
+		return 0;
+	while (!req.complete)
+		cuda_poll();
+	if (req.reply_len != 7)
+		pr_err("%s: got %d byte reply\n", __func__, req.reply_len);
+	now = (u32)((req.reply[3] << 24) + (req.reply[4] << 16) +
+	            (req.reply[5] << 8) + req.reply[6]);
+	return now - RTC_OFFSET;
+}
+
+int cuda_set_rtc_time(struct rtc_time *tm)
+{
+	u32 now;
+	struct adb_request req;
+
+	now = lower_32_bits(rtc_tm_to_time64(tm) + RTC_OFFSET);
+	if (cuda_request(&req, NULL, 6, CUDA_PACKET, CUDA_SET_TIME,
+	                 now >> 24, now >> 16, now >> 8, now) < 0)
+		return -ENXIO;
+	while (!req.complete)
+		cuda_poll();
+	if ((req.reply_len != 3) && (req.reply_len != 7))
+		pr_err("%s: got %d byte reply\n", __func__, req.reply_len);
+	return 0;
+}
diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index d72c450aebe5..48eaa770f0f6 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -1737,6 +1737,39 @@ pmu_enable_irled(int on)
 	pmu_wait_complete(&req);
 }
 
+/* Offset between Unix time (1970-based) and Mac time (1904-based) */
+#define RTC_OFFSET	2082844800
+
+time64_t pmu_get_time(void)
+{
+	struct adb_request req;
+	time64_t now;
+
+	if (pmu_request(&req, NULL, 1, PMU_READ_RTC) < 0)
+		return 0;
+	pmu_wait_complete(&req);
+	if (req.reply_len != 4)
+		pr_err("%s: got %d byte reply\n", __func__, req.reply_len);
+	now = (u32)((req.reply[0] << 24) + (req.reply[1] << 16)	+
+	            (req.reply[2] << 8) + req.reply[3]);
+	return now - RTC_OFFSET;
+}
+
+int pmu_set_rtc_time(struct rtc_time *tm)
+{
+	u32 now;
+	struct adb_request req;
+
+	now = lower_32_bits(rtc_tm_to_time64(tm) + RTC_OFFSET);
+	if (pmu_request(&req, NULL, 5, PMU_SET_RTC,
+	                now >> 24, now >> 16, now >> 8, now) < 0)
+		return -ENXIO;
+	pmu_wait_complete(&req);
+	if (req.reply_len != 0)
+		pr_err("%s: got %d byte reply\n", __func__, req.reply_len);
+	return 0;
+}
+
 void
 pmu_restart(void)
 {
diff --git a/include/linux/cuda.h b/include/linux/cuda.h
index 056867f09a01..45bfe9d61271 100644
--- a/include/linux/cuda.h
+++ b/include/linux/cuda.h
@@ -8,6 +8,7 @@
 #ifndef _LINUX_CUDA_H
 #define _LINUX_CUDA_H
 
+#include <linux/rtc.h>
 #include <uapi/linux/cuda.h>
 
 
@@ -16,4 +17,7 @@ extern int cuda_request(struct adb_request *req,
 			void (*done)(struct adb_request *), int nbytes, ...);
 extern void cuda_poll(void);
 
+extern time64_t cuda_get_time(void);
+extern int cuda_set_rtc_time(struct rtc_time *tm);
+
 #endif /* _LINUX_CUDA_H */
diff --git a/include/linux/pmu.h b/include/linux/pmu.h
index 9ac8fc60ad49..52453a24a24f 100644
--- a/include/linux/pmu.h
+++ b/include/linux/pmu.h
@@ -9,6 +9,7 @@
 #ifndef _LINUX_PMU_H
 #define _LINUX_PMU_H
 
+#include <linux/rtc.h>
 #include <uapi/linux/pmu.h>
 
 
@@ -36,6 +37,9 @@ static inline void pmu_resume(void)
 
 extern void pmu_enable_irled(int on);
 
+extern time64_t pmu_get_time(void);
+extern int pmu_set_rtc_time(struct rtc_time *tm);
+
 extern void pmu_restart(void);
 extern void pmu_shutdown(void);
 extern void pmu_unlock(void);
-- 
2.16.4
