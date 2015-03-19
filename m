Return-Path: <clg@fr.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3AEF11A09EC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 04:44:58 +1100 (AEDT)
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Thu, 19 Mar 2015 17:44:55 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: lm-sensors@lm-sensors.org
Subject: [PATCH v2 1/5] hwmon: (ibmpowernv) replace AMBIENT_TEMP by TEMP
Date: Thu, 19 Mar 2015 18:44:41 +0100
Message-Id: <1426787085-9004-2-git-send-email-clg@fr.ibm.com>
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

Ambient is too restrictive as there can be other temperature channels :
core, memory, etc.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
 drivers/hwmon/ibmpowernv.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux.git/drivers/hwmon/ibmpowernv.c
===================================================================
--- linux.git.orig/drivers/hwmon/ibmpowernv.c
+++ linux.git/drivers/hwmon/ibmpowernv.c
@@ -44,7 +44,7 @@
  */
 enum sensors {
 	FAN,
-	AMBIENT_TEMP,
+	TEMP,
 	POWER_SUPPLY,
 	POWER_INPUT,
 	MAX_SENSOR_TYPE,
@@ -87,7 +87,7 @@ static ssize_t show_sensor(struct device
 		return ret;
 
 	/* Convert temperature to milli-degrees */
-	if (sdata->type == AMBIENT_TEMP)
+	if (sdata->type == TEMP)
 		x *= 1000;
 	/* Convert power to micro-watts */
 	else if (sdata->type == POWER_INPUT)
@@ -154,7 +154,7 @@ static int create_hwmon_attr_name(struct
 	} else if (!strcmp(attr_suffix, DT_DATA_ATTR_SUFFIX)) {
 		attr_name = "input";
 	} else if (!strcmp(attr_suffix, DT_THRESHOLD_ATTR_SUFFIX)) {
-		if (type == AMBIENT_TEMP)
+		if (type == TEMP)
 			attr_name = "max";
 		else if (type == FAN)
 			attr_name = "min";
