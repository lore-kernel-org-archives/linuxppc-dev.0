Return-Path: <jdub@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 62B2A67B5A
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Sep 2006 05:51:09 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8FJp3oS002228
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Sep 2006 15:51:03 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8FJp3X0191806
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Sep 2006 13:51:03 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8FJp2te018632
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Sep 2006 13:51:02 -0600
Subject: [PATCH] PPC: Fix xmon stack frame address in backtrace
From: Josh Boyer <jdub@us.ibm.com>
To: paulus@samba.org
Content-Type: text/plain
Date: Fri, 15 Sep 2006 14:53:10 -0500
Message-Id: <1158349990.26996.41.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The stack frame address was being printed incorrectly in the backtrace
option of XMON on PPC.  This patch fixes it to print the actual stack
address instead of the address of the local variable that contains it.

Patch is against current powerpc.git tree.

Signed-off-by: Josh Boyer <jdub@us.ibm.com>

---
 arch/ppc/xmon/xmon.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.orig/arch/ppc/xmon/xmon.c
+++ linux-2.6/arch/ppc/xmon/xmon.c
@@ -806,7 +806,7 @@ backtrace(struct pt_regs *excp)
 	for (; sp != 0; sp = stack[0]) {
 		if (mread(sp, stack, sizeof(stack)) != sizeof(stack))
 			break;
-		printf("[%.8lx] ", stack);
+		printf("[%.8lx] ", stack[0]);
 		xmon_print_symbol(stack[1], " ", "\n");
 		if (stack[1] == (unsigned) &ret_from_except
 		    || stack[1] == (unsigned) &ret_from_except_full
