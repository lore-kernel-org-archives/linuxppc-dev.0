Return-Path: <albrecht.dress@arcor.de>
Received: from mail-in-16.arcor-online.net (mail-in-16.arcor-online.net
	[151.189.21.56])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 21A9BB7D2B
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Mar 2010 19:56:54 +1100 (EST)
Message-ID: <22132814.1267520208614.JavaMail.ngmail@webmail14.arcor-online.net>
Date: Tue, 2 Mar 2010 09:56:48 +0100 (CET)
From: "Albrecht Dreﬂ" <albrecht.dress@arcor.de>
To: w.sang@pengutronix.de
Subject: Re: [Patch] mpc5200b: improve baud rate calculation (reach high
	baud rates, better accuracy)
In-Reply-To: <20100302082858.GA4087@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20100302082858.GA4087@pengutronix.de>
	<14429243.1267517383754.JavaMail.ngmail@webmail14.arcor-online.net>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wolfram:

[snip]
> > Yes, but I do all /calculations/ with the /4 prescaler for higher
> accuracy.
> > If the divisor exceeds the available 16 bits of the counter reg, I roun=
d
> > (divisor / 8) to use the /32 prescaler.  Think of a 19-bit counter valu=
e,
> > where I can choose to use either the lower or the higher 16 bits for th=
e
> > counter reg.
>=20
> Okay, now I got it. (Maybe this is an indication for another comment abov=
e
> the
> set divisor function?)

O.k., I will add that comment...

> > Remember also that using the higher 16 bits (/32 prescaler) is
> > probably the exceptional case - with an IPB frequency of 132 MHz this
> will
> > happen only for standard baud rates B300 and slower.
>=20
> Even the rare cases have to be correct ;)

I agree - will make the debug output and comments clearer...

[snip]
> > > This should be handled using a new compatible-entry
> > > "fsl,mpc5200b-psc-uart".
> >=20
>=20
> > I agree that this would be a lot cleaner, but it's also a lot more
> intrusive.
> > CC'ing the device tree discussion list here... comments, please!!
>=20
> Why intrusive? Maybe I miss something?

Not for the source file, but for all the dts files, if they want to benefit=
 from the detection of the '5200B.  Basically, *all* files have to be check=
ed and touched if necessary.  Again, I agree that this would be the clean a=
pproach, but I wanted to avoid that effort.  Grant???

[snip]
> Leave those two function pointers empty and fill them during probe (probe
> has
> access to the compatible-property it was matched against, see its
> arguments).
> So it should be a matter of:
>=20
> if (matched_property =3D=3D 5200b)
> =09ops->func =3D this_one;
> else
> =09ops->func =3D that_one;

Umm, yes, that's true of course.  Will pick it up.

Thanks, Albrecht.

Tolle Dekollet=E9s oder scharfe Tatoos? Vote jetzt ... oder mach selbst mit=
 und zeige Deine Schokoladenseite
bei Topp oder Hopp von Arcor: http://www.arcor.de/rd/footer.toh
