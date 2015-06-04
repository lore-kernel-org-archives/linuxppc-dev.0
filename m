Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 619831A0BC2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:43:49 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 4 Jun 2015 16:43:48 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B54BA2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:43:45 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t546hbIM43909244
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:45 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t546hCre014051
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:13 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, bhelgaas@google.com, aik@ozlabs.ru,
 panto@antoniou-consulting.com, robherring2@gmail.com,
 grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>
Subject: [PATCH v5 12/42] powerpc/pci: Cleanup on pci_controller_ops
Date: Thu,  4 Jun 2015 16:41:41 +1000
Message-Id: <1433400131-18429-13-git-send-email-gwshan@linux.vnet.ibm.com>
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

Each PHB maintains one instance of "struct pci_controller_ops",
which includes various callbacks called by PCI subsystem. In the
definition of this struct, some callbacks have explicit names for
its arguments, but the left don't have.

The patch removes all explicit names of the arguments to the
callbacks in "struct pci_controller_ops" to keep the code look
consistent.

Cc: Daniel Axtens <dja@axtens.net>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v5:
  * Newly introduced
---
 arch/powerpc/include/asm/pci-bridge.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 744884b..1252cd5 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -18,8 +18,8 @@ struct device_node;
  * PCI controller operations
  */
 struct pci_controller_ops {
-	void		(*dma_dev_setup)(struct pci_dev *dev);
-	void		(*dma_bus_setup)(struct pci_bus *bus);
+	void		(*dma_dev_setup)(struct pci_dev *);
+	void		(*dma_bus_setup)(struct pci_bus *);
 
 	int		(*probe_mode)(struct pci_bus *);
 
@@ -28,8 +28,8 @@ struct pci_controller_ops {
 	bool		(*enable_device_hook)(struct pci_dev *);
 
 	/* Called during PCI resource reassignment */
-	resource_size_t (*window_alignment)(struct pci_bus *, unsigned long type);
-	void		(*reset_secondary_bus)(struct pci_dev *dev);
+	resource_size_t (*window_alignment)(struct pci_bus *, unsigned long);
+	void		(*reset_secondary_bus)(struct pci_dev *);
 };
 
 /*
-- 
2.1.0
