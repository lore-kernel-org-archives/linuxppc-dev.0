Return-Path: <clg@fr.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7E6B61A0145
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 00:46:14 +1000 (AEST)
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Tue, 7 Apr 2015 15:46:10 +0100
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: lm-sensors@lm-sensors.org
Subject: [PATCH 4/4] hwmon: (ibmpowernv) pretty print labels
Date: Tue,  7 Apr 2015 16:45:56 +0200
Message-Id: <1428417956-28617-1-git-send-email-clg@fr.ibm.com>
In-Reply-To: <5523ECC4.9010609@fr.ibm.com>
References: <5523ECC4.9010609@fr.ibm.com>
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

In the case of a cpu core sensor, the firmware exposes the physical 
identifier of the core in the "ibm,pir" property. The driver 
translates this identifier in a linux cpu number and prints out a 
range corresponding to the hardware threads of the core (as they
share the same sensor).

The numbering gives a hint on the localization of the core in the 
system (which socket, which chip). 

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---

 Changes since v1:

 - check cpu validity before printing out the attribute label. 
   if invalid, use a "phy" prefix to distinguish a linux cpu 
   number from a physical cpu number. 

 drivers/hwmon/ibmpowernv.c |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

Index: linux.git/drivers/hwmon/ibmpowernv.c
===================================================================
--- linux.git.orig/drivers/hwmon/ibmpowernv.c
+++ linux.git/drivers/hwmon/ibmpowernv.c
@@ -113,9 +113,43 @@ static ssize_t show_label(struct device
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
+		int i = -1;
+
+		for_each_possible_cpu(i)
+			if (paca[i].hw_cpu_id == id)
+				break;
+
+		if (i != -1)
+			/*
+			 * The digital thermal sensors are associated
+			 * with a core. Let's print out the range of
+			 * cpu ids corresponding to the hardware
+			 * threads of the core.
+			 */
+			n += snprintf(sdata->label + n,
+				      sizeof(sdata->label) - n,
+				      " %d-%d", i, i+7);
+		else
+			n += snprintf(sdata->label + n,
+				      sizeof(sdata->label) - n,
+				      " phy%d", id);
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
