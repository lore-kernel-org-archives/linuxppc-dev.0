Return-Path: <david.jander@protonic.nl>
From: David Jander <david.jander@protonic.nl>
To: "John Rigby" <jcrigby@gmail.com>
Subject: Re: [PATCH] Added support for PRTLVT based boards (MPC5121)
Date: Fri, 20 Jun 2008 11:01:27 +0200
References: <200806131049.03765.david.jander@protonic.nl>
	<4b73d43f0806180833r7877fc16o2673f64df5e49aa7@mail.gmail.com>
In-Reply-To: <4b73d43f0806180833r7877fc16o2673f64df5e49aa7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806201101.27908.david.jander@protonic.nl>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi John,

On Wednesday 18 June 2008 17:33:48 John Rigby wrote:
> Hi David,
>
> Looks like your device tree is based on the beta ltib bsp.  There were
> some changes in release 1 that you may want to incorporate:
>
> First as a convention I changed all the interrupt numbers in the
> tuples to be decimal.  I like this better because the interrupts are
> decimal in the reference manual.
>
> Second, the new clock driver that is in the release 1 bsp and will be
> posting here shortly no longer uses the device tree, so you can remove
> all the clk-name, clk-parent, clk-ctrl properties.

Thanks, I'll incorporate these changes and submit again.
Btw, do you agree with the following part of the patch?

> > diff --git a/arch/powerpc/platforms/512x/Kconfig
> > b/arch/powerpc/platforms/512x/Kconfig index 4c0da0c..57b3912 100644
> > --- a/arch/powerpc/platforms/512x/Kconfig
> > +++ b/arch/powerpc/platforms/512x/Kconfig
> > @@ -2,18 +2,20 @@ config PPC_MPC512x
> >        bool
> >        select FSL_SOC
> >        select IPIC
> > -       default n
> >
> >  config PPC_MPC5121
> >        bool
> >        select PPC_MPC512x
> > -       default n
> >
> > -config MPC5121_ADS
> > -       bool "Freescale MPC5121E ADS"
> > +config MPC5121_GENERIC
> > +       bool "Generic support for simple MPC5121 based boards"
> >        depends on PPC_MULTIPLATFORM && PPC32
> >        select DEFAULT_UIMAGE
> >        select PPC_MPC5121
> >        help
> > -         This option enables support for the MPC5121E ADS board.
> > -       default n
> > +         This option enables support for a simple MPC5121 based boards
> > which +         do not need a custom platform specific setup.
> > +
> > +         Boards that are compatible with this generic platform support
> > +         are: Freescale MPC5121 ADS and Protonic LVT based boards
> > (ZANMCU +         and VICVT2).
> > diff --git a/arch/powerpc/platforms/512x/Makefile
> > b/arch/powerpc/platforms/512x/Makefile index 232c89f..9d40a2e 100644
> > --- a/arch/powerpc/platforms/512x/Makefile
> > +++ b/arch/powerpc/platforms/512x/Makefile
> > @@ -1,4 +1,4 @@
> >  #
> >  # Makefile for the Freescale PowerPC 512x linux kernel.
> >  #
> > -obj-$(CONFIG_MPC5121_ADS)      += mpc5121_ads.o
> > +obj-$(CONFIG_MPC5121_GENERIC)  += mpc5121_generic.o
> > diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.c
> > b/arch/powerpc/platforms/512x/mpc5121_generic.c similarity index 73%
> > rename from arch/powerpc/platforms/512x/mpc5121_ads.c
> > rename to arch/powerpc/platforms/512x/mpc5121_generic.c
> > index 50bd3a3..824ddbb 100644
> > --- a/arch/powerpc/platforms/512x/mpc5121_ads.c
> > +++ b/arch/powerpc/platforms/512x/mpc5121_generic.c
>[...]

The idea is to make it as simple as possible to add new platforms that are 
basically just derivatives of the same.

Greetings,

-- 
David Jander
Protonic Holland.
