Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 03319B7082
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Sep 2009 10:39:18 +1000 (EST)
Subject: Re: [PATCH 1/2] ibm_newemac: Add Support for MAL Interrupt Coalescing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: prodyut hazarika <prodyuth@gmail.com>
In-Reply-To: <49c0ff980909211728s2d39e356p6900d047c6918826@mail.gmail.com>
References: <1253573245-1867-1-git-send-email-phazarika@amcc.com>
	<1253576514.7103.165.camel@pasglop>
	<0CA0A16855646F4FA96D25A158E299D606FFE802@SDCEXCHANGE01.ad.amcc.com>
	<1253578361.7103.180.camel@pasglop>
	<49c0ff980909211728s2d39e356p6900d047c6918826@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 22 Sep 2009 10:39:03 +1000
Message-Id: <1253579943.7103.194.camel@pasglop>
Mime-Version: 1.0
Cc: Victor Gallardo <vgallardo@amcc.com>, Feng Kan <fkan@amcc.com>,
	netdev@vger.kernel.org, lada.podivin@gmail.com,
	Loc Ho <lho@amcc.com>, bhutchings@solarflare.com,
	Prodyut Hazarika <phazarika@amcc.com>,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-09-21 at 17:28 -0700, prodyut hazarika wrote:
> > BTW. If you guys are ever going to do another change to MAL, please
> > please plase, add the -one- major missing feature that's causing all
> the
> > pain and complication in the current design: Add a per-channel
> interrupt
> > masking option.
> >
> > The lack of ability to mask the interrupt per MAL channel is what
> forces
> > us to create that fake netdev structure in order to share the napi
> > device instance between all the EMACs in the system. This is very
> > inefficient too. We would be able to make things run a lot smoother
> if
> > we could just have a napi instance per EMAC, but for that, we need
> > per-channel interrupt masking.
> >
> 
> I will add a patch for the above as soon as I am done incorporating
> your comments on the MAL coalescing support.
> 
Well... the above is a HW limitation :-) IE. I was suggesting you fix
the HW, but in the case where you already did and the current MAL in
your SoC can indeed mask the interrupt per-channel, then that's great
and we should definitely look into having the driver go back to a more
standard NAPI model on MALs that have that capability.

Cheers,
Ben.
