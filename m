Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 20 Dec 2007 14:54:57 +1100
Subject: [PATCH 12/19] [POWERPC] Merge 32 and 64 bits pcibios_enable_device
In-Reply-To: <1198122881.874131.56762399546.qpush@grosgo>
Message-Id: <20071220035459.574EDDDF56@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This merge the two implementations, based on the previously
fixed up 32 bits one. The pcibios_enable_device_hook in ppc_md
is now available for ppc64 use. Also remove the new unused
"initial" parameter from it and fixup users.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/pci-common.c       |   38 +++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/pci_32.c           |   37 --------------------------------
 arch/powerpc/kernel/pci_64.c           |   30 --------------------------
 arch/powerpc/platforms/powermac/pci.c  |   22 ++++++++-----------
 arch/powerpc/platforms/powermac/pmac.h |    2 -
 include/asm-powerpc/machdep.h          |   10 +++-----
 6 files changed, 53 insertions(+), 86 deletions(-)

--- linux-merge.orig/arch/powerpc/kernel/pci-common.c	2007-12-14 15:49:33.000000000 +1100
+++ linux-merge/arch/powerpc/kernel/pci-common.c	2007-12-14 15:49:34.000000000 +1100
@@ -1127,3 +1127,41 @@ void __devinit pcibios_claim_one_bus(str
 }
 EXPORT_SYMBOL_GPL(pcibios_claim_one_bus);
 #endif /* CONFIG_HOTPLUG */
+
+int pcibios_enable_device(struct pci_dev *dev, int mask)
+{
+	u16 cmd, old_cmd;
+	int idx;
+	struct resource *r;
+
+	if (ppc_md.pcibios_enable_device_hook)
+		if (ppc_md.pcibios_enable_device_hook(dev))
+			return -EINVAL;
+
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	old_cmd = cmd;
+	for (idx = 0; idx < PCI_NUM_RESOURCES; idx++) {
+		/* Only set up the requested stuff */
+		if (!(mask & (1 << idx)))
+			continue;
+		r = &dev->resource[idx];
+		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
+			continue;
+		if (r->flags & IORESOURCE_UNSET) {
+			printk(KERN_ERR "PCI: Device %s not available because"
+			       " of resource collisions\n", pci_name(dev));
+			return -EINVAL;
+		}
+		if (r->flags & IORESOURCE_IO)
+			cmd |= PCI_COMMAND_IO;
+		if (r->flags & IORESOURCE_MEM)
+			cmd |= PCI_COMMAND_MEMORY;
+	}
+	if (cmd != old_cmd) {
+		printk("PCI: Enabling device %s (%04x -> %04x)\n",
+		       pci_name(dev), old_cmd, cmd);
+		pci_write_config_word(dev, PCI_COMMAND, cmd);
+	}
+	return 0;
+}
+
Index: linux-merge/include/asm-powerpc/machdep.h
===================================================================
--- linux-merge.orig/include/asm-powerpc/machdep.h	2007-12-14 15:49:31.000000000 +1100
+++ linux-merge/include/asm-powerpc/machdep.h	2007-12-14 15:49:34.000000000 +1100
@@ -204,12 +204,6 @@ struct machdep_calls {
 	/*
 	 * optional PCI "hooks"
 	 */
-
-	/* Called when pci_enable_device() is called (initial=0) or
-	 * when a device with no assigned resource is found (initial=1).
-	 * Returns 0 to allow assignment/enabling of the device. */
-	int  (*pcibios_enable_device_hook)(struct pci_dev *, int initial);
-
 	/* Called in indirect_* to avoid touching devices */
 	int (*pci_exclude_device)(struct pci_controller *, unsigned char, unsigned char);
 
@@ -225,6 +219,10 @@ struct machdep_calls {
 	/* Called for each PCI bus in the system when it's probed */
 	void (*pcibios_fixup_bus)(struct pci_bus *);
 
+	/* Called when pci_enable_device() is called. Returns 0 to
+	 * allow assignment/enabling of the device. */
+	int  (*pcibios_enable_device_hook)(struct pci_dev *);
+
 	/* Called to shutdown machine specific hardware not already controlled
 	 * by other drivers.
 	 */
Index: linux-merge/arch/powerpc/kernel/pci_32.c
===================================================================
--- linux-merge.orig/arch/powerpc/kernel/pci_32.c	2007-12-14 15:49:33.000000000 +1100
+++ linux-merge/arch/powerpc/kernel/pci_32.c	2007-12-14 15:49:34.000000000 +1100
@@ -518,43 +518,6 @@ pcibios_update_irq(struct pci_dev *dev, 
 	/* XXX FIXME - update OF device tree node interrupt property */
 }
 
-int pcibios_enable_device(struct pci_dev *dev, int mask)
-{
-	u16 cmd, old_cmd;
-	int idx;
-	struct resource *r;
-
-	if (ppc_md.pcibios_enable_device_hook)
-		if (ppc_md.pcibios_enable_device_hook(dev, 0))
-			return -EINVAL;
-		
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	old_cmd = cmd;
-	for (idx = 0; idx < PCI_NUM_RESOURCES; idx++) {
-		/* Only set up the requested stuff */
-		if (!(mask & (1 << idx)))
-			continue;
-		r = &dev->resource[idx];
-		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
-			continue;
-		if (r->flags & IORESOURCE_UNSET) {
-			printk(KERN_ERR "PCI: Device %s not available because"
-			       " of resource collisions\n", pci_name(dev));
-			return -EINVAL;
-		}
-		if (r->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		if (r->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
-	}
-	if (cmd != old_cmd) {
-		printk("PCI: Enabling device %s (%04x -> %04x)\n",
-		       pci_name(dev), old_cmd, cmd);
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
-	return 0;
-}
-
 static struct pci_controller*
 pci_bus_to_hose(int bus)
 {
Index: linux-merge/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-merge.orig/arch/powerpc/kernel/pci_64.c	2007-12-14 15:49:33.000000000 +1100
+++ linux-merge/arch/powerpc/kernel/pci_64.c	2007-12-14 15:49:34.000000000 +1100
@@ -420,36 +420,6 @@ static int __init pcibios_init(void)
 
 subsys_initcall(pcibios_init);
 
-int pcibios_enable_device(struct pci_dev *dev, int mask)
-{
-	u16 cmd, oldcmd;
-	int i;
-
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	oldcmd = cmd;
-
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		struct resource *res = &dev->resource[i];
-
-		/* Only set up the requested stuff */
-		if (!(mask & (1<<i)))
-			continue;
-
-		if (res->flags & IORESOURCE_IO)
-			cmd |= PCI_COMMAND_IO;
-		if (res->flags & IORESOURCE_MEM)
-			cmd |= PCI_COMMAND_MEMORY;
-	}
-
-	if (cmd != oldcmd) {
-		printk(KERN_DEBUG "PCI: Enabling device: (%s), cmd %x\n",
-		       pci_name(dev), cmd);
-                /* Enable the appropriate bits in the PCI command register.  */
-		pci_write_config_word(dev, PCI_COMMAND, cmd);
-	}
-	return 0;
-}
-
 #ifdef CONFIG_HOTPLUG
 
 int pcibios_unmap_io_space(struct pci_bus *bus)
Index: linux-merge/arch/powerpc/platforms/powermac/pci.c
===================================================================
--- linux-merge.orig/arch/powerpc/platforms/powermac/pci.c	2007-12-14 15:49:32.000000000 +1100
+++ linux-merge/arch/powerpc/platforms/powermac/pci.c	2007-12-14 15:49:34.000000000 +1100
@@ -1058,8 +1058,7 @@ void __init pmac_pci_init(void)
 #endif
 }
 
-int
-pmac_pci_enable_device_hook(struct pci_dev *dev, int initial)
+int pmac_pci_enable_device_hook(struct pci_dev *dev)
 {
 	struct device_node* node;
 	int updatecfg = 0;
@@ -1101,26 +1100,25 @@ pmac_pci_enable_device_hook(struct pci_d
 		updatecfg = 1;
 	}
 
+	/*
+	 * Fixup various header fields on 32 bits. We don't do that on
+	 * 64 bits as some of these have strange values behind the HT
+	 * bridge and we must not, for example, enable MWI or set the
+	 * cache line size on them.
+	 */
+#ifdef CONFIG_PPC32
 	if (updatecfg) {
 		u16 cmd;
 
-		/*
-		 * Make sure PCI is correctly configured
-		 *
-		 * We use old pci_bios versions of the function since, by
-		 * default, gmac is not powered up, and so will be absent
-		 * from the kernel initial PCI lookup.
-		 *
-		 * Should be replaced by 2.4 new PCI mechanisms and really
-		 * register the device.
-		 */
 		pci_read_config_word(dev, PCI_COMMAND, &cmd);
 		cmd |= PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER
 			| PCI_COMMAND_INVALIDATE;
 		pci_write_config_word(dev, PCI_COMMAND, cmd);
 		pci_write_config_byte(dev, PCI_LATENCY_TIMER, 16);
+
 		pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE,
 				      L1_CACHE_BYTES >> 2);
+#endif
 	}
 
 	return 0;
Index: linux-merge/arch/powerpc/platforms/powermac/pmac.h
===================================================================
--- linux-merge.orig/arch/powerpc/platforms/powermac/pmac.h	2007-12-14 15:48:58.000000000 +1100
+++ linux-merge/arch/powerpc/platforms/powermac/pmac.h	2007-12-14 15:49:34.000000000 +1100
@@ -26,7 +26,7 @@ extern void pmac_pci_init(void);
 extern void pmac_nvram_update(void);
 extern unsigned char pmac_nvram_read_byte(int addr);
 extern void pmac_nvram_write_byte(int addr, unsigned char val);
-extern int pmac_pci_enable_device_hook(struct pci_dev *dev, int initial);
+extern int pmac_pci_enable_device_hook(struct pci_dev *dev);
 extern void pmac_pcibios_after_init(void);
 extern int of_show_percpuinfo(struct seq_file *m, int i);
 
