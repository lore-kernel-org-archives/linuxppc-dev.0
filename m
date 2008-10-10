Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D7DF8DE19B
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 22:56:59 +1100 (EST)
Date: Fri, 10 Oct 2008 06:56:51 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: linuxppc-dev@ozlabs.org, Ben Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Message-id: <patch-ipi-5@bga.com>
In-Reply-To: <patch-ipi-2@bga.com>
Subject: [PATCH 16/16] powerpc ps3: use smp_request_message_ipi
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ps3 has 4 ipis per cpu and can use the new smp_request_message_ipi to
reduce path length when receiving an ipi.

This has the side effect of setting IRQF_PERCPU.

Signed-off-by: Milton Miller <miltonm@bga.com>

Index: next.git/arch/powerpc/platforms/ps3/smp.c
===================================================================
--- next.git.orig/arch/powerpc/platforms/ps3/smp.c	2008-10-05 00:20:41.000000000 -0500
+++ next.git/arch/powerpc/platforms/ps3/smp.c	2008-10-05 00:22:50.000000000 -0500
@@ -32,12 +32,6 @@
 #define DBG pr_debug
 #endif
 
-static irqreturn_t ipi_function_handler(int irq, void *msg)
-{
-	smp_message_recv((int)(long)msg);
-	return IRQ_HANDLED;
-}
-
 /**
   * ps3_ipi_virqs - a per cpu array of virqs for ipi use
   */
@@ -45,13 +39,6 @@ static irqreturn_t ipi_function_handler(
 #define MSG_COUNT 4
 static DEFINE_PER_CPU(unsigned int, ps3_ipi_virqs[MSG_COUNT]);
 
-static const char *names[MSG_COUNT] = {
-	"ipi call",
-	"ipi reschedule",
-	"ipi migrate",
-	"ipi debug brk"
-};
-
 static void do_message_pass(int target, int msg)
 {
 	int result;
@@ -119,8 +106,7 @@ static void __init ps3_smp_setup_cpu(int
 		DBG("%s:%d: (%d, %d) => virq %u\n",
 			__func__, __LINE__, cpu, i, virqs[i]);
 
-		result = request_irq(virqs[i], ipi_function_handler,
-			IRQF_DISABLED, names[i], (void*)(long)i);
+		result = smp_request_message_ipi(virqs[i], i);
 
 		if (result)
 			virqs[i] = NO_IRQ;
