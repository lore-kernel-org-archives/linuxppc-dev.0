Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DC32FDDE0C
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 02:09:01 +1000 (EST)
Received: from vaxon.spb.rtsoft.ru (localhost.localdomain [127.0.0.1])
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1) with ESMTP id l8IG7sbF022718
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 20:07:54 +0400
Received: (from vaxon@localhost)
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1/Submit) id l8IG7s85022715
	for linuxppc-dev@ozlabs.org; Tue, 18 Sep 2007 20:07:54 +0400
Date: Tue, 18 Sep 2007 20:07:54 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC] [PATCH] PowerPC: Add 64-bit phys addr support to 32-bit pci.
Message-ID: <20070918160754.GA22698@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DF9456FB-459D-4800-B994-D9B198096069@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently pci_32 doesn't support 64-bit physical addresses, while
PowerPC440 platform has PCI space typically mapped above 4GB range.
The patch adds 64-bit physical address support to 32-bit PCI code
in order to bring-up PCI on 44x platform.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/kernel/iomap.c  |    4 +--
 arch/powerpc/kernel/pci_32.c |   56 +++++++++++++++++++++++++++++--------------
 2 files changed, 41 insertions(+), 19 deletions(-)

diff -ruN linux-2.6.orig/arch/powerpc/kernel/iomap.c linux-2.6/arch/powerpc/kernel/iomap.c
--- linux-2.6.orig/arch/powerpc/kernel/iomap.c	2007-09-18 15:32:19.000000000 +0400
+++ linux-2.6/arch/powerpc/kernel/iomap.c	2007-09-18 17:26:35.000000000 +0400
@@ -119,8 +119,8 @@
 
 void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max)
 {
-	unsigned long start = pci_resource_start(dev, bar);
-	unsigned long len = pci_resource_len(dev, bar);
+	resource_size_t start = pci_resource_start(dev, bar);
+	resource_size_t len = pci_resource_len(dev, bar);
 	unsigned long flags = pci_resource_flags(dev, bar);
 
 	if (!len)
diff -ruN linux-2.6.orig/arch/powerpc/kernel/pci_32.c linux-2.6/arch/powerpc/kernel/pci_32.c
--- linux-2.6.orig/arch/powerpc/kernel/pci_32.c	2007-09-18 15:32:19.000000000 +0400
+++ linux-2.6/arch/powerpc/kernel/pci_32.c	2007-09-18 18:17:00.000000000 +0400
@@ -105,7 +105,7 @@
 {
 	struct pci_controller* hose = (struct pci_controller *)dev->sysdata;
 	int i;
-	unsigned long offset;
+	resource_size_t offset;
 
 	if (!hose) {
 		printk(KERN_ERR "No hose for PCI dev %s!\n", pci_name(dev));
@@ -115,7 +115,7 @@
 		struct resource *res = dev->resource + i;
 		if (!res->flags)
 			continue;
-		if (res->end == 0xffffffff) {
+		if (res->end == (resource_size_t) -1) {
 			DBG("PCI:%s Resource %d [%016llx-%016llx] is unassigned\n",
 			    pci_name(dev), i, (u64)res->start, (u64)res->end);
 			res->end -= res->start;
@@ -148,7 +148,7 @@
 void pcibios_resource_to_bus(struct pci_dev *dev, struct pci_bus_region *region,
 			struct resource *res)
 {
-	unsigned long offset = 0;
+	resource_size_t offset = 0;
 	struct pci_controller *hose = dev->sysdata;
 
 	if (hose && res->flags & IORESOURCE_IO)
@@ -163,7 +163,7 @@
 void pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
 			     struct pci_bus_region *region)
 {
-	unsigned long offset = 0;
+	resource_size_t offset = 0;
 	struct pci_controller *hose = dev->sysdata;
 
 	if (hose && res->flags & IORESOURCE_IO)
@@ -439,7 +439,7 @@
 	u8 io_base_lo, io_limit_lo;
 	u16 mem_base, mem_limit;
 	u16 cmd;
-	unsigned long start, end, off;
+	resource_size_t start, end, off;
 	struct pci_controller *hose = dev->sysdata;
 
 	if (!hose) {
@@ -843,16 +843,28 @@
 }
 EXPORT_SYMBOL(pci_device_from_OF_node);
 
+
+static inline u64 pci_get_range64(u32 *r)
+{
+	return (((u64)r[0] << 32) | r[1]);
+}
+
+
 void __init
 pci_process_bridge_OF_ranges(struct pci_controller *hose,
 			   struct device_node *dev, int primary)
 {
 	static unsigned int static_lc_ranges[256] __initdata;
 	const unsigned int *dt_ranges;
-	unsigned int *lc_ranges, *ranges, *prev, size;
+	unsigned int *lc_ranges, *ranges, *prev;
 	int rlen = 0, orig_rlen;
 	int memno = 0;
 	struct resource *res;
+	u32 prev_pci_space, pci_space;
+	u64 prev_pci_addr, pci_addr;
+	u64 prev_size, size;
+	phys_addr_t cpu_phys_addr;
+	
 	int np, na = of_n_addr_cells(dev);
 	np = na + 5;
 
@@ -879,11 +891,18 @@
 	prev = NULL;
 	while ((rlen -= np * sizeof(unsigned int)) >= 0) {
 		if (prev) {
-			if (prev[0] == ranges[0] && prev[1] == ranges[1] &&
-				(prev[2] + prev[na+4]) == ranges[2] &&
-				(prev[na+2] + prev[na+4]) == ranges[na+2]) {
-				prev[na+4] += ranges[na+4];
+			prev_pci_space = prev[0];
+			prev_pci_addr = pci_get_range64(&prev[1]);
+			prev_size = pci_get_range64(&prev[na+3]);
+			pci_space = ranges[0];
+			pci_addr = pci_get_range64(&ranges[1]);
+			if ((prev_pci_space == pci_space) && 
+			    ((prev_pci_addr + prev_size) == pci_addr)) {
+				size = pci_get_range64(&ranges[na+3]);
+				prev_size += size;
 				ranges[0] = 0;
+				prev[na+3] = (u32)((prev_size >> 32) & 0xffffffff);
+				prev[na+4] = (u32)(prev_size & 0xffffffff);
 				ranges += np;
 				continue;
 			}
@@ -904,21 +923,22 @@
 	rlen = orig_rlen;
 	while (ranges && (rlen -= np * sizeof(unsigned int)) >= 0) {
 		res = NULL;
-		size = ranges[na+4];
-		switch ((ranges[0] >> 24) & 0x3) {
+		size = pci_get_range64(&ranges[na+3]);
+		pci_space = ranges[0] >> 24;
+		switch (pci_space & 0x3) {
 		case 1:		/* I/O space */
 			if (ranges[2] != 0)
 				break;
-			hose->io_base_phys = ranges[na+2];
+			hose->io_base_phys = of_translate_address(dev, &ranges[3]);
 			/* limit I/O space to 16MB */
 			if (size > 0x01000000)
 				size = 0x01000000;
-			hose->io_base_virt = ioremap(ranges[na+2], size);
+			hose->io_base_virt = ioremap(hose->io_base_phys, size);
 			if (primary)
 				isa_io_base = (unsigned long) hose->io_base_virt;
 			res = &hose->io_resource;
 			res->flags = IORESOURCE_IO;
-			res->start = ranges[2];
+			res->start = pci_get_range64(&ranges[1]);
 			DBG("PCI: IO 0x%llx -> 0x%llx\n",
 			    (u64)res->start, (u64)res->start + size - 1);
 			break;
@@ -933,14 +953,16 @@
 			}
 			while (memno < 3 && hose->mem_resources[memno].flags)
 				++memno;
+			pci_addr = pci_get_range64(&ranges[1]);
+			cpu_phys_addr = of_translate_address(dev, &ranges[3]);
 			if (memno == 0)
-				hose->pci_mem_offset = ranges[na+2] - ranges[2];
+				hose->pci_mem_offset = (u64)cpu_phys_addr - pci_addr;
 			if (memno < 3) {
 				res = &hose->mem_resources[memno];
 				res->flags = IORESOURCE_MEM;
 				if(ranges[0] & 0x40000000)
 					res->flags |= IORESOURCE_PREFETCH;
-				res->start = ranges[na+2];
+				res->start = cpu_phys_addr;
 				DBG("PCI: MEM[%d] 0x%llx -> 0x%llx\n", memno,
 				    (u64)res->start, (u64)res->start + size - 1);
 			}
