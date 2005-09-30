Return-Path: <sfr@canb.auug.org.au>
Date: Fri, 30 Sep 2005 23:44:46 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Message-Id: <20050930234446.6207aa27.sfr@canb.auug.org.au>
In-Reply-To: <20050930233602.138b6e27.sfr@canb.auug.org.au>
References: <20050930233602.138b6e27.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/9] ppc64 iseries: move some iSeries include files
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These files are only referenced from within
arch/powerpc/platforms/iseries, so move them there. We also remove the
StudLy Caps from the names.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/platforms/iseries/call_sm.h       |   37 +++++
 arch/powerpc/platforms/iseries/ipl_parms.h     |   70 ++++++++++
 arch/powerpc/platforms/iseries/irq.c           |    3 
 arch/powerpc/platforms/iseries/irq.h           |    8 +
 arch/powerpc/platforms/iseries/lpardata.c      |   10 +
 arch/powerpc/platforms/iseries/main_store.h    |  165 ++++++++++++++++++++++++
 arch/powerpc/platforms/iseries/pci.c           |    3 
 arch/powerpc/platforms/iseries/proc.c          |    5 -
 arch/powerpc/platforms/iseries/processor_vpd.h |   85 ++++++++++++
 arch/powerpc/platforms/iseries/release_data.h  |   63 +++++++++
 arch/powerpc/platforms/iseries/setup.c         |   10 +
 arch/powerpc/platforms/iseries/spcomm_area.h   |   36 +++++
 arch/powerpc/platforms/iseries/vpd_areas.h     |   88 +++++++++++++
 include/asm-ppc64/iSeries/HvCallSm.h           |   38 -----
 include/asm-ppc64/iSeries/HvReleaseData.h      |   64 ---------
 include/asm-ppc64/iSeries/IoHriMainStore.h     |  166 ------------------------
 include/asm-ppc64/iSeries/IoHriProcessorVpd.h  |   86 ------------
 include/asm-ppc64/iSeries/ItIplParmsReal.h     |   71 ----------
 include/asm-ppc64/iSeries/ItSpCommArea.h       |   37 -----
 include/asm-ppc64/iSeries/ItVpdAreas.h         |   89 -------------
 include/asm-ppc64/iSeries/iSeries_irq.h        |    8 -
 21 files changed, 569 insertions(+), 573 deletions(-)
 create mode 100644 arch/powerpc/platforms/iseries/call_sm.h
 create mode 100644 arch/powerpc/platforms/iseries/ipl_parms.h
 create mode 100644 arch/powerpc/platforms/iseries/irq.h
 create mode 100644 arch/powerpc/platforms/iseries/main_store.h
 create mode 100644 arch/powerpc/platforms/iseries/processor_vpd.h
 create mode 100644 arch/powerpc/platforms/iseries/release_data.h
 create mode 100644 arch/powerpc/platforms/iseries/spcomm_area.h
 create mode 100644 arch/powerpc/platforms/iseries/vpd_areas.h
 delete mode 100644 include/asm-ppc64/iSeries/HvCallSm.h
 delete mode 100644 include/asm-ppc64/iSeries/HvReleaseData.h
 delete mode 100644 include/asm-ppc64/iSeries/IoHriMainStore.h
 delete mode 100644 include/asm-ppc64/iSeries/IoHriProcessorVpd.h
 delete mode 100644 include/asm-ppc64/iSeries/ItIplParmsReal.h
 delete mode 100644 include/asm-ppc64/iSeries/ItSpCommArea.h
 delete mode 100644 include/asm-ppc64/iSeries/ItVpdAreas.h
 delete mode 100644 include/asm-ppc64/iSeries/iSeries_irq.h

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

b08567cb680686cdea9e362c0ccf0a08d77b9f0c
diff --git a/arch/powerpc/platforms/iseries/call_sm.h b/arch/powerpc/platforms/iseries/call_sm.h
new file mode 100644
--- /dev/null
+++ b/arch/powerpc/platforms/iseries/call_sm.h
@@ -0,0 +1,37 @@
+/*
+ * Copyright (C) 2001  Mike Corrigan IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+#ifndef _ISERIES_CALL_SM_H
+#define _ISERIES_CALL_SM_H
+
+/*
+ * This file contains the "hypervisor call" interface which is used to
+ * drive the hypervisor from the OS.
+ */
+
+#include <asm/iSeries/HvCallSc.h>
+#include <asm/iSeries/HvTypes.h>
+
+#define HvCallSmGet64BitsOfAccessMap	HvCallSm  + 11
+
+static inline u64 HvCallSm_get64BitsOfAccessMap(HvLpIndex lpIndex,
+		u64 indexIntoBitMap)
+{
+	return HvCall2(HvCallSmGet64BitsOfAccessMap, lpIndex, indexIntoBitMap);
+}
+
+#endif /* _ISERIES_CALL_SM_H */
diff --git a/arch/powerpc/platforms/iseries/ipl_parms.h b/arch/powerpc/platforms/iseries/ipl_parms.h
new file mode 100644
--- /dev/null
+++ b/arch/powerpc/platforms/iseries/ipl_parms.h
@@ -0,0 +1,70 @@
+/*
+ * Copyright (C) 2001  Mike Corrigan IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+#ifndef _ISERIES_IPL_PARMS_H
+#define _ISERIES_IPL_PARMS_H
+
+/*
+ *	This struct maps the IPL Parameters DMA'd from the SP.
+ *
+ * Warning:
+ *	This data must map in exactly 64 bytes and match the architecture for
+ *	the IPL parms
+ */
+
+#include <asm/types.h>
+
+struct ItIplParmsReal {
+	u8	xFormat;		// Defines format of IplParms	x00-x00
+	u8	xRsvd01:6;		// Reserved			x01-x01
+	u8	xAlternateSearch:1;	// Alternate search indicator	...
+	u8	xUaSupplied:1;		// UA Supplied on programmed IPL...
+	u8	xLsUaFormat;		// Format byte for UA		x02-x02
+	u8	xRsvd02;		// Reserved			x03-x03
+	u32	xLsUa;			// LS UA			x04-x07
+	u32	xUnusedLsLid;		// First OS LID to load		x08-x0B
+	u16	xLsBusNumber;		// LS Bus Number		x0C-x0D
+	u8	xLsCardAdr;		// LS Card Address		x0E-x0E
+	u8	xLsBoardAdr;		// LS Board Address		x0F-x0F
+	u32	xRsvd03;		// Reserved			x10-x13
+	u8	xSpcnPresent:1;		// SPCN present			x14-x14
+	u8	xCpmPresent:1;		// CPM present			...
+	u8	xRsvd04:6;		// Reserved			...
+	u8	xRsvd05:4;		// Reserved			x15-x15
+	u8	xKeyLock:4;		// Keylock setting		...
+	u8	xRsvd06:6;		// Reserved			x16-x16
+	u8	xIplMode:2;		// Ipl mode (A|B|C|D)		...
+	u8	xHwIplType;		// Fast v slow v slow EC HW IPL	x17-x17
+	u16	xCpmEnabledIpl:1;	// CPM in effect when IPL initiatedx18-x19
+	u16	xPowerOnResetIpl:1;	// Indicate POR condition	...
+	u16	xMainStorePreserved:1;	// Main Storage is preserved	...
+	u16	xRsvd07:13;		// Reserved			...
+	u16	xIplSource:16;		// Ipl source			x1A-x1B
+	u8	xIplReason:8;		// Reason for this IPL		x1C-x1C
+	u8	xRsvd08;		// Reserved			x1D-x1D
+	u16	xRsvd09;		// Reserved			x1E-x1F
+	u16	xSysBoxType;		// System Box Type		x20-x21
+	u16	xSysProcType;		// System Processor Type	x22-x23
+	u32	xRsvd10;		// Reserved			x24-x27
+	u64	xRsvd11;		// Reserved			x28-x2F
+	u64	xRsvd12;		// Reserved			x30-x37
+	u64	xRsvd13;		// Reserved			x38-x3F
+};
+
+extern struct ItIplParmsReal	xItIplParmsReal;
+
+#endif /* _ISERIES_IPL_PARMS_H */
diff --git a/arch/powerpc/platforms/iseries/irq.c b/arch/powerpc/platforms/iseries/irq.c
--- a/arch/powerpc/platforms/iseries/irq.c
+++ b/arch/powerpc/platforms/iseries/irq.c
@@ -40,7 +40,8 @@
 #include <asm/iSeries/HvLpEvent.h>
 #include <asm/iSeries/HvCallPci.h>
 #include <asm/iSeries/HvCallXm.h>
-#include <asm/iSeries/iSeries_irq.h>
+
+#include "irq.h"
 
 /* This maps virtual irq numbers to real irqs */
 unsigned int virt_irq_to_real_map[NR_IRQS];
diff --git a/arch/powerpc/platforms/iseries/irq.h b/arch/powerpc/platforms/iseries/irq.h
new file mode 100644
--- /dev/null
+++ b/arch/powerpc/platforms/iseries/irq.h
@@ -0,0 +1,8 @@
+#ifndef	_ISERIES_IRQ_H
+#define	_ISERIES_IRQ_H
+
+extern void iSeries_init_IRQ(void);
+extern int  iSeries_allocate_IRQ(HvBusNumber, HvSubBusNumber, HvAgentId);
+extern void iSeries_activate_IRQs(void);
+
+#endif /* _ISERIES_IRQ_H */
diff --git a/arch/powerpc/platforms/iseries/lpardata.c b/arch/powerpc/platforms/iseries/lpardata.c
--- a/arch/powerpc/platforms/iseries/lpardata.c
+++ b/arch/powerpc/platforms/iseries/lpardata.c
@@ -19,15 +19,15 @@
 #include <asm/lppaca.h>
 #include <asm/iSeries/ItLpRegSave.h>
 #include <asm/paca.h>
-#include <asm/iSeries/HvReleaseData.h>
 #include <asm/iSeries/LparMap.h>
-#include <asm/iSeries/ItVpdAreas.h>
-#include <asm/iSeries/ItIplParmsReal.h>
 #include <asm/iSeries/ItExtVpdPanel.h>
 #include <asm/iSeries/ItLpQueue.h>
-#include <asm/iSeries/IoHriProcessorVpd.h>
-#include <asm/iSeries/ItSpCommArea.h>
 
+#include "vpd_areas.h"
+#include "spcomm_area.h"
+#include "ipl_parms.h"
+#include "processor_vpd.h"
+#include "release_data.h"
 
 /* The HvReleaseData is the root of the information shared between
  * the hypervisor and Linux.
diff --git a/arch/powerpc/platforms/iseries/main_store.h b/arch/powerpc/platforms/iseries/main_store.h
new file mode 100644
--- /dev/null
+++ b/arch/powerpc/platforms/iseries/main_store.h
@@ -0,0 +1,165 @@
+/*
+ * Copyright (C) 2001  Mike Corrigan IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#ifndef _ISERIES_MAIN_STORE_H
+#define _ISERIES_MAIN_STORE_H
+
+/* Main Store Vpd for Condor,iStar,sStar */
+struct IoHriMainStoreSegment4 {
+	u8	msArea0Exists:1;
+	u8	msArea1Exists:1;
+	u8	msArea2Exists:1;
+	u8	msArea3Exists:1;
+	u8	reserved1:4;
+	u8	reserved2;
+
+	u8	msArea0Functional:1;
+	u8	msArea1Functional:1;
+	u8	msArea2Functional:1;
+	u8	msArea3Functional:1;
+	u8	reserved3:4;
+	u8	reserved4;
+
+	u32	totalMainStore;
+
+	u64	msArea0Ptr;
+	u64	msArea1Ptr;
+	u64	msArea2Ptr;
+	u64	msArea3Ptr;
+
+	u32	cardProductionLevel;
+
+	u32	msAdrHole;
+
+	u8	msArea0HasRiserVpd:1;
+	u8	msArea1HasRiserVpd:1;
+	u8	msArea2HasRiserVpd:1;
+	u8	msArea3HasRiserVpd:1;
+	u8	reserved5:4;
+	u8	reserved6;
+	u16	reserved7;
+
+	u8	reserved8[28];
+
+	u64	nonInterleavedBlocksStartAdr;
+	u64	nonInterleavedBlocksEndAdr;
+};
+
+/* Main Store VPD for Power4 */
+struct IoHriMainStoreChipInfo1 {
+	u32	chipMfgID	__attribute((packed));
+	char	chipECLevel[4]	__attribute((packed));
+};
+
+struct IoHriMainStoreVpdIdData {
+	char	typeNumber[4];
+	char	modelNumber[4];
+	char	partNumber[12];
+	char	serialNumber[12];
+};
+
+struct IoHriMainStoreVpdFruData {
+	char	fruLabel[8]	__attribute((packed));
+	u8	numberOfSlots	__attribute((packed));
+	u8	pluggingType	__attribute((packed));
+	u16	slotMapIndex	__attribute((packed));
+};
+
+struct IoHriMainStoreAdrRangeBlock {
+	void	*blockStart      __attribute((packed));
+	void	*blockEnd        __attribute((packed));
+	u32	blockProcChipId __attribute((packed));
+};
+
+#define MaxAreaAdrRangeBlocks 4
+
+struct IoHriMainStoreArea4 {
+	u32	msVpdFormat			__attribute((packed));
+	u8	containedVpdType		__attribute((packed));
+	u8	reserved1			__attribute((packed));
+	u16	reserved2			__attribute((packed));
+
+	u64	msExists			__attribute((packed));
+	u64	msFunctional			__attribute((packed));
+
+	u32	memorySize			__attribute((packed));
+	u32	procNodeId			__attribute((packed));
+
+	u32	numAdrRangeBlocks		__attribute((packed));
+	struct IoHriMainStoreAdrRangeBlock xAdrRangeBlock[MaxAreaAdrRangeBlocks]	__attribute((packed));
+
+	struct IoHriMainStoreChipInfo1	chipInfo0	__attribute((packed));
+	struct IoHriMainStoreChipInfo1	chipInfo1	__attribute((packed));
+	struct IoHriMainStoreChipInfo1	chipInfo2	__attribute((packed));
+	struct IoHriMainStoreChipInfo1	chipInfo3	__attribute((packed));
+	struct IoHriMainStoreChipInfo1	chipInfo4	__attribute((packed));
+	struct IoHriMainStoreChipInfo1	chipInfo5	__attribute((packed));
+	struct IoHriMainStoreChipInfo1	chipInfo6	__attribute((packed));
+	struct IoHriMainStoreChipInfo1	chipInfo7	__attribute((packed));
+
+	void	*msRamAreaArray			__attribute((packed));
+	u32	msRamAreaArrayNumEntries	__attribute((packed));
+	u32	msRamAreaArrayEntrySize		__attribute((packed));
+
+	u32	numaDimmExists			__attribute((packed));
+	u32	numaDimmFunctional		__attribute((packed));
+	void	*numaDimmArray			__attribute((packed));
+	u32	numaDimmArrayNumEntries		__attribute((packed));
+	u32	numaDimmArrayEntrySize		__attribute((packed));
+
+	struct IoHriMainStoreVpdIdData idData	__attribute((packed));
+
+	u64	powerData			__attribute((packed));
+	u64	cardAssemblyPartNum		__attribute((packed));
+	u64	chipSerialNum			__attribute((packed));
+
+	u64	reserved3			__attribute((packed));
+	char	reserved4[16]			__attribute((packed));
+
+	struct IoHriMainStoreVpdFruData fruData	__attribute((packed));
+
+	u8	vpdPortNum			__attribute((packed));
+	u8	reserved5			__attribute((packed));
+	u8	frameId				__attribute((packed));
+	u8	rackUnit			__attribute((packed));
+	char	asciiKeywordVpd[256]		__attribute((packed));
+	u32	reserved6			__attribute((packed));
+};
+
+
+struct IoHriMainStoreSegment5 {
+	u16	reserved1;
+	u8	reserved2;
+	u8	msVpdFormat;
+
+	u32	totalMainStore;
+	u64	maxConfiguredMsAdr;
+
+	struct IoHriMainStoreArea4	*msAreaArray;
+	u32	msAreaArrayNumEntries;
+	u32	msAreaArrayEntrySize;
+
+	u32	msAreaExists;
+	u32	msAreaFunctional;
+
+	u64	reserved3;
+};
+
+extern u64	xMsVpd[];
+
+#endif	/* _ISERIES_MAIN_STORE_H */
diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -37,12 +37,13 @@
 
 #include <asm/iSeries/HvCallPci.h>
 #include <asm/iSeries/HvCallXm.h>
-#include <asm/iSeries/iSeries_irq.h>
 #include <asm/iSeries/iSeries_pci.h>
 #include <asm/iSeries/mf.h>
 
 #include <asm/ppc-pci.h>
 
+#include "irq.h"
+
 extern unsigned long io_page_mask;
 
 /*
diff --git a/arch/powerpc/platforms/iseries/proc.c b/arch/powerpc/platforms/iseries/proc.c
--- a/arch/powerpc/platforms/iseries/proc.c
+++ b/arch/powerpc/platforms/iseries/proc.c
@@ -26,8 +26,9 @@
 #include <asm/lppaca.h>
 #include <asm/iSeries/ItLpQueue.h>
 #include <asm/iSeries/HvCallXm.h>
-#include <asm/iSeries/IoHriMainStore.h>
-#include <asm/iSeries/IoHriProcessorVpd.h>
+
+#include "processor_vpd.h"
+#include "main_store.h"
 
 static int __init iseries_proc_create(void)
 {
diff --git a/arch/powerpc/platforms/iseries/processor_vpd.h b/arch/powerpc/platforms/iseries/processor_vpd.h
new file mode 100644
--- /dev/null
+++ b/arch/powerpc/platforms/iseries/processor_vpd.h
@@ -0,0 +1,85 @@
+/*
+ * Copyright (C) 2001  Mike Corrigan IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+#ifndef _ISERIES_PROCESSOR_VPD_H
+#define _ISERIES_PROCESSOR_VPD_H
+
+#include <asm/types.h>
+
+/*
+ * This struct maps Processor Vpd that is DMAd to SLIC by CSP
+ */
+struct IoHriProcessorVpd {
+	u8	xFormat;		// VPD format indicator		x00-x00
+	u8	xProcStatus:8;		// Processor State		x01-x01
+	u8	xSecondaryThreadCount;	// Secondary thread cnt		x02-x02
+	u8	xSrcType:1;		// Src Type			x03-x03
+	u8	xSrcSoft:1;		// Src stay soft		...
+	u8	xSrcParable:1;		// Src parable			...
+	u8	xRsvd1:5;		// Reserved			...
+	u16	xHvPhysicalProcIndex;	// Hypervisor physical proc index04-x05
+	u16	xRsvd2;			// Reserved			x06-x07
+	u32	xHwNodeId;		// Hardware node id		x08-x0B
+	u32	xHwProcId;		// Hardware processor id	x0C-x0F
+
+	u32	xTypeNum;		// Card Type/CCIN number	x10-x13
+	u32	xModelNum;		// Model/Feature number		x14-x17
+	u64	xSerialNum;		// Serial number		x18-x1F
+	char	xPartNum[12];		// Book Part or FPU number	x20-x2B
+	char	xMfgID[4];		// Manufacturing ID		x2C-x2F
+
+	u32	xProcFreq;		// Processor Frequency		x30-x33
+	u32	xTimeBaseFreq;		// Time Base Frequency		x34-x37
+
+	u32	xChipEcLevel;		// Chip EC Levels		x38-x3B
+	u32	xProcIdReg;		// PIR SPR value		x3C-x3F
+	u32	xPVR;			// PVR value			x40-x43
+	u8	xRsvd3[12];		// Reserved			x44-x4F
+
+	u32	xInstCacheSize;		// Instruction cache size in KB	x50-x53
+	u32	xInstBlockSize;		// Instruction cache block size	x54-x57
+	u32	xDataCacheOperandSize;	// Data cache operand size	x58-x5B
+	u32	xInstCacheOperandSize;	// Inst cache operand size	x5C-x5F
+
+	u32	xDataL1CacheSizeKB;	// L1 data cache size in KB	x60-x63
+	u32	xDataL1CacheLineSize;	// L1 data cache block size	x64-x67
+	u64	xRsvd4;			// Reserved			x68-x6F
+
+	u32	xDataL2CacheSizeKB;	// L2 data cache size in KB	x70-x73
+	u32	xDataL2CacheLineSize;	// L2 data cache block size	x74-x77
+	u64	xRsvd5;			// Reserved			x78-x7F
+
+	u32	xDataL3CacheSizeKB;	// L3 data cache size in KB	x80-x83
+	u32	xDataL3CacheLineSize;	// L3 data cache block size	x84-x87
+	u64	xRsvd6;			// Reserved			x88-x8F
+
+	u64	xFruLabel;		// Card Location Label		x90-x97
+	u8	xSlotsOnCard;		// Slots on card (0=no slots)	x98-x98
+	u8	xPartLocFlag;		// Location flag (0-pluggable 1-imbedded) x99-x99
+	u16	xSlotMapIndex;		// Index in slot map table	x9A-x9B
+	u8	xSmartCardPortNo;	// Smart card port number	x9C-x9C
+	u8	xRsvd7;			// Reserved			x9D-x9D
+	u16	xFrameIdAndRackUnit;	// Frame ID and rack unit adr	x9E-x9F
+
+	u8	xRsvd8[24];		// Reserved			xA0-xB7
+
+	char	xProcSrc[72];		// CSP format SRC		xB8-xFF
+};
+
+extern struct IoHriProcessorVpd	xIoHriProcessorVpd[];
+
+#endif /* _ISERIES_PROCESSOR_VPD_H */
diff --git a/arch/powerpc/platforms/iseries/release_data.h b/arch/powerpc/platforms/iseries/release_data.h
new file mode 100644
--- /dev/null
+++ b/arch/powerpc/platforms/iseries/release_data.h
@@ -0,0 +1,63 @@
+/*
+ * Copyright (C) 2001  Mike Corrigan IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+#ifndef _ISERIES_RELEASE_DATA_H
+#define _ISERIES_RELEASE_DATA_H
+
+/*
+ * This control block contains the critical information about the
+ * release so that it can be changed in the future (ie, the virtual
+ * address of the OS's NACA).
+ */
+#include <asm/types.h>
+#include <asm/naca.h>
+
+/*
+ * When we IPL a secondary partition, we will check if if the
+ * secondary xMinPlicVrmIndex > the primary xVrmIndex.
+ * If it is then this tells PLIC that this secondary is not
+ * supported running on this "old" of a level of PLIC.
+ *
+ * Likewise, we will compare the primary xMinSlicVrmIndex to
+ * the secondary xVrmIndex.
+ * If the primary xMinSlicVrmDelta > secondary xVrmDelta then we
+ * know that this PLIC does not support running an OS "that old".
+ */
+
+#define	HVREL_TAGSINACTIVE	0x8000
+#define HVREL_32BIT		0x4000
+#define HVREL_NOSHAREDPROCS	0x2000
+#define HVREL_NOHMT		0x1000
+
+struct HvReleaseData {
+	u32	xDesc;		/* Descriptor "HvRD" ebcdic	x00-x03 */
+	u16	xSize;		/* Size of this control block	x04-x05 */
+	u16	xVpdAreasPtrOffset; /* Offset in NACA of ItVpdAreas x06-x07 */
+	struct  naca_struct	*xSlicNacaAddr; /* Virt addr of SLIC NACA x08-x0F */
+	u32	xMsNucDataOffset; /* Offset of Linux Mapping Data x10-x13 */
+	u32	xRsvd1;		/* Reserved			x14-x17 */
+	u16	xFlags;
+	u16	xVrmIndex;	/* VRM Index of OS image	x1A-x1B */
+	u16	xMinSupportedPlicVrmIndex; /* Min PLIC level  (soft) x1C-x1D */
+	u16	xMinCompatablePlicVrmIndex; /* Min PLIC levelP (hard) x1E-x1F */
+	char	xVrmName[12];	/* Displayable name		x20-x2B */
+	char	xRsvd3[20];	/* Reserved			x2C-x3F */
+};
+
+extern struct HvReleaseData	hvReleaseData;
+
+#endif /* _ISERIES_RELEASE_DATA_H */
diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platforms/iseries/setup.c
--- a/arch/powerpc/platforms/iseries/setup.c
+++ b/arch/powerpc/platforms/iseries/setup.c
@@ -48,18 +48,18 @@
 #include <asm/iSeries/HvCallHpt.h>
 #include <asm/iSeries/HvLpConfig.h>
 #include <asm/iSeries/HvCallEvent.h>
-#include <asm/iSeries/HvCallSm.h>
 #include <asm/iSeries/HvCallXm.h>
 #include <asm/iSeries/ItLpQueue.h>
-#include <asm/iSeries/IoHriMainStore.h>
 #include <asm/iSeries/mf.h>
 #include <asm/iSeries/HvLpEvent.h>
-#include <asm/iSeries/iSeries_irq.h>
-#include <asm/iSeries/IoHriProcessorVpd.h>
-#include <asm/iSeries/ItVpdAreas.h>
 #include <asm/iSeries/LparMap.h>
 
 #include "setup.h"
+#include "irq.h"
+#include "vpd_areas.h"
+#include "processor_vpd.h"
+#include "main_store.h"
+#include "call_sm.h"
 
 extern void hvlog(char *fmt, ...);
 
diff --git a/arch/powerpc/platforms/iseries/spcomm_area.h b/arch/powerpc/platforms/iseries/spcomm_area.h
new file mode 100644
--- /dev/null
+++ b/arch/powerpc/platforms/iseries/spcomm_area.h
@@ -0,0 +1,36 @@
+/*
+ * Copyright (C) 2001  Mike Corrigan IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#ifndef _ISERIES_SPCOMM_AREA_H
+#define _ISERIES_SPCOMM_AREA_H
+
+
+struct SpCommArea {
+	u32	xDesc;			// Descriptor (only in new formats)	000-003
+	u8	xFormat;		// Format (only in new formats)		004-004
+	u8	xRsvd1[11];		// Reserved				005-00F
+	u64	xRawTbAtIplStart;	// Raw HW TB value when IPL is started	010-017
+	u64	xRawTodAtIplStart;	// Raw HW TOD value when IPL is started	018-01F
+	u64	xBcdTimeAtIplStart;	// BCD time when IPL is started		020-027
+	u64	xBcdTimeAtOsStart;	// BCD time when OS passed control	028-02F
+	u8	xRsvd2[80];		// Reserved				030-07F
+};
+
+extern struct SpCommArea xSpCommArea;
+
+#endif /* _ISERIES_SPCOMM_AREA_H */
diff --git a/arch/powerpc/platforms/iseries/vpd_areas.h b/arch/powerpc/platforms/iseries/vpd_areas.h
new file mode 100644
--- /dev/null
+++ b/arch/powerpc/platforms/iseries/vpd_areas.h
@@ -0,0 +1,88 @@
+/*
+ * Copyright (C) 2001  Mike Corrigan IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+#ifndef _ISERIES_VPD_AREAS_H
+#define _ISERIES_VPD_AREAS_H
+
+/*
+ * This file defines the address and length of all of the VPD area passed to
+ * the OS from PLIC (most of which start from the SP).
+ */
+
+#include <asm/types.h>
+
+/* VPD Entry index is carved in stone - cannot be changed (easily). */
+#define ItVpdCecVpd				0
+#define ItVpdDynamicSpace			1
+#define ItVpdExtVpd				2
+#define ItVpdExtVpdOnPanel			3
+#define ItVpdFirstPaca				4
+#define ItVpdIoVpd				5
+#define ItVpdIplParms				6
+#define ItVpdMsVpd				7
+#define ItVpdPanelVpd				8
+#define ItVpdLpNaca				9
+#define ItVpdBackplaneAndMaybeClockCardVpd	10
+#define ItVpdRecoveryLogBuffer			11
+#define ItVpdSpCommArea				12
+#define ItVpdSpLogBuffer			13
+#define ItVpdSpLogBufferSave			14
+#define ItVpdSpCardVpd				15
+#define ItVpdFirstProcVpd			16
+#define ItVpdApModelVpd				17
+#define ItVpdClockCardVpd			18
+#define ItVpdBusExtCardVpd			19
+#define ItVpdProcCapacityVpd			20
+#define ItVpdInteractiveCapacityVpd		21
+#define ItVpdFirstSlotLabel			22
+#define ItVpdFirstLpQueue			23
+#define ItVpdFirstL3CacheVpd			24
+#define ItVpdFirstProcFruVpd			25
+
+#define ItVpdMaxEntries				26
+
+#define ItDmaMaxEntries				10
+
+#define ItVpdAreasMaxSlotLabels			192
+
+
+struct ItVpdAreas {
+	u32	xSlicDesc;		// Descriptor			000-003
+	u16	xSlicSize;		// Size of this control block	004-005
+	u16	xPlicAdjustVpdLens:1;	// Flag to indicate new interface006-007
+	u16	xRsvd1:15;		// Reserved bits		...
+	u16	xSlicVpdEntries;	// Number of VPD entries	008-009
+	u16	xSlicDmaEntries;	// Number of DMA entries	00A-00B
+	u16	xSlicMaxLogicalProcs;	// Maximum logical processors	00C-00D
+	u16	xSlicMaxPhysicalProcs;	// Maximum physical processors	00E-00F
+	u16	xSlicDmaToksOffset;	// Offset into this of array	010-011
+	u16	xSlicVpdAdrsOffset;	// Offset into this of array	012-013
+	u16	xSlicDmaLensOffset;	// Offset into this of array	014-015
+	u16	xSlicVpdLensOffset;	// Offset into this of array	016-017
+	u16	xSlicMaxSlotLabels;	// Maximum number of slot labels018-019
+	u16	xSlicMaxLpQueues;	// Maximum number of LP Queues	01A-01B
+	u8	xRsvd2[4];		// Reserved			01C-01F
+	u64	xRsvd3[12];		// Reserved			020-07F
+	u32	xPlicDmaLens[ItDmaMaxEntries];// Array of DMA lengths	080-0A7
+	u32	xPlicDmaToks[ItDmaMaxEntries];// Array of DMA tokens	0A8-0CF
+	u32	xSlicVpdLens[ItVpdMaxEntries];// Array of VPD lengths	0D0-12F
+	void	*xSlicVpdAdrs[ItVpdMaxEntries];// Array of VPD buffers	130-1EF
+};
+
+extern struct ItVpdAreas	itVpdAreas;
+
+#endif /* _ISERIES_VPD_AREAS_H */
diff --git a/include/asm-ppc64/iSeries/HvCallSm.h b/include/asm-ppc64/iSeries/HvCallSm.h
deleted file mode 100644
--- a/include/asm-ppc64/iSeries/HvCallSm.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/*
- * HvCallSm.h
- * Copyright (C) 2001  Mike Corrigan IBM Corporation
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#ifndef _HVCALLSM_H
-#define _HVCALLSM_H
-
-/*
- * This file contains the "hypervisor call" interface which is used to
- * drive the hypervisor from the OS.
- */
-
-#include <asm/iSeries/HvCallSc.h>
-#include <asm/iSeries/HvTypes.h>
-
-#define HvCallSmGet64BitsOfAccessMap	HvCallSm  + 11
-
-static inline u64 HvCallSm_get64BitsOfAccessMap(HvLpIndex lpIndex,
-		u64 indexIntoBitMap)
-{
-	return HvCall2(HvCallSmGet64BitsOfAccessMap, lpIndex, indexIntoBitMap);
-}
-
-#endif /* _HVCALLSM_H */
diff --git a/include/asm-ppc64/iSeries/HvReleaseData.h b/include/asm-ppc64/iSeries/HvReleaseData.h
deleted file mode 100644
--- a/include/asm-ppc64/iSeries/HvReleaseData.h
+++ /dev/null
@@ -1,64 +0,0 @@
-/*
- * HvReleaseData.h
- * Copyright (C) 2001  Mike Corrigan IBM Corporation
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#ifndef _HVRELEASEDATA_H
-#define _HVRELEASEDATA_H
-
-/*
- * This control block contains the critical information about the
- * release so that it can be changed in the future (ie, the virtual
- * address of the OS's NACA).
- */
-#include <asm/types.h>
-#include <asm/naca.h>
-
-/*
- * When we IPL a secondary partition, we will check if if the
- * secondary xMinPlicVrmIndex > the primary xVrmIndex.
- * If it is then this tells PLIC that this secondary is not
- * supported running on this "old" of a level of PLIC.
- *
- * Likewise, we will compare the primary xMinSlicVrmIndex to
- * the secondary xVrmIndex.
- * If the primary xMinSlicVrmDelta > secondary xVrmDelta then we
- * know that this PLIC does not support running an OS "that old".
- */
-
-#define	HVREL_TAGSINACTIVE	0x8000
-#define HVREL_32BIT		0x4000
-#define HVREL_NOSHAREDPROCS	0x2000
-#define HVREL_NOHMT		0x1000
-
-struct HvReleaseData {
-	u32	xDesc;		/* Descriptor "HvRD" ebcdic	x00-x03 */
-	u16	xSize;		/* Size of this control block	x04-x05 */
-	u16	xVpdAreasPtrOffset; /* Offset in NACA of ItVpdAreas x06-x07 */
-	struct  naca_struct	*xSlicNacaAddr; /* Virt addr of SLIC NACA x08-x0F */
-	u32	xMsNucDataOffset; /* Offset of Linux Mapping Data x10-x13 */
-	u32	xRsvd1;		/* Reserved			x14-x17 */
-	u16	xFlags;
-	u16	xVrmIndex;	/* VRM Index of OS image	x1A-x1B */
-	u16	xMinSupportedPlicVrmIndex; /* Min PLIC level  (soft) x1C-x1D */
-	u16	xMinCompatablePlicVrmIndex; /* Min PLIC levelP (hard) x1E-x1F */
-	char	xVrmName[12];	/* Displayable name		x20-x2B */
-	char	xRsvd3[20];	/* Reserved			x2C-x3F */
-};
-
-extern struct HvReleaseData	hvReleaseData;
-
-#endif /* _HVRELEASEDATA_H */
diff --git a/include/asm-ppc64/iSeries/IoHriMainStore.h b/include/asm-ppc64/iSeries/IoHriMainStore.h
deleted file mode 100644
--- a/include/asm-ppc64/iSeries/IoHriMainStore.h
+++ /dev/null
@@ -1,166 +0,0 @@
-/*
- * IoHriMainStore.h
- * Copyright (C) 2001  Mike Corrigan IBM Corporation
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-
-#ifndef _IOHRIMAINSTORE_H
-#define _IOHRIMAINSTORE_H
-
-/* Main Store Vpd for Condor,iStar,sStar */
-struct IoHriMainStoreSegment4 {
-	u8	msArea0Exists:1;
-	u8	msArea1Exists:1;
-	u8	msArea2Exists:1;
-	u8	msArea3Exists:1;
-	u8	reserved1:4;
-	u8	reserved2;
-
-	u8	msArea0Functional:1;
-	u8	msArea1Functional:1;
-	u8	msArea2Functional:1;
-	u8	msArea3Functional:1;
-	u8	reserved3:4;
-	u8	reserved4;
-
-	u32	totalMainStore;
-
-	u64	msArea0Ptr;
-	u64	msArea1Ptr;
-	u64	msArea2Ptr;
-	u64	msArea3Ptr;
-
-	u32	cardProductionLevel;
-
-	u32	msAdrHole;
-
-	u8	msArea0HasRiserVpd:1;
-	u8	msArea1HasRiserVpd:1;
-	u8	msArea2HasRiserVpd:1;
-	u8	msArea3HasRiserVpd:1;
-	u8	reserved5:4;
-	u8	reserved6;
-	u16	reserved7;
-
-	u8	reserved8[28];
-
-	u64	nonInterleavedBlocksStartAdr;
-	u64	nonInterleavedBlocksEndAdr;
-};
-
-/* Main Store VPD for Power4 */
-struct IoHriMainStoreChipInfo1 {
-	u32	chipMfgID	__attribute((packed));
-	char	chipECLevel[4]	__attribute((packed));
-};
-
-struct IoHriMainStoreVpdIdData {
-	char	typeNumber[4];
-	char	modelNumber[4];
-	char	partNumber[12];
-	char	serialNumber[12];
-};
-
-struct IoHriMainStoreVpdFruData {
-	char	fruLabel[8]	__attribute((packed));
-	u8	numberOfSlots	__attribute((packed));
-	u8	pluggingType	__attribute((packed));
-	u16	slotMapIndex	__attribute((packed));
-};
-
-struct IoHriMainStoreAdrRangeBlock {
-	void	*blockStart      __attribute((packed));
-	void	*blockEnd        __attribute((packed));
-	u32	blockProcChipId __attribute((packed));
-};
-
-#define MaxAreaAdrRangeBlocks 4
-
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
-};
-
-
-struct IoHriMainStoreSegment5 {
-	u16	reserved1;
-	u8	reserved2;
-	u8	msVpdFormat;
-
-	u32	totalMainStore;
-	u64	maxConfiguredMsAdr;
-
-	struct IoHriMainStoreArea4	*msAreaArray;
-	u32	msAreaArrayNumEntries;
-	u32	msAreaArrayEntrySize;
-
-	u32	msAreaExists;
-	u32	msAreaFunctional;
-
-	u64	reserved3;
-};
-
-extern u64	xMsVpd[];
-
-#endif	/* _IOHRIMAINSTORE_H */
diff --git a/include/asm-ppc64/iSeries/IoHriProcessorVpd.h b/include/asm-ppc64/iSeries/IoHriProcessorVpd.h
deleted file mode 100644
--- a/include/asm-ppc64/iSeries/IoHriProcessorVpd.h
+++ /dev/null
@@ -1,86 +0,0 @@
-/*
- * IoHriProcessorVpd.h
- * Copyright (C) 2001  Mike Corrigan IBM Corporation
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#ifndef _IOHRIPROCESSORVPD_H
-#define _IOHRIPROCESSORVPD_H
-
-#include <asm/types.h>
-
-/*
- * This struct maps Processor Vpd that is DMAd to SLIC by CSP
- */
-struct IoHriProcessorVpd {
-	u8	xFormat;		// VPD format indicator		x00-x00
-	u8	xProcStatus:8;		// Processor State		x01-x01
-	u8	xSecondaryThreadCount;	// Secondary thread cnt		x02-x02
-	u8	xSrcType:1;		// Src Type			x03-x03
-	u8	xSrcSoft:1;		// Src stay soft		...
-	u8	xSrcParable:1;		// Src parable			...
-	u8	xRsvd1:5;		// Reserved			...
-	u16	xHvPhysicalProcIndex;	// Hypervisor physical proc index04-x05
-	u16	xRsvd2;			// Reserved			x06-x07
-	u32	xHwNodeId;		// Hardware node id		x08-x0B
-	u32	xHwProcId;		// Hardware processor id	x0C-x0F
-
-	u32	xTypeNum;		// Card Type/CCIN number	x10-x13
-	u32	xModelNum;		// Model/Feature number		x14-x17
-	u64	xSerialNum;		// Serial number		x18-x1F
-	char	xPartNum[12];		// Book Part or FPU number	x20-x2B
-	char	xMfgID[4];		// Manufacturing ID		x2C-x2F
-
-	u32	xProcFreq;		// Processor Frequency		x30-x33
-	u32	xTimeBaseFreq;		// Time Base Frequency		x34-x37
-
-	u32	xChipEcLevel;		// Chip EC Levels		x38-x3B
-	u32	xProcIdReg;		// PIR SPR value		x3C-x3F
-	u32	xPVR;			// PVR value			x40-x43
-	u8	xRsvd3[12];		// Reserved			x44-x4F
-
-	u32	xInstCacheSize;		// Instruction cache size in KB	x50-x53
-	u32	xInstBlockSize;		// Instruction cache block size	x54-x57
-	u32	xDataCacheOperandSize;	// Data cache operand size	x58-x5B
-	u32	xInstCacheOperandSize;	// Inst cache operand size	x5C-x5F
-
-	u32	xDataL1CacheSizeKB;	// L1 data cache size in KB	x60-x63
-	u32	xDataL1CacheLineSize;	// L1 data cache block size	x64-x67
-	u64	xRsvd4;			// Reserved			x68-x6F
-
-	u32	xDataL2CacheSizeKB;	// L2 data cache size in KB	x70-x73
-	u32	xDataL2CacheLineSize;	// L2 data cache block size	x74-x77
-	u64	xRsvd5;			// Reserved			x78-x7F
-
-	u32	xDataL3CacheSizeKB;	// L3 data cache size in KB	x80-x83
-	u32	xDataL3CacheLineSize;	// L3 data cache block size	x84-x87
-	u64	xRsvd6;			// Reserved			x88-x8F
-
-	u64	xFruLabel;		// Card Location Label		x90-x97
-	u8	xSlotsOnCard;		// Slots on card (0=no slots)	x98-x98
-	u8	xPartLocFlag;		// Location flag (0-pluggable 1-imbedded) x99-x99
-	u16	xSlotMapIndex;		// Index in slot map table	x9A-x9B
-	u8	xSmartCardPortNo;	// Smart card port number	x9C-x9C
-	u8	xRsvd7;			// Reserved			x9D-x9D
-	u16	xFrameIdAndRackUnit;	// Frame ID and rack unit adr	x9E-x9F
-
-	u8	xRsvd8[24];		// Reserved			xA0-xB7
-
-	char	xProcSrc[72];		// CSP format SRC		xB8-xFF
-};
-
-extern struct IoHriProcessorVpd	xIoHriProcessorVpd[];
-
-#endif /* _IOHRIPROCESSORVPD_H */
diff --git a/include/asm-ppc64/iSeries/ItIplParmsReal.h b/include/asm-ppc64/iSeries/ItIplParmsReal.h
deleted file mode 100644
--- a/include/asm-ppc64/iSeries/ItIplParmsReal.h
+++ /dev/null
@@ -1,71 +0,0 @@
-/*
- * ItIplParmsReal.h
- * Copyright (C) 2001  Mike Corrigan IBM Corporation
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#ifndef _ITIPLPARMSREAL_H
-#define _ITIPLPARMSREAL_H
-
-/*
- *	This struct maps the IPL Parameters DMA'd from the SP.
- *
- * Warning:
- *	This data must map in exactly 64 bytes and match the architecture for
- *	the IPL parms
- */
-
-#include <asm/types.h>
-
-struct ItIplParmsReal {
-	u8	xFormat;		// Defines format of IplParms	x00-x00
-	u8	xRsvd01:6;		// Reserved			x01-x01
-	u8	xAlternateSearch:1;	// Alternate search indicator	...
-	u8	xUaSupplied:1;		// UA Supplied on programmed IPL...
-	u8	xLsUaFormat;		// Format byte for UA		x02-x02
-	u8	xRsvd02;		// Reserved			x03-x03
-	u32	xLsUa;			// LS UA			x04-x07
-	u32	xUnusedLsLid;		// First OS LID to load		x08-x0B
-	u16	xLsBusNumber;		// LS Bus Number		x0C-x0D
-	u8	xLsCardAdr;		// LS Card Address		x0E-x0E
-	u8	xLsBoardAdr;		// LS Board Address		x0F-x0F
-	u32	xRsvd03;		// Reserved			x10-x13
-	u8	xSpcnPresent:1;		// SPCN present			x14-x14
-	u8	xCpmPresent:1;		// CPM present			...
-	u8	xRsvd04:6;		// Reserved			...
-	u8	xRsvd05:4;		// Reserved			x15-x15
-	u8	xKeyLock:4;		// Keylock setting		...
-	u8	xRsvd06:6;		// Reserved			x16-x16
-	u8	xIplMode:2;		// Ipl mode (A|B|C|D)		...
-	u8	xHwIplType;		// Fast v slow v slow EC HW IPL	x17-x17
-	u16	xCpmEnabledIpl:1;	// CPM in effect when IPL initiatedx18-x19
-	u16	xPowerOnResetIpl:1;	// Indicate POR condition	...
-	u16	xMainStorePreserved:1;	// Main Storage is preserved	...
-	u16	xRsvd07:13;		// Reserved			...
-	u16	xIplSource:16;		// Ipl source			x1A-x1B
-	u8	xIplReason:8;		// Reason for this IPL		x1C-x1C
-	u8	xRsvd08;		// Reserved			x1D-x1D
-	u16	xRsvd09;		// Reserved			x1E-x1F
-	u16	xSysBoxType;		// System Box Type		x20-x21
-	u16	xSysProcType;		// System Processor Type	x22-x23
-	u32	xRsvd10;		// Reserved			x24-x27
-	u64	xRsvd11;		// Reserved			x28-x2F
-	u64	xRsvd12;		// Reserved			x30-x37
-	u64	xRsvd13;		// Reserved			x38-x3F
-};
-
-extern struct ItIplParmsReal	xItIplParmsReal;
-
-#endif /* _ITIPLPARMSREAL_H */
diff --git a/include/asm-ppc64/iSeries/ItSpCommArea.h b/include/asm-ppc64/iSeries/ItSpCommArea.h
deleted file mode 100644
--- a/include/asm-ppc64/iSeries/ItSpCommArea.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- * ItSpCommArea.h
- * Copyright (C) 2001  Mike Corrigan IBM Corporation
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-
-#ifndef _ITSPCOMMAREA_H
-#define _ITSPCOMMAREA_H
-
-
-struct SpCommArea {
-	u32	xDesc;			// Descriptor (only in new formats)	000-003
-	u8	xFormat;		// Format (only in new formats)		004-004
-	u8	xRsvd1[11];		// Reserved				005-00F
-	u64	xRawTbAtIplStart;	// Raw HW TB value when IPL is started	010-017
-	u64	xRawTodAtIplStart;	// Raw HW TOD value when IPL is started	018-01F
-	u64	xBcdTimeAtIplStart;	// BCD time when IPL is started		020-027
-	u64	xBcdTimeAtOsStart;	// BCD time when OS passed control	028-02F
-	u8	xRsvd2[80];		// Reserved				030-07F
-};
-
-extern struct SpCommArea xSpCommArea;
-
-#endif /* _ITSPCOMMAREA_H */
diff --git a/include/asm-ppc64/iSeries/ItVpdAreas.h b/include/asm-ppc64/iSeries/ItVpdAreas.h
deleted file mode 100644
--- a/include/asm-ppc64/iSeries/ItVpdAreas.h
+++ /dev/null
@@ -1,89 +0,0 @@
-/*
- * ItVpdAreas.h
- * Copyright (C) 2001  Mike Corrigan IBM Corporation
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
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-#ifndef _ITVPDAREAS_H
-#define _ITVPDAREAS_H
-
-/*
- * This file defines the address and length of all of the VPD area passed to
- * the OS from PLIC (most of which start from the SP).
- */
-
-#include <asm/types.h>
-
-/* VPD Entry index is carved in stone - cannot be changed (easily). */
-#define ItVpdCecVpd				0
-#define ItVpdDynamicSpace			1
-#define ItVpdExtVpd				2
-#define ItVpdExtVpdOnPanel			3
-#define ItVpdFirstPaca				4
-#define ItVpdIoVpd				5
-#define ItVpdIplParms				6
-#define ItVpdMsVpd				7
-#define ItVpdPanelVpd				8
-#define ItVpdLpNaca				9
-#define ItVpdBackplaneAndMaybeClockCardVpd	10
-#define ItVpdRecoveryLogBuffer			11
-#define ItVpdSpCommArea				12
-#define ItVpdSpLogBuffer			13
-#define ItVpdSpLogBufferSave			14
-#define ItVpdSpCardVpd				15
-#define ItVpdFirstProcVpd			16
-#define ItVpdApModelVpd				17
-#define ItVpdClockCardVpd			18
-#define ItVpdBusExtCardVpd			19
-#define ItVpdProcCapacityVpd			20
-#define ItVpdInteractiveCapacityVpd		21
-#define ItVpdFirstSlotLabel			22
-#define ItVpdFirstLpQueue			23
-#define ItVpdFirstL3CacheVpd			24
-#define ItVpdFirstProcFruVpd			25
-
-#define ItVpdMaxEntries				26
-
-#define ItDmaMaxEntries				10
-
-#define ItVpdAreasMaxSlotLabels			192
-
-
-struct ItVpdAreas {
-	u32	xSlicDesc;		// Descriptor			000-003
-	u16	xSlicSize;		// Size of this control block	004-005
-	u16	xPlicAdjustVpdLens:1;	// Flag to indicate new interface006-007
-	u16	xRsvd1:15;		// Reserved bits		...
-	u16	xSlicVpdEntries;	// Number of VPD entries	008-009
-	u16	xSlicDmaEntries;	// Number of DMA entries	00A-00B
-	u16	xSlicMaxLogicalProcs;	// Maximum logical processors	00C-00D
-	u16	xSlicMaxPhysicalProcs;	// Maximum physical processors	00E-00F
-	u16	xSlicDmaToksOffset;	// Offset into this of array	010-011
-	u16	xSlicVpdAdrsOffset;	// Offset into this of array	012-013
-	u16	xSlicDmaLensOffset;	// Offset into this of array	014-015
-	u16	xSlicVpdLensOffset;	// Offset into this of array	016-017
-	u16	xSlicMaxSlotLabels;	// Maximum number of slot labels018-019
-	u16	xSlicMaxLpQueues;	// Maximum number of LP Queues	01A-01B
-	u8	xRsvd2[4];		// Reserved			01C-01F
-	u64	xRsvd3[12];		// Reserved			020-07F
-	u32	xPlicDmaLens[ItDmaMaxEntries];// Array of DMA lengths	080-0A7
-	u32	xPlicDmaToks[ItDmaMaxEntries];// Array of DMA tokens	0A8-0CF
-	u32	xSlicVpdLens[ItVpdMaxEntries];// Array of VPD lengths	0D0-12F
-	void	*xSlicVpdAdrs[ItVpdMaxEntries];// Array of VPD buffers	130-1EF
-};
-
-extern struct ItVpdAreas	itVpdAreas;
-
-#endif /* _ITVPDAREAS_H */
diff --git a/include/asm-ppc64/iSeries/iSeries_irq.h b/include/asm-ppc64/iSeries/iSeries_irq.h
deleted file mode 100644
--- a/include/asm-ppc64/iSeries/iSeries_irq.h
+++ /dev/null
@@ -1,8 +0,0 @@
-#ifndef	__ISERIES_IRQ_H__
-#define	__ISERIES_IRQ_H__
-
-extern void iSeries_init_IRQ(void);
-extern int  iSeries_allocate_IRQ(HvBusNumber, HvSubBusNumber, HvAgentId);
-extern void iSeries_activate_IRQs(void);
-
-#endif /* __ISERIES_IRQ_H__ */
