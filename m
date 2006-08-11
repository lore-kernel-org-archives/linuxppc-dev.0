Return-Path: <bcook@bpointsys.com>
Received: from bpointsys.com (70-253-197-251.ded.swbell.net [70.253.197.251])
	by ozlabs.org (Postfix) with ESMTP id 28E0867A3E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Aug 2006 00:50:46 +1000 (EST)
From: Brent Cook <bcook@bpointsys.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Realtime preemption patch on PPC
Date: Fri, 11 Aug 2006 09:38:45 -0500
References: <1155251072.5950.80.camel@localhost>
In-Reply-To: <1155251072.5950.80.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608110938.45385.bcook@bpointsys.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 10 August 2006 18:04, Ben Weintraub wrote:
> Howdy,
>
> I'm wondering if anyone has had success getting Ingo Molnar's realtime
> preemption patch (the one here:
> http://people.redhat.com/mingo/realtime-preempt/ ) working on the ppc
> arch.

I have gotten them to work with MPC7448 boards, but it has hardware floating 
point, so no math-emu problems.

> Anyhow, when I boot on an MPC8555 with my hack, I get an endless stream
> of:
>
> BUG: sleeping function called from invalid context init(1) at
> arch/powerpc/math-emu/math.c:226
> in_atomic():0 [00000000], irqs_disabled():1
> Call Trace:
> [A0BB3E90] [A000934C] show_stack+0x48/0x194 (unreliable)
> [A0BB3EC0] [A001B7DC] __might_sleep+0xe8/0xf4
> [A0BB3EE0] [A00136C0] do_mathemu+0x30/0x8c8
> [A0BB3F00] [A00036AC] program_check_exception+0x1ac/0x514
> [A0BB3F40] [A0002A08] ret_from_except_full+0x0/0x4c
>
> Line 226 in arch/powerpc/math-emu/math.c is part of the do_mathemu()
> function, and contains a call to get_user(), which calls
> __might_sleep(), causing this problem.
>
