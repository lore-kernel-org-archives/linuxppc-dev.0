Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405ntG2jyNzF1dX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 22:40:36 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2LBe9PE051629
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 07:40:34 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gumn4dn78-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 07:40:33 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 21 Mar 2018 11:40:32 -0000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v2] powerpc/perf: Fix kernel address leaks via Sampling
 registers
Date: Wed, 21 Mar 2018 17:10:24 +0530
Message-Id: <1521632426-30770-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman <mpe@ellerman.id.au>

Current code in power_pmu_disable() does not clear the sampling
registers like Sampling Instruction Address Register (SAIR) and
Sampling Data Address Register (SDAR) after disabling the PMU.
Since these are userspace readable and could contain kernel
address, add code to explicitly clear the content of these registers.
Patch also adds a "context synchronizing instruction" to enforce
no further updates to these registers as mandated by PowerISA.

"If an mtspr instruction is executed that changes the
value of a Performance Monitor register other than
SIAR, SDAR, and SIER, the change is not guaranteed
to have taken effect until after a subsequent context
synchronizing instruction has been executed (see
Chapter 11. "Synchronization Requirements for Con-
text Alterations" on page 1133)."

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
Changelog v1:
  - Added config flags to avoid 32bit build breaks.

 arch/powerpc/perf/core-book3s.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index f89bbd54ecec..39846226c702 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1226,6 +1226,7 @@ static void power_pmu_disable(struct pmu *pmu)
 		 */
 		write_mmcr0(cpuhw, val);
 		mb();
+		isync();
 
 		/*
 		 * Disable instruction sampling if it was enabled
@@ -1234,12 +1235,26 @@ static void power_pmu_disable(struct pmu *pmu)
 			mtspr(SPRN_MMCRA,
 			      cpuhw->mmcr[2] & ~MMCRA_SAMPLE_ENABLE);
 			mb();
+			isync();
 		}
 
 		cpuhw->disabled = 1;
 		cpuhw->n_added = 0;
 
 		ebb_switch_out(mmcr0);
+
+#ifdef CONFIG_PPC64
+		/*
+		 * These are readable by userspace, may contain kernel
+		 * addresses and are not switched by context switch, so clear
+		 * them now to avoid leaking anything to userspace in general
+		 * including to another process.
+		 */
+		if (ppmu->flags & PPMU_ARCH_207S) {
+			mtspr(SPRN_SDAR, 0);
+			mtspr(SPRN_SIAR, 0);
+		}
+#endif
 	}
 
 	local_irq_restore(flags);
-- 
2.7.4
