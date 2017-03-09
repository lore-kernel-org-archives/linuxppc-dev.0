Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vf7xg1cSnzDqXh
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Mar 2017 22:50:31 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v29BiFTt120424
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Mar 2017 06:50:28 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 292yb0h5sr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Mar 2017 06:50:27 -0500
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 9 Mar 2017 21:50:24 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v29BoE4840239112
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Mar 2017 22:50:22 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v29BnnFb012058
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Mar 2017 22:49:50 +1100
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com,
 akshay.adiga@linux.vnet.ibm.com, andrew@aj.id.au, clg@kaod.org,
 maddy@linux.vnet.ibm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [RFC 1/2] powerpc/powernv: Enable support for OCC inband platform
 sensors
Date: Thu,  9 Mar 2017 17:19:14 +0530
In-Reply-To: <1489060155-22086-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1489060155-22086-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Message-Id: <1489060155-22086-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In P9, OCC writes the platform sensors to main memory. This patch
provides support to read the sensors from main memory.

OCC writes three buffers which includes one names buffer for sensor
meta data and two buffers for sensor readings. The sensor names
buffers is written once and contains information like name, units,
frequency, sensor type, location, offset relative to reading buffer
and scale factor for each sensor. There are two buffers to store
sensor readings. While OCC writes to one buffer the sensor values can
be read from the other buffer. The sensor records stored in sensor
buffer can be of two types like counter sensor and full sensor.
Counter sensor record contains just the counter value. Full sensor
contains sample value, min, max, accumulator. It also maintains
min/max for three different clients which can be reset at runtime.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal-api.h               |  36 +++
 arch/powerpc/platforms/powernv/Makefile           |   2 +-
 arch/powerpc/platforms/powernv/opal-occ-sensors.c | 302 ++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal.c             |   3 +
 4 files changed, 342 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-occ-sensors.c

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index a0aa285..0ed9f79a 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -928,6 +928,42 @@ enum {
 	OPAL_PCI_TCE_KILL_ALL,
 };
 
+/* PowerNV OPAL-OCC Inband sensor definitions */
+enum occ_sensor_type {
+	OCC_SENSOR_TYPE_INVALID		= 0x0000,
+	OCC_SENSOR_TYPE_GENERIC		= 0x0001,
+	OCC_SENSOR_TYPE_CURRENT		= 0x0002,
+	OCC_SENSOR_TYPE_VOLTAGE		= 0x0004,
+	OCC_SENSOR_TYPE_TEMPERATURE	= 0x0008,
+	OCC_SENSOR_TYPE_UTILIZATION	= 0x0010,
+	OCC_SENSOR_TYPE_TIME		= 0x0020,
+	OCC_SENSOR_TYPE_FREQUENCY	= 0x0040,
+	OCC_SENSOR_TYPE_POWER		= 0x0080,
+	OCC_SENSOR_TYPE_PERFORMANCE	= 0x0200,
+};
+
+#define MAX_OCC_SENSOR_NAME_LEN         16
+#define MAX_OCC_SENSOR_UNITS_LEN        4
+
+struct occ_hwmon_sensor {
+	int type;
+	int occ_id;
+	u64 offset;
+	char name[MAX_OCC_SENSOR_NAME_LEN * 2];
+};
+
+int opal_occ_sensors_init(void);
+struct occ_hwmon_sensor *opal_occ_sensor_get_hwmon_list(int *nr_sensors);
+int opal_occ_sensor_get_sample(int occ_id, u64 offset, u64 *val);
+int opal_occ_sensor_get_min(int occ_id, u64 offset, u64 *val);
+int opal_occ_sensor_get_max(int occ_id, u64 offset, u64 *val);
+int opal_occ_sensor_get_csm_min(int occ_id, u64 offset, u64 *val);
+int opal_occ_sensor_get_csm_max(int occ_id, u64 offset, u64 *val);
+int opal_occ_sensor_get_js_min(int occ_id, u64 offset, u64 *val);
+int opal_occ_sensor_get_js_max(int occ_id, u64 offset, u64 *val);
+int opal_occ_sensor_get_prof_min(int occ_id, u64 offset, u64 *val);
+int opal_occ_sensor_get_prof_max(int occ_id, u64 offset, u64 *val);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __OPAL_API_H */
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index b5d98cb..940849d 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -2,7 +2,7 @@ obj-y			+= setup.o opal-wrappers.o opal.o opal-async.o idle.o
 obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
 obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
 obj-y			+= opal-msglog.o opal-hmi.o opal-power.o opal-irqchip.o
-obj-y			+= opal-kmsg.o
+obj-y			+= opal-kmsg.o opal-occ-sensors.o
 
 obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
 obj-$(CONFIG_PCI)	+= pci.o pci-ioda.o npu-dma.o
diff --git a/arch/powerpc/platforms/powernv/opal-occ-sensors.c b/arch/powerpc/platforms/powernv/opal-occ-sensors.c
new file mode 100644
index 0000000..b789925
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-occ-sensors.c
@@ -0,0 +1,302 @@
+/*
+ * Copyright IBM Corporation 2017
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#define pr_fmt(fmt) "opal-occ-sensors: " fmt
+
+#include <linux/of_platform.h>
+#include <linux/miscdevice.h>
+#include <linux/highmem.h>
+#include <linux/slab.h>
+
+#include <asm/opal.h>
+
+enum sensor_structure_type {
+	OCC_SENSOR_STRUCTURE_TYPE_FULL		= 0x01,
+	OCC_SENSOR_STRUCTURE_TYPE_COUNTER	= 0x02,
+};
+
+enum occ_sensor_location {
+	OCC_SENSOR_LOC_SYSTEM		= 0x0001,
+	OCC_SENSOR_LOC_PROCESSOR	= 0x0002,
+	OCC_SENSOR_LOC_PARTITION	= 0x0004,
+	OCC_SENSOR_LOC_MEMORY		= 0x0008,
+	OCC_SENSOR_LOC_VRM		= 0x0010,
+	OCC_SENSOR_LOC_OCC		= 0x0020,
+	OCC_SENSOR_LOC_CORE		= 0x0040,
+	OCC_SENSOR_LOC_QUAD		= 0x0080,
+	OCC_SENSOR_LOC_GPU		= 0x0100,
+};
+
+struct occ_sensor_name {
+	char name[MAX_OCC_SENSOR_NAME_LEN];
+	char units[MAX_OCC_SENSOR_UNITS_LEN];
+	u16 gsid;
+	u32 freq;
+	u32 scale_factor;
+	u16 type;
+	u16 location;
+	u8 structure_type;
+	u32 reading_offset;
+	u8 sensor_specific_info;
+	u8 pad[];
+} __packed;
+
+struct occ_sensor_record {
+	u16 gsid;
+	u64 timestamp;
+	u16 sample;
+	u16 min;
+	u16 max;
+	u16 csm_min;
+	u16 csm_max;
+	u16 prof_min;
+	u16 prof_max;
+	u16 js_min;
+	u16 js_max;
+	u64 accumulator;
+	u32 update_tag;
+	u8 pad[];
+} __packed;
+
+struct occ_sensor_counter {
+	u16 gsid;
+	u64 timestamp;
+	u64 accumulator;
+	u8 sample;
+	u8 pad[];
+} __packed;
+
+static struct occ_data {
+	int id;
+	int nr_sensors;
+	u64 pbase;
+	void *base;
+	int names_offset;
+	int ping_offset;
+	int pong_offset;
+} *occs;
+
+static int nr_occs;
+static int name_len;
+
+static int opal_occ_sensor_get_count(enum occ_sensor_type type)
+{
+	struct occ_sensor_name *sensor;
+	int count = 0;
+	int i, j;
+
+	for (i = 0; i < nr_occs; i++)
+		for (j = 0; j < occs[i].nr_sensors; j++) {
+			sensor = (struct occ_sensor_name *)(occs[i].base +
+				 occs[i].names_offset + j * name_len);
+			if (type == be16_to_cpu(sensor->type))
+				count++;
+		}
+
+	return count;
+}
+
+struct occ_hwmon_sensor *opal_occ_sensor_get_hwmon_list(int *nr_sensors)
+{
+	struct occ_sensor_name *sensor;
+	struct occ_hwmon_sensor *slist;
+	int i, j, count = 0;
+
+	*nr_sensors = opal_occ_sensor_get_count(OCC_SENSOR_TYPE_POWER);
+	*nr_sensors += opal_occ_sensor_get_count(OCC_SENSOR_TYPE_TEMPERATURE);
+	slist = kcalloc(*nr_sensors, sizeof(*slist), GFP_KERNEL);
+	if (!slist)
+		return NULL;
+
+	for (i = 0; i < nr_occs; i++)
+		for (j = 0; j < occs[i].nr_sensors; j++) {
+			enum occ_sensor_type type;
+			enum occ_sensor_location loc;
+
+			sensor = (struct occ_sensor_name *)(occs[i].base +
+				 occs[i].names_offset + j * name_len);
+			type = be16_to_cpu(sensor->type);
+			loc = be16_to_cpu(sensor->location);
+
+			if (type != OCC_SENSOR_TYPE_POWER &&
+			    type != OCC_SENSOR_TYPE_TEMPERATURE)
+				continue;
+
+			if (loc == OCC_SENSOR_LOC_SYSTEM)
+				strncpy(slist[count].name, sensor->name,
+					strlen(sensor->name));
+			else
+				snprintf(slist[count].name,
+					 sizeof(slist[count].name), "P%d_%s",
+					 occs[i].id, sensor->name);
+
+			slist[count].type = type;
+			slist[count].occ_id = occs[i].id;
+			slist[count].offset =
+					be32_to_cpu(sensor->reading_offset);
+			count++;
+		}
+
+	return slist;
+}
+EXPORT_SYMBOL_GPL(opal_occ_sensor_get_hwmon_list);
+
+static inline struct occ_data *get_occ(int occ_id)
+{
+	int i;
+
+	for (i = 0; i < nr_occs; i++)
+		if (occ_id == occs[i].id)
+			return &occs[i];
+
+	return NULL;
+}
+
+static struct occ_sensor_record *opal_occ_sensor_read_rec(int occ_id,
+							  u64 offset)
+{
+	struct occ_sensor_record *sping, *spong;
+	struct occ_data *occ;
+	u8 *ping, *pong;
+
+	occ = get_occ(occ_id);
+	if (!occ)
+		return NULL;
+
+	ping = (u8 *)(occ->base + occ->ping_offset);
+	pong = (u8 *)(occ->base + occ->pong_offset);
+	sping = (struct occ_sensor_record *)((u64)ping + offset);
+	spong = (struct occ_sensor_record *)((u64)pong + offset);
+
+	if (*ping && *pong) {
+		if (be64_to_cpu(sping->timestamp) >
+		    be64_to_cpu(spong->timestamp))
+			return sping;
+		else
+			return spong;
+	} else if (*ping && !*pong) {
+		return sping;
+	} else if (*pong && !*pong) {
+		return spong;
+	} else if (!*ping && !*pong) {
+		return NULL;
+	}
+
+	return NULL;
+}
+
+#define get(name)							\
+int opal_occ_sensor_get_##name(int occ_id, u64 offset, u64 *val)	\
+{									\
+	struct occ_sensor_record *sensor;				\
+	sensor = opal_occ_sensor_read_rec(occ_id, offset);		\
+	if (!sensor)							\
+		return -EIO;						\
+	*val = be16_to_cpu(sensor->name);				\
+	return 0;							\
+}									\
+EXPORT_SYMBOL_GPL(opal_occ_sensor_get_##name)
+
+get(sample);
+get(min);
+get(max);
+get(csm_min);
+get(csm_max);
+get(js_min);
+get(js_max);
+get(prof_min);
+get(prof_max);
+
+int __init opal_occ_sensors_init(void)
+{
+	struct platform_device *pdev;
+	struct device_node *sensor, *node;
+	int i, ret = -ENODEV;
+
+	sensor = of_find_compatible_node(NULL, NULL,
+					 "ibm,p9-occ-inband-sensor");
+	if (!sensor) {
+		pr_info("OCC inband sensors node not found\n");
+		return ret;
+	}
+
+	for_each_child_of_node(sensor, node)
+		if (strcmp(node->name, "occ") == 0)
+			nr_occs++;
+
+	if (of_property_read_u32(sensor, "sensor-names-size", &name_len)) {
+		pr_info("Missing sensor-names-size DT property\n");
+		return ret;
+	}
+
+	occs = kcalloc(nr_occs, sizeof(*occs), GFP_KERNEL);
+	if (!occs)
+		return -ENOMEM;
+
+	i = 0;
+	for_each_child_of_node(sensor, node) {
+		const __be32 *reg;
+		int reg_len = 0;
+
+		if (strcmp(node->name, "occ") != 0)
+			continue;
+
+		if (of_property_read_u32(node, "ibm,occ-id", &occs[i].id)) {
+			pr_info("Missing ibm,occ-id DT property\n");
+			goto out;
+		}
+
+		if (of_property_read_u32(node, "nr-sensors",
+					 &occs[i].nr_sensors)) {
+			pr_info("Missing nr_sensors DT property\n");
+			goto out;
+		}
+
+		if (of_property_read_u32(node, "ping-offset",
+					 &occs[i].ping_offset)) {
+			pr_info("Missing ping_offset DT property\n");
+			goto out;
+		}
+
+		if (of_property_read_u32(node, "pong-offset",
+					 &occs[i].pong_offset)) {
+			pr_info("Missing pong_offset DT property\n");
+			goto out;
+		}
+
+		if (of_property_read_u32(node, "names-offset",
+					 &occs[i].names_offset)) {
+			pr_info("Missing names_offset DT property\n");
+			goto out;
+		}
+
+		reg = of_get_property(node, "reg", &reg_len);
+		if (!reg_len) {
+			pr_info("Missing reg DT property\n");
+			goto out;
+		}
+
+		occs[i].pbase = be32_to_cpu(reg[0]);
+		occs[i].pbase = be32_to_cpu(reg[1]) | (occs[i].pbase << 32);
+		occs[i].base = phys_to_virt(occs[i].pbase);
+		i++;
+	}
+
+	pdev = of_platform_device_create(sensor, "occ-inband-sensor", NULL);
+	ret = PTR_ERR_OR_ZERO(pdev);
+	if (!ret)
+		return 0;
+out:
+	kfree(occs);
+	return ret;
+}
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 86d9fde..750d181 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -704,6 +704,9 @@ static int __init opal_init(void)
 	/* Initialise OPAL sensor interface */
 	opal_sensor_init();
 
+	/* Initialize OPAL OCC Inband sensor interface */
+	opal_occ_sensors_init();
+
 	/* Initialise OPAL hypervisor maintainence interrupt handling */
 	opal_hmi_handler_init();
 
-- 
1.8.3.1
