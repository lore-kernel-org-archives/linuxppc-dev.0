Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wbkk51pR8zDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 14:47:25 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4T4hinW026684
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 00:47:16 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2aqhmjgyw3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 00:47:16 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Mon, 29 May 2017 14:47:13 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4T4l2b328115112
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 14:47:10 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4T4kTJP014395
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 14:46:30 +1000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: jdelvare@suse.com, linux@roeck-us.net, paulus@samba.org, mpe@ellerman.id.au
Cc: linux-hwmon@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, svaidy@linux.vnet.ibm.com,
 ego@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com,
 andrew@aj.id.au, clg@kaod.org,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH V5] hwmon: (ibmpowernv) Add highest/lowest attributes to
 sensors
Date: Mon, 29 May 2017 10:16:01 +0530
Message-Id: <1496033161-9244-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

OCC provides historical minimum and maximum value for the sensor
readings. This patch exports them as highest and lowest attributes
for the inband sensors copied by OCC to main memory.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
Changes from V4:
- Got rid of 'len' variable in populate_attr_groups

 drivers/hwmon/ibmpowernv.c | 68 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 61 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index 6d2e660..b562323 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -298,10 +298,14 @@ static int populate_attr_groups(struct platform_device *pdev)
 		sensor_groups[type].attr_count++;
 
 		/*
-		 * add a new attribute for labels
+		 * add attributes for labels, min and max
 		 */
 		if (!of_property_read_string(np, "label", &label))
 			sensor_groups[type].attr_count++;
+		if (of_find_property(np, "sensor-data-min", NULL))
+			sensor_groups[type].attr_count++;
+		if (of_find_property(np, "sensor-data-max", NULL))
+			sensor_groups[type].attr_count++;
 	}
 
 	of_node_put(opal);
@@ -337,6 +341,41 @@ static void create_hwmon_attr(struct sensor_data *sdata, const char *attr_name,
 	sdata->dev_attr.show = show;
 }
 
+static void populate_sensor(struct sensor_data *sdata, int od, int hd, int sid,
+			    const char *attr_name, enum sensors type,
+			    const struct attribute_group *pgroup,
+			    ssize_t (*show)(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf))
+{
+	sdata->id = sid;
+	sdata->type = type;
+	sdata->opal_index = od;
+	sdata->hwmon_index = hd;
+	create_hwmon_attr(sdata, attr_name, show);
+	pgroup->attrs[sensor_groups[type].attr_count++] = &sdata->dev_attr.attr;
+}
+
+static char *get_max_attr(enum sensors type)
+{
+	switch (type) {
+	case POWER_INPUT:
+		return "input_highest";
+	default:
+		return "highest";
+	}
+}
+
+static char *get_min_attr(enum sensors type)
+{
+	switch (type) {
+	case POWER_INPUT:
+		return "input_lowest";
+	default:
+		return "lowest";
+	}
+}
+
 /*
  * Iterate through the device tree for each child of 'sensors' node, create
  * a sysfs attribute file, the file is named by translating the DT node name
@@ -417,16 +456,31 @@ static int create_device_attrs(struct platform_device *pdev)
 			 * attribute. They are related to the same
 			 * sensor.
 			 */
-			sdata[count].type = type;
-			sdata[count].opal_index = sdata[count - 1].opal_index;
-			sdata[count].hwmon_index = sdata[count - 1].hwmon_index;
 
 			make_sensor_label(np, &sdata[count], label);
+			populate_sensor(&sdata[count], opal_index,
+					sdata[count - 1].hwmon_index,
+					sensor_id, "label", type, pgroups[type],
+					show_label);
+			count++;
+		}
 
-			create_hwmon_attr(&sdata[count], "label", show_label);
+		if (!of_property_read_u32(np, "sensor-data-max", &sensor_id)) {
+			attr_name = get_max_attr(type);
+			populate_sensor(&sdata[count], opal_index,
+					sdata[count - 1].hwmon_index,
+					sensor_id, attr_name, type,
+					pgroups[type], show_sensor);
+			count++;
+		}
 
-			pgroups[type]->attrs[sensor_groups[type].attr_count++] =
-				&sdata[count++].dev_attr.attr;
+		if (!of_property_read_u32(np, "sensor-data-min", &sensor_id)) {
+			attr_name = get_min_attr(type);
+			populate_sensor(&sdata[count], opal_index,
+					sdata[count - 1].hwmon_index,
+					sensor_id, attr_name, type,
+					pgroups[type], show_sensor);
+			count++;
 		}
 	}
 
-- 
1.8.3.1
