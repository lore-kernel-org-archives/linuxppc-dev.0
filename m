Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTL4t42wRzDqgy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 16:55:26 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5E6rxHg084061
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 02:55:25 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23gf59as31-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 02:55:25 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 14 Jun 2016 00:55:24 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Kevin Hao <haokexin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH V1 09/10] powerpc: use jump label for mmu_has_feature
Date: Tue, 14 Jun 2016 12:24:47 +0530
In-Reply-To: <1465887288-12952-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1465887288-12952-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1465887288-12952-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Kevin Hao <haokexin@gmail.com>

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
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu.h | 36 ++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/cputable.c | 17 +++++++++++++++++
 arch/powerpc/kernel/setup_32.c |  1 +
 arch/powerpc/kernel/setup_64.c |  1 +
 4 files changed, 55 insertions(+)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index c488db09f7a0..e453e095579e 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -143,6 +143,41 @@ static inline bool __mmu_has_feature(unsigned long feature)
 	return !!(MMU_FTRS_POSSIBLE & cur_cpu_spec->mmu_features & feature);
 }
 
+#ifdef CONFIG_JUMP_LABEL
+#include <linux/jump_label.h>
+
+#define MAX_MMU_FEATURES	(8 * sizeof(((struct cpu_spec *)0)->mmu_features))
+
+extern struct static_key_true mmu_feat_keys[MAX_MMU_FEATURES];
+
+extern void mmu_feat_keys_init(void);
+
+static __always_inline bool mmu_has_feature(unsigned long feature)
+{
+	int i;
+
+	if (!(MMU_FTRS_POSSIBLE & feature))
+		return false;
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
+
+static inline void mmu_feat_keys_init(void)
+{
+
+}
+
 static inline bool mmu_has_feature(unsigned long feature)
 {
 	return __mmu_has_feature(feature);
@@ -152,6 +187,7 @@ static inline void mmu_clear_feature(unsigned long feature)
 {
 	cur_cpu_spec->mmu_features &= ~feature;
 }
+#endif /* CONFIG_JUMP_LABEL */
 
 extern unsigned int __start___mmu_ftr_fixup, __stop___mmu_ftr_fixup;
 
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index b0a24b425441..a98630183e92 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -2243,4 +2243,21 @@ void __init cpu_feat_keys_init(void)
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
index ac5b41ad94ed..cd0d8814bd9b 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -107,6 +107,7 @@ notrace unsigned long __init early_init(unsigned long dt_ptr)
 	 */
 	jump_label_init();
 	cpu_feat_keys_init();
+	mmu_feat_keys_init();
 
 	return KERNELBASE + offset;
 }
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 1bd0d19afe1d..8222950f820f 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -487,6 +487,7 @@ void __init setup_system(void)
 	 */
 	jump_label_init();
 	cpu_feat_keys_init();
+	mmu_feat_keys_init();
 
 	/*
 	 * Unflatten the device-tree passed by prom_init or kexec
-- 
2.7.4
