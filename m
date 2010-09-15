Return-Path: <nacc@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1FA14B70A6
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 04:06:39 +1000 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e1.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8FI00AR027017
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 14:00:00 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8FI6ZNI300222
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 14:06:35 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o8FI6YcI010627
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 15:06:35 -0300
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [PATCH 07/15] ppc: pci-common cleanup
Date: Wed, 15 Sep 2010 11:05:50 -0700
Message-Id: <1284573958-8397-8-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
References: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
	Milton Miller <miltonm@bga.com>, Paul Mackerras <paulus@samba.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>, linuxppc-dev@lists.ozlabs.org,
	Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use set_dma_ops and remove unused oddly-named temp pointer sd.

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
---
 arch/powerpc/kernel/pci-common.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 9021c4a..10a44e6 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1090,8 +1090,6 @@ void __devinit pcibios_setup_bus_devices(struct pci_bus *bus)
 		 bus->number, bus->self ? pci_name(bus->self) : "PHB");
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		struct dev_archdata *sd = &dev->dev.archdata;
-
 		/* Cardbus can call us to add new devices to a bus, so ignore
 		 * those who are already fully discovered
 		 */
@@ -1107,7 +1105,7 @@ void __devinit pcibios_setup_bus_devices(struct pci_bus *bus)
 		set_dev_node(&dev->dev, pcibus_to_node(dev->bus));
 
 		/* Hook up default DMA ops */
-		sd->dma_ops = pci_dma_ops;
+		set_dma_ops(&dev->dev, pci_dma_ops);
 		set_dma_offset(&dev->dev, PCI_DRAM_OFFSET);
 
 		/* Additional platform DMA/iommu setup */
-- 
1.7.0.4
