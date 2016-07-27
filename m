Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzxtn3NkJzDrLJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 00:18:57 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 aneesh.kumar@linux.vnet.ibm.com, haokexin@gmail.com
Subject: [PATCH v3 20/21] powerpc/mm: Catch usage of cpu/mmu_has_feature()
 before jump label init
Date: Thu, 28 Jul 2016 00:18:16 +1000
Message-Id: <1469629097-30859-20-git-send-email-mpe@ellerman.id.au>
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

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This allows us to catch incorrect usage of cpu_has_feature() and
mmu_has_feature() prior to jump labels being initialised.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig.debug                 | 10 ++++++++++
 arch/powerpc/include/asm/cpu_has_feature.h |  7 +++++++
 arch/powerpc/include/asm/mmu.h             | 14 ++++++++++++++
 arch/powerpc/kernel/process.c              |  2 +-
 4 files changed, 32 insertions(+), 1 deletion(-)

v3: Use printk() and dump_stack() rather than WARN_ON(), because
    WARN_ON() may not work this early in boot.
    Rename the Kconfig.

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 2512dac77adb..0108fde08d90 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -69,6 +69,16 @@ config JUMP_LABEL_FEATURE_CHECKS
 	  feature checks. This should generate more optimal code for those
 	  checks.
 
+config JUMP_LABEL_FEATURE_CHECK_DEBUG
+	bool "Do extra check on feature fixup calls"
+	depends on DEBUG_KERNEL && JUMP_LABEL_FEATURE_CHECKS
+	default n
+	help
+	  This tries to catch incorrect usage of cpu_has_feature() and
+	  mmu_has_feature() in the code.
+
+	  If you don't know what this means, say N.
+
 config FTR_FIXUP_SELFTEST
 	bool "Run self-tests of the feature-fixup code"
 	depends on DEBUG_KERNEL
diff --git a/arch/powerpc/include/asm/cpu_has_feature.h b/arch/powerpc/include/asm/cpu_has_feature.h
index 18e60e61bea9..b702a48c438d 100644
--- a/arch/powerpc/include/asm/cpu_has_feature.h
+++ b/arch/powerpc/include/asm/cpu_has_feature.h
@@ -22,6 +22,13 @@ static __always_inline bool cpu_has_feature(unsigned long feature)
 {
 	int i;
 
+#ifdef CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG
+	if (!static_key_initialized) {
+		printk("Warning! cpu_has_feature() used prior to jump label init!\n");
+		dump_stack();
+		return __cpu_has_feature(feature);
+	}
+#endif
 	if (CPU_FTRS_ALWAYS & feature)
 		return true;
 
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 3900cb7fe7cf..50d8c9f78976 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -153,6 +153,13 @@ static __always_inline bool mmu_has_feature(unsigned long feature)
 {
 	int i;
 
+#ifdef CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG
+	if (!static_key_initialized) {
+		printk("Warning! mmu_has_feature() used prior to jump label init!\n");
+		dump_stack();
+		return __mmu_has_feature(feature);
+	}
+#endif
 	if (!(MMU_FTRS_POSSIBLE & feature))
 		return false;
 
@@ -164,6 +171,13 @@ static inline void mmu_clear_feature(unsigned long feature)
 {
 	int i;
 
+#ifdef CONFIG_FEATURE_FIXUP_DEBUG
+	if (!static_key_initialized) {
+		WARN_ON(1);
+		cur_cpu_spec->mmu_features &= ~feature;
+		return;
+	}
+#endif
 	i = __builtin_ctzl(feature);
 	cur_cpu_spec->mmu_features &= ~feature;
 	static_branch_disable(&mmu_feature_keys[i]);
