Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x22a.google.com (mail-yk0-x22a.google.com
 [IPv6:2607:f8b0:4002:c07::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3367F1A1D7B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 22:15:19 +1000 (AEST)
Received: by ykll84 with SMTP id l84so35030422ykl.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 05:15:17 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 7/8] powerpc: use the jump label for cpu_has_feature
Date: Thu, 20 Aug 2015 20:14:35 +0800
Message-Id: <1440072876-8321-8-git-send-email-haokexin@gmail.com>
In-Reply-To: <1440072876-8321-1-git-send-email-haokexin@gmail.com>
References: <1440072876-8321-1-git-send-email-haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The cpu features are fixed once the probe of cpu features are done.
And the function cpu_has_feature() does be used in some hot path.
The checking of the cpu features for each time of invoking of
cpu_has_feature() seems suboptimal. This tries to reduce this
overhead of this check by using jump label.

The generated assemble code of the following c program:
	if (cpu_has_feature(CPU_FTR_XXX))
		xxx()

Before:
	lis     r9,-16230
	lwz     r9,12324(r9)
	lwz     r9,12(r9)
	andi.   r10,r9,512
	beqlr-

After:
	nop	if CPU_FTR_XXX is enabled
	b xxx	if CPU_FTR_XXX is not enabled

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/include/asm/cpufeatures.h | 20 ++++++++++++++++++++
 arch/powerpc/include/asm/cputable.h    |  8 ++++++++
 arch/powerpc/kernel/cputable.c         | 18 ++++++++++++++++++
 arch/powerpc/kernel/setup_32.c         |  1 +
 arch/powerpc/kernel/setup_64.c         |  1 +
 5 files changed, 48 insertions(+)

diff --git a/arch/powerpc/include/asm/cpufeatures.h b/arch/powerpc/include/asm/cpufeatures.h
index 37650db5044f..405a97fe6ef9 100644
--- a/arch/powerpc/include/asm/cpufeatures.h
+++ b/arch/powerpc/include/asm/cpufeatures.h
@@ -3,6 +3,25 @@
 
 #include <asm/cputable.h>
 
+#ifdef CONFIG_JUMP_LABEL
+#include <linux/jump_label.h>
+
+extern struct static_key_true cpu_feat_keys[MAX_CPU_FEATURES];
+
+static inline int cpu_has_feature(unsigned long feature)
+{
+	int i;
+
+	if (CPU_FTRS_ALWAYS & feature)
+		return 1;
+
+	if (!(CPU_FTRS_POSSIBLE & feature))
+		return 0;
+
+	i = __builtin_ctzl(feature);
+	return static_branch_likely(&cpu_feat_keys[i]);
+}
+#else
 static inline int cpu_has_feature(unsigned long feature)
 {
 	return (CPU_FTRS_ALWAYS & feature) ||
@@ -10,5 +29,6 @@ static inline int cpu_has_feature(unsigned long feature)
 		& cur_cpu_spec->cpu_features
 		& feature);
 }
+#endif
 
 #endif /* __ASM_POWERPC_CPUFEATURE_H */
diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index ae4b6ef341cd..2ebee2894102 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -114,6 +114,12 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 
 extern const char *powerpc_base_platform;
 
+#ifdef CONFIG_JUMP_LABEL
+extern void cpu_feat_keys_init(void);
+#else
+static inline void cpu_feat_keys_init(void) { }
+#endif
+
 /* TLB flush actions. Used as argument to cpu_spec.flush_tlb() hook */
 enum {
 	TLB_INVAL_SCOPE_GLOBAL = 0,	/* invalidate all TLBs */
@@ -124,6 +130,8 @@ enum {
 
 /* CPU kernel features */
 
+#define MAX_CPU_FEATURES	(8 * sizeof(((struct cpu_spec *)0)->cpu_features))
+
 /* Retain the 32b definitions all use bottom half of word */
 #define CPU_FTR_COHERENT_ICACHE		ASM_CONST(0x00000001)
 #define CPU_FTR_L2CR			ASM_CONST(0x00000002)
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 7d80bfdfb15e..7d4fe69a61ed 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -15,6 +15,7 @@
 #include <linux/threads.h>
 #include <linux/init.h>
 #include <linux/export.h>
+#include <linux/jump_label.h>
 
 #include <asm/oprofile_impl.h>
 #include <asm/cputable.h>
@@ -2195,3 +2196,20 @@ struct cpu_spec * __init identify_cpu(unsigned long offset, unsigned int pvr)
 
 	return NULL;
 }
+
+#ifdef CONFIG_JUMP_LABEL
+DEFINE_STATIC_KEY_TRUE_ARRAY(cpu_feat_keys, MAX_CPU_FEATURES);
+EXPORT_SYMBOL_GPL(cpu_feat_keys);
+
+void __init cpu_feat_keys_init(void)
+{
+	int i;
+
+	for (i = 0; i < MAX_CPU_FEATURES; i++) {
+		unsigned long f = 1ul << i;
+
+		if (!(cur_cpu_spec->cpu_features & f))
+			static_branch_disable(&cpu_feat_keys[i]);
+	}
+}
+#endif
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index f0868f510b3b..93756175a13c 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -115,6 +115,7 @@ notrace void __init machine_init(u64 dt_ptr)
 	lockdep_init();
 
 	jump_label_init();
+	cpu_feat_keys_init();
 
 	/* Enable early debugging if any specified (see udbg.h) */
 	udbg_early_init();
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index f0802a0b4a20..4cf3894d91fa 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -251,6 +251,7 @@ void __init early_setup(unsigned long dt_ptr)
 	lockdep_init();
 
 	jump_label_init();
+	cpu_feat_keys_init();
 
 	/* -------- printk is now safe to use ------- */
 
-- 
2.1.0
