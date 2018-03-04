Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zvMSN00zjzDqmB
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Mar 2018 23:15:31 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w24CEMkZ141132
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 4 Mar 2018 07:15:29 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gga4fhd9c-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Mar 2018 07:15:29 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Sun, 4 Mar 2018 12:15:27 -0000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/perf: Fix kernel address leaks via Sampling registers
Date: Sun,  4 Mar 2018 17:45:09 +0530
Message-Id: <1520165709-20524-1-git-send-email-maddy@linux.vnet.ibm.com>
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

Tested-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/core-book3s.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 73f997b84d19..e8754243f3cb 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1235,6 +1235,7 @@ static void power_pmu_disable(struct pmu *pmu)
 		 */
 		write_mmcr0(cpuhw, val);
 		mb();
+		isync();
 
 		/*
 		 * Disable instruction sampling if it was enabled
@@ -1243,12 +1244,22 @@ static void power_pmu_disable(struct pmu *pmu)
 			mtspr(SPRN_MMCRA,
 			      cpuhw->mmcr[2] & ~MMCRA_SAMPLE_ENABLE);
 			mb();
+			isync();
 		}
 
 		cpuhw->disabled = 1;
 		cpuhw->n_added = 0;
 
 		ebb_switch_out(mmcr0);
+
+		/*
+		 * These are readable by userspace, may contain kernel
+		 * addresses and are not switched by context switch, so clear
+		 * them now to avoid leaking anything to userspace in general
+		 * including to another process.
+		 */
+		mtspr(SPRN_SDAR, 0);
+		mtspr(SPRN_SIAR, 0);
 	}
 
 	local_irq_restore(flags);
-- 
2.7.4
