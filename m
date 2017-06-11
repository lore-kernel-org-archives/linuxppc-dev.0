Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmCj64MB3zDqLN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 10:00:58 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id w12so4684619pfk.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Jun 2017 17:00:58 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH 14/14] powerpc/64s: idle runlatch switch is done with MSR[EE]=0
Date: Mon, 12 Jun 2017 09:58:35 +1000
Message-Id: <20170611235835.7400-15-npiggin@gmail.com>
In-Reply-To: <20170611235835.7400-1-npiggin@gmail.com>
References: <20170611235835.7400-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2*mfmsr and 2*mtmsr can be avoided in the idle sleep/wake code
because we know the MSR[EE] is clear.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/platforms/powernv/idle.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index ee416e016387..84c55a5ef7ea 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -291,9 +291,9 @@ static unsigned long __power7_idle_type(unsigned long type)
 	if (!prep_irq_for_idle_irqsoff())
 		return 0;
 
-	ppc64_runlatch_off();
+	__ppc64_runlatch_off();
 	srr1 = power7_idle_insn(type);
-	ppc64_runlatch_on();
+	__ppc64_runlatch_on();
 
 	fini_irq_for_idle_irqsoff();
 
@@ -328,9 +328,9 @@ static unsigned long __power9_idle_type(unsigned long stop_psscr_val,
 	psscr = mfspr(SPRN_PSSCR);
 	psscr = (psscr & ~stop_psscr_mask) | stop_psscr_val;
 
-	ppc64_runlatch_off();
+	__ppc64_runlatch_off();
 	srr1 = power9_idle_stop(psscr);
-	ppc64_runlatch_on();
+	__ppc64_runlatch_on();
 
 	fini_irq_for_idle_irqsoff();
 
@@ -365,7 +365,7 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
 	unsigned long srr1;
 	u32 idle_states = pnv_get_supported_cpuidle_states();
 
-	ppc64_runlatch_off();
+	__ppc64_runlatch_off();
 
 	if (cpu_has_feature(CPU_FTR_ARCH_300) && deepest_stop_found) {
 		unsigned long psscr;
@@ -392,7 +392,7 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
 		HMT_medium();
 	}
 
-	ppc64_runlatch_on();
+	__ppc64_runlatch_on();
 
 	return srr1;
 }
-- 
2.11.0
