Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5C5991A0ABD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 14:28:49 +1000 (AEST)
Received: from mail-pa0-x22e.google.com (mail-pa0-x22e.google.com
 [IPv6:2607:f8b0:400e:c03::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D0B831402A8
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2015 14:28:48 +1000 (AEST)
Received: by pacyx8 with SMTP id yx8so124856163pac.1
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Apr 2015 21:28:47 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org,
	benh@kernel.crashing.org,
	mpe@ellerman.id.au
Subject: [PATCH 10/10] powerpc: Remove MSI-related PCI controller ops from
 ppc_md
Date: Tue, 14 Apr 2015 14:28:03 +1000
Message-Id: <1428985683-24767-11-git-send-email-dja@axtens.net>
In-Reply-To: <1428985683-24767-1-git-send-email-dja@axtens.net>
References: <1428985683-24767-1-git-send-email-dja@axtens.net>
Cc: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove unneeded ppc_md functions. Patch callsites to use pci_controller_ops
functions exclusively.
---
 arch/powerpc/include/asm/machdep.h |  6 ------
 arch/powerpc/kernel/msi.c          | 15 ++++-----------
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index ef889943..0d387d0 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -131,12 +131,6 @@ struct machdep_calls {
 	/* To setup PHBs when using automatic OF platform driver for PCI */
 	int		(*pci_setup_phb)(struct pci_controller *host);
 
-#ifdef CONFIG_PCI_MSI
-	int		(*setup_msi_irqs)(struct pci_dev *dev,
-					  int nvec, int type);
-	void		(*teardown_msi_irqs)(struct pci_dev *dev);
-#endif
-
 	void		(*restart)(char *cmd);
 	void		(*halt)(void);
 	void		(*panic)(char *str);
diff --git a/arch/powerpc/kernel/msi.c b/arch/powerpc/kernel/msi.c
index 3d452f7..dab616a 100644
--- a/arch/powerpc/kernel/msi.c
+++ b/arch/powerpc/kernel/msi.c
@@ -17,9 +17,8 @@ int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
 	struct pci_controller *phb = pci_bus_to_host(dev->bus);
 
-	if ((!phb->controller_ops.setup_msi_irqs ||
-	     !phb->controller_ops.teardown_msi_irqs) &&
-	    (!ppc_md.setup_msi_irqs || !ppc_md.teardown_msi_irqs)) {
+	if (!phb->controller_ops.setup_msi_irqs ||
+	    !phb->controller_ops.teardown_msi_irqs) {
 		pr_debug("msi: Platform doesn't provide MSI callbacks.\n");
 		return -ENOSYS;
 	}
@@ -28,18 +27,12 @@ int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 	if (type == PCI_CAP_ID_MSI && nvec > 1)
 		return 1;
 
-	if (phb->controller_ops.setup_msi_irqs)
-		return phb->controller_ops.setup_msi_irqs(dev, nvec, type);
-	else
-		return ppc_md.setup_msi_irqs(dev, nvec, type);
+	return phb->controller_ops.setup_msi_irqs(dev, nvec, type);
 }
 
 void arch_teardown_msi_irqs(struct pci_dev *dev)
 {
 	struct pci_controller *phb = pci_bus_to_host(dev->bus);
 
-	if (phb->controller_ops.teardown_msi_irqs)
-		phb->controller_ops.teardown_msi_irqs(dev);
-	else
-		ppc_md.teardown_msi_irqs(dev);
+	phb->controller_ops.teardown_msi_irqs(dev);
 }
-- 
2.1.4
