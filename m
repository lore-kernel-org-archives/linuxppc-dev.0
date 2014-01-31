Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 13C8A2C01AE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 15:13:47 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Thu, 30 Jan 2014 21:13:45 -0700
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id F250A6E803A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 23:13:37 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23032.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0V4Dg9Q4718972
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 04:13:42 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0V4DeLJ004549
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 23:13:41 -0500
Subject: [PATCH 1/3] powerpc: Free up the slot of PPC_MSG_CALL_FUNC_SINGLE
 IPI message
To: deepthi@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, toshi.kani@hp.com,
 arnd@arndb.de, geoff@infradead.org, mpe@ellerman.id.au,
 rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
 paul.gortmaker@windriver.com, afleming@freescale.com, anton@samba.org,
 srivatsa.bhat@linux.vnet.ibm.com, benh@kernel.crashing.org,
 paulus@samba.org, ady8radu@gmail.com, linuxppc-dev@lists.ozlabs.org
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Fri, 31 Jan 2014 09:40:07 +0530
Message-ID: <20140131041007.13071.23707.stgit@preeti.in.ibm.com>
In-Reply-To: <20140131040631.13071.19603.stgit@preeti.in.ibm.com>
References: <20140131040631.13071.19603.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

The IPI handlers for both PPC_MSG_CALL_FUNC and PPC_MSG_CALL_FUNC_SINGLE map
to a common implementation - generic_smp_call_function_single_interrupt(). So,
we can consolidate them and save one of the IPI message slots, (which are
precious on powerpc, since only 4 of those slots are available).

So, implement the functionality of PPC_MSG_CALL_FUNC_SINGLE using
PPC_MSG_CALL_FUNC itself and release its IPI message slot, so that it can be
used for something else in the future, if desired.

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
Signed-off-by: Preeti U. Murthy <preeti@linux.vnet.ibm.com>
Acked-by: Geoff Levand <geoff@infradead.org> [For the PS3 part]
---

 arch/powerpc/include/asm/smp.h          |    2 +-
 arch/powerpc/kernel/smp.c               |   12 +++++-------
 arch/powerpc/platforms/cell/interrupt.c |    2 +-
 arch/powerpc/platforms/ps3/smp.c        |    2 +-
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 084e080..9f7356b 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -120,7 +120,7 @@ extern int cpu_to_core_id(int cpu);
  * in /proc/interrupts will be wrong!!! --Troy */
 #define PPC_MSG_CALL_FUNCTION   0
 #define PPC_MSG_RESCHEDULE      1
-#define PPC_MSG_CALL_FUNC_SINGLE	2
+#define PPC_MSG_UNUSED		2
 #define PPC_MSG_DEBUGGER_BREAK  3
 
 /* for irq controllers that have dedicated ipis per message (4) */
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index ac2621a..ee7d76b 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -145,9 +145,9 @@ static irqreturn_t reschedule_action(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t call_function_single_action(int irq, void *data)
+static irqreturn_t unused_action(int irq, void *data)
 {
-	generic_smp_call_function_single_interrupt();
+	/* This slot is unused and hence available for use, if needed */
 	return IRQ_HANDLED;
 }
 
@@ -168,14 +168,14 @@ static irqreturn_t debug_ipi_action(int irq, void *data)
 static irq_handler_t smp_ipi_action[] = {
 	[PPC_MSG_CALL_FUNCTION] =  call_function_action,
 	[PPC_MSG_RESCHEDULE] = reschedule_action,
-	[PPC_MSG_CALL_FUNC_SINGLE] = call_function_single_action,
+	[PPC_MSG_UNUSED] = unused_action,
 	[PPC_MSG_DEBUGGER_BREAK] = debug_ipi_action,
 };
 
 const char *smp_ipi_name[] = {
 	[PPC_MSG_CALL_FUNCTION] =  "ipi call function",
 	[PPC_MSG_RESCHEDULE] = "ipi reschedule",
-	[PPC_MSG_CALL_FUNC_SINGLE] = "ipi call function single",
+	[PPC_MSG_UNUSED] = "ipi unused",
 	[PPC_MSG_DEBUGGER_BREAK] = "ipi debugger",
 };
 
@@ -251,8 +251,6 @@ irqreturn_t smp_ipi_demux(void)
 			generic_smp_call_function_interrupt();
 		if (all & IPI_MESSAGE(PPC_MSG_RESCHEDULE))
 			scheduler_ipi();
-		if (all & IPI_MESSAGE(PPC_MSG_CALL_FUNC_SINGLE))
-			generic_smp_call_function_single_interrupt();
 		if (all & IPI_MESSAGE(PPC_MSG_DEBUGGER_BREAK))
 			debug_ipi_action(0, NULL);
 	} while (info->messages);
@@ -280,7 +278,7 @@ EXPORT_SYMBOL_GPL(smp_send_reschedule);
 
 void arch_send_call_function_single_ipi(int cpu)
 {
-	do_message_pass(cpu, PPC_MSG_CALL_FUNC_SINGLE);
+	do_message_pass(cpu, PPC_MSG_CALL_FUNCTION);
 }
 
 void arch_send_call_function_ipi_mask(const struct cpumask *mask)
diff --git a/arch/powerpc/platforms/cell/interrupt.c b/arch/powerpc/platforms/cell/interrupt.c
index 2d42f3b..adf3726 100644
--- a/arch/powerpc/platforms/cell/interrupt.c
+++ b/arch/powerpc/platforms/cell/interrupt.c
@@ -215,7 +215,7 @@ void iic_request_IPIs(void)
 {
 	iic_request_ipi(PPC_MSG_CALL_FUNCTION);
 	iic_request_ipi(PPC_MSG_RESCHEDULE);
-	iic_request_ipi(PPC_MSG_CALL_FUNC_SINGLE);
+	iic_request_ipi(PPC_MSG_UNUSED);
 	iic_request_ipi(PPC_MSG_DEBUGGER_BREAK);
 }
 
diff --git a/arch/powerpc/platforms/ps3/smp.c b/arch/powerpc/platforms/ps3/smp.c
index 4b35166..00d1a7c 100644
--- a/arch/powerpc/platforms/ps3/smp.c
+++ b/arch/powerpc/platforms/ps3/smp.c
@@ -76,7 +76,7 @@ static int __init ps3_smp_probe(void)
 
 		BUILD_BUG_ON(PPC_MSG_CALL_FUNCTION    != 0);
 		BUILD_BUG_ON(PPC_MSG_RESCHEDULE       != 1);
-		BUILD_BUG_ON(PPC_MSG_CALL_FUNC_SINGLE != 2);
+		BUILD_BUG_ON(PPC_MSG_UNUSED	      != 2);
 		BUILD_BUG_ON(PPC_MSG_DEBUGGER_BREAK   != 3);
 
 		for (i = 0; i < MSG_COUNT; i++) {
