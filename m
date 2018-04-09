Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KJfp3hhdzDqfk
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2018 15:25:38 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id y66so5214651pfi.7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Apr 2018 22:25:38 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linux-rtc@vger.kernel.org
Subject: [PATCH v2 2/9] powerpc/powernv: OPAL RTC driver standardise OPAL_BUSY
 loops
Date: Mon,  9 Apr 2018 15:24:24 +1000
Message-Id: <20180409052431.26405-3-npiggin@gmail.com>
In-Reply-To: <20180409052431.26405-1-npiggin@gmail.com>
References: <20180409052431.26405-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Convert to using the standard delay poll/delay form.

The OPAL RTC driver:

- Did not previously delay or sleep in the OPAL_BUSY_EVENT case.
  There have been scheduling delays of up to 50 seconds observed here
  (BMC reboot can do it), which this should fix.

Cc: linux-rtc@vger.kernel.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/opal-rtc.c |  6 +++--
 drivers/rtc/rtc-opal.c                    | 33 ++++++++++++++---------
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-rtc.c b/arch/powerpc/platforms/powernv/opal-rtc.c
index f8868864f373..f530cf62594d 100644
--- a/arch/powerpc/platforms/powernv/opal-rtc.c
+++ b/arch/powerpc/platforms/powernv/opal-rtc.c
@@ -48,10 +48,12 @@ unsigned long __init opal_get_boot_time(void)
 
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_rtc_read(&__y_m_d, &__h_m_s_ms);
-		if (rc == OPAL_BUSY_EVENT)
+		if (rc == OPAL_BUSY_EVENT) {
+			mdelay(OPAL_BUSY_DELAY_MS);
 			opal_poll_events(NULL);
-		else if (rc == OPAL_BUSY)
+		} else if (rc == OPAL_BUSY) {
 			mdelay(10);
+		}
 	}
 	if (rc != OPAL_SUCCESS)
 		return 0;
diff --git a/drivers/rtc/rtc-opal.c b/drivers/rtc/rtc-opal.c
index 304e891e35fc..cddcc4749d39 100644
--- a/drivers/rtc/rtc-opal.c
+++ b/drivers/rtc/rtc-opal.c
@@ -57,7 +57,7 @@ static void tm_to_opal(struct rtc_time *tm, u32 *y_m_d, u64 *h_m_s_ms)
 
 static int opal_get_rtc_time(struct device *dev, struct rtc_time *tm)
 {
-	long rc = OPAL_BUSY;
+	s64 rc = OPAL_BUSY;
 	int retries = 10;
 	u32 y_m_d;
 	u64 h_m_s_ms;
@@ -66,13 +66,17 @@ static int opal_get_rtc_time(struct device *dev, struct rtc_time *tm)
 
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_rtc_read(&__y_m_d, &__h_m_s_ms);
-		if (rc == OPAL_BUSY_EVENT)
+		if (rc == OPAL_BUSY_EVENT) {
+			msleep(OPAL_BUSY_DELAY_MS);
 			opal_poll_events(NULL);
-		else if (retries-- && (rc == OPAL_HARDWARE
-				       || rc == OPAL_INTERNAL_ERROR))
+		} else if (rc == OPAL_BUSY) {
 			msleep(10);
-		else if (rc != OPAL_BUSY && rc != OPAL_BUSY_EVENT)
-			break;
+		} else if (rc == OPAL_HARDWARE || rc == OPAL_INTERNAL_ERROR) {
+			if (retries--) {
+				msleep(10); /* Wait 10ms before retry */
+				rc = OPAL_BUSY; /* go around again */
+			}
+		}
 	}
 
 	if (rc != OPAL_SUCCESS)
@@ -87,21 +91,26 @@ static int opal_get_rtc_time(struct device *dev, struct rtc_time *tm)
 
 static int opal_set_rtc_time(struct device *dev, struct rtc_time *tm)
 {
-	long rc = OPAL_BUSY;
+	s64 rc = OPAL_BUSY;
 	int retries = 10;
 	u32 y_m_d = 0;
 	u64 h_m_s_ms = 0;
 
 	tm_to_opal(tm, &y_m_d, &h_m_s_ms);
+
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_rtc_write(y_m_d, h_m_s_ms);
-		if (rc == OPAL_BUSY_EVENT)
+		if (rc == OPAL_BUSY_EVENT) {
+			msleep(OPAL_BUSY_DELAY_MS);
 			opal_poll_events(NULL);
-		else if (retries-- && (rc == OPAL_HARDWARE
-				       || rc == OPAL_INTERNAL_ERROR))
+		} else if (rc == OPAL_BUSY) {
 			msleep(10);
-		else if (rc != OPAL_BUSY && rc != OPAL_BUSY_EVENT)
-			break;
+		} else if (rc == OPAL_HARDWARE || rc == OPAL_INTERNAL_ERROR) {
+			if (retries--) {
+				msleep(10); /* Wait 10ms before retry */
+				rc = OPAL_BUSY; /* go around again */
+			}
+		}
 	}
 
 	return rc == OPAL_SUCCESS ? 0 : -EIO;
-- 
2.17.0
