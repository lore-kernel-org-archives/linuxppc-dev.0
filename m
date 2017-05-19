Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wTkQm0QtrzDqMM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 20:13:19 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4JA8qhW136494
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 06:13:17 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ahwrajx5y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 06:13:16 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Fri, 19 May 2017 20:13:14 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4JAD3P553477498
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 20:13:11 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4JACci6007527
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 20:12:38 +1000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] rtc/tpo: Implement rtc_class_ops.alarm_irq_enable callback
Date: Fri, 19 May 2017 15:42:00 +0530
Message-Id: <20170519101200.9287-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Provide an implementation of the callback
rtc_class_ops.alarm_irq_enable callback for rtc-opal driver. This
callback is called when the wake alarm is disabled via the command:

'echo 0 > /sys/class/rtc/rtc0/wakealarm'

Without this the Timed-Power-On(TPO) config remains set even when its
disabled by the above command and the FSP will force machine boot at
previously configured time.

The callback is implemented as function opal_tpo_alarm_irq_enable()
which calls opal_set_tpo_time() with alarm.enabled == 0. A branch has
been added to opal_set_tpo_time() to handle this case by passing y_m_d
== h_m_s_ms == 0 to opal as arguments for opal_tpo_write() call.

Patch-based-on: https://patchwork.ozlabs.org/patch/764559/
Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
Corresponding opal side changes posted at
https://patchwork.ozlabs.org/patch/764555/ "fsp/tpo: Provide support
for disabling TPO alarm"
---
 drivers/rtc/rtc-opal.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-opal.c b/drivers/rtc/rtc-opal.c
index 2d84e2a..e2a946c 100644
--- a/drivers/rtc/rtc-opal.c
+++ b/drivers/rtc/rtc-opal.c
@@ -167,7 +167,14 @@ static int opal_set_tpo_time(struct device *dev, struct rtc_wkalrm *alarm)
 	u32 y_m_d = 0;
 	int token, rc;
 
-	tm_to_opal(&alarm->time, &y_m_d, &h_m_s_ms);
+	/* if alarm is enabled */
+	if (alarm->enabled) {
+		tm_to_opal(&alarm->time, &y_m_d, &h_m_s_ms);
+		pr_debug("Alarm set to %x %llx\n", y_m_d, h_m_s_ms);
+
+	} else {
+		pr_debug("Alarm getting disabled\n");
+	}
 
 	token = opal_async_get_token_interruptible();
 	if (token < 0) {
@@ -200,6 +207,18 @@ static int opal_set_tpo_time(struct device *dev, struct rtc_wkalrm *alarm)
 	return rc;
 }
 
+int opal_tpo_alarm_irq_enable(struct device *dev, unsigned int enabled)
+{
+	struct rtc_wkalrm alarm = { .enabled = 0 };
+
+	/*
+	 * TPO is automatically enabled when opal_set_tpo_time() is called with
+	 * non-zero rtc-time. We only handle disable case which needs to be
+	 * explicitly told to opal.
+	 */
+	return enabled ? 0 : opal_set_tpo_time(dev, &alarm);
+}
+
 static struct rtc_class_ops opal_rtc_ops = {
 	.read_time	= opal_get_rtc_time,
 	.set_time	= opal_set_rtc_time,
@@ -215,6 +234,7 @@ static int opal_rtc_probe(struct platform_device *pdev)
 		device_set_wakeup_capable(&pdev->dev, true);
 		opal_rtc_ops.read_alarm	= opal_get_tpo_time;
 		opal_rtc_ops.set_alarm = opal_set_tpo_time;
+		opal_rtc_ops.alarm_irq_enable = opal_tpo_alarm_irq_enable;
 	}
 
 	rtc = devm_rtc_device_register(&pdev->dev, DRVNAME, &opal_rtc_ops,
-- 
2.9.3
