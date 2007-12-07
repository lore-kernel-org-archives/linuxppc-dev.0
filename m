Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 230A3DDE17
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 16:09:23 +1100 (EST)
Received: from ash.ozlabs.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id F27C8368008
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 16:09:22 +1100 (EST)
Date: Fri, 7 Dec 2007 16:09:18 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/3] [POWERPC] iSeries: clean up and simplify vdpinfo.c
Message-Id: <20071207160918.c1641642.sfr@canb.auug.org.au>
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


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/vpdinfo.c |  100 ++++++++++++++----------------
 1 files changed, 46 insertions(+), 54 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/vpdinfo.c b/arch/powerpc/platforms/iseries/vpdinfo.c
index f9415bf..aec82e3 100644
--- a/arch/powerpc/platforms/iseries/vpdinfo.c
+++ b/arch/powerpc/platforms/iseries/vpdinfo.c
@@ -82,62 +82,56 @@ struct slot_map {
 static void __init iseries_parse_slot_area(struct slot_map *map, int len,
 		HvAgentId agent, u8 *phb, char card[4])
 {
-	int slot_map_len = len;
-	struct slot_map *slot_map = map;
-
 	/*
 	 * Parse Slot label until we find the one requested
 	 */
-	while (slot_map_len > 0) {
-		if (slot_map->agent == agent) {
+	while (len > 0) {
+		if (map->agent == agent) {
 			/*
 			 * If Phb wasn't found, grab the entry first one found.
 			 */
 			if (*phb == 0xff)
-				*phb = slot_map->phb;
+				*phb = map->phb;
 			/* Found it, extract the data. */
-			if (slot_map->phb == *phb) {
-				memcpy(card, &slot_map->card_location, 3);
+			if (map->phb == *phb) {
+				memcpy(card, &map->card_location, 3);
 				card[3]  = 0;
 				break;
 			}
 		}
 		/* Point to the next Slot */
-		slot_map = (struct slot_map *)((char *)slot_map + SLOT_ENTRY_SIZE);
-		slot_map_len -= SLOT_ENTRY_SIZE;
+		map = (struct slot_map *)((char *)map + SLOT_ENTRY_SIZE);
+		len -= SLOT_ENTRY_SIZE;
 	}
 }
 
 /*
  * Parse the Mfg Area
  */
-static void __init iseries_parse_mfg_area(u8 *area, int len,
-		HvAgentId agent, u8 *phb,
-		u8 *frame, char card[4])
+static void __init iseries_parse_mfg_area(struct mfg_vpd_area *area, int len,
+		HvAgentId agent, u8 *phb, u8 *frame, char card[4])
 {
-	struct mfg_vpd_area *mfg_area = (struct mfg_vpd_area *)area;
-	int mfg_area_len = len;
 	u16 slot_map_fmt = 0;
 
 	/* Parse Mfg Data */
-	while (mfg_area_len > 0) {
-		int mfg_tag_len = mfg_area->length;
+	while (len > 0) {
+		int mfg_tag_len = area->length;
 		/* Frame ID         (FI 4649020310 ) */
-		if (mfg_area->tag == VPD_FRU_FRAME_ID)
-			*frame = mfg_area->data1;
+		if (area->tag == VPD_FRU_FRAME_ID)
+			*frame = area->data1;
 		/* Slot Map Format  (MF 4D46020004 ) */
-		else if (mfg_area->tag == VPD_SLOT_MAP_FORMAT)
-			slot_map_fmt = (mfg_area->data1 * 256)
-				+ mfg_area->data2;
+		else if (area->tag == VPD_SLOT_MAP_FORMAT)
+			slot_map_fmt = (area->data1 * 256)
+				+ area->data2;
 		/* Slot Map         (SM 534D90 */
-		else if (mfg_area->tag == VPD_SLOT_MAP) {
+		else if (area->tag == VPD_SLOT_MAP) {
 			struct slot_map *slot_map;
 
 			if (slot_map_fmt == 0x1004)
-				slot_map = (struct slot_map *)((char *)mfg_area
+				slot_map = (struct slot_map *)((char *)area
 						+ MFG_ENTRY_SIZE + 1);
 			else
-				slot_map = (struct slot_map *)((char *)mfg_area
+				slot_map = (struct slot_map *)((char *)area
 						+ MFG_ENTRY_SIZE);
 			iseries_parse_slot_area(slot_map, mfg_tag_len,
 					agent, phb, card);
@@ -146,9 +140,9 @@ static void __init iseries_parse_mfg_area(u8 *area, int len,
 		 * Point to the next Mfg Area
 		 * Use defined size, sizeof give wrong answer
 		 */
-		mfg_area = (struct mfg_vpd_area *)((char *)mfg_area + mfg_tag_len
+		area = (struct mfg_vpd_area *)((char *)area + mfg_tag_len
 				+ MFG_ENTRY_SIZE);
-		mfg_area_len -= (mfg_tag_len + MFG_ENTRY_SIZE);
+		len -= (mfg_tag_len + MFG_ENTRY_SIZE);
 	}
 }
 
@@ -156,48 +150,46 @@ static void __init iseries_parse_mfg_area(u8 *area, int len,
  * Look for "BUS".. Data is not Null terminated.
  * PHBID of 0xFF indicates PHB was not found in VPD Data.
  */
-static int __init iseries_parse_phbid(u8 *area, int len)
+static u8 __init iseries_parse_phbid(u8 *area, int len)
 {
-	u8 *phb_ptr = area;
-	int data_len = len;
-	char phb = 0xFF;
-
-	while (data_len > 0) {
-		if ((*phb_ptr == 'B') && (*(phb_ptr + 1) == 'U')
-				&& (*(phb_ptr + 2) == 'S')) {
-			phb_ptr += 3;
-			while (*phb_ptr == ' ')
-				++phb_ptr;
-			phb = (*phb_ptr & 0x0F);
-			break;
+	while (len > 0) {
+		if ((*area == 'B') && (*(area + 1) == 'U')
+				&& (*(area + 2) == 'S')) {
+			area += 3;
+			while (*area == ' ')
+				area++;
+			return *area & 0x0F;
 		}
-		++phb_ptr;
-		--data_len;
+		area++;
+		len--;
 	}
-	return phb;
+	return 0xff;
 }
 
 /*
  * Parse out the VPD Areas
  */
-static void __init iseries_parse_vpd(u8 *data, int vpd_data_len,
+static void __init iseries_parse_vpd(u8 *data, int data_len,
 		HvAgentId agent, u8 *frame, char card[4])
 {
-	u8 *tag_ptr = data;
-	int data_len = vpd_data_len - 3;
 	u8 phb = 0xff;
 
-	while ((*tag_ptr != VPD_END_OF_AREA) && (data_len > 0)) {
-		int len = *(tag_ptr + 1) + (*(tag_ptr + 2) * 256);
-		u8 *area  = tag_ptr + 3;
+	while (data_len > 0) {
+		int len;
+		u8 tag = *data;
 
-		if (*tag_ptr == VPD_ID_STRING)
-			phb = iseries_parse_phbid(area, len);
-		else if (*tag_ptr == VPD_VENDOR_AREA)
-			iseries_parse_mfg_area(area, len,
+		if (tag == VPD_END_OF_AREA)
+			break;
+		len = *(data + 1) + (*(data + 2) * 256);
+		data += 3;
+		data_len -= 3;
+		if (tag == VPD_ID_STRING)
+			phb = iseries_parse_phbid(data, len);
+		else if (tag == VPD_VENDOR_AREA)
+			iseries_parse_mfg_area((struct mfg_vpd_area *)data, len,
 					agent, &phb, frame, card);
 		/* Point to next Area. */
-		tag_ptr  = area + len;
+		data += len;
 		data_len -= len;
 	}
 }
-- 
1.5.3.7

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
