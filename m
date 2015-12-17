Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B63761A106E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 13:48:16 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, gwshan@linux.vnet.ibm.com,
 Alistair Popple <alistair@popple.id.au>
Subject: [PATCH v3 2/3] powerpc: Add __raw_rm_writeq() function
Date: Thu, 17 Dec 2015 13:43:12 +1100
Message-Id: <1450320193-20116-3-git-send-email-alistair@popple.id.au>
In-Reply-To: <1450320193-20116-1-git-send-email-alistair@popple.id.au>
References: <1450320193-20116-1-git-send-email-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move __raw_rw_writeq() from platforms/powernv/pci-ioda.c to
include/asm/io.h so that it can be used by other code.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/include/asm/io.h             | 11 +++++++++++
 arch/powerpc/platforms/powernv/pci-ioda.c | 10 ----------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 5879fde..6c1297e 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -385,6 +385,17 @@ static inline void __raw_writeq(unsigned long v, volatile void __iomem *addr)
 {
 	*(volatile unsigned long __force *)PCI_FIX_ADDR(addr) = v;
 }
+
+/*
+ * Real mode version of the above. stdcix is only supposed to be used
+ * in hypervisor real mode as per the architecture spec.
+ */
+static inline void __raw_rm_writeq(u64 val, volatile void __iomem *paddr)
+{
+	__asm__ __volatile__("stdcix %0,0,%1"
+		: : "r" (val), "r" (paddr) : "memory");
+}
+
 #endif /* __powerpc64__ */
 
 /*
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 42b4bb2..cb04642 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -116,16 +116,6 @@ static int __init iommu_setup(char *str)
 }
 early_param("iommu", iommu_setup);
 
-/*
- * stdcix is only supposed to be used in hypervisor real mode as per
- * the architecture spec
- */
-static inline void __raw_rm_writeq(u64 val, volatile void __iomem *paddr)
-{
-	__asm__ __volatile__("stdcix %0,0,%1"
-		: : "r" (val), "r" (paddr) : "memory");
-}
-
 static inline bool pnv_pci_is_mem_pref_64(unsigned long flags)
 {
 	return ((flags & (IORESOURCE_MEM_64 | IORESOURCE_PREFETCH)) ==
-- 
2.1.4
