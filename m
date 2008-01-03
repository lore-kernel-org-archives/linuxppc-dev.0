Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by ozlabs.org (Postfix) with ESMTP id E195CDDEC0
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2008 01:54:45 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so10131646wag.13
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Jan 2008 06:54:45 -0800 (PST)
Message-ID: <9e4733910801030654i7409e383n6b7f844aa543f234@mail.gmail.com>
Date: Thu, 3 Jan 2008 09:54:45 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Timur Tabi" <timur@freescale.com>, "Jon Smirl" <jonsmirl@gmail.com>,
	linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
In-Reply-To: <20080103044432.GB25357@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801012027p4be16b92r43af773f4e5ae531@mail.gmail.com>
	<477BADF5.9060003@freescale.com>
	<20080103044432.GB25357@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/2/08, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Wed, Jan 02, 2008 at 09:29:57AM -0600, Timur Tabi wrote:
> > Jon Smirl wrote:
> > > On 12/19/07, Timur Tabi <timur@freescale.com> wrote:
> > >>  sound/soc/fsl/fsl_ssi.c                      |  614 +++++++++++++++++++
> > >>  sound/soc/fsl/fsl_ssi.h                      |  224 +++++++
> > >
> > > I'm confused about this part. You built a driver for the mpc8610 ssi
> > > port.  This port has a device tree entry.
> > >
> > > +           ssi@16000 {
> > > +                   compatible = "fsl,ssi";
> > > +                   cell-index = <0>;
> > > +                   reg = <16000 100>;
> > > +                   interrupt-parent = <&mpic>;
> > > +                   interrupts = <3e 2>;
> > > +                   fsl,mode = "i2s-slave";
> > > +                   codec {
> > > +                           compatible = "cirrus,cs4270";
> > > +                           /* MCLK source is a stand-alone oscillator */
> > > +                           bus-frequency = <bb8000>;
> > > +                   };
> > > +           };
> > >
> > > But then you don't create an of_platform_driver for this device.
> > > Instead you create one for the fabric driver, struct
> > > of_platform_driver mpc8610_hpcd_of_driver, and directly link the SSI
> > > driver into it.
> >
> > That's the best plan I came up with.  This is apparently fixed in ASoC
> > V2.  From ASoC V1's perspective, the fabric driver must be the master.
> > However, it doesn't make sense to have a node in the device tree for the
> > fabric driver, because there is no such "device".  The fabric driver is
> > an abstraction.  So I need to chose some other node to probe the fabric
> > driver with.  I chose the SSI, since each SSI can have only one
> > codec.
>
> Instantiating the fabric driver off any node is wrong, precisely
> because it is an abstraction.  The fabric driver should be
> instantiated by the platform code.

Instantiating it from the platform code forces me to put it either the
of_platform_bus or the platform_bus since there aren't any other buses
around when the platform code runs. Platform bus doesn't implement
dynamic module loading. So that means it has to go onto the
of_platform_bus. That implies that is it a pseudo-device without a
pseudo-device entry in the device tree which is fine with me. I'll
need to poke around in the of_bus code and see if the driver will load
without a device tree entry.

A simple fix to this would be to let me instantiate the driver off
from the root node of the tree. That's the conceptually correct place
for instantiating a driver that extends the platform code. Should I
try adjusting the of probing code to pass the node in, or are there
major objections?

Also, as others have pointed out, this driver is not an abstraction.
It represents the mess of wires hooking the codec up to the jacks on
the back panel and possibly GPIO pins that control the wiring. You
need this because the pins on HD audio codecs are completely
reconfigurable and the same chip can be wired in a thousand different
ways. It lets you have a generic codec driver and the move the
platform specific code out of the driver.


>
> --
> David Gibson                    | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_ _other_
>                                 | _way_ _around_!
> http://www.ozlabs.org/~dgibson
>


-- 
Jon Smirl
jonsmirl@gmail.com
