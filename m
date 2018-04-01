Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40DWxF2C48zF20w
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2018 20:36:33 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id 61-v6so559430plb.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Apr 2018 03:36:33 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: [PATCH v2 1/3] powerpc: use NMI IPI for smp_send_stop
Date: Sun,  1 Apr 2018 20:36:13 +1000
Message-Id: <20180401103615.15454-2-npiggin@gmail.com>
In-Reply-To: <20180401103615.15454-1-npiggin@gmail.com>
References: <20180401103615.15454-1-npiggin@gmail.com>
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/smp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index cfc08b099c49..db88660bf6bd 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -565,7 +565,11 @@ void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *))
 }
 #endif
 
+#ifdef CONFIG_NMI_IPI
+static void stop_this_cpu(struct pt_regs *regs)
+#else
 static void stop_this_cpu(void *dummy)
+#endif
 {
 	/* Remove this CPU */
 	set_cpu_online(smp_processor_id(), false);
@@ -577,7 +581,11 @@ static void stop_this_cpu(void *dummy)
 
 void smp_send_stop(void)
 {
+#ifdef CONFIG_NMI_IPI
+	smp_send_nmi_ipi(NMI_IPI_ALL_OTHERS, stop_this_cpu, 1000000);
+#else
 	smp_call_function(stop_this_cpu, NULL, 0);
+#endif
 }
 
 struct thread_info *current_set[NR_CPUS];
-- 
2.16.3
