Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40VVzt3TcFzF1RV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 14:42:15 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3O4fre7056276
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 00:42:12 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hhvy79uqm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 00:42:11 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Tue, 24 Apr 2018 05:42:09 +0100
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: npiggin@gmail.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, ppaidipe@linux.vnet.ibm.com,
 svaidy@linux.vnet.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] cpufreq: powernv: Fix the hardlockup by synchronus smp_call
 in timer interrupt
Date: Tue, 24 Apr 2018 10:11:46 +0530
Message-Id: <1524544906-31512-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

gpstate_timer_handler() uses synchronous smp_call to set the pstate
on the requested core. This causes the below hard lockup:

[c000003fe566b320] [c0000000001d5340] smp_call_function_single+0x110/0x180 (unreliable)
[c000003fe566b390] [c0000000001d55e0] smp_call_function_any+0x180/0x250
[c000003fe566b3f0] [c000000000acd3e8] gpstate_timer_handler+0x1e8/0x580
[c000003fe566b4a0] [c0000000001b46b0] call_timer_fn+0x50/0x1c0
[c000003fe566b520] [c0000000001b4958] expire_timers+0x138/0x1f0
[c000003fe566b590] [c0000000001b4bf8] run_timer_softirq+0x1e8/0x270
[c000003fe566b630] [c000000000d0d6c8] __do_softirq+0x158/0x3e4
[c000003fe566b710] [c000000000114be8] irq_exit+0xe8/0x120
[c000003fe566b730] [c000000000024d0c] timer_interrupt+0x9c/0xe0
[c000003fe566b760] [c000000000009014] decrementer_common+0x114/0x120
--- interrupt: 901 at doorbell_global_ipi+0x34/0x50
LR = arch_send_call_function_ipi_mask+0x120/0x130
[c000003fe566ba50] [c00000000004876c] arch_send_call_function_ipi_mask+0x4c/0x130 (unreliable)
[c000003fe566ba90] [c0000000001d59f0] smp_call_function_many+0x340/0x450
[c000003fe566bb00] [c000000000075f18] pmdp_invalidate+0x98/0xe0
[c000003fe566bb30] [c0000000003a1120] change_huge_pmd+0xe0/0x270
[c000003fe566bba0] [c000000000349278] change_protection_range+0xb88/0xe40
[c000003fe566bcf0] [c0000000003496c0] mprotect_fixup+0x140/0x340
[c000003fe566bdb0] [c000000000349a74] SyS_mprotect+0x1b4/0x350
[c000003fe566be30] [c00000000000b184] system_call+0x58/0x6c

Fix this by using the asynchronus smp_call in the timer interrupt handler.
We don't have to wait in this handler until the pstates are changed on
the core. This change will not have any impact on the global pstate
ramp-down algorithm.

Reported-by: Nicholas Piggin <npiggin@gmail.com>
Reported-by: Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>
Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 0591874..7e0c752 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -721,7 +721,7 @@ void gpstate_timer_handler(struct timer_list *t)
 	spin_unlock(&gpstates->gpstate_lock);
 
 	/* Timer may get migrated to a different cpu on cpu hot unplug */
-	smp_call_function_any(policy->cpus, set_pstate, &freq_data, 1);
+	smp_call_function_any(policy->cpus, set_pstate, &freq_data, 0);
 }
 
 /*
-- 
1.8.3.1
