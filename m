Return-Path: <dja@axtens.net>
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8714E1A06C5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:37:02 +1100 (AEDT)
Received: by pagj7 with SMTP id j7so17260341pag.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 22:37:00 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 17/27] powerpc/pasemi: Move controller ops from ppc_md to
 controller_ops
Date: Wed, 25 Mar 2015 16:35:51 +1100
Message-Id: <1427261761-22952-18-git-send-email-dja@axtens.net>
In-Reply-To: <1427261761-22952-1-git-send-email-dja@axtens.net>
References: <1427261761-22952-1-git-send-email-dja@axtens.net>
Cc: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This moves the PaSemi platform to use the pci_controller_ops
structure rather than ppc_md for PCI controller operations.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/platforms/pasemi/iommu.c  | 6 ++++--
 arch/powerpc/platforms/pasemi/pasemi.h | 1 +
 arch/powerpc/platforms/pasemi/pci.c    | 5 +++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pasemi/iommu.c b/arch/powerpc/platforms/pasemi/iommu.c
index 2e576f2..b8f567b 100644
--- a/arch/powerpc/platforms/pasemi/iommu.c
+++ b/arch/powerpc/platforms/pasemi/iommu.c
@@ -27,6 +27,8 @@
 #include <asm/machdep.h>
 #include <asm/firmware.h>
 
+#include "pasemi.h"
+
 #define IOBMAP_PAGE_SHIFT	12
 #define IOBMAP_PAGE_SIZE	(1 << IOBMAP_PAGE_SHIFT)
 #define IOBMAP_PAGE_MASK	(IOBMAP_PAGE_SIZE - 1)
@@ -248,8 +250,8 @@ void __init iommu_init_early_pasemi(void)
 
 	iob_init(NULL);
 
-	ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_pasemi;
-	ppc_md.pci_dma_bus_setup = pci_dma_bus_setup_pasemi;
+	pasemi_pci_controller_ops.dma_dev_setup = pci_dma_dev_setup_pasemi;
+	pasemi_pci_controller_ops.dma_bus_setup = pci_dma_bus_setup_pasemi;
 	ppc_md.tce_build = iobmap_build;
 	ppc_md.tce_free  = iobmap_free;
 	set_pci_dma_ops(&dma_iommu_ops);
diff --git a/arch/powerpc/platforms/pasemi/pasemi.h b/arch/powerpc/platforms/pasemi/pasemi.h
index ea65bf0..11f230a 100644
--- a/arch/powerpc/platforms/pasemi/pasemi.h
+++ b/arch/powerpc/platforms/pasemi/pasemi.h
@@ -30,5 +30,6 @@ static inline void restore_astate(int cpu)
 }
 #endif
 
+extern struct pci_controller_ops pasemi_pci_controller_ops;
 
 #endif /* _PASEMI_PASEMI_H */
diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
index aa86271..f3a68a0 100644
--- a/arch/powerpc/platforms/pasemi/pci.c
+++ b/arch/powerpc/platforms/pasemi/pci.c
@@ -31,6 +31,8 @@
 
 #include <asm/ppc-pci.h>
 
+#include "pasemi.h"
+
 #define PA_PXP_CFA(bus, devfn, off) (((bus) << 20) | ((devfn) << 12) | (off))
 
 static inline int pa_pxp_offset_valid(u8 bus, u8 devfn, int offset)
@@ -199,6 +201,7 @@ static int __init pas_add_bridge(struct device_node *dev)
 
 	hose->first_busno = 0;
 	hose->last_busno = 0xff;
+	hose->controller_ops = pasemi_pci_controller_ops;
 
 	setup_pa_pxp(hose);
 
@@ -239,3 +242,5 @@ void __iomem *pasemi_pci_getcfgaddr(struct pci_dev *dev, int offset)
 
 	return (void __iomem *)pa_pxp_cfg_addr(hose, dev->bus->number, dev->devfn, offset);
 }
+
+struct pci_controller_ops pasemi_pci_controller_ops;
-- 
2.1.4
