Date: Thu, 14 Mar 2002 13:21:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Armin Kuster <akuster@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: ppc405_dma warnings
Message-ID: <20020314022146.GP22020@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Armin,

ppc405_dma.c has several constructs like:
	p_dma_ch->polarity = polarity & GET_DMA_POLARITY(0);
where GET_DMA_POLARITY() is defined:
	#define GET_DMA_POLARITY(chan) DMAReq##chan##_ActiveLow | \
		DMAAck##chan##_ActiveLow | EOT##chan##_ActiveLow

Note the macro has no parentheses around its definition, which is
unusual.  IIRC C precedence will mean this code turns out as:
	p_dma_ch->polarity = (polarity & DMAReq0_ActiveLow) | \
		DMAAck0_ActiveLow | EOT0_ActiveLow
which looks wrong to me and if correct is an insane use of a macro.
It's also giving compiler warnings.

I'm guessing that the macro should just get parentheses, but that's a
semantic change so I don't want to make it without knowing for sure.
Could you check this?

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
