Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 14605DDEB9
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 20:54:34 +1000 (EST)
Date: Wed, 15 Aug 2007 20:54:32 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Fix section mismatch in dart_iommu.c
Message-Id: <20070815205432.e4823a61.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These functions are only called from __init functions.

WARNING: vmlinux.o(.text+0x398f4): Section mismatch: reference to .init.text:.lmb_alloc (between '.iommu_init_early_dart' and '.pci_dma_bus_setup_dart')

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/sysdev/dart_iommu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index a1d2042..e0e24b0 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -204,7 +204,7 @@ static void dart_free(struct iommu_table *tbl, long index, long npages)
 }
 
 
-static int dart_init(struct device_node *dart_node)
+static int __init dart_init(struct device_node *dart_node)
 {
 	unsigned int i;
 	unsigned long tmp, base, size;
@@ -313,7 +313,7 @@ static void pci_dma_bus_setup_dart(struct pci_bus *bus)
 		PCI_DN(dn)->iommu_table = &iommu_table_dart;
 }
 
-void iommu_init_early_dart(void)
+void __init iommu_init_early_dart(void)
 {
 	struct device_node *dn;
 
-- 
1.5.2.4
