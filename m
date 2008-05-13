Return-Path: <olof@lixom.net>
Received: from elcamino.pasemi.com (elcamino.pasemi.com [67.155.108.98])
	by ozlabs.org (Postfix) with ESMTP id 687CADDF2D
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 08:19:15 +1000 (EST)
Message-Id: <DFA27E66-0B8C-4CBF-9C6F-692A3B8DCED8@lixom.net>
From: Olof Johansson <olof@lixom.net>
To: Corey Ashford <cjashfor@us.ibm.com>
In-Reply-To: <482A10AF.6040205@us.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: Feedback requested on switching the exception wrapper used for
	the PMU interrupt on ppc64
Date: Tue, 13 May 2008 17:13:31 -0500
References: <482A10AF.6040205@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, eranian@googlemail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On May 13, 2008, at 5:05 PM, Corey Ashford wrote:

> Hello,
>
> One of the things I've been working on is porting perfmon2 to ppc64.  
> We've made a fair amount of progress on it, and support is available  
> in libpfm and the perfmon2 kernel patch.
>
> One of the things we had to work around was the "lazy interrupt  
> disabling" mechanism in ppc64 Linux.  The problem was that the PMU  
> exception handler (0xf00) uses the STD_EXCEPTION_PSERIES wrapper,  
> which does not support lazy interrupt disabling.
>
> This is desirable for Oprofile's use of the PMU since its handler is  
> fairly simple and being able to profile interrupt protected code is  
> desirable.  However, it causes problems for perfmon2, since the  
> operations it performs on the thread of its PMU interrupt handler  
> can cause a deadlock condition (it can end up calling spin_lock, for  
> example).
>
> Initially, to work around this, we created special spin_lock_irqsave  
> and spin_unlock_irqrestore macros for perfmon2 which we could  
> override for POWER to define them as functions which do hard  
> disables and restores.
>
> However, not all of the places that we need to disable interrupts  
> were occurring from within the perfmon2 code.  Specifically, getting  
> PMU interrupts in the middle of a schedule() call (where interrupts  
> were expected to be disabled) was causing kernel hangs.
>
> To fix this, I've gone back and removed the special spin_lock macros  
> we defined in perfmon2 and have ifdef'd arch/powerpc/kernel/ 
> head_64.S file as follows:
>
> /*** pSeries interrupt support ***/
>
>        /* moved from 0xf00 */
> + #ifdef CONFIG_PERFMON
> +         MASKABLE_EXCEPTION_PSERIES(., performance_monitor)
> + #else
>        STD_EXCEPTION_PSERIES(., performance_monitor)
> + #endif
>
> /*
> * An interrupt came in while soft-disabled; clear EE in SRR1,
> * clear paca->hard_enabled and return.
>
> The downside of this change is that if someone is using Oprofile and  
> they have enabled perfmon in their kernel, they will not get profile  
> samples that occur in interrupt-protected regions of the kernel.  
> However, they still can by configuring perfmon out of their kernel.
>
> What do you think of this idea?  Is this something that you would  
> object to when perfmon2 does go upstream to LKML?  I think we'd want  
> to add some documentation somewhere that describes this side-effect  
> of enabling perfmon in the ppc64 Linux kernel.  Do you have  
> suggestions on where that should go?  I'm thinking perhaps in both  
> the basic_profiling.txt and perfmon2.txt files in the Documentation  
> subdirectory.

Since you didn't post the perfmon2 code, I'll ask instead of go look:

Do you have a single entry point from performance_monitor into  
perfmon2? If so, it's nicer to check and see if interrupts are soft  
disabled right upon entry (before taking any locks, etc), and if they  
are just return without doing more work.

PMU interrupts generally won't re-arm themselves so you'll obviously  
have to deal with that as well but I'm sure you're already aware of  
that...


-Olof
