Date: Thu, 14 Mar 2002 17:17:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppc405_dma warnings
Message-ID: <20020314061743.GA1755@zax>
References: <20020314022146.GP22020@zax> <3C8FBEC2.4030206@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3C8FBEC2.4030206@pacbell.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Mar 13, 2002 at 09:04:02PM +0000, Armin wrote:
> David Gibson wrote:
> >Armin,
> >
> >ppc405_dma.c has several constructs like:
> >	p_dma_ch->polarity = polarity & GET_DMA_POLARITY(0);
> >where GET_DMA_POLARITY() is defined:
> >	#define GET_DMA_POLARITY(chan) DMAReq##chan##_ActiveLow | \
> >		DMAAck##chan##_ActiveLow | EOT##chan##_ActiveLow
> >
> >Note the macro has no parentheses around its definition, which is
> >unusual.  IIRC C precedence will mean this code turns out as:
> >	p_dma_ch->polarity = (polarity & DMAReq0_ActiveLow) | \
> >		DMAAck0_ActiveLow | EOT0_ActiveLow
> >which looks wrong to me and if correct is an insane use of a macro.
> >It's also giving compiler warnings.
> >
> >I'm guessing that the macro should just get parentheses, but that's a
> >semantic change so I don't want to make it without knowing for sure.
> >Could you check this?
>
> Thanks.. I missed the parentheses.  The macro is there to allow me to
> use the same driver for the 405gp dma and the stb0xxxx cpu since the the
> stbxxxx does not have a polarity.  I could have poluted the driver with
> #ifdefs or mask the deltas with a few macros.  I went with macros.

Seems reasonable.  Will you put in the missing parentheses, or should
I?

> armin
>
> PS I am insane

That may be true, but accidentally missing the () doesn't prove it.
Deliberately missing the () would :-)

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
