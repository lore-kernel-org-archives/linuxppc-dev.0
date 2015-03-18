Return-Path: <clg@fr.ibm.com>
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ED2281A08EE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 02:47:59 +1100 (AEDT)
Received: from /spool/local
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Wed, 18 Mar 2015 15:47:56 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: lm-sensors@lm-sensors.org
Subject: [PATCH 5/5] hwmon: (ibmpowernv) do not use the OPAL index for hwmon
 attribute names
Date: Wed, 18 Mar 2015 16:47:45 +0100
Message-Id: <1426693665-10797-6-git-send-email-clg@fr.ibm.com>
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

The current OPAL firmware exposes the different sensors of an IBM Power
system using the node names such as :

	sensors/amb-temp#1-data
	sensors/amb-temp#1-thrs
	cooling-fan#1-data
	cooling-fan#1-faulted
	cooling-fan#1-thrs
	cooling-fan#2-data
	...

The ibmpowernv driver, when loaded, parses these names to extract the
sensor index and the sensor attribute name. Unfortunately, this scheme
makes it difficult to add sensors with a different layout (specially of
the same type, like temperature) as the sensor index calculated in OPAL
is directly used in the hwmon sysfs interface.

What this patch does is add a independent hwmon index for each sensor.
The increment of the hwmon index (temp, fan, power, etc.) is kept per
sensor type in the sensor_group table. The sensor_data table is used
to store the association of the hwmon and OPAL indexes, as we need to
have the same hwmon index for different attributes of a same sensor.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
 drivers/hwmon/ibmpowernv.c |   23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index 570d2360b698..ffcebc9d8bf5 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -55,6 +55,7 @@ static struct sensor_group {
 	const char *compatible;
 	struct attribute_group group;
 	u32 attr_count;
+	u32 hwmon_index;
 } sensor_groups[] = {
 	{"fan", "ibm,opal-sensor-cooling-fan"},
 	{"temp", "ibm,opal-sensor-amb-temp"},
@@ -64,6 +65,8 @@ static struct sensor_group {
 
 struct sensor_data {
 	u32 id; /* An opaque id of the firmware for each sensor */
+	u32 hwmon_index;
+	u32 opal_index;
 	enum sensors type;
 	char name[MAX_ATTR_LEN];
 	struct device_attribute dev_attr;
@@ -185,6 +188,19 @@ static int get_sensor_type(struct device_node *np)
 	return MAX_SENSOR_TYPE;
 }
 
+static u32 get_sensor_hwmon_index(struct sensor_data *sdata,
+	struct sensor_data *sdata_table, int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		if (sdata_table[i].opal_index == sdata->opal_index &&
+		    sdata_table[i].type == sdata->type)
+			return sdata_table[i].hwmon_index;
+
+	return ++sensor_groups[sdata->type].hwmon_index;
+}
+
 static int populate_attr_groups(struct platform_device *pdev)
 {
 	struct platform_data *pdata = platform_get_drvdata(pdev);
@@ -274,8 +290,13 @@ static int create_device_attrs(struct platform_device *pdev)
 			goto exit_put_node;
 		}
 
+		sdata[count].opal_index = opal_index;
+		sdata[count].hwmon_index =
+			get_sensor_hwmon_index(&sdata[count], sdata, count);
+
 		snprintf(sdata[count].name, MAX_ATTR_LEN, "%s%d_%s",
-			 sensor_groups[type].name, opal_index, attr_name);
+			 sensor_groups[type].name, sdata[count].hwmon_index,
+			 attr_name);
 
 		sysfs_attr_init(&sdata[count].dev_attr.attr);
 		sdata[count].dev_attr.attr.name = sdata[count].name;
-- 
1.7.10.4
