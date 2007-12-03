Return-Path: <Tony.Li@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AEDD5DDE9D
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Dec 2007 16:09:49 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	lB359hnR017113
	for <linuxppc-dev@ozlabs.org>; Sun, 2 Dec 2007 22:09:43 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lB359fdk014603
	for <linuxppc-dev@ozlabs.org>; Sun, 2 Dec 2007 23:09:42 -0600 (CST)
Subject: Re: [PATCH] Add IPIC MSI interrupt support
From: Li Li <r64360@freescale.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20071203015209.GD26919@localhost.localdomain>
References: <1196394519.29683.8.camel@Guyver>
	<20071203015209.GD26919@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 03 Dec 2007 12:59:33 +0800
Message-Id: <1196657973.9642.28.camel@Guyver>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Gala Kumar <kumar.gala@freescale.com>, Li Tony <Tony.Li@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-12-03 at 09:52 +0800, David Gibson wrote:
> On Fri, Nov 30, 2007 at 11:48:39AM +0800, Li Li wrote: 
> > The IPIC MSI is introduced on MPC837x chip. 
> > Implements the IPIC MSI as two level interrupt controller. 
> > 
> > Signed-off-by: Tony Li <tony.li@freescale.com> 
> > --- 
> >  arch/powerpc/boot/dts/mpc8377_mds.dts     |   14 ++ 
> >  arch/powerpc/boot/dts/mpc8378_mds.dts     |   14 ++ 
> >  arch/powerpc/boot/dts/mpc8379_mds.dts     |   14 ++ 
> >  arch/powerpc/platforms/83xx/Kconfig       |    6 + 
> >  arch/powerpc/platforms/83xx/mpc837x_mds.c |   11 + 
> >  arch/powerpc/sysdev/Makefile              |    1 + 
> >  arch/powerpc/sysdev/ipic_msi.c            |  359
> +++++++++++++++++++++++++++++ 
> >  include/asm-powerpc/ipic_msi.h            |   54 +++++ 
> >  8 files changed, 473 insertions(+), 0 deletions(-) 
> >  create mode 100644 arch/powerpc/sysdev/ipic_msi.c 
> >  create mode 100644 include/asm-powerpc/ipic_msi.h 
> > 
> > diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts
> b/arch/powerpc/boot/dts/mpc8377_mds.dts 
> > index 1f7819e..1068fe2 100644 
> > --- a/arch/powerpc/boot/dts/mpc8377_mds.dts 
> > +++ b/arch/powerpc/boot/dts/mpc8377_mds.dts 
> > @@ -210,6 +210,20 @@ 
> >                       #interrupt-cells = <2>; 
> >                       reg = <700 100>; 
> >               }; 
> > + 
> > +             ipic-msi@7c0 { 
> > +                     compatible = "fsl,ipic-msi"; 
> > +                     reg = <7c0 40>; 
> > +                     interrupts = < 43 8 
> > +                                    4  8 
> > +                                    51 8 
> > +                                    52 8 
> > +                                    56 8 
> > +                                    57 8 
> > +                                    58 8 
> > +                                    59 8 >; 
> > +                     interrupt-parent = < &ipic >; 
> > +             };
> 
> I'm not sure why the MSI needs a device node of its own.  What actual 
> piece of hardware is this representing?
> 

The IPIC MSI has its own registers which control the mask and ack of MSI
interrupt. Furthermore, IPIC MSI is the second level interrupt
coontorller which connected to IPIC, to compatible with IPIC OF routine
interface, we need a device node.

> -- 
> David Gibson                    | I'll have my music baroque, and my
> code 
> david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_
> _other_ 
>                                 | _way_ _around_! 
> http://www.ozlabs.org/~dgibson
> 

- Tony
