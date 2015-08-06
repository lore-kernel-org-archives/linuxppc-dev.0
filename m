Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D8111A0808
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:12:51 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 6 Aug 2015 14:12:49 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 13AF12BB006A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:12:47 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t764CcNB49414150
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 14:12:46 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t764CD0f011754
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 14:12:14 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, aik@ozlabs.ru,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v6 01/42] PCI: Add pcibios_setup_bridge()
Date: Thu,  6 Aug 2015 14:11:06 +1000
Message-Id: <1438834307-26960-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
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

The patch adds weak function pcibios_setup_bridge(), which is called
by pci_setup_bridge(). PowerPC PowerNV platform will reuse the function
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
index 3fed437..0fa9712 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -816,6 +816,7 @@ void pci_stop_and_remove_bus_device_locked(struct pci_dev *dev);
 void pci_stop_root_bus(struct pci_bus *bus);
 void pci_remove_root_bus(struct pci_bus *bus);
 void pci_setup_cardbus(struct pci_bus *bus);
+void pcibios_setup_bridge(struct pci_bus *bus, unsigned long type);
 void pci_sort_breadthfirst(void);
 #define dev_is_pci(d) ((d)->bus == &pci_bus_type)
 #define dev_is_pf(d) ((dev_is_pci(d) ? to_pci_dev(d)->is_physfn : false))
-- 
2.1.0
