Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id AA2E5DE1EE
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:07:55 +1100 (EST)
Received: from ash.ozlabs.ibm.com (ta-1-1.tip.net.au [203.11.71.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 0CB4D368002
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:07:55 +1100 (EST)
Date: Fri, 7 Dec 2007 01:49:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 05/19] [POWERPC] iSeries: deCamelCase pci.c
Message-Id: <20071207014927.c8bc9ff7.sfr@canb.auug.org.au>
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
 arch/powerpc/platforms/iseries/pci.c |  216 +++++++++++++++++-----------------
 1 files changed, 108 insertions(+), 108 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index 8ef3226..705f52c 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -138,19 +138,19 @@ static void __init allocate_device_bars(struct pci_dev *dev)
  * PCI: Read Vendor Failed 0x18.58.10 Rc: 0x00xx
  * PCI: Connect Bus Unit Failed 0x18.58.10 Rc: 0x00xx
  */
-static void pci_Log_Error(char *Error_Text, int Bus, int SubBus,
-		int AgentId, int HvRc)
+static void pci_log_error(char *error, int bus, int subbus,
+		int agent, int hv_res)
 {
-	if (HvRc == 0x0302)
+	if (hv_res == 0x0302)
 		return;
 	printk(KERN_ERR "PCI: %s Failed: 0x%02X.%02X.%02X Rc: 0x%04X",
-	       Error_Text, Bus, SubBus, AgentId, HvRc);
+	       error, bus, subbus, agent, hv_res);
 }
 
 /*
  * Look down the chain to find the matching Device Device
  */
-static struct device_node *find_Device_Node(int bus, int devfn)
+static struct device_node *find_device_node(int bus, int devfn)
 {
 	struct device_node *node;
 
@@ -170,14 +170,14 @@ void __init iSeries_pci_final_fixup(void)
 {
 	struct pci_dev *pdev = NULL;
 	struct device_node *node;
-	int DeviceCount = 0;
+	int num_dev = 0;
 
 	/* Fix up at the device node and pci_dev relationship */
 	mf_display_src(0xC9000100);
 
 	printk("pcibios_final_fixup\n");
 	for_each_pci_dev(pdev) {
-		node = find_Device_Node(pdev->bus->number, pdev->devfn);
+		node = find_device_node(pdev->bus->number, pdev->devfn);
 		printk("pci dev %p (%x.%x), node %p\n", pdev,
 		       pdev->bus->number, pdev->devfn, node);
 
@@ -194,7 +194,7 @@ void __init iSeries_pci_final_fixup(void)
 				err = HvCallXm_connectBusUnit(pdn->busno, pdn->bussubno,
 						*agent, irq);
 				if (err)
-					pci_Log_Error("Connect Bus Unit",
+					pci_log_error("Connect Bus Unit",
 						pdn->busno, pdn->bussubno, *agent, err);
 				else {
 					err = HvCallPci_configStore8(pdn->busno, pdn->bussubno,
@@ -202,18 +202,18 @@ void __init iSeries_pci_final_fixup(void)
 							PCI_INTERRUPT_LINE,
 							irq);
 					if (err)
-						pci_Log_Error("PciCfgStore Irq Failed!",
+						pci_log_error("PciCfgStore Irq Failed!",
 							pdn->busno, pdn->bussubno, *agent, err);
 				}
 				if (!err)
 					pdev->irq = irq;
 			}
 
-			++DeviceCount;
+			++num_dev;
 			pdev->sysdata = (void *)node;
 			PCI_DN(node)->pcidev = pdev;
 			allocate_device_bars(pdev);
-			iSeries_Device_Information(pdev, DeviceCount);
+			iSeries_Device_Information(pdev, num_dev);
 			iommu_devnode_init_iSeries(pdev, node);
 		} else
 			printk("PCI: Device Tree not found for 0x%016lX\n",
@@ -229,13 +229,13 @@ void __init iSeries_pci_final_fixup(void)
  * Sanity Check Node PciDev to passed pci_dev
  * If none is found, returns a NULL which the client must handle.
  */
-static struct device_node *get_Device_Node(struct pci_dev *pdev)
+static struct device_node *get_device_node(struct pci_dev *pdev)
 {
 	struct device_node *node;
 
 	node = pdev->sysdata;
 	if (node == NULL || PCI_DN(node)->pcidev != pdev)
-		node = find_Device_Node(pdev->bus->number, pdev->devfn);
+		node = find_device_node(pdev->bus->number, pdev->devfn);
 	return node;
 }
 #endif
@@ -262,7 +262,7 @@ static u64 hv_cfg_write_func[4] = {
 static int iSeries_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 		int offset, int size, u32 *val)
 {
-	struct device_node *node = find_Device_Node(bus->number, devfn);
+	struct device_node *node = find_device_node(bus->number, devfn);
 	u64 fn;
 	struct HvCallPci_LoadReturn ret;
 
@@ -292,7 +292,7 @@ static int iSeries_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 static int iSeries_pci_write_config(struct pci_bus *bus, unsigned int devfn,
 		int offset, int size, u32 val)
 {
-	struct device_node *node = find_Device_Node(bus->number, devfn);
+	struct device_node *node = find_device_node(bus->number, devfn);
 	u64 fn;
 	u64 ret;
 
@@ -324,15 +324,15 @@ static struct pci_ops iSeries_pci_ops = {
  * PCI: Device 23.90 ReadL Retry( 1)
  * PCI: Device 23.90 ReadL Retry Successful(1)
  */
-static int CheckReturnCode(char *TextHdr, struct device_node *DevNode,
+static int check_return_code(char *type, struct device_node *dn,
 		int *retry, u64 ret)
 {
 	if (ret != 0)  {
-		struct pci_dn *pdn = PCI_DN(DevNode);
+		struct pci_dn *pdn = PCI_DN(dn);
 
 		(*retry)++;
 		printk("PCI: %s: Device 0x%04X:%02X  I/O Error(%2d): 0x%04X\n",
-				TextHdr, pdn->busno, pdn->devfn,
+				type, pdn->busno, pdn->devfn,
 				*retry, (int)ret);
 		/*
 		 * Bump the retry and check for retry count exceeded.
@@ -356,28 +356,28 @@ static int CheckReturnCode(char *TextHdr, struct device_node *DevNode,
  * the exposure of being device global.
  */
 static inline struct device_node *xlate_iomm_address(
-		const volatile void __iomem *IoAddress,
-		u64 *dsaptr, u64 *BarOffsetPtr)
+		const volatile void __iomem *addr,
+		u64 *dsaptr, u64 *bar_offset)
 {
-	unsigned long OrigIoAddr;
-	unsigned long BaseIoAddr;
-	unsigned long TableIndex;
-	struct device_node *DevNode;
+	unsigned long orig_addr;
+	unsigned long base_addr;
+	unsigned long ind;
+	struct device_node *dn;
 
-	OrigIoAddr = (unsigned long __force)IoAddress;
-	if ((OrigIoAddr < BASE_IO_MEMORY) || (OrigIoAddr >= max_io_memory))
+	orig_addr = (unsigned long __force)addr;
+	if ((orig_addr < BASE_IO_MEMORY) || (orig_addr >= max_io_memory))
 		return NULL;
-	BaseIoAddr = OrigIoAddr - BASE_IO_MEMORY;
-	TableIndex = BaseIoAddr / IOMM_TABLE_ENTRY_SIZE;
-	DevNode = iomm_table[TableIndex];
-
-	if (DevNode != NULL) {
-		int barnum = iobar_table[TableIndex];
-		*dsaptr = iseries_ds_addr(DevNode) | (barnum << 24);
-		*BarOffsetPtr = BaseIoAddr % IOMM_TABLE_ENTRY_SIZE;
+	base_addr = orig_addr - BASE_IO_MEMORY;
+	ind = base_addr / IOMM_TABLE_ENTRY_SIZE;
+	dn = iomm_table[ind];
+
+	if (dn != NULL) {
+		int barnum = iobar_table[ind];
+		*dsaptr = iseries_ds_addr(dn) | (barnum << 24);
+		*bar_offset = base_addr % IOMM_TABLE_ENTRY_SIZE;
 	} else
-		panic("PCI: Invalid PCI IoAddress detected!\n");
-	return DevNode;
+		panic("PCI: Invalid PCI IO address detected!\n");
+	return dn;
 }
 
 /*
@@ -385,16 +385,16 @@ static inline struct device_node *xlate_iomm_address(
  * On MM I/O error, all ones are returned and iSeries_pci_IoError is cal
  * else, data is returned in Big Endian format.
  */
-static u8 iSeries_Read_Byte(const volatile void __iomem *IoAddress)
+static u8 iSeries_read_byte(const volatile void __iomem *addr)
 {
-	u64 BarOffset;
+	u64 bar_offset;
 	u64 dsa;
 	int retry = 0;
 	struct HvCallPci_LoadReturn ret;
-	struct device_node *DevNode =
-		xlate_iomm_address(IoAddress, &dsa, &BarOffset);
+	struct device_node *dn =
+		xlate_iomm_address(addr, &dsa, &bar_offset);
 
-	if (DevNode == NULL) {
+	if (dn == NULL) {
 		static unsigned long last_jiffies;
 		static int num_printed;
 
@@ -403,27 +403,27 @@ static u8 iSeries_Read_Byte(const volatile void __iomem *IoAddress)
 			num_printed = 0;
 		}
 		if (num_printed++ < 10)
-			printk(KERN_ERR "iSeries_Read_Byte: invalid access at IO address %p\n",
-			       IoAddress);
+			printk(KERN_ERR "iSeries_read_byte: invalid access at IO address %p\n",
+			       addr);
 		return 0xff;
 	}
 	do {
-		HvCall3Ret16(HvCallPciBarLoad8, &ret, dsa, BarOffset, 0);
-	} while (CheckReturnCode("RDB", DevNode, &retry, ret.rc) != 0);
+		HvCall3Ret16(HvCallPciBarLoad8, &ret, dsa, bar_offset, 0);
+	} while (check_return_code("RDB", dn, &retry, ret.rc) != 0);
 
 	return ret.value;
 }
 
-static u16 iSeries_Read_Word(const volatile void __iomem *IoAddress)
+static u16 iSeries_read_word(const volatile void __iomem *addr)
 {
-	u64 BarOffset;
+	u64 bar_offset;
 	u64 dsa;
 	int retry = 0;
 	struct HvCallPci_LoadReturn ret;
-	struct device_node *DevNode =
-		xlate_iomm_address(IoAddress, &dsa, &BarOffset);
+	struct device_node *dn =
+		xlate_iomm_address(addr, &dsa, &bar_offset);
 
-	if (DevNode == NULL) {
+	if (dn == NULL) {
 		static unsigned long last_jiffies;
 		static int num_printed;
 
@@ -432,28 +432,28 @@ static u16 iSeries_Read_Word(const volatile void __iomem *IoAddress)
 			num_printed = 0;
 		}
 		if (num_printed++ < 10)
-			printk(KERN_ERR "iSeries_Read_Word: invalid access at IO address %p\n",
-			       IoAddress);
+			printk(KERN_ERR "iSeries_read_word: invalid access at IO address %p\n",
+			       addr);
 		return 0xffff;
 	}
 	do {
 		HvCall3Ret16(HvCallPciBarLoad16, &ret, dsa,
-				BarOffset, 0);
-	} while (CheckReturnCode("RDW", DevNode, &retry, ret.rc) != 0);
+				bar_offset, 0);
+	} while (check_return_code("RDW", dn, &retry, ret.rc) != 0);
 
 	return ret.value;
 }
 
-static u32 iSeries_Read_Long(const volatile void __iomem *IoAddress)
+static u32 iSeries_read_long(const volatile void __iomem *addr)
 {
-	u64 BarOffset;
+	u64 bar_offset;
 	u64 dsa;
 	int retry = 0;
 	struct HvCallPci_LoadReturn ret;
-	struct device_node *DevNode =
-		xlate_iomm_address(IoAddress, &dsa, &BarOffset);
+	struct device_node *dn =
+		xlate_iomm_address(addr, &dsa, &bar_offset);
 
-	if (DevNode == NULL) {
+	if (dn == NULL) {
 		static unsigned long last_jiffies;
 		static int num_printed;
 
@@ -462,14 +462,14 @@ static u32 iSeries_Read_Long(const volatile void __iomem *IoAddress)
 			num_printed = 0;
 		}
 		if (num_printed++ < 10)
-			printk(KERN_ERR "iSeries_Read_Long: invalid access at IO address %p\n",
-			       IoAddress);
+			printk(KERN_ERR "iSeries_read_long: invalid access at IO address %p\n",
+			       addr);
 		return 0xffffffff;
 	}
 	do {
 		HvCall3Ret16(HvCallPciBarLoad32, &ret, dsa,
-				BarOffset, 0);
-	} while (CheckReturnCode("RDL", DevNode, &retry, ret.rc) != 0);
+				bar_offset, 0);
+	} while (check_return_code("RDL", dn, &retry, ret.rc) != 0);
 
 	return ret.value;
 }
@@ -478,16 +478,16 @@ static u32 iSeries_Read_Long(const volatile void __iomem *IoAddress)
  * Write MM I/O Instructions for the iSeries
  *
  */
-static void iSeries_Write_Byte(u8 data, volatile void __iomem *IoAddress)
+static void iSeries_write_byte(u8 data, volatile void __iomem *addr)
 {
-	u64 BarOffset;
+	u64 bar_offset;
 	u64 dsa;
 	int retry = 0;
 	u64 rc;
-	struct device_node *DevNode =
-		xlate_iomm_address(IoAddress, &dsa, &BarOffset);
+	struct device_node *dn =
+		xlate_iomm_address(addr, &dsa, &bar_offset);
 
-	if (DevNode == NULL) {
+	if (dn == NULL) {
 		static unsigned long last_jiffies;
 		static int num_printed;
 
@@ -496,24 +496,24 @@ static void iSeries_Write_Byte(u8 data, volatile void __iomem *IoAddress)
 			num_printed = 0;
 		}
 		if (num_printed++ < 10)
-			printk(KERN_ERR "iSeries_Write_Byte: invalid access at IO address %p\n", IoAddress);
+			printk(KERN_ERR "iSeries_write_byte: invalid access at IO address %p\n", addr);
 		return;
 	}
 	do {
-		rc = HvCall4(HvCallPciBarStore8, dsa, BarOffset, data, 0);
-	} while (CheckReturnCode("WWB", DevNode, &retry, rc) != 0);
+		rc = HvCall4(HvCallPciBarStore8, dsa, bar_offset, data, 0);
+	} while (check_return_code("WWB", dn, &retry, rc) != 0);
 }
 
-static void iSeries_Write_Word(u16 data, volatile void __iomem *IoAddress)
+static void iSeries_write_word(u16 data, volatile void __iomem *addr)
 {
-	u64 BarOffset;
+	u64 bar_offset;
 	u64 dsa;
 	int retry = 0;
 	u64 rc;
-	struct device_node *DevNode =
-		xlate_iomm_address(IoAddress, &dsa, &BarOffset);
+	struct device_node *dn =
+		xlate_iomm_address(addr, &dsa, &bar_offset);
 
-	if (DevNode == NULL) {
+	if (dn == NULL) {
 		static unsigned long last_jiffies;
 		static int num_printed;
 
@@ -522,25 +522,25 @@ static void iSeries_Write_Word(u16 data, volatile void __iomem *IoAddress)
 			num_printed = 0;
 		}
 		if (num_printed++ < 10)
-			printk(KERN_ERR "iSeries_Write_Word: invalid access at IO address %p\n",
-			       IoAddress);
+			printk(KERN_ERR "iSeries_write_word: invalid access at IO address %p\n",
+			       addr);
 		return;
 	}
 	do {
-		rc = HvCall4(HvCallPciBarStore16, dsa, BarOffset, data, 0);
-	} while (CheckReturnCode("WWW", DevNode, &retry, rc) != 0);
+		rc = HvCall4(HvCallPciBarStore16, dsa, bar_offset, data, 0);
+	} while (check_return_code("WWW", dn, &retry, rc) != 0);
 }
 
-static void iSeries_Write_Long(u32 data, volatile void __iomem *IoAddress)
+static void iSeries_write_long(u32 data, volatile void __iomem *addr)
 {
-	u64 BarOffset;
+	u64 bar_offset;
 	u64 dsa;
 	int retry = 0;
 	u64 rc;
-	struct device_node *DevNode =
-		xlate_iomm_address(IoAddress, &dsa, &BarOffset);
+	struct device_node *dn =
+		xlate_iomm_address(addr, &dsa, &bar_offset);
 
-	if (DevNode == NULL) {
+	if (dn == NULL) {
 		static unsigned long last_jiffies;
 		static int num_printed;
 
@@ -549,63 +549,63 @@ static void iSeries_Write_Long(u32 data, volatile void __iomem *IoAddress)
 			num_printed = 0;
 		}
 		if (num_printed++ < 10)
-			printk(KERN_ERR "iSeries_Write_Long: invalid access at IO address %p\n",
-			       IoAddress);
+			printk(KERN_ERR "iSeries_write_long: invalid access at IO address %p\n",
+			       addr);
 		return;
 	}
 	do {
-		rc = HvCall4(HvCallPciBarStore32, dsa, BarOffset, data, 0);
-	} while (CheckReturnCode("WWL", DevNode, &retry, rc) != 0);
+		rc = HvCall4(HvCallPciBarStore32, dsa, bar_offset, data, 0);
+	} while (check_return_code("WWL", dn, &retry, rc) != 0);
 }
 
 static u8 iseries_readb(const volatile void __iomem *addr)
 {
-	return iSeries_Read_Byte(addr);
+	return iSeries_read_byte(addr);
 }
 
 static u16 iseries_readw(const volatile void __iomem *addr)
 {
-	return le16_to_cpu(iSeries_Read_Word(addr));
+	return le16_to_cpu(iSeries_read_word(addr));
 }
 
 static u32 iseries_readl(const volatile void __iomem *addr)
 {
-	return le32_to_cpu(iSeries_Read_Long(addr));
+	return le32_to_cpu(iSeries_read_long(addr));
 }
 
 static u16 iseries_readw_be(const volatile void __iomem *addr)
 {
-	return iSeries_Read_Word(addr);
+	return iSeries_read_word(addr);
 }
 
 static u32 iseries_readl_be(const volatile void __iomem *addr)
 {
-	return iSeries_Read_Long(addr);
+	return iSeries_read_long(addr);
 }
 
 static void iseries_writeb(u8 data, volatile void __iomem *addr)
 {
-	iSeries_Write_Byte(data, addr);
+	iSeries_write_byte(data, addr);
 }
 
 static void iseries_writew(u16 data, volatile void __iomem *addr)
 {
-	iSeries_Write_Word(cpu_to_le16(data), addr);
+	iSeries_write_word(cpu_to_le16(data), addr);
 }
 
 static void iseries_writel(u32 data, volatile void __iomem *addr)
 {
-	iSeries_Write_Long(cpu_to_le32(data), addr);
+	iSeries_write_long(cpu_to_le32(data), addr);
 }
 
 static void iseries_writew_be(u16 data, volatile void __iomem *addr)
 {
-	iSeries_Write_Word(data, addr);
+	iSeries_write_word(data, addr);
 }
 
 static void iseries_writel_be(u32 data, volatile void __iomem *addr)
 {
-	iSeries_Write_Long(data, addr);
+	iSeries_write_long(data, addr);
 }
 
 static void iseries_readsb(const volatile void __iomem *addr, void *buf,
@@ -613,7 +613,7 @@ static void iseries_readsb(const volatile void __iomem *addr, void *buf,
 {
 	u8 *dst = buf;
 	while(count-- > 0)
-		*(dst++) = iSeries_Read_Byte(addr);
+		*(dst++) = iSeries_read_byte(addr);
 }
 
 static void iseries_readsw(const volatile void __iomem *addr, void *buf,
@@ -621,7 +621,7 @@ static void iseries_readsw(const volatile void __iomem *addr, void *buf,
 {
 	u16 *dst = buf;
 	while(count-- > 0)
-		*(dst++) = iSeries_Read_Word(addr);
+		*(dst++) = iSeries_read_word(addr);
 }
 
 static void iseries_readsl(const volatile void __iomem *addr, void *buf,
@@ -629,7 +629,7 @@ static void iseries_readsl(const volatile void __iomem *addr, void *buf,
 {
 	u32 *dst = buf;
 	while(count-- > 0)
-		*(dst++) = iSeries_Read_Long(addr);
+		*(dst++) = iSeries_read_long(addr);
 }
 
 static void iseries_writesb(volatile void __iomem *addr, const void *buf,
@@ -637,7 +637,7 @@ static void iseries_writesb(volatile void __iomem *addr, const void *buf,
 {
 	const u8 *src = buf;
 	while(count-- > 0)
-		iSeries_Write_Byte(*(src++), addr);
+		iSeries_write_byte(*(src++), addr);
 }
 
 static void iseries_writesw(volatile void __iomem *addr, const void *buf,
@@ -645,7 +645,7 @@ static void iseries_writesw(volatile void __iomem *addr, const void *buf,
 {
 	const u16 *src = buf;
 	while(count-- > 0)
-		iSeries_Write_Word(*(src++), addr);
+		iSeries_write_word(*(src++), addr);
 }
 
 static void iseries_writesl(volatile void __iomem *addr, const void *buf,
@@ -653,7 +653,7 @@ static void iseries_writesl(volatile void __iomem *addr, const void *buf,
 {
 	const u32 *src = buf;
 	while(count-- > 0)
-		iSeries_Write_Long(*(src++), addr);
+		iSeries_write_long(*(src++), addr);
 }
 
 static void iseries_memset_io(volatile void __iomem *addr, int c,
@@ -662,7 +662,7 @@ static void iseries_memset_io(volatile void __iomem *addr, int c,
 	volatile char __iomem *d = addr;
 
 	while (n-- > 0)
-		iSeries_Write_Byte(c, d++);
+		iSeries_write_byte(c, d++);
 }
 
 static void iseries_memcpy_fromio(void *dest, const volatile void __iomem *src,
@@ -672,7 +672,7 @@ static void iseries_memcpy_fromio(void *dest, const volatile void __iomem *src,
 	const volatile char __iomem *s = src;
 
 	while (n-- > 0)
-		*d++ = iSeries_Read_Byte(s++);
+		*d++ = iSeries_read_byte(s++);
 }
 
 static void iseries_memcpy_toio(volatile void __iomem *dest, const void *src,
@@ -682,7 +682,7 @@ static void iseries_memcpy_toio(volatile void __iomem *dest, const void *src,
 	volatile char __iomem *d = dest;
 
 	while (n-- > 0)
-		iSeries_Write_Byte(*s++, d++);
+		iSeries_write_byte(*s++, d++);
 }
 
 /* We only set MMIO ops. The default PIO ops will be default
-- 
1.5.3.7


-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
