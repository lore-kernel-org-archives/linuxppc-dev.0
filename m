Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 2BAE1DDFB4
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 16:08:38 +1100 (EST)
Received: from ash.ozlabs.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id E6E97368006
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 16:08:37 +1100 (EST)
Date: Fri, 7 Dec 2007 16:08:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/3] [POWERPC] iSeries: DeCamelCase vpdinfo.c
Message-Id: <20071207160833.ec4fb0ec.sfr@canb.auug.org.au>
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

This is a purely mechanical transformation.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/pci.c     |    2 +-
 arch/powerpc/platforms/iseries/pci.h     |    2 +-
 arch/powerpc/platforms/iseries/vpdinfo.c |  188 +++++++++++++++---------------
 3 files changed, 95 insertions(+), 97 deletions(-)

These three follow on from the 19 I posted last night.

diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index 3071a30..5466975 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -227,7 +227,7 @@ void __init iSeries_pci_final_fixup(void)
 		pdev->sysdata = node;
 		PCI_DN(node)->pcidev = pdev;
 		allocate_device_bars(pdev);
-		iSeries_Device_Information(pdev, num_dev, bus, *sub_bus);
+		iseries_device_information(pdev, num_dev, bus, *sub_bus);
 		iommu_devnode_init_iSeries(pdev, node);
 	}
 	iSeries_activate_IRQs();
diff --git a/arch/powerpc/platforms/iseries/pci.h b/arch/powerpc/platforms/iseries/pci.h
index b142873..5f517cf 100644
--- a/arch/powerpc/platforms/iseries/pci.h
+++ b/arch/powerpc/platforms/iseries/pci.h
@@ -47,7 +47,7 @@ struct pci_dev;				/* For Forward Reference */
 #define ISERIES_GET_DEVICE_FROM_SUBBUS(subbus)		((subbus >> 5) & 0x7)
 #define ISERIES_GET_FUNCTION_FROM_SUBBUS(subbus)	((subbus >> 2) & 0x7)
 
-extern void	iSeries_Device_Information(struct pci_dev *PciDev, int count,
+extern void	iseries_device_information(struct pci_dev *pdev, int count,
 			u16 bus, HvSubBusNumber subbus);
 #ifdef CONFIG_PCI
 extern void	iSeries_pcibios_init(void);
diff --git a/arch/powerpc/platforms/iseries/vpdinfo.c b/arch/powerpc/platforms/iseries/vpdinfo.c
index 25dc0bb..f9415bf 100644
--- a/arch/powerpc/platforms/iseries/vpdinfo.c
+++ b/arch/powerpc/platforms/iseries/vpdinfo.c
@@ -44,113 +44,111 @@
 /*
  * Bus Vpd Tags
  */
-#define  VpdEndOfAreaTag   0x79
-#define  VpdIdStringTag    0x82
-#define  VpdVendorAreaTag  0x84
+#define VPD_END_OF_AREA		0x79
+#define VPD_ID_STRING		0x82
+#define VPD_VENDOR_AREA		0x84
 
 /*
  * Mfg Area Tags
  */
-#define  VpdFruFrameId    0x4649     // "FI"
-#define  VpdSlotMapFormat 0x4D46     // "MF"
-#define  VpdSlotMap       0x534D     // "SM"
+#define VPD_FRU_FRAME_ID	0x4649	/* "FI" */
+#define VPD_SLOT_MAP_FORMAT	0x4D46	/* "MF" */
+#define VPD_SLOT_MAP		0x534D	/* "SM" */
 
 /*
  * Structures of the areas
  */
-struct MfgVpdAreaStruct {
-	u16 Tag;
-	u8  TagLength;
-	u8  AreaData1;
-	u8  AreaData2;
+struct mfg_vpd_area {
+	u16	tag;
+	u8	length;
+	u8	data1;
+	u8	data2;
 };
-typedef struct MfgVpdAreaStruct MfgArea;
 #define MFG_ENTRY_SIZE   3
 
-struct SlotMapStruct {
-	u8   AgentId;
-	u8   SecondaryAgentId;
-	u8   PhbId;
-	char CardLocation[3];
-	char Parms[8];
-	char Reserved[2];
+struct slot_map {
+	u8	agent;
+	u8	secondary_agent;
+	u8	phb;
+	char	card_location[3];
+	char	parms[8];
+	char	reserved[2];
 };
-typedef struct SlotMapStruct SlotMap;
 #define SLOT_ENTRY_SIZE   16
 
 /*
  * Parse the Slot Area
  */
-static void __init iSeries_Parse_SlotArea(SlotMap *MapPtr, int MapLen,
-		HvAgentId agent, u8 *PhbId, char card[4])
+static void __init iseries_parse_slot_area(struct slot_map *map, int len,
+		HvAgentId agent, u8 *phb, char card[4])
 {
-	int SlotMapLen = MapLen;
-	SlotMap *SlotMapPtr = MapPtr;
+	int slot_map_len = len;
+	struct slot_map *slot_map = map;
 
 	/*
 	 * Parse Slot label until we find the one requested
 	 */
-	while (SlotMapLen > 0) {
-		if (SlotMapPtr->AgentId == agent) {
+	while (slot_map_len > 0) {
+		if (slot_map->agent == agent) {
 			/*
 			 * If Phb wasn't found, grab the entry first one found.
 			 */
-			if (*PhbId == 0xff)
-				*PhbId = SlotMapPtr->PhbId;
+			if (*phb == 0xff)
+				*phb = slot_map->phb;
 			/* Found it, extract the data. */
-			if (SlotMapPtr->PhbId == *PhbId) {
-				memcpy(card, &SlotMapPtr->CardLocation, 3);
+			if (slot_map->phb == *phb) {
+				memcpy(card, &slot_map->card_location, 3);
 				card[3]  = 0;
 				break;
 			}
 		}
 		/* Point to the next Slot */
-		SlotMapPtr = (SlotMap *)((char *)SlotMapPtr + SLOT_ENTRY_SIZE);
-		SlotMapLen -= SLOT_ENTRY_SIZE;
+		slot_map = (struct slot_map *)((char *)slot_map + SLOT_ENTRY_SIZE);
+		slot_map_len -= SLOT_ENTRY_SIZE;
 	}
 }
 
 /*
  * Parse the Mfg Area
  */
-static void __init iSeries_Parse_MfgArea(u8 *AreaData, int AreaLen,
-		HvAgentId agent, u8 *PhbId,
+static void __init iseries_parse_mfg_area(u8 *area, int len,
+		HvAgentId agent, u8 *phb,
 		u8 *frame, char card[4])
 {
-	MfgArea *MfgAreaPtr = (MfgArea *)AreaData;
-	int MfgAreaLen = AreaLen;
-	u16 SlotMapFmt = 0;
+	struct mfg_vpd_area *mfg_area = (struct mfg_vpd_area *)area;
+	int mfg_area_len = len;
+	u16 slot_map_fmt = 0;
 
 	/* Parse Mfg Data */
-	while (MfgAreaLen > 0) {
-		int MfgTagLen = MfgAreaPtr->TagLength;
+	while (mfg_area_len > 0) {
+		int mfg_tag_len = mfg_area->length;
 		/* Frame ID         (FI 4649020310 ) */
-		if (MfgAreaPtr->Tag == VpdFruFrameId)		/* FI  */
-			*frame = MfgAreaPtr->AreaData1;
+		if (mfg_area->tag == VPD_FRU_FRAME_ID)
+			*frame = mfg_area->data1;
 		/* Slot Map Format  (MF 4D46020004 ) */
-		else if (MfgAreaPtr->Tag == VpdSlotMapFormat)	/* MF  */
-			SlotMapFmt = (MfgAreaPtr->AreaData1 * 256)
-				+ MfgAreaPtr->AreaData2;
+		else if (mfg_area->tag == VPD_SLOT_MAP_FORMAT)
+			slot_map_fmt = (mfg_area->data1 * 256)
+				+ mfg_area->data2;
 		/* Slot Map         (SM 534D90 */
-		else if (MfgAreaPtr->Tag == VpdSlotMap)	{	/* SM  */
-			SlotMap *SlotMapPtr;
+		else if (mfg_area->tag == VPD_SLOT_MAP) {
+			struct slot_map *slot_map;
 
-			if (SlotMapFmt == 0x1004)
-				SlotMapPtr = (SlotMap *)((char *)MfgAreaPtr
+			if (slot_map_fmt == 0x1004)
+				slot_map = (struct slot_map *)((char *)mfg_area
 						+ MFG_ENTRY_SIZE + 1);
 			else
-				SlotMapPtr = (SlotMap *)((char *)MfgAreaPtr
+				slot_map = (struct slot_map *)((char *)mfg_area
 						+ MFG_ENTRY_SIZE);
-			iSeries_Parse_SlotArea(SlotMapPtr, MfgTagLen,
-					agent, PhbId, card);
+			iseries_parse_slot_area(slot_map, mfg_tag_len,
+					agent, phb, card);
 		}
 		/*
 		 * Point to the next Mfg Area
 		 * Use defined size, sizeof give wrong answer
 		 */
-		MfgAreaPtr = (MfgArea *)((char *)MfgAreaPtr + MfgTagLen
+		mfg_area = (struct mfg_vpd_area *)((char *)mfg_area + mfg_tag_len
 				+ MFG_ENTRY_SIZE);
-		MfgAreaLen -= (MfgTagLen + MFG_ENTRY_SIZE);
+		mfg_area_len -= (mfg_tag_len + MFG_ENTRY_SIZE);
 	}
 }
 
@@ -158,79 +156,79 @@ static void __init iSeries_Parse_MfgArea(u8 *AreaData, int AreaLen,
  * Look for "BUS".. Data is not Null terminated.
  * PHBID of 0xFF indicates PHB was not found in VPD Data.
  */
-static int __init iSeries_Parse_PhbId(u8 *AreaPtr, int AreaLength)
+static int __init iseries_parse_phbid(u8 *area, int len)
 {
-	u8 *PhbPtr = AreaPtr;
-	int DataLen = AreaLength;
-	char PhbId = 0xFF;
+	u8 *phb_ptr = area;
+	int data_len = len;
+	char phb = 0xFF;
 
-	while (DataLen > 0) {
-		if ((*PhbPtr == 'B') && (*(PhbPtr + 1) == 'U')
-				&& (*(PhbPtr + 2) == 'S')) {
-			PhbPtr += 3;
-			while (*PhbPtr == ' ')
-				++PhbPtr;
-			PhbId = (*PhbPtr & 0x0F);
+	while (data_len > 0) {
+		if ((*phb_ptr == 'B') && (*(phb_ptr + 1) == 'U')
+				&& (*(phb_ptr + 2) == 'S')) {
+			phb_ptr += 3;
+			while (*phb_ptr == ' ')
+				++phb_ptr;
+			phb = (*phb_ptr & 0x0F);
 			break;
 		}
-		++PhbPtr;
-		--DataLen;
+		++phb_ptr;
+		--data_len;
 	}
-	return PhbId;
+	return phb;
 }
 
 /*
  * Parse out the VPD Areas
  */
-static void __init iSeries_Parse_Vpd(u8 *VpdData, int VpdDataLen,
+static void __init iseries_parse_vpd(u8 *data, int vpd_data_len,
 		HvAgentId agent, u8 *frame, char card[4])
 {
-	u8 *TagPtr = VpdData;
-	int DataLen = VpdDataLen - 3;
-	u8 PhbId = 0xff;
+	u8 *tag_ptr = data;
+	int data_len = vpd_data_len - 3;
+	u8 phb = 0xff;
 
-	while ((*TagPtr != VpdEndOfAreaTag) && (DataLen > 0)) {
-		int AreaLen = *(TagPtr + 1) + (*(TagPtr + 2) * 256);
-		u8 *AreaData  = TagPtr + 3;
+	while ((*tag_ptr != VPD_END_OF_AREA) && (data_len > 0)) {
+		int len = *(tag_ptr + 1) + (*(tag_ptr + 2) * 256);
+		u8 *area  = tag_ptr + 3;
 
-		if (*TagPtr == VpdIdStringTag)
-			PhbId = iSeries_Parse_PhbId(AreaData, AreaLen);
-		else if (*TagPtr == VpdVendorAreaTag)
-			iSeries_Parse_MfgArea(AreaData, AreaLen,
-					agent, &PhbId, frame, card);
+		if (*tag_ptr == VPD_ID_STRING)
+			phb = iseries_parse_phbid(area, len);
+		else if (*tag_ptr == VPD_VENDOR_AREA)
+			iseries_parse_mfg_area(area, len,
+					agent, &phb, frame, card);
 		/* Point to next Area. */
-		TagPtr  = AreaData + AreaLen;
-		DataLen -= AreaLen;
+		tag_ptr  = area + len;
+		data_len -= len;
 	}
 }
 
-static int __init iSeries_Get_Location_Code(u16 bus, HvAgentId agent,
+static int __init iseries_get_location_code(u16 bus, HvAgentId agent,
 		u8 *frame, char card[4])
 {
 	int status = 0;
-	int BusVpdLen = 0;
-	u8 *BusVpdPtr = kmalloc(BUS_VPDSIZE, GFP_KERNEL);
+	int bus_vpd_len = 0;
+	u8 *bus_vpd = kmalloc(BUS_VPDSIZE, GFP_KERNEL);
 
-	if (BusVpdPtr == NULL) {
+	if (bus_vpd == NULL) {
 		printk("PCI: Bus VPD Buffer allocation failure.\n");
 		return 0;
 	}
-	BusVpdLen = HvCallPci_getBusVpd(bus, iseries_hv_addr(BusVpdPtr),
+	bus_vpd_len = HvCallPci_getBusVpd(bus, iseries_hv_addr(bus_vpd),
 					BUS_VPDSIZE);
-	if (BusVpdLen == 0) {
+	if (bus_vpd_len == 0) {
 		printk("PCI: Bus VPD Buffer zero length.\n");
 		goto out_free;
 	}
-	/* printk("PCI: BusVpdPtr: %p, %d\n",BusVpdPtr, BusVpdLen); */
+	/* printk("PCI: bus_vpd: %p, %d\n",bus_vpd, bus_vpd_len); */
 	/* Make sure this is what I think it is */
-	if (*BusVpdPtr != VpdIdStringTag) {	/* 0x82 */
+	if (*bus_vpd != VPD_ID_STRING) {
 		printk("PCI: Bus VPD Buffer missing starting tag.\n");
 		goto out_free;
 	}
-	iSeries_Parse_Vpd(BusVpdPtr, BusVpdLen, agent, frame, card);
+	iseries_parse_vpd(bus_vpd, bus_vpd_len, agent, frame, card);
 	status = 1;
 out_free:
-	kfree(BusVpdPtr);
+	kfree(bus_vpd);
 	return status;
 }
 
@@ -243,7 +241,7 @@ out_free:
  * PCI: Bus  0, Device 26, Vendor 0x12AE  Frame  1, Card  C10  Ethernet
  * controller
  */
-void __init iSeries_Device_Information(struct pci_dev *PciDev, int count,
+void __init iseries_device_information(struct pci_dev *pdev, int count,
 		u16 bus, HvSubBusNumber subbus)
 {
 	u8 frame = 0;
@@ -253,10 +251,10 @@ void __init iSeries_Device_Information(struct pci_dev *PciDev, int count,
 	agent = ISERIES_PCI_AGENTID(ISERIES_GET_DEVICE_FROM_SUBBUS(subbus),
 			ISERIES_GET_FUNCTION_FROM_SUBBUS(subbus));
 
-	if (iSeries_Get_Location_Code(bus, agent, &frame, card)) {
+	if (iseries_get_location_code(bus, agent, &frame, card)) {
 		printk("%d. PCI: Bus%3d, Device%3d, Vendor %04X Frame%3d, "
 			"Card %4s  0x%04X\n", count, bus,
-			PCI_SLOT(PciDev->devfn), PciDev->vendor, frame,
-			card, (int)(PciDev->class >> 8));
+			PCI_SLOT(pdev->devfn), pdev->vendor, frame,
+			card, (int)(pdev->class >> 8));
 	}
 }
-- 
1.5.3.7

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
