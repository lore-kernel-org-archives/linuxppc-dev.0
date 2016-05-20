Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9z0J294jzDqCT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:43:12 +1000 (AEST)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 20 May 2016 16:43:12 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 044753578053
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:43:08 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4K6gx0P7209234
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:43:07 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4K6gYSS032170
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:42:34 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 alistair@popple.id.au, aik@ozlabs.ru,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v10 16/18] powerpc/powernv: Introduce pnv_pci_get_slot_id()
Date: Fri, 20 May 2016 16:41:40 +1000
Message-Id: <1463726502-14679-17-git-send-email-gwshan@linux.vnet.ibm.com>
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

This introduces pnv_pci_get_slot_id() to get the hotpluggable PCI
slot ID from the corresponding device node. It will be used by
hotplug driver.

Requested-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pnv-pci.h   |  2 ++
 arch/powerpc/platforms/powernv/pci.c | 38 ++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
index c607902..810cc9a 100644
--- a/arch/powerpc/include/asm/pnv-pci.h
+++ b/arch/powerpc/include/asm/pnv-pci.h
@@ -17,6 +17,8 @@
 #define PCI_SLOT_ID(phb_id, bdfn)	\
 	(PCI_SLOT_ID_PREFIX | ((uint64_t)(bdfn) << 16) | (phb_id))
 
+extern int pnv_pci_get_slot_id(struct device_node *np, uint64_t *id);
+
 int pnv_phb_to_cxl_mode(struct pci_dev *dev, uint64_t mode);
 int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
 			   unsigned int virq);
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 0f1b8bf..2607d29 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -26,6 +26,7 @@
 #include <asm/machdep.h>
 #include <asm/msi_bitmap.h>
 #include <asm/ppc-pci.h>
+#include <asm/pnv-pci.h>
 #include <asm/opal.h>
 #include <asm/iommu.h>
 #include <asm/tce.h>
@@ -36,6 +37,43 @@
 #include "powernv.h"
 #include "pci.h"
 
+int pnv_pci_get_slot_id(struct device_node *np, uint64_t *id)
+{
+	struct device_node *parent = np;
+	u32 bdfn;
+	u64 phbid;
+	int ret;
+
+	ret = of_property_read_u32(np, "reg", &bdfn);
+	if (ret)
+		return -ENXIO;
+
+	bdfn = ((bdfn & 0x00ffff00) >> 8);
+	while ((parent = of_get_parent(parent))) {
+		if (!PCI_DN(parent)) {
+			of_node_put(parent);
+			break;
+		}
+
+		if (!of_device_is_compatible(parent, "ibm,ioda2-phb")) {
+			of_node_put(parent);
+			continue;
+		}
+
+		ret = of_property_read_u64(parent, "ibm,opal-phbid", &phbid);
+		if (ret) {
+			of_node_put(parent);
+			return -ENXIO;
+		}
+
+		*id = PCI_SLOT_ID(phbid, bdfn);
+		return 0;
+	}
+
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(pnv_pci_get_slot_id);
+
 #ifdef CONFIG_PCI_MSI
 int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 {
-- 
2.1.0
