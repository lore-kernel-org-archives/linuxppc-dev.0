Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 81B63679F2
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 17:07:57 +1000 (EST)
Date: Fri, 19 May 2006 16:42:49 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 01/14] powerpc: tidy up iseries/pci.c
Message-Id: <20060519164249.2dc43bc4.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove some unused counters.

No need to allocate iomm_table and iobar_table, which means that
iomm_table_initialize is not longer needed.

Use kzalloc where sensible.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/platforms/iseries/pci.c |   78 +++++-----------------------------
 1 files changed, 11 insertions(+), 67 deletions(-)

This series of patches are intenede to put the iSeries PCI devices into
the flattened device tree.  Built and run on an iSeries 270 with a single
PCI ethernet.  Built for pSeries_defconfig.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

039fac4f522c6207625993cd79bb2164dc0b91f1
diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index 428ffb5..91a9474 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -57,15 +57,6 @@ LIST_HEAD(iSeries_Global_Device_List);
 
 static int DeviceCount;
 
-/* Counters and control flags. */
-static long Pci_Io_Read_Count;
-static long Pci_Io_Write_Count;
-#if 0
-static long Pci_Cfg_Read_Count;
-static long Pci_Cfg_Write_Count;
-#endif
-static long Pci_Error_Count;
-
 static int Pci_Retry_Max = 3;	/* Only retry 3 times  */
 static int Pci_Error_Flag = 1;	/* Set Retry Error on. */
 
@@ -79,41 +70,19 @@ #define IOMM_TABLE_MAX_ENTRIES	1024
 #define IOMM_TABLE_ENTRY_SIZE	0x0000000000400000UL
 #define BASE_IO_MEMORY		0xE000000000000000UL
 
-static unsigned long max_io_memory = 0xE000000000000000UL;
+static unsigned long max_io_memory = BASE_IO_MEMORY;
 static long current_iomm_table_entry;
 
 /*
  * Lookup Tables.
  */
-static struct device_node **iomm_table;
-static u8 *iobar_table;
+static struct device_node *iomm_table[IOMM_TABLE_MAX_ENTRIES];
+static u8 iobar_table[IOMM_TABLE_MAX_ENTRIES];
 
-/*
- * Static and Global variables
- */
-static char *pci_io_text = "iSeries PCI I/O";
+static const char pci_io_text[] = "iSeries PCI I/O";
 static DEFINE_SPINLOCK(iomm_table_lock);
 
 /*
- * iomm_table_initialize
- *
- * Allocates and initalizes the Address Translation Table and Bar
- * Tables to get them ready for use.  Must be called before any
- * I/O space is handed out to the device BARs.
- */
-static void iomm_table_initialize(void)
-{
-	spin_lock(&iomm_table_lock);
-	iomm_table = kmalloc(sizeof(*iomm_table) * IOMM_TABLE_MAX_ENTRIES,
-			GFP_KERNEL);
-	iobar_table = kmalloc(sizeof(*iobar_table) * IOMM_TABLE_MAX_ENTRIES,
-			GFP_KERNEL);
-	spin_unlock(&iomm_table_lock);
-	if ((iomm_table == NULL) || (iobar_table == NULL))
-		panic("PCI: I/O tables allocation failed.\n");
-}
-
-/*
  * iomm_table_allocate_entry
  *
  * Adds pci_dev entry in address translation table
@@ -140,9 +109,8 @@ static void iomm_table_allocate_entry(st
 	 */
 	spin_lock(&iomm_table_lock);
 	bar_res->name = pci_io_text;
-	bar_res->start =
+	bar_res->start = BASE_IO_MEMORY +
 		IOMM_TABLE_ENTRY_SIZE * current_iomm_table_entry;
-	bar_res->start += BASE_IO_MEMORY;
 	bar_res->end = bar_res->start + bar_size - 1;
 	/*
 	 * Allocate the number of table entries needed for BAR.
@@ -154,7 +122,7 @@ static void iomm_table_allocate_entry(st
 		++current_iomm_table_entry;
 	}
 	max_io_memory = BASE_IO_MEMORY +
-		(IOMM_TABLE_ENTRY_SIZE * current_iomm_table_entry);
+		IOMM_TABLE_ENTRY_SIZE * current_iomm_table_entry;
 	spin_unlock(&iomm_table_lock);
 }
 
@@ -171,13 +139,10 @@ static void iomm_table_allocate_entry(st
  */
 static void allocate_device_bars(struct pci_dev *dev)
 {
-	struct resource *bar_res;
 	int bar_num;
 
-	for (bar_num = 0; bar_num <= PCI_ROM_RESOURCE; ++bar_num) {
-		bar_res = &dev->resource[bar_num];
+	for (bar_num = 0; bar_num <= PCI_ROM_RESOURCE; ++bar_num)
 		iomm_table_allocate_entry(dev, bar_num);
-	}
 }
 
 /*
@@ -205,10 +170,9 @@ static struct device_node *build_device_
 	struct device_node *node;
 	struct pci_dn *pdn;
 
-	node = kmalloc(sizeof(struct device_node), GFP_KERNEL);
+	node = kzalloc(sizeof(struct device_node), GFP_KERNEL);
 	if (node == NULL)
 		return NULL;
-	memset(node, 0, sizeof(struct device_node));
 	pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
 	if (pdn == NULL) {
 		kfree(node);
@@ -224,7 +188,7 @@ static struct device_node *build_device_
 }
 
 /*
- * unsigned long __init find_and_init_phbs(void)
+ * iSeries_pcibios_init
  *
  * Description:
  *   This function checks for all possible system PCI host bridges that connect
@@ -232,7 +196,7 @@ static struct device_node *build_device_
  *   ownership status.  A pci_controller is built for any bus which is partially
  *   owned or fully owned by this guest partition.
  */
-unsigned long __init find_and_init_phbs(void)
+void iSeries_pcibios_init(void)
 {
 	struct pci_controller *phb;
 	HvBusNumber bus;
@@ -263,18 +227,6 @@ unsigned long __init find_and_init_phbs(
 			printk(KERN_ERR "Unexpected Return on Probe(0x%04X): 0x%04X",
 			       bus, ret);
 	}
-	return 0;
-}
-
-/*
- * iSeries_pcibios_init
- *
- * Chance to initialize and structures or variable before PCI Bus walk.
- */
-void iSeries_pcibios_init(void)
-{
-	iomm_table_initialize();
-	find_and_init_phbs();
 }
 
 /*
@@ -331,8 +283,7 @@ static void scan_PHB_slots(struct pci_co
 	int IdSel;
 	const int MaxAgents = 8;
 
-	DevInfo = (struct HvCallPci_DeviceInfo*)
-		kmalloc(sizeof(struct HvCallPci_DeviceInfo), GFP_KERNEL);
+	DevInfo = kmalloc(sizeof(struct HvCallPci_DeviceInfo), GFP_KERNEL);
 	if (DevInfo == NULL)
 		return;
 
@@ -622,7 +573,6 @@ static int CheckReturnCode(char *TextHdr
 	if (ret != 0)  {
 		struct pci_dn *pdn = PCI_DN(DevNode);
 
-		++Pci_Error_Count;
 		(*retry)++;
 		printk("PCI: %s: Device 0x%04X:%02X  I/O Error(%2d): 0x%04X\n",
 				TextHdr, pdn->busno, pdn->devfn,
@@ -704,7 +654,6 @@ u8 iSeries_Read_Byte(const volatile void
 		return 0xff;
 	}
 	do {
-		++Pci_Io_Read_Count;
 		HvCall3Ret16(HvCallPciBarLoad8, &ret, dsa, BarOffset, 0);
 	} while (CheckReturnCode("RDB", DevNode, &retry, ret.rc) != 0);
 
@@ -734,7 +683,6 @@ u16 iSeries_Read_Word(const volatile voi
 		return 0xffff;
 	}
 	do {
-		++Pci_Io_Read_Count;
 		HvCall3Ret16(HvCallPciBarLoad16, &ret, dsa,
 				BarOffset, 0);
 	} while (CheckReturnCode("RDW", DevNode, &retry, ret.rc) != 0);
@@ -765,7 +713,6 @@ u32 iSeries_Read_Long(const volatile voi
 		return 0xffffffff;
 	}
 	do {
-		++Pci_Io_Read_Count;
 		HvCall3Ret16(HvCallPciBarLoad32, &ret, dsa,
 				BarOffset, 0);
 	} while (CheckReturnCode("RDL", DevNode, &retry, ret.rc) != 0);
@@ -803,7 +750,6 @@ void iSeries_Write_Byte(u8 data, volatil
 		return;
 	}
 	do {
-		++Pci_Io_Write_Count;
 		rc = HvCall4(HvCallPciBarStore8, dsa, BarOffset, data, 0);
 	} while (CheckReturnCode("WWB", DevNode, &retry, rc) != 0);
 }
@@ -831,7 +777,6 @@ void iSeries_Write_Word(u16 data, volati
 		return;
 	}
 	do {
-		++Pci_Io_Write_Count;
 		rc = HvCall4(HvCallPciBarStore16, dsa, BarOffset, swab16(data), 0);
 	} while (CheckReturnCode("WWW", DevNode, &retry, rc) != 0);
 }
@@ -859,7 +804,6 @@ void iSeries_Write_Long(u32 data, volati
 		return;
 	}
 	do {
-		++Pci_Io_Write_Count;
 		rc = HvCall4(HvCallPciBarStore32, dsa, BarOffset, swab32(data), 0);
 	} while (CheckReturnCode("WWL", DevNode, &retry, rc) != 0);
 }
-- 
1.3.1.ge923
