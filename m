Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zM1pR2yL9zF0Wx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 20:22:55 +1100 (AEDT)
Message-Id: <d58db76251497ba882658c0f2c7e3ea8b9081c14.1516179904.git.christophe.leroy@c-s.fr>
In-Reply-To: <49148d07955d3e5f963cedf9adcfcc37c3e03ef4.1516179904.git.christophe.leroy@c-s.fr>
References: <49148d07955d3e5f963cedf9adcfcc37c3e03ef4.1516179904.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 4/5] powerpc/8xx: Increase the number of mm slices
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 17 Jan 2018 10:22:46 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On the 8xx, we can have as many slices as PMD entries.
This means we could have 1024 slices in 4k size pages mode
and 64 slices in 16k size pages.

However, due to a stack overflow in slice_get_unmapped_area(),
we limit to 512 slices.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: no change

 arch/powerpc/include/asm/mmu-8xx.h | 6 +++++-
 arch/powerpc/include/asm/page_32.h | 3 ++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu-8xx.h b/arch/powerpc/include/asm/mmu-8xx.h
index d669d0062da4..40aa7b0cd0dc 100644
--- a/arch/powerpc/include/asm/mmu-8xx.h
+++ b/arch/powerpc/include/asm/mmu-8xx.h
@@ -171,7 +171,11 @@ typedef struct {
 	unsigned long vdso_base;
 #ifdef CONFIG_PPC_MM_SLICES
 	u16 user_psize;		/* page size index */
-	unsigned char low_slices_psize[8]; /* 16 slices */
+#if defined(CONFIG_PPC_16K_PAGES)
+	unsigned char low_slices_psize[32]; /* 64 slices */
+#else
+	unsigned char low_slices_psize[256]; /* 512 slices */
+#endif
 	unsigned char high_slices_psize[0];
 	unsigned long slb_addr_limit;
 #endif
diff --git a/arch/powerpc/include/asm/page_32.h b/arch/powerpc/include/asm/page_32.h
index f7d1bd1183c8..43695ce7ee07 100644
--- a/arch/powerpc/include/asm/page_32.h
+++ b/arch/powerpc/include/asm/page_32.h
@@ -62,7 +62,8 @@ extern void copy_page(void *to, void *from);
 
 #ifdef CONFIG_PPC_MM_SLICES
 
-#define SLICE_LOW_SHIFT		28
+/* SLICE_LOW_SHIFT >= 23 to avoid stack overflow in slice_get_unmapped_area() */
+#define SLICE_LOW_SHIFT		(PMD_SHIFT > 23 ? PMD_SHIFT : 23)
 #define SLICE_HIGH_SHIFT	0
 
 #define SLICE_LOW_TOP		(0xfffffffful)
-- 
2.13.3
