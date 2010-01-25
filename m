Return-Path: <leitao@linux.vnet.ibm.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e24smtp04.br.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C493E1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Jan 2010 00:42:38 +1100 (EST)
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
	by e24smtp04.br.ibm.com (8.14.3/8.13.1) with ESMTP id o0PDVXTM018661
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2010 11:31:33 -0200
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
	by d24relay01.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0PDgVAn4034738
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2010 10:42:31 -0300
Received: from d24av02.br.ibm.com (loopback [127.0.0.1])
	by d24av02.br.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o0PDgVt4009749
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2010 11:42:31 -0200
Message-ID: <4B5D9FC5.5070600@linux.vnet.ibm.com>
Date: Mon, 25 Jan 2010 11:42:29 -0200
From: Breno Leitao <leitao@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Linux PCI <linux-pci@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH] PCI-E broken on PPC (regression)
Content-Type: text/plain; charset=UTF-8
Cc: Jay Vosburgh <fubar@us.ibm.com>, Ron Mercer <ron.mercer@qlogic.com>,
	kaneshige.kenji@jp.fujitsu.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello, 

I found that qlge is broken on PPC, and it got broken after commit 
06a1cbafb253c4c60d6a54a994887f5fbceabcc0. It happens because dev->pcie 
is not set on PPC, because the function set_pcie_port_type(), who sets
dev->pcie, is not being called on PPC PCI code.

So, I have two ideas to fix it, the first one is to call 
set_pcie_port_type() on pci_device_add() instead of pci_setup_device(). 
Since that PPC device flow calls pci_device_add(), it fixes the problem
without duplicating the caller for this function. 

OTOH, it's also possible to add set_pcie_port_type() on pci.h and call
it inside the PPC PCI files, specifically on of_create_pci_dev().

I tested both ideas and they work perfect, so I'd like to figure out 
which one is the most correct one. Both patches are attached here. 

Thanks, 
Breno

----- First idea -----

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 98ffb2d..328c3ab 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -746,7 +746,6 @@ int pci_setup_device(struct pci_dev *dev)
 	dev->hdr_type = hdr_type & 0x7f;
 	dev->multifunction = !!(hdr_type & 0x80);
 	dev->error_state = pci_channel_io_normal;
-	set_pcie_port_type(dev);
 	set_pci_aer_firmware_first(dev);
 
 	list_for_each_entry(slot, &dev->bus->slots, list)
@@ -1052,6 +1051,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	/* Initialize various capabilities */
 	pci_init_capabilities(dev);
 
+	set_pcie_port_type(dev);
 	/*
 	 * Add the device to our list of discovered devices
 	 * and the bus list for fixup functions, etc.

----- Second idea -----

diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index 7311fdf..f8820e8 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -160,6 +160,7 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
 	dev->error_state = pci_channel_io_normal;
 	dev->dma_mask = 0xffffffff;
 
+	set_pcie_port_type(dev);
 	if (!strcmp(type, "pci") || !strcmp(type, "pciex")) {
 		/* a PCI-PCI bridge */
 		dev->hdr_type = PCI_HEADER_TYPE_BRIDGE;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 98ffb2d..f787eea 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -681,7 +681,7 @@ static void pci_read_irq(struct pci_dev *dev)
 	dev->irq = irq;
 }
 
-static void set_pcie_port_type(struct pci_dev *pdev)
+void set_pcie_port_type(struct pci_dev *pdev)
 {
 	int pos;
 	u16 reg16;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 174e539..765095b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1269,6 +1269,7 @@ int pcibios_add_platform_entries(struct pci_dev *dev);
 void pcibios_disable_device(struct pci_dev *dev);
 int pcibios_set_pcie_reset_state(struct pci_dev *dev,
 				 enum pcie_reset_state state);
+extern void set_pcie_port_type(struct pci_dev *pdev);
 
 #ifdef CONFIG_PCI_MMCONFIG
 extern void __init pci_mmcfg_early_init(void);
