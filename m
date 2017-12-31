Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z8vnN1MqqzDr1k
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jan 2018 09:16:55 +1100 (AEDT)
From: Darren Stevens <darren@stevens-zone.net>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
CC: chzigotzky@xenosoft.de
Date: Sun, 31 Dec 2017 22:00:14 +0000 (GMT)
Message-ID: <4b3d1ee02c7.3de0aa2c@auth.smtp.1and1.co.uk>
Subject: [PATCH NEXT 1/4] powerpc/pasemi: Add PCI initialisation for Nemo
 board.
MIME-Version: 1.0
Content-type: multipart/mixed; boundary="--=_BOUNDARY.6c36894036f0cf76.1d"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Warning: This is a message in MIME format. Your mail reader does
not support MIME. Some parts of this message will be readable as
plain text. To see the rest, you will need to upgrade your mail
reader. Following are some URLs where you can find MIME-capable
mail programs for common platforms:

  AmigaOS...........: http://yam.ch/
  Unix/MacOS/Windows: http://www.mozilla.com/thunderbird/

General information about MIME can be found at:
http://en.wikipedia.org/wiki/MIME

----=_BOUNDARY.6c36894036f0cf76.1d
Content-Type: text/plain

    The A-Eon Amigaone X1000's Nemo motherboard has an AMD SB600
    connected to one of the PCI-e root ports on its PaSemi
    Pwrficient 1628M SoC. Normally the SB600 southbridge would be
    connected to a hidden PCI-e port on the system's northbridge,
    and as a result doesn't fully comply with the PCI-e spec.
    
    Add code to relax the PCI-e detection in both the root port
    and the Linux kernel allowing on board devices to be detected.
    
    Signed-off-by: Darren Stevens <Darren@stevens-zone.net>

---

----=_BOUNDARY.6c36894036f0cf76.1d
Content-Type: text/plain;
	name="pci.patch"
Content-Disposition: attachment;
	filename="pci.patch";
	size=5035

diff --git a/arch/powerpc/platforms/pasemi/pasemi.h b/arch/powerpc/platforms/pasemi/pasemi.h
index 329d2a6..8900dee 100644
--- a/arch/powerpc/platforms/pasemi/pasemi.h
+++ b/arch/powerpc/platforms/pasemi/pasemi.h
@@ -3,6 +3,9 @@
 #define _PASEMI_PASEMI_H
 
 extern unsigned long pas_get_boot_time(void);
+#ifdef CONFIG_PPC_PASEMI_NEMO
+extern void nemo_pci_init(void);
+#endif
 extern void pas_pci_init(void);
 extern void pas_pci_irq_fixup(struct pci_dev *dev);
 extern void pas_pci_dma_dev_setup(struct pci_dev *dev);
diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
index 5ff6108..cb0ac87 100644
--- a/arch/powerpc/platforms/pasemi/pci.c
+++ b/arch/powerpc/platforms/pasemi/pci.c
@@ -27,6 +27,7 @@
 #include <linux/pci.h>
 
 #include <asm/pci-bridge.h>
+#include <asm/isa-bridge.h>
 #include <asm/machdep.h>
 
 #include <asm/ppc-pci.h>
@@ -108,6 +109,92 @@ static int workaround_5945(struct pci_bus *bus, unsigned int devfn,
 	return 1;
 }
 
+#ifdef CONFIG_PPC_PASEMI_NEMO
+static int sb600_bus = 5;
+static void __iomem *iob_mapbase = NULL;
+
+static void sb600_set_flag(int bus)
+{
+	struct resource res;
+	struct device_node *dn;
+	int err;
+
+	if (iob_mapbase == NULL) {
+		dn = of_find_compatible_node(NULL, "isa", "pasemi,1682m-iob");
+		if (!dn) {
+			printk(KERN_CRIT "NEMO SB600 missing iob node\n");
+			return;
+		}
+
+		err = of_address_to_resource(dn, 0, &res);
+		of_node_put(dn);
+
+		if (err) {
+			printk(KERN_CRIT "NEMO SB600 missing resource\n");
+			return;
+		}
+
+		printk(KERN_CRIT "NEMO SB600 IOB base %08lx\n",res.start);
+
+		iob_mapbase = ioremap(res.start + 0x100, 0x94);
+	}
+
+	if (iob_mapbase != NULL) {
+		if (bus == sb600_bus) {
+			/*
+			 * This is the SB600's bus, tell the PCI-e root port
+			 * to allow non-zero devices to enumerate.
+			 */
+			out_le32(iob_mapbase + 4, in_le32(iob_mapbase + 4) | 0x800);
+		} else {
+			/*
+			 * Only scan device 0 on other busses
+			 */
+			out_le32(iob_mapbase + 4, in_le32(iob_mapbase + 4) & ~0x800);
+		}
+	}
+}
+
+static int nemo_pxp_read_config(struct pci_bus *bus, unsigned int devfn,
+			      int offset, int len, u32 *val)
+{
+	struct pci_controller *hose;
+	void volatile __iomem *addr;
+
+	hose = pci_bus_to_host(bus);
+	if (!hose)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (!pa_pxp_offset_valid(bus->number, devfn, offset))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	if (workaround_5945(bus, devfn, offset, len, val))
+		return PCIBIOS_SUCCESSFUL;
+
+	addr = pa_pxp_cfg_addr(hose, bus->number, devfn, offset);
+
+	sb600_set_flag(bus->number);
+
+	/*
+	 * Note: the caller has already checked that offset is
+	 * suitably aligned and that len is 1, 2 or 4.
+	 */
+	switch (len) {
+	case 1:
+		*val = in_8(addr);
+		break;
+	case 2:
+		*val = in_le16(addr);
+		break;
+	default:
+		*val = in_le32(addr);
+		break;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+#endif
+
 static int pa_pxp_read_config(struct pci_bus *bus, unsigned int devfn,
 			      int offset, int len, u32 *val)
 {
@@ -178,6 +265,20 @@ static int pa_pxp_write_config(struct pci_bus *bus, unsigned int devfn,
 	return PCIBIOS_SUCCESSFUL;
 }
 
+#ifdef CONFIG_PPC_PASEMI_NEMO
+static struct pci_ops nemo_pxp_ops = {
+	.read = nemo_pxp_read_config,
+	.write = pa_pxp_write_config,
+};
+
+static void __init setup_nemo_pxp(struct pci_controller *hose)
+{
+	hose->ops = &nemo_pxp_ops;
+	hose->cfg_data = ioremap(0xe0000000, 0x10000000);
+}
+
+#endif
+
 static struct pci_ops pa_pxp_ops = {
 	.read = pa_pxp_read_config,
 	.write = pa_pxp_write_config,
@@ -189,6 +290,35 @@ static void __init setup_pa_pxp(struct pci_controller *hose)
 	hose->cfg_data = ioremap(0xe0000000, 0x10000000);
 }
 
+#ifdef CONFIG_PPC_PASEMI_NEMO
+static int __init nemo_add_bridge(struct device_node *dev)
+{
+	struct pci_controller *hose;
+
+	pr_debug("Adding PCI host bridge %pOF\n", dev);
+
+	hose = pcibios_alloc_controller(dev);
+	if (!hose)
+		return -ENOMEM;
+
+	hose->first_busno = 0;
+	hose->last_busno = 0xff;
+	hose->controller_ops = pasemi_pci_controller_ops;
+
+	setup_nemo_pxp(hose);
+
+	printk(KERN_INFO "Found PA-PXP PCI host bridge.\n");
+
+	/* Interpret the "ranges" property */
+	pci_process_bridge_OF_ranges(hose, dev, 1);
+
+	/* Scan for an isa bridge. */
+	isa_bridge_find_early(hose);
+
+	return 0;
+}
+#endif
+
 static int __init pas_add_bridge(struct device_node *dev)
 {
 	struct pci_controller *hose;
@@ -213,6 +343,28 @@ static int __init pas_add_bridge(struct device_node *dev)
 	return 0;
 }
 
+#ifdef CONFIG_PPC_PASEMI_NEMO
+void __init nemo_pci_init(void)
+{
+	struct device_node *np, *root;
+
+	root = of_find_node_by_path("/");
+	if (!root) {
+		printk(KERN_CRIT "pas_pci_init: can't find root "
+			"of device tree\n");
+		return;
+	}
+
+	pci_set_flags(PCI_SCAN_ALL_PCIE_DEVS);
+
+	for (np = NULL; (np = of_get_next_child(root, np)) != NULL;)
+		if (np->name && !strcmp(np->name, "pxp") && !nemo_add_bridge(np))
+			of_node_get(np);
+
+	of_node_put(root);
+}
+#endif
+
 void __init pas_pci_init(void)
 {
 	struct device_node *np, *root;

----=_BOUNDARY.6c36894036f0cf76.1d--
