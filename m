Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E99831A0176
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 14:28:20 +1000 (AEST)
Received: from mail-pd0-x22a.google.com (mail-pd0-x22a.google.com
 [IPv6:2607:f8b0:400e:c02::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6811B1402A8
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2015 14:28:20 +1000 (AEST)
Received: by pdea3 with SMTP id a3so130489648pde.3
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Apr 2015 21:28:18 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org,
	benh@kernel.crashing.org,
	mpe@ellerman.id.au
Subject: [PATCH 01/10] powerpc: Add MSI operations to pci_controller_ops struct
Date: Tue, 14 Apr 2015 14:27:54 +1000
Message-Id: <1428985683-24767-2-git-send-email-dja@axtens.net>
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

Add MSI setup and teardown functions to pci_controller_ops.

Patch the callsites (arch_{setup,teardown}_msi_irqs) to prefer the
controller ops version if it's available.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/include/asm/pci-bridge.h |  6 ++++++
 arch/powerpc/kernel/msi.c             | 18 +++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 1811c44..a3b6252 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -30,6 +30,12 @@ struct pci_controller_ops {
 	/* Called during PCI resource reassignment */
 	resource_size_t (*window_alignment)(struct pci_bus *, unsigned long type);
 	void		(*reset_secondary_bus)(struct pci_dev *dev);
+
+#ifdef CONFIG_PCI_MSI
+	int		(*setup_msi_irqs)(struct pci_dev *dev,
+					  int nvec, int type);
+	void		(*teardown_msi_irqs)(struct pci_dev *dev);
+#endif
 };
 
 /*
diff --git a/arch/powerpc/kernel/msi.c b/arch/powerpc/kernel/msi.c
index 71bd161..3d452f7 100644
--- a/arch/powerpc/kernel/msi.c
+++ b/arch/powerpc/kernel/msi.c
@@ -15,7 +15,11 @@
 
 int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
-	if (!ppc_md.setup_msi_irqs || !ppc_md.teardown_msi_irqs) {
+	struct pci_controller *phb = pci_bus_to_host(dev->bus);
+
+	if ((!phb->controller_ops.setup_msi_irqs ||
+	     !phb->controller_ops.teardown_msi_irqs) &&
+	    (!ppc_md.setup_msi_irqs || !ppc_md.teardown_msi_irqs)) {
 		pr_debug("msi: Platform doesn't provide MSI callbacks.\n");
 		return -ENOSYS;
 	}
@@ -24,10 +28,18 @@ int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 	if (type == PCI_CAP_ID_MSI && nvec > 1)
 		return 1;
 
-	return ppc_md.setup_msi_irqs(dev, nvec, type);
+	if (phb->controller_ops.setup_msi_irqs)
+		return phb->controller_ops.setup_msi_irqs(dev, nvec, type);
+	else
+		return ppc_md.setup_msi_irqs(dev, nvec, type);
 }
 
 void arch_teardown_msi_irqs(struct pci_dev *dev)
 {
-	ppc_md.teardown_msi_irqs(dev);
+	struct pci_controller *phb = pci_bus_to_host(dev->bus);
+
+	if (phb->controller_ops.teardown_msi_irqs)
+		phb->controller_ops.teardown_msi_irqs(dev);
+	else
+		ppc_md.teardown_msi_irqs(dev);
 }
-- 
2.1.4
