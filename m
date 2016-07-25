Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryQsx42tDzDqWt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 12:57:57 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 1/3] powerpc/mm: Fix build break due when PPC_NATIVE=n
Date: Mon, 25 Jul 2016 12:57:49 +1000
Message-Id: <1469415471-2476-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The recent commit to rework the hash MMU setup broke the build when
CONFIG_PPC_NATIVE=n. Fix it by providing a fallback implementation of
hpte_init_native().

Fixes: 166dd7d3fbf2 ("powerpc/64: Move MMU backend selection out of platform code")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index b0f4dffe12ae..45dfa2e4f0d1 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -391,7 +391,15 @@ int htab_remove_mapping(unsigned long vstart, unsigned long vend,
 extern void add_gpage(u64 addr, u64 page_size, unsigned long number_of_pages);
 extern void demote_segment_4k(struct mm_struct *mm, unsigned long addr);
 
-extern void hpte_init_native(void);
+#ifdef CONFIG_PPC_NATIVE
+void hpte_init_native(void);
+#else
+static inline void hpte_init_native(void)
+{
+	panic("hpte_init_native: No noative hash table support compiled in!\n");
+}
+#endif
+
 extern void hpte_init_lpar(void);
 extern void hpte_init_beat(void);
 extern void hpte_init_beat_v3(void);
-- 
2.7.4
