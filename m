Return-Path: <cjashfor@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B7B42DDEFD
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 12:04:43 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4G24eT4004411
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 22:04:40 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4G24dgc077660
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 20:04:39 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4G24daL028709
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 20:04:39 -0600
In-Reply-To: <18476.56587.887087.503435@cargo.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Subject: Re: Feedback requested on switching the exception wrapper
	used	for	the PMU interrupt on ppc64
Message-ID: <OFA799651B.BB2A2EE9-ON8725744B.00083D5B-8825744B.000B6945@us.ibm.com>
From: Corey J Ashford <cjashfor@us.ibm.com>
Date: Thu, 15 May 2008 19:04:36 -0700
Content-Type: text/plain; charset="US-ASCII"
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> wrote on 05/15/2008 06:02:03 PM:

> Corey J Ashford writes:
> 
> > Thanks for the feedback.  I don't believe I need a separate flag, 
because
> > the PMU interrupt (via the PMAO bit) will still be pending when 
interrupts
> > are hard enabled again, and the handler will be reentered 
automatically.
> 
> If that were the case then we wouldn't have had the problem with
> losing PMU interrupts that meant we had to change the PMU interrupt
> handler from a MASKABLE_EXCEPTION to a STD_EXCEPTION.  This was in
> commit 449d846dbcbf61bdf7d50a923e4791102168c292.
> 
> My understanding is that the PMU only requests an interrupt when PMAO
> goes from 0 to 1 (i.e. it's edge-triggered).  If the CPU takes the
> interrupt and then sets MSR.EE again (e.g. by returning from the
> interrupt handler), and PMAO has not been reset to 0, then I don't
> think the PMU requests another interrupt at that point.

I think that is the case on early POWER4 and PPC970 chips where this is no 
PMAO bit.  However, from personal [bad] experience, I can say that if PMAO 
is not cleared in the interrupt handler, the exception will be taken again 
when interrupts are reenabled.  I've seen the system lockup in interrupt 
handling "loops" because it wasn't being cleared.

> 
> > I discovered through some trial and error that get_paca() doesn't work
> > correctly in the interrupt handler.  It appears that the value of r13 
(the
> > PACA pointer) is not initialized.  Perhaps r13 is a scratch register 
used
> > by the compiler?
> 
> Weird.  It definitely should be correct.  Loading r13 is one of the
> first things the interrupt entry code does, and r13 is not a scratch
> register (it's normally the thread-local storage pointer).
> 
> If r13 is bogus then that's definitely a serious bug.

My evidence for this was that I was seeing get_paca()->soft_enable and 
get_paca()->hard_enable set to zero, but regs->softe set to 1.

Looking at the code again, I see that in STD_EXCEPTION_COMMON in 
exception.h, the macro DISABLE_INTS is used, which zeros out the soft and 
hard disable flags.  So r13 is ok, and I think using the regs struct is 
the right way to go.


> 
> > Fortunately, because the soft enable flag is available in the pt_regs
> > structure, and because the hard enable flag will be set to the same as 
the
> > value of regs->msr's MSR_EE flag in the restore code, I now have this 
code
> > in the interrupt handler:
> > 
> > void perfmon_pmu_int_handler(struct pt_regs *regs) {
> > 
> >       if (regs->softe == 0) {
> >             /* disable hardware interrupts */
> >             regs->msr &= ~MSR_EE;
> >             return;
> >       }
> >       ...
> > }
> > 
> > This code does seem to be working, but needs more testing.
> 
> I expect that after a little while you'll stop getting PMU
> interrupts...
> 
> Paul.

I haven't seen that yet, but I am seeing another kernel hang with my test 
case that creates and deals with about 2000 interrupts per second.  After 
a random amount of time running it, it hangs the system.  If I restart the 
system into xmon, I see a callstack that doesn't have any perfmon code in 
it, but does have some kernel interrupt handling code.  The hang is the 
same when using MASKABLE_EXCEPTION_PSERIES and STD_EXCEPTION_PSERIES (+ 
the above fix).

I'd love to be able to run that call stack by you, if you have time to 
look at it.

Thanks,

- Corey

Corey Ashford
Software Engineer
IBM Linux Technology Center, Linux Toolchain
Beaverton, OR 
503-578-3507 
cjashfor@us.ibm.com
