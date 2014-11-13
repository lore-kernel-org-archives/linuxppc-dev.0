Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8086D1A0BB3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 13:42:15 +1100 (AEDT)
Message-ID: <1415846532.28703.3.camel@concordia>
Subject: Re: [PATCH] powerpc: mitigate impact of decrementer reset
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Clarke <pc@us.ibm.com>
Date: Thu, 13 Nov 2014 13:42:12 +1100
In-Reply-To: <546126DC.6090909@us.ibm.com>
References: <1412708517-84726-1-git-send-email-pc@us.ibm.com>
 <54343B54.4060500@us.ibm.com>
 <1415614083.5769.18.camel@kernel.crashing.org>
 <546126DC.6090909@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-11-10 at 14:58 -0600, Paul Clarke wrote:
> On 11/10/2014 04:08 AM, Benjamin Herrenschmidt wrote:
> > On Tue, 2014-10-07 at 14:13 -0500, Paul Clarke wrote:
> >> This patch short-circuits the reset of the decrementer, exiting after
> >> the decrementer reset, but before the housekeeping tasks if the only
> >> need for the interrupt is simply to reset it.  After this patch,
> >> the latency spike was measured at about 150 nanoseconds.
> >
> > Doesn't this break the irq_work stuff ? We trigger it with a set_dec(1);
> > and your patch will probably cause it to be skipped...
> 
> You're right.

Yeah, thanks Ben, that would have been bad.

So we'll need to come up with a different approach.
 
> I'm confused by the division between timer_interrupt() and 
> __timer_interrupt().  The former is called with interrupts disabled (and 
> enables them), but also calls irq_enter()/irq_exit().  Why are those 
> calls not in __timer_interrupt()?  (If they were, the short-circuit 
> logic might be a bit easier to put directly in __timer_interrupt(), 
> which would eliminate any duplicate code.)
> 
> It looks like __timer_interrupt is only called directly by the broadcast 
> timer IPI handler.  (Why is __timer_interrupt not static?)  Does this 
> path not need irq_enter/irq_exit?

I think I answered most of this in the other mail I just sent, but let me know
if not.

And __timer_interrupt() is static, if you have a new enough kernel :)

cheers
