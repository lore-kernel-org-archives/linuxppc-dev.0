Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F0265DE164
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 22:56:55 +1100 (EST)
Date: Fri, 10 Oct 2008 06:56:45 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: linuxppc-dev@ozlabs.org, Ben Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Message-id: <patch-ipi-1@bga.com>
In-Reply-To: <patch-xics-0@bga.com>
Subject: [PATCH 13/16] powerpc smp: no need to set_need_resched in resched ipi
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The code was asking "Do we have to do this?", and according to x86 and s390
the answer is no, the scheduler will do it before calling the arch hook.

Signed-off-by: Milton Miller <miltonm@bga.com>

Index: next.git/arch/powerpc/kernel/smp.c
===================================================================
--- next.git.orig/arch/powerpc/kernel/smp.c	2008-10-04 22:09:36.000000000 -0500
+++ next.git/arch/powerpc/kernel/smp.c	2008-10-04 22:12:32.000000000 -0500
@@ -101,8 +101,7 @@ void smp_message_recv(int msg)
 		generic_smp_call_function_interrupt();
 		break;
 	case PPC_MSG_RESCHEDULE:
-		/* XXX Do we have to do this? */
-		set_need_resched();
+		/* we notice need_resched on exit */
 		break;
 	case PPC_MSG_CALL_FUNC_SINGLE:
 		generic_smp_call_function_single_interrupt();
