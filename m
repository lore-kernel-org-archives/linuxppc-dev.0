Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C451967B7E
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 16:28:34 +1000 (EST)
Date: Thu, 17 Aug 2006 16:28:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] iseries: remove some gcc 4.1 warnings
Message-Id: <20060817162828.2737d146.sfr@canb.auug.org.au>
In-Reply-To: <200608161515.26166.arnd.bergmann@de.ibm.com>
References: <20060816152032.2407a832.sfr@canb.auug.org.au>
	<200608161515.26166.arnd.bergmann@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

gcc 4.1 produces some warnings that say it is ignoring the packed
attribute on some structure elements, so, since all the elements of
these structs are packed, pack the structs instead.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/main_store.h |  126 ++++++++++++++-------------
 1 files changed, 63 insertions(+), 63 deletions(-)

This version takes into account Arnds good suggestion.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff --git a/arch/powerpc/platforms/iseries/main_store.h b/arch/powerpc/platforms/iseries/main_store.h
index 74f6889..1a7a3f5 100644
--- a/arch/powerpc/platforms/iseries/main_store.h
+++ b/arch/powerpc/platforms/iseries/main_store.h
@@ -61,9 +61,9 @@ struct IoHriMainStoreSegment4 {
 };
 
 /* Main Store VPD for Power4 */
-struct IoHriMainStoreChipInfo1 {
-	u32	chipMfgID	__attribute((packed));
-	char	chipECLevel[4]	__attribute((packed));
+struct __attribute((packed)) IoHriMainStoreChipInfo1 {
+	u32	chipMfgID;
+	char	chipECLevel[4];
 };
 
 struct IoHriMainStoreVpdIdData {
@@ -73,72 +73,72 @@ struct IoHriMainStoreVpdIdData {
 	char	serialNumber[12];
 };
 
-struct IoHriMainStoreVpdFruData {
-	char	fruLabel[8]	__attribute((packed));
-	u8	numberOfSlots	__attribute((packed));
-	u8	pluggingType	__attribute((packed));
-	u16	slotMapIndex	__attribute((packed));
+struct	__attribute((packed)) IoHriMainStoreVpdFruData {
+	char	fruLabel[8];
+	u8	numberOfSlots;
+	u8	pluggingType;
+	u16	slotMapIndex;
 };
 
-struct IoHriMainStoreAdrRangeBlock {
-	void	*blockStart      __attribute((packed));
-	void	*blockEnd        __attribute((packed));
-	u32	blockProcChipId __attribute((packed));
+struct  __attribute((packed)) IoHriMainStoreAdrRangeBlock {
+	void	*blockStart;
+	void	*blockEnd;
+	u32	blockProcChipId;
 };
 
 #define MaxAreaAdrRangeBlocks 4
 
-struct IoHriMainStoreArea4 {
-	u32	msVpdFormat			__attribute((packed));
-	u8	containedVpdType		__attribute((packed));
-	u8	reserved1			__attribute((packed));
-	u16	reserved2			__attribute((packed));
-
-	u64	msExists			__attribute((packed));
-	u64	msFunctional			__attribute((packed));
-
-	u32	memorySize			__attribute((packed));
-	u32	procNodeId			__attribute((packed));
-
-	u32	numAdrRangeBlocks		__attribute((packed));
-	struct IoHriMainStoreAdrRangeBlock xAdrRangeBlock[MaxAreaAdrRangeBlocks]	__attribute((packed));
-
-	struct IoHriMainStoreChipInfo1	chipInfo0	__attribute((packed));
-	struct IoHriMainStoreChipInfo1	chipInfo1	__attribute((packed));
-	struct IoHriMainStoreChipInfo1	chipInfo2	__attribute((packed));
-	struct IoHriMainStoreChipInfo1	chipInfo3	__attribute((packed));
-	struct IoHriMainStoreChipInfo1	chipInfo4	__attribute((packed));
-	struct IoHriMainStoreChipInfo1	chipInfo5	__attribute((packed));
-	struct IoHriMainStoreChipInfo1	chipInfo6	__attribute((packed));
-	struct IoHriMainStoreChipInfo1	chipInfo7	__attribute((packed));
-
-	void	*msRamAreaArray			__attribute((packed));
-	u32	msRamAreaArrayNumEntries	__attribute((packed));
-	u32	msRamAreaArrayEntrySize		__attribute((packed));
-
-	u32	numaDimmExists			__attribute((packed));
-	u32	numaDimmFunctional		__attribute((packed));
-	void	*numaDimmArray			__attribute((packed));
-	u32	numaDimmArrayNumEntries		__attribute((packed));
-	u32	numaDimmArrayEntrySize		__attribute((packed));
-
-	struct IoHriMainStoreVpdIdData idData	__attribute((packed));
-
-	u64	powerData			__attribute((packed));
-	u64	cardAssemblyPartNum		__attribute((packed));
-	u64	chipSerialNum			__attribute((packed));
-
-	u64	reserved3			__attribute((packed));
-	char	reserved4[16]			__attribute((packed));
-
-	struct IoHriMainStoreVpdFruData fruData	__attribute((packed));
-
-	u8	vpdPortNum			__attribute((packed));
-	u8	reserved5			__attribute((packed));
-	u8	frameId				__attribute((packed));
-	u8	rackUnit			__attribute((packed));
-	char	asciiKeywordVpd[256]		__attribute((packed));
-	u32	reserved6			__attribute((packed));
+struct __attribute((packed)) IoHriMainStoreArea4 {
+	u32	msVpdFormat;
+	u8	containedVpdType;
+	u8	reserved1;
+	u16	reserved2;
+
+	u64	msExists;
+	u64	msFunctional;
+
+	u32	memorySize;
+	u32	procNodeId;
+
+	u32	numAdrRangeBlocks;
+	struct IoHriMainStoreAdrRangeBlock xAdrRangeBlock[MaxAreaAdrRangeBlocks];
+
+	struct IoHriMainStoreChipInfo1	chipInfo0;
+	struct IoHriMainStoreChipInfo1	chipInfo1;
+	struct IoHriMainStoreChipInfo1	chipInfo2;
+	struct IoHriMainStoreChipInfo1	chipInfo3;
+	struct IoHriMainStoreChipInfo1	chipInfo4;
+	struct IoHriMainStoreChipInfo1	chipInfo5;
+	struct IoHriMainStoreChipInfo1	chipInfo6;
+	struct IoHriMainStoreChipInfo1	chipInfo7;
+
+	void	*msRamAreaArray;
+	u32	msRamAreaArrayNumEntries;
+	u32	msRamAreaArrayEntrySize;
+
+	u32	numaDimmExists;
+	u32	numaDimmFunctional;
+	void	*numaDimmArray;
+	u32	numaDimmArrayNumEntries;
+	u32	numaDimmArrayEntrySize;
+
+	struct IoHriMainStoreVpdIdData idData;
+
+	u64	powerData;
+	u64	cardAssemblyPartNum;
+	u64	chipSerialNum;
+
+	u64	reserved3;
+	char	reserved4[16];
+
+	struct IoHriMainStoreVpdFruData fruData;
+
+	u8	vpdPortNum;
+	u8	reserved5;
+	u8	frameId;
+	u8	rackUnit;
+	char	asciiKeywordVpd[256];
+	u32	reserved6;
 };
 
 
-- 
1.4.1.1
