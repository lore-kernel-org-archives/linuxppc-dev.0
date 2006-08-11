Return-Path: <roger.larsson@norran.net>
Received: from mail.skekraft.net (ns.skekraft.net [213.199.96.131])
	by ozlabs.org (Postfix) with ESMTP id 6711867BCA
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Aug 2006 08:49:57 +1000 (EST)
Received: from icd.localnet (78.net216.skekraft.net [84.244.216.78])
	by mail.skekraft.net (Postfix) with ESMTP id 18016A401A
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Aug 2006 00:29:16 +0200 (CEST)
From: Roger Larsson <roger.larsson@norran.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Realtime preemption patch on PPC
Date: Sat, 12 Aug 2006 00:29:15 +0200
References: <1155251072.5950.80.camel@localhost>
	<200608110938.45385.bcook@bpointsys.com>
In-Reply-To: <200608110938.45385.bcook@bpointsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608120029.15236.roger.larsson@norran.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 11 August 2006 16:38, Brent Cook wrote:
> On Thursday 10 August 2006 18:04, Ben Weintraub wrote:
> > Howdy,
> >
> > I'm wondering if anyone has had success getting Ingo Molnar's realtime
> > preemption patch (the one here:
> > http://people.redhat.com/mingo/realtime-preempt/ ) working on the ppc
> > arch.
>
> I have gotten them to work with MPC7448 boards, but it has hardware
> floating point, so no math-emu problems.
>
> > Anyhow, when I boot on an MPC8555 with my hack, I get an endless stream
> > of:
> >
> > BUG: sleeping function called from invalid context init(1) at
> > arch/powerpc/math-emu/math.c:226
> > in_atomic():0 [00000000], irqs_disabled():1
> > Call Trace:
> > [A0BB3E90] [A000934C] show_stack+0x48/0x194 (unreliable)
> > [A0BB3EC0] [A001B7DC] __might_sleep+0xe8/0xf4
> > [A0BB3EE0] [A00136C0] do_mathemu+0x30/0x8c8
> > [A0BB3F00] [A00036AC] program_check_exception+0x1ac/0x514
> > [A0BB3F40] [A0002A08] ret_from_except_full+0x0/0x4c
> >
> > Line 226 in arch/powerpc/math-emu/math.c is part of the do_mathemu()
> > function, and contains a call to get_user(), which calls
> > __might_sleep(), causing this problem.
It is not the might sleep that is the problem. Nor the get_user.
It is that the irqs are DISABLED.
If the thread goes to sleep it might never wake up! (With interrupts disabled
what HW can not notify SW that it is live...)

1) Floating point in kernel is difficult to handle due to lazy register saving
2) When using a processor without hardware floating point, compile with 
library (to avoid taking exceptions due to unimplemented instructions with
emulation)

My guess is that you have a driver that disables interrupts, does floating 
point calculations expecting that it has floating point support, takes an 
exception, exception code does not expect to get an exception from kernel
space and absolutely not when having interrupts disabled...

Recompile with soft float, or even better use fixed point calculations!

/RogerL
