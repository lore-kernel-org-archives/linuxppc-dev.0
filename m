Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 21 Mar 2006 20:46:05 +1100
Subject: [PATCH 7/11] powerpc: iseries: Make more stuff static in
	platforms/iseries/mf.c
In-Reply-To: <1142934351.193140.181086235013.qpush@concordia>
Message-Id: <20060321094636.A430767A67@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make mf_get_rtc(), mf_get_boot_rtc() and mf_set_rtc() static, cause they can
be. We need to move mf_set_rtc() to avoid a forward declaration.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/platforms/iseries/mf.c |   78 ++++++++++++++++++------------------
 include/asm-powerpc/iseries/mf.h    |    4 -
 2 files changed, 39 insertions(+), 43 deletions(-)

Index: to-merge/arch/powerpc/platforms/iseries/mf.c
===================================================================
--- to-merge.orig/arch/powerpc/platforms/iseries/mf.c
+++ to-merge/arch/powerpc/platforms/iseries/mf.c
@@ -706,6 +706,43 @@ static void get_rtc_time_complete(void *
 	complete(&rtc->com);
 }
 
+static int mf_set_rtc(struct rtc_time *tm)
+{
+	char ce_time[12];
+	u8 day, mon, hour, min, sec, y1, y2;
+	unsigned year;
+
+	year = 1900 + tm->tm_year;
+	y1 = year / 100;
+	y2 = year % 100;
+
+	sec = tm->tm_sec;
+	min = tm->tm_min;
+	hour = tm->tm_hour;
+	day = tm->tm_mday;
+	mon = tm->tm_mon + 1;
+
+	BIN_TO_BCD(sec);
+	BIN_TO_BCD(min);
+	BIN_TO_BCD(hour);
+	BIN_TO_BCD(mon);
+	BIN_TO_BCD(day);
+	BIN_TO_BCD(y1);
+	BIN_TO_BCD(y2);
+
+	memset(ce_time, 0, sizeof(ce_time));
+	ce_time[3] = 0x41;
+	ce_time[4] = y1;
+	ce_time[5] = y2;
+	ce_time[6] = sec;
+	ce_time[7] = min;
+	ce_time[8] = hour;
+	ce_time[10] = day;
+	ce_time[11] = mon;
+
+	return signal_ce_msg(ce_time, NULL);
+}
+
 static int rtc_set_tm(int rc, u8 *ce_msg, struct rtc_time *tm)
 {
 	tm->tm_wday = 0;
@@ -761,7 +798,7 @@ static int rtc_set_tm(int rc, u8 *ce_msg
 	return 0;
 }
 
-int mf_get_rtc(struct rtc_time *tm)
+static int mf_get_rtc(struct rtc_time *tm)
 {
 	struct ce_msg_comp_data ce_complete;
 	struct rtc_time_data rtc_data;
@@ -794,7 +831,7 @@ static void get_boot_rtc_time_complete(v
 	rtc->busy = 0;
 }
 
-int mf_get_boot_rtc(struct rtc_time *tm)
+static int mf_get_boot_rtc(struct rtc_time *tm)
 {
 	struct ce_msg_comp_data ce_complete;
 	struct boot_rtc_time_data rtc_data;
@@ -816,43 +853,6 @@ int mf_get_boot_rtc(struct rtc_time *tm)
 	return rtc_set_tm(rtc_data.rc, rtc_data.ce_msg.ce_msg, tm);
 }
 
-int mf_set_rtc(struct rtc_time *tm)
-{
-	char ce_time[12];
-	u8 day, mon, hour, min, sec, y1, y2;
-	unsigned year;
-
-	year = 1900 + tm->tm_year;
-	y1 = year / 100;
-	y2 = year % 100;
-
-	sec = tm->tm_sec;
-	min = tm->tm_min;
-	hour = tm->tm_hour;
-	day = tm->tm_mday;
-	mon = tm->tm_mon + 1;
-
-	BIN_TO_BCD(sec);
-	BIN_TO_BCD(min);
-	BIN_TO_BCD(hour);
-	BIN_TO_BCD(mon);
-	BIN_TO_BCD(day);
-	BIN_TO_BCD(y1);
-	BIN_TO_BCD(y2);
-
-	memset(ce_time, 0, sizeof(ce_time));
-	ce_time[3] = 0x41;
-	ce_time[4] = y1;
-	ce_time[5] = y2;
-	ce_time[6] = sec;
-	ce_time[7] = min;
-	ce_time[8] = hour;
-	ce_time[10] = day;
-	ce_time[11] = mon;
-
-	return signal_ce_msg(ce_time, NULL);
-}
-
 #ifdef CONFIG_PROC_FS
 
 static int proc_mf_dump_cmdline(char *page, char **start, off_t off,
Index: to-merge/include/asm-powerpc/iseries/mf.h
===================================================================
--- to-merge.orig/include/asm-powerpc/iseries/mf.h
+++ to-merge/include/asm-powerpc/iseries/mf.h
@@ -48,8 +48,4 @@ extern void mf_display_progress(u16 valu
 
 extern void mf_init(void);
 
-extern int mf_get_rtc(struct rtc_time *tm);
-extern int mf_get_boot_rtc(struct rtc_time *tm);
-extern int mf_set_rtc(struct rtc_time *tm);
-
 #endif /* _ASM_POWERPC_ISERIES_MF_H */
