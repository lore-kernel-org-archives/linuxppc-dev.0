Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B0D11A0E52
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:45:02 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 4 Jun 2015 16:45:01 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 29AC62BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:45:00 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t546hbop45023402
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:45 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t546hCIx001935
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:13 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, bhelgaas@google.com, aik@ozlabs.ru,
 panto@antoniou-consulting.com, robherring2@gmail.com,
 grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v5 13/42] powerpc/pci: Override pcibios_setup_bridge()
Date: Thu,  4 Jun 2015 16:41:42 +1000
Message-Id: <1433400131-18429-14-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch overrides pcibios_setup_bridge(), called to update PCI
bridge windows at completion of PCI resource assignment, to assign
PE and setup various (resource) mapping in next patch.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v5:
  * Split from [PATCH v5 v4 06/21]
---
 arch/powerpc/include/asm/pci-bridge.h | 1 +
 arch/powerpc/kernel/pci-common.c      | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 1252cd5..1f39ca7 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -29,6 +29,7 @@ struct pci_controller_ops {
 
 	/* Called during PCI resource reassignment */
 	resource_size_t (*window_alignment)(struct pci_bus *, unsigned long);
+	void		(*setup_bridge)(struct pci_bus *, unsigned long);
 	void		(*reset_secondary_bus)(struct pci_dev *);
 };
 
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 0d05406..0358f24 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -122,6 +122,14 @@ resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 	return 1;
 }
 
+void pcibios_setup_bridge(struct pci_bus *bus, unsigned long type)
+{
+	struct pci_controller *hose = pci_bus_to_host(bus);
+
+	if (hose->controller_ops.setup_bridge)
+		hose->controller_ops.setup_bridge(bus, type);
+}
+
 void pcibios_reset_secondary_bus(struct pci_dev *dev)
 {
 	struct pci_controller *phb = pci_bus_to_host(dev->bus);
-- 
2.1.0
