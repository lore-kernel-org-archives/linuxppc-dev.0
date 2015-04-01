Return-Path: <clg@fr.ibm.com>
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3726E1A0AA4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 21:15:57 +1100 (AEDT)
Received: from /spool/local
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Wed, 1 Apr 2015 11:15:53 +0100
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: lm-sensors@lm-sensors.org
Subject: [PATCH 2/4] hwmon: (ibmpowernv) add support for the new device tree
Date: Wed,  1 Apr 2015 12:15:04 +0200
Message-Id: <1427883306-32528-3-git-send-email-clg@fr.ibm.com>
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

The new OPAL device tree for sensors has a different layout and uses new
property names, for the type and for the handler used to capture the
sensor data.

This patch modifies the ibmpowernv driver to support such a tree in a
way preserving compatibility with older OPAL firmwares.

This is achieved by changing the error path of the routine parsing
an OPAL node name. The node is simply considered being from the new
device tree layout and fallback values are used.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
 drivers/hwmon/ibmpowernv.c |   47 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index c9aa4d837c6f..f38aa27343f2 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -176,11 +176,26 @@ static const char *parse_opal_node_name(const char *node_name,
 static int get_sensor_type(struct device_node *np)
 {
 	enum sensors type;
+	const char *str;
 
 	for (type = 0; type < MAX_SENSOR_TYPE; type++) {
 		if (of_device_is_compatible(np, sensor_groups[type].compatible))
 			return type;
 	}
+
+	/*
+	 * Let's check if we have a newer device tree
+	 */
+	if (!of_device_is_compatible(np, "ibm,opal-sensor"))
+		return MAX_SENSOR_TYPE;
+
+	if (of_property_read_string(np, "sensor-type", &str))
+		return MAX_SENSOR_TYPE;
+
+	for (type = 0; type < MAX_SENSOR_TYPE; type++)
+		if (!strcmp(str, sensor_groups[type].name))
+			return type;
+
 	return MAX_SENSOR_TYPE;
 }
 
@@ -189,11 +204,16 @@ static u32 get_sensor_hwmon_index(struct sensor_data *sdata,
 {
 	int i;
 
-	for (i = 0; i < count; i++)
-		if (sdata_table[i].opal_index == sdata->opal_index &&
-		    sdata_table[i].type == sdata->type)
-			return sdata_table[i].hwmon_index;
+	/*
+	 * We don't use the OPAL index on newer device trees
+	 */
+	if (sdata->opal_index != -1) {
+		for (i = 0; i < count; i++)
+			if (sdata_table[i].opal_index == sdata->opal_index &&
+			    sdata_table[i].type == sdata->type)
+				return sdata_table[i].hwmon_index;
 
+	}
 	return ++sensor_groups[sdata->type].hwmon_index;
 }
 
@@ -282,7 +302,12 @@ static int create_device_attrs(struct platform_device *pdev)
 		if (type == MAX_SENSOR_TYPE)
 			continue;
 
-		if (of_property_read_u32(np, "sensor-id", &sensor_id)) {
+		/*
+		 * Newer device trees use a "sensor-data" property
+		 * name for input.
+		 */
+		if (of_property_read_u32(np, "sensor-id", &sensor_id) &&
+		    of_property_read_u32(np, "sensor-data", &sensor_id)) {
 			dev_info(&pdev->dev,
 				 "'sensor-id' missing in the node '%s'\n",
 				 np->name);
@@ -292,12 +317,16 @@ static int create_device_attrs(struct platform_device *pdev)
 		sdata[count].id = sensor_id;
 		sdata[count].type = type;
 
+		/*
+		 * If we can not parse the node name, it means we are
+		 * running on a newer device tree. We can just forget
+		 * about the OPAL index and use a defaut value for the
+		 * hwmon attribute name
+		 */
 		attr_name = parse_opal_node_name(np->name, type, &opal_index);
 		if (IS_ERR(attr_name)) {
-			dev_err(&pdev->dev, "Sensor device node name '%s' is invalid\n",
-				np->name);
-			err = PTR_ERR(attr_name);
-			goto exit_put_node;
+			attr_name = "input";
+			opal_index = -1;
 		}
 
 		sdata[count].opal_index = opal_index;
-- 
1.7.10.4
