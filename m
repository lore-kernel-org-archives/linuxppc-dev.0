Return-Path: <rostedt@goodmis.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CC63FB707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Sep 2009 04:05:10 +1000 (EST)
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id 400DDDDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Sep 2009 04:05:09 +1000 (EST)
Subject: Re: [FTRACE] Enabling function_graph causes OOPS
From: Steven Rostedt <rostedt@goodmis.org>
To: Sachin Sant <sachinp@in.ibm.com>
In-Reply-To: <4AA88F7D.5030302@in.ibm.com>
References: <4A5C5D65.3030906@in.ibm.com>
	<alpine.DEB.2.00.0907141844540.32740@gandalf.stny.rr.com>
	<4A76BE81.4080707@in.ibm.com>
	<1252458303.20985.10.camel@gandalf.stny.rr.com>
	<4AA74AE2.5090001@in.ibm.com>
	<1252525364.27001.32.camel@gandalf.stny.rr.com>
	<4AA88F7D.5030302@in.ibm.com>
Content-Type: text/plain
Date: Fri, 11 Sep 2009 14:05:06 -0400
Message-Id: <1252692306.18996.703.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: rostedt@goodmis.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-09-10 at 11:02 +0530, Sachin Sant wrote:
> Steven Rostedt wrote:
> > Ah, seems the bug happens to be in the module handling. Does the call
> > back always have .mod_return_to_handler?
> >   
> Yes. Every time it ends up in .mod_return_to_handler

Hmm, I still can not reproduce it, and I've confirmed that I
hit .mod_return_to_handler too.

Could you apply the below patch. This wont fix anything, but it will at
least make the trace back show the real functions that were called.

Thanks,

-- Steve

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 892a9f2..a2e1b15 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1014,9 +1014,13 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	int curr_frame = current->curr_ret_stack;
 	extern void return_to_handler(void);
-	unsigned long addr = (unsigned long)return_to_handler;
+	unsigned long rth = (unsigned long)return_to_handler;
+	unsigned long mrth = -1;
 #ifdef CONFIG_PPC64
-	addr = *(unsigned long*)addr;
+	extern void mod_return_to_handler(void);
+	rth = *(unsigned long *)rth;
+	mrth = (unsigned long)mod_return_to_handler;
+	mrth = *(unsigned long *)mrth;
 #endif
 #endif
 
@@ -1042,7 +1046,7 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 		if (!firstframe || ip != lr) {
 			printk("["REG"] ["REG"] %pS", sp, ip, (void *)ip);
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-			if (ip == addr && curr_frame >= 0) {
+			if ((ip == rth || ip == mrth) && curr_frame >= 0) {
 				printk(" (%pS)",
 				       (void *)current->ret_stack[curr_frame].ret);
 				curr_frame--;
