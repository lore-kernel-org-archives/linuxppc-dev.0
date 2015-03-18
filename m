Return-Path: <clg@fr.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 63BC51A02F4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 02:47:59 +1100 (AEDT)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Wed, 18 Mar 2015 15:47:55 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: lm-sensors@lm-sensors.org
Subject: [PATCH 3/5] hwmon: (ibmpowernv) add a convert_opal_attr_name() routine
Date: Wed, 18 Mar 2015 16:47:43 +0100
Message-Id: <1426693665-10797-4-git-send-email-clg@fr.ibm.com>
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

It simplifies the create_hwmon_attr_name() routine and it clearly isolates
the conversion done between the OPAL node names and hwmon attributes names.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
 drivers/hwmon/ibmpowernv.c |   39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index 07a8219b7f4e..edcc4ffa5ad0 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -127,6 +127,28 @@ static int get_sensor_index_attr(const char *name, u32 *index,
 	return 0;
 }
 
+static const char *convert_opal_attr_name(enum sensors type,
+					const char *opal_attr)
+{
+	const char *attr_name = NULL;
+
+	if (!strcmp(opal_attr, DT_FAULT_ATTR_SUFFIX)) {
+		attr_name = "fault";
+	} else if (!strcmp(opal_attr, DT_DATA_ATTR_SUFFIX)) {
+		attr_name = "input";
+	} else if (!strcmp(opal_attr, DT_THRESHOLD_ATTR_SUFFIX)) {
+		if (type == TEMP)
+			attr_name = "max";
+		else if (type == FAN)
+			attr_name = "min";
+		else
+			return NULL;
+	} else {
+		return NULL;
+	}
+	return attr_name;
+}
+
 /*
  * This function translates the DT node name into the 'hwmon' attribute name.
  * IBMPOWERNV device node appear like cooling-fan#2-data, amb-temp#1-thrs etc.
@@ -138,7 +160,7 @@ static int create_hwmon_attr_name(struct device *dev, enum sensors type,
 					 char *hwmon_attr_name)
 {
 	char attr_suffix[MAX_ATTR_LEN];
-	char *attr_name;
+	const char *attr_name;
 	u32 index;
 	int err;
 
@@ -149,20 +171,9 @@ static int create_hwmon_attr_name(struct device *dev, enum sensors type,
 		return err;
 	}
 
-	if (!strcmp(attr_suffix, DT_FAULT_ATTR_SUFFIX)) {
-		attr_name = "fault";
-	} else if (!strcmp(attr_suffix, DT_DATA_ATTR_SUFFIX)) {
-		attr_name = "input";
-	} else if (!strcmp(attr_suffix, DT_THRESHOLD_ATTR_SUFFIX)) {
-		if (type == TEMP)
-			attr_name = "max";
-		else if (type == FAN)
-			attr_name = "min";
-		else
-			return -ENOENT;
-	} else {
+	attr_name = convert_opal_attr_name(type, attr_suffix);
+	if (!attr_name)
 		return -ENOENT;
-	}
 
 	snprintf(hwmon_attr_name, MAX_ATTR_LEN, "%s%d_%s",
 		 sensor_groups[type].name, index, attr_name);
-- 
1.7.10.4
