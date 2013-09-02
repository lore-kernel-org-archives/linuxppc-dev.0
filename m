Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 74BC22C00CB
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Sep 2013 15:46:31 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 2/3] powerpc: use the jump label for cpu_has_feature
Date: Mon, 2 Sep 2013 13:45:25 +0800
Message-ID: <1378100726-32545-3-git-send-email-haokexin@gmail.com>
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

The cpu features are fixed once the probe of cpu features are done.
And the function cpu_has_feature() does be used in some hot path.
The checking of the cpu features for each time of invoking of
cpu_has_feature() seems suboptimal. This tries to reduce this
overhead of this check by using jump label. But we can only use
the jump label for this check only after the execution of
jump_label_init(), so we introduce another jump label to
still do the feature check by default before all the cpu
feature jump labels are initialized.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v2: Include the jump_label.h instead of jump_label_base.h.

 arch/powerpc/include/asm/cpufeatures.h | 27 +++++++++++++++++++++++++++
 arch/powerpc/kernel/cputable.c         | 23 +++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/powerpc/include/asm/cpufeatures.h b/arch/powerpc/include/asm/cpufeatures.h
index 37650db..2631287 100644
--- a/arch/powerpc/include/asm/cpufeatures.h
+++ b/arch/powerpc/include/asm/cpufeatures.h
@@ -2,7 +2,33 @@
 #define __ASM_POWERPC_CPUFEATURES_H
 
 #include <asm/cputable.h>
+#ifdef CONFIG_JUMP_LABEL
+#include <linux/jump_label.h>
 
+#ifdef __powerpc64__
+#define MAX_CPU_FEATURES	64
+#else
+#define MAX_CPU_FEATURES	32
+#endif
+extern struct static_key cpu_feat_keys[MAX_CPU_FEATURES];
+extern struct static_key cpu_feat_keys_enabled;
+
+static inline int cpu_has_feature(unsigned long feature)
+{
+	if (CPU_FTRS_ALWAYS & feature)
+		return 1;
+
+	if (!(CPU_FTRS_POSSIBLE | feature))
+		return 0;
+
+	if (static_key_false(&cpu_feat_keys_enabled)) {
+		int i = __builtin_ctzl(feature);
+
+		return static_key_false(&cpu_feat_keys[i]);
+	} else
+		return !!(cur_cpu_spec->cpu_features & feature);
+}
+#else
 static inline int cpu_has_feature(unsigned long feature)
 {
 	return (CPU_FTRS_ALWAYS & feature) ||
@@ -10,5 +36,6 @@ static inline int cpu_has_feature(unsigned long feature)
 		& cur_cpu_spec->cpu_features
 		& feature);
 }
+#endif
 
 #endif /* __ASM_POWERPC_CPUFEATURE_H */
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 597d954..50bd216 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -21,6 +21,7 @@
 #include <asm/prom.h>		/* for PTRRELOC on ARCH=ppc */
 #include <asm/mmu.h>
 #include <asm/setup.h>
+#include <asm/cpufeatures.h>
 
 struct cpu_spec* cur_cpu_spec = NULL;
 EXPORT_SYMBOL(cur_cpu_spec);
@@ -2258,3 +2259,25 @@ struct cpu_spec * __init identify_cpu(unsigned long offset, unsigned int pvr)
 
 	return NULL;
 }
+
+#ifdef CONFIG_JUMP_LABEL
+struct static_key cpu_feat_keys[MAX_CPU_FEATURES];
+struct static_key cpu_feat_keys_enabled;
+
+static __init int cpu_feat_keys_init(void)
+{
+	int i;
+
+	for (i = 0; i < MAX_CPU_FEATURES; i++) {
+		unsigned long f = 1 << i;
+
+		if (cur_cpu_spec->cpu_features & f)
+			static_key_slow_inc(&cpu_feat_keys[i]);
+	}
+
+	static_key_slow_inc(&cpu_feat_keys_enabled);
+
+	return 0;
+}
+early_initcall(cpu_feat_keys_init);
+#endif
-- 
1.8.3.1
