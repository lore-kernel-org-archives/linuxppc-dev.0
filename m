Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7fPx5yQZzDqlp
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 17:10:29 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id o1so16113399pga.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Oct 2017 23:10:29 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/3] powerpc: use NMI IPI for smp_send_stop
Date: Fri,  6 Oct 2017 16:10:05 +1000
Message-Id: <20171006061005.29891-4-npiggin@gmail.com>
In-Reply-To: <20171006061005.29891-1-npiggin@gmail.com>
References: <20171006061005.29891-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the NMI IPI rather than smp_call_function for smp_send_stop.
Have stopped CPUs hard disable interrupts rather than just soft
disable.

This function is used in crash/panic/shutdown paths to bring other
CPUs down as quickly and reliably as possible, and minimizing their
potential to cause trouble.

Avoiding the Linux smp_call_function infrastructure and (if supported)
using true NMI IPIs makes this more robust.

Also use spin loop primitives in the stop callback, mainly to help
processing speed of the active thread speed in the simulator.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/smp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index e0a4c1f82e25..ce891030d925 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -547,19 +547,20 @@ void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *))
 }
 #endif
 
-static void stop_this_cpu(void *dummy)
+static void __noreturn stop_this_cpu(struct pt_regs *regs)
 {
 	/* Remove this CPU */
 	set_cpu_online(smp_processor_id(), false);
 
-	local_irq_disable();
+	hard_irq_disable();
+	spin_begin();
 	while (1)
-		;
+		spin_cpu_relax();
 }
 
 void smp_send_stop(void)
 {
-	smp_call_function(stop_this_cpu, NULL, 0);
+	smp_send_nmi_ipi(NMI_IPI_ALL_OTHERS, stop_this_cpu, 1000000);
 }
 
 struct thread_info *current_set[NR_CPUS];
-- 
2.13.3
