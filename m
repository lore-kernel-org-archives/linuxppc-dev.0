Return-Path: <nacc@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E9D9BB71C5
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Oct 2010 04:27:43 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o9IHN64Z025801
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Oct 2010 11:23:06 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9IHRGON151414
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Oct 2010 11:27:16 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o9IHRESo006666
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Oct 2010 11:27:16 -0600
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [PATCH 1/7] microblaze: pci-common cleanup
Date: Mon, 18 Oct 2010 10:26:58 -0700
Message-Id: <1287422825-14999-2-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1287422825-14999-1-git-send-email-nacc@us.ibm.com>
References: <1287422825-14999-1-git-send-email-nacc@us.ibm.com>
Cc: Michal Simek <monstr@monstr.eu>, linux-kernel@vger.kernel.org,
	miltonm@bga.com, Jesse Barnes <jbarnes@virtuousgeek.org>,
	microblaze-uclinux@itee.uq.edu.au, linuxppc-dev@lists.ozlabs.org,
	Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use set_dma_ops and remove now used-once oddly named temp pointer sd.

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: benh@kernel.crashing.org
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/microblaze/pci/pci-common.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 55ef532..9631e1d 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -1075,8 +1075,6 @@ void __devinit pcibios_setup_bus_devices(struct pci_bus *bus)
 		 bus->number, bus->self ? pci_name(bus->self) : "PHB");
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		struct dev_archdata *sd = &dev->dev.archdata;
-
 		/* Setup OF node pointer in archdata */
 		dev->dev.of_node = pci_device_to_OF_node(dev);
 
@@ -1086,8 +1084,8 @@ void __devinit pcibios_setup_bus_devices(struct pci_bus *bus)
 		set_dev_node(&dev->dev, pcibus_to_node(dev->bus));
 
 		/* Hook up default DMA ops */
-		sd->dma_ops = pci_dma_ops;
-		sd->dma_data = (void *)PCI_DRAM_OFFSET;
+		set_dma_ops(&dev->dev, pci_dma_ops);
+		dev->dev.archdata.dma_data = (void *)PCI_DRAM_OFFSET;
 
 		/* Read default IRQs and fixup if necessary */
 		pci_read_irq_line(dev);
-- 
1.7.1
