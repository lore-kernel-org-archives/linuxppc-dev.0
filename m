Return-Path: <clg@fr.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9BAEC1A096D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 21:15:58 +1100 (AEDT)
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Wed, 1 Apr 2015 11:15:55 +0100
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: lm-sensors@lm-sensors.org
Subject: [PATCH 4/4] hwmon: (ibmpowernv) pretty print labels
Date: Wed,  1 Apr 2015 12:15:06 +0200
Message-Id: <1427883306-32528-5-git-send-email-clg@fr.ibm.com>
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

The new OPAL device tree adds a few properties which can be used to add
extra information on the sensor label.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
 drivers/hwmon/ibmpowernv.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index be6fe559b52a..3e753c215b40 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -113,9 +113,31 @@ static ssize_t show_label(struct device *dev, struct device_attribute *devattr,
 static void __init make_sensor_label(struct device_node *np,
 		    struct sensor_data *sdata, const char *label)
 {
+	u32 id;
 	size_t n;
 
 	n = snprintf(sdata->label, sizeof(sdata->label), "%s", label);
+
+	/*
+	 * Core temp pretty print
+	 */
+	if (!of_property_read_u32(np, "ibm,pir", &id)) {
+		int i;
+
+		for_each_possible_cpu(i)
+			if (paca[i].hw_cpu_id == id)
+				break;
+
+		n += snprintf(sdata->label + n, sizeof(sdata->label) - n,
+			      " %d-%d", i, i+7);
+	}
+
+	/*
+	 * Membuffer pretty print
+	 */
+	if (!of_property_read_u32(np, "ibm,chip-id", &id))
+		n += snprintf(sdata->label + n, sizeof(sdata->label) - n,
+			      " %d", id & 0xffff);
 }
 
 static int get_sensor_index_attr(const char *name, u32 *index,
-- 
1.7.10.4
