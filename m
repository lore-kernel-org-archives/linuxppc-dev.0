Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EBEFCDDE23
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 11:36:47 +1100 (EST)
Subject: Re: [Linux-fbdev-devel] [PATCH 1/2] fb: add support for
	foreign	endianness
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Clemens Koller <clemens.koller@anagramm.de>
In-Reply-To: <47BA162C.5000807@anagramm.de>
References: <20080205154432.GA8749@localhost.localdomain>
	<20080214224942.a0cb6218.akpm@linux-foundation.org>
	<20080215164542.GB16810@localhost.localdomain>
	<Pine.LNX.4.64.0802171030330.6848@anakin>
	<20080218081847.e9e65f2f.krzysztof.h1@poczta.fm>
	<19805.1203355811@turing-police.cc.vt.edu>
	<47BA162C.5000807@anagramm.de>
Content-Type: text/plain
Date: Tue, 19 Feb 2008 11:35:53 +1100
Message-Id: <1203381353.6740.59.camel@pasglop>
Mime-Version: 1.0
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com,
	Krzysztof Helt <krzysztof.h1@poczta.fm>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Andrew Morton <akpm@linux-foundation.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-02-19 at 00:35 +0100, Clemens Koller wrote:
> Valdis.Kletnieks@vt.edu schrieb:
> > On Mon, 18 Feb 2008 08:18:47 +0100, Krzysztof Helt said:
> >> I know two fb drivers which use endianess information (pm2fb and s3c2410fb).
> >> Both resolve endianess at driver level. Actually, both handle it by setting special
> >> bits so the graphics chip itself reorder bytes to transform foreign endianess. 
> >> I understand that this patch is for chips which cannot reorder bytes by themselves.
> > 
> > Does anybody know of such a chip that's actually available in the wild?  Or are
> > we writing drivers for speculative possible chips?
> > 
> 
> I had troubles with the Silicon Motion SM501/SM502 endianess on PowerPC PCI vs. LocalBus.
> The chip also has a register to swap endianess, but that seems to only affect some
> LocalBus modes.
> The current fb and X drivers are working, but when it comes to font
> aliasing and hw-acceleration, the problems start to rise again...

Most "sane" gfx chips nowadays provide configurable surfaces that allow
to perform the swap when writing/reading from regions of the
framebuffer, with the ability to set a different swapper setting (based
on bit depth) per region.

Then there is also the risk that your PCI<->Localbus has been wired
improperly :-)

Ben.
