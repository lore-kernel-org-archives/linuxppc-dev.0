Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 755C5DDDFA
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 15:53:37 +1000 (EST)
Subject: powerpc: Fix OF parsing of 64 bits PCI addresses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Thu, 17 Jul 2008 15:53:31 +1000
Message-Id: <1216274011.7740.293.camel@pasglop>
Mime-Version: 1.0
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The OF parsing code for PCI addresses isn't always treating properly
the address space indication 0b11 (ie. 0x3) as meaning 64 bits
memory space.

This means that it fails to parse addresses for PCI BARs that have
this encoding set by the firmware, which happens on some SLOF
versions and breaks offb palette handling on Powerstation.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Index: linux-work/arch/powerpc/kernel/pci-common.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci-common.c	2008-07-17 15:09:11.000000000 +1000
+++ linux-work/arch/powerpc/kernel/pci-common.c	2008-07-17 15:09:22.000000000 +1000
@@ -598,6 +598,7 @@ void __devinit pci_process_bridge_OF_ran
 			res->start = pci_addr;
 			break;
 		case 2:		/* PCI Memory space */
+		case 3:		/* PCI 64 bits Memory space */
 			printk(KERN_INFO
 			       " MEM 0x%016llx..0x%016llx -> 0x%016llx %s\n",
 			       cpu_addr, cpu_addr + size - 1, pci_addr,
Index: linux-work/arch/powerpc/kernel/prom_parse.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/prom_parse.c	2008-07-17 15:06:43.000000000 +1000
+++ linux-work/arch/powerpc/kernel/prom_parse.c	2008-07-17 15:08:16.000000000 +1000
@@ -128,12 +128,35 @@ static void of_bus_pci_count_cells(struc
 		*sizec = 2;
 }
 
+static unsigned int of_bus_pci_get_flags(const u32 *addr)
+{
+	unsigned int flags = 0;
+	u32 w = addr[0];
+
+	switch((w >> 24) & 0x03) {
+	case 0x01:
+		flags |= IORESOURCE_IO;
+		break;
+	case 0x02: /* 32 bits */
+	case 0x03: /* 64 bits */
+		flags |= IORESOURCE_MEM;
+		break;
+	}
+	if (w & 0x40000000)
+		flags |= IORESOURCE_PREFETCH;
+	return flags;
+}
+
 static u64 of_bus_pci_map(u32 *addr, const u32 *range, int na, int ns, int pna)
 {
 	u64 cp, s, da;
+	unsigned int af, rf;
+
+	af = of_bus_pci_get_flags(addr);
+	rf = of_bus_pci_get_flags(range);
 
 	/* Check address type match */
-	if ((addr[0] ^ range[0]) & 0x03000000)
+	if ((af ^ rf) & (IORESOURCE_MEM | IORESOURCE_IO))
 		return OF_BAD_ADDR;
 
 	/* Read address values, skipping high cell */
@@ -153,25 +176,6 @@ static int of_bus_pci_translate(u32 *add
 	return of_bus_default_translate(addr + 1, offset, na - 1);
 }
 
-static unsigned int of_bus_pci_get_flags(const u32 *addr)
-{
-	unsigned int flags = 0;
-	u32 w = addr[0];
-
-	switch((w >> 24) & 0x03) {
-	case 0x01:
-		flags |= IORESOURCE_IO;
-		break;
-	case 0x02: /* 32 bits */
-	case 0x03: /* 64 bits */
-		flags |= IORESOURCE_MEM;
-		break;
-	}
-	if (w & 0x40000000)
-		flags |= IORESOURCE_PREFETCH;
-	return flags;
-}
-
 const u32 *of_get_pci_address(struct device_node *dev, int bar_no, u64 *size,
 			unsigned int *flags)
 {
