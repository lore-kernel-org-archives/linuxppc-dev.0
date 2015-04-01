Return-Path: <clg@fr.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 045951A0B33
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 21:15:57 +1100 (AEDT)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Wed, 1 Apr 2015 11:15:54 +0100
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: lm-sensors@lm-sensors.org
Subject: [PATCH 3/4] hwmon: (ibmpowernv) add a label attribute
Date: Wed,  1 Apr 2015 12:15:05 +0200
Message-Id: <1427883306-32528-4-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1426787085-9004-1-git-send-email-clg@fr.ibm.com>
References: <1426787085-9004-1-git-send-email-clg@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 Jean Delvare <jdelvare@suse.de>, Neelesh Gupta <neelegup@linux.vnet.ibm.com>,
 skiboot@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 Guenter Roeck <linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, sensors are only identified by their type and index.

The new OPAL device tree can expose extra properties to identify
some sensors by their name or location. This patch adds the creation
of a new hwmon *_label attribute when such properties are detected.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
 drivers/hwmon/ibmpowernv.c |   51 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index f38aa27343f2..be6fe559b52a 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -32,6 +32,7 @@
 #include <linux/err.h>
 
 #define MAX_ATTR_LEN	32
+#define MAX_LABEL_LEN	64
 
 /* Sensor suffix name from DT */
 #define DT_FAULT_ATTR_SUFFIX		"faulted"
@@ -68,6 +69,7 @@ struct sensor_data {
 	u32 hwmon_index;
 	u32 opal_index;
 	enum sensors type;
+	char label[MAX_LABEL_LEN];
 	char name[MAX_ATTR_LEN];
 	struct device_attribute dev_attr;
 };
@@ -99,6 +101,23 @@ static ssize_t show_sensor(struct device *dev, struct device_attribute *devattr,
 	return sprintf(buf, "%u\n", x);
 }
 
+static ssize_t show_label(struct device *dev, struct device_attribute *devattr,
+			   char *buf)
+{
+	struct sensor_data *sdata = container_of(devattr, struct sensor_data,
+						 dev_attr);
+
+	return sprintf(buf, "%s\n", sdata->label);
+}
+
+static void __init make_sensor_label(struct device_node *np,
+		    struct sensor_data *sdata, const char *label)
+{
+	size_t n;
+
+	n = snprintf(sdata->label, sizeof(sdata->label), "%s", label);
+}
+
 static int get_sensor_index_attr(const char *name, u32 *index,
 					char *attr)
 {
@@ -226,11 +245,21 @@ static int populate_attr_groups(struct platform_device *pdev)
 
 	opal = of_find_node_by_path("/ibm,opal/sensors");
 	for_each_child_of_node(opal, np) {
+		const char *label;
+
 		if (np->name == NULL)
 			continue;
 
 		type = get_sensor_type(np);
-		if (type != MAX_SENSOR_TYPE)
+		if (type == MAX_SENSOR_TYPE)
+			continue;
+
+		sensor_groups[type].attr_count++;
+
+		/*
+		 * add a new attribute for labels
+		 */
+		if (!of_property_read_string(np, "label", &label))
 			sensor_groups[type].attr_count++;
 	}
 
@@ -294,6 +323,7 @@ static int create_device_attrs(struct platform_device *pdev)
 	for_each_child_of_node(opal, np) {
 		const char *attr_name;
 		u32 opal_index;
+		const char *label;
 
 		if (np->name == NULL)
 			continue;
@@ -337,6 +367,25 @@ static int create_device_attrs(struct platform_device *pdev)
 
 		pgroups[type]->attrs[sensor_groups[type].attr_count++] =
 				&sdata[count++].dev_attr.attr;
+
+		if (!of_property_read_string(np, "label", &label)) {
+			/*
+			 * For the label attribute, we can reuse the
+			 * "properties" of the previous "input"
+			 * attribute. They are related to the same
+			 * sensor.
+			 */
+			sdata[count].type = type;
+			sdata[count].opal_index = sdata[count - 1].opal_index;
+			sdata[count].hwmon_index = sdata[count - 1].hwmon_index;
+
+			make_sensor_label(np, &sdata[count], label);
+
+			create_hwmon_attr(&sdata[count], "label", show_label);
+
+			pgroups[type]->attrs[sensor_groups[type].attr_count++] =
+				&sdata[count++].dev_attr.attr;
+		}
 	}
 
 exit_put_node:
-- 
1.7.10.4
