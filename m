Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rz3kX3cf2zDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 13:38:44 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v2 2/2] powerpc/mm: Rename hpte_init_lpar() and move the
 fallback to a header
Date: Tue, 26 Jul 2016 13:38:38 +1000
Message-Id: <1469504318-9461-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1469504318-9461-1-git-send-email-mpe@ellerman.id.au>
References: <1469504318-9461-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hpte_init_lpar() is part of the pseries platform, so name it as such.

Move the fallback implementation for when PSERIES=n into the header,
dropping the weak implementation. The panic() is now handled by the
calling code.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 7 ++++++-
 arch/powerpc/mm/hash_utils_64.c               | 7 +------
 arch/powerpc/platforms/pseries/lpar.c         | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index b0f4dffe12ae..450b017fdc19 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -391,8 +391,13 @@ int htab_remove_mapping(unsigned long vstart, unsigned long vend,
 extern void add_gpage(u64 addr, u64 page_size, unsigned long number_of_pages);
 extern void demote_segment_4k(struct mm_struct *mm, unsigned long addr);
 
+#ifdef CONFIG_PPC_PSERIES
+void hpte_init_pseries(void);
+#else
+static inline void hpte_init_pseries(void) { }
+#endif
+
 extern void hpte_init_native(void);
-extern void hpte_init_lpar(void);
 extern void hpte_init_beat(void);
 extern void hpte_init_beat_v3(void);
 
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 381b5894cc99..1ff11c1bb182 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -885,11 +885,6 @@ static void __init htab_initialize(void)
 #undef KB
 #undef MB
 
-void __init __weak hpte_init_lpar(void)
-{
-	panic("FW_FEATURE_LPAR set but no LPAR support compiled\n");
-}
-
 void __init hash__early_init_mmu(void)
 {
 	/*
@@ -930,7 +925,7 @@ void __init hash__early_init_mmu(void)
 	if (firmware_has_feature(FW_FEATURE_PS3_LV1))
 		ps3_early_mm_init();
 	else if (firmware_has_feature(FW_FEATURE_LPAR))
-		hpte_init_lpar();
+		hpte_init_pseries();
 	else if IS_ENABLED(CONFIG_PPC_NATIVE)
 		hpte_init_native();
 
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 0e91388d0af9..86707e67843f 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -589,7 +589,7 @@ static int __init disable_bulk_remove(char *str)
 
 __setup("bulk_remove=", disable_bulk_remove);
 
-void __init hpte_init_lpar(void)
+void __init hpte_init_pseries(void)
 {
 	mmu_hash_ops.hpte_invalidate	 = pSeries_lpar_hpte_invalidate;
 	mmu_hash_ops.hpte_updatepp	 = pSeries_lpar_hpte_updatepp;
-- 
2.7.4
