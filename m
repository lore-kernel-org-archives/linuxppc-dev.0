Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x22f.google.com (mail-yk0-x22f.google.com
 [IPv6:2607:f8b0:4002:c07::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 132141A1DAF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Aug 2015 21:21:09 +1000 (AEST)
Received: by ykll84 with SMTP id l84so130763818ykl.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Aug 2015 04:21:07 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] powerpc: use jump label for mmu_has_feature
Date: Mon, 24 Aug 2015 19:20:28 +0800
Message-Id: <1440415228-8006-7-git-send-email-haokexin@gmail.com>
In-Reply-To: <1440415228-8006-1-git-send-email-haokexin@gmail.com>
References: <1440415228-8006-1-git-send-email-haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The mmu features are fixed once the probe of mmu features are done.
And the function mmu_has_feature() does be used in some hot path.
The checking of the mmu features for each time of invoking of
mmu_has_feature() seems suboptimal. This tries to reduce this
overhead of this check by using jump label.

The generated assemble code of the following c program:
	if (mmu_has_feature(MMU_FTR_XXX))
		xxx()
Before:
	lis     r9,-16230
	lwz     r9,12324(r9)
	lwz     r9,24(r9)
	andi.   r10,r9,16
	beqlr+

After:
	nop	if MMU_FTR_XXX is enabled
	b xxx	if MMU_FTR_XXX is not enabled

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v2: Use the open-coded definition and initialization for mmu_feat_keys[].

 arch/powerpc/include/asm/mmu.h | 29 +++++++++++++++++++++++++++++
 arch/powerpc/kernel/cputable.c | 17 +++++++++++++++++
 arch/powerpc/kernel/setup_32.c |  1 +
 arch/powerpc/kernel/setup_64.c |  1 +
 4 files changed, 48 insertions(+)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 3d5abfe6ba67..e091de352a75 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -109,6 +109,34 @@
 DECLARE_PER_CPU(int, next_tlbcam_idx);
 #endif
 
+#ifdef CONFIG_JUMP_LABEL
+#include <linux/jump_label.h>
+
+#define MAX_MMU_FEATURES	(8 * sizeof(((struct cpu_spec *)0)->mmu_features))
+
+extern struct static_key_true mmu_feat_keys[MAX_MMU_FEATURES];
+
+extern void mmu_feat_keys_init(void);
+
+static inline int mmu_has_feature(unsigned long feature)
+{
+	int i;
+
+	i = __builtin_ctzl(feature);
+	return static_branch_likely(&mmu_feat_keys[i]);
+}
+
+static inline void mmu_clear_feature(unsigned long feature)
+{
+	int i;
+
+	i = __builtin_ctzl(feature);
+	cur_cpu_spec->mmu_features &= ~feature;
+	static_branch_disable(&mmu_feat_keys[i]);
+}
+#else
+static inline void mmu_feat_keys_init(void) { }
+
 static inline int mmu_has_feature(unsigned long feature)
 {
 	return (cur_cpu_spec->mmu_features & feature);
@@ -118,6 +146,7 @@ static inline void mmu_clear_feature(unsigned long feature)
 {
 	cur_cpu_spec->mmu_features &= ~feature;
 }
+#endif
 
 extern unsigned int __start___mmu_ftr_fixup, __stop___mmu_ftr_fixup;
 
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index ea94931c5e70..6b505c98520b 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -2214,4 +2214,21 @@ void __init cpu_feat_keys_init(void)
 			static_branch_disable(&cpu_feat_keys[i]);
 	}
 }
+
+struct static_key_true mmu_feat_keys[MAX_MMU_FEATURES] = {
+			[0 ... MAX_MMU_FEATURES - 1] = STATIC_KEY_TRUE_INIT
+};
+EXPORT_SYMBOL_GPL(mmu_feat_keys);
+
+void __init mmu_feat_keys_init(void)
+{
+	int i;
+
+	for (i = 0; i < MAX_MMU_FEATURES; i++) {
+		unsigned long f = 1ul << i;
+
+		if (!(cur_cpu_spec->mmu_features & f))
+			static_branch_disable(&mmu_feat_keys[i]);
+	}
+}
 #endif
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 93756175a13c..8acff5a4bc3e 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -116,6 +116,7 @@ notrace void __init machine_init(u64 dt_ptr)
 
 	jump_label_init();
 	cpu_feat_keys_init();
+	mmu_feat_keys_init();
 
 	/* Enable early debugging if any specified (see udbg.h) */
 	udbg_early_init();
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 4cf3894d91fa..df6f98f1c46c 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -252,6 +252,7 @@ void __init early_setup(unsigned long dt_ptr)
 
 	jump_label_init();
 	cpu_feat_keys_init();
+	mmu_feat_keys_init();
 
 	/* -------- printk is now safe to use ------- */
 
-- 
2.1.0
