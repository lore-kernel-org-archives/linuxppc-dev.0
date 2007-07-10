Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 93C6BDDEDD
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 02:11:30 +1000 (EST)
Date: Tue, 10 Jul 2007 11:11:21 -0500
From: Scott Wood <scottwood@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4] Add DMA sector to
	Documentation/powerpc/booting-without-of.txt file.
Message-ID: <20070710161121.GA14556@ld0162-tx32.am.freescale.net>
References: <1184060662530-git-send-email-wei.zhang@freescale.com>
	<11840606624025-git-send-email-wei.zhang@freescale.com>
	<14A08601-B779-45BF-BC22-D1A3C9997502@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <14A08601-B779-45BF-BC22-D1A3C9997502@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 10, 2007 at 04:01:19PM +0200, Segher Boessenkool wrote:
> > +    - compatible : Should be "fsl,mpc8xxx-dma"
> 
> Should _include_, not should _be_.  And none of this xxx
> business, of course.

Especially since the 85xx/86xx version is not 100% compatible with the
83xx version.  How about fsl,mpc8349-dma and fsl,mpc8548-dma for the two
variants?

> > +    - extended : Set the DMA channel to work at extended chain mode.
> > +                 If not set, the DMA channel will work at basic
> > +                 chain mode.
> 
> Call it "extended-chain-mode", perhaps?

Or don't call it anything.  The ability to do extended chain mode is
implicit in being compatible with fsl,mpc8548-dma.

> > +    - reserved : Reserve the DMA channel to device.
> 
> What does this do?  Reserve it for what device, and where?
> The OS driver?

Some hardware has DMA channels hardwired to certain peripherals, such as
an audio codec.  This keeps them from being used as general purpose DMA
channels.

I'd rather just treat the different DMA channels as independent devices,
rather than children of a dma "bus", and change the compatible name if
they're not general purpose.  There's only one register that's shared
among the channels, and it's a superfluous status summary register.

-Scott
