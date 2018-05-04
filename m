Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40crzp00V5zDqlJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 22:34:13 +1000 (AEST)
Message-Id: <457781f2de403852ba2a60257c3d9aca75c4d2c8.1525435203.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1525435203.git.christophe.leroy@c-s.fr>
References: <cover.1525435203.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH  09/17] powerpc: make __ioremap_caller() common to PPC32 and
 PPC64
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  4 May 2018 14:34:08 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h |   1 +
 arch/powerpc/mm/ioremap.c                    | 126 +++++++--------------------
 2 files changed, 34 insertions(+), 93 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index c5c6ead06bfb..2bebdd8302cb 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -18,6 +18,7 @@
 #define _PAGE_RO		0
 #define _PAGE_USER		0
 #define _PAGE_HWWRITE		0
+#define _PAGE_COHERENT		0
 
 #define _PAGE_EXEC		0x00001 /* execute permission */
 #define _PAGE_WRITE		0x00002 /* write access allowed */
diff --git a/arch/powerpc/mm/ioremap.c b/arch/powerpc/mm/ioremap.c
index 65d611d44d38..59be5dfcb3e9 100644
--- a/arch/powerpc/mm/ioremap.c
+++ b/arch/powerpc/mm/ioremap.c
@@ -33,95 +33,6 @@ unsigned long ioremap_bot;
 unsigned long ioremap_bot = IOREMAP_BASE;
 #endif
 
-#ifdef CONFIG_PPC32
-
-void __iomem *
-__ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
-		 void *caller)
-{
-	unsigned long v, i;
-	phys_addr_t p;
-	int err;
-
-	/* Make sure we have the base flags */
-	if ((flags & _PAGE_PRESENT) == 0)
-		flags |= pgprot_val(PAGE_KERNEL);
-
-	/* Non-cacheable page cannot be coherent */
-	if (flags & _PAGE_NO_CACHE)
-		flags &= ~_PAGE_COHERENT;
-
-	/*
-	 * Choose an address to map it to.
-	 * Once the vmalloc system is running, we use it.
-	 * Before then, we use space going up from IOREMAP_BASE
-	 * (ioremap_bot records where we're up to).
-	 */
-	p = addr & PAGE_MASK;
-	size = PAGE_ALIGN(addr + size) - p;
-
-	/*
-	 * If the address lies within the first 16 MB, assume it's in ISA
-	 * memory space
-	 */
-	if (p < 16*1024*1024)
-		p += _ISA_MEM_BASE;
-
-#ifndef CONFIG_CRASH_DUMP
-	/*
-	 * Don't allow anybody to remap normal RAM that we're using.
-	 * mem_init() sets high_memory so only do the check after that.
-	 */
-	if (slab_is_available() && (p < virt_to_phys(high_memory)) &&
-	    page_is_ram(__phys_to_pfn(p))) {
-		printk("__ioremap(): phys addr 0x%llx is RAM lr %ps\n",
-		       (unsigned long long)p, __builtin_return_address(0));
-		return NULL;
-	}
-#endif
-
-	if (size == 0)
-		return NULL;
-
-	/*
-	 * Is it already mapped?  Perhaps overlapped by a previous
-	 * mapping.
-	 */
-	v = p_block_mapped(p);
-	if (v)
-		goto out;
-
-	if (slab_is_available()) {
-		struct vm_struct *area;
-		area = get_vm_area_caller(size, VM_IOREMAP, caller);
-		if (area == 0)
-			return NULL;
-		area->phys_addr = p;
-		v = (unsigned long) area->addr;
-	} else {
-		v = ioremap_bot;
-		ioremap_bot += size;
-	}
-
-	/*
-	 * Should check if it is a candidate for a BAT mapping
-	 */
-
-	err = 0;
-	for (i = 0; i < size && err == 0; i += PAGE_SIZE)
-		err = map_kernel_page(v+i, p+i, flags);
-	if (err) {
-		if (slab_is_available())
-			vunmap((void *)v);
-		return NULL;
-	}
-
-out:
-	return (void __iomem *) (v + ((unsigned long)addr & ~PAGE_MASK));
-}
-
-#else
-
 /**
  * __ioremap_at - Low level function to establish the page tables
  *                for an IO mapping
@@ -135,6 +46,10 @@ void __iomem * __ioremap_at(phys_addr_t pa, void *ea, unsigned long size,
 	if ((flags & _PAGE_PRESENT) == 0)
 		flags |= pgprot_val(PAGE_KERNEL);
 
+	/* Non-cacheable page cannot be coherent */
+	if (flags & _PAGE_NO_CACHE)
+		flags &= ~_PAGE_COHERENT;
+
 	/* We don't support the 4K PFN hack with ioremap */
 	if (flags & H_PAGE_4K_PFN)
 		return NULL;
@@ -187,6 +102,33 @@ void __iomem * __ioremap_caller(phys_addr_t addr, unsigned long size,
 	if ((size == 0) || (paligned == 0))
 		return NULL;
 
+	/*
+	 * If the address lies within the first 16 MB, assume it's in ISA
+	 * memory space
+	 */
+	if (IS_ENABLED(CONFIG_PPC32) && paligned < 16*1024*1024)
+		paligned += _ISA_MEM_BASE;
+
+	/*
+	 * Don't allow anybody to remap normal RAM that we're using.
+	 * mem_init() sets high_memory so only do the check after that.
+	 */
+	if (!IS_ENABLED(CONFIG_CRASH_DUMP) &&
+	    slab_is_available() && (paligned < virt_to_phys(high_memory)) &&
+	    page_is_ram(__phys_to_pfn(paligned))) {
+		printk("__ioremap(): phys addr 0x%llx is RAM lr %ps\n",
+		       (u64)paligned, __builtin_return_address(0));
+		return NULL;
+	}
+
+	/*
+	 * Is it already mapped?  Perhaps overlapped by a previous
+	 * mapping.
+	 */
+	ret = (void __iomem *)p_block_mapped(paligned);
+	if (ret)
+		goto out;
+
 	if (slab_is_available()) {
 		struct vm_struct *area;
 
@@ -205,14 +147,12 @@ void __iomem * __ioremap_caller(phys_addr_t addr, unsigned long size,
 		if (ret)
 			ioremap_bot += size;
 	}
-
+out:
 	if (ret)
-		ret += addr & ~PAGE_MASK;
+		ret += (unsigned long)addr & ~PAGE_MASK;
 	return ret;
 }
 
-#endif
-
 /*
  * Unmap an IO region and remove it from imalloc'd list.
  * Access to IO memory should be serialized by driver.
-- 
2.13.3
