Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3BE372C00CD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Sep 2013 15:46:34 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 3/3] powerpc: use jump label for mmu_has_feature
Date: Mon, 2 Sep 2013 13:45:26 +0800
Message-ID: <1378100726-32545-4-git-send-email-haokexin@gmail.com>
In-Reply-To: <1378100726-32545-1-git-send-email-haokexin@gmail.com>
References: <1378100726-32545-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
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
overhead of this check by using jump label. But we can only use
the jump label for this check only after the execution of
jump_label_init(), so we introduce another jump label to
still do the feature check by default before all the mmu
feature jump labels are initialized.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v2: Include the jump_label.h instead of jump_label_base.h.

 arch/powerpc/include/asm/mmu.h | 19 +++++++++++++++++++
 arch/powerpc/kernel/cputable.c | 20 ++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 691fd8a..b7f049e 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -121,10 +121,29 @@
 DECLARE_PER_CPU(int, next_tlbcam_idx);
 #endif
 
+#ifdef CONFIG_JUMP_LABEL
+#include <linux/jump_label.h>
+
+#define MAX_MMU_FEATURES	32
+
+extern struct static_key mmu_feat_keys[MAX_MMU_FEATURES];
+extern struct static_key mmu_feat_keys_enabled;
+
+static inline int mmu_has_feature(unsigned long feature)
+{
+	if (static_key_false(&mmu_feat_keys_enabled)) {
+		int i = __builtin_ctzl(feature);
+
+		return static_key_false(&mmu_feat_keys[i]);
+	} else
+		return !!(cur_cpu_spec->mmu_features & feature);
+}
+#else
 static inline int mmu_has_feature(unsigned long feature)
 {
 	return (cur_cpu_spec->mmu_features & feature);
 }
+#endif
 
 static inline void mmu_clear_feature(unsigned long feature)
 {
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 50bd216..785370b 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -2280,4 +2280,24 @@ static __init int cpu_feat_keys_init(void)
 	return 0;
 }
 early_initcall(cpu_feat_keys_init);
+
+struct static_key mmu_feat_keys[MAX_MMU_FEATURES];
+struct static_key mmu_feat_keys_enabled;
+
+static __init int mmu_feat_keys_init(void)
+{
+	int i;
+
+	for (i = 0; i < MAX_MMU_FEATURES; i++) {
+		unsigned long f = 1 << i;
+
+		if (cur_cpu_spec->mmu_features & f)
+			static_key_slow_inc(&mmu_feat_keys[i]);
+	}
+
+	static_key_slow_inc(&mmu_feat_keys_enabled);
+
+	return 0;
+}
+early_initcall(mmu_feat_keys_init);
 #endif
-- 
1.8.3.1
