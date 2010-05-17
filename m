Return-Path: <jeff@theptrgroup.com>
Received: from mail.theptrgroup.com (mail.theptrgroup.com [71.178.251.9])
	by ozlabs.org (Postfix) with ESMTP id D3496B7D74
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 May 2010 06:30:43 +1000 (EST)
Message-ID: <4BF1A760.2010707@theptrgroup.com>
Date: Mon, 17 May 2010 16:30:24 -0400
From: Jeff Angielski <jeff@theptrgroup.com>
MIME-Version: 1.0
To: Andre Prendel <andre.prendel@gmx.de>, linuxppc-dev@lists.ozlabs.org,
	Jeff Angielski <jeff@theptrgroup.com>, lm-sensors@lm-sensors.org
Subject: [PATCH] hwmon: (tmp421) Add nfactor support  (2nd attempt)
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Here is a second attempt at a patch to add nfactor support to the tmp421 driver.

This includes the changes as suggested by Andre Prendel, the original driver author.


>From 8ebe84174ff6bd294656d77183758044f19d8900 Mon Sep 17 00:00:00 2001
From: Jeff Angielski <jeff@theptrgroup.com>
Date: Mon, 10 May 2010 10:26:34 -0400
Subject: [PATCH] hwmon: (tmp421) Add nfactor support

Add support for reading and writing the n-factor correction
registers.  This is needed to compensate for the characteristics
of a particular sensor hanging off of the remote channels.

Signed-off-by: Jeff Angielski <jeff@theptrgroup.com>
---
 drivers/hwmon/tmp421.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
index 738c472..ce1f6d1 100644
--- a/drivers/hwmon/tmp421.c
+++ b/drivers/hwmon/tmp421.c
@@ -49,6 +49,7 @@ enum chips { tmp421, tmp422, tmp423 };
 
 static const u8 TMP421_TEMP_MSB[4]		= { 0x00, 0x01, 0x02, 0x03 };
 static const u8 TMP421_TEMP_LSB[4]		= { 0x10, 0x11, 0x12, 0x13 };
+static const u8 TMP421_NFACTOR[3]		= { 0x21, 0x22, 0x23 };
 
 /* Flags */
 #define TMP421_CONFIG_SHUTDOWN			0x40
@@ -76,6 +77,7 @@ struct tmp421_data {
 	int channels;
 	u8 config;
 	s16 temp[4];
+	s8 nfactor[3];
 };
 
 static int temp_from_s16(s16 reg)
@@ -115,6 +117,10 @@ static struct tmp421_data *tmp421_update_device(struct device *dev)
 			data->temp[i] |= i2c_smbus_read_byte_data(client,
 				TMP421_TEMP_LSB[i]);
 		}
+		for (i = 1; i < data->channels; i++) {
+			data->nfactor[i - 1] = i2c_smbus_read_byte_data(client,
+				TMP421_NFACTOR[i - 1]);
+		}
 		data->last_updated = jiffies;
 		data->valid = 1;
 	}
@@ -157,6 +163,32 @@ static ssize_t show_fault(struct device *dev,
 		return sprintf(buf, "0\n");
 }
 
+static ssize_t show_nfactor(struct device *dev,
+			  struct device_attribute *devattr, char *buf)
+{
+	int index = to_sensor_dev_attr(devattr)->index;
+	struct tmp421_data *data = tmp421_update_device(dev);
+
+	return sprintf(buf, "%d\n", data->nfactor[index - 1]);
+}
+
+static ssize_t set_nfactor(struct device *dev,
+		struct device_attribute *devattr,
+		const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct tmp421_data *data = i2c_get_clientdata(client);
+	int index = to_sensor_dev_attr(devattr)->index;
+	int nfactor = simple_strtol(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	i2c_smbus_write_byte_data(client, TMP421_NFACTOR[index - 1],
+			SENSORS_LIMIT(nfactor, -128, 127));
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
 static mode_t tmp421_is_visible(struct kobject *kobj, struct attribute *a,
 				int n)
 {
@@ -177,19 +209,28 @@ static mode_t tmp421_is_visible(struct kobject *kobj, struct attribute *a,
 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_value, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp_value, NULL, 1);
 static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_fault, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp2_nfactor, S_IRUSR | S_IWUSR | S_IRGRP,
+		show_nfactor, set_nfactor, 1);
 static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp_value, NULL, 2);
 static SENSOR_DEVICE_ATTR(temp3_fault, S_IRUGO, show_fault, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp3_nfactor, S_IRUSR | S_IWUSR | S_IRGRP,
+		show_nfactor, set_nfactor, 2);
 static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_temp_value, NULL, 3);
 static SENSOR_DEVICE_ATTR(temp4_fault, S_IRUGO, show_fault, NULL, 3);
+static SENSOR_DEVICE_ATTR(temp4_nfactor, S_IRUSR | S_IWUSR | S_IRGRP,
+		show_nfactor, set_nfactor, 3);
 
 static struct attribute *tmp421_attr[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_temp2_input.dev_attr.attr,
 	&sensor_dev_attr_temp2_fault.dev_attr.attr,
+	&sensor_dev_attr_temp2_nfactor.dev_attr.attr,
 	&sensor_dev_attr_temp3_input.dev_attr.attr,
 	&sensor_dev_attr_temp3_fault.dev_attr.attr,
+	&sensor_dev_attr_temp3_nfactor.dev_attr.attr,
 	&sensor_dev_attr_temp4_input.dev_attr.attr,
 	&sensor_dev_attr_temp4_fault.dev_attr.attr,
+	&sensor_dev_attr_temp4_nfactor.dev_attr.attr,
 	NULL
 };
 
-- 
Jeff Angielski
The PTR Group
www.theptrgroup.com
