Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 19 Apr 2007 17:35:27 +1000
Subject: [PATCH 5/7] Enable MSI mappings for MPIC
In-Reply-To: <1176968125.531108.326168797246.qpush@cradle>
Message-Id: <20070419073555.01990DDECB@ozlabs.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On some Apple machines the HT MSI mappings are not enabled by firmware, so
we need to do it by hand.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/sysdev/mpic.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

Index: msi-new/arch/powerpc/sysdev/mpic.c
===================================================================
--- msi-new.orig/arch/powerpc/sysdev/mpic.c
+++ msi-new/arch/powerpc/sysdev/mpic.c
@@ -379,6 +379,50 @@ static void mpic_shutdown_ht_interrupt(s
 	spin_unlock_irqrestore(&mpic->fixup_lock, flags);
 }
 
+#ifdef CONFIG_PCI_MSI
+static void __init mpic_scan_ht_msi(struct mpic *mpic, u8 __iomem *devbase,
+				    unsigned int devfn)
+{
+	u8 __iomem *base;
+	u8 pos, flags;
+	u64 addr = 0;
+
+	for (pos = readb(devbase + PCI_CAPABILITY_LIST); pos != 0;
+	     pos = readb(devbase + pos + PCI_CAP_LIST_NEXT)) {
+		u8 id = readb(devbase + pos + PCI_CAP_LIST_ID);
+		if (id == PCI_CAP_ID_HT) {
+			id = readb(devbase + pos + 3);
+			if ((id & HT_5BIT_CAP_MASK) == HT_CAPTYPE_MSI_MAPPING)
+				break;
+		}
+	}
+
+	if (pos == 0)
+		return;
+
+	base = devbase + pos;
+
+	flags = readb(base + HT_MSI_FLAGS);
+	if (!(flags & HT_MSI_FLAGS_FIXED)) {
+		addr = readl(base + HT_MSI_ADDR_LO) & HT_MSI_ADDR_LO_MASK;
+		addr = addr | ((u64)readl(base + HT_MSI_ADDR_HI) << 32);
+	}
+
+	printk(KERN_DEBUG "mpic:   - HT:%02x.%x %s MSI mapping found @ 0x%lx\n",
+		PCI_SLOT(devfn), PCI_FUNC(devfn),
+		flags & HT_MSI_FLAGS_ENABLE ? "enabled" : "disabled", addr);
+
+	if (!(flags & HT_MSI_FLAGS_ENABLE))
+		writeb(flags | HT_MSI_FLAGS_ENABLE, base + HT_MSI_FLAGS);
+}
+#else
+static void __init mpic_scan_ht_msi(struct mpic *mpic, u8 __iomem *devbase,
+				    unsigned int devfn)
+{
+	return;
+}
+#endif
+
 static void __init mpic_scan_ht_pic(struct mpic *mpic, u8 __iomem *devbase,
 				    unsigned int devfn, u32 vdid)
 {
@@ -470,6 +514,7 @@ static void __init mpic_scan_ht_pics(str
 			goto next;
 
 		mpic_scan_ht_pic(mpic, devbase, devfn, l);
+		mpic_scan_ht_msi(mpic, devbase, devfn);
 
 	next:
 		/* next device, if function 0 */
