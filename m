Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8CF4CDE10A
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 22:56:57 +1100 (EST)
Date: Fri, 10 Oct 2008 06:56:44 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: linuxppc-dev@ozlabs.org, Ben Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Message-id: <patch-xics-12@bga.com>
In-Reply-To: <patch-xics-0@bga.com>
Subject: [PATCH 12/16] powerpc: reduce and comment xics ipi memory barrier
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A single full sync (mb()) is requrired to order the mmio to the qirr reg
with the set or clear of the message word.  However, test_and_clear_bit
has the effect of smp_mb() and we are not doing any other io from here,
so we don't need a mb per bit processed.

Signed-off-by: Milton Miller <miltonm@bga.com>

Index: next.git/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- next.git.orig/arch/powerpc/platforms/pseries/xics.c	2008-10-04 23:56:15.000000000 -0500
+++ next.git/arch/powerpc/platforms/pseries/xics.c	2008-10-05 00:01:26.000000000 -0500
@@ -498,26 +498,23 @@ static irqreturn_t xics_ipi_dispatch(int
 {
 	WARN_ON(cpu_is_offline(cpu));
 
+	mb();	/* order mmio clearing qirr */
 	while (xics_ipi_message[cpu].value) {
 		if (test_and_clear_bit(PPC_MSG_CALL_FUNCTION,
 				       &xics_ipi_message[cpu].value)) {
-			mb();
 			smp_message_recv(PPC_MSG_CALL_FUNCTION);
 		}
 		if (test_and_clear_bit(PPC_MSG_RESCHEDULE,
 				       &xics_ipi_message[cpu].value)) {
-			mb();
 			smp_message_recv(PPC_MSG_RESCHEDULE);
 		}
 		if (test_and_clear_bit(PPC_MSG_CALL_FUNC_SINGLE,
 				       &xics_ipi_message[cpu].value)) {
-			mb();
 			smp_message_recv(PPC_MSG_CALL_FUNC_SINGLE);
 		}
 #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
 		if (test_and_clear_bit(PPC_MSG_DEBUGGER_BREAK,
 				       &xics_ipi_message[cpu].value)) {
-			mb();
 			smp_message_recv(PPC_MSG_DEBUGGER_BREAK);
 		}
 #endif
