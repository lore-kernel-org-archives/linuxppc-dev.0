Return-Path: <jwboyer@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.24])
	by ozlabs.org (Postfix) with ESMTP id 29E5ADDF86
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 22:00:09 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so2193943qwe.15
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 05:00:07 -0700 (PDT)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Tue, 12 May 2009 07:51:49 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [RFC] Hardware Breakpoint interfaces implementation for PPC64
Message-ID: <20090512115149.GA1885@yoda.jdub.homelinux.org>
References: <20090511200355.GA17988@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090511200355.GA17988@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@au1.ibm.com>,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 12, 2009 at 01:33:55AM +0530, K.Prasad wrote:
>Hi PPC Dev folks,
>	Please find a patch below that implements the proposed Hardware
>Breakpoint interfaces for PPC64 architecture.
>
>As a brief introduction, the proposed Hardware Breakpoint
>infrastructure provides generic in-kernel interfaces to which users
>from kernel- and user-space can request for breakpoint registers. An
>ftrace plugin that can trace accesses to data variables is also part
>of the generic HW Breakpoint interface patchset. The latest submission
>for this patchset along with an x86 implementation can be found here:
>http://lkml.org/lkml/2009/5/11/159.
>
>The following are the salient features of the PPC64 patch.
>
>- Arch-specific definitions for kernel and user-space requests are
>  defined in arch/powerpc/kernel/hw_breakpoint.c
>- Ptrace is converted to use the HW Breakpoint interfaces
>- The ftrace plugin called ksym_tracer is tested to work fine. For
>  instance when tracing pid_max kernel variable, the following was
>  obtained as output
>
># cat trace
># tracer: ksym_tracer
>#
>#       TASK-PID      CPU#      Symbol         Type    Function         
>#          |           |          |              |         |            
>bash            4502  3   pid_max               RW  .do_proc_dointvec_minmax_conv+0x78/0x10c
>bash            4502  3   pid_max               RW  .do_proc_dointvec_minmax_conv+0xa0/0x10c
>bash            4502  3   pid_max               RW  .alloc_pid+0x8c/0x4a4
>
>There are however a few limitations/caveats of the patch as identified
>below:
>
>- The patch is currently implemented only for PPC64 architecture. Other
>  architectures (especially Book-E implementations are expected to
>  happen in due course).

Does this mean you will work on transitioning Book-E implementations, or that
you expect the Book-E maintainers to?  I'm just curious.  The code as written
relies heavily on the DABR/MSR setup that ppc64 has and Book-E unfortunately
doesn't follow that at all.

Book-E also allows for more than one HW breakpoint, which means you're growing
the thread_struct by 32-bytes to support 4 of them.  64-bytes if this ever
supports DAC events.  Have you thought at all about a way to support this
without carrying around the data in the thread struct?

<snip>

>Index: linux-2.6-tip.hbkpt/arch/powerpc/mm/fault.c
>===================================================================
>--- linux-2.6-tip.hbkpt.orig/arch/powerpc/mm/fault.c
>+++ linux-2.6-tip.hbkpt/arch/powerpc/mm/fault.c
>@@ -137,6 +137,12 @@ int __kprobes do_page_fault(struct pt_re
> 		error_code &= 0x48200000;
> 	else
> 		is_write = error_code & DSISR_ISSTORE;
>+
>+	if (error_code & DSISR_DABRMATCH) {
>+		/* DABR match */
>+		do_dabr(regs, address, error_code);
>+		return 0;
>+	}
> #else
> 	is_write = error_code & ESR_DST;
> #endif /* CONFIG_4xx || CONFIG_BOOKE */
>@@ -151,14 +157,6 @@ int __kprobes do_page_fault(struct pt_re
> 	if (!user_mode(regs) && (address >= TASK_SIZE))
> 		return SIGSEGV;
> 
>-#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
>-  	if (error_code & DSISR_DABRMATCH) {
>-		/* DABR match */
>-		do_dabr(regs, address, error_code);
>-		return 0;
>-	}
>-#endif /* !(CONFIG_4xx || CONFIG_BOOKE)*/
>-
> 	if (in_atomic() || mm == NULL) {
> 		if (!user_mode(regs))
> 			return SIGSEGV;


I don't understand why this was changed, and the changelog doesn't highlight it.

josh
