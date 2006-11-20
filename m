Return-Path: <arnd@arndb.de>
Message-Id: <20061120180524.546658000@arndb.de>
References: <20061120174454.067872000@arndb.de>
Date: Mon, 20 Nov 2006 18:45:06 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: [PATCH 12/22] spufs: always map local store non-guarded
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When fixing spufs to map the 'mem' file backing store cacheable,
I incorrectly set the physical mapping to use both cache-inhibited
and guarded mapping, which resulted in a serious performance
degradation.

Debugged-by: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
@@ -105,11 +105,11 @@ spufs_mem_mmap_nopage(struct vm_area_str
 
 	if (ctx->state == SPU_STATE_SAVED) {
 		vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
-					& ~(_PAGE_NO_CACHE | _PAGE_GUARDED));
+							& ~_PAGE_NO_CACHE);
 		page = vmalloc_to_page(ctx->csa.lscsa->ls + offset);
 	} else {
 		vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
-					| _PAGE_NO_CACHE | _PAGE_GUARDED);
+							| _PAGE_NO_CACHE);
 		page = pfn_to_page((ctx->spu->local_store_phys + offset)
 				   >> PAGE_SHIFT);
 	}

--
