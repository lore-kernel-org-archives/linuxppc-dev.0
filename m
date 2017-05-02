Return-Path: <srs0=inet=4i=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wHB6V24DNzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 May 2017 16:22:42 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wHB6V1N3kz8sxx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 May 2017 16:22:42 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wHB6T4ZRzz9sDB
 for <linuxppc-dev@ozlabs.org>; Tue,  2 May 2017 16:22:41 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v426IpTX073047
 for <linuxppc-dev@ozlabs.org>; Tue, 2 May 2017 02:22:39 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a6frwmben-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 02 May 2017 02:22:38 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 2 May 2017 16:22:36 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v426MQkQ1966366
 for <linuxppc-dev@ozlabs.org>; Tue, 2 May 2017 16:22:34 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v426LuVP023182
 for <linuxppc-dev@ozlabs.org>; Tue, 2 May 2017 16:21:57 +1000
Date: Tue, 2 May 2017 11:51:32 +0530
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH v2] powerpc/book3s: mce: Move add_taint() later in
 virtual mode.
Reply-To: mahesh@linux.vnet.ibm.com
References: <149253349689.12722.1516352063236500616.stgit@jupiter.in.ibm.com>
 <874lxjbak1.fsf@possimpible.ozlabs.ibm.com>
 <87r30mtnc2.fsf@concordia.ellerman.id.au>
 <87y3ug1u1t.fsf@possimpible.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87y3ug1u1t.fsf@possimpible.ozlabs.ibm.com>
Message-Id: <20170502062132.GA30664@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017-05-02 01:22:06 Tue, Daniel Axtens wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> 
> > Daniel Axtens <dja@axtens.net> writes:
> >>> diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
> >>> index a1475e6..b23b323 100644
> >>> --- a/arch/powerpc/kernel/mce.c
> >>> +++ b/arch/powerpc/kernel/mce.c
> >>> @@ -221,6 +221,8 @@ static void machine_check_process_queued_event(struct irq_work *work)
> >>>  {
> >>>  	int index;
> >>>  
> >>> +	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
> >>> +
> >> This bit makes sense...
> >>
> >>> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> >>> index ff365f9..af97e81 100644
> >>> --- a/arch/powerpc/kernel/traps.c
> >>> +++ b/arch/powerpc/kernel/traps.c
> >>> @@ -741,6 +739,8 @@ void machine_check_exception(struct pt_regs *regs)
> >>>  
> >>>  	__this_cpu_inc(irq_stat.mce_exceptions);
> >>>  
> >>> +	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
> >>> +
> >>
> >> But this bit I'm not sure about.
> >>
> >> Isn't machine_check_exception called from asm in
> >> kernel/exceptions-64s.S? As in, it's called really early/in real mode?
> >
> > It is called from there, in asm, but not from real mode AFAICS.
> >
> > There's a call from machine_check_common(), we're already in virtual
> > mode there.
> >
> > The other call is from unrecover_mce(), and both places that call that
> > do so via rfid, using PACAKMSR, which should turn on virtual mode.
> >
> >
> > But none of that really matters. The fundamental issue here is we can't
> > recursively call OPAL, that's what matters.
> 
> Ah right, yes. Every time I think I understand MCEs, it is made plain to
> me that I do not. I have been trying to compose a coherent reply for
> over an hour and every time I think I have got somewhere I find a
> massive issue in my understanding. But here goes!
> 
> > So if we were in OPAL and take an MCE, then we must not call OPAL again
> > from the MCE handler.
> 
> If I'm correctly understanding the code, this includes the non-early
> handlers (ppc_md.machine_check_exception) as well as the early handlers
> (ppc_md.machine_check_early). Is that right?

Yes, the early handler runs in real mode and non-early handler gets called
in virtual mode. The early handler tries to recover from soft errors and
generates an MCE event. There are following scenarios where above handler's
get called depending on whether error have been recovered or not:

1. MCE in kernel/OPAL
	- Call ppc_md.machine_check_early() handler in real mode
	  - Try to recover from soft errors and generate event.
	  - if Recovered:
	    - queue the event for work queue to print later
	    - Go back to kernel/OPAL code
	  - else if not recovered
	    - Switch to virtual mode
	    - call ppc_md.machine_check_exception()
	      - print event and panic

2. MCE in userspace
	- Call ppc_md.machine_check_early() handler in real mode
          - Try to recover from soft errors and generate event.
	- Switch to virtual mode
	- call ppc_md.machine_check_exception()
          - Print event.
	  - if recovered:
	    - Return from interrupt.
	  - else if not recovered:
	    - Kill the process
	    - Return from interrupt.
> 
> So the only place we're safe to do prints is in the 'bottom half' on the
> other side of the work queue?
> 
> > This fixes one case where we know that can happen, but AFAICS we are not
> > protected in general from it.
> >
> > For example if we take an MCE in OPAL, decide it's not recoverable and
> > go to unrecover_mce(), that will call machine_check_exception() which
> > can then call OPAL via printk.
> 
> (Assuming I understand the code, we probably won't get that far because
> we'll attempt an opal reboot and a panic in opal_machine_check - but
> carrying on...)
> 
> I think I see what you mean: even without any tainting, panic() will
> printk(), which will take us back to OPAL.
> 
> I *think* we can fix this with a tweak to opal_machine_check. It pulls
> the event off the work-queue and prints it, but I now think it
> shouldn't; it just try to recover. If it can't recover it should proceed
> to do the opal_cec_reboot2. That might fail on a BMC system or an early
> firmware level, leaving the machine hosed, but it was about to panic
> anyway.
> 
> We can then leave popping the event and printing it to the bottom
> half/work queue.
> 
> ... assuming I have understood it correctly. Thoughts?
> 
> > Or maybe there's a check in there somewhere that makes it OK, but it's
> > not clear to me.
> 
> More immediately, what I'm confused by (amongst many other things!) -
> and maybe Mahesh you can enlighten me - is this: what situation is
> caught by this add_taint() in machine_check_exception? If we're about to
> die, tainting the kernel is probably not the most useful thing to do. As
> I understand it, if we're not about to die, we'll print out the taint in
> the 'bottom half'/work queue side. Is this right?

machine_check_exception() gets called for unrecovered MCE in kernel/OPAL, and
MCE in userspace. For MCE in kernel and userspace, we are safe to call
add_taint from machine_check_exception() even if it calls OPAL for printk.

Now for MCE in OPAL, there are two cases:
1. Recovered MCE:
   - MCE handler queue's up the event to print it later
   - Return to currently executing OPAL routine.
   - When scheduled, work queue calls the add_taint and prints the event.
   - machine_check_exception() never gets called.

   Not calling add_taint() (or anything that could make OPAL call) from MCE
   handler prevents OPAL stack corruption. This makes MCE handler to
   safely return to currently executing OPAL routine.

2. Unrecovered MCE:
   - Can't return to currently executing OPAL routine.
   - kernel needs to print the event and call panic.
   - Switch to virtual mode and call machine_check_exception()
   - machine_check_exception() calls add_taint() and panic()

Now for case (2), kernel needs to panic. Since MCE handler will never go back
to currently executing OPAL routine, we should be now safe to call add_taint()
or new OPAL call. Kernel can now print event and head to panic or call
opal_cec_reboot2().

Thanks,
-Mahesh.
