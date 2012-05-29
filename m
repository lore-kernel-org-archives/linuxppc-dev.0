Return-Path: <yong.zhang0@gmail.com>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
 [209.85.212.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5D4F6B6EEB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2012 17:18:12 +1000 (EST)
Received: by vbip1 with SMTP id p1so2362122vbi.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2012 00:18:08 -0700 (PDT)
From: Yong Zhang <yong.zhang0@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 09/10] POWERPC: smp: remove call to
 ipi_call_lock()/ipi_call_unlock()
Date: Tue, 29 May 2012 15:16:04 +0800
Message-Id: <1338275765-3217-10-git-send-email-yong.zhang0@gmail.com>
In-Reply-To: <1338275765-3217-1-git-send-email-yong.zhang0@gmail.com>
References: <1338275765-3217-1-git-send-email-yong.zhang0@gmail.com>
Cc: axboe@kernel.dk, sshtylyov@mvista.com, nikunj@linux.vnet.ibm.com,
 david.daney@cavium.com, peterz@infradead.org, akpm@linux-foundation.org,
 ralf@linux-mips.org, Paul Mackerras <paulus@samba.org>,
 srivatsa.bhat@linux.vnet.ibm.com, tglx@linutronix.de,
 paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Yong Zhang <yong.zhang@windriver.com>

1) call_function.lock used in smp_call_function_many() is just to protect
   call_function.queue and &data->refs, cpu_online_mask is outside of the
   lock. And it's not necessary to protect cpu_online_mask,
   because data->cpumask is pre-calculate and even if a cpu is brougt up
   when calling arch_send_call_function_ipi_mask(), it's harmless because
   validation test in generic_smp_call_function_interrupt() will take care
   of it.

2) For cpu down issue, stop_machine() will guarantee that no concurrent
   smp_call_fuction() is processing.

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/smp.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index e4cb343..e1417c4 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -571,7 +571,6 @@ void __devinit start_secondary(void *unused)
 	if (system_state == SYSTEM_RUNNING)
 		vdso_data->processorCount++;
 #endif
-	ipi_call_lock();
 	notify_cpu_starting(cpu);
 	set_cpu_online(cpu, true);
 	/* Update sibling maps */
@@ -601,7 +600,6 @@ void __devinit start_secondary(void *unused)
 		of_node_put(np);
 	}
 	of_node_put(l2_cache);
-	ipi_call_unlock();
 
 	local_irq_enable();
 
-- 
1.7.5.4
