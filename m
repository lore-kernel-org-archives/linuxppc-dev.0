Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTL4z0KzHzDqhd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 16:55:30 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5E6rxEl141713
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 02:55:28 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23getmj9cb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 02:55:28 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 14 Jun 2016 00:55:27 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH V1 10/10] powerpc/mm: Catch the usage of
 cpu/mmu_has_feature before jump label init
Date: Tue, 14 Jun 2016 12:24:48 +0530
In-Reply-To: <1465887288-12952-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1465887288-12952-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1465887288-12952-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/cpufeatures.h |  6 ++++++
 arch/powerpc/include/asm/mmu.h         | 13 +++++++++++++
 arch/powerpc/kernel/process.c          |  2 +-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/cpufeatures.h b/arch/powerpc/include/asm/cpufeatures.h
index 4a4a0b898463..ee1ce11778df 100644
--- a/arch/powerpc/include/asm/cpufeatures.h
+++ b/arch/powerpc/include/asm/cpufeatures.h
@@ -22,6 +22,12 @@ static __always_inline bool cpu_has_feature(unsigned long feature)
 {
 	int i;
 
+#ifdef CONFIG_DEBUG_VM
+	if (!static_key_initialized) {
+		WARN_ON(1);
+		return __cpu_has_feature(feature);
+	}
+#endif
 	if (CPU_FTRS_ALWAYS & feature)
 		return true;
 
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index e453e095579e..941b7a329262 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -156,6 +156,12 @@ static __always_inline bool mmu_has_feature(unsigned long feature)
 {
 	int i;
 
+#ifdef CONFIG_DEBUG_VM
+	if (!static_key_initialized) {
+		WARN_ON(1);
+		return __mmu_has_feature(feature);
+	}
+#endif
 	if (!(MMU_FTRS_POSSIBLE & feature))
 		return false;
 
@@ -167,6 +173,13 @@ static inline void mmu_clear_feature(unsigned long feature)
 {
 	int i;
 
+#ifdef CONFIG_DEBUG_VM
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
index 3d1f3d07e0d5..218ddf160438 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1293,7 +1293,7 @@ void show_regs(struct pt_regs * regs)
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
