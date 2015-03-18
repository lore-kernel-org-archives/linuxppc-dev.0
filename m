Return-Path: <clg@fr.ibm.com>
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 727C81A051A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 02:47:59 +1100 (AEDT)
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Wed, 18 Mar 2015 15:47:56 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: lm-sensors@lm-sensors.org
Subject: [PATCH 4/5] hwmon: (ibmpowernv) change create_hwmon_attr_name()
 prototype
Date: Wed, 18 Mar 2015 16:47:44 +0100
Message-Id: <1426693665-10797-5-git-send-email-clg@fr.ibm.com>
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
 drivers/hwmon/ibmpowernv.c |   32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index edcc4ffa5ad0..570d2360b698 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -155,28 +155,22 @@ static const char *convert_opal_attr_name(enum sensors type,
  * which need to be mapped as fan2_input, temp1_max respectively before
  * populating them inside hwmon device class.
  */
-static int create_hwmon_attr_name(struct device *dev, enum sensors type,
-					 const char *node_name,
-					 char *hwmon_attr_name)
+static int parse_opal_node_name(const char *node_name, enum sensors type,
+	u32 *index, const char **hwmon_attr_name)
 {
 	char attr_suffix[MAX_ATTR_LEN];
 	const char *attr_name;
-	u32 index;
 	int err;
 
-	err = get_sensor_index_attr(node_name, &index, attr_suffix);
-	if (err) {
-		dev_err(dev, "Sensor device node name '%s' is invalid\n",
-			node_name);
+	err = get_sensor_index_attr(node_name, index, attr_suffix);
+	if (err)
 		return err;
-	}
 
 	attr_name = convert_opal_attr_name(type, attr_suffix);
 	if (!attr_name)
 		return -ENOENT;
 
-	snprintf(hwmon_attr_name, MAX_ATTR_LEN, "%s%d_%s",
-		 sensor_groups[type].name, index, attr_name);
+	*hwmon_attr_name = attr_name;
 	return 0;
 }
 
@@ -252,6 +246,9 @@ static int create_device_attrs(struct platform_device *pdev)
 	}
 
 	for_each_child_of_node(opal, np) {
+		const char *attr_name;
+		u32 opal_index;
+
 		if (np->name == NULL)
 			continue;
 
@@ -268,10 +265,17 @@ static int create_device_attrs(struct platform_device *pdev)
 
 		sdata[count].id = sensor_id;
 		sdata[count].type = type;
-		err = create_hwmon_attr_name(&pdev->dev, type, np->name,
-					     sdata[count].name);
-		if (err)
+
+		err = parse_opal_node_name(np->name, type, &opal_index,
+					   &attr_name);
+		if (err) {
+			dev_err(&pdev->dev, "Sensor device node name '%s' is invalid\n",
+				np->name);
 			goto exit_put_node;
+		}
+
+		snprintf(sdata[count].name, MAX_ATTR_LEN, "%s%d_%s",
+			 sensor_groups[type].name, opal_index, attr_name);
 
 		sysfs_attr_init(&sdata[count].dev_attr.attr);
 		sdata[count].dev_attr.attr.name = sdata[count].name;
-- 
1.7.10.4
