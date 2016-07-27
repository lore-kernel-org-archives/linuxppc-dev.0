Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzxtm121WzDrLK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 00:18:56 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 aneesh.kumar@linux.vnet.ibm.com, haokexin@gmail.com
Subject: [PATCH v3 18/21] powerpc: Add option to use jump label for
 cpu_has_feature()
Date: Thu, 28 Jul 2016 00:18:14 +1000
Message-Id: <1469629097-30859-18-git-send-email-mpe@ellerman.id.au>
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

We do binary patching of asm code using CPU features, which is a
one-time operation, done during early boot. However checks of CPU
features in C code are currently done at run time, even though the set
of CPU features can never change after boot.

We can optimise this by using jump labels to implement cpu_has_feature(),
meaning checks in C code are binary patched into a single nop or branch.

For a C sequence along the lines of:

    if (cpu_has_feature(FOO))
         return 2;

The generated code before is roughly:

    ld      r9,-27640(r2)
    ld      r9,0(r9)
    lwz     r9,32(r9)
    cmpwi   cr7,r9,0
    bge     cr7, 1f
    li      r3,2
    blr
1:  ...

After (true):
    nop
    li      r3,2
    blr

After (false):
    b	1f
    li      r3,2
    blr
1:  ...

Signed-off-by: Kevin Hao <haokexin@gmail.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/cpu_has_feature.h | 22 ++++++++++++++++++++++
 arch/powerpc/include/asm/cputable.h        |  6 ++++++
 arch/powerpc/kernel/cputable.c             | 20 ++++++++++++++++++++
 arch/powerpc/lib/feature-fixups.c          |  1 +
 4 files changed, 49 insertions(+)

v3: Rename MAX_CPU_FEATURES as we already have a #define with that name.
    Define NUM_CPU_FTR_KEYS as a constant.
    Rename the array to cpu_feature_keys.
    Use the kconfig we added to guard it.
    Rewrite the change log.

diff --git a/arch/powerpc/include/asm/cpu_has_feature.h b/arch/powerpc/include/asm/cpu_has_feature.h
index ad296b2f1d84..18e60e61bea9 100644
--- a/arch/powerpc/include/asm/cpu_has_feature.h
+++ b/arch/powerpc/include/asm/cpu_has_feature.h
@@ -11,10 +11,32 @@ static inline bool __cpu_has_feature(unsigned long feature)
 		  (CPU_FTRS_POSSIBLE & cur_cpu_spec->cpu_features & feature));
 }
 
+#ifdef CONFIG_JUMP_LABEL_FEATURE_CHECKS
+#include <linux/jump_label.h>
+
+#define NUM_CPU_FTR_KEYS	64
+
+extern struct static_key_true cpu_feature_keys[NUM_CPU_FTR_KEYS];
+
+static __always_inline bool cpu_has_feature(unsigned long feature)
+{
+	int i;
+
+	if (CPU_FTRS_ALWAYS & feature)
+		return true;
+
+	if (!(CPU_FTRS_POSSIBLE & feature))
+		return false;
+
+	i = __builtin_ctzl(feature);
+	return static_branch_likely(&cpu_feature_keys[i]);
+}
+#else
 static inline bool cpu_has_feature(unsigned long feature)
 {
 	return __cpu_has_feature(feature);
 }
+#endif
 
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_POWERPC_CPUFEATURE_H */
diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 92961bcfbe3f..f23aa3450bca 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -123,6 +123,12 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 
 extern const char *powerpc_base_platform;
 
+#ifdef CONFIG_JUMP_LABEL
+extern void cpu_feature_keys_init(void);
+#else
+static inline void cpu_feature_keys_init(void) { }
+#endif
+
 /* TLB flush actions. Used as argument to cpu_spec.flush_tlb() hook */
 enum {
 	TLB_INVAL_SCOPE_GLOBAL = 0,	/* invalidate all TLBs */
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index d81f826d1029..f268850f8fda 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -15,6 +15,7 @@
 #include <linux/threads.h>
 #include <linux/init.h>
 #include <linux/export.h>
+#include <linux/jump_label.h>
 
 #include <asm/oprofile_impl.h>
 #include <asm/cputable.h>
@@ -2224,3 +2225,22 @@ struct cpu_spec * __init identify_cpu(unsigned long offset, unsigned int pvr)
 
 	return NULL;
 }
+
+#ifdef CONFIG_JUMP_LABEL
+struct static_key_true cpu_feature_keys[NUM_CPU_FTR_KEYS] = {
+			[0 ... NUM_CPU_FTR_KEYS - 1] = STATIC_KEY_TRUE_INIT
+};
+EXPORT_SYMBOL_GPL(cpu_feature_keys);
+
+void __init cpu_feature_keys_init(void)
+{
+	int i;
+
+	for (i = 0; i < NUM_CPU_FTR_KEYS; i++) {
+		unsigned long f = 1ul << i;
+
+		if (!(cur_cpu_spec->cpu_features & f))
+			static_branch_disable(&cpu_feature_keys[i]);
+	}
+}
+#endif
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index 2a1904739843..f90423faade0 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -195,6 +195,7 @@ void __init apply_feature_fixups(void)
 	 * CPU/MMU features.
 	 */
 	jump_label_init();
+	cpu_feature_keys_init();
 }
 
 static int __init check_features(void)
-- 
2.7.4
