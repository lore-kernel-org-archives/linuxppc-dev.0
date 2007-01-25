Return-Path: <michael@ozlabs.org>
To: linux-pci@atrey.karlin.mff.cuni.cz
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 25 Jan 2007 19:34:16 +1100
Subject: [RFC/PATCH 15/16] Enable MSI mappings for MPIC
In-Reply-To: <1169714047.65693.647693675533.qpush@cradle>
Message-Id: <20070125083417.EBCA9DE3BE@ozlabs.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, Brice Goglin <brice@myri.com>,
	shaohua.li@intel.com, "David S. Miller" <davem@davemloft.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>
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

 arch/powerpc/sysdev/mpic.c |   49 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

Index: msi/arch/powerpc/sysdev/mpic.c
===================================================================
--- msi.orig/arch/powerpc/sysdev/mpic.c
+++ msi/arch/powerpc/sysdev/mpic.c
@@ -379,7 +379,51 @@ static void mpic_shutdown_ht_interrupt(s
 	spin_unlock_irqrestore(&mpic->fixup_lock, flags);
 }
 
-static void __init mpic_scan_ht_pic(struct mpic *mpic, u8 __iomem *devbase,
+#ifdef CONFIG_PCI_MSI
+static void __init mpic_setup_ht_msi(struct mpic *mpic, u8 __iomem *devbase,
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
+static void __init mpic_setup_ht_msi(struct mpic *mpic, u8 __iomem *devbase,
+				    unsigned int devfn)
+{
+	return;
+}
+#endif
+
+static void __init mpic_setup_ht_pic(struct mpic *mpic, u8 __iomem *devbase,
 				    unsigned int devfn, u32 vdid)
 {
 	int i, irq, n;
@@ -469,7 +513,8 @@ static void __init mpic_scan_ht_pics(str
 		if (!(s & PCI_STATUS_CAP_LIST))
 			goto next;
 
-		mpic_scan_ht_pic(mpic, devbase, devfn, l);
+		mpic_setup_ht_pic(mpic, devbase, devfn, l);
+		mpic_setup_ht_msi(mpic, devbase, devfn);
 
 	next:
 		/* next device, if function 0 */
