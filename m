Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryQsy3gNfzDqWt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 12:57:58 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 2/3] powerpc/mm: Rename hpte_init_lpar() & put fallback in a
 header
Date: Mon, 25 Jul 2016 12:57:50 +1000
Message-Id: <1469415471-2476-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1469415471-2476-1-git-send-email-mpe@ellerman.id.au>
References: <1469415471-2476-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hpte_init_lpar() is part of the pseries platform, so name it as such.
Provide the fallback implementation in a header, rather than using a
weak function.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 10 +++++++++-
 arch/powerpc/mm/hash_utils_64.c               |  7 +------
 arch/powerpc/platforms/pseries/lpar.c         |  2 +-
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 45dfa2e4f0d1..23cff86aa779 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -400,7 +400,15 @@ static inline void hpte_init_native(void)
 }
 #endif
 
-extern void hpte_init_lpar(void);
+#ifdef CONFIG_PPC_PSERIES
+void hpte_init_pseries(void);
+#else
+static inline void hpte_init_pseries(void)
+{
+	panic("hpte_init_pseries: No LPAR hash table support compiled in!\n");
+}
+#endif
+
 extern void hpte_init_beat(void);
 extern void hpte_init_beat_v3(void);
 
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 341632471b9d..92043204363c 100644
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
 	else
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
