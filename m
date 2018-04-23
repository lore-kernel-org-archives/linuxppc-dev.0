Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40V0FT0QjNzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 18:37:16 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 y2038@lists.linaro.org, arnd@arndb.de
Subject: [PATCH 4/5] powerpc: use time64_t in update_persistent_clock
Date: Mon, 23 Apr 2018 10:36:41 +0200
Message-Id: <20180423083642.2608886-4-arnd@arndb.de>
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

update_persistent_clock() is deprecated because it suffers from overflow
in 2038 on 32-bit architectures. This changes powerpc to use the
update_persistent_clock64() replacement, and to pass down 64-bit
timestamps consistently.

This is now simpler, as we no longer have to worry about the offset
numbers in tm_year and tm_mon that are different between the Linux
conventions and RTAS.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/kernel/time.c              |  6 ++----
 arch/powerpc/platforms/8xx/m8xx_setup.c |  7 +++----
 arch/powerpc/platforms/powermac/time.c  | 17 ++++-------------
 3 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index afb27962b396..f9b0baa3fa2b 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -781,16 +781,14 @@ void __init generic_calibrate_decr(void)
 	}
 }
 
-int update_persistent_clock(struct timespec now)
+int update_persistent_clock64(struct timespec64 now)
 {
 	struct rtc_time tm;
 
 	if (!ppc_md.set_rtc_time)
 		return -ENODEV;
 
-	to_tm(now.tv_sec + 1 + timezone_offset, &tm);
-	tm.tm_year -= 1900;
-	tm.tm_mon -= 1;
+	rtc_time64_to_tm(now.tv_sec + 1 + timezone_offset, &tm);
 
 	return ppc_md.set_rtc_time(&tm);
 }
diff --git a/arch/powerpc/platforms/8xx/m8xx_setup.c b/arch/powerpc/platforms/8xx/m8xx_setup.c
index d76daa90647b..027c42d8966c 100644
--- a/arch/powerpc/platforms/8xx/m8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -169,15 +169,14 @@ int mpc8xx_set_rtc_time(struct rtc_time *tm)
 {
 	sitk8xx_t __iomem *sys_tmr1;
 	sit8xx_t __iomem *sys_tmr2;
-	int time;
+	time64_t time;
 
 	sys_tmr1 = immr_map(im_sitk);
 	sys_tmr2 = immr_map(im_sit);
-	time = mktime(tm->tm_year+1900, tm->tm_mon+1, tm->tm_mday,
-	              tm->tm_hour, tm->tm_min, tm->tm_sec);
+	time = rtc_tm_to_time64(tm);
 
 	out_be32(&sys_tmr1->sitk_rtck, KAPWR_KEY);
-	out_be32(&sys_tmr2->sit_rtc, time);
+	out_be32(&sys_tmr2->sit_rtc, (u32)time);
 	out_be32(&sys_tmr1->sitk_rtck, ~KAPWR_KEY);
 
 	immr_unmap(sys_tmr2);
diff --git a/arch/powerpc/platforms/powermac/time.c b/arch/powerpc/platforms/powermac/time.c
index d5d1c452038e..7c968e46736f 100644
--- a/arch/powerpc/platforms/powermac/time.c
+++ b/arch/powerpc/platforms/powermac/time.c
@@ -84,15 +84,6 @@ long __init pmac_time_init(void)
 	return delta;
 }
 
-#if defined(CONFIG_ADB_CUDA) || defined(CONFIG_ADB_PMU) || \
-    defined(CONFIG_PMAC_SMU)
-static unsigned long from_rtc_time(struct rtc_time *tm)
-{
-	return mktime(tm->tm_year+1900, tm->tm_mon+1, tm->tm_mday,
-		      tm->tm_hour, tm->tm_min, tm->tm_sec);
-}
-#endif
-
 #ifdef CONFIG_ADB_CUDA
 static time64_t cuda_get_time(void)
 {
@@ -115,10 +106,10 @@ static time64_t cuda_get_time(void)
 
 static int cuda_set_rtc_time(struct rtc_time *tm)
 {
-	unsigned int nowtime;
+	time64_t nowtime;
 	struct adb_request req;
 
-	nowtime = from_rtc_time(tm) + RTC_OFFSET;
+	nowtime = rtc_tm_to_time64(tm) + RTC_OFFSET;
 	if (cuda_request(&req, NULL, 6, CUDA_PACKET, CUDA_SET_TIME,
 			 nowtime >> 24, nowtime >> 16, nowtime >> 8,
 			 nowtime) < 0)
@@ -158,10 +149,10 @@ static time64_t pmu_get_time(void)
 
 static int pmu_set_rtc_time(struct rtc_time *tm)
 {
-	unsigned int nowtime;
+	time64_t nowtime;
 	struct adb_request req;
 
-	nowtime = from_rtc_time(tm) + RTC_OFFSET;
+	nowtime = rtc_tm_to_time64(tm) + RTC_OFFSET;
 	if (pmu_request(&req, NULL, 5, PMU_SET_RTC, nowtime >> 24,
 			nowtime >> 16, nowtime >> 8, nowtime) < 0)
 		return -ENXIO;
-- 
2.9.0
