Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40WtMb2wlvzF24d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 20:19:07 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH v3] powerpc: Fix smp_send_stop NMI IPI handling
Date: Thu, 26 Apr 2018 20:19:02 +1000
Message-Id: <20180426101902.22886-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicholas Piggin <npiggin@gmail.com>

The NMI IPI handler for a receiving CPU increments nmi_ipi_busy_count
over the handler function call, which causes later smp_send_nmi_ipi()
callers to spin until the call is finished.

The stop_this_cpu() function never returns, so the busy count is never
decremeted, which can cause the system to hang in some cases. For
example panic() will call smp_send_stop() early on which calls
stop_this_cpu() on other CPUs, then later in the reboot path,
pnv_restart() will call smp_send_stop() again, which hangs.

Fix this by adding a special case to the stop_this_cpu() handler to
decrement the busy count, because it will never return.

Now that the NMI/non-NMI versions of stop_this_cpu() are different,
split them out into separate functions rather than doing #ifdef tricks
to share the body between the two functions.

Fixes: 6bed3237624e3 ("powerpc: use NMI IPI for smp_send_stop")
Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
[mpe: Split out the functions, tweak change log a bit]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/smp.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

v3: Split into separate functions, rather than doing #ifdef tricks.

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index e16ec7b3b427..3582f30b60b7 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -565,11 +565,7 @@ void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *))
 }
 #endif
 
-#ifdef CONFIG_NMI_IPI
-static void stop_this_cpu(struct pt_regs *regs)
-#else
 static void stop_this_cpu(void *dummy)
-#endif
 {
 	/* Remove this CPU */
 	set_cpu_online(smp_processor_id(), false);
@@ -580,10 +576,26 @@ static void stop_this_cpu(void *dummy)
 		spin_cpu_relax();
 }
 
+#ifdef CONFIG_NMI_IPI
+static void nmi_stop_this_cpu(struct pt_regs *regs)
+{
+	/*
+	 * This is a special case because it never returns, so the NMI IPI
+	 * handling would never mark it as done, which makes any later
+	 * smp_send_nmi_ipi() call spin forever. Mark it done now.
+	 */
+	nmi_ipi_lock();
+	nmi_ipi_busy_count--;
+	nmi_ipi_unlock();
+
+	stop_this_cpu(NULL);
+}
+#endif
+
 void smp_send_stop(void)
 {
 #ifdef CONFIG_NMI_IPI
-	smp_send_nmi_ipi(NMI_IPI_ALL_OTHERS, stop_this_cpu, 1000000);
+	smp_send_nmi_ipi(NMI_IPI_ALL_OTHERS, nmi_stop_this_cpu, 1000000);
 #else
 	smp_call_function(stop_this_cpu, NULL, 0);
 #endif
-- 
2.14.1
