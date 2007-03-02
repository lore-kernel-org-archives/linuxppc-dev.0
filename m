Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 654B9DDF16
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Mar 2007 18:59:42 +1100 (EST)
Date: Fri, 02 Mar 2007 16:59:25 +0900 (JST)
Message-Id: <200703020759.l227xYIY002693@toshiba.co.jp>
Subject: [PATCH] celleb: bug fix caused by not casting pointer types
To: paulus@samba.org
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes a bug caused by changes of pointer type in
commit f1fda89522c5aaa1bd4ef69605e85e6ee9c85faf.

hose->cfg_addr type is "volatile unsigned int __iomem *", so
"hose->cfg_addr + X" will not make an intended address.

This patch also adds comments for usage of cfg_addr and cfg_data in
pci_controller structure. We use them in irregular way, and the
original code is short of explanations about them.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/platforms/celleb/scc_epci.c
diff -u linux-powerpc-git/arch/powerpc/platforms/celleb/scc_epci.c:1.1.1.2 linux-powerpc-git/arch/powerpc/platforms/celleb/scc_epci.c:1.20
--- linux-powerpc-git/arch/powerpc/platforms/celleb/scc_epci.c:1.1.1.2	Wed Feb 14 10:52:11 2007
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/scc_epci.c	Wed Feb 21 14:06:25 2007
@@ -43,11 +43,34 @@
 
 #define iob()  __asm__ __volatile__("eieio; sync":::"memory")
 
+static inline volatile void __iomem *celleb_epci_get_epci_base(
+					struct pci_controller *hose)
+{
+	/*
+	 * Note:
+	 * Celleb epci uses cfg_addr as a base address for
+	 * epci control registers.
+	 */
+
+	return hose->cfg_addr;
+}
+
+static inline volatile void __iomem *celleb_epci_get_epci_cfg(
+					struct pci_controller *hose)
+{
+	/*
+	 * Note:
+	 * Celleb epci uses cfg_data as a base address for
+	 * configuration area for epci devices.
+	 */
+
+	return hose->cfg_data;
+}
 
 #if 0 /* test code for epci dummy read */
 static void celleb_epci_dummy_read(struct pci_dev *dev)
 {
-	void __iomem *epci_base;
+	volatile void __iomem *epci_base;
 	struct device_node *node;
 	struct pci_controller *hose;
 	u32 val;
@@ -58,7 +81,7 @@
 	if (!hose)
 		return;
 
-	epci_base = hose->cfg_addr;
+	epci_base = celleb_epci_get_epci_base(hose);
 
 	val = in_be32(epci_base + SCC_EPCI_WATRP);
 	iosync();
@@ -70,19 +93,20 @@
 static inline void clear_and_disable_master_abort_interrupt(
 					struct pci_controller *hose)
 {
-	void __iomem *addr;
-	addr = hose->cfg_addr + PCI_COMMAND;
-	out_be32(addr, in_be32(addr) | (PCI_STATUS_REC_MASTER_ABORT << 16));
+	volatile void __iomem *epci_base, *reg;
+	epci_base = celleb_epci_get_epci_base(hose);
+	reg = epci_base + PCI_COMMAND;
+	out_be32(reg, in_be32(reg) | (PCI_STATUS_REC_MASTER_ABORT << 16));
 }
 
 static int celleb_epci_check_abort(struct pci_controller *hose,
-				   void __iomem *addr)
+				   volatile void __iomem *addr)
 {
-	void __iomem *reg, *epci_base;
+	volatile void __iomem *reg, *epci_base;
 	u32 val;
 
 	iob();
-	epci_base = hose->cfg_addr;
+	epci_base = celleb_epci_get_epci_base(hose);
 
 	reg = epci_base + PCI_COMMAND;
 	val = in_be32(reg);
@@ -108,20 +132,21 @@
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static void __iomem *celleb_epci_make_config_addr(struct pci_controller *hose,
+static volatile void __iomem *celleb_epci_make_config_addr(
+					struct pci_controller *hose,
 					unsigned int devfn, int where)
 {
-	void __iomem *addr;
+	volatile void __iomem *addr;
 	struct pci_bus *bus = hose->bus;
 
 	if (bus->self)
-		addr = hose->cfg_data +
+		addr = celleb_epci_get_epci_cfg(hose) +
 		       (((bus->number & 0xff) << 16)
 		        | ((devfn & 0xff) << 8)
 		        | (where & 0xff)
 		        | 0x01000000);
 	else
-		addr = hose->cfg_data +
+		addr = celleb_epci_get_epci_cfg(hose) +
 		       (((devfn & 0xff) << 8) | (where & 0xff));
 
 	pr_debug("EPCI: config_addr = 0x%p\n", addr);
@@ -132,7 +157,7 @@
 static int celleb_epci_read_config(struct pci_bus *bus,
 			unsigned int devfn, int where, int size, u32 * val)
 {
-	void __iomem *addr;
+	volatile void __iomem *epci_base, *addr;
 	struct device_node *node;
 	struct pci_controller *hose;
 
@@ -142,13 +167,14 @@
 	node = (struct device_node *)bus->sysdata;
 	hose = pci_find_hose_for_OF_device(node);
 
-	if (!hose->cfg_data)
+	if (!celleb_epci_get_epci_cfg(hose))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	if (bus->number == hose->first_busno && devfn == 0) {
 		/* EPCI controller self */
 
-		addr = hose->cfg_addr + where;
+		epci_base = celleb_epci_get_epci_base(hose);
+		addr = epci_base + where;
 
 		switch (size) {
 		case 1:
@@ -185,7 +211,7 @@
 	}
 
 	pr_debug("EPCI: "
-		 "addr=0x%lx, devfn=0x%x, where=0x%x, size=0x%x, val=0x%x\n",
+		 "addr=0x%p, devfn=0x%x, where=0x%x, size=0x%x, val=0x%x\n",
 		 addr, devfn, where, size, *val);
 
 	return celleb_epci_check_abort(hose, NULL);
@@ -194,7 +220,7 @@
 static int celleb_epci_write_config(struct pci_bus *bus,
 			unsigned int devfn, int where, int size, u32 val)
 {
-	void __iomem *addr;
+	volatile void __iomem *epci_base, *addr;
 	struct device_node *node;
 	struct pci_controller *hose;
 
@@ -204,13 +230,15 @@
 	node = (struct device_node *)bus->sysdata;
 	hose = pci_find_hose_for_OF_device(node);
 
-	if (!hose->cfg_data)
+
+	if (!celleb_epci_get_epci_cfg(hose))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	if (bus->number == hose->first_busno && devfn == 0) {
 		/* EPCI controller self */
 
-		addr = hose->cfg_addr + where;
+		epci_base = celleb_epci_get_epci_base(hose);
+		addr = epci_base + where;
 
 		switch (size) {
 		case 1:
@@ -258,10 +286,10 @@
 static int __devinit celleb_epci_init(struct pci_controller *hose)
 {
 	u32 val;
-	void __iomem *reg, *epci_base;
+	volatile void __iomem *reg, *epci_base;
 	int hwres = 0;
 
-	epci_base = hose->cfg_addr;
+	epci_base = celleb_epci_get_epci_base(hose);
 
 	/* PCI core reset(Internal bus and PCI clock) */
 	reg = epci_base + SCC_EPCI_CKCTRL;
@@ -382,6 +410,18 @@
 
 	pr_debug("PCI: celleb_setup_epci()\n");
 
+	/*
+	 * Note:
+	 * Celleb epci uses cfg_addr and cfg_data member of  
+	 * pci_controller structure in irregular way.
+	 *
+	 * cfg_addr is used to map for control registers of 
+	 * celleb epci.
+	 *
+	 * cfg_data is used for configuration area of devices
+	 * on Celleb epci buses.
+	 */
+
 	if (of_address_to_resource(node, 0, &r))
 		goto error;
 	hose->cfg_addr = ioremap(r.start, (r.end - r.start + 1));
