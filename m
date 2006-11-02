Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] spufs: always map local store non-guarded
Date: Thu, 2 Nov 2006 13:46:48 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611021346.49473.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, michaele@au1.ibm.com,
	cbe-oss-dev@ozlabs.org
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

Accessing the real local store memory needs to be cache-inhibited,
in order to maintain data consistency, but since it is actual
RAM, there is no point in a guarded mapping.

Debugged-by: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---

This fixes a regression in 2.6.19, please merge.

Index: linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
@@ -104,11 +104,11 @@ spufs_mem_mmap_nopage(struct vm_area_str
 
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
