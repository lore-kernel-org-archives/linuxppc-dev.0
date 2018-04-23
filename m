Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40V0Fg05P1zF24T
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 18:37:25 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 y2038@lists.linaro.org, arnd@arndb.de
Subject: [PATCH 3/5] powerpc: use time64_t in read_persistent_clock
Date: Mon, 23 Apr 2018 10:36:40 +0200
Message-Id: <20180423083642.2608886-3-arnd@arndb.de>
In-Reply-To: <20180423083642.2608886-1-arnd@arndb.de>
References: <20180423083642.2608886-1-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Looking through the remaining users of the deprecated mktime()
function, I found the powerpc rtc handlers, which use it in
place of rtc_tm_to_time64().

To clean this up, I'm changing over the read_persistent_clock()
function to the read_persistent_clock64() variant, and change
all the platform specific handlers along with it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: fix a typo: rtc_tm_to_time66 -> rtc_tm_to_time64
---
 arch/powerpc/include/asm/machdep.h        |  2 +-
 arch/powerpc/include/asm/opal.h           |  2 +-
 arch/powerpc/include/asm/rtas.h           |  2 +-
 arch/powerpc/kernel/rtas-rtc.c            |  4 ++--
 arch/powerpc/kernel/time.c                |  7 +++----
 arch/powerpc/platforms/8xx/m8xx_setup.c   |  4 +---
 arch/powerpc/platforms/maple/maple.h      |  2 +-
 arch/powerpc/platforms/maple/time.c       |  5 ++---
 arch/powerpc/platforms/pasemi/pasemi.h    |  2 +-
 arch/powerpc/platforms/pasemi/time.c      |  4 ++--
 arch/powerpc/platforms/powermac/pmac.h    |  2 +-
 arch/powerpc/platforms/powermac/time.c    | 31 +++++++++++--------------------
 arch/powerpc/platforms/powernv/opal-rtc.c |  5 ++---
 arch/powerpc/platforms/ps3/platform.h     |  2 +-
 arch/powerpc/platforms/ps3/time.c         |  2 +-
 15 files changed, 31 insertions(+), 45 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index ffe7c71e1132..a47de82fb8e2 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -83,7 +83,7 @@ struct machdep_calls {
 
 	int		(*set_rtc_time)(struct rtc_time *);
 	void		(*get_rtc_time)(struct rtc_time *);
-	unsigned long	(*get_boot_time)(void);
+	time64_t	(*get_boot_time)(void);
 	unsigned char 	(*rtc_read_val)(int addr);
 	void		(*rtc_write_val)(int addr, unsigned char val);
 
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 03e1a920491e..fc211bd98e0f 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -325,7 +325,7 @@ extern int opal_async_wait_response_interruptible(uint64_t token,
 extern int opal_get_sensor_data(u32 sensor_hndl, u32 *sensor_data);
 
 struct rtc_time;
-extern unsigned long opal_get_boot_time(void);
+extern time64_t opal_get_boot_time(void);
 extern void opal_nvram_init(void);
 extern void opal_flash_update_init(void);
 extern void opal_flash_update_print_message(void);
diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index ec9dd79398ee..71e393c46a49 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -361,7 +361,7 @@ extern int rtas_offline_cpus_mask(cpumask_var_t cpus);
 extern int rtas_ibm_suspend_me(u64 handle);
 
 struct rtc_time;
-extern unsigned long rtas_get_boot_time(void);
+extern time64_t rtas_get_boot_time(void);
 extern void rtas_get_rtc_time(struct rtc_time *rtc_time);
 extern int rtas_set_rtc_time(struct rtc_time *rtc_time);
 
diff --git a/arch/powerpc/kernel/rtas-rtc.c b/arch/powerpc/kernel/rtas-rtc.c
index 49600985c7ef..a28239b8b0c0 100644
--- a/arch/powerpc/kernel/rtas-rtc.c
+++ b/arch/powerpc/kernel/rtas-rtc.c
@@ -13,7 +13,7 @@
 
 #define MAX_RTC_WAIT 5000	/* 5 sec */
 #define RTAS_CLOCK_BUSY (-2)
-unsigned long __init rtas_get_boot_time(void)
+time64_t __init rtas_get_boot_time(void)
 {
 	int ret[8];
 	int error;
@@ -38,7 +38,7 @@ unsigned long __init rtas_get_boot_time(void)
 		return 0;
 	}
 
-	return mktime(ret[0], ret[1], ret[2], ret[3], ret[4], ret[5]);
+	return mktime64(ret[0], ret[1], ret[2], ret[3], ret[4], ret[5]);
 }
 
 /* NOTE: get_rtc_time will get an error if executed in interrupt context
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 360e71d455cc..afb27962b396 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -795,7 +795,7 @@ int update_persistent_clock(struct timespec now)
 	return ppc_md.set_rtc_time(&tm);
 }
 
-static void __read_persistent_clock(struct timespec *ts)
+static void __read_persistent_clock(struct timespec64 *ts)
 {
 	struct rtc_time tm;
 	static int first = 1;
@@ -819,11 +819,10 @@ static void __read_persistent_clock(struct timespec *ts)
 	}
 	ppc_md.get_rtc_time(&tm);
 
-	ts->tv_sec = mktime(tm.tm_year+1900, tm.tm_mon+1, tm.tm_mday,
-			    tm.tm_hour, tm.tm_min, tm.tm_sec);
+	ts->tv_sec = rtc_tm_to_time64(&tm);
 }
 
-void read_persistent_clock(struct timespec *ts)
+void read_persistent_clock64(struct timespec64 *ts)
 {
 	__read_persistent_clock(ts);
 
diff --git a/arch/powerpc/platforms/8xx/m8xx_setup.c b/arch/powerpc/platforms/8xx/m8xx_setup.c
index 2188d691a40f..d76daa90647b 100644
--- a/arch/powerpc/platforms/8xx/m8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -192,9 +192,7 @@ void mpc8xx_get_rtc_time(struct rtc_time *tm)
 
 	/* Get time from the RTC. */
 	data = in_be32(&sys_tmr->sit_rtc);
-	to_tm(data, tm);
-	tm->tm_year -= 1900;
-	tm->tm_mon -= 1;
+	rtc_time64_to_tm(data, tm);
 	immr_unmap(sys_tmr);
 	return;
 }
diff --git a/arch/powerpc/platforms/maple/maple.h b/arch/powerpc/platforms/maple/maple.h
index d10f4af3a42e..4f358b55c341 100644
--- a/arch/powerpc/platforms/maple/maple.h
+++ b/arch/powerpc/platforms/maple/maple.h
@@ -6,7 +6,7 @@
  */
 extern int maple_set_rtc_time(struct rtc_time *tm);
 extern void maple_get_rtc_time(struct rtc_time *tm);
-extern unsigned long maple_get_boot_time(void);
+extern time64_t maple_get_boot_time(void);
 extern void maple_calibrate_decr(void);
 extern void maple_pci_init(void);
 extern void maple_pci_irq_fixup(struct pci_dev *dev);
diff --git a/arch/powerpc/platforms/maple/time.c b/arch/powerpc/platforms/maple/time.c
index cfddc87f81bf..becf2ebf7df5 100644
--- a/arch/powerpc/platforms/maple/time.c
+++ b/arch/powerpc/platforms/maple/time.c
@@ -137,7 +137,7 @@ static struct resource rtc_iores = {
 	.flags = IORESOURCE_IO | IORESOURCE_BUSY,
 };
 
-unsigned long __init maple_get_boot_time(void)
+time64_t __init maple_get_boot_time(void)
 {
 	struct rtc_time tm;
 	struct device_node *rtcs;
@@ -170,7 +170,6 @@ unsigned long __init maple_get_boot_time(void)
 	request_resource(&ioport_resource, &rtc_iores);
 
 	maple_get_rtc_time(&tm);
-	return mktime(tm.tm_year+1900, tm.tm_mon+1, tm.tm_mday,
-		      tm.tm_hour, tm.tm_min, tm.tm_sec);
+	return rtc_tm_to_time64(&tm);
 }
 
diff --git a/arch/powerpc/platforms/pasemi/pasemi.h b/arch/powerpc/platforms/pasemi/pasemi.h
index 329d2a619254..70b56048ed1b 100644
--- a/arch/powerpc/platforms/pasemi/pasemi.h
+++ b/arch/powerpc/platforms/pasemi/pasemi.h
@@ -2,7 +2,7 @@
 #ifndef _PASEMI_PASEMI_H
 #define _PASEMI_PASEMI_H
 
-extern unsigned long pas_get_boot_time(void);
+extern time64_t pas_get_boot_time(void);
 extern void pas_pci_init(void);
 extern void pas_pci_irq_fixup(struct pci_dev *dev);
 extern void pas_pci_dma_dev_setup(struct pci_dev *dev);
diff --git a/arch/powerpc/platforms/pasemi/time.c b/arch/powerpc/platforms/pasemi/time.c
index fa54351ac268..ea815254ee7b 100644
--- a/arch/powerpc/platforms/pasemi/time.c
+++ b/arch/powerpc/platforms/pasemi/time.c
@@ -21,8 +21,8 @@
 
 #include <asm/time.h>
 
-unsigned long __init pas_get_boot_time(void)
+time64_t __init pas_get_boot_time(void)
 {
 	/* Let's just return a fake date right now */
-	return mktime(2006, 1, 1, 12, 0, 0);
+	return mktime64(2006, 1, 1, 12, 0, 0);
 }
diff --git a/arch/powerpc/platforms/powermac/pmac.h b/arch/powerpc/platforms/powermac/pmac.h
index 6f15b8804e9b..16a52afdb76e 100644
--- a/arch/powerpc/platforms/powermac/pmac.h
+++ b/arch/powerpc/platforms/powermac/pmac.h
@@ -15,7 +15,7 @@ struct rtc_time;
 extern int pmac_newworld;
 
 extern long pmac_time_init(void);
-extern unsigned long pmac_get_boot_time(void);
+extern time64_t pmac_get_boot_time(void);
 extern void pmac_get_rtc_time(struct rtc_time *);
 extern int pmac_set_rtc_time(struct rtc_time *);
 extern void pmac_read_rtc_time(void);
diff --git a/arch/powerpc/platforms/powermac/time.c b/arch/powerpc/platforms/powermac/time.c
index 274af6fa388e..d5d1c452038e 100644
--- a/arch/powerpc/platforms/powermac/time.c
+++ b/arch/powerpc/platforms/powermac/time.c
@@ -84,15 +84,6 @@ long __init pmac_time_init(void)
 	return delta;
 }
 
-#if defined(CONFIG_ADB_CUDA) || defined(CONFIG_ADB_PMU)
-static void to_rtc_time(unsigned long now, struct rtc_time *tm)
-{
-	to_tm(now, tm);
-	tm->tm_year -= 1900;
-	tm->tm_mon -= 1;
-}
-#endif
-
 #if defined(CONFIG_ADB_CUDA) || defined(CONFIG_ADB_PMU) || \
     defined(CONFIG_PMAC_SMU)
 static unsigned long from_rtc_time(struct rtc_time *tm)
@@ -103,10 +94,10 @@ static unsigned long from_rtc_time(struct rtc_time *tm)
 #endif
 
 #ifdef CONFIG_ADB_CUDA
-static unsigned long cuda_get_time(void)
+static time64_t cuda_get_time(void)
 {
 	struct adb_request req;
-	unsigned int now;
+	time64_t now;
 
 	if (cuda_request(&req, NULL, 2, CUDA_PACKET, CUDA_GET_TIME) < 0)
 		return 0;
@@ -117,10 +108,10 @@ static unsigned long cuda_get_time(void)
 		       req.reply_len);
 	now = (req.reply[3] << 24) + (req.reply[4] << 16)
 		+ (req.reply[5] << 8) + req.reply[6];
-	return ((unsigned long)now) - RTC_OFFSET;
+	return now - RTC_OFFSET;
 }
 
-#define cuda_get_rtc_time(tm)	to_rtc_time(cuda_get_time(), (tm))
+#define cuda_get_rtc_time(tm)	rtc_time64_to_tm(cuda_get_time(), (tm))
 
 static int cuda_set_rtc_time(struct rtc_time *tm)
 {
@@ -147,10 +138,10 @@ static int cuda_set_rtc_time(struct rtc_time *tm)
 #endif
 
 #ifdef CONFIG_ADB_PMU
-static unsigned long pmu_get_time(void)
+static time64_t pmu_get_time(void)
 {
 	struct adb_request req;
-	unsigned int now;
+	time64_t now;
 
 	if (pmu_request(&req, NULL, 1, PMU_READ_RTC) < 0)
 		return 0;
@@ -160,10 +151,10 @@ static unsigned long pmu_get_time(void)
 		       req.reply_len);
 	now = (req.reply[0] << 24) + (req.reply[1] << 16)
 		+ (req.reply[2] << 8) + req.reply[3];
-	return ((unsigned long)now) - RTC_OFFSET;
+	return now - RTC_OFFSET;
 }
 
-#define pmu_get_rtc_time(tm)	to_rtc_time(pmu_get_time(), (tm))
+#define pmu_get_rtc_time(tm)	rtc_time64_to_tm(pmu_get_time(), (tm))
 
 static int pmu_set_rtc_time(struct rtc_time *tm)
 {
@@ -188,13 +179,13 @@ static int pmu_set_rtc_time(struct rtc_time *tm)
 #endif
 
 #ifdef CONFIG_PMAC_SMU
-static unsigned long smu_get_time(void)
+static time64_t smu_get_time(void)
 {
 	struct rtc_time tm;
 
 	if (smu_get_rtc_time(&tm, 1))
 		return 0;
-	return from_rtc_time(&tm);
+	return rtc_tm_to_time64(&tm);
 }
 
 #else
@@ -204,7 +195,7 @@ static unsigned long smu_get_time(void)
 #endif
 
 /* Can't be __init, it's called when suspending and resuming */
-unsigned long pmac_get_boot_time(void)
+time64_t pmac_get_boot_time(void)
 {
 	/* Get the time from the RTC, used only at boot time */
 	switch (sys_ctrler) {
diff --git a/arch/powerpc/platforms/powernv/opal-rtc.c b/arch/powerpc/platforms/powernv/opal-rtc.c
index f8868864f373..f515c4a76900 100644
--- a/arch/powerpc/platforms/powernv/opal-rtc.c
+++ b/arch/powerpc/platforms/powernv/opal-rtc.c
@@ -34,7 +34,7 @@ static void opal_to_tm(u32 y_m_d, u64 h_m_s_ms, struct rtc_time *tm)
 	tm->tm_wday     = -1;
 }
 
-unsigned long __init opal_get_boot_time(void)
+time64_t __init opal_get_boot_time(void)
 {
 	struct rtc_time tm;
 	u32 y_m_d;
@@ -59,8 +59,7 @@ unsigned long __init opal_get_boot_time(void)
 	y_m_d = be32_to_cpu(__y_m_d);
 	h_m_s_ms = be64_to_cpu(__h_m_s_ms);
 	opal_to_tm(y_m_d, h_m_s_ms, &tm);
-	return mktime(tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
-		      tm.tm_hour, tm.tm_min, tm.tm_sec);
+	return rtc_tm_to_time64(&tm);
 }
 
 static __init int opal_time_init(void)
diff --git a/arch/powerpc/platforms/ps3/platform.h b/arch/powerpc/platforms/ps3/platform.h
index 1809cfc562ee..9bc68f913466 100644
--- a/arch/powerpc/platforms/ps3/platform.h
+++ b/arch/powerpc/platforms/ps3/platform.h
@@ -57,7 +57,7 @@ static inline void ps3_smp_cleanup_cpu(int cpu) { }
 /* time */
 
 void __init ps3_calibrate_decr(void);
-unsigned long __init ps3_get_boot_time(void);
+time64_t __init ps3_get_boot_time(void);
 void ps3_get_rtc_time(struct rtc_time *time);
 int ps3_set_rtc_time(struct rtc_time *time);
 
diff --git a/arch/powerpc/platforms/ps3/time.c b/arch/powerpc/platforms/ps3/time.c
index 11b45b58c81b..9dac125c997e 100644
--- a/arch/powerpc/platforms/ps3/time.c
+++ b/arch/powerpc/platforms/ps3/time.c
@@ -76,7 +76,7 @@ static u64 read_rtc(void)
 	return rtc_val;
 }
 
-unsigned long __init ps3_get_boot_time(void)
+time64_t __init ps3_get_boot_time(void)
 {
 	return read_rtc() + ps3_os_area_get_rtc_diff();
 }
-- 
2.9.0
