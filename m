Return-Path: <clg@fr.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DBA1A1A09DC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 04:44:58 +1100 (AEDT)
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Thu, 19 Mar 2015 17:44:55 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: lm-sensors@lm-sensors.org
Subject: [PATCH v2 2/5] hwmon: (ibmpowernv) add a get_sensor_type() routine
Date: Thu, 19 Mar 2015 18:44:42 +0100
Message-Id: <1426787085-9004-3-git-send-email-clg@fr.ibm.com>
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

It will help in adding different compatible properties, coming from a
new device tree layout for example.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
 drivers/hwmon/ibmpowernv.c |   26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

Index: linux.git/drivers/hwmon/ibmpowernv.c
===================================================================
--- linux.git.orig/drivers/hwmon/ibmpowernv.c
+++ linux.git/drivers/hwmon/ibmpowernv.c
@@ -169,6 +169,17 @@ static int create_hwmon_attr_name(struct
 	return 0;
 }
 
+static int get_sensor_type(struct device_node *np)
+{
+	enum sensors type;
+
+	for (type = 0; type < MAX_SENSOR_TYPE; type++) {
+		if (of_device_is_compatible(np, sensor_groups[type].compatible))
+			return type;
+	}
+	return MAX_SENSOR_TYPE;
+}
+
 static int populate_attr_groups(struct platform_device *pdev)
 {
 	struct platform_data *pdata = platform_get_drvdata(pdev);
@@ -181,12 +192,9 @@ static int populate_attr_groups(struct p
 		if (np->name == NULL)
 			continue;
 
-		for (type = 0; type < MAX_SENSOR_TYPE; type++)
-			if (of_device_is_compatible(np,
-					sensor_groups[type].compatible)) {
-				sensor_groups[type].attr_count++;
-				break;
-			}
+		type = get_sensor_type(np);
+		if (type != MAX_SENSOR_TYPE)
+			sensor_groups[type].attr_count++;
 	}
 
 	of_node_put(opal);
@@ -236,11 +244,7 @@ static int create_device_attrs(struct pl
 		if (np->name == NULL)
 			continue;
 
-		for (type = 0; type < MAX_SENSOR_TYPE; type++)
-			if (of_device_is_compatible(np,
-					sensor_groups[type].compatible))
-				break;
-
+		type = get_sensor_type(np);
 		if (type == MAX_SENSOR_TYPE)
 			continue;
 
