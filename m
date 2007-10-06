Return-Path: <geoff@white.local.net>
Received: from outbound9-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C3C86DDEBD
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Oct 2007 07:38:22 +1000 (EST)
Message-Id: <20071006213542.768463626@am.sony.com>
References: <20071006213542.311447584@am.sony.com>
Date: Sat, 06 Oct 2007 14:35:46 -0700
From: geoffrey.levand@am.sony.com
To: paulus@samba.org
Subject: [patch 4/6] PS3: Add os-area rtc_diff set/get routines
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Updates for PS3 os-area rtc_diff set/get routines
o Add a new routine ps3_os_area_set_rtc_diff().
o Rename ps3_os_area_rtc_diff() to ps3_os_area_get_rtc_diff().
o Remove static variable rtc_shift with calls to ps3_os_area_get_rtc_diff().

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/os-area.c  |   19 +++++++++++++++++--
 arch/powerpc/platforms/ps3/platform.h |    3 ++-
 arch/powerpc/platforms/ps3/time.c     |   14 +++-----------
 3 files changed, 22 insertions(+), 14 deletions(-)

--- a/arch/powerpc/platforms/ps3/os-area.c
+++ b/arch/powerpc/platforms/ps3/os-area.c
@@ -261,16 +261,31 @@ void __init ps3_os_area_save_params(void
 }
 
 /**
- * ps3_os_area_rtc_diff - Returns the rtc diff value.
+ * ps3_os_area_get_rtc_diff - Returns the rtc diff value.
  */
 
-u64 ps3_os_area_rtc_diff(void)
+u64 ps3_os_area_get_rtc_diff(void)
 {
 	return saved_params.rtc_diff ? saved_params.rtc_diff
 		: SECONDS_FROM_1970_TO_2000;
 }
 
 /**
+ * ps3_os_area_set_rtc_diff - Set the rtc diff value.
+ *
+ * An asynchronous write is needed to support writing updates from
+ * the timer interrupt context.
+ */
+
+void ps3_os_area_set_rtc_diff(u64 rtc_diff)
+{
+	if (saved_params.rtc_diff != rtc_diff) {
+		saved_params.rtc_diff = rtc_diff;
+		os_area_queue_work();
+	}
+}
+
+/**
  * ps3_os_area_get_av_multi_out - Returns the default video mode.
  */
 
--- a/arch/powerpc/platforms/ps3/platform.h
+++ b/arch/powerpc/platforms/ps3/platform.h
@@ -63,7 +63,8 @@ int ps3_set_rtc_time(struct rtc_time *ti
 /* os area */
 
 void __init ps3_os_area_save_params(void);
-u64 ps3_os_area_rtc_diff(void);
+u64 ps3_os_area_get_rtc_diff(void);
+void ps3_os_area_set_rtc_diff(u64 rtc_diff);
 
 /* spu */
 
--- a/arch/powerpc/platforms/ps3/time.c
+++ b/arch/powerpc/platforms/ps3/time.c
@@ -50,12 +50,6 @@ static void __maybe_unused _dump_time(in
 	_dump_tm(&tm, func, line);
 }
 
-/**
- * rtc_shift - Difference in seconds between 1970 and the ps3 rtc value.
- */
-
-static s64 rtc_shift;
-
 void __init ps3_calibrate_decr(void)
 {
 	int result;
@@ -66,8 +60,6 @@ void __init ps3_calibrate_decr(void)
 
 	ppc_tb_freq = tmp;
 	ppc_proc_freq = ppc_tb_freq * 40;
-
-	rtc_shift = ps3_os_area_rtc_diff();
 }
 
 static u64 read_rtc(void)
@@ -87,18 +79,18 @@ int ps3_set_rtc_time(struct rtc_time *tm
 	u64 now = mktime(tm->tm_year + 1900, tm->tm_mon + 1, tm->tm_mday,
 		tm->tm_hour, tm->tm_min, tm->tm_sec);
 
-	rtc_shift = now - read_rtc();
+	ps3_os_area_set_rtc_diff(now - read_rtc());
 	return 0;
 }
 
 void ps3_get_rtc_time(struct rtc_time *tm)
 {
-	to_tm(read_rtc() + rtc_shift, tm);
+	to_tm(read_rtc() + ps3_os_area_get_rtc_diff(), tm);
 	tm->tm_year -= 1900;
 	tm->tm_mon -= 1;
 }
 
 unsigned long __init ps3_get_boot_time(void)
 {
-	return read_rtc() + rtc_shift;
+	return read_rtc() + ps3_os_area_get_rtc_diff();
 }

-- 
