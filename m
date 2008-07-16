Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id BFF45DDE20
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 08:12:39 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Nathan Lynch <ntl@pobox.com>
Subject: [PATCH] powerpc: fix support for latencytop
Date: Thu, 17 Jul 2008 00:12:25 +0200
References: <48755237.9070701@nortel.com> <200807101608.18643.arnd@arndb.de>
	<20080716202236.GZ9594@localdomain>
In-Reply-To: <20080716202236.GZ9594@localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807170012.25859.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We need to pass the kernel stack pointer instead of the user space
stack pointer in save_stack_trace_tsk().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

On Wednesday 16 July 2008, Nathan Lynch wrote:
> Arnd Bergmann wrote:
> > Implement save_stack_trace_tsk on powerpc, so that we can run with
> > latencytop.
> 
> So I tried latencytop with linux-next and got the following oops, but
> I didn't really look into it yet.

Oh, I didn't even realize that benh had merged that patch of mine.
As I wrote in the description, it was entirely untested. You found
another obvious bug: The code was passing the user space stack
pointer instead of the kernel stack pointer.

Again, this patch is entirely untested, and I would not be at all
surprised to find other trivial bugs.

--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -59,6 +59,6 @@ EXPORT_SYMBOL_GPL(save_stack_trace);
 
 void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 {
-	save_context_stack(trace, tsk->thread.regs->gpr[1], tsk, 0);
+	save_context_stack(trace, tsk->thread.ksp, tsk, 0);
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
