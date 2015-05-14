Return-Path: <B18196@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0130.outbound.protection.outlook.com [157.56.110.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0D3E51A0015
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 02:57:57 +1000 (AEST)
From: Cristian Stoica <cristian.stoica@freescale.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>,
 <kyle@redhat.com>, <horia.geanta@freescale.com>
Subject: [PATCH] powerpc: support sizes greater than an unsigned long
Date: Thu, 14 May 2015 19:24:44 +0300
Message-ID: <1431620684-20123-1-git-send-email-cristian.stoica@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Cristian
 Stoica <cristian.stoica@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use resource_size_t to accommodate sizes greater than the size of an
unsigned long int on platforms that have more than 32 bit
physical addresses

Signed-off-by: Cristian Stoica <cristian.stoica@freescale.com>
---
 arch/powerpc/include/asm/io.h | 14 +++++++-------
 arch/powerpc/mm/pgtable_32.c  | 10 +++++-----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index a8d2ef3..749c66e 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -716,24 +716,24 @@ static inline void iosync(void)
  *   be hooked (but can be used by a hook on iounmap)
  *
  */
-extern void __iomem *ioremap(phys_addr_t address, unsigned long size);
-extern void __iomem *ioremap_prot(phys_addr_t address, unsigned long size,
+extern void __iomem *ioremap(phys_addr_t address, resource_size_t size);
+extern void __iomem *ioremap_prot(phys_addr_t address, resource_size_t size,
 				  unsigned long flags);
-extern void __iomem *ioremap_wc(phys_addr_t address, unsigned long size);
+extern void __iomem *ioremap_wc(phys_addr_t address, resource_size_t size);
 #define ioremap_nocache(addr, size)	ioremap((addr), (size))
 
 extern void iounmap(volatile void __iomem *addr);
 
-extern void __iomem *__ioremap(phys_addr_t, unsigned long size,
+extern void __iomem *__ioremap(phys_addr_t, resource_size_t size,
 			       unsigned long flags);
-extern void __iomem *__ioremap_caller(phys_addr_t, unsigned long size,
+extern void __iomem *__ioremap_caller(phys_addr_t, resource_size_t size,
 				      unsigned long flags, void *caller);
 
 extern void __iounmap(volatile void __iomem *addr);
 
 extern void __iomem * __ioremap_at(phys_addr_t pa, void *ea,
-				   unsigned long size, unsigned long flags);
-extern void __iounmap_at(void *ea, unsigned long size);
+				   resource_size_t size, unsigned long flags);
+extern void __iounmap_at(void *ea, resource_size_t size);
 
 /*
  * When CONFIG_PPC_INDIRECT_PIO is set, we use the generic iomap implementation
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 7692d1b..a7d5137 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -135,7 +135,7 @@ pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
 }
 
 void __iomem *
-ioremap(phys_addr_t addr, unsigned long size)
+ioremap(phys_addr_t addr, resource_size_t size)
 {
 	return __ioremap_caller(addr, size, _PAGE_NO_CACHE | _PAGE_GUARDED,
 				__builtin_return_address(0));
@@ -143,7 +143,7 @@ ioremap(phys_addr_t addr, unsigned long size)
 EXPORT_SYMBOL(ioremap);
 
 void __iomem *
-ioremap_wc(phys_addr_t addr, unsigned long size)
+ioremap_wc(phys_addr_t addr, resource_size_t size)
 {
 	return __ioremap_caller(addr, size, _PAGE_NO_CACHE,
 				__builtin_return_address(0));
@@ -151,7 +151,7 @@ ioremap_wc(phys_addr_t addr, unsigned long size)
 EXPORT_SYMBOL(ioremap_wc);
 
 void __iomem *
-ioremap_prot(phys_addr_t addr, unsigned long size, unsigned long flags)
+ioremap_prot(phys_addr_t addr, resource_size_t size, unsigned long flags)
 {
 	/* writeable implies dirty for kernel addresses */
 	if ((flags & (_PAGE_RW | _PAGE_RO)) != _PAGE_RO)
@@ -173,13 +173,13 @@ ioremap_prot(phys_addr_t addr, unsigned long size, unsigned long flags)
 EXPORT_SYMBOL(ioremap_prot);
 
 void __iomem *
-__ioremap(phys_addr_t addr, unsigned long size, unsigned long flags)
+__ioremap(phys_addr_t addr, resource_size_t size, unsigned long flags)
 {
 	return __ioremap_caller(addr, size, flags, __builtin_return_address(0));
 }
 
 void __iomem *
-__ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
+__ioremap_caller(phys_addr_t addr, resource_size_t size, unsigned long flags,
 		 void *caller)
 {
 	unsigned long v, i;
-- 
2.3.5
