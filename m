Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36347C04EBF
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 11:06:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A99C620851
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 11:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/JtbTWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A99C620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 437hy35P8LzDqMt
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 22:06:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y/JtbTWx";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=wgff=om=linuxfoundation.org=gregkh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y/JtbTWx"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437htp1q6hzDqNx
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Dec 2018 22:03:30 +1100 (AEDT)
Received: from localhost (unknown [62.119.166.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B7DD320834;
 Mon,  3 Dec 2018 11:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543835008;
 bh=3tHfjbk9Sl9xQCUJsxsM0PKW6xYkhbuwANLvCRDqEKU=;
 h=Subject:To:Cc:From:Date:From;
 b=Y/JtbTWxrepv5XFqH63RbZlF019uiZv22GzMSv1u7bC+WV7sDIbNseA+dztGvui8z
 /IH0HyJrKh+pRd+xYwSHnukpbRd52aKoO+gAectaFeDF7yty1fiwDdebZtlZerQEdC
 Ht24C+vkSSoqGeQwvD4XYHVZsr73nNYDyQISW/gc=
Subject: Patch "powerpc/function_graph: Simplify with function_graph_enter()"
 has been added to the 4.19-stable tree
To: benh@kernel.crashing.org, gregkh@linuxfoundation.org,
 linuxppc-dev@lists.ozlabs.org, mhiramat@kernel.org, mpe@ellerman.id.au,
 paulus@samba.org, rostedt@goodmis.org, stable@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Mon, 03 Dec 2018 12:00:12 +0100
Message-ID: <154383481221611@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: stable-commits@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


This is a note to let you know that I've just added the patch titled

    powerpc/function_graph: Simplify with function_graph_enter()

to the 4.19-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     powerpc-function_graph-simplify-with-function_graph_enter.patch
and it can be found in the queue-4.19 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From fe60522ec60082a1dd735691b82c64f65d4ad15e Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date: Sun, 18 Nov 2018 17:28:53 -0500
Subject: powerpc/function_graph: Simplify with function_graph_enter()

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit fe60522ec60082a1dd735691b82c64f65d4ad15e upstream.

The function_graph_enter() function does the work of calling the function
graph hook function and the management of the shadow stack, simplifying the
work done in the architecture dependent prepare_ftrace_return().

Have powerpc use the new code, and remove the shadow stack management as well as
having to set up the trace structure.

This is needed to prepare for a fix of a design bug on how the curr_ret_stack
is used.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: stable@kernel.org
Fixes: 03274a3ffb449 ("tracing/fgraph: Adjust fgraph depth before calling trace return callback")
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/trace/ftrace.c |   15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -697,7 +697,6 @@ int ftrace_disable_ftrace_graph_caller(v
  */
 unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip)
 {
-	struct ftrace_graph_ent trace;
 	unsigned long return_hooker;
 
 	if (unlikely(ftrace_graph_is_dead()))
@@ -708,18 +707,8 @@ unsigned long prepare_ftrace_return(unsi
 
 	return_hooker = ppc_function_entry(return_to_handler);
 
-	trace.func = ip;
-	trace.depth = current->curr_ret_stack + 1;
-
-	/* Only trace if the calling function expects to */
-	if (!ftrace_graph_entry(&trace))
-		goto out;
-
-	if (ftrace_push_return_trace(parent, ip, &trace.depth, 0,
-				     NULL) == -EBUSY)
-		goto out;
-
-	parent = return_hooker;
+	if (!function_graph_enter(parent, ip, 0, NULL))
+		parent = return_hooker;
 out:
 	return parent;
 }


Patches currently in stable-queue which might be from rostedt@goodmis.org are

queue-4.19/function_graph-create-function_graph_enter-to-consolidate-architecture-code.patch
queue-4.19/sh-function_graph-simplify-with-function_graph_enter.patch
queue-4.19/function_graph-move-return-callback-before-update-of-curr_ret_stack.patch
queue-4.19/nds32-function_graph-simplify-with-function_graph_enter.patch
queue-4.19/function_graph-use-new-curr_ret_depth-to-manage-depth-instead-of-curr_ret_stack.patch
queue-4.19/sparc-function_graph-simplify-with-function_graph_enter.patch
queue-4.19/parisc-function_graph-simplify-with-function_graph_enter.patch
queue-4.19/x86-function_graph-simplify-with-function_graph_enter.patch
queue-4.19/powerpc-function_graph-simplify-with-function_graph_enter.patch
queue-4.19/function_graph-reverse-the-order-of-pushing-the-ret_stack-and-the-callback.patch
queue-4.19/arm-function_graph-simplify-with-function_graph_enter.patch
queue-4.19/mips-function_graph-simplify-with-function_graph_enter.patch
queue-4.19/function_graph-make-ftrace_push_return_trace-static.patch
queue-4.19/arm64-function_graph-simplify-with-function_graph_enter.patch
queue-4.19/riscv-function_graph-simplify-with-function_graph_enter.patch
queue-4.19/s390-function_graph-simplify-with-function_graph_enter.patch
queue-4.19/microblaze-function_graph-simplify-with-function_graph_enter.patch
queue-4.19/function_graph-have-profiler-use-curr_ret_stack-and-not-depth.patch
