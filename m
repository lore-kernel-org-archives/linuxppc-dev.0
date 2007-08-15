Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4E1F7DDEC0
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 20:58:25 +1000 (EST)
Date: Wed, 15 Aug 2007 20:58:23 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Fix section mismatch in pasemi/iommu.c
Message-Id: <20070815205823.b0a04715.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Olof Johansson <olof@lixom.net>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These functions are only called by __init functions.

WARNING: vmlinux.o(.text+0x56aa0): Section mismatch: reference to .init.text:.lmb_alloc (between '.iob_init' and '.iommu_init_early_pasemi')

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/pasemi/iommu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/pasemi/iommu.c b/arch/powerpc/platforms/pasemi/iommu.c
index f33b21b..c910ec9 100644
--- a/arch/powerpc/platforms/pasemi/iommu.c
+++ b/arch/powerpc/platforms/pasemi/iommu.c
@@ -187,7 +187,7 @@ static void pci_dma_dev_setup_pasemi(struct pci_dev *dev)
 static void pci_dma_bus_setup_null(struct pci_bus *b) { }
 static void pci_dma_dev_setup_null(struct pci_dev *d) { }
 
-int iob_init(struct device_node *dn)
+int __init iob_init(struct device_node *dn)
 {
 	unsigned long tmp;
 	u32 regword;
@@ -233,7 +233,7 @@ int iob_init(struct device_node *dn)
 
 
 /* These are called very early. */
-void iommu_init_early_pasemi(void)
+void __init iommu_init_early_pasemi(void)
 {
 	int iommu_off;
 
-- 
1.5.2.4
