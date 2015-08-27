Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9171A1A0545
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 19:13:37 +1000 (AEST)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F3CEC1401EF
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2015 19:13:36 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 27 Aug 2015 14:43:34 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 006FAE0059
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2015 14:42:58 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7R9DTsJ60227622
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2015 14:43:29 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7R9DXaU031144
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2015 14:43:33 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: rjw@rjwysocki.net
Cc: stewart@linux.vnet.ibm.com, viresh.kumar@linaro.org,
 linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] cpufreq: powernv: Export frequency throttle state of the chip
 through sysfs
Date: Thu, 27 Aug 2015 14:43:26 +0530
Message-Id: <1440666806-11760-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Create a sysfs 'throttle' attribute per-chip(per-numa-node) to reflect
the throttle state of the chip. The usersapce programs can poll on
this attribute to keep an eye on the throttle state. Currently we
print a log message to notify the user of throttling event. The
performance-sensitive applications can monitor the throttle state
using this attribute.

Following file is created in sysfs:
/sys/devices/system/node/nodeN/throttle
'throttle' attribute has the following values:
0 : frequency is unthrottled
1 : frequency is throttled

Suggested-by: Stewart Smith <stewart@linux.vnet.ibm.com>
Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
This patch is based on top of linux-next/master 

 drivers/cpufreq/powernv-cpufreq.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 64994e1..aed6c34 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -28,6 +28,8 @@
 #include <linux/of.h>
 #include <linux/reboot.h>
 #include <linux/slab.h>
+#include <linux/device.h>
+#include <linux/node.h>
 
 #include <asm/cputhreads.h>
 #include <asm/firmware.h>
@@ -413,6 +415,23 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
 	.notifier_call = powernv_cpufreq_reboot_notifier,
 };
 
+static ssize_t throttle_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	int i;
+
+	for (i = 0; i < nr_chips; i++)
+		if (chips[i].id == dev->id) {
+			smp_call_function_any(&chips[i].mask,
+					      powernv_cpufreq_throttle_check,
+					      NULL, 1);
+			return sprintf(buf, "%d\n", throttled ||
+						    chips[i].throttled);
+		}
+}
+
+static DEVICE_ATTR(throttle, 0400, throttle_show, NULL);
+
 void powernv_cpufreq_work_fn(struct work_struct *work)
 {
 	struct chip *chip = container_of(work, struct chip, throttle);
@@ -570,6 +589,8 @@ static int init_chip_info(void)
 		cpumask_copy(&chips[i].mask, cpumask_of_node(chip[i]));
 		INIT_WORK(&chips[i].throttle, powernv_cpufreq_work_fn);
 		chips[i].restore = false;
+		device_create_file(&node_devices[chip[i]]->dev,
+				   &dev_attr_throttle);
 	}
 
 	return 0;
-- 
1.9.3
