Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 31/39] powerpc/powernv: More little endian issues in OPAL RTC
 driver
Date: Mon, 23 Sep 2013 12:05:05 +1000
Message-Id: <1379901913-5945-32-git-send-email-anton@samba.org>
In-Reply-To: <1379901913-5945-1-git-send-email-anton@samba.org>
References: <1379901913-5945-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sparse caught an issue where opal_set_rtc_time was incorrectly
byteswapping. Also fix a number of sparse warnings.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/opal.h           |  4 ++--
 arch/powerpc/platforms/powernv/opal-rtc.c | 19 ++++++++++---------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 6622ea4..3db5e82 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -543,8 +543,8 @@ int64_t opal_console_read(int64_t term_number, __be64 *length,
 			  uint8_t *buffer);
 int64_t opal_console_write_buffer_space(int64_t term_number,
 					__be64 *length);
-int64_t opal_rtc_read(uint32_t *year_month_day,
-		      uint64_t *hour_minute_second_millisecond);
+int64_t opal_rtc_read(__be32 *year_month_day,
+		      __be64 *hour_minute_second_millisecond);
 int64_t opal_rtc_write(uint32_t year_month_day,
 		       uint64_t hour_minute_second_millisecond);
 int64_t opal_cec_power_down(uint64_t request);
diff --git a/arch/powerpc/platforms/powernv/opal-rtc.c b/arch/powerpc/platforms/powernv/opal-rtc.c
index dbfdba3..7d07c7e 100644
--- a/arch/powerpc/platforms/powernv/opal-rtc.c
+++ b/arch/powerpc/platforms/powernv/opal-rtc.c
@@ -37,10 +37,12 @@ unsigned long __init opal_get_boot_time(void)
 	struct rtc_time tm;
 	u32 y_m_d;
 	u64 h_m_s_ms;
+	__be32 __y_m_d;
+	__be64 __h_m_s_ms;
 	long rc = OPAL_BUSY;
 
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
-		rc = opal_rtc_read(&y_m_d, &h_m_s_ms);
+		rc = opal_rtc_read(&__y_m_d, &__h_m_s_ms);
 		if (rc == OPAL_BUSY_EVENT)
 			opal_poll_events(NULL);
 		else
@@ -48,8 +50,8 @@ unsigned long __init opal_get_boot_time(void)
 	}
 	if (rc != OPAL_SUCCESS)
 		return 0;
-	y_m_d = be32_to_cpu(y_m_d);
-	h_m_s_ms = be64_to_cpu(h_m_s_ms);
+	y_m_d = be32_to_cpu(__y_m_d);
+	h_m_s_ms = be64_to_cpu(__h_m_s_ms);
 	opal_to_tm(y_m_d, h_m_s_ms, &tm);
 	return mktime(tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
 		      tm.tm_hour, tm.tm_min, tm.tm_sec);
@@ -60,9 +62,11 @@ void opal_get_rtc_time(struct rtc_time *tm)
 	long rc = OPAL_BUSY;
 	u32 y_m_d;
 	u64 h_m_s_ms;
+	__be32 __y_m_d;
+	__be64 __h_m_s_ms;
 
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
-		rc = opal_rtc_read(&y_m_d, &h_m_s_ms);
+		rc = opal_rtc_read(&__y_m_d, &__h_m_s_ms);
 		if (rc == OPAL_BUSY_EVENT)
 			opal_poll_events(NULL);
 		else
@@ -70,8 +74,8 @@ void opal_get_rtc_time(struct rtc_time *tm)
 	}
 	if (rc != OPAL_SUCCESS)
 		return;
-	y_m_d = be32_to_cpu(y_m_d);
-	h_m_s_ms = be64_to_cpu(h_m_s_ms);
+	y_m_d = be32_to_cpu(__y_m_d);
+	h_m_s_ms = be64_to_cpu(__h_m_s_ms);
 	opal_to_tm(y_m_d, h_m_s_ms, tm);
 }
 
@@ -90,9 +94,6 @@ int opal_set_rtc_time(struct rtc_time *tm)
 	h_m_s_ms |= ((u64)bin2bcd(tm->tm_min)) << 48;
 	h_m_s_ms |= ((u64)bin2bcd(tm->tm_sec)) << 40;
 
-	y_m_d = cpu_to_be32(y_m_d);
-	h_m_s_ms = cpu_to_be64(h_m_s_ms);
-
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_rtc_write(y_m_d, h_m_s_ms);
 		if (rc == OPAL_BUSY_EVENT)
-- 
1.8.1.2
