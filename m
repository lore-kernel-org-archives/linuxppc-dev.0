Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A4FC07E85
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 11:03:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 732A1214DE
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 11:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2byaxJl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732A1214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438JrC1Z9yzDqd0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 22:03:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A2byaxJl";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=egbn=on=linuxfoundation.org=gregkh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="A2byaxJl"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438Jlb0KYfzDqYV
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 21:59:23 +1100 (AEDT)
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 91E5E20878;
 Tue,  4 Dec 2018 10:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543921161;
 bh=LKHyEwEQnJR8GIddD7ZTZ+J/beh5QGq6NVLuV1fB/ng=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=A2byaxJlxNn7OXEx6Bm3XGJRiyEZoDB/R0IFmi6Fxijha14yNPYZXy01RSL6FVKBy
 oEqbTXGDtLRpeJFowXBBEUQbWwSkckqY86jJG6MapjmAbeT4K2u+Wzu9qcXswIzDaY
 VkTSOWUpn9pcouJARaupbdDLnSlxPTcbBH6g3qyw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4.19 103/139] powerpc/function_graph: Simplify with
 function_graph_enter()
Date: Tue,  4 Dec 2018 11:49:44 +0100
Message-Id: <20181204103654.772207063@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 "Steven Rostedt \(VMware\)" <rostedt@goodmis.org>,
 linuxppc-dev@lists.ozlabs.org, stable@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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


