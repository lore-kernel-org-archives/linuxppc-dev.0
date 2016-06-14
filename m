Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTL4s5C6yzDqhW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 16:55:25 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5E6rwKN098680
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 02:55:23 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23gf672hyd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 02:55:23 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 14 Jun 2016 00:55:22 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Kevin Hao <haokexin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH V1 08/10] powerpc: use the jump label for cpu_has_feature
Date: Tue, 14 Jun 2016 12:24:46 +0530
In-Reply-To: <1465887288-12952-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1465887288-12952-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1465887288-12952-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Kevin Hao <haokexin@gmail.com>

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
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/cpufeatures.h | 21 +++++++++++++++++++++
 arch/powerpc/include/asm/cputable.h    |  8 ++++++++
 arch/powerpc/kernel/cputable.c         | 20 ++++++++++++++++++++
 arch/powerpc/kernel/setup_32.c         |  1 +
 arch/powerpc/kernel/setup_64.c         |  1 +
 5 files changed, 51 insertions(+)

diff --git a/arch/powerpc/include/asm/cpufeatures.h b/arch/powerpc/include/asm/cpufeatures.h
index bfa6cb8f5629..4a4a0b898463 100644
--- a/arch/powerpc/include/asm/cpufeatures.h
+++ b/arch/powerpc/include/asm/cpufeatures.h
@@ -13,10 +13,31 @@ static inline bool __cpu_has_feature(unsigned long feature)
 	return !!(CPU_FTRS_POSSIBLE & cur_cpu_spec->cpu_features & feature);
 }
 
+#ifdef CONFIG_JUMP_LABEL
+#include <linux/jump_label.h>
+
+extern struct static_key_true cpu_feat_keys[MAX_CPU_FEATURES];
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
+	return static_branch_likely(&cpu_feat_keys[i]);
+}
+#else
 static inline bool cpu_has_feature(unsigned long feature)
 {
 
 	return __cpu_has_feature(feature);
 }
+#endif
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_POWERPC_CPUFEATURE_H */
diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index a49ea95849f8..6c161e456759 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -122,6 +122,12 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 
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
@@ -132,6 +138,8 @@ enum {
 
 /* CPU kernel features */
 
+#define MAX_CPU_FEATURES	(8 * sizeof(((struct cpu_spec *)0)->cpu_features))
+
 /* Retain the 32b definitions all use bottom half of word */
 #define CPU_FTR_COHERENT_ICACHE		ASM_CONST(0x00000001)
 #define CPU_FTR_L2CR			ASM_CONST(0x00000002)
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index d8a0f7ca74e1..b0a24b425441 100644
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
+struct static_key_true cpu_feat_keys[MAX_CPU_FEATURES] = {
+			[0 ... MAX_CPU_FEATURES - 1] = STATIC_KEY_TRUE_INIT
+};
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
index ccac1cfd877d..ac5b41ad94ed 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -106,6 +106,7 @@ notrace unsigned long __init early_init(unsigned long dt_ptr)
 	 * by now.
 	 */
 	jump_label_init();
+	cpu_feat_keys_init();
 
 	return KERNELBASE + offset;
 }
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index a4867a900b02..1bd0d19afe1d 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -486,6 +486,7 @@ void __init setup_system(void)
 	 * by now.
 	 */
 	jump_label_init();
+	cpu_feat_keys_init();
 
 	/*
 	 * Unflatten the device-tree passed by prom_init or kexec
-- 
2.7.4
