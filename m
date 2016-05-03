Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzVSR5wttzDq9s
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 15:42:47 +1000 (AEST)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 3 May 2016 15:42:47 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 690823578058
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 15:42:44 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u435gaZx52363510
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 15:42:44 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u435gBib018661
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 15:42:12 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 alistair@popple.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v9 01/26] powerpc/pci: Cleanup on struct pci_controller_ops
Date: Tue,  3 May 2016 15:41:20 +1000
Message-Id: <1462254105-24128-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1462254105-24128-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1462254105-24128-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Each PHB has one instance of "struct pci_controller_ops" that includes
various callbacks called by PCI subsystem. In the definition of this
struct, some callbacks have explicit names for its arguments, but the
left don't have.

This adds all explicit names of the arguments to the callbacks in
"struct pci_controller_ops" so that the code looks consistent. Also,
argument name @dev is replaced by @pdev as the later one is the
preferred name for PCI device.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Reviewed-by: Daniel Axtens <dja@axtens.net>
Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/pci-bridge.h | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index f5056e3..023c8c8 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -17,33 +17,34 @@ struct device_node;
  * PCI controller operations
  */
 struct pci_controller_ops {
-	void		(*dma_dev_setup)(struct pci_dev *dev);
+	void		(*dma_dev_setup)(struct pci_dev *pdev);
 	void		(*dma_bus_setup)(struct pci_bus *bus);
 
-	int		(*probe_mode)(struct pci_bus *);
+	int		(*probe_mode)(struct pci_bus *bus);
 
 	/* Called when pci_enable_device() is called. Returns true to
 	 * allow assignment/enabling of the device. */
-	bool		(*enable_device_hook)(struct pci_dev *);
+	bool		(*enable_device_hook)(struct pci_dev *pdev);
 
-	void		(*disable_device)(struct pci_dev *);
+	void		(*disable_device)(struct pci_dev *pdev);
 
-	void		(*release_device)(struct pci_dev *);
+	void		(*release_device)(struct pci_dev *pdev);
 
 	/* Called during PCI resource reassignment */
-	resource_size_t (*window_alignment)(struct pci_bus *, unsigned long type);
-	void		(*reset_secondary_bus)(struct pci_dev *dev);
+	resource_size_t (*window_alignment)(struct pci_bus *bus,
+					    unsigned long type);
+	void		(*reset_secondary_bus)(struct pci_dev *pdev);
 
 #ifdef CONFIG_PCI_MSI
-	int		(*setup_msi_irqs)(struct pci_dev *dev,
+	int		(*setup_msi_irqs)(struct pci_dev *pdev,
 					  int nvec, int type);
-	void		(*teardown_msi_irqs)(struct pci_dev *dev);
+	void		(*teardown_msi_irqs)(struct pci_dev *pdev);
 #endif
 
-	int             (*dma_set_mask)(struct pci_dev *dev, u64 dma_mask);
-	u64		(*dma_get_required_mask)(struct pci_dev *dev);
+	int             (*dma_set_mask)(struct pci_dev *pdev, u64 dma_mask);
+	u64		(*dma_get_required_mask)(struct pci_dev *pdev);
 
-	void		(*shutdown)(struct pci_controller *);
+	void		(*shutdown)(struct pci_controller *hose);
 };
 
 /*
-- 
2.1.0
