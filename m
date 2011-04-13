Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <cf6ebe6b06b7474d09bafb4f6d7e8140520bfef0.1302670946.git.michael@ellerman.id.au>
In-Reply-To: <d143d3f1ea9830a0f2ef7b0cf7148dab2bf0cc14.1302670946.git.michael@ellerman.id.au>
References: <d143d3f1ea9830a0f2ef7b0cf7148dab2bf0cc14.1302670946.git.michael@ellerman.id.au>
Subject: [PATCH 2/2] powerpc: Fix slice state initialization for Book3E
Date: Wed, 13 Apr 2011 15:00:05 +1000 (EST)
From: michael@ozlabs.org (Michael Ellerman)
Cc: David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Book3E, MMU_NO_CONTEXT != 0, but the slice_mm_new_context()
macro assumes that it is.  This means that the map of the
page sizes for each slice is always initialized to zeroes
(which happens to be 4k pages), rather than to the correct
default base page size value - which might be 64k.

This patch corrects the problem.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/page_64.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/page_64.h b/arch/powerpc/include/asm/page_64.h
index 932f88d..1cc558c 100644
--- a/arch/powerpc/include/asm/page_64.h
+++ b/arch/powerpc/include/asm/page_64.h
@@ -130,7 +130,7 @@ extern void slice_set_user_psize(struct mm_struct *mm, unsigned int psize);
 extern void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
 				  unsigned long len, unsigned int psize);
 
-#define slice_mm_new_context(mm)	((mm)->context.id == 0)
+#define slice_mm_new_context(mm)	((mm)->context.id == MMU_NO_CONTEXT)
 
 #endif /* __ASSEMBLY__ */
 #else
-- 
1.7.1
