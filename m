Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id 67C4CDE577
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 00:30:19 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2129616wag
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 07:30:17 -0700 (PDT)
Message-ID: <fa686aa40710150730u3164b12dtef42d8dd68674fdc@mail.gmail.com>
Date: Mon, 15 Oct 2007 08:30:17 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Domen Puncer" <domen.puncer@telargo.com>
Subject: Re: [PATCH v3 4/4] FEC mpc52xx: phy part of the driver\
In-Reply-To: <20071015105601.GM3000@nd47.coderock.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071014075511.GC3000@nd47.coderock.org>
	<20071014075958.GG3000@nd47.coderock.org>
	<fa686aa40710141505w1787e7e1g6116185001561a4d@mail.gmail.com>
	<20071015105601.GM3000@nd47.coderock.org>
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/15/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> On 14/10/07 16:05 -0600, Grant Likely wrote:
> > On 10/14/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> > > PHY part of the driver for mpc5200(b) ethernet.
> >
> > Assuming I understand correctly, this comment is not correct and this
> > patch just adds an MDIO bus driver.  PHY drivers are in phylib and
> > data transfer is setup via the core driver, correct?
>
> Right.
>
> >
> > It is conceivable that the PHY is connected to an alternate MDIO bus,
> > or the MDIO bus is used for a PHY connected to an external Ethernet
> > controller.
> >
> > Speaking of which, is it possible to use this MDIO bus without the
> > core FEC being initialized?
>
> IIRC fec doesn't need any initialization for MDIO bus registers to work.
>
> >
> > > +static struct of_device_id fec_mdio_match[] = {
> > > +       {
> > > +               .type = "mdio",
> > > +               .compatible = "mpc5200b-fec-phy",
> >
> > This is not a phy; it's an MDIO bus.  Also, shouldn't this be
> > "mpc5200-..." instead of "mpc5200b-..."?
>
> Didn't know if it's ok for mpc5200, guess it is?

I believe it is.

>
> >
> > > +       },
> > > +       {},
> > > +};
> > > +
> > > +struct of_platform_driver mpc52xx_fec_mdio_driver = {
> > > +       .name = "mpc5200b-fec-phy",
> > > +       .probe = fec_mdio_probe,
> > > +       .remove = fec_mdio_remove,
> > > +       .match_table = fec_mdio_match,
> >
> > Inconsistent naming.  Please use the same prefix on all global/static
> > symbols (ie. use "mpc52xx_mdio_" instead of the mix of
> > "mpc52xx_fec_mdio_", "fec_mdio_", etc.)  I also thing that "fec_mdio_"
> > is too generic because there are a number of different incompatible
> > FEC devices.
>
> OK.
>
> >
> > > +};
> > > +
> > > +/* let fec driver call it, since this has to be registered before it */
> > > +EXPORT_SYMBOL_GPL(mpc52xx_fec_mdio_driver);
> >
> > Why not have a module_init()/module_exit() in this file?  I don't
> > think the FEC driver calls this driver's functions directly anymore,
> > and it's still dependent on the of_platform bus probe order anyway.
>
> It was one way of making sure mdio driver is registered before fec.
> (and of_platform bus probe order won't work for modules)
> Nicer alternatives?

However, that assumption only works when the PHY is accessed via the
on-chip MDIO controller.  What happens with a different MDIO bus is
used?

...

Need to take a look at how phylib handles the probing order problem;
but really this is something that PHYLIB needs to handle; not the FEC
driver.

> > > --- linux.git.orig/drivers/net/fec_mpc52xx/Kconfig
> > > +++ linux.git/drivers/net/fec_mpc52xx/Kconfig
> > > @@ -11,5 +11,18 @@ config FEC_MPC52xx
> > >         ---help---
> > >           This option enables support for the MPC5200's on-chip
> > >           Fast Ethernet Controller
> > > +         If compiled as module, it will be called 'fec_mpc52xx.ko'.
> >
> > Drop this line and make the help text the same format as the other eth
> > drivers in drivers/net.
>
> How exactly is it different now?
> And most of them have the "Module will be called xxx" line.

Okay, you're right.  There is a real hodgepodge of help text format in
drivers/net/Kconfig.  Do what seems best to you.

>
> >
> > > +
> > > +config FEC_MPC52xx_MDIO
> > > +       bool "FEC MII PHY driver"
> > > +       depends on FEC_MPC52xx
> > > +       default y
> > > +       ---help---
> > > +         The MPC5200's FEC can connect to the Ethernet either with
> > > +         an external MII PHY chip or 10 Mbps 7-wire interface
> > > +         (Motorola? industry standard).
> > > +         If your board uses an external PHY, enable this.
> >
> > Not strictly true.  This enables talking to a PHY using the internal
> > MDIO controller.  PHY register access could just as easily be accessed
> > via an alternate interface.
>
> Not just that is also selects which mode will it use.
> If you don't enable this, fec will be set up as 7-wire
> ( 696                 rcntrl |= FEC_RCNTRL_MII_MODE;)

Looking at fec.c:

That line is dependent on priv->has_phy.  priv->has_phy is set on line
949 which is conditional on the node having the property "phy-handle".
 It doesn't look like it is conditional on CONFIG_FEC_MPC52xx_MDIO at
all.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
