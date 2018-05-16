Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mCjf47xdzF1Md
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 22:02:30 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4GBxhcK135165
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 08:02:27 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j0kjat2bk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 08:02:27 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Wed, 16 May 2018 13:02:25 +0100
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, mpe@ellerman.id.au, ego@linux.vnet.ibm.com,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH] cpuidle/powernv : init all present cpus for deep states
Date: Wed, 16 May 2018 17:32:14 +0530
Message-Id: <1526472134-23757-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Init all present cpus for deep states instead of "all possible" cpus.
Init fails if the possible cpu is gaurded. Resulting in making only
non-deep states available for cpuidle/hotplug.

Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/idle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 1f12ab1..1c5d067 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -79,7 +79,7 @@ static int pnv_save_sprs_for_deep_states(void)
 	uint64_t msr_val = MSR_IDLE;
 	uint64_t psscr_val = pnv_deepest_stop_psscr_val;
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		uint64_t pir = get_hard_smp_processor_id(cpu);
 		uint64_t hsprg0_val = (uint64_t)paca_ptrs[cpu];
 
@@ -814,7 +814,7 @@ static int __init pnv_init_idle_states(void)
 		int cpu;
 
 		pr_info("powernv: idle: Saving PACA pointers of all CPUs in their thread sibling PACA\n");
-		for_each_possible_cpu(cpu) {
+		for_each_present_cpu(cpu) {
 			int base_cpu = cpu_first_thread_sibling(cpu);
 			int idx = cpu_thread_in_core(cpu);
 			int i;
-- 
2.5.5
