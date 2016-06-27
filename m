Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdRYX10btzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 21:29:51 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 02/38] drm: Fix broken use of _PAGE_NO_CACHE on powerpc
Date: Mon, 27 Jun 2016 21:29:00 +1000
Message-Id: <1467026976-7974-3-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
References: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

That constant no longer exist. Use the proper accessor instead

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/gpu/drm/drm_memory.c  | 2 +-
 drivers/gpu/drm/drm_scatter.c | 2 +-
 drivers/gpu/drm/drm_vm.c      | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_memory.c b/drivers/gpu/drm/drm_memory.c
index 87a8cb7..fc0ebd2 100644
--- a/drivers/gpu/drm/drm_memory.c
+++ b/drivers/gpu/drm/drm_memory.c
@@ -44,7 +44,7 @@
 # include <asm/agp.h>
 #else
 # ifdef __powerpc__
-#  define PAGE_AGP	__pgprot(_PAGE_KERNEL | _PAGE_NO_CACHE)
+#  define PAGE_AGP	pgprot_noncached_wc(PAGE_KERNEL)
 # else
 #  define PAGE_AGP	PAGE_KERNEL
 # endif
diff --git a/drivers/gpu/drm/drm_scatter.c b/drivers/gpu/drm/drm_scatter.c
index 4f0f3b3..bf70431 100644
--- a/drivers/gpu/drm/drm_scatter.c
+++ b/drivers/gpu/drm/drm_scatter.c
@@ -41,7 +41,7 @@
 static inline void *drm_vmalloc_dma(unsigned long size)
 {
 #if defined(__powerpc__) && defined(CONFIG_NOT_COHERENT_CACHE)
-	return __vmalloc(size, GFP_KERNEL, PAGE_KERNEL | _PAGE_NO_CACHE);
+	return __vmalloc(size, GFP_KERNEL, pgprot_noncached_wc(PAGE_KERNEL));
 #else
 	return vmalloc_32(size);
 #endif
diff --git a/drivers/gpu/drm/drm_vm.c b/drivers/gpu/drm/drm_vm.c
index ac9f4b3..7e9f642 100644
--- a/drivers/gpu/drm/drm_vm.c
+++ b/drivers/gpu/drm/drm_vm.c
@@ -80,7 +80,7 @@ static pgprot_t drm_dma_prot(uint32_t map_type, struct vm_area_struct *vma)
 	pgprot_t tmp = vm_get_page_prot(vma->vm_flags);
 
 #if defined(__powerpc__) && defined(CONFIG_NOT_COHERENT_CACHE)
-	tmp |= _PAGE_NO_CACHE;
+	tmp = pgprot_noncached_wc(tmp);
 #endif
 	return tmp;
 }
@@ -593,7 +593,7 @@ static int drm_mmap_locked(struct file *filp, struct vm_area_struct *vma)
 			 * pages and mappings in fault()
 			 */
 #if defined(__powerpc__)
-			pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE;
+			vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 #endif
 			vma->vm_ops = &drm_vm_ops;
 			break;
-- 
2.7.4
