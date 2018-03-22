Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406NqT2XhPzF1wx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 21:55:17 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2MAsnMt012251
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 06:55:14 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gvb0yrb7j-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 06:55:13 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 22 Mar 2018 10:54:56 -0000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, linux@roeck-us.net
Cc: linuxppc-dev@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, stewart@linux.vnet.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 2/3] hwmon: ibmpowernv: Add attributes to enable/disable
 sensor groups
Date: Thu, 22 Mar 2018 16:24:34 +0530
In-Reply-To: <1521716075-807-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1521716075-807-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Message-Id: <1521716075-807-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On-Chip-Controller(OCC) is an embedded micro-processor in POWER9 chip
which measures various system and chip level sensors. These sensors
comprises of environmental sensors (like power, temperature, current
and voltage) and performance sensors (like utilization, frequency).
All these sensors are copied to main memory at a regular interval of
100ms. OCC provides a way to select a group of sensors that is copied
to the main memory to increase the update frequency of selected sensor
groups. When a sensor-group is disabled, OCC will not copy it to main
memory and those sensors read 0 values.

This patch provides support for enabling/disabling the sensor groups
like power, temperature, current and voltage. This patch adds new
sysfs attributes to disable and enable them.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---

- Should the new attributes be added to hwmon_chip_attrs[]?

 Documentation/hwmon/ibmpowernv |  31 +++++++++-
 drivers/hwmon/ibmpowernv.c     | 127 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 150 insertions(+), 8 deletions(-)

diff --git a/Documentation/hwmon/ibmpowernv b/Documentation/hwmon/ibmpowernv
index 8826ba2..5e510fd 100644
--- a/Documentation/hwmon/ibmpowernv
+++ b/Documentation/hwmon/ibmpowernv
@@ -38,4 +38,33 @@ tempX_max		Threshold ambient temperature for alert generation.
 inX_input		Measured power supply voltage
 inX_fault		0: No fail condition.
 			1: Failing power supply.
-power1_input		System power consumption (microWatt)
+powerX_input		Power consumption (microWatt)
+currX_input		Measured current
+
+Sysfs attributes in POWER9
+---------------------------
+
+On-Chip-Controller(OCC) copies the sensors to main memory. The
+environmental sensor groups can be dynamically configured by writing
+to the below sysfs files. Writing to this file configures the sensor
+group update for the all the OCC chips in the system.
+
+power_enable		Disable/enable copying of power sensors
+			0: Disable
+			1: Enable
+			RO
+
+in_enable		Disable/enable copying of voltage sensors
+			0: Disable
+			1: Enable
+			RO
+
+curr_enable		Disable/enable copying of current sensors
+			0: Disable
+			1: Enable
+			RO
+
+temp_enable		Disable/enable copying of temperature sensors
+			0: Disable
+			1: Enable
+			RO
diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index 5ccdd0b..696ccbc 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -90,6 +90,16 @@ struct sensor_data {
 	struct device_attribute dev_attr;
 };
 
+struct sensor_group_data {
+	u32 nr_ids;
+	u32 *id;
+	char name[MAX_ATTR_LEN];
+	struct device_attribute dev_attr;
+};
+
+DEFINE_MUTEX(sensor_groups_mutex);
+static int nr_sg_attr_count;
+
 struct platform_data {
 	const struct attribute_group *attr_groups[MAX_SENSOR_TYPE + 1];
 	u32 sensors_count; /* Total count of sensors from each group */
@@ -117,6 +127,42 @@ static ssize_t show_sensor(struct device *dev, struct device_attribute *devattr,
 	return sprintf(buf, "%u\n", x);
 }
 
+static ssize_t store_enable(struct device *dev,
+			    struct device_attribute *devattr,
+			    const char *buf, size_t count)
+{
+	struct sensor_group_data *sdata = container_of(devattr,
+						       struct sensor_group_data,
+						       dev_attr);
+	int ret;
+	u32 data;
+	int i;
+
+	ret = kstrtoint(buf, 0, &data);
+	if (ret)
+		return ret;
+
+	if (data != 0 && data != 1)
+		return -EIO;
+
+	ret = mutex_lock_interruptible(&sensor_groups_mutex);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < sdata->nr_ids; i++) {
+		ret =  sensor_group_enable(sdata->id[i], data);
+		if (ret) {
+			ret = -EIO;
+			goto out;
+		}
+	}
+
+	ret = count;
+out:
+	mutex_unlock(&sensor_groups_mutex);
+	return ret;
+}
+
 static ssize_t show_label(struct device *dev, struct device_attribute *devattr,
 			  char *buf)
 {
@@ -322,6 +368,21 @@ static int populate_attr_groups(struct platform_device *pdev)
 
 	of_node_put(opal);
 
+	opal = of_find_node_by_path("/ibm,opal/sensor-groups");
+	for (type = 0; type < MAX_SENSOR_TYPE; type++)
+		for_each_child_of_node(opal, np) {
+			enum sensors ctype;
+
+			ctype = get_sensor_type(np);
+			if (ctype == type) {
+				sensor_groups[ctype].attr_count++;
+				nr_sg_attr_count++;
+				break;
+			}
+		}
+
+	of_node_put(opal);
+
 	for (type = 0; type < MAX_SENSOR_TYPE; type++) {
 		sensor_groups[type].group.attrs = devm_kzalloc(&pdev->dev,
 					sizeof(struct attribute *) *
@@ -400,19 +461,25 @@ static int create_device_attrs(struct platform_device *pdev)
 	const struct attribute_group **pgroups = pdata->attr_groups;
 	struct device_node *opal, *np;
 	struct sensor_data *sdata;
+	struct sensor_group_data *sgdata;
 	u32 sensor_id;
 	enum sensors type;
 	u32 count = 0;
 	int err = 0;
+	int nr_id[MAX_SENSOR_TYPE] = {0};
 
-	opal = of_find_node_by_path("/ibm,opal/sensors");
-	sdata = devm_kzalloc(&pdev->dev, pdata->sensors_count * sizeof(*sdata),
+	sdata = devm_kzalloc(&pdev->dev, (pdata->sensors_count -
+			     nr_sg_attr_count) * sizeof(*sdata),
 			     GFP_KERNEL);
-	if (!sdata) {
-		err = -ENOMEM;
-		goto exit_put_node;
-	}
+	if (!sdata)
+		return -ENOMEM;
+
+	sgdata = devm_kzalloc(&pdev->dev, nr_sg_attr_count * sizeof(*sgdata),
+			      GFP_KERNEL);
+	if (!sgdata)
+		return -ENOMEM;
 
+	opal = of_find_node_by_path("/ibm,opal/sensors");
 	for_each_child_of_node(opal, np) {
 		const char *attr_name;
 		u32 opal_index;
@@ -496,7 +563,53 @@ static int create_device_attrs(struct platform_device *pdev)
 		}
 	}
 
-exit_put_node:
+	of_node_put(opal);
+
+	opal = of_find_node_by_path("/ibm,opal/sensor-groups");
+	for_each_child_of_node(opal, np) {
+		type = get_sensor_type(np);
+		if (type == MAX_SENSOR_TYPE)
+			continue;
+		nr_id[type]++;
+	}
+
+	count = 0;
+	for (type = 0; type < MAX_SENSOR_TYPE; type++) {
+		int c = 0;
+
+		if (!nr_id[type])
+			continue;
+
+		sgdata[count].nr_ids = nr_id[type];
+		sgdata[count].id = devm_kzalloc(&pdev->dev, nr_id[type] *
+					    sizeof(u32), GFP_KERNEL);
+		if (!sgdata[count].id)
+			return -ENOMEM;
+
+		for_each_child_of_node(opal, np) {
+			enum sensors ctype;
+
+			ctype = get_sensor_type(np);
+			if (type != ctype)
+				continue;
+
+			if (of_property_read_u32(np, "sensor-group-id",
+						&sensor_id))
+				continue;
+
+			sgdata[count].id[c++] = sensor_id;
+		}
+		snprintf(sgdata[count].name, MAX_ATTR_LEN, "%s_enable",
+			 sensor_groups[type].name);
+		sysfs_attr_init(&sgdata[count].dev_attr.attr);
+		sgdata[count].dev_attr.attr.name = sgdata[count].name;
+		sgdata[count].dev_attr.attr.mode = 00220;
+		sgdata[count].dev_attr.store = store_enable;
+		pgroups[type]->attrs[sensor_groups[type].attr_count++] =
+			&sgdata[count].dev_attr.attr;
+		count++;
+	}
+
 	of_node_put(opal);
 	return err;
 }
-- 
1.8.3.1
