Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 13 Dec 2005 18:04:29 +1100
Message-Id: <1134457469.6989.189.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Update MPIC workarounds
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Segher Boessenkool <segher@kernel.crashing.org>

Cleanup the MPIC IO-APIC workarounds, make them a bit more generic,
smaller and faster. 

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/sysdev/mpic.c
===================================================================
--- linux-work.orig/arch/powerpc/sysdev/mpic.c	2005-12-06 16:17:43.000000000 +1100
+++ linux-work/arch/powerpc/sysdev/mpic.c	2005-12-07 13:30:45.000000000 +1100
@@ -175,57 +175,57 @@ static inline int mpic_is_ht_interrupt(s
 	return mpic->fixups[source_no].base != NULL;
 }
 
+
 static inline void mpic_apic_end_irq(struct mpic *mpic, unsigned int source_no)
 {
 	struct mpic_irq_fixup *fixup = &mpic->fixups[source_no];
-	u32 tmp;
 
 	spin_lock(&mpic->fixup_lock);
-	writeb(0x11 + 2 * fixup->irq, fixup->base);
-	tmp = readl(fixup->base + 2);
-	writel(tmp | 0x80000000ul, fixup->base + 2);
-	/* config writes shouldn't be posted but let's be safe ... */
-	(void)readl(fixup->base + 2);
+	writeb(0x11 + 2 * fixup->irq, fixup->base + 2);
+	writel(fixup->data, fixup->base + 4);
 	spin_unlock(&mpic->fixup_lock);
 }
 
 
-static void __init mpic_amd8111_read_irq(struct mpic *mpic, u8 __iomem *devbase)
+static void __init mpic_scan_ioapic(struct mpic *mpic, u8 __iomem *devbase)
 {
-	int i, irq;
+	int i, irq, n;
 	u32 tmp;
+	u8 pos;
 
-	printk(KERN_INFO "mpic:    - Workarounds on AMD 8111 @ %p\n", devbase);
+	for (pos = readb(devbase + 0x34); pos; pos = readb(devbase + pos + 1)) {
+		u8 id = readb(devbase + pos);
 
-	for (i=0; i < 24; i++) {
-		writeb(0x10 + 2*i, devbase + 0xf2);
-		tmp = readl(devbase + 0xf4);
-		if ((tmp & 0x1) || !(tmp & 0x20))
-			continue;
-		irq = (tmp >> 16) & 0xff;
-		mpic->fixups[irq].irq = i;
-		mpic->fixups[irq].base = devbase + 0xf2;
+		if (id == 0x08) {
+			id = readb(devbase + pos + 3);
+			if (id == 0x80)
+				break;
+		}
 	}
-}
- 
-static void __init mpic_amd8131_read_irq(struct mpic *mpic, u8 __iomem *devbase)
-{
-	int i, irq;
-	u32 tmp;
+	if (pos == 0)
+		return;
+
+	printk(KERN_INFO "mpic:    - Workarounds @ %p, pos = 0x%02x\n", devbase, pos);
 
-	printk(KERN_INFO "mpic:    - Workarounds on AMD 8131 @ %p\n", devbase);
+	devbase += pos;
 
-	for (i=0; i < 4; i++) {
-		writeb(0x10 + 2*i, devbase + 0xba);
-		tmp = readl(devbase + 0xbc);
-		if ((tmp & 0x1) || !(tmp & 0x20))
+	writeb(0x01, devbase + 2);
+	n = (readl(devbase + 4) >> 16) & 0xff;
+
+	for (i = 0; i <= n; i++) {
+		writeb(0x10 + 2 * i, devbase + 2);
+		tmp = readl(devbase + 4);
+		if ((tmp & 0x21) != 0x20)
 			continue;
 		irq = (tmp >> 16) & 0xff;
 		mpic->fixups[irq].irq = i;
-		mpic->fixups[irq].base = devbase + 0xba;
+		mpic->fixups[irq].base = devbase;
+		writeb(0x11 + 2 * i, devbase + 2);
+		mpic->fixups[irq].data = readl(devbase + 4) | 0x80000000;
 	}
 }
  
+
 static void __init mpic_scan_ioapics(struct mpic *mpic)
 {
 	unsigned int devfn;
@@ -241,21 +241,19 @@ static void __init mpic_scan_ioapics(str
 	/* Init spinlock */
 	spin_lock_init(&mpic->fixup_lock);
 
-	/* Map u3 config space. We assume all IO-APICs are on the primary bus
-	 * and slot will never be above "0xf" so we only need to map 32k
+	/* Map U3 config space. We assume all IO-APICs are on the primary bus
+	 * so we only need to map 64kB.
 	 */
-	cfgspace = (unsigned char __iomem *)ioremap(0xf2000000, 0x8000);
+	cfgspace = ioremap(0xf2000000, 0x10000);
 	BUG_ON(cfgspace == NULL);
 
 	/* Now we scan all slots. We do a very quick scan, we read the header type,
 	 * vendor ID and device ID only, that's plenty enough
 	 */
-	for (devfn = 0; devfn < PCI_DEVFN(0x10,0); devfn ++) {
+	for (devfn = 0; devfn < 0x100; devfn++) {
 		u8 __iomem *devbase = cfgspace + (devfn << 8);
 		u8 hdr_type = readb(devbase + PCI_HEADER_TYPE);
 		u32 l = readl(devbase + PCI_VENDOR_ID);
-		u16 vendor_id, device_id;
-		int multifunc = 0;
 
 		DBG("devfn %x, l: %x\n", devfn, l);
 
@@ -264,21 +262,11 @@ static void __init mpic_scan_ioapics(str
 		    l == 0x0000ffff || l == 0xffff0000)
 			goto next;
 
-		/* Check if it's a multifunction device (only really used
-		 * to function 0 though
-		 */
-		multifunc = !!(hdr_type & 0x80);
-		vendor_id = l & 0xffff;
-		device_id = (l >> 16) & 0xffff;
-
-		/* If a known device, go to fixup setup code */
-		if (vendor_id == PCI_VENDOR_ID_AMD && device_id == 0x7460)
-			mpic_amd8111_read_irq(mpic, devbase);
-		if (vendor_id == PCI_VENDOR_ID_AMD && device_id == 0x7450)
-			mpic_amd8131_read_irq(mpic, devbase);
+		mpic_scan_ioapic(mpic, devbase);
+
 	next:
 		/* next device, if function 0 */
-		if ((PCI_FUNC(devfn) == 0) && !multifunc)
+		if (PCI_FUNC(devfn) == 0 && (hdr_type & 0x80) == 0)
 			devfn += 7;
 	}
 }
Index: linux-work/include/asm-powerpc/mpic.h
===================================================================
--- linux-work.orig/include/asm-powerpc/mpic.h	2005-11-24 17:18:48.000000000 +1100
+++ linux-work/include/asm-powerpc/mpic.h	2005-12-07 10:32:51.000000000 +1100
@@ -117,7 +117,8 @@ typedef int (*mpic_cascade_t)(struct pt_
 struct mpic_irq_fixup
 {
 	u8 __iomem	*base;
-	unsigned int   irq;
+	u32		data;
+	unsigned int	irq;
 };
 #endif /* CONFIG_MPIC_BROKEN_U3 */
 
