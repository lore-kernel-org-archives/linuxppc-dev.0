Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2mlf6Lc9zDqlS
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jul 2017 02:38:38 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v65GcY7n092044
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jul 2017 12:38:36 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bgwem9v8g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Jul 2017 12:38:36 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 5 Jul 2017 12:38:35 -0400
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 4/5] powernv:idle: Move initialization of sibling pacas to
 pnv_alloc_idle_core_states
Date: Wed,  5 Jul 2017 22:08:15 +0530
In-Reply-To: <1499272696-28751-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1499272696-28751-1-git-send-email-ego@linux.vnet.ibm.com>
Message-Id: <1499272696-28751-5-git-send-email-ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

On POWER9 DD1, in order to get around a hardware issue, we store in
every CPU thread's paca the paca pointers of all its siblings.

Move this code into pnv_alloc_idle_core_states() soon after the space
for saving the sibling pacas is allocated.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/idle.c | 45 +++++++++++++++++------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index c400ff9..254a0db8 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -194,6 +194,28 @@ static void pnv_alloc_idle_core_states(void)
 		}
 	}
 
+	/*
+	 * For each CPU, record its PACA address in each of it's
+	 * sibling thread's PACA at the slot corresponding to this
+	 * CPU's index in the core.
+	 */
+	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
+		int cpu;
+
+		pr_info("powernv: idle: Saving PACA pointers of all CPUs in their thread sibling PACA\n");
+		for_each_possible_cpu(cpu) {
+			int base_cpu = cpu_first_thread_sibling(cpu);
+			int idx = cpu_thread_in_core(cpu);
+			int i;
+
+			for (i = 0; i < threads_per_core; i++) {
+				int j = base_cpu + i;
+
+				paca[j].thread_sibling_pacas[idx] = &paca[cpu];
+			}
+		}
+	}
+
 	update_subcore_sibling_mask();
 
 	if (supported_cpuidle_states & OPAL_PM_LOSE_FULL_CONTEXT)
@@ -898,31 +920,8 @@ static int __init pnv_init_idle_states(void)
 	if (pnv_probe_idle_states())
 		goto out;
 
-
 	pnv_alloc_idle_core_states();
 
-	/*
-	 * For each CPU, record its PACA address in each of it's
-	 * sibling thread's PACA at the slot corresponding to this
-	 * CPU's index in the core.
-	 */
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
-		int cpu;
-
-		pr_info("powernv: idle: Saving PACA pointers of all CPUs in their thread sibling PACA\n");
-		for_each_possible_cpu(cpu) {
-			int base_cpu = cpu_first_thread_sibling(cpu);
-			int idx = cpu_thread_in_core(cpu);
-			int i;
-
-			for (i = 0; i < threads_per_core; i++) {
-				int j = base_cpu + i;
-
-				paca[j].thread_sibling_pacas[idx] = &paca[cpu];
-			}
-		}
-	}
-
 out:
 	return 0;
 }
-- 
1.9.4
