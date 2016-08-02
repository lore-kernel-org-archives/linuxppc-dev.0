Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3K0W0RzWzDqVH
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 11:50:34 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u721mgRm139406
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 21:50:32 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24gpjfcam2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Aug 2016 21:50:31 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 1 Aug 2016 19:50:31 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: neelegup@linux.vnet.ibm.com, Stewart Smith <stewart@linux.vnet.ibm.com>,
 stable@vger.kernel.org
Subject: [PATCH] rtc-opal: Fix handling of firmware error codes,
 prevent busy loops
Date: Tue,  2 Aug 2016 11:50:16 +1000
Message-Id: <1470102616-18346-1-git-send-email-stewart@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

According to the OPAL docs:
https://github.com/open-power/skiboot/blob/skiboot-5.2.5/doc/opal-api/opal-rtc-read-3.txt
https://github.com/open-power/skiboot/blob/skiboot-5.2.5/doc/opal-api/opal-rtc-write-4.txt
OPAL_HARDWARE may be returned from OPAL_RTC_READ or OPAL_RTC_WRITE and this
indicates either a transient or permanent error.

Prior to this patch, Linux was not dealing with OPAL_HARDWARE being a
permanent error particularly well, in that you could end up in a busy
loop.

This was not too hard to trigger on an AMI BMC based OpenPOWER machine
doing a continuous "ipmitool mc reset cold" to the BMC, the result of
that being that we'd get stuck in an infinite loop in opal_get_rtc_time.

We now retry a few times before returning the error higher up the stack.

Cc: stable@vger.kernel.org
Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
 drivers/rtc/rtc-opal.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-opal.c b/drivers/rtc/rtc-opal.c
index 9c18d6fd8107..fab19e3e2fba 100644
--- a/drivers/rtc/rtc-opal.c
+++ b/drivers/rtc/rtc-opal.c
@@ -58,6 +58,7 @@ static void tm_to_opal(struct rtc_time *tm, u32 *y_m_d, u64 *h_m_s_ms)
 static int opal_get_rtc_time(struct device *dev, struct rtc_time *tm)
 {
 	long rc = OPAL_BUSY;
+	int retries = 10;
 	u32 y_m_d;
 	u64 h_m_s_ms;
 	__be32 __y_m_d;
@@ -67,8 +68,11 @@ static int opal_get_rtc_time(struct device *dev, struct rtc_time *tm)
 		rc = opal_rtc_read(&__y_m_d, &__h_m_s_ms);
 		if (rc == OPAL_BUSY_EVENT)
 			opal_poll_events(NULL);
-		else
+		else if (retries-- && (rc == OPAL_HARDWARE
+				       || rc == OPAL_INTERNAL_ERROR))
 			msleep(10);
+		else if (rc != OPAL_BUSY && rc != OPAL_BUSY_EVENT)
+			break;
 	}
 
 	if (rc != OPAL_SUCCESS)
@@ -84,6 +88,7 @@ static int opal_get_rtc_time(struct device *dev, struct rtc_time *tm)
 static int opal_set_rtc_time(struct device *dev, struct rtc_time *tm)
 {
 	long rc = OPAL_BUSY;
+	int retries = 10;
 	u32 y_m_d = 0;
 	u64 h_m_s_ms = 0;
 
@@ -92,8 +97,11 @@ static int opal_set_rtc_time(struct device *dev, struct rtc_time *tm)
 		rc = opal_rtc_write(y_m_d, h_m_s_ms);
 		if (rc == OPAL_BUSY_EVENT)
 			opal_poll_events(NULL);
-		else
+		else if (retries-- && (rc == OPAL_HARDWARE
+				       || rc == OPAL_INTERNAL_ERROR))
 			msleep(10);
+		else if (rc != OPAL_BUSY && rc != OPAL_BUSY_EVENT)
+			break;
 	}
 
 	return rc == OPAL_SUCCESS ? 0 : -EIO;
-- 
2.1.4
