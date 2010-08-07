Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id BD1C1B6EDF
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Aug 2010 02:39:43 +1000 (EST)
Date: Sat, 7 Aug 2010 18:39:32 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/mpc8xxx_gpio.c: extend the driver to support
	mpc512x gpios
Message-ID: <20100807183932.4ee10757@wker>
In-Reply-To: <AANLkTimopiF3MZfaAXOO1rJVTptP0HFWSTtmSviAcfT3@mail.gmail.com>
References: <87iq4r5y4q.fsf@macbook.be.48ers.dk>
	<1281187711-10215-1-git-send-email-agust@denx.de>
	<AANLkTimopiF3MZfaAXOO1rJVTptP0HFWSTtmSviAcfT3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>,
	Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant,

On Sat, 7 Aug 2010 09:12:50 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:

> Hi Anatolij,
>=20
> Looks pretty good, but some comments below...
>=20
> On Sat, Aug 7, 2010 at 7:28 AM, Anatolij Gustschin <agust@denx.de> wrote:
> > Signed-off-by: Anatolij Gustschin <agust@denx.de>
>=20
> You haven't written a patch description.  Give some details about how
> the 512x gpio controller is different from the 8xxx one.

Ok, will fix.

...
> > @@ -226,6 +272,9 @@ static struct irq_chip mpc8xxx_irq_chip =3D {
> > =A0static int mpc8xxx_gpio_irq_map(struct irq_host *h, unsigned int vir=
q,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irq_hw_n=
umber_t hw)
> > =A0{
> > + =A0 =A0 =A0 if (of_device_is_compatible(h->of_node, "fsl,mpc5121-gpio=
"))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc8xxx_irq_chip.set_type =3D mpc512x_irq=
_set_type;
> > +
>=20
> You can put the set type hook into the of_match_table data which you
> will need for of_find_matching_node() (see below).

How can I get this match table data reference in mpc8xxx_gpio_irq_map() ?
Is it okay to set data field of struct device_node to the set type
hook? I could do it in mpc8xxx_add_gpiochips() but I'm not sure whether
the data field will be used for other purposes somewhere else.

...
> > @@ -330,6 +379,9 @@ static int __init mpc8xxx_add_gpiochips(void)
> > =A0 =A0 =A0 =A0for_each_compatible_node(np, NULL, "fsl,mpc8610-gpio")
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mpc8xxx_add_controller(np);
> >
> > + =A0 =A0 =A0 for_each_compatible_node(np, NULL, "fsl,mpc5121-gpio")
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc8xxx_add_controller(np);
> > +
>=20
> This list is getting too long.  Refactor this function to use
> for_each_matching_node().  Also doing it this way is dangerous because
> if say a 5121 gpio node claims compatibility with a 8610 gpio node,
> then the gpio controller will get registered twice.

Fixed.

Thanks,
Anatolij
