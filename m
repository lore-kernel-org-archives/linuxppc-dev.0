Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrNtl0K31zF1JT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 03:09:27 +1100 (AEDT)
Date: Tue, 27 Feb 2018 17:09:24 +0100
From: Torsten Duwe <duwe@lst.de>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jiri Kosina <jkosina@suse.cz>,
 Balbir Singh <bsingharora@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, live-patching@vger.kernel.org
Subject: [PATCH 2/2] ppc64le save_stack_trace_tsk_reliable (Was:
 HAVE_RELIABLE_STACKTRACE)
Message-ID: <20180227160924.GA19111@lst.de>
References: <20171004152516.25803-1-kamalesh@linux.vnet.ibm.com>
 <20171005124313.GA25100@lst.de>
 <9f388c9a-8d74-865a-b113-f77322918b39@linux.vnet.ibm.com>
 <20171017144733.GB2136@lst.de>
 <95e6f942-88b7-0208-0eb0-2f5462aec410@linux.vnet.ibm.com>
 <20171020120739.GA20306@lst.de> <1508547548.5662.2.camel@gmail.com>
 <39bb7180-1adf-4df6-c9ba-c6f92754767f@linux.vnet.ibm.com>
 <20171212113912.GA1907@lst.de>
 <alpine.LSU.2.21.1712121308440.21907@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LSU.2.21.1712121308440.21907@pobox.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 12, 2017 at 01:12:37PM +0100, Miroslav Benes wrote:
> 
> I think that this is not enough. You need to also implement 
> save_stack_trace_tsk_reliable() for powerpc defined as __weak in 
> kernel/stacktrace.c.

So here is my initial proposal. I'd really like to get the successful
exit stricter, i.e. hit the initial stack value exactly instead of just
a window. Also, the check for kernel code looks clumsy IMHO. IOW:
Comments more than welcome!

Most of it is Copy&Waste, nonetheless:

Signed-off-by: Torsten Duwe <duwe@suse.de>


diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index d534ed901538..e08af49e71d0 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -13,6 +13,7 @@
 #include <linux/export.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
+#include <linux/sched/task_stack.h>
 #include <linux/stacktrace.h>
 #include <asm/ptrace.h>
 #include <asm/processor.h>
@@ -76,3 +77,58 @@ save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
 	save_context_stack(trace, regs->gpr[1], current, 0);
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_regs);
+
+#ifdef CONFIG_HAVE_RELIABLE_STACKTRACE
+int
+save_stack_trace_tsk_reliable(struct task_struct *tsk,
+                              struct stack_trace *trace)
+{
+	unsigned long sp;
+	unsigned long stack_page = (unsigned long)task_stack_page(tsk);
+	/* the last frame (unwinding first) may not yet have saved its LR onto the stack. */
+	int firstframe = 1;
+
+	if (tsk == current)
+		sp = current_stack_pointer();
+	else
+		sp = tsk->thread.ksp;
+
+	if (sp < stack_page + sizeof(struct thread_struct)
+	    || sp > stack_page + THREAD_SIZE - STACK_FRAME_OVERHEAD)
+		return 1;
+	
+	for (;;) {
+		unsigned long *stack = (unsigned long *) sp;
+		unsigned long newsp, ip;
+
+		newsp = stack[0];
+		/* Stack grows downwards; unwinder may only go up */
+		if (newsp <= sp)
+			return 1;
+
+		if (newsp >= stack_page + THREAD_SIZE)
+			return 1; /* invalid backlink, too far up! */
+
+		/* Examine the saved LR: it must point into kernel code. */
+		ip = stack[STACK_FRAME_LR_SAVE];
+		if ( (ip & 0xEFFF000000000000) != CONFIG_KERNEL_START
+		     && !firstframe)
+			return 1;
+		firstframe = 0;
+
+		if (!trace->skip)
+			trace->entries[trace->nr_entries++] = ip;
+		else
+			trace->skip--;
+
+		if (newsp > stack_page + THREAD_SIZE - STACK_FRAME_OVERHEAD)
+			break; /* hit the window for last frame */
+
+		if (trace->nr_entries >= trace->max_entries)
+			return -E2BIG;
+
+		sp = newsp;
+	}
+	return 0;
+}
+#endif /* CONFIG_HAVE_RELIABLE_STACKTRACE */
