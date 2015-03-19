Return-Path: <clg@fr.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 633BC1A09D8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 04:45:00 +1100 (AEDT)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Thu, 19 Mar 2015 17:44:57 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: lm-sensors@lm-sensors.org
Subject: [PATCH v2 4/5] hwmon: (ibmpowernv) change create_hwmon_attr_name()
 prototype
Date: Thu, 19 Mar 2015 18:44:44 +0100
Message-Id: <1426787085-9004-5-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
References: <1423117857-32759-1-git-send-email-clg@fr.ibm.com>
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

It simplifies the creation of the hwmon attributes and will help when
support for a new device tree layout is added. The patch also changes
the name of the routine to parse_opal_node_name().

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---

Changes since v1:

 - changed returned value of parse_opal_node_name()
 - used *_PTR macros to check for errors

 drivers/hwmon/ibmpowernv.c |   37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

Index: linux.git/drivers/hwmon/ibmpowernv.c
===================================================================
--- linux.git.orig/drivers/hwmon/ibmpowernv.c
+++ linux.git/drivers/hwmon/ibmpowernv.c
@@ -152,29 +152,22 @@ static const char *convert_opal_attr_nam
  * which need to be mapped as fan2_input, temp1_max respectively before
  * populating them inside hwmon device class.
  */
-static int create_hwmon_attr_name(struct device *dev, enum sensors type,
-					 const char *node_name,
-					 char *hwmon_attr_name)
+static const char *parse_opal_node_name(const char *node_name,
+					enum sensors type, u32 *index)
 {
 	char attr_suffix[MAX_ATTR_LEN];
 	const char *attr_name;
-	u32 index;
 	int err;
 
-	err = get_sensor_index_attr(node_name, &index, attr_suffix);
-	if (err) {
-		dev_err(dev, "Sensor device node name '%s' is invalid\n",
-			node_name);
-		return err;
-	}
+	err = get_sensor_index_attr(node_name, index, attr_suffix);
+	if (err)
+		return ERR_PTR(err);
 
 	attr_name = convert_opal_attr_name(type, attr_suffix);
 	if (!attr_name)
-		return -ENOENT;
+		return ERR_PTR(-ENOENT);
 
-	snprintf(hwmon_attr_name, MAX_ATTR_LEN, "%s%d_%s",
-		 sensor_groups[type].name, index, attr_name);
-	return 0;
+	return attr_name;
 }
 
 static int get_sensor_type(struct device_node *np)
@@ -249,6 +242,9 @@ static int create_device_attrs(struct pl
 	}
 
 	for_each_child_of_node(opal, np) {
+		const char *attr_name;
+		u32 opal_index;
+
 		if (np->name == NULL)
 			continue;
 
@@ -265,10 +261,17 @@ static int create_device_attrs(struct pl
 
 		sdata[count].id = sensor_id;
 		sdata[count].type = type;
-		err = create_hwmon_attr_name(&pdev->dev, type, np->name,
-					     sdata[count].name);
-		if (err)
+
+		attr_name = parse_opal_node_name(np->name, type, &opal_index);
+		if (IS_ERR(attr_name)) {
+			dev_err(&pdev->dev, "Sensor device node name '%s' is invalid\n",
+				np->name);
+			err = IS_ERR(attr_name);
 			goto exit_put_node;
+		}
+
+		snprintf(sdata[count].name, MAX_ATTR_LEN, "%s%d_%s",
+			 sensor_groups[type].name, opal_index, attr_name);
 
 		sysfs_attr_init(&sdata[count].dev_attr.attr);
 		sdata[count].dev_attr.attr.name = sdata[count].name;
