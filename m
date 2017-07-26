Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHPWS0brTzDqmS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 15:56:51 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6Q5rbHR141341
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 01:56:49 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bxfeswq7b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 01:56:48 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Wed, 26 Jul 2017 15:56:46 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6Q5uZCc27394048
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 15:56:43 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6Q5uBOK006031
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 15:56:11 +1000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: clg@kaod.org, linux@roeck-us.net
Cc: jdelvare@suse.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, linux-hwmon@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 ego@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com,
 stewart@linux.vnet.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [RFC] hwmon: (ibmpowernv) Add support for reset-history sensors
Date: Wed, 26 Jul 2017 11:25:38 +0530
Message-Id: <1501048538-23160-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In P9, OCC allows for clearing the sensor min-max history. This patch
exports attribute to reset history when set will clear the history of
all the sensors owned by CSM and belonging to the chip.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
This patch is on top of this patchset:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1453891.html

This patch creates a non-standard attribute called as reset_historyX
which clears the lowest and highest of all the sensors like power,
temperature, voltage belonging to the chip.

 drivers/hwmon/ibmpowernv.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index 5ccdd0b..611e472 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -51,6 +51,7 @@ enum sensors {
 	POWER_SUPPLY,
 	POWER_INPUT,
 	CURRENT,
+	RESET_HISTORY,
 	MAX_SENSOR_TYPE,
 };
 
@@ -78,6 +79,7 @@ enum sensors {
 	{ "in"    },
 	{ "power" },
 	{ "curr"  },
+	{ "reset_history" },
 };
 
 struct sensor_data {
@@ -126,6 +128,25 @@ static ssize_t show_label(struct device *dev, struct device_attribute *devattr,
 	return sprintf(buf, "%s\n", sdata->label);
 }
 
+static ssize_t store_reset_history(struct device *dev,
+				   struct device_attribute *devattr,
+				   const char *buf, size_t count)
+{
+	struct sensor_data *sdata = container_of(devattr, struct sensor_data,
+						 dev_attr);
+	int rc;
+	int reset;
+
+	rc = kstrtoint(buf, 0, &reset);
+	if (rc)
+		return rc;
+
+	if (reset == 1)
+		rc = opal_sensor_groups_clear_history(sdata->id);
+
+	return rc ? rc : count;
+}
+
 static int __init get_logical_cpu(int hwcpu)
 {
 	int cpu;
@@ -458,6 +479,16 @@ static int create_device_attrs(struct platform_device *pdev)
 
 		create_hwmon_attr(&sdata[count], attr_name, show_sensor);
 
+		if (type == RESET_HISTORY) {
+			snprintf(sdata[count].name, MAX_ATTR_LEN, "%s%d",
+				 sensor_groups[type].name,
+				 sdata[count].hwmon_index);
+
+			sdata[count].dev_attr.attr.mode = 0220;
+			sdata[count].dev_attr.store = store_reset_history;
+			sdata[count].dev_attr.show = NULL;
+		}
+
 		pgroups[type]->attrs[sensor_groups[type].attr_count++] =
 				&sdata[count++].dev_attr.attr;
 
-- 
1.8.3.1
