Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D8B9E1A005A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 14:51:39 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Wed, 3 Jun 2015 10:21:36 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 01ED7E0058
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 10:24:51 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t534pXju6684946
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jun 2015 10:21:34 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t534pXuK013815
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jun 2015 10:21:33 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Neelesh Gupta <neelegup@linux.vnet.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Subject: [PATCH] rtc/rtc-opal: Disable rtc-alarms when opal doesn't support tpo
Date: Wed,  3 Jun 2015 10:21:27 +0530
Message-Id: <1433307087-11503-1-git-send-email-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

rtc-opal driver provides support for rtc alarms via
times-power-on(tpo). However some platforms like BML use a fake rtc
clock and don't support tpo. Such platforms are indicated by the missing
'has-tpo' property in the device tree.

Current implementation however enables callback for
rtc_class_ops.read/set alarm irrespective of the tpo support from the
platform. This results in a failed opal call when kernel tries to read
an existing alarms via opal_get_tpo_time during rtc device registration.

This patch fixes this issue by setting opal_rtc_ops.read/set_alarm
callback pointers only when tpo is supported.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 drivers/rtc/rtc-opal.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-opal.c b/drivers/rtc/rtc-opal.c
index 7061dca..1125641 100644
--- a/drivers/rtc/rtc-opal.c
+++ b/drivers/rtc/rtc-opal.c
@@ -190,11 +190,9 @@ exit:
 	return rc;
 }
 
-static const struct rtc_class_ops opal_rtc_ops = {
+static struct rtc_class_ops opal_rtc_ops = {
 	.read_time	= opal_get_rtc_time,
 	.set_time	= opal_set_rtc_time,
-	.read_alarm	= opal_get_tpo_time,
-	.set_alarm	= opal_set_tpo_time,
 };
 
 static int opal_rtc_probe(struct platform_device *pdev)
@@ -202,8 +200,11 @@ static int opal_rtc_probe(struct platform_device *pdev)
 	struct rtc_device *rtc;
 
 	if (pdev->dev.of_node && of_get_property(pdev->dev.of_node, "has-tpo",
-						 NULL))
+						 NULL)) {
 		device_set_wakeup_capable(&pdev->dev, true);
+		opal_rtc_ops.read_alarm	= opal_get_tpo_time;
+		opal_rtc_ops.set_alarm = opal_set_tpo_time;
+	}
 
 	rtc = devm_rtc_device_register(&pdev->dev, DRVNAME, &opal_rtc_ops,
 				       THIS_MODULE);
-- 
2.2.1
