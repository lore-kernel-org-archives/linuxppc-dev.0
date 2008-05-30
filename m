Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 10635DE304
	for <linuxppc-dev@ozlabs.org>; Sat, 31 May 2008 08:21:17 +1000 (EST)
Date: Fri, 30 May 2008 17:19:30 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [PATCH 2/2] talitos: Freescale integrated security engine (SEC)
	driver
Message-Id: <20080530171930.61965d59.kim.phillips@freescale.com>
In-Reply-To: <20080530211204.GA15768@2ka.mipt.ru>
References: <20080529141250.0946b02c.kim.phillips@freescale.com>
	<20080530180904.GA18945@2ka.mipt.ru>
	<20080530143614.1e675228.kim.phillips@freescale.com>
	<4840585D.8050805@freescale.com>
	<20080530151638.087970ab.kim.phillips@freescale.com>
	<4840615F.4070103@freescale.com>
	<20080530153505.21eb1ec4.kim.phillips@freescale.com>
	<48406562.4010306@freescale.com>
	<20080530154820.6e56b625.kim.phillips@freescale.com>
	<20080530211204.GA15768@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
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

On Sat, 31 May 2008 01:12:08 +0400
Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:

> On Fri, May 30, 2008 at 03:48:20PM -0500, Kim Phillips (kim.phillips@freescale.com) wrote:
> > sorry, by ISR I meant interrupt status registers.  but I can't tell
> > where the suspected simultaneous accesses are.  Evgeniy, can you point
> > out the register accesses you're talking about?
> 
> priv->status is accessed from tasklets, although readonly, but that rises
> a red flag... Also callback invocation tasklet drops the lock around

ok, I see what you are saying now; if a channel gets done during
talitos_done processing, it'll trigger an interrupt and reset
priv->status, leaving the tasklet in the dark as to which channel has
done status, depending on how many channel dones it has already
processed.  I think the only solution here is to call flush_channel on
each channel, regardless of the bits in the interrupt status - I'll
send out a patch shortly.

> callback, during that time cached status and priv itself (and tail like
> in two simultaneous flushes) could change (or not?)

I think you're talking about a different 'status' here; flush_channel's
local 'status' doesn't resemble priv->status bits in any way, it looks
at the descriptor header writeback bits for done status, on a per
descriptor basis.  It forwards this descriptor done vs. error status to
the callback.

priv itself won't change; it's uniquely associated to the device.

Kim
