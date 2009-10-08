Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E772AB7B6B
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 01:51:51 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp05.au.ibm.com (8.14.3/8.13.1) with ESMTP id n98En5Tw009360
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Oct 2009 01:49:05 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n98Epner1446016
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Oct 2009 01:51:49 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n98EpntT029718
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Oct 2009 01:51:49 +1100
Message-ID: <4ACDFC83.4080205@in.ibm.com>
Date: Thu, 08 Oct 2009 20:21:47 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] Ftrace : fix function_graph tracer OOPS
References: <4A5C5D65.3030906@in.ibm.com>
	<alpine.DEB.2.00.0907141844540.32740@gandalf.stny.rr.com>
	<4A76BE81.4080707@in.ibm.com>
	<1252458303.20985.10.camel@gandalf.stny.rr.com>
	<4AA74AE2.5090001@in.ibm.com>
	<1252814877.26049.93.camel@gandalf.stny.rr.com>
	<1252816650.8375.70.camel@pasglop>
	<1252848060.26049.647.camel@gandalf.stny.rr.com>
	<1252873548.8375.73.camel@pasglop>
	<1252915227.8375.118.camel@pasglop>
	<1254749155.13160.6.camel@gandalf.stny.rr.com>
	<1254774039.7122.35.camel@pasglop>
	<1254775073.13160.13.camel@gandalf.stny.rr.com>
	<4ACC57C4.5010002@in.ibm.com> <1254906621.2409.1.camel@pasglop>
In-Reply-To: <1254906621.2409.1.camel@pasglop>
Content-Type: multipart/mixed; boundary="------------080105090805070904020205"
Cc: linuxppc-dev@ozlabs.org, rostedt@goodmis.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080105090805070904020205
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Enabling function graph causes oops due to usage of LOAD_REG_IMMEDIATE().
As explained by Ben the usage of LOAD_REG_IMMEDIATE generates relocs that are
not supported when CONFIG_RELOCATABLE is set.

Switch to LOAD_REG_ADDR().

Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
---



--------------080105090805070904020205
Content-Type: text/x-patch;
 name="fix_ftrace_function_graph.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix_ftrace_function_graph.patch"

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

--------------080105090805070904020205--
