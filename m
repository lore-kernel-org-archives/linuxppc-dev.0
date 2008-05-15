Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18476.51426.864747.201527@cargo.ozlabs.ibm.com>
Date: Fri, 16 May 2008 09:36:02 +1000
From: Paul Mackerras <paulus@samba.org>
To: Corey J Ashford <cjashfor@us.ibm.com>
Subject: Re: Feedback requested on switching the exception wrapper used
	for	the PMU interrupt on ppc64
In-Reply-To: <OFCAB2D7CB.BDD1D753-ON8725744A.00688AB6-8825744A.006C3754@us.ibm.com>
References: <1210833967.8297.76.camel@pasglop>
	<OFCAB2D7CB.BDD1D753-ON8725744A.00688AB6-8825744A.006C3754@us.ibm.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Corey J Ashford writes:

> Ideally, what I'm looking for is something that mimics the operation of
> MASKABLE_EXCEPTION_PSERIES.
> I've been looking at the kernel code (entry_64.S, exception.h, head_64.S)
> but am finding it quite complicated and hard to follow, particularly in the
> area of interrupt disabling wrt the soft and hard disable logic.
> 
> My initial thought is to do something like this in the beginning of my
> perfmon2 interrupt handler:
> 
> void perfmon_pmu_int_handler(struct pt_regs *regs) {
> 
>       if (get_paca()->soft_enabled == 0) {
>             /* disable hardware interrupts */
>             get_paca()->hard_enabled = 0;
>             regs->msr &= ^MSR_EE;
>             return;
>       }
> ...
> }
> 
> Does this seem like it might work?

That's a start (with ~MSR_EE rather than ^MSR_EE, of course).  You
also need to set a flag in that case, and test the flag in the part of
arch/powerpc/kernel/irq.c:raw_local_irq_restore() that hard-enables
interrupts.  If the flag is set then you should call back into the
perfmon2 code at that point (and clear the flag, of course).  You
could add a field to the paca for that flag.

You probably also want to read some of the PMU's SPRs when you first
get the interrupt and save their values away, and then when you get
the call back from raw_local_irq_restore, use the saved values rather
than what's currently in the SPRs, since the saved values will be more
accurate.

Paul.
