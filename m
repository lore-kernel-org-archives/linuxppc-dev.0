Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9C31DDDDFA
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2008 12:00:38 +1100 (EST)
Subject: Re: pmac_zilog debugging ...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Diggs <kevdig@hypersurf.com>
In-Reply-To: <491CAA32.20307@hypersurf.com>
References: <4914B549.9010805@hypersurf.com>
	<1226096603.13603.74.camel@pasglop> <491C11B2.1060909@hypersurf.com>
	<1226612654.7178.84.camel@pasglop>  <491CAA32.20307@hypersurf.com>
Content-Type: text/plain
Date: Fri, 14 Nov 2008 12:00:29 +1100
Message-Id: <1226624429.7178.105.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-11-13 at 14:29 -0800, Kevin Diggs wrote:
> Benjamin Herrenschmidt wrote:
> > On Thu, 2008-11-13 at 03:38 -0800, Kevin Diggs wrote:
> > 
> > 
> >>12,206 PowerMac Zilog interrupts
> >>
> >>Interrupt load is higher without the DMA support.
> >>
> >>Is it possible that this hardware was not meant to be used without the
> >>DMA (i.e. it does not work quite right?)?
> > 
> > 
> > Well, the HW Rx buffer is only 3 bytes so if you have high interrupt
> > latencies you are more likely to loose data...
> > 
> These are not real 8530s any more, right? How certain are we of this?
> Is it possible that there is a larger buffer when used with the DMA
> capability ... somehow?

Well, the main thing is that when using DMA, it doesn't need to wait for
the kernel to come fetch the bytes, and thus the only latency that
matters if the DMA list is appropriately provisioned is the bus latency,
which is much less likely to be an issue even with a small buffer.

It's definitely not a "basic" 8530, it's an ESCC but I don't think the
base rx buffer in polled mode is any bigger (I may be wrong).

> I tried to put some debug statements where the flow lines are managed. I
> could have goofed it up. They never produce any output. The latest
> attempt used nortscts which should have disabled flow control. That
> coupled with the fact that a 250 MHz 750GX is talking to a 486dx4 at
> 1200 - 9600 baud I would have thought would reduce the chance the PowerMac
> would fall behind?

Have you disabled flow control both with the old macserial -and-
pmac_zilog and still experiencing the same problems ? (ie one works and
the other one doesn't ?)

> You would need to explain to me the advantage of doing DMA in this case???

Well, if I setup for example 128 DMA descriptors for 1 byte each, then
the chip will be able to DMA up to 128 bytes without CPU intervention,
thus is a -lot- less likely to overflow it's fifo. It's essentially a
way to have the DMA engine operate as an external FIFO. As the CPU
fetches the bytes, it can recycle the descriptors at the end of the list
effectively acting as some kind of ring buffer.

We can more easily do DMA for Tx but while this can improve performances
and lower interrupt usage, it is not a correctness issue in the sense
that Tx isn't -losing- data today, it's Rx that is a potential problem.

Cheers,
Ben.
