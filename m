Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzhvH383gzDqnf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 23:33:15 +1000 (AEST)
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 3 May 2016 18:53:11 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 997AA125804F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 18:55:11 +0530 (IST)
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u43DN88A46334092
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 18:53:08 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u43DN9ZB031530
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 18:53:12 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, robherring2@gmail.com, dja@axtens.net,
 alistair@popple.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v9 01/22] PCI: Add pcibios_setup_bridge()
Date: Tue,  3 May 2016 23:22:32 +1000
Message-Id: <1462281773-26438-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
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
to assign above platform required resources to newly plugged PCI devices
during PCI hotplug in subsequent patches.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/setup-bus.c | 5 +++++
 include/linux/pci.h     | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 55641a3..d678c46 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -695,11 +695,16 @@ static void __pci_setup_bridge(struct pci_bus *bus, unsigned long type)
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
index 004b813..a17f0e8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -856,6 +856,7 @@ void pci_stop_and_remove_bus_device_locked(struct pci_dev *dev);
 void pci_stop_root_bus(struct pci_bus *bus);
 void pci_remove_root_bus(struct pci_bus *bus);
 void pci_setup_cardbus(struct pci_bus *bus);
+void pcibios_setup_bridge(struct pci_bus *bus, unsigned long type);
 void pci_sort_breadthfirst(void);
 #define dev_is_pci(d) ((d)->bus == &pci_bus_type)
 #define dev_is_pf(d) ((dev_is_pci(d) ? to_pci_dev(d)->is_physfn : false))
-- 
2.1.0
