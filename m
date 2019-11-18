Return-Path: <SRS0=h9PY=ZK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABC5C432C0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Nov 2019 14:54:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC42220730
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Nov 2019 14:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC42220730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47GsRP0CfCzDqdb
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Nov 2019 01:54:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=5krg=zk=goodmis.org=rostedt@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=goodmis.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47GsMx6qNXzDqPN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2019 01:51:09 +1100 (AEDT)
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com
 [66.24.58.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1607A2071B;
 Mon, 18 Nov 2019 14:51:06 +0000 (UTC)
Date: Mon, 18 Nov 2019 09:51:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Qian Cai <cai@lca.pw>
Subject: Re: powerpc ftrace broken due to "manual merge of the ftrace tree
 with the arm64 tree"
Message-ID: <20191118095104.0daebbc3@oasis.local.home>
In-Reply-To: <1573851994.5937.138.camel@lca.pw>
References: <1573849732.5937.136.camel@lca.pw>
 <20191115160230.78871d8f@gandalf.local.home>
 <1573851994.5937.138.camel@lca.pw>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 15 Nov 2019 16:06:34 -0500
Qian Cai <cai@lca.pw> wrote:

> > Test this commit please: b83b43ffc6e4b514ca034a0fbdee01322e2f7022  
> 
> # git reset --hard b83b43ffc6e4b514ca034a0fbdee01322e2f7022
> 
> Yes, that one is bad.

Can you see if this patch fixes the issue for you?

Thanks!

-- Steve

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 0f358be551cd..fd8f4dc661dc 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -109,6 +109,13 @@
 #define MEM_DISCARD(sec) *(.mem##sec)
 #endif
 
+/* PowerPC defines ftrace_graph_stub in the code */
+#ifndef CONFIG_PPC
+# define DEFINE_FTRACE_GRAPH_STUB	ftrace_graph_stub = ftrace_stub;
+#else
+# define DEFINE_FTRACE_GRAPH_STUB
+#endif
+
 #ifdef CONFIG_FTRACE_MCOUNT_RECORD
 #ifdef CC_USING_PATCHABLE_FUNCTION_ENTRY
 /*
@@ -120,17 +127,17 @@
 			__start_mcount_loc = .;			\
 			KEEP(*(__patchable_function_entries))	\
 			__stop_mcount_loc = .;			\
-			ftrace_graph_stub = ftrace_stub;
+			DEFINE_FTRACE_GRAPH_STUB
 #else
 #define MCOUNT_REC()	. = ALIGN(8);				\
 			__start_mcount_loc = .;			\
 			KEEP(*(__mcount_loc))			\
 			__stop_mcount_loc = .;			\
-			ftrace_graph_stub = ftrace_stub;
+			DEFINE_FTRACE_GRAPH_STUB
 #endif
 #else
 # ifdef CONFIG_FUNCTION_TRACER
-#  define MCOUNT_REC()	ftrace_graph_stub = ftrace_stub;
+#  define MCOUNT_REC()	DEFINE_FTRACE_GRAPH_STUB
 # else
 #  define MCOUNT_REC()
 # endif
