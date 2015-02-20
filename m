Return-Path: <clg@fr.ibm.com>
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 748691A0EFC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Feb 2015 02:09:42 +1100 (AEDT)
Received: from /spool/local
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Fri, 20 Feb 2015 15:09:38 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 3/3] hwmon: (ibmpowernv) add DTS support
Date: Fri, 20 Feb 2015 16:07:37 +0100
Message-Id: <1424444857-13805-4-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
References: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, lm-sensors@lm-sensors.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org,
 Jean Delvare <jdelvare@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch reworks the ibmpowernv driver to support the new device tree
for sensors exposed by OPAL. It also adds new sensors : the core and
memory buffers DTS.

Hopefully, the proposed framework is good enough to easily add sensors
for other resources such as volts, planar temperatures, etc.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
 drivers/hwmon/ibmpowernv.c |  336 ++++++++++++++++++++++++--------------------
 1 file changed, 180 insertions(+), 156 deletions(-)

diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index febe8175d36c..9a6ee33f8219 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -32,247 +32,276 @@
 #include <linux/err.h>
 
 #define MAX_ATTR_LEN	32
-
-/* Sensor suffix name from DT */
-#define DT_FAULT_ATTR_SUFFIX		"faulted"
-#define DT_DATA_ATTR_SUFFIX		"data"
-#define DT_THRESHOLD_ATTR_SUFFIX	"thrs"
+#define MAX_LABEL_LEN	64
+#define MAX_ATTRS	3	/* sensor-data, sensor-status, label */
 
 /*
  * Enumerates all the types of sensors in the POWERNV platform and does index
- * into 'struct sensor_group'
+ * into 'struct sensor_type'
  */
 enum sensors {
 	FAN,
-	AMBIENT_TEMP,
+	TEMP,
 	POWER_SUPPLY,
 	POWER_INPUT,
 	MAX_SENSOR_TYPE,
 };
 
-static struct sensor_group {
+static struct sensor_type {
+	enum sensors type;
 	const char *name;
-	const char *compatible;
-	struct attribute_group group;
-	u32 attr_count;
-} sensor_groups[] = {
-	{"fan", "ibm,opal-sensor-cooling-fan"},
-	{"temp", "ibm,opal-sensor-amb-temp"},
-	{"in", "ibm,opal-sensor-power-supply"},
-	{"power", "ibm,opal-sensor-power"}
+	u32 count;
+} sensor_types[] = {
+	{ FAN,			"fan"	},
+	{ TEMP,			"temp"	},
+	{ POWER_SUPPLY,		"power"	},
+	{ POWER_INPUT,		"in"	},
+	{ MAX_SENSOR_TYPE,	NULL	}
 };
 
 struct sensor_data {
-	u32 id; /* An opaque id of the firmware for each sensor */
+	u32 data;
+	u32 status;
+	char label[MAX_LABEL_LEN];
 	enum sensors type;
-	char name[MAX_ATTR_LEN];
-	struct device_attribute dev_attr;
+	char attr_name[MAX_ATTRS][MAX_ATTR_LEN];
+	struct sensor_device_attribute sd_attrs[MAX_ATTRS];
 };
 
 struct platform_data {
-	const struct attribute_group *attr_groups[MAX_SENSOR_TYPE + 1];
+	struct attribute_group attr_group;
+	const struct attribute_group *groups[2];
 	u32 sensors_count; /* Total count of sensors from each group */
+	struct attribute **attrs;
+	struct sensor_data **sensors;
 };
 
 static ssize_t show_sensor(struct device *dev, struct device_attribute *devattr,
 			   char *buf)
 {
-	struct sensor_data *sdata = container_of(devattr, struct sensor_data,
-						 dev_attr);
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct platform_data *pdata = dev_get_drvdata(dev);
+	struct sensor_data *sdata = pdata->sensors[attr->index];
 	ssize_t ret;
 	u32 x;
 
-	ret = opal_get_sensor_data(sdata->id, &x);
+	ret = opal_get_sensor_data(sdata->data, &x);
 	if (ret)
 		return ret;
 
 	/* Convert temperature to milli-degrees */
-	if (sdata->type == AMBIENT_TEMP)
+	if (sdata->type == TEMP)
 		x *= 1000;
 	/* Convert power to micro-watts */
-	else if (sdata->type == POWER_INPUT)
+	else if (sdata->type == POWER_SUPPLY)
 		x *= 1000000;
 
 	return sprintf(buf, "%u\n", x);
 }
 
-static int get_sensor_index_attr(const char *name, u32 *index,
-					char *attr)
+static ssize_t show_alarm(struct device *dev, struct device_attribute *devattr,
+			   char *buf)
 {
-	char *hash_pos = strchr(name, '#');
-	char buf[8] = { 0 };
-	char *dash_pos;
-	u32 copy_len;
-	int err;
-
-	if (!hash_pos)
-		return -EINVAL;
-
-	dash_pos = strchr(hash_pos, '-');
-	if (!dash_pos)
-		return -EINVAL;
-
-	copy_len = dash_pos - hash_pos - 1;
-	if (copy_len >= sizeof(buf))
-		return -EINVAL;
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct platform_data *pdata = dev_get_drvdata(dev);
+	struct sensor_data *sdata = pdata->sensors[attr->index];
+	ssize_t ret;
+	u32 x;
 
-	strncpy(buf, hash_pos + 1, copy_len);
+	ret = opal_get_sensor_data(sdata->status, &x);
+	if (ret)
+		return ret;
 
-	err = kstrtou32(buf, 10, index);
-	if (err)
-		return err;
+	/*
+	 * Depending on the sensor type, the status bits can have
+	 * different meanings. Let's not be too subtil for the moment,
+	 * testing against 0x6 should raise an alarm.
+	 */
+	return sprintf(buf, "%u\n", x & 0x6);
+}
 
-	strncpy(attr, dash_pos + 1, MAX_ATTR_LEN);
+static ssize_t show_label(struct device *dev, struct device_attribute *devattr,
+			   char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct platform_data *pdata = dev_get_drvdata(dev);
+	struct sensor_data *sdata = pdata->sensors[attr->index];
 
-	return 0;
+	return sprintf(buf, "%s\n", sdata->label);
 }
 
-/*
- * This function translates the DT node name into the 'hwmon' attribute name.
- * IBMPOWERNV device node appear like cooling-fan#2-data, amb-temp#1-thrs etc.
- * which need to be mapped as fan2_input, temp1_max respectively before
- * populating them inside hwmon device class.
- */
-static int create_hwmon_attr_name(struct device *dev, enum sensors type,
-					 const char *node_name,
-					 char *hwmon_attr_name)
+static struct sensor_type *__init get_sensor_type(struct platform_device *pdev,
+	struct device_node *np)
 {
-	char attr_suffix[MAX_ATTR_LEN];
-	char *attr_name;
-	u32 index;
-	int err;
+	const char *type;
+	int i;
 
-	err = get_sensor_index_attr(node_name, &index, attr_suffix);
-	if (err) {
-		dev_err(dev, "Sensor device node name '%s' is invalid\n",
-			node_name);
-		return err;
-	}
+	if (np->name == NULL)
+		return NULL;
+
+	if (!of_device_is_compatible(np, "ibm,opal-sensor"))
+		return NULL;
 
-	if (!strcmp(attr_suffix, DT_FAULT_ATTR_SUFFIX)) {
-		attr_name = "fault";
-	} else if (!strcmp(attr_suffix, DT_DATA_ATTR_SUFFIX)) {
-		attr_name = "input";
-	} else if (!strcmp(attr_suffix, DT_THRESHOLD_ATTR_SUFFIX)) {
-		if (type == AMBIENT_TEMP)
-			attr_name = "max";
-		else if (type == FAN)
-			attr_name = "min";
-		else
-			return -ENOENT;
-	} else {
-		return -ENOENT;
+	if (of_property_read_string(np, "sensor-type", &type)) {
+		dev_info(&pdev->dev,
+			 "'sensor-type' missing in the node '%s'\n",
+			 np->name);
+		return NULL;
 	}
 
-	snprintf(hwmon_attr_name, MAX_ATTR_LEN, "%s%d_%s",
-		 sensor_groups[type].name, index, attr_name);
-	return 0;
+	for (i = 0 ; i < MAX_SENSOR_TYPE; i++)
+		if (!strcmp(type, sensor_types[i].name))
+			return &sensor_types[i];
+
+	return NULL;
 }
 
-static int populate_attr_groups(struct platform_device *pdev)
+static void __init make_sensor_label(struct device_node *np,
+		    struct sensor_data *sdata, const char *label)
 {
-	struct platform_data *pdata = platform_get_drvdata(pdev);
-	const struct attribute_group **pgroups = pdata->attr_groups;
-	struct device_node *opal, *np;
-	enum sensors type;
+	u32 id;
+	size_t n;
 
-	opal = of_find_node_by_path("/ibm,opal/sensors");
-	for_each_child_of_node(opal, np) {
-		if (np->name == NULL)
-			continue;
+	n = snprintf(sdata->label, sizeof(sdata->label), "%s", label);
 
-		for (type = 0; type < MAX_SENSOR_TYPE; type++)
-			if (of_device_is_compatible(np,
-					sensor_groups[type].compatible)) {
-				sensor_groups[type].attr_count++;
-				break;
-			}
-	}
+	/*
+	 * Core temp pretty pretty
+	 */
+	if (!of_property_read_u32(np, "ibm,pir", &id)) {
+		int i;
 
-	of_node_put(opal);
+		for_each_possible_cpu(i)
+			if (paca[i].hw_cpu_id == id)
+				break;
 
-	for (type = 0; type < MAX_SENSOR_TYPE; type++) {
-		sensor_groups[type].group.attrs = devm_kzalloc(&pdev->dev,
-					sizeof(struct attribute *) *
-					(sensor_groups[type].attr_count + 1),
-					GFP_KERNEL);
-		if (!sensor_groups[type].group.attrs)
-			return -ENOMEM;
-
-		pgroups[type] = &sensor_groups[type].group;
-		pdata->sensors_count += sensor_groups[type].attr_count;
-		sensor_groups[type].attr_count = 0;
+		n += snprintf(sdata->label + n, sizeof(sdata->label) - n,
+			      " %d-%d", i, i+7);
 	}
 
-	return 0;
+	/*
+	 * Membuffer pretty print
+	 */
+	if (!of_property_read_u32(np, "ibm,chip-id", &id))
+		n += snprintf(sdata->label + n, sizeof(sdata->label) - n,
+			      " %d", id & 0xffff);
 }
 
-/*
- * Iterate through the device tree for each child of 'sensors' node, create
- * a sysfs attribute file, the file is named by translating the DT node name
- * to the name required by the higher 'hwmon' driver like fan1_input, temp1_max
- * etc..
- */
-static int create_device_attrs(struct platform_device *pdev)
+static int __init populate_attr_groups(struct platform_device *pdev)
 {
 	struct platform_data *pdata = platform_get_drvdata(pdev);
-	const struct attribute_group **pgroups = pdata->attr_groups;
 	struct device_node *opal, *np;
-	struct sensor_data *sdata;
-	u32 sensor_id;
-	enum sensors type;
-	u32 count = 0;
 	int err = 0;
+	int i = 0;
 
 	opal = of_find_node_by_path("/ibm,opal/sensors");
-	sdata = devm_kzalloc(&pdev->dev, pdata->sensors_count * sizeof(*sdata),
-			     GFP_KERNEL);
-	if (!sdata) {
+	if (!opal) {
+		dev_dbg(&pdev->dev, "Opal node 'sensors' not found\n");
+		return -ENODEV;
+	}
+
+	for_each_child_of_node(opal, np) {
+		if (of_device_is_compatible(np, "ibm,opal-sensor"))
+			pdata->sensors_count++;
+	}
+
+	pdata->attrs = devm_kzalloc(&pdev->dev,
+	    sizeof(*pdata->attrs) * pdata->sensors_count * MAX_ATTRS + 1,
+	    GFP_KERNEL);
+	if (!pdata->attrs) {
+		err = -ENOMEM;
+		goto exit_put_node;
+	}
+	pdata->sensors = devm_kzalloc(&pdev->dev,
+	    sizeof(*pdata->sensors) * pdata->sensors_count * MAX_ATTRS + 1,
+	    GFP_KERNEL);
+	if (!pdata->sensors) {
 		err = -ENOMEM;
 		goto exit_put_node;
 	}
 
-	for_each_child_of_node(opal, np) {
-		if (np->name == NULL)
-			continue;
 
-		for (type = 0; type < MAX_SENSOR_TYPE; type++)
-			if (of_device_is_compatible(np,
-					sensor_groups[type].compatible))
-				break;
+	for_each_child_of_node(opal, np) {
+		struct sensor_data *sdata;
+		struct sensor_type *stype;
+		u32 sensor_data;
+		const char *label;
 
-		if (type == MAX_SENSOR_TYPE)
+		stype = get_sensor_type(pdev, np);
+		if (!stype)
 			continue;
 
-		if (of_property_read_u32(np, "sensor-id", &sensor_id)) {
+		if (of_property_read_u32(np, "sensor-data", &sensor_data)) {
 			dev_info(&pdev->dev,
-				 "'sensor-id' missing in the node '%s'\n",
+				 "'sensor-data' missing in the node '%s'\n",
 				 np->name);
 			continue;
 		}
 
-		sdata[count].id = sensor_id;
-		sdata[count].type = type;
-		err = create_hwmon_attr_name(&pdev->dev, type, np->name,
-					     sdata[count].name);
-		if (err)
+		sdata = devm_kzalloc(&pdev->dev, sizeof(*sdata), GFP_KERNEL);
+		if (sdata == NULL) {
+			err = -ENOMEM;
 			goto exit_put_node;
+		}
+
+		stype->count++;
+		sdata->data = sensor_data;
+		sdata->type = stype->type;
+
+		snprintf(sdata->attr_name[0], MAX_ATTR_LEN, "%s%d_input",
+			 stype->name, stype->count);
+
+		sysfs_attr_init(&sdata->sd_attrs[0].dev_attr.attr);
+		sdata->sd_attrs[0].dev_attr.attr.name = sdata->attr_name[0];
+		sdata->sd_attrs[0].dev_attr.attr.mode = S_IRUGO;
+		sdata->sd_attrs[0].dev_attr.show = show_sensor;
+		sdata->sd_attrs[0].index = i;
+
+		pdata->attrs[i] = &sdata->sd_attrs[0].dev_attr.attr;
+		pdata->sensors[i++] = sdata;
+
+		if (!of_property_read_u32(np, "sensor-status",
+					  &sdata->status)) {
+			snprintf(sdata->attr_name[1], MAX_ATTR_LEN,
+				 "%s%d_alarm", stype->name, stype->count);
+
+			sysfs_attr_init(&sdata->sd_attrs[1].dev_attr.attr);
+			sdata->sd_attrs[1].dev_attr.attr.name =
+				sdata->attr_name[1];
+			sdata->sd_attrs[1].dev_attr.attr.mode = S_IRUGO;
+			sdata->sd_attrs[1].dev_attr.show = show_alarm;
+			sdata->sd_attrs[1].index = i;
+
+			pdata->attrs[i] = &sdata->sd_attrs[1].dev_attr.attr;
+			pdata->sensors[i++] = sdata;
+		}
+
+		if (!of_property_read_string(np, "label", &label)) {
+			snprintf(sdata->attr_name[2], MAX_ATTR_LEN,
+				 "%s%d_label", stype->name, stype->count);
 
-		sysfs_attr_init(&sdata[count].dev_attr.attr);
-		sdata[count].dev_attr.attr.name = sdata[count].name;
-		sdata[count].dev_attr.attr.mode = S_IRUGO;
-		sdata[count].dev_attr.show = show_sensor;
+			make_sensor_label(np, sdata, label);
 
-		pgroups[type]->attrs[sensor_groups[type].attr_count++] =
-				&sdata[count++].dev_attr.attr;
+			sysfs_attr_init(&sdata->sd_attrs[2].dev_attr.attr);
+			sdata->sd_attrs[2].dev_attr.attr.name =
+				sdata->attr_name[2];
+			sdata->sd_attrs[2].dev_attr.attr.mode = S_IRUGO;
+			sdata->sd_attrs[2].dev_attr.show = show_label;
+			sdata->sd_attrs[2].index = i;
+
+			pdata->attrs[i] = &sdata->sd_attrs[2].dev_attr.attr;
+			pdata->sensors[i++] = sdata;
+		}
 	}
 
+	pdata->attr_group.attrs = pdata->attrs;
+	pdata->groups[0] = &pdata->attr_group;
+
 exit_put_node:
 	of_node_put(opal);
 	return err;
 }
 
-static int ibmpowernv_probe(struct platform_device *pdev)
+static int __init ibmpowernv_probe(struct platform_device *pdev)
 {
 	struct platform_data *pdata;
 	struct device *hwmon_dev;
@@ -288,15 +317,10 @@ static int ibmpowernv_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	/* Create sysfs attribute data for each sensor found in the DT */
-	err = create_device_attrs(pdev);
-	if (err)
-		return err;
-
 	/* Finally, register with hwmon */
 	hwmon_dev = devm_hwmon_device_register_with_groups(&pdev->dev, DRVNAME,
 							   pdata,
-							   pdata->attr_groups);
+							   pdata->groups);
 
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
-- 
1.7.10.4
