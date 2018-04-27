Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40XH4F67WzzF24j
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Apr 2018 11:52:13 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id n9-v6so292155pgq.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 18:52:13 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2] powerpc: Fix deadlock with multiple calls to smp_send_stop
Date: Fri, 27 Apr 2018 11:51:59 +1000
Message-Id: <20180427015159.17270-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

smp_send_stop can lock up the IPI path for any subsequent calls,
because the receiving CPUs spin in their handler function. This
started becoming a problem with the addition of an smp_send_stop
call in the reboot path, because panics can reboot after doing
their own smp_send_stop.

The NMI IPI variant was fixed with ac61c11566 ("powerpc: Fix
smp_send_stop NMI IPI handling"), which leaves the smp_call_function
variant.

This is fixed by having smp_send_stop only ever do the
smp_call_function once. This is a bit less robust than the NMI IPI
fix, because any other call to smp_call_function after smp_send_stop
could deadlock, but that has always been the case, and it was not
been a problem before.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Fixes: f2748bdfe1573 ("powerpc/powernv: Always stop secondaries before reboot/shutdown")
Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Changes since v1:
- Rebased to powerpc fixes branch which has the NMI IPI fix.

 arch/powerpc/kernel/smp.c | 55 +++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 3582f30b60b7..9ca7148b5881 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -565,17 +565,6 @@ void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *))
 }
 #endif
 
-static void stop_this_cpu(void *dummy)
-{
-	/* Remove this CPU */
-	set_cpu_online(smp_processor_id(), false);
-
-	hard_irq_disable();
-	spin_begin();
-	while (1)
-		spin_cpu_relax();
-}
-
 #ifdef CONFIG_NMI_IPI
 static void nmi_stop_this_cpu(struct pt_regs *regs)
 {
@@ -583,23 +572,57 @@ static void nmi_stop_this_cpu(struct pt_regs *regs)
 	 * This is a special case because it never returns, so the NMI IPI
 	 * handling would never mark it as done, which makes any later
 	 * smp_send_nmi_ipi() call spin forever. Mark it done now.
+	 *
+	 * IRQs are already hard disabled by the smp_handle_nmi_ipi.
 	 */
 	nmi_ipi_lock();
 	nmi_ipi_busy_count--;
 	nmi_ipi_unlock();
 
-	stop_this_cpu(NULL);
+	/* Remove this CPU */
+	set_cpu_online(smp_processor_id(), false);
+
+	spin_begin();
+	while (1)
+		spin_cpu_relax();
 }
-#endif
 
 void smp_send_stop(void)
 {
-#ifdef CONFIG_NMI_IPI
 	smp_send_nmi_ipi(NMI_IPI_ALL_OTHERS, nmi_stop_this_cpu, 1000000);
-#else
+}
+
+#else /* CONFIG_NMI_IPI */
+
+static void stop_this_cpu(void *dummy)
+{
+	/* Remove this CPU */
+	set_cpu_online(smp_processor_id(), false);
+
+	hard_irq_disable();
+	spin_begin();
+	while (1)
+		spin_cpu_relax();
+}
+
+void smp_send_stop(void)
+{
+	static bool stopped = false;
+
+	/*
+	 * Prevent waiting on csd lock from a previous smp_send_stop.
+	 * This is racy, but in general callers try to do the right
+	 * thing and only fire off one smp_send_stop (e.g., see
+	 * kernel/panic.c)
+	 */
+	if (stopped)
+		return;
+
+	stopped = true;
+
 	smp_call_function(stop_this_cpu, NULL, 0);
-#endif
 }
+#endif /* CONFIG_NMI_IPI */
 
 struct thread_info *current_set[NR_CPUS];
 
-- 
2.17.0
