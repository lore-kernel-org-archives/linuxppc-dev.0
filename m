Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40WJ644JtyzDrDT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 21:35:24 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id n9so352259pgq.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 04:35:24 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2] powerpc: Fix smp_send_stop NMI IPI handling
Date: Wed, 25 Apr 2018 21:35:12 +1000
Message-Id: <20180425113512.20595-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The NMI IPI handler for a receiving CPU increments nmi_ipi_busy_count
over the handler function call, which causes later smp_send_nmi_ipi()
callers to spin until the call is finished.

The smp_send_stop function never returns, so the busy count is never
decremeted, which can cause the system to hang in some cases. For
example panic() will call smp_send_stop early on, then later in the
reboot path, pnv_restart will call smp_send_stop again, which hangs.

Fix this by adding a special case to the smp_send_stop handler to
decrement the busy count, because it will never return.

Fixes: 6bed3237624e3 ("powerpc: use NMI IPI for smp_send_stop")
Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Changes since v1:
- Reduce #ifdef spaghetti suggested by mpe

 arch/powerpc/kernel/smp.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index e16ec7b3b427..41d42c2f88d4 100644
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
@@ -582,12 +607,9 @@ static void stop_this_cpu(void *dummy)
 
 void smp_send_stop(void)
 {
-#ifdef CONFIG_NMI_IPI
-	smp_send_nmi_ipi(NMI_IPI_ALL_OTHERS, stop_this_cpu, 1000000);
-#else
 	smp_call_function(stop_this_cpu, NULL, 0);
-#endif
 }
+#endif /* CONFIG_NMI_IPI */
 
 struct thread_info *current_set[NR_CPUS];
 
-- 
2.17.0
