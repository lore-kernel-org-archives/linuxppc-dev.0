Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2D06DB7091
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Jul 2009 13:02:00 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 82A4FDDDA0
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2009 13:01:59 +1000 (EST)
Subject: Re: ALSA fixes for non-coherent ppc32 again
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <1245623678.16880.27.camel@pasglop>
References: <20090621181855.74980@gmx.net> <1245623678.16880.27.camel@pasglop>
Content-Type: text/plain
Date: Wed, 08 Jul 2009 13:01:50 +1000
Message-Id: <1247022110.6066.65.camel@pasglop>
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-06-22 at 08:34 +1000, Benjamin Herrenschmidt wrote:
> On Sun, 2009-06-21 at 20:18 +0200, Gerhard Pircher wrote:
> > Hi,
> > 
> > Takashi Iwai posted patches to make ALSA work on non-coherent PPC32
> > systems (almost exactly) a year ago. See here:
> > http://www.nabble.com/-PATCH-0-3--ALSA-fixes-for-non-coherent-ppc32-to17980027.html#a17980027
> > 
> > As far as I can see these patches never went upstream. Where there any
> > objections or did we just forget about them? It would be cool, if the
> > patches could be merged now, as at least two platforms need this bugfix
> > (namely Sam440 and AmigaOne).
> 
> I definitely forgot about those... But I'm fine with what Takashi did
> for now, I can always make the powerpc helper for dma_mmap_coherent()
> smarter later on if necessary.

BTW. Can you guys send a "final" patch for adding mmap_coherent to
powerpc ? Please make so that the dma_mmap_coherent() function doesn't
explose if dma_ops->mmap_coherent is NULL though (either fail gracefully
or fallback to some standard mmap).

Note that we probably need to add the virtual address too. IE. On
platforms with an iommu, we cannot easily go back from the dma_addr_t to
the memory address, it's easier to do that from the virtual address in
fact.

Cheers,
Ben.
