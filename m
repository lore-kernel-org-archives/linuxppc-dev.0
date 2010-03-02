Return-Path: <albrecht.dress@arcor.de>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DDF8AB7D25
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Mar 2010 19:09:48 +1100 (EST)
Message-ID: <14429243.1267517383754.JavaMail.ngmail@webmail14.arcor-online.net>
Date: Tue, 2 Mar 2010 09:09:43 +0100 (CET)
From: "Albrecht Dreﬂ" <albrecht.dress@arcor.de>
To: w.sang@pengutronix.de
Subject: Re: [Patch] mpc5200b: improve baud rate calculation (reach high
	baud rates, better accuracy)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wolfram!

Thanks a lot for your comments!

[snip]
> > + * as the chip can be only either a 5200B or not. */
> > +static int is_mpc5200b =3D -1;
> > +
> > +
>=20
> One empty line too much. Maybe we can also get rid of the static later in
> the
> process, but first things first.

Ooops....

[snip]
> > +=09if (is_mpc5200b =3D=3D 1)
> > +=09=09return mpc5xxx_get_bus_frequency(p) * 4;
> > +=09else
> > +=09=09return mpc5xxx_get_bus_frequency(p) / 2;
>=20
> Isn't this wrong? You can also have /32 on the 5200B (the fallback).

Yes, but I do all /calculations/ with the /4 prescaler for higher accuracy.=
  If the divisor exceeds the available 16 bits of the counter reg, I round =
(divisor / 8) to use the /32 prescaler.  Think of a 19-bit counter value, w=
here I can choose to use either the lower or the higher 16 bits for the cou=
nter reg.  Remember also that using the higher 16 bits (/32 prescaler) is p=
robably the exceptional case - with an IPB frequency of 132 MHz this will h=
appen only for standard baud rates B300 and slower.

[snip]
> > +=09/* Check only once if we are running on a mpc5200b or not */
> > +=09if (is_mpc5200b =3D=3D -1) {
> > +=09=09struct device_node *np;
> > +
> > +=09=09np =3D of_find_compatible_node(NULL, NULL, "fsl,mpc5200b-immr");
>=20
> This should be handled using a new compatible-entry
> "fsl,mpc5200b-psc-uart".

I agree that this would be a lot cleaner, but it's also a lot more intrusiv=
e.  CC'ing the device tree discussion list here... comments, please!!

> > +=09=09if (np) {
> > +=09=09=09is_mpc5200b =3D 1;
> > +=09=09=09dev_dbg(&op->dev, "mpc5200b: using /4 prescaler\n");
>=20
> Does this message respect the fallback case?

See comment above...

> You could also have a set_divisor-function for 5200 and 5200B and set it
> here
> in the function struct (one reason less for the static ;))

Hmmm, but then I would need a 'static struct psc_ops mpc5200b_psc_ops', whe=
re only two functions differ from the generic 52xx struct as it is implemen=
ted now.  Using the static int needs less space.  However, in combination w=
ith the new compatible entry, it would of course make sense.

Again, any insight from the device tree gurus would be appreciated!

Thanks, Albrecht.

Tolle Dekollet=E9s oder scharfe Tatoos? Vote jetzt ... oder mach selbst mit=
 und zeige Deine Schokoladenseite
bei Topp oder Hopp von Arcor: http://www.arcor.de/rd/footer.toh
