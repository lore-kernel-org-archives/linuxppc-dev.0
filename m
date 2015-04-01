Return-Path: <clg@fr.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 688F51A0960
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 21:15:55 +1100 (AEDT)
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Wed, 1 Apr 2015 11:15:51 +0100
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: lm-sensors@lm-sensors.org
Subject: [PATCH 1/4] hwmon: (ibmpowernv) add a helper routine create_hwmon_attr
Date: Wed,  1 Apr 2015 12:15:03 +0200
Message-Id: <1427883306-32528-2-git-send-email-clg@fr.ibm.com>
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

This should shorten a bit the code necessary to create a hmwon attribute.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
 drivers/hwmon/ibmpowernv.c |   23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index a6e7245f172d..c9aa4d837c6f 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -232,6 +232,20 @@ static int populate_attr_groups(struct platform_device *pdev)
 	return 0;
 }
 
+static void create_hwmon_attr(struct sensor_data *sdata, const char *attr_name,
+	ssize_t (*show)(struct device *dev, struct device_attribute *attr,
+			char *buf))
+{
+	snprintf(sdata->name, MAX_ATTR_LEN, "%s%d_%s",
+		 sensor_groups[sdata->type].name, sdata->hwmon_index,
+		 attr_name);
+
+	sysfs_attr_init(&sdata->dev_attr.attr);
+	sdata->dev_attr.attr.name = sdata->name;
+	sdata->dev_attr.attr.mode = S_IRUGO;
+	sdata->dev_attr.show = show;
+}
+
 /*
  * Iterate through the device tree for each child of 'sensors' node, create
  * a sysfs attribute file, the file is named by translating the DT node name
@@ -290,14 +304,7 @@ static int create_device_attrs(struct platform_device *pdev)
 		sdata[count].hwmon_index =
 			get_sensor_hwmon_index(&sdata[count], sdata, count);
 
-		snprintf(sdata[count].name, MAX_ATTR_LEN, "%s%d_%s",
-			 sensor_groups[type].name, sdata[count].hwmon_index,
-			 attr_name);
-
-		sysfs_attr_init(&sdata[count].dev_attr.attr);
-		sdata[count].dev_attr.attr.name = sdata[count].name;
-		sdata[count].dev_attr.attr.mode = S_IRUGO;
-		sdata[count].dev_attr.show = show_sensor;
+		create_hwmon_attr(&sdata[count], attr_name, show_sensor);
 
 		pgroups[type]->attrs[sensor_groups[type].attr_count++] =
 				&sdata[count++].dev_attr.attr;
-- 
1.7.10.4
