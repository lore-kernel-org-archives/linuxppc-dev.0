Return-Path: <clg@fr.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1BA041A0757
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 03:20:03 +1000 (AEST)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Wed, 8 Apr 2015 18:20:00 +0100
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: lm-sensors@lm-sensors.org
Subject: [PATCH v5 4/4] hwmon: (ibmpowernv) pretty print labels
Date: Wed,  8 Apr 2015 19:19:50 +0200
Message-Id: <1428513590-5773-5-git-send-email-clg@fr.ibm.com>
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

 Changes since v4:

 - fixed comparison between signed and unsigned integer in 
   get_logical_cpu()

 Changes since v3:

 - removed error message in case of an unknown physical cpu number

 Changes since v2:

 - fix bogus logical cpu retrieval 
 - use 'threads_per_core' to print out cpu range

 Changes since v1:

 - check cpu validity before printing out the attribute label. 
   if invalid, use a "phy" prefix to distinguish a linux cpu 
   number from a physical cpu number. 

 drivers/hwmon/ibmpowernv.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index 9e8f93c9c475..7f16f1b1a571 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -30,6 +30,7 @@
 #include <linux/platform_device.h>
 #include <asm/opal.h>
 #include <linux/err.h>
+#include <asm/cputhreads.h>
 
 #define MAX_ATTR_LEN	32
 #define MAX_LABEL_LEN	64
@@ -112,13 +113,53 @@ static ssize_t show_label(struct device *dev, struct device_attribute *devattr,
 	return sprintf(buf, "%s\n", sdata->label);
 }
 
+static int __init get_logical_cpu(int hwcpu)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		if (get_hard_smp_processor_id(cpu) == hwcpu)
+			return cpu;
+
+	return -ENOENT;
+}
+
 static void __init make_sensor_label(struct device_node *np,
 				     struct sensor_data *sdata,
 				     const char *label)
 {
+	u32 id;
 	size_t n;
 
 	n = snprintf(sdata->label, sizeof(sdata->label), "%s", label);
+
+	/*
+	 * Core temp pretty print
+	 */
+	if (!of_property_read_u32(np, "ibm,pir", &id)) {
+		int cpuid = get_logical_cpu(id);
+
+		if (cpuid >= 0)
+			/*
+			 * The digital thermal sensors are associated
+			 * with a core. Let's print out the range of
+			 * cpu ids corresponding to the hardware
+			 * threads of the core.
+			 */
+			n += snprintf(sdata->label + n,
+				      sizeof(sdata->label) - n, " %d-%d",
+				      cpuid, cpuid + threads_per_core - 1);
+		else
+			n += snprintf(sdata->label + n,
+				      sizeof(sdata->label) - n, " phy%d", id);
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
