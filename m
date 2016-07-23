Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rxMJJ3jbPzDqWK
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jul 2016 19:13:36 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6N99v86059457
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jul 2016 05:13:34 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24c5420vt6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jul 2016 05:13:34 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 23 Jul 2016 03:13:33 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH for-4.8 V2 10/10] powerpc/mm: Catch the usage of
 cpu/mmu_has_feature before jump label init
Date: Sat, 23 Jul 2016 14:42:43 +0530
In-Reply-To: <1469265163-1491-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1469265163-1491-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1469265163-1491-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This enable us to catch the wrong usage of cpu_has_feature and
mmu_has_feature in the code. We need to use the feature bit based
check in show_regs because that is used in the reporting code.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/Kconfig.debug             | 11 +++++++++++
 arch/powerpc/include/asm/cpufeatures.h |  6 ++++++
 arch/powerpc/include/asm/mmu.h         | 13 +++++++++++++
 arch/powerpc/kernel/process.c          |  2 +-
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 8243ada23237..e4da4e4985fe 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -60,6 +60,17 @@ config CODE_PATCHING_SELFTEST
 	depends on DEBUG_KERNEL
 	default n
 
+config FEATURE_FIXUP_DEBUG
+	bool "Do extra check on feature fixup calls"
+	depends on DEBUG_KERNEL
+	default n
+	help
+	  This catch the wrong usage of cpu_has_feature and mmu_has_feature
+	  in the code.
+
+	  If you don't know what this means, say N
+
+
 config FTR_FIXUP_SELFTEST
 	bool "Run self-tests of the feature-fixup code"
 	depends on DEBUG_KERNEL
diff --git a/arch/powerpc/include/asm/cpufeatures.h b/arch/powerpc/include/asm/cpufeatures.h
index 4a4a0b898463..93e7e3e87af4 100644
--- a/arch/powerpc/include/asm/cpufeatures.h
+++ b/arch/powerpc/include/asm/cpufeatures.h
@@ -22,6 +22,12 @@ static __always_inline bool cpu_has_feature(unsigned long feature)
 {
 	int i;
 
+#ifdef CONFIG_FEATURE_FIXUP_DEBUG
+	if (!static_key_initialized) {
+		WARN_ON(1);
+		return __cpu_has_feature(feature);
+	}
+#endif
 	if (CPU_FTRS_ALWAYS & feature)
 		return true;
 
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 3726161f6a8d..5c1f3a4cb99f 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -152,6 +152,12 @@ static __always_inline bool mmu_has_feature(unsigned long feature)
 {
 	int i;
 
+#ifdef CONFIG_FEATURE_FIXUP_DEBUG
+	if (!static_key_initialized) {
+		WARN_ON(1);
+		return __mmu_has_feature(feature);
+	}
+#endif
 	if (!(MMU_FTRS_POSSIBLE & feature))
 		return false;
 
@@ -163,6 +169,13 @@ static inline void mmu_clear_feature(unsigned long feature)
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
 	static_branch_disable(&mmu_feat_keys[i]);
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 75611b984faa..5a08cff6621c 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1315,7 +1315,7 @@ void show_regs(struct pt_regs * regs)
 	print_msr_bits(regs->msr);
 	printk("  CR: %08lx  XER: %08lx\n", regs->ccr, regs->xer);
 	trap = TRAP(regs);
-	if ((regs->trap != 0xc00) && cpu_has_feature(CPU_FTR_CFAR))
+	if ((regs->trap != 0xc00) && __cpu_has_feature(CPU_FTR_CFAR))
 		printk("CFAR: "REG" ", regs->orig_gpr3);
 	if (trap == 0x200 || trap == 0x300 || trap == 0x600)
 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
-- 
2.7.4
