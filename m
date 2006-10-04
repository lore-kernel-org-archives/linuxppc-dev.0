Return-Path: <arnd@arndb.de>
Message-Id: <20061004161501.242111000@arndb.de>
References: <20061004152610.151599000@dyn-9-152-242-103.boeblingen.de.ibm.com>
Date: Wed, 04 Oct 2006 17:26:16 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 06/14] spufs: use correct pg_prot for mapping spu LS
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This hopefully fixes a long-standing bug in the spu file system.
An spu context comes with local memory that can be either saved
in kernel pages or point directly to a physical SPE.

When mapping the physical SPE, that mapping needs to be cache-inhibited.
For simplicity, we used to map the kernel backing memory that way
too, but unfortunately that was not only inefficient, but also incorrect
because the same page could then be accessed simultaneously through
a cacheable and a cache-inhibited mapping, which is not allowed
by the powerpc specification and in our case caused data inconsistency
for which we did a really ugly workaround in user space.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
@@ -102,12 +102,16 @@ spufs_mem_mmap_nopage(struct vm_area_str
 
 	spu_acquire(ctx);
 
-	if (ctx->state == SPU_STATE_SAVED)
+	if (ctx->state == SPU_STATE_SAVED) {
+		vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
+					& ~(_PAGE_NO_CACHE | _PAGE_GUARDED));
 		page = vmalloc_to_page(ctx->csa.lscsa->ls + offset);
-	else
+	} else {
+		vma->vm_page_prot = __pgprot(pgprot_val(vma->vm_page_prot)
+					| _PAGE_NO_CACHE | _PAGE_GUARDED);
 		page = pfn_to_page((ctx->spu->local_store_phys + offset)
 				   >> PAGE_SHIFT);
-
+	}
 	spu_release(ctx);
 
 	if (type)

--
