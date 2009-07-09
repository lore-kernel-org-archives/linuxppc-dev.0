Return-Path: <gerhard_pircher@gmx.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F1D28B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Jul 2009 21:22:45 +1000 (EST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id DD079DDDE7
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Jul 2009 21:22:43 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Thu, 09 Jul 2009 13:22:38 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <s5hfxd7qn49.wl%tiwai@suse.de>
Message-ID: <20090709112238.34100@gmx.net>
MIME-Version: 1.0
References: <20090621181855.74980@gmx.net>	<1245623678.16880.27.camel@pasglop>
	<1247022110.6066.65.camel@pasglop> <s5hfxd7qn49.wl%tiwai@suse.de>
Subject: Re: ALSA fixes for non-coherent ppc32 again
To: Takashi Iwai <tiwai@suse.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Wed, 08 Jul 2009 16:13:10 +0200
> Von: Takashi Iwai <tiwai@suse.de>
> An: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Gerhard Pircher <gerhard_pircher@gmx.net>, linuxppc-dev@ozlabs.org
> Betreff: Re: ALSA fixes for non-coherent ppc32 again

> At Wed, 08 Jul 2009 13:01:50 +1000,
> Benjamin Herrenschmidt wrote:
> > 
> > On Mon, 2009-06-22 at 08:34 +1000, Benjamin Herrenschmidt wrote:
> > > On Sun, 2009-06-21 at 20:18 +0200, Gerhard Pircher wrote:
> > > > Hi,
> > > > 
> > > > Takashi Iwai posted patches to make ALSA work on non-coherent
> > > > PPC32 systems (almost exactly) a year ago. See here:
> > > >
> > > > http://www.nabble.com/-PATCH-0-3--ALSA-fixes-for-non-coherent-ppc32-to17980027.html#a17980027
> > > > 
> > > > As far as I can see these patches never went upstream. Where
> > > > there any objections or did we just forget about them? It would
> > > > be cool, if the patches could be merged now, as at least two
> > > > platforms need this bugfix (namely Sam440 and AmigaOne).
> > > 
> > > I definitely forgot about those... But I'm fine with what Takashi
> > > did for now, I can always make the powerpc helper for
> > > dma_mmap_coherent() smarter later on if necessary.
> > 
> > BTW. Can you guys send a "final" patch for adding mmap_coherent to
> > powerpc ? Please make so that the dma_mmap_coherent() function doesn't
> > explose if dma_ops->mmap_coherent is NULL though (either fail
> > gracefully or fallback to some standard mmap).
> 
> The attached is the revised patch.  It falls backs to the standard
> mmap.
> 
> The whole patch series are found in test/dma-fix branch of sound git
> tree below:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
> test/dma-fix
> 
> I had no time to play cross-build yet, so it'd be helpful if someone
> can test it...
> (BTW, any good minimal gcc and binutils package for kernel builds for
>  PPC32?)
Okay, I cross-build it on a x86 machine and tested it on my AmigaOne with
the VIA686 onboard sound and a Soundblaster 5.1. It worked fine after I
applied the "ALSA: Fix SG-buffer DMA with non-coherent architectures"
patch.

Thanks!

Gerhard

-- 
Neu: GMX Doppel-FLAT mit Internet-Flatrate + Telefon-Flatrate
für nur 19,99 Euro/mtl.!* http://portal.gmx.net/de/go/dsl02
