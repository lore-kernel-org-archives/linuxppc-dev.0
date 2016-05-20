Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9yzm4wPWzDqB5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:42:44 +1000 (AEST)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 20 May 2016 16:42:44 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 29ACC2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:42:42 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4K6gYv466191426
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:42:42 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4K6g9pw008971
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:42:09 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 alistair@popple.id.au, aik@ozlabs.ru,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v10 02/18] powerpc/pci: Override pcibios_setup_bridge()
Date: Fri, 20 May 2016 16:41:26 +1000
Message-Id: <1463726502-14679-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1463726502-14679-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1463726502-14679-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This overrides pcibios_setup_bridge() that is called to update PCI
bridge windows when PCI resource assignment is completed, to assign
PE and setup various (resource) mapping for the PE in subsequent
patches.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/pci-bridge.h | 2 ++
 arch/powerpc/kernel/pci-common.c      | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 467c0b0..b5e88e4 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -33,6 +33,8 @@ struct pci_controller_ops {
 	/* Called during PCI resource reassignment */
 	resource_size_t (*window_alignment)(struct pci_bus *bus,
 					    unsigned long type);
+	void		(*setup_bridge)(struct pci_bus *bus,
+					unsigned long type);
 	void		(*reset_secondary_bus)(struct pci_dev *pdev);
 
 #ifdef CONFIG_PCI_MSI
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 0f7a60f..40df3a5 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -124,6 +124,14 @@ resource_size_t pcibios_window_alignment(struct pci_bus *bus,
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
