Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 22693DDEA2
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 23:06:57 +1100 (EST)
Date: Tue, 19 Feb 2008 04:05:30 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Clemens Koller <clemens.koller@anagramm.de>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/2] fb: add support for foreign
	endianness
Message-Id: <20080219040530.7b1d115d.akpm@linux-foundation.org>
In-Reply-To: <47BABD3A.7010102@anagramm.de>
References: <20080205154432.GA8749@localhost.localdomain>
	<20080214224942.a0cb6218.akpm@linux-foundation.org>
	<20080215164542.GB16810@localhost.localdomain>
	<Pine.LNX.4.64.0802171030330.6848@anakin>
	<20080218081847.e9e65f2f.krzysztof.h1@poczta.fm>
	<19805.1203355811@turing-police.cc.vt.edu>
	<47BA162C.5000807@anagramm.de> <1203381353.6740.59.camel@pasglop>
	<47BABD3A.7010102@anagramm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com,
	Krzysztof Helt <krzysztof.h1@poczta.fm>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 19 Feb 2008 12:27:54 +0100 Clemens Koller <clemens.koller@anagramm.de> wrote:

> Benjamin Herrenschmidt schrieb:
> > On Tue, 2008-02-19 at 00:35 +0100, Clemens Koller wrote:
> >> Valdis.Kletnieks@vt.edu schrieb:
> >>> On Mon, 18 Feb 2008 08:18:47 +0100, Krzysztof Helt said:
> >>>> I know two fb drivers which use endianess information (pm2fb and s3c2410fb).
> >>>> Both resolve endianess at driver level. Actually, both handle it by setting special
> >>>> bits so the graphics chip itself reorder bytes to transform foreign endianess. 
> >>>> I understand that this patch is for chips which cannot reorder bytes by themselves.
> >>> Does anybody know of such a chip that's actually available in the wild?  Or are
> >>> we writing drivers for speculative possible chips?
> >>>
> >> I had troubles with the Silicon Motion SM501/SM502 endianess on PowerPC PCI vs. LocalBus.
> >> The chip also has a register to swap endianess, but that seems to only affect some
> >> LocalBus modes.
> >> The current fb and X drivers are working, but when it comes to font
> >> aliasing and hw-acceleration, the problems start to rise again...
> > 
> > Most "sane" gfx chips nowadays provide configurable surfaces that allow
> > to perform the swap when writing/reading from regions of the
> > framebuffer, with the ability to set a different swapper setting (based
> > on bit depth) per region.
> 
> Most! But not the SM50x. I still hope I would be wrong here. :-(
> 
> > Then there is also the risk that your PCI<->Localbus has been wired
> > improperly :-)
> 
> That's not an issue in my case. The SM50x can be connected to
> either an PCI or some Local/CPU-whateverbus IF.
> I.e. on the MPC85xx PowerPC, PCI and LocalBus are separate bussses.
> If the sm501 is attached to the MPC85xx' PCI like any other video card,
> the PCI config-space is can be accessed as usual, whereas the framebuffer
> memory area is byte-swapped compared to other common video cards.
> 
> So, to get back on topic:
> I would welcome endianess swapping in SW. Some architectures (PowerPC)
> should also be able to do swapped-endian mmapping. I just haven't
> had time for a closer look but it looks also interesting way to do it
> that way.

Bizarrely, the original author of the patch (Anton) has fallen off the cc. 
Could whoever did that please thwap himself?

Anyway, my head is now officially spinning.  Did anyone actually have a
reason why we shouldn't proceed with Anton's patch?
