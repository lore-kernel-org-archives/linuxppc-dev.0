Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 40yRV51VxtzF0Tj
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 13:27:57 +1000 (AEST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Paul Mackerras <paulus@samba.org>,, Michael Ellerman <mpe@ellerman.id.au>
Message-Id: <ddfa9261a77d747e6523dd5cc0df84cc555dc440.1527909627.git.fthain@telegraphics.com.au>
In-Reply-To: <de8edb03dbd2fd25b53d0bdf9c6d65adf9aa0aa3.1527909627.git.fthain@telegraphics.com.au>
References: <cover.1527909627.git.fthain@telegraphics.com.au>
 <f32f4e3a0fd736152f768b7a00bfc731daba1629.1527909627.git.fthain@telegraphics.com.au>
 <7ce9a8c3996506ae6f9ab16b3cf73c287e205a89.1527909627.git.fthain@telegraphics.com.au>
 <8597ac466215f573d8bea40e74fdec2bf72fabbb.1527909627.git.fthain@telegraphics.com.au>
 <878b389293851359e53de186bf302ce52d95ad95.1527909627.git.fthain@telegraphics.com.au>
 <adba0545c06cd6c67e26c433990d036b0d7e968c.1527909627.git.fthain@telegraphics.com.au>
 <166b4c3a7347fe27f12bda86d50533cd01ee11b9.1527909627.git.fthain@telegraphics.com.au>
 <73507a3e9444da17c222cf74df41842ce30d15ee.1527909627.git.fthain@telegraphics.com.au>
 <de8edb03dbd2fd25b53d0bdf9c6d65adf9aa0aa3.1527909627.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 09/11] macintosh: Use common code to access RTC
Date: Fri,  1 Jun 2018 23:27:51 -0400 (EDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that the 68k Mac port has adopted the via-pmu driver, it must access
the PMU RTC using the appropriate command format. The same code can now
be used for both m68k and powerpc.

Replace the RTC code that's duplicated in arch/powerpc and arch/m68k
with common RTC accessors for Cuda and PMU devices.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Mackerras <paulus@samba.org>,
Cc: Michael Ellerman <mpe@ellerman.id.au>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/mac/misc.c                   | 64 ++---------------------------
 arch/powerpc/platforms/powermac/time.c | 74 +---------------------------------
 drivers/macintosh/via-cuda.c           | 34 ++++++++++++++++
 drivers/macintosh/via-pmu.c            | 32 +++++++++++++++
 include/linux/cuda.h                   |  3 ++
 include/linux/pmu.h                    |  3 ++
 6 files changed, 78 insertions(+), 132 deletions(-)

diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index 28090a44fa09..397f9f942a9f 100644
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
@@ -635,12 +579,12 @@ int mac_hwclk(int op, struct rtc_time *t)
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
@@ -671,12 +615,12 @@ int mac_hwclk(int op, struct rtc_time *t)
 #ifdef CONFIG_ADB_CUDA
 		case MAC_ADB_EGRET:
 		case MAC_ADB_CUDA:
-			cuda_write_time(now);
+			cuda_set_time(now);
 			break;
 #endif
 #ifdef CONFIG_ADB_PMU
 		case MAC_ADB_PB2:
-			pmu_write_time(now);
+			pmu_set_time(now);
 			break;
 #endif
 		default:
diff --git a/arch/powerpc/platforms/powermac/time.c b/arch/powerpc/platforms/powermac/time.c
index 274af6fa388e..e9c1f3dafe2f 100644
--- a/arch/powerpc/platforms/powermac/time.c
+++ b/arch/powerpc/platforms/powermac/time.c
@@ -42,9 +42,6 @@
 #define DBG(x...)
 #endif
 
-/* Apparently the RTC stores seconds since 1 Jan 1904 */
-#define RTC_OFFSET	2082844800
-
 /*
  * Calibrate the decrementer frequency with the VIA timer 1.
  */
@@ -103,43 +100,8 @@ static unsigned long from_rtc_time(struct rtc_time *tm)
 #endif
 
 #ifdef CONFIG_ADB_CUDA
-static unsigned long cuda_get_time(void)
-{
-	struct adb_request req;
-	unsigned int now;
-
-	if (cuda_request(&req, NULL, 2, CUDA_PACKET, CUDA_GET_TIME) < 0)
-		return 0;
-	while (!req.complete)
-		cuda_poll();
-	if (req.reply_len != 7)
-		printk(KERN_ERR "cuda_get_time: got %d byte reply\n",
-		       req.reply_len);
-	now = (req.reply[3] << 24) + (req.reply[4] << 16)
-		+ (req.reply[5] << 8) + req.reply[6];
-	return ((unsigned long)now) - RTC_OFFSET;
-}
-
 #define cuda_get_rtc_time(tm)	to_rtc_time(cuda_get_time(), (tm))
-
-static int cuda_set_rtc_time(struct rtc_time *tm)
-{
-	unsigned int nowtime;
-	struct adb_request req;
-
-	nowtime = from_rtc_time(tm) + RTC_OFFSET;
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
+#define cuda_set_rtc_time(tm)	cuda_set_time(from_rtc_time(tm))
 #else
 #define cuda_get_time()		0
 #define cuda_get_rtc_time(tm)
@@ -147,40 +109,8 @@ static int cuda_set_rtc_time(struct rtc_time *tm)
 #endif
 
 #ifdef CONFIG_ADB_PMU
-static unsigned long pmu_get_time(void)
-{
-	struct adb_request req;
-	unsigned int now;
-
-	if (pmu_request(&req, NULL, 1, PMU_READ_RTC) < 0)
-		return 0;
-	pmu_wait_complete(&req);
-	if (req.reply_len != 4)
-		printk(KERN_ERR "pmu_get_time: got %d byte reply from PMU\n",
-		       req.reply_len);
-	now = (req.reply[0] << 24) + (req.reply[1] << 16)
-		+ (req.reply[2] << 8) + req.reply[3];
-	return ((unsigned long)now) - RTC_OFFSET;
-}
-
 #define pmu_get_rtc_time(tm)	to_rtc_time(pmu_get_time(), (tm))
-
-static int pmu_set_rtc_time(struct rtc_time *tm)
-{
-	unsigned int nowtime;
-	struct adb_request req;
-
-	nowtime = from_rtc_time(tm) + RTC_OFFSET;
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
+#define pmu_set_rtc_time(tm)	pmu_set_time(from_rtc_time(tm))
 #else
 #define pmu_get_time()		0
 #define pmu_get_rtc_time(tm)
diff --git a/drivers/macintosh/via-cuda.c b/drivers/macintosh/via-cuda.c
index 019556136e77..8e7fb2115f10 100644
--- a/drivers/macintosh/via-cuda.c
+++ b/drivers/macintosh/via-cuda.c
@@ -771,3 +771,37 @@ cuda_input(unsigned char *buf, int nb)
 	               buf, nb, false);
     }
 }
+
+/* Offset between Unix time (1970-based) and Mac time (1904-based) */
+#define RTC_OFFSET	2082844800
+
+unsigned long cuda_get_time(void)
+{
+	struct adb_request req;
+	unsigned long now;
+
+	if (cuda_request(&req, NULL, 2, CUDA_PACKET, CUDA_GET_TIME) < 0)
+		return 0;
+	while (!req.complete)
+		cuda_poll();
+	if (req.reply_len != 7)
+		pr_err("%s: got %d byte reply\n", __func__, req.reply_len);
+	now = (req.reply[3] << 24) + (req.reply[4] << 16) +
+	      (req.reply[5] << 8) + req.reply[6];
+	return now - RTC_OFFSET;
+}
+
+int cuda_set_time(unsigned long now)
+{
+	struct adb_request req;
+
+	now += RTC_OFFSET;
+	if (cuda_request(&req, NULL, 6, CUDA_PACKET, CUDA_SET_TIME,
+			now >> 24, now >> 16, now >> 8, now) < 0)
+		return -ENXIO;
+	while (!req.complete)
+		cuda_poll();
+	if ((req.reply_len != 3) && (req.reply_len != 7))
+		pr_err("%s: got %d byte reply\n", __func__, req.reply_len);
+	return 0;
+}
diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 19a27ed49721..3cbccd346997 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -1820,6 +1820,38 @@ pmu_shutdown(void)
 		;
 }
 
+/* Offset between Unix time (1970-based) and Mac time (1904-based) */
+#define RTC_OFFSET	2082844800
+
+unsigned long pmu_get_time(void)
+{
+	struct adb_request req;
+	unsigned long now;
+
+	if (pmu_request(&req, NULL, 1, PMU_READ_RTC) < 0)
+		return 0;
+	pmu_wait_complete(&req);
+	if (req.reply_len != 4)
+		pr_err("%s: got %d byte reply\n", __func__, req.reply_len);
+	now = (req.reply[0] << 24) + (req.reply[1] << 16) +
+	      (req.reply[2] << 8) + req.reply[3];
+	return now - RTC_OFFSET;
+}
+
+int pmu_set_time(unsigned long now)
+{
+	struct adb_request req;
+
+	now += RTC_OFFSET;
+	if (pmu_request(&req, NULL, 5, PMU_SET_RTC,
+			now >> 24, now >> 16, now >> 8, now) < 0)
+		return -ENXIO;
+	pmu_wait_complete(&req);
+	if (req.reply_len != 0)
+		pr_err("%s: got %d byte reply\n", __func__, req.reply_len);
+	return 0;
+}
+
 int
 pmu_present(void)
 {
diff --git a/include/linux/cuda.h b/include/linux/cuda.h
index 056867f09a01..a68669f746e1 100644
--- a/include/linux/cuda.h
+++ b/include/linux/cuda.h
@@ -16,4 +16,7 @@ extern int cuda_request(struct adb_request *req,
 			void (*done)(struct adb_request *), int nbytes, ...);
 extern void cuda_poll(void);
 
+extern unsigned long cuda_get_time(void);
+extern int cuda_set_time(unsigned long now);
+
 #endif /* _LINUX_CUDA_H */
diff --git a/include/linux/pmu.h b/include/linux/pmu.h
index 9ac8fc60ad49..feefd0bff9cf 100644
--- a/include/linux/pmu.h
+++ b/include/linux/pmu.h
@@ -34,6 +34,9 @@ static inline void pmu_resume(void)
 {}
 #endif
 
+extern unsigned long pmu_get_time(void);
+extern int pmu_set_time(unsigned long now);
+
 extern void pmu_enable_irled(int on);
 
 extern void pmu_restart(void);
-- 
2.16.1
