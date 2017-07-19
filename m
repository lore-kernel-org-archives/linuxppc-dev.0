Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC4Wz4V3gzDrTN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 14:57:19 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 15/24] powerpc/mm: Move CMO accounting out of do_page_fault
 into a helper
Date: Wed, 19 Jul 2017 14:49:37 +1000
Message-Id: <20170719044946.22030-15-benh@kernel.crashing.org>
In-Reply-To: <20170719044946.22030-1-benh@kernel.crashing.org>
References: <20170719044946.22030-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It makes do_page_fault() more readable. No functional change.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/mm/fault.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 0b217947d34f..5ccbf30d8aef 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -222,6 +222,23 @@ static bool bad_kernel_fault(bool is_exec, unsigned long error_code,
 	return is_exec || (address >= TASK_SIZE);
 }
 
+#ifdef CONFIG_PPC_SMLPAR
+static inline void cmo_account_page_fault(void)
+{
+	if (firmware_has_feature(FW_FEATURE_CMO)) {
+		u32 page_ins;
+
+		preempt_disable();
+		page_ins = be32_to_cpu(get_lppaca()->page_ins);
+		page_ins += 1 << PAGE_FACTOR;
+		get_lppaca()->page_ins = cpu_to_be32(page_ins);
+		preempt_enable();
+	}
+}
+#else
+static inline void cmo_account_page_fault(void) { }
+#endif /* CONFIG_PPC_SMLPAR */
+
 /*
  * Define the correct "is_write" bit in error_code based
  * on the processor family
@@ -501,17 +518,7 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 		current->maj_flt++;
 		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
 			      regs, address);
-#ifdef CONFIG_PPC_SMLPAR
-		if (firmware_has_feature(FW_FEATURE_CMO)) {
-			u32 page_ins;
-
-			preempt_disable();
-			page_ins = be32_to_cpu(get_lppaca()->page_ins);
-			page_ins += 1 << PAGE_FACTOR;
-			get_lppaca()->page_ins = cpu_to_be32(page_ins);
-			preempt_enable();
-		}
-#endif /* CONFIG_PPC_SMLPAR */
+		cmo_account_page_fault();
 	} else {
 		current->min_flt++;
 		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
-- 
2.13.3
