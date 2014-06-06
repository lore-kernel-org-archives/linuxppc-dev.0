Return-Path: <kenhelias@web.de>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA39C1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jun 2014 03:47:54 +1000 (EST)
From: Ken Helias <kenhelias@web.de>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 05/13] powerpc: Use list_add_(before|after) macros
Date: Fri,  6 Jun 2014 19:34:24 +0200
Message-Id: <1402076072-4044-5-git-send-email-kenhelias@web.de>
In-Reply-To: <1402076072-4044-1-git-send-email-kenhelias@web.de>
References: <1402076072-4044-1-git-send-email-kenhelias@web.de>
Cc: Ken Helias <kenhelias@firemail.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ken Helias <kenhelias@firemail.de>

Many places in the code uses list_add_tail/list_add to insert an entry
before/after another entry. This confuses the reader because these are usually
used to add an item to a list_head and not an entry. Better use the self
explaining function name.

Signed-off-by: Ken Helias <kenhelias@firemail.de>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/lib/rheap.c          | 2 +-
 arch/powerpc/mm/dma-noncoherent.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/rheap.c b/arch/powerpc/lib/rheap.c
index a1060a8..d8c5f16 100644
--- a/arch/powerpc/lib/rheap.c
+++ b/arch/powerpc/lib/rheap.c
@@ -486,7 +486,7 @@ unsigned long rh_alloc_align(rh_info_t * info, int size, int alignment, const ch
 			spblk->start = blk->start;
 			spblk->size = sp_size;
 			/* add before the blk */
-			list_add(&spblk->list, blk->list.prev);
+			list_add_before(&spblk->list, &blk->list);
 		}
 		newblk = get_slot(info);
 		newblk->start = start;
diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
index d85e86a..222ae97 100644
--- a/arch/powerpc/mm/dma-noncoherent.c
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -120,7 +120,7 @@ ppc_vm_region_alloc(struct ppc_vm_region *head, size_t size, gfp_t gfp)
 	/*
 	 * Insert this entry _before_ the one we found.
 	 */
-	list_add_tail(&new->vm_list, &c->vm_list);
+	list_add_before(&new->vm_list, &c->vm_list);
 	new->vm_start = addr;
 	new->vm_end = addr + size;
 
-- 
2.0.0
