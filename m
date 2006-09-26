Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 4B36D67B72
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 16:11:32 +1000 (EST)
Date: Tue, 26 Sep 2006 01:10:55 -0500
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Lazy interrupt disabling for 64-bit machines
Message-ID: <20060926011055.32d533e7@pb15>
In-Reply-To: <17688.45762.294594.33723@cargo.ozlabs.ibm.com>
References: <17688.45762.294594.33723@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 26 Sep 2006 14:55:30 +1000 Paul Mackerras <paulus@samba.org> wrote:

> This implements a lazy strategy for disabling interrupts.  This means
> that local_irq_disable() et al. just clear the 'interrupts are
> enabled' flag in the paca.  If an interrupt comes along, the interrupt
> entry code notices that interrupts are supposed to be disabled, and
> clears the EE bit in SRR1, clears the 'interrupts are hard-enabled'
> flag in the paca, and returns.  This means that interrupts only
> actually get disabled in the processor when an interrupt comes along.
> 
> When interrupts are enabled by local_irq_enable() et al., the code
> sets the interrupts-enabled flag in the paca, and then checks whether
> interrupts got hard-disabled.  If so, it also sets the EE bit in the
> MSR to hard-enable the interrupts.
> 
> This has the potential to improve performance, and also makes it
> easier to make a kernel that can boot on iSeries and on other 64-bit
> machines, since this lazy-disable strategy is very similar to the
> soft-disable strategy that iSeries already uses.

I like it. Got any benchmarks that show a difference?

At first glance I found it a bit hard to follow, since the old+new
terminology is a bit complicated. There's softe, proc_enabled and
hard_enabled. A s/proc_enabled/soft_enabled/g (and similar for
asm-offsets) might make it a little more intuitive, since you're
touching most uses of it already?



-Olof
