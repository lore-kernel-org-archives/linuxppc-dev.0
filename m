Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4A6B2DDD0A
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 16:10:26 +1100 (EST)
Received: from ash.ozlabs.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 153DC368007
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 16:10:26 +1100 (EST)
Date: Fri, 7 Dec 2007 16:10:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/3] [POWERPC] iSeries: merge vpdinfo.c intp pci.c
Message-Id: <20071207161022.fda39b4a.sfr@canb.auug.org.au>
In-Reply-To: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
References: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There was only one global function in vpdinfo.c and it was only called
from pci.c, so merge them and make the function static.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/Makefile  |    2 +-
 arch/powerpc/platforms/iseries/pci.c     |  218 ++++++++++++++++++++++++++
 arch/powerpc/platforms/iseries/pci.h     |    6 -
 arch/powerpc/platforms/iseries/vpdinfo.c |  252 ------------------------------
 4 files changed, 219 insertions(+), 259 deletions(-)
 delete mode 100644 arch/powerpc/platforms/iseries/vpdinfo.c

diff --git a/arch/powerpc/platforms/iseries/Makefile b/arch/powerpc/platforms/iseries/Makefile
index a65f1b4..cc7161f 100644
--- a/arch/powerpc/platforms/iseries/Makefile
+++ b/arch/powerpc/platforms/iseries/Makefile
@@ -5,7 +5,7 @@ extra-y += dt.o
 obj-y += exception.o
 obj-y += hvlog.o hvlpconfig.o lpardata.o setup.o dt_mod.o mf.o lpevents.o \
 	hvcall.o proc.o htab.o iommu.o misc.o irq.o
-obj-$(CONFIG_PCI) += pci.o vpdinfo.o
+obj-$(CONFIG_PCI) += pci.o
 obj-$(CONFIG_SMP) += smp.o
 obj-$(CONFIG_VIOPATH) += viopath.o vio.o
 obj-$(CONFIG_MODULES) += ksyms.o
diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index 5466975..68f248b 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2001 Allan Trautman, IBM Corporation
+ * Copyright (C) 2005,2007  Stephen Rothwell, IBM Corp
  *
  * iSeries specific routines for PCI.
  *
@@ -26,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 
+#include <asm/types.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/prom.h>
@@ -35,6 +37,7 @@
 #include <asm/abs_addr.h>
 #include <asm/firmware.h>
 
+#include <asm/iseries/hv_types.h>
 #include <asm/iseries/hv_call_xm.h>
 #include <asm/iseries/mf.h>
 #include <asm/iseries/iommu.h>
@@ -80,6 +83,221 @@ static inline u64 iseries_ds_addr(struct device_node *node)
 }
 
 /*
+ * Size of Bus VPD data
+ */
+#define BUS_VPDSIZE      1024
+
+/*
+ * Bus Vpd Tags
+ */
+#define VPD_END_OF_AREA		0x79
+#define VPD_ID_STRING		0x82
+#define VPD_VENDOR_AREA		0x84
+
+/*
+ * Mfg Area Tags
+ */
+#define VPD_FRU_FRAME_ID	0x4649	/* "FI" */
+#define VPD_SLOT_MAP_FORMAT	0x4D46	/* "MF" */
+#define VPD_SLOT_MAP		0x534D	/* "SM" */
+
+/*
+ * Structures of the areas
+ */
+struct mfg_vpd_area {
+	u16	tag;
+	u8	length;
+	u8	data1;
+	u8	data2;
+};
+#define MFG_ENTRY_SIZE   3
+
+struct slot_map {
+	u8	agent;
+	u8	secondary_agent;
+	u8	phb;
+	char	card_location[3];
+	char	parms[8];
+	char	reserved[2];
+};
+#define SLOT_ENTRY_SIZE   16
+
+/*
+ * Parse the Slot Area
+ */
+static void __init iseries_parse_slot_area(struct slot_map *map, int len,
+		HvAgentId agent, u8 *phb, char card[4])
+{
+	/*
+	 * Parse Slot label until we find the one requested
+	 */
+	while (len > 0) {
+		if (map->agent == agent) {
+			/*
+			 * If Phb wasn't found, grab the entry first one found.
+			 */
+			if (*phb == 0xff)
+				*phb = map->phb;
+			/* Found it, extract the data. */
+			if (map->phb == *phb) {
+				memcpy(card, &map->card_location, 3);
+				card[3]  = 0;
+				break;
+			}
+		}
+		/* Point to the next Slot */
+		map = (struct slot_map *)((char *)map + SLOT_ENTRY_SIZE);
+		len -= SLOT_ENTRY_SIZE;
+	}
+}
+
+/*
+ * Parse the Mfg Area
+ */
+static void __init iseries_parse_mfg_area(struct mfg_vpd_area *area, int len,
+		HvAgentId agent, u8 *phb, u8 *frame, char card[4])
+{
+	u16 slot_map_fmt = 0;
+
+	/* Parse Mfg Data */
+	while (len > 0) {
+		int mfg_tag_len = area->length;
+		/* Frame ID         (FI 4649020310 ) */
+		if (area->tag == VPD_FRU_FRAME_ID)
+			*frame = area->data1;
+		/* Slot Map Format  (MF 4D46020004 ) */
+		else if (area->tag == VPD_SLOT_MAP_FORMAT)
+			slot_map_fmt = (area->data1 * 256)
+				+ area->data2;
+		/* Slot Map         (SM 534D90 */
+		else if (area->tag == VPD_SLOT_MAP) {
+			struct slot_map *slot_map;
+
+			if (slot_map_fmt == 0x1004)
+				slot_map = (struct slot_map *)((char *)area
+						+ MFG_ENTRY_SIZE + 1);
+			else
+				slot_map = (struct slot_map *)((char *)area
+						+ MFG_ENTRY_SIZE);
+			iseries_parse_slot_area(slot_map, mfg_tag_len,
+					agent, phb, card);
+		}
+		/*
+		 * Point to the next Mfg Area
+		 * Use defined size, sizeof give wrong answer
+		 */
+		area = (struct mfg_vpd_area *)((char *)area + mfg_tag_len
+				+ MFG_ENTRY_SIZE);
+		len -= (mfg_tag_len + MFG_ENTRY_SIZE);
+	}
+}
+
+/*
+ * Look for "BUS".. Data is not Null terminated.
+ * PHBID of 0xFF indicates PHB was not found in VPD Data.
+ */
+static u8 __init iseries_parse_phbid(u8 *area, int len)
+{
+	while (len > 0) {
+		if ((*area == 'B') && (*(area + 1) == 'U')
+				&& (*(area + 2) == 'S')) {
+			area += 3;
+			while (*area == ' ')
+				area++;
+			return *area & 0x0F;
+		}
+		area++;
+		len--;
+	}
+	return 0xff;
+}
+
+/*
+ * Parse out the VPD Areas
+ */
+static void __init iseries_parse_vpd(u8 *data, int data_len,
+		HvAgentId agent, u8 *frame, char card[4])
+{
+	u8 phb = 0xff;
+
+	while (data_len > 0) {
+		int len;
+		u8 tag = *data;
+
+		if (tag == VPD_END_OF_AREA)
+			break;
+		len = *(data + 1) + (*(data + 2) * 256);
+		data += 3;
+		data_len -= 3;
+		if (tag == VPD_ID_STRING)
+			phb = iseries_parse_phbid(data, len);
+		else if (tag == VPD_VENDOR_AREA)
+			iseries_parse_mfg_area((struct mfg_vpd_area *)data, len,
+					agent, &phb, frame, card);
+		/* Point to next Area. */
+		data += len;
+		data_len -= len;
+	}
+}
+
+static int __init iseries_get_location_code(u16 bus, HvAgentId agent,
+		u8 *frame, char card[4])
+{
+	int status = 0;
+	int bus_vpd_len = 0;
+	u8 *bus_vpd = kmalloc(BUS_VPDSIZE, GFP_KERNEL);
+
+	if (bus_vpd == NULL) {
+		printk("PCI: Bus VPD Buffer allocation failure.\n");
+		return 0;
+	}
+	bus_vpd_len = HvCallPci_getBusVpd(bus, iseries_hv_addr(bus_vpd),
+					BUS_VPDSIZE);
+	if (bus_vpd_len == 0) {
+		printk("PCI: Bus VPD Buffer zero length.\n");
+		goto out_free;
+	}
+	/* printk("PCI: bus_vpd: %p, %d\n",bus_vpd, bus_vpd_len); */
+	/* Make sure this is what I think it is */
+	if (*bus_vpd != VPD_ID_STRING) {
+		printk("PCI: Bus VPD Buffer missing starting tag.\n");
+		goto out_free;
+	}
+	iseries_parse_vpd(bus_vpd, bus_vpd_len, agent, frame, card);
+	status = 1;
+out_free:
+	kfree(bus_vpd);
+	return status;
+}
+
+/*
+ * Prints the device information.
+ * - Pass in pci_dev* pointer to the device.
+ * - Pass in the device count
+ *
+ * Format:
+ * PCI: Bus  0, Device 26, Vendor 0x12AE  Frame  1, Card  C10  Ethernet
+ * controller
+ */
+static void __init iseries_device_information(struct pci_dev *pdev, int count,
+		u16 bus, HvSubBusNumber subbus)
+{
+	u8 frame = 0;
+	char card[4];
+	HvAgentId agent;
+
+	agent = ISERIES_PCI_AGENTID(ISERIES_GET_DEVICE_FROM_SUBBUS(subbus),
+			ISERIES_GET_FUNCTION_FROM_SUBBUS(subbus));
+
+	if (iseries_get_location_code(bus, agent, &frame, card)) {
+		printk("%d. PCI: Bus%3d, Device%3d, Vendor %04X Frame%3d, "
+			"Card %4s  0x%04X\n", count, bus,
+			PCI_SLOT(pdev->devfn), pdev->vendor, frame,
+			card, (int)(pdev->class >> 8));
+	}
+}
+
+/*
  * iomm_table_allocate_entry
  *
  * Adds pci_dev entry in address translation table
diff --git a/arch/powerpc/platforms/iseries/pci.h b/arch/powerpc/platforms/iseries/pci.h
index 5f517cf..180aa74 100644
--- a/arch/powerpc/platforms/iseries/pci.h
+++ b/arch/powerpc/platforms/iseries/pci.h
@@ -30,10 +30,6 @@
  * End Change Activity
  */
 
-#include <asm/iseries/hv_types.h>
-
-struct pci_dev;				/* For Forward Reference */
-
 /*
  * Decodes Linux DevFn to iSeries DevFn, bridge device, or function.
  * For Linux, see PCI_SLOT and PCI_FUNC in include/linux/pci.h
@@ -47,8 +43,6 @@ struct pci_dev;				/* For Forward Reference */
 #define ISERIES_GET_DEVICE_FROM_SUBBUS(subbus)		((subbus >> 5) & 0x7)
 #define ISERIES_GET_FUNCTION_FROM_SUBBUS(subbus)	((subbus >> 2) & 0x7)
 
-extern void	iseries_device_information(struct pci_dev *pdev, int count,
-			u16 bus, HvSubBusNumber subbus);
 #ifdef CONFIG_PCI
 extern void	iSeries_pcibios_init(void);
 extern void	iSeries_pci_final_fixup(void);
diff --git a/arch/powerpc/platforms/iseries/vpdinfo.c b/arch/powerpc/platforms/iseries/vpdinfo.c
deleted file mode 100644
index aec82e3..0000000
--- a/arch/powerpc/platforms/iseries/vpdinfo.c
+++ /dev/null
@@ -1,252 +0,0 @@
-/*
- * This code gets the card location of the hardware
- * Copyright (C) 2001  <Allan H Trautman> <IBM Corp>
- * Copyright (C) 2005  Stephen Rothwel, IBM Corp
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the:
- * Free Software Foundation, Inc.,
- * 59 Temple Place, Suite 330,
- * Boston, MA  02111-1307  USA
- *
- * Change Activity:
- *   Created, Feb 2, 2001
- *   Ported to ppc64, August 20, 2001
- * End Change Activity
- */
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/pci.h>
-
-#include <asm/types.h>
-#include <asm/resource.h>
-#include <asm/abs_addr.h>
-#include <asm/iseries/hv_types.h>
-
-#include "pci.h"
-#include "call_pci.h"
-
-/*
- * Size of Bus VPD data
- */
-#define BUS_VPDSIZE      1024
-
-/*
- * Bus Vpd Tags
- */
-#define VPD_END_OF_AREA		0x79
-#define VPD_ID_STRING		0x82
-#define VPD_VENDOR_AREA		0x84
-
-/*
- * Mfg Area Tags
- */
-#define VPD_FRU_FRAME_ID	0x4649	/* "FI" */
-#define VPD_SLOT_MAP_FORMAT	0x4D46	/* "MF" */
-#define VPD_SLOT_MAP		0x534D	/* "SM" */
-
-/*
- * Structures of the areas
- */
-struct mfg_vpd_area {
-	u16	tag;
-	u8	length;
-	u8	data1;
-	u8	data2;
-};
-#define MFG_ENTRY_SIZE   3
-
-struct slot_map {
-	u8	agent;
-	u8	secondary_agent;
-	u8	phb;
-	char	card_location[3];
-	char	parms[8];
-	char	reserved[2];
-};
-#define SLOT_ENTRY_SIZE   16
-
-/*
- * Parse the Slot Area
- */
-static void __init iseries_parse_slot_area(struct slot_map *map, int len,
-		HvAgentId agent, u8 *phb, char card[4])
-{
-	/*
-	 * Parse Slot label until we find the one requested
-	 */
-	while (len > 0) {
-		if (map->agent == agent) {
-			/*
-			 * If Phb wasn't found, grab the entry first one found.
-			 */
-			if (*phb == 0xff)
-				*phb = map->phb;
-			/* Found it, extract the data. */
-			if (map->phb == *phb) {
-				memcpy(card, &map->card_location, 3);
-				card[3]  = 0;
-				break;
-			}
-		}
-		/* Point to the next Slot */
-		map = (struct slot_map *)((char *)map + SLOT_ENTRY_SIZE);
-		len -= SLOT_ENTRY_SIZE;
-	}
-}
-
-/*
- * Parse the Mfg Area
- */
-static void __init iseries_parse_mfg_area(struct mfg_vpd_area *area, int len,
-		HvAgentId agent, u8 *phb, u8 *frame, char card[4])
-{
-	u16 slot_map_fmt = 0;
-
-	/* Parse Mfg Data */
-	while (len > 0) {
-		int mfg_tag_len = area->length;
-		/* Frame ID         (FI 4649020310 ) */
-		if (area->tag == VPD_FRU_FRAME_ID)
-			*frame = area->data1;
-		/* Slot Map Format  (MF 4D46020004 ) */
-		else if (area->tag == VPD_SLOT_MAP_FORMAT)
-			slot_map_fmt = (area->data1 * 256)
-				+ area->data2;
-		/* Slot Map         (SM 534D90 */
-		else if (area->tag == VPD_SLOT_MAP) {
-			struct slot_map *slot_map;
-
-			if (slot_map_fmt == 0x1004)
-				slot_map = (struct slot_map *)((char *)area
-						+ MFG_ENTRY_SIZE + 1);
-			else
-				slot_map = (struct slot_map *)((char *)area
-						+ MFG_ENTRY_SIZE);
-			iseries_parse_slot_area(slot_map, mfg_tag_len,
-					agent, phb, card);
-		}
-		/*
-		 * Point to the next Mfg Area
-		 * Use defined size, sizeof give wrong answer
-		 */
-		area = (struct mfg_vpd_area *)((char *)area + mfg_tag_len
-				+ MFG_ENTRY_SIZE);
-		len -= (mfg_tag_len + MFG_ENTRY_SIZE);
-	}
-}
-
-/*
- * Look for "BUS".. Data is not Null terminated.
- * PHBID of 0xFF indicates PHB was not found in VPD Data.
- */
-static u8 __init iseries_parse_phbid(u8 *area, int len)
-{
-	while (len > 0) {
-		if ((*area == 'B') && (*(area + 1) == 'U')
-				&& (*(area + 2) == 'S')) {
-			area += 3;
-			while (*area == ' ')
-				area++;
-			return *area & 0x0F;
-		}
-		area++;
-		len--;
-	}
-	return 0xff;
-}
-
-/*
- * Parse out the VPD Areas
- */
-static void __init iseries_parse_vpd(u8 *data, int data_len,
-		HvAgentId agent, u8 *frame, char card[4])
-{
-	u8 phb = 0xff;
-
-	while (data_len > 0) {
-		int len;
-		u8 tag = *data;
-
-		if (tag == VPD_END_OF_AREA)
-			break;
-		len = *(data + 1) + (*(data + 2) * 256);
-		data += 3;
-		data_len -= 3;
-		if (tag == VPD_ID_STRING)
-			phb = iseries_parse_phbid(data, len);
-		else if (tag == VPD_VENDOR_AREA)
-			iseries_parse_mfg_area((struct mfg_vpd_area *)data, len,
-					agent, &phb, frame, card);
-		/* Point to next Area. */
-		data += len;
-		data_len -= len;
-	}
-}
-
-static int __init iseries_get_location_code(u16 bus, HvAgentId agent,
-		u8 *frame, char card[4])
-{
-	int status = 0;
-	int bus_vpd_len = 0;
-	u8 *bus_vpd = kmalloc(BUS_VPDSIZE, GFP_KERNEL);
-
-	if (bus_vpd == NULL) {
-		printk("PCI: Bus VPD Buffer allocation failure.\n");
-		return 0;
-	}
-	bus_vpd_len = HvCallPci_getBusVpd(bus, iseries_hv_addr(bus_vpd),
-					BUS_VPDSIZE);
-	if (bus_vpd_len == 0) {
-		printk("PCI: Bus VPD Buffer zero length.\n");
-		goto out_free;
-	}
-	/* printk("PCI: bus_vpd: %p, %d\n",bus_vpd, bus_vpd_len); */
-	/* Make sure this is what I think it is */
-	if (*bus_vpd != VPD_ID_STRING) {
-		printk("PCI: Bus VPD Buffer missing starting tag.\n");
-		goto out_free;
-	}
-	iseries_parse_vpd(bus_vpd, bus_vpd_len, agent, frame, card);
-	status = 1;
-out_free:
-	kfree(bus_vpd);
-	return status;
-}
-
-/*
- * Prints the device information.
- * - Pass in pci_dev* pointer to the device.
- * - Pass in the device count
- *
- * Format:
- * PCI: Bus  0, Device 26, Vendor 0x12AE  Frame  1, Card  C10  Ethernet
- * controller
- */
-void __init iseries_device_information(struct pci_dev *pdev, int count,
-		u16 bus, HvSubBusNumber subbus)
-{
-	u8 frame = 0;
-	char card[4];
-	HvAgentId agent;
-
-	agent = ISERIES_PCI_AGENTID(ISERIES_GET_DEVICE_FROM_SUBBUS(subbus),
-			ISERIES_GET_FUNCTION_FROM_SUBBUS(subbus));
-
-	if (iseries_get_location_code(bus, agent, &frame, card)) {
-		printk("%d. PCI: Bus%3d, Device%3d, Vendor %04X Frame%3d, "
-			"Card %4s  0x%04X\n", count, bus,
-			PCI_SLOT(pdev->devfn), pdev->vendor, frame,
-			card, (int)(pdev->class >> 8));
-	}
-}
-- 
1.5.3.7

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
