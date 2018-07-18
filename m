Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41W4z83LdKzF35L
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 04:13:55 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6IIDm7C090167
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 14:13:53 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kaab58tat-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 14:13:53 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Wed, 18 Jul 2018 19:13:50 +0100
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, linux@roeck-us.net
Cc: linuxppc-dev@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v6 2/2] hwmon: ibmpowernv: Add attributes to enable/disable
 sensor groups
Date: Wed, 18 Jul 2018 23:43:30 +0530
In-Reply-To: <1531937610-6454-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1531937610-6454-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Message-Id: <1531937610-6454-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
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
per-senor sysfs attribute to disable and enable them.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
Changes from v5:
- Dont store the sensor node and parse the device-tree for each sensor
  to find the sensor-group during init

 Documentation/hwmon/ibmpowernv |  43 ++++++-
 drivers/hwmon/ibmpowernv.c     | 249 +++++++++++++++++++++++++++++++++++------
 2 files changed, 258 insertions(+), 34 deletions(-)

diff --git a/Documentation/hwmon/ibmpowernv b/Documentation/hwmon/ibmpowernv
index 8826ba2..5646825 100644
--- a/Documentation/hwmon/ibmpowernv
+++ b/Documentation/hwmon/ibmpowernv
@@ -33,9 +33,48 @@ fanX_input		Measured RPM value.
 fanX_min		Threshold RPM for alert generation.
 fanX_fault		0: No fail condition
 			1: Failing fan
+
 tempX_input		Measured ambient temperature.
 tempX_max		Threshold ambient temperature for alert generation.
-inX_input		Measured power supply voltage
+tempX_highest		Historical maximum temperature
+tempX_lowest		Historical minimum temperature
+tempX_enable		Enable/disable all temperature sensors belonging to the
+			sub-group. In POWER9, this attribute corresponds to
+			each OCC. Using this attribute each OCC can be asked to
+			disable/enable all of its temperature sensors.
+			1: Enable
+			0: Disable
+
+inX_input		Measured power supply voltage (millivolt)
 inX_fault		0: No fail condition.
 			1: Failing power supply.
-power1_input		System power consumption (microWatt)
+inX_highest		Historical maximum voltage
+inX_lowest		Historical minimum voltage
+inX_enable		Enable/disable all voltage sensors belonging to the
+			sub-group. In POWER9, this attribute corresponds to
+			each OCC. Using this attribute each OCC can be asked to
+			disable/enable all of its voltage sensors.
+			1: Enable
+			0: Disable
+
+powerX_input		Power consumption (microWatt)
+powerX_input_highest	Historical maximum power
+powerX_input_lowest	Historical minimum power
+powerX_enable		Enable/disable all power sensors belonging to the
+			sub-group. In POWER9, this attribute corresponds to
+			each OCC. Using this attribute each OCC can be asked to
+			disable/enable all of its power sensors.
+			1: Enable
+			0: Disable
+
+currX_input		Measured current (milliampere)
+currX_highest		Historical maximum current
+currX_lowest		Historical minimum current
+currX_enable		Enable/disable all current sensors belonging to the
+			sub-group. In POWER9, this attribute corresponds to
+			each OCC. Using this attribute each OCC can be asked to
+			disable/enable all of its current sensors.
+			1: Enable
+			0: Disable
+
+energyX_input		Cumulative energy (microJoule)
diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index f829dad..167acf3 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -90,11 +90,20 @@ struct sensor_data {
 	char label[MAX_LABEL_LEN];
 	char name[MAX_ATTR_LEN];
 	struct device_attribute dev_attr;
+	struct sensor_group_data *sgrp_data;
+};
+
+struct sensor_group_data {
+	struct mutex mutex;
+	u32 gid;
+	bool enable;
 };
 
 struct platform_data {
 	const struct attribute_group *attr_groups[MAX_SENSOR_TYPE + 1];
+	struct sensor_group_data *sgrp_data;
 	u32 sensors_count; /* Total count of sensors from each group */
+	u32 nr_sensor_groups; /* Total number of sensor groups */
 };
 
 static ssize_t show_sensor(struct device *dev, struct device_attribute *devattr,
@@ -105,6 +114,9 @@ static ssize_t show_sensor(struct device *dev, struct device_attribute *devattr,
 	ssize_t ret;
 	u64 x;
 
+	if (sdata->sgrp_data && !sdata->sgrp_data->enable)
+		return -ENODATA;
+
 	ret =  opal_get_sensor_data_u64(sdata->id, &x);
 
 	if (ret)
@@ -120,6 +132,46 @@ static ssize_t show_sensor(struct device *dev, struct device_attribute *devattr,
 	return sprintf(buf, "%llu\n", x);
 }
 
+static ssize_t show_enable(struct device *dev,
+			   struct device_attribute *devattr, char *buf)
+{
+	struct sensor_data *sdata = container_of(devattr, struct sensor_data,
+						 dev_attr);
+
+	return sprintf(buf, "%u\n", sdata->sgrp_data->enable);
+}
+
+static ssize_t store_enable(struct device *dev,
+			    struct device_attribute *devattr,
+			    const char *buf, size_t count)
+{
+	struct sensor_data *sdata = container_of(devattr, struct sensor_data,
+						 dev_attr);
+	struct sensor_group_data *sgrp_data = sdata->sgrp_data;
+	bool data;
+	int ret;
+
+	ret = kstrtobool(buf, &data);
+	if (ret)
+		return ret;
+
+	ret = mutex_lock_interruptible(&sgrp_data->mutex);
+	if (ret)
+		return ret;
+
+	if (data != sgrp_data->enable) {
+		ret =  sensor_group_enable(sgrp_data->gid, data);
+		if (!ret)
+			sgrp_data->enable = data;
+	}
+
+	if (!ret)
+		ret = count;
+
+	mutex_unlock(&sgrp_data->mutex);
+	return ret;
+}
+
 static ssize_t show_label(struct device *dev, struct device_attribute *devattr,
 			  char *buf)
 {
@@ -292,12 +344,126 @@ static u32 get_sensor_hwmon_index(struct sensor_data *sdata,
 	return ++sensor_groups[sdata->type].hwmon_index;
 }
 
+static int init_sensor_group_data(struct platform_device *pdev,
+				  struct platform_data *pdata)
+{
+	struct sensor_group_data *sgrp_data;
+	struct device_node *groups, *sgrp;
+	enum sensors type;
+	int count = 0, ret = 0;
+
+	groups = of_find_node_by_path("/ibm,opal/sensor-groups");
+	if (!groups)
+		return ret;
+
+	for_each_child_of_node(groups, sgrp) {
+		type = get_sensor_type(sgrp);
+		if (type != MAX_SENSOR_TYPE)
+			pdata->nr_sensor_groups++;
+	}
+
+	if (!pdata->nr_sensor_groups)
+		goto out;
+
+	sgrp_data = devm_kcalloc(&pdev->dev, pdata->nr_sensor_groups,
+				 sizeof(*sgrp_data), GFP_KERNEL);
+	if (!sgrp_data) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	for_each_child_of_node(groups, sgrp) {
+		const __be32 *phandles;
+		int len, gid;
+
+		type = get_sensor_type(sgrp);
+		if (type == MAX_SENSOR_TYPE)
+			continue;
+
+		if (of_property_read_u32(sgrp, "sensor-group-id", &gid))
+			continue;
+
+		phandles = of_get_property(sgrp, "sensors", &len);
+		if (!phandles)
+			continue;
+
+		len /= sizeof(u32);
+		if (!len)
+			continue;
+
+		sensor_groups[type].attr_count++;
+		sgrp_data[count].gid = gid;
+		mutex_init(&sgrp_data[count].mutex);
+		sgrp_data[count++].enable = false;
+	}
+
+	pdata->sgrp_data = sgrp_data;
+out:
+	of_node_put(groups);
+	return ret;
+}
+
+static struct sensor_group_data *get_sensor_group(struct platform_data *pdata,
+						  struct device_node *node,
+						  enum sensors gtype)
+{
+	struct sensor_group_data *sgrp_data = pdata->sgrp_data;
+	struct device_node *groups, *sgrp;
+
+	groups = of_find_node_by_path("/ibm,opal/sensor-groups");
+	if (!groups)
+		return NULL;
+
+	for_each_child_of_node(groups, sgrp) {
+		const __be32 *phandles;
+		int len, gid, i;
+		enum sensors type;
+
+		type = get_sensor_type(sgrp);
+		if (type != gtype)
+			continue;
+
+		if (of_property_read_u32(sgrp, "sensor-group-id", &gid))
+			continue;
+
+		phandles = of_get_property(sgrp, "sensors", &len);
+		if (!phandles)
+			continue;
+
+		len /= sizeof(u32);
+		if (!len)
+			continue;
+
+		while (--len >= 0)
+			if (be32_to_cpu(phandles[len]) == node->phandle)
+				break;
+
+		if (len < 0)
+			continue;
+
+		for (i = 0; i < pdata->nr_sensor_groups; i++)
+			if (gid == sgrp_data[i].gid) {
+				of_node_put(sgrp);
+				of_node_put(groups);
+				return &sgrp_data[i];
+			}
+	}
+
+	of_node_put(groups);
+	return NULL;
+}
+
 static int populate_attr_groups(struct platform_device *pdev)
 {
 	struct platform_data *pdata = platform_get_drvdata(pdev);
 	const struct attribute_group **pgroups = pdata->attr_groups;
 	struct device_node *opal, *np;
 	enum sensors type;
+	int ret;
+
+	ret = init_sensor_group_data(pdev, pdata);
+	if (ret)
+		return ret;
 
 	opal = of_find_node_by_path("/ibm,opal/sensors");
 	for_each_child_of_node(opal, np) {
@@ -344,7 +510,10 @@ static int populate_attr_groups(struct platform_device *pdev)
 static void create_hwmon_attr(struct sensor_data *sdata, const char *attr_name,
 			      ssize_t (*show)(struct device *dev,
 					      struct device_attribute *attr,
-					      char *buf))
+					      char *buf),
+			    ssize_t (*store)(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf, size_t count))
 {
 	snprintf(sdata->name, MAX_ATTR_LEN, "%s%d_%s",
 		 sensor_groups[sdata->type].name, sdata->hwmon_index,
@@ -352,23 +521,33 @@ static void create_hwmon_attr(struct sensor_data *sdata, const char *attr_name,
 
 	sysfs_attr_init(&sdata->dev_attr.attr);
 	sdata->dev_attr.attr.name = sdata->name;
-	sdata->dev_attr.attr.mode = S_IRUGO;
 	sdata->dev_attr.show = show;
+	if (store) {
+		sdata->dev_attr.store = store;
+		sdata->dev_attr.attr.mode = 0664;
+	} else {
+		sdata->dev_attr.attr.mode = 0444;
+	}
 }
 
 static void populate_sensor(struct sensor_data *sdata, int od, int hd, int sid,
 			    const char *attr_name, enum sensors type,
 			    const struct attribute_group *pgroup,
+			    struct sensor_group_data *sgrp_data,
 			    ssize_t (*show)(struct device *dev,
 					    struct device_attribute *attr,
-					    char *buf))
+					    char *buf),
+			    ssize_t (*store)(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf, size_t count))
 {
 	sdata->id = sid;
 	sdata->type = type;
 	sdata->opal_index = od;
 	sdata->hwmon_index = hd;
-	create_hwmon_attr(sdata, attr_name, show);
+	create_hwmon_attr(sdata, attr_name, show, store);
 	pgroup->attrs[sensor_groups[type].attr_count++] = &sdata->dev_attr.attr;
+	sdata->sgrp_data = sgrp_data;
 }
 
 static char *get_max_attr(enum sensors type)
@@ -403,24 +582,23 @@ static int create_device_attrs(struct platform_device *pdev)
 	const struct attribute_group **pgroups = pdata->attr_groups;
 	struct device_node *opal, *np;
 	struct sensor_data *sdata;
-	u32 sensor_id;
-	enum sensors type;
 	u32 count = 0;
-	int err = 0;
+	u32 group_attr_id[MAX_SENSOR_TYPE] = {0};
 
-	opal = of_find_node_by_path("/ibm,opal/sensors");
 	sdata = devm_kcalloc(&pdev->dev,
 			     pdata->sensors_count, sizeof(*sdata),
 			     GFP_KERNEL);
-	if (!sdata) {
-		err = -ENOMEM;
-		goto exit_put_node;
-	}
+	if (!sdata)
+		return -ENOMEM;
 
+	opal = of_find_node_by_path("/ibm,opal/sensors");
 	for_each_child_of_node(opal, np) {
+		struct sensor_group_data *sgrp_data;
 		const char *attr_name;
-		u32 opal_index;
+		u32 opal_index, hw_id;
+		u32 sensor_id;
 		const char *label;
+		enum sensors type;
 
 		if (np->name == NULL)
 			continue;
@@ -456,14 +634,12 @@ static int create_device_attrs(struct platform_device *pdev)
 			opal_index = INVALID_INDEX;
 		}
 
-		sdata[count].opal_index = opal_index;
-		sdata[count].hwmon_index =
-			get_sensor_hwmon_index(&sdata[count], sdata, count);
-
-		create_hwmon_attr(&sdata[count], attr_name, show_sensor);
-
-		pgroups[type]->attrs[sensor_groups[type].attr_count++] =
-				&sdata[count++].dev_attr.attr;
+		hw_id = get_sensor_hwmon_index(&sdata[count], sdata, count);
+		sgrp_data = get_sensor_group(pdata, np, type);
+		populate_sensor(&sdata[count], opal_index, hw_id, sensor_id,
+				attr_name, type, pgroups[type], sgrp_data,
+				show_sensor, NULL);
+		count++;
 
 		if (!of_property_read_string(np, "label", &label)) {
 			/*
@@ -474,35 +650,43 @@ static int create_device_attrs(struct platform_device *pdev)
 			 */
 
 			make_sensor_label(np, &sdata[count], label);
-			populate_sensor(&sdata[count], opal_index,
-					sdata[count - 1].hwmon_index,
+			populate_sensor(&sdata[count], opal_index, hw_id,
 					sensor_id, "label", type, pgroups[type],
-					show_label);
+					NULL, show_label, NULL);
 			count++;
 		}
 
 		if (!of_property_read_u32(np, "sensor-data-max", &sensor_id)) {
 			attr_name = get_max_attr(type);
-			populate_sensor(&sdata[count], opal_index,
-					sdata[count - 1].hwmon_index,
+			populate_sensor(&sdata[count], opal_index, hw_id,
 					sensor_id, attr_name, type,
-					pgroups[type], show_sensor);
+					pgroups[type], sgrp_data, show_sensor,
+					NULL);
 			count++;
 		}
 
 		if (!of_property_read_u32(np, "sensor-data-min", &sensor_id)) {
 			attr_name = get_min_attr(type);
-			populate_sensor(&sdata[count], opal_index,
-					sdata[count - 1].hwmon_index,
+			populate_sensor(&sdata[count], opal_index, hw_id,
 					sensor_id, attr_name, type,
-					pgroups[type], show_sensor);
+					pgroups[type], sgrp_data, show_sensor,
+					NULL);
+			count++;
+		}
+
+		if (sgrp_data && !sgrp_data->enable) {
+			sgrp_data->enable = true;
+			hw_id = ++group_attr_id[type];
+			populate_sensor(&sdata[count], opal_index, hw_id,
+					sgrp_data->gid, "enable", type,
+					pgroups[type], sgrp_data, show_enable,
+					store_enable);
 			count++;
 		}
 	}
 
-exit_put_node:
 	of_node_put(opal);
-	return err;
+	return 0;
 }
 
 static int ibmpowernv_probe(struct platform_device *pdev)
@@ -517,6 +701,7 @@ static int ibmpowernv_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pdata);
 	pdata->sensors_count = 0;
+	pdata->nr_sensor_groups = 0;
 	err = populate_attr_groups(pdev);
 	if (err)
 		return err;
-- 
1.8.3.1
