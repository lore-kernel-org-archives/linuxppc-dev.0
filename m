Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzxtm5dZfzDrLR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 00:18:56 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 aneesh.kumar@linux.vnet.ibm.com, haokexin@gmail.com
Subject: [PATCH v3 19/21] powerpc: Add option to use jump label for
 mmu_has_feature()
Date: Thu, 28 Jul 2016 00:18:15 +1000
Message-Id: <1469629097-30859-19-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
References: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Kevin Hao <haokexin@gmail.com>

As we just did for CPU features.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/mmu.h    | 36 ++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/cputable.c    | 17 +++++++++++++++++
 arch/powerpc/lib/feature-fixups.c |  1 +
 3 files changed, 54 insertions(+)

v3: Rename to mmu_feature_keys, and NUM_MMU_FTR_KEYS.
    Use the kconfig.

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index e3eff365e55d..3900cb7fe7cf 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -140,6 +140,41 @@ static inline bool __mmu_has_feature(unsigned long feature)
 	return !!(MMU_FTRS_POSSIBLE & cur_cpu_spec->mmu_features & feature);
 }
 
+#ifdef CONFIG_JUMP_LABEL_FEATURE_CHECKS
+#include <linux/jump_label.h>
+
+#define NUM_MMU_FTR_KEYS	32
+
+extern struct static_key_true mmu_feature_keys[NUM_MMU_FTR_KEYS];
+
+extern void mmu_feature_keys_init(void);
+
+static __always_inline bool mmu_has_feature(unsigned long feature)
+{
+	int i;
+
+	if (!(MMU_FTRS_POSSIBLE & feature))
+		return false;
+
+	i = __builtin_ctzl(feature);
+	return static_branch_likely(&mmu_feature_keys[i]);
+}
+
+static inline void mmu_clear_feature(unsigned long feature)
+{
+	int i;
+
+	i = __builtin_ctzl(feature);
+	cur_cpu_spec->mmu_features &= ~feature;
+	static_branch_disable(&mmu_feature_keys[i]);
+}
+#else
+
+static inline void mmu_feature_keys_init(void)
+{
+
+}
+
 static inline bool mmu_has_feature(unsigned long feature)
 {
 	return __mmu_has_feature(feature);
@@ -149,6 +184,7 @@ static inline void mmu_clear_feature(unsigned long feature)
 {
 	cur_cpu_spec->mmu_features &= ~feature;
 }
+#endif /* CONFIG_JUMP_LABEL */
 
 extern unsigned int __start___mmu_ftr_fixup, __stop___mmu_ftr_fixup;
 
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index f268850f8fda..db14efc7d3e0 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -2243,4 +2243,21 @@ void __init cpu_feature_keys_init(void)
 			static_branch_disable(&cpu_feature_keys[i]);
 	}
 }
+
+struct static_key_true mmu_feature_keys[NUM_MMU_FTR_KEYS] = {
+			[0 ... NUM_MMU_FTR_KEYS - 1] = STATIC_KEY_TRUE_INIT
+};
+EXPORT_SYMBOL_GPL(mmu_feature_keys);
+
+void __init mmu_feature_keys_init(void)
+{
+	int i;
+
+	for (i = 0; i < NUM_MMU_FTR_KEYS; i++) {
+		unsigned long f = 1ul << i;
+
+		if (!(cur_cpu_spec->mmu_features & f))
+			static_branch_disable(&mmu_feature_keys[i]);
+	}
+}
 #endif
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index f90423faade0..8db370cec547 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -196,6 +196,7 @@ void __init apply_feature_fixups(void)
 	 */
 	jump_label_init();
 	cpu_feature_keys_init();
+	mmu_feature_keys_init();
 }
 
 static int __init check_features(void)
-- 
2.7.4
