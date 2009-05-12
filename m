Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [59.145.155.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp08.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 82D15DDFA0
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 06:25:54 +1000 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp08.in.ibm.com (8.13.1/8.13.1) with ESMTP id n4CJhlZs029524
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 01:13:47 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4CKPmPQ1630302
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 01:55:49 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.13.1/8.13.3) with ESMTP id n4CKPlR4020453
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 06:25:48 +1000
Date: Wed, 13 May 2009 01:55:45 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [RFC] Hardware Breakpoint interfaces implementation for PPC64
Message-ID: <20090512202545.GE6033@in.ibm.com>
References: <20090511200355.GA17988@in.ibm.com>
	<20090512115149.GA1885@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090512115149.GA1885@yoda.jdub.homelinux.org>
Cc: linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@au1.ibm.com>,
	paulus@samba.org
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 12, 2009 at 07:51:49AM -0400, Josh Boyer wrote:
> On Tue, May 12, 2009 at 01:33:55AM +0530, K.Prasad wrote:
> >Hi PPC Dev folks,
> >	Please find a patch below that implements the proposed Hardware
> >Breakpoint interfaces for PPC64 architecture.
> >
> >As a brief introduction, the proposed Hardware Breakpoint
> >infrastructure provides generic in-kernel interfaces to which users
> >from kernel- and user-space can request for breakpoint registers. An
> >ftrace plugin that can trace accesses to data variables is also part
> >of the generic HW Breakpoint interface patchset. The latest submission
> >for this patchset along with an x86 implementation can be found here:
> >http://lkml.org/lkml/2009/5/11/159.
> >
> >The following are the salient features of the PPC64 patch.
> >
> >- Arch-specific definitions for kernel and user-space requests are
> >  defined in arch/powerpc/kernel/hw_breakpoint.c
> >- Ptrace is converted to use the HW Breakpoint interfaces
> >- The ftrace plugin called ksym_tracer is tested to work fine. For
> >  instance when tracing pid_max kernel variable, the following was
> >  obtained as output
> >
> ># cat trace
> ># tracer: ksym_tracer
> >#
> >#       TASK-PID      CPU#      Symbol         Type    Function         
> >#          |           |          |              |         |            
> >bash            4502  3   pid_max               RW  .do_proc_dointvec_minmax_conv+0x78/0x10c
> >bash            4502  3   pid_max               RW  .do_proc_dointvec_minmax_conv+0xa0/0x10c
> >bash            4502  3   pid_max               RW  .alloc_pid+0x8c/0x4a4
> >
> >There are however a few limitations/caveats of the patch as identified
> >below:
> >
> >- The patch is currently implemented only for PPC64 architecture. Other
> >  architectures (especially Book-E implementations are expected to
> >  happen in due course).
> 
> Does this mean you will work on transitioning Book-E implementations, or that
> you expect the Book-E maintainers to?  I'm just curious.  The code as written
> relies heavily on the DABR/MSR setup that ppc64 has and Book-E unfortunately
> doesn't follow that at all.
> 
> Book-E also allows for more than one HW breakpoint, which means you're growing
> the thread_struct by 32-bytes to support 4 of them.  64-bytes if this ever
> supports DAC events.  Have you thought at all about a way to support this
> without carrying around the data in the thread struct?
> 
> <snip>
>

The idea behind embedding the physical debug register values in
thread_struct is to use its synchronisation mechanisms for HW Breakpoint
related fields too. These values were originally maintained in a
separate structure whose pointer lay in thread_struct but was modified
based on a suggestion from Ingo Molnar (here:
http://lkml.org/lkml/2009/3/10/210).

I do see that Book-E processors will have severe memory footprint
constraints (in embedded environment) and if the maintainers carry a
different perspective (than the one cited above), the relevant fields
can be migrated to a new structure whose pointer will be embedded in
task_struct. The generic code may have to carry some #ifdefs though.

 
> >Index: linux-2.6-tip.hbkpt/arch/powerpc/mm/fault.c
> >===================================================================
> >--- linux-2.6-tip.hbkpt.orig/arch/powerpc/mm/fault.c
> >+++ linux-2.6-tip.hbkpt/arch/powerpc/mm/fault.c
> >@@ -137,6 +137,12 @@ int __kprobes do_page_fault(struct pt_re
> > 		error_code &= 0x48200000;
> > 	else
> > 		is_write = error_code & DSISR_ISSTORE;
> >+
> >+	if (error_code & DSISR_DABRMATCH) {
> >+		/* DABR match */
> >+		do_dabr(regs, address, error_code);
> >+		return 0;
> >+	}
> > #else
> > 	is_write = error_code & ESR_DST;
> > #endif /* CONFIG_4xx || CONFIG_BOOKE */
> >@@ -151,14 +157,6 @@ int __kprobes do_page_fault(struct pt_re
> > 	if (!user_mode(regs) && (address >= TASK_SIZE))
> > 		return SIGSEGV;
> > 
> >-#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
> >-  	if (error_code & DSISR_DABRMATCH) {
> >-		/* DABR match */
> >-		do_dabr(regs, address, error_code);
> >-		return 0;
> >-	}
> >-#endif /* !(CONFIG_4xx || CONFIG_BOOKE)*/
> >-
> > 	if (in_atomic() || mm == NULL) {
> > 		if (!user_mode(regs))
> > 			return SIGSEGV;
> 
> 
> I don't understand why this was changed, and the changelog doesn't highlight it.
> 
> josh

The intention is to capture the exception much before kprobes and xmon
do. The HW Breakpoint exception handler will return NOTIFY_DONE if the
exception doesn't belong to it and doesn't harm the rest. kprobes has
been tested to work fine alongwith HW Breakpoints.

I will add a description about this change in the next iteration of the
patch.

Thanks,
K.Prasad
