Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 762D81A0D04
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:14:32 +1100 (AEDT)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 18:44:29 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 9F8EE3940019
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 18:44:25 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4DECg510616904
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 18:44:12 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4DD3d5029973
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 18:43:04 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 01/50] PCI: Add pcibios_setup_bridge()
Date: Thu,  5 Nov 2015 00:12:01 +1100
Message-Id: <1446642770-4681-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, PowerPC PowerNV platform utilizes ppc_md.pcibios_fixup(),
which is called for once after PCI probing and resource assignment
are completed, to allocate platform required resources for PCI devices:
PE#, IO and MMIO mapping, DMA address translation (TCE) table etc.
Obviously, it's not hotplug friendly.

This adds weak function pcibios_setup_bridge(), which is called by
pci_setup_bridge(). PowerPC PowerNV platform will reuse the function
to assign above platform required resources to newly added PCI devices,
in order to support PCI hotplug in subsequent patches.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/setup-bus.c | 5 +++++
 include/linux/pci.h     | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 508cc56..a69eae1 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -696,11 +696,16 @@ static void __pci_setup_bridge(struct pci_bus *bus, unsigned long type)
 	pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, bus->bridge_ctl);
 }
 
+void __weak pcibios_setup_bridge(struct pci_bus *bus, unsigned long type)
+{
+}
+
 void pci_setup_bridge(struct pci_bus *bus)
 {
 	unsigned long type = IORESOURCE_IO | IORESOURCE_MEM |
 				  IORESOURCE_PREFETCH;
 
+	pcibios_setup_bridge(bus, type);
 	__pci_setup_bridge(bus, type);
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e90eb22..41343bb 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -831,6 +831,7 @@ void pci_stop_and_remove_bus_device_locked(struct pci_dev *dev);
 void pci_stop_root_bus(struct pci_bus *bus);
 void pci_remove_root_bus(struct pci_bus *bus);
 void pci_setup_cardbus(struct pci_bus *bus);
+void pcibios_setup_bridge(struct pci_bus *bus, unsigned long type);
 void pci_sort_breadthfirst(void);
 #define dev_is_pci(d) ((d)->bus == &pci_bus_type)
 #define dev_is_pf(d) ((dev_is_pci(d) ? to_pci_dev(d)->is_physfn : false))
-- 
2.1.0
