Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40WK2M6fqczF252
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 22:17:15 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id a14so4557838pfi.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 05:17:15 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc: Fix deadlock with multiple calls to smp_send_stop
Date: Wed, 25 Apr 2018 22:17:04 +1000
Message-Id: <20180425121704.22713-1-npiggin@gmail.com>
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

The NMI IPI handler for a receiving CPU increments nmi_ipi_busy_count
over the handler function call, which causes the next
smp_send_nmi_ipi() caller to spin. Fix this by adding a special case
to the smp_send_stop handler to decrement the busy count, because it
will never return.

The smp_call_function path (used when !CONFIG_NMI_IPI) suffers from
a similar deadlock. This is fixed by having smp_send_stop only ever
do the smp_call_function once. This is a bit less robust, because
any other use of smp_call_function after smp_send_stop could deadlock,
but that hasn't been a problem before. Fixing that would take a bit
more code.

Fixes: f2748bdfe1573 ("powerpc/powernv: Always stop secondaries before reboot/shutdown")
Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

This supersedes "[PATCH v2] powerpc: Fix smp_send_stop NMI IPI
handling". I got the root cause for that wrong, and missed the
non-NMI case that is also affected.

 arch/powerpc/kernel/smp.c | 49 +++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index e16ec7b3b427..9ca7148b5881 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -566,10 +566,35 @@ void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *))
 #endif
 
 #ifdef CONFIG_NMI_IPI
-static void stop_this_cpu(struct pt_regs *regs)
-#else
+static void nmi_stop_this_cpu(struct pt_regs *regs)
+{
+	/*
+	 * This is a special case because it never returns, so the NMI IPI
+	 * handling would never mark it as done, which makes any later
+	 * smp_send_nmi_ipi() call spin forever. Mark it done now.
+	 *
+	 * IRQs are already hard disabled by the smp_handle_nmi_ipi.
+	 */
+	nmi_ipi_lock();
+	nmi_ipi_busy_count--;
+	nmi_ipi_unlock();
+
+	/* Remove this CPU */
+	set_cpu_online(smp_processor_id(), false);
+
+	spin_begin();
+	while (1)
+		spin_cpu_relax();
+}
+
+void smp_send_stop(void)
+{
+	smp_send_nmi_ipi(NMI_IPI_ALL_OTHERS, nmi_stop_this_cpu, 1000000);
+}
+
+#else /* CONFIG_NMI_IPI */
+
 static void stop_this_cpu(void *dummy)
-#endif
 {
 	/* Remove this CPU */
 	set_cpu_online(smp_processor_id(), false);
@@ -582,12 +607,22 @@ static void stop_this_cpu(void *dummy)
 
 void smp_send_stop(void)
 {
-#ifdef CONFIG_NMI_IPI
-	smp_send_nmi_ipi(NMI_IPI_ALL_OTHERS, stop_this_cpu, 1000000);
-#else
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
