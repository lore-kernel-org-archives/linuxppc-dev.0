Return-Path: <SRS0+0ced42e87c3290b50e75+874+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [205.233.218.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CEF9168A29
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jan 2006 11:14:01 +1100 (EST)
Subject: [PATCH] Make CHRP build again
From: David Woodhouse <dwmw2@infradead.org>
To: paulus@samba.org
Content-Type: text/plain
Date: Sat, 14 Jan 2006 00:13:49 +0000
Message-Id: <1137197629.3621.34.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This makes CHRP build again, although it's untested because my Pegasos
is currently in pieces.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

--- arch/powerpc/platforms/chrp/setup.c~	2006-01-13 15:26:41.000000000 +0000
+++ arch/powerpc/platforms/chrp/setup.c	2006-01-13 23:44:29.000000000 +0000
@@ -352,9 +352,10 @@ static void __init chrp_find_openpic(voi
 		opaddr = opprop[na-1];	/* assume 32-bit */
 		oplen /= na * sizeof(unsigned int);
 	} else {
-		if (np->n_addrs == 0)
+		struct resource r;
+		if (of_address_to_resource(np, 0, &r))
 			return;
-		opaddr = np->addrs[0].address;
+		opaddr = r.start;
 		oplen = 0;
 	}
 
@@ -377,7 +378,7 @@ static void __init chrp_find_openpic(voi
 	 */
 	if (oplen < len) {
 		printk(KERN_ERR "Insufficient addresses for distributed"
-		       " OpenPIC (%d < %d)\n", np->n_addrs, len);
+		       " OpenPIC (%d < %d)\n", oplen, len);
 		len = oplen;
 	}
 
--- arch/powerpc/platforms/chrp/time.c~	2006-01-03 03:21:10.000000000 +0000
+++ arch/powerpc/platforms/chrp/time.c	2006-01-13 23:54:44.000000000 +0000
@@ -21,6 +21,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/init.h>
 #include <linux/bcd.h>
+#include <linux/ioport.h>
 
 #include <asm/io.h>
 #include <asm/nvram.h>
@@ -37,14 +38,16 @@ static int nvram_data = NVRAM_DATA;
 long __init chrp_time_init(void)
 {
 	struct device_node *rtcs;
+	struct resource r;
 	int base;
 
 	rtcs = find_compatible_devices("rtc", "pnpPNP,b00");
 	if (rtcs == NULL)
 		rtcs = find_compatible_devices("rtc", "ds1385-rtc");
-	if (rtcs == NULL || rtcs->addrs == NULL)
+	if (rtcs == NULL || of_address_to_resource(rtcs, 0, &r))
 		return 0;
-	base = rtcs->addrs[0].address;
+	
+	base = r.start;
 	nvram_as1 = 0;
 	nvram_as0 = base;
 	nvram_data = base + 1;
--- arch/powerpc/platforms/chrp/pci.c~	2006-01-03 03:21:10.000000000 +0000
+++ arch/powerpc/platforms/chrp/pci.c	2006-01-14 00:03:36.000000000 +0000
@@ -135,12 +135,13 @@ int __init
 hydra_init(void)
 {
 	struct device_node *np;
+	struct resource r;
 
 	np = find_devices("mac-io");
-	if (np == NULL || np->n_addrs == 0)
+	if (np == NULL || of_address_to_resource(np, 0, &r))
 		return 0;
-	Hydra = ioremap(np->addrs[0].address, np->addrs[0].size);
-	printk("Hydra Mac I/O at %lx\n", np->addrs[0].address);
+	Hydra = ioremap(r.start, r.end-r.start);
+	printk("Hydra Mac I/O at %lx\n", r.start);
 	printk("Hydra Feature_Control was %x",
 	       in_le32(&Hydra->Feature_Control));
 	out_le32(&Hydra->Feature_Control, (HYDRA_FC_SCC_CELL_EN |
@@ -177,18 +178,24 @@ setup_python(struct pci_controller *hose
 {
 	u32 __iomem *reg;
 	u32 val;
-	unsigned long addr = dev->addrs[0].address;
+	struct resource r;
 
-	setup_indirect_pci(hose, addr + 0xf8000, addr + 0xf8010);
+	if (of_address_to_resource(dev, 0, &r)) {
+		printk(KERN_ERR "No address for Python PCI controller\n");
+		return;
+	}
 
 	/* Clear the magic go-slow bit */
-	reg = ioremap(dev->addrs[0].address + 0xf6000, 0x40);
+	reg = ioremap(r.start + 0xf6000, 0x40);
+	BUG_ON(!reg); 
 	val = in_be32(&reg[12]);
 	if (val & PRG_CL_RESET_VALID) {
 		out_be32(&reg[12], val & ~PRG_CL_RESET_VALID);
 		in_be32(&reg[12]);
 	}
 	iounmap(reg);
+
+	setup_indirect_pci(hose, r.start + 0xf8000, r.start + 0xf8010);
 }
 
 /* Marvell Discovery II based Pegasos 2 */
@@ -218,7 +225,7 @@ chrp_find_bridges(void)
 	char *model, *machine;
 	int is_longtrail = 0, is_mot = 0, is_pegasos = 0;
 	struct device_node *root = find_path_device("/");
-
+	struct resource r;
 	/*
 	 * The PCI host bridge nodes on some machines don't have
 	 * properties to adequately identify them, so we have to
@@ -238,7 +245,7 @@ chrp_find_bridges(void)
 			continue;
 		++index;
 		/* The GG2 bridge on the LongTrail doesn't have an address */
-		if (dev->n_addrs < 1 && !is_longtrail) {
+		if (of_address_to_resource(dev, 0, &r) && !is_longtrail) {
 			printk(KERN_WARNING "Can't use %s: no address\n",
 			       dev->full_name);
 			continue;
@@ -255,8 +262,8 @@ chrp_find_bridges(void)
 			printk(KERN_INFO "PCI buses %d..%d",
 			       bus_range[0], bus_range[1]);
 		printk(" controlled by %s", dev->type);
-		if (dev->n_addrs > 0)
-			printk(" at %lx", dev->addrs[0].address);
+		if (!is_longtrail)
+			printk(" at %lx", r.start);
 		printk("\n");
 
 		hose = pcibios_alloc_controller();

-- 
dwmw2
