Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 39BEDDDF05
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 09:00:25 +1000 (EST)
Date: Thu, 24 Jul 2008 18:00:19 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: lockdep badness
Message-ID: <20080724230018.GG9594@localdomain>
References: <20080724192300.GE9594@localdomain>
	<1216939496.11188.58.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1216939496.11188.58.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Thu, 2008-07-24 at 14:23 -0500, Nathan Lynch wrote:
> > I'm seeing warnings from the lockdep code itself in recent kernels on
> > a Power6 blade (v2.6.26 and benh's -next branch).
> > 
> > Something to do with powerpc's "lazy" interrupt-disabling, perhaps?
> > 
> > A couple of stack traces below, the first is from benh's tree, the
> > second is from 2.6.26.  The lockdep self-tests all pass at boot.
> 
> Interesting.
> 
> > [c0000000e787bc20] [c0000000e787bc70] 0xc0000000e787bc70 (unreliable)
> > [c0000000e787bca0] [c0000000000b5ac8] .lock_release+0x7c/0x208
> > [c0000000e787bd50] [c0000000005e12c0] ._spin_unlock_irqrestore+0x34/0x94
> > [c0000000e787bde0] [c00000000004d648] .pSeries_log_error+0x380/0x3f0
> > [c0000000e787bef0] [c00000000004d8e4] .rtasd+0x98/0x100
> > [c0000000e787bf90] [c000000000029d20] .kernel_thread+0x4c/0x68
> > Instruction dump:
> 
> This one is one I haven't managed to reproduce and didn't quite find out
> what could be causing it, but it was already reported by Badari (and in
> fact is referenced as a regression in Rafael list).

Okay.



> > Call Trace:
> > [c00000000fffbb10] [c00000000fffbbb0] 0xc00000000fffbbb0 (unreliable)
> > [c00000000fffbbb0] [c0000000005d8824] ._spin_unlock_irq+0x40/0x68
> > [c00000000fffbc40] [c000000000426708] .ipr_ioa_reset_done+0x218/0x2ac
> > [c00000000fffbd00] [c00000000041bdb8] .ipr_reset_ioa_job+0xc8/0xf4
> > [c00000000fffbd90] [c000000000424ffc] .ipr_isr+0x280/0x628
> > [c00000000fffbe50] [c0000000000ccc70] .handle_IRQ_event+0x58/0xd4
> > [c00000000fffbef0] [c0000000000cef4c] .handle_fasteoi_irq+0x128/0x1c8
> > [c00000000fffbf90] [c000000000029918] .call_handle_irq+0x1c/0x2c
> > [c000000000a63a20] [c00000000000d9cc] .do_IRQ+0x138/0x248
> > [c000000000a63ad0] [c000000000004ca8] hardware_interrupt_entry+0x28/0x2c
> > --- Exception: 501 at .raw_local_irq_restore+0x8c/0xa4
> >     LR = .cpu_idle+0x140/0x210
> > [c000000000a63e60] [c0000000005da07c] .rest_init+0x7c/0x98
> > [c000000000a63ee0] [c000000000866f10] .start_kernel+0x488/0x4b0
> > [c000000000a63f90] [c000000000008584] .start_here_common+0x4c/0xc8
> > Instruction dump:
> 
> This one is new to me. I will have a look. What machine is this ?

Power6 blade - JS22 (four cores), with single disk attached via IPR,
HEA for network... nothing exotic, I guess.  Not sure how recreatable
the ipr trace is, I've only seen it once (and with 2.6.26 only).  The
rtasd trace is pretty consistent on powerpc/next.
