Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 55D28DEA30
	for <linuxppc-dev@ozlabs.org>; Sat, 31 May 2008 06:55:52 +1000 (EST)
Date: Fri, 30 May 2008 15:48:20 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] talitos: Freescale integrated security engine (SEC)
	driver
Message-Id: <20080530154820.6e56b625.kim.phillips@freescale.com>
In-Reply-To: <48406562.4010306@freescale.com>
References: <20080529141250.0946b02c.kim.phillips@freescale.com>
	<20080530180904.GA18945@2ka.mipt.ru>
	<20080530143614.1e675228.kim.phillips@freescale.com>
	<4840585D.8050805@freescale.com>
	<20080530151638.087970ab.kim.phillips@freescale.com>
	<4840615F.4070103@freescale.com>
	<20080530153505.21eb1ec4.kim.phillips@freescale.com>
	<48406562.4010306@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, linuxppc-dev@ozlabs.org,
	mr.scada@gmail.com, linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 30 May 2008 15:36:50 -0500
Scott Wood <scottwood@freescale.com> wrote:

> Kim Phillips wrote:
> > On Fri, 30 May 2008 15:19:43 -0500
> > Scott Wood <scottwood@freescale.com> wrote:
> > 
> >> Kim Phillips wrote:
> >>> On Fri, 30 May 2008 14:41:17 -0500
> >>> Scott Wood <scottwood@freescale.com> wrote:
> >>>
> >>>> Kim Phillips wrote:
> >>>>> On Fri, 30 May 2008 22:09:04 +0400
> >>>>> Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> >>>>>> Don't you want to protect against simultaneous access to register space
> >>>>>> from different CPUs? Or it is single processor board only?
> >>>>> Doesn't linux mask the IRQ line for the interrupt currently being
> >>>>> serviced, and on all processors?
> >>>> Yes.  Could there be interference from non-interrupt driver code on 
> >>>> another cpu (or interrupted code), though?
> >>> not that I can see - the fetch fifo register writes are protected with
> >>> per-channel spinlocks.
> >> But you don't take the spinlocks from the interrupt handler.
> > 
> > why can't fetch fifo registers be written the same time the ISR is
> > being accessed?
> 
> I don't know -- you brought them up.  My question was whether there's 
> anything that the ISR touches that is also touched by non-ISR code.
> 
sorry, by ISR I meant interrupt status registers.  but I can't tell
where the suspected simultaneous accesses are.  Evgeniy, can you point
out the register accesses you're talking about?

Kim
