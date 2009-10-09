Return-Path: <sachinp@in.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4AE91B7B98
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 23:13:17 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n99C3g1b009181
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Oct 2009 08:03:42 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n99CDCsL228990
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Oct 2009 08:13:12 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n99C9mwH018234
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Oct 2009 08:09:48 -0400
From: Sachin Sant <sachinp@in.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 09 Oct 2009 17:43:08 +0530
Message-Id: <20091009121308.21261.44640.sendpatchset@localhost.localdomain>
Subject: [RESEND][PATCH]Ftrace - fix function_graph tracer OOPS
Cc: linuxppc-dev@ozlabs.org, rostedt@goodmis.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This time sending the patch as inline and not as an attachment.

Enabling function graph causes oops due to usage of LOAD_REG_IMMEDIATE().
As explained by Ben the usage of LOAD_REG_IMMEDIATE generates relocs that are
not supported when CONFIG_RELOCATABLE is set. 

Switch to LOAD_REG_ADDR().

Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
---

diff -Naurp old/arch/powerpc/kernel/entry_64.S new/arch/powerpc/kernel/entry_64.S
--- old/arch/powerpc/kernel/entry_64.S	2009-10-08 18:37:44.000000000 +0530
+++ new/arch/powerpc/kernel/entry_64.S	2009-10-08 18:34:33.000000000 +0530
@@ -1038,8 +1038,8 @@ _GLOBAL(mod_return_to_handler)
 	 * We are in a module using the module's TOC.
 	 * Switch to our TOC to run inside the core kernel.
 	 */
-	LOAD_REG_IMMEDIATE(r4,ftrace_return_to_handler)
-	ld	r2, 8(r4)
+	ld	r2, PACATOC(r13)
+	LOAD_REG_ADDR(r4,ftrace_return_to_handler)
 
 	bl	.ftrace_return_to_handler
 	nop
