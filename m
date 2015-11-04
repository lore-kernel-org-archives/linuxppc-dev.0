Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8FACF1A0BF2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:13:47 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 23:13:45 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id CD65E2BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:13:42 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4DDYX432047218
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 00:13:42 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4DD9DM009658
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 00:13:10 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 03/50] powerpc/pci: Cleanup on struct pci_controller_ops
Date: Thu,  5 Nov 2015 00:12:03 +1100
Message-Id: <1446642770-4681-4-git-send-email-gwshan@linux.vnet.ibm.com>
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

Each PHB has one instance of "struct pci_controller_ops", which
includes various callbacks called by PCI subsystem. In the definition
of this struct, some callbacks have explicit names for its arguments,
but the left don't have.

This adds all explicit names of the arguments to the callbacks in
"struct pci_controller_ops" so that the code looks consistent.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 6076116..0f2ff3a 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -21,18 +21,19 @@ struct pci_controller_ops {
 	void		(*dma_dev_setup)(struct pci_dev *dev);
 	void		(*dma_bus_setup)(struct pci_bus *bus);
 
-	int		(*probe_mode)(struct pci_bus *);
+	int		(*probe_mode)(struct pci_bus *bus);
 
 	/* Called when pci_enable_device() is called. Returns true to
 	 * allow assignment/enabling of the device. */
-	bool		(*enable_device_hook)(struct pci_dev *);
+	bool		(*enable_device_hook)(struct pci_dev *dev);
 
-	void		(*disable_device)(struct pci_dev *);
+	void		(*disable_device)(struct pci_dev *dev);
 
-	void		(*release_device)(struct pci_dev *);
+	void		(*release_device)(struct pci_dev *dev);
 
 	/* Called during PCI resource reassignment */
-	resource_size_t (*window_alignment)(struct pci_bus *, unsigned long type);
+	resource_size_t (*window_alignment)(struct pci_bus *bus,
+					    unsigned long type);
 	void		(*setup_bridge)(struct pci_bus *bus,
 					unsigned long type);
 	void		(*reset_secondary_bus)(struct pci_dev *dev);
@@ -46,7 +47,7 @@ struct pci_controller_ops {
 	int             (*dma_set_mask)(struct pci_dev *dev, u64 dma_mask);
 	u64		(*dma_get_required_mask)(struct pci_dev *dev);
 
-	void		(*shutdown)(struct pci_controller *);
+	void		(*shutdown)(struct pci_controller *hose);
 };
 
 /*
-- 
2.1.0
