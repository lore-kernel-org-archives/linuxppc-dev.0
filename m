Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 98F6F67A7B
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2005 13:06:18 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Chapman <jchapman@katalix.com>
In-Reply-To: <422C495B.8090805@katalix.com>
References: <20050307105838.3DB6C1C007DE@mwinf0309.wanadoo.fr>
	<422C495B.8090805@katalix.com>
Content-Type: text/plain
Date: Wed, 09 Mar 2005 13:01:35 +1100
Message-Id: <1110333695.32556.15.camel@gaston>
Mime-Version: 1.0
Cc: Nicolas DET <det.nicolas@free.fr>, Sven Luther <luther@gluck.debian.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: mv64x60 updates
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-03-07 at 12:30 +0000, James Chapman wrote:
> Hi Nicolas,
> 
> A few general comments:-
> 
> - mv64x60 stuff is best posted to linuxppc-embedded
> 
> - you change several generic files to support your platform. It should
>    be possible to support new mv64x60 platforms by writing a new
>    xxx_setup.c file in arch/ppc/platforms with no other generic changes.
>    It is a goal that all mv64x60 boards can be supported by the generic
>    code in arch/ppc/syslib. If some changes need to be made outside
>    arch/ppc/platforms to support your board, try to make them generic so
>    that other similar boards would be able to use them. I suggest you
>    clone chrp_setup.c or katana.c rather than adding conditionals in
>    chrp_setup.c for your board. Then use code in your board specific
>    setup file to call arch/ppc/syslib mv64x60 routines as appropriate.

Welcome to the world of embedded people who use #ifdef's for their
platforms :)

Pegasos claims to be chrp compliant, and so uses chrp_setup.c and relies
on other chrp related bits. The point here is to limit the platform
specific code and use the device-tree as much as is possible. Though I
agree that Nicals patch introduce wrong dependencies (I need to do a
deeper review of it).

If chrp_setup.c indeed ends up beeing cluttered by too much Pegasos
specific stuff, then it will be time to do split pegasos to a different
platform type as part of CONFIG_PPC_MULTIPLATFORM.

Now as far as his patch is concernd, the whole is_pegasos2() stuff is
too ugly for words, I agree. If he really needs so, then he should add
an argument to mv64x60_init() in order to customize it's behaviour.
Though I haven't looked at the code to see why he's trying to skip
stuffs here.

> - you shouldn't need to add board-specific changes in mv643xx_eth.c.
>    Setup device platform data for your board in your platform file.
>    If something needs to be added to the platform data for a generic
>    change to mv643xx_eth, do that rather than add platform conditionals
>    in the driver.

Agreed, though I think that's almost there now.

> - why do you need to use SA_SHIRQ in the ethernet driver?

Why don't use use it ? SA_INTERRUPT is crap and should probably be
removed from the driver.

> /james
> 
> Nicolas DET wrote:
> 
> > Hello Sven,
> > 
> > On 07/03/2005, you wrote:
> > 
> > 
> >>But i hear Nicolas has done some useful work yesterday evening, i will
> >>review it as soon as he is back from dreamland :)
> > 
> > 
> > You can find the patch against 2.6.11 from kernel.org here:
> > http://powernico.free.fr/patch_2.6.11_mv64x60.diff.bz2
> > 
> > This patch shouldn't break mv code for others platform (non PegasosII), and
> > fix Pegasos II init...
> > 
> > Basicly, I added mv64360_ispegasos2() in include/asm-ppc/mv64x60.h. Then:
> > 
> > in arch/ppc/syslibs/mv64360_pic.c, I skip the IRQ init code
> > in arch/ppc/syslibs/mv64x60.c, I skip all the chip init & patch the
> > ressources tables for Pegasos II hardware (register base & IRQ).
> > in include/asm-ppc/mv64x60.h: added mv64360_ispegasos2()
> > in arch/ppc/kernel/chrp_setup.c, rename/added pegasos2_stuff() and call
> > mv64x60_init() if CONFIG_MV64x60
> > in drivers/net/mv64xx_eth.c, use SA_SHIRQ instead of SA_INTERRUPT for
> > request_irq if pegasos II detected
> > 
> > The only thing to do is to add mv64360_ispegasos2() in include/asm-mips/...
> > because I use this function to use the correct flags in the ethernet
> > driver.
> > 
> > Of course, this patch may be discuss as there are several architecture
> > using Marvell chipsets and each requieres some specific code.
> > I don't know where it's the best to place mv64360_ispeasos2(), maybe this
> > func could even be renamed mv64x60_ispegasos2()..
> > 
> > Please, people from others MV64x60 architectures review this patch, modify
> > if it neeeded and check it doesn't break your architecture (I shouldn't but
> > for MIPS ethernet).
> > 
> > Regards
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
