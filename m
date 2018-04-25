Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40W3l44pHQzF24L
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 12:18:07 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id e9so12219585pgr.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 19:18:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Subject: [PATCH] powerpc: Fix smp_send_stop NMI IPI handling
Date: Wed, 25 Apr 2018 12:17:53 +1000
Message-Id: <20180425021753.26275-1-npiggin@gmail.com>
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
 arch/powerpc/kernel/smp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index e16ec7b3b427..250fccf04c6e 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -567,10 +567,19 @@ void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *))
 
 #ifdef CONFIG_NMI_IPI
 static void stop_this_cpu(struct pt_regs *regs)
+{
+	/*
+	 * This is a special case because it never returns, so the NMI IPI
+	 * handling would never mark it as done, which makes any later
+	 * smp_send_nmi_ipi() call spin forever. Mark it done now.
+	 */
+	nmi_ipi_lock();
+	nmi_ipi_busy_count--;
+	nmi_ipi_unlock();
 #else
 static void stop_this_cpu(void *dummy)
-#endif
 {
+#endif
 	/* Remove this CPU */
 	set_cpu_online(smp_processor_id(), false);
 
-- 
2.17.0
