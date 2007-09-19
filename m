Return-Path: <silvio.fricke@googlemail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.227])
	by ozlabs.org (Postfix) with ESMTP id 2AD37DDEA0
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 05:01:55 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so237741nzh
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 12:01:54 -0700 (PDT)
Date: Wed, 19 Sep 2007 21:01:46 +0200
To: linuxppc-dev@ozlabs.org
Subject: Re: Configuration-Problem ext-interrupt on mpc52xx
Message-ID: <20070919190146.GI5682@sfrouter>
References: <20070919115952.GF5682@sfrouter>
	<fa686aa40709190809v284618d4r65674a1409ab0b57@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcccYpVZDxQ8hzPO"
In-Reply-To: <fa686aa40709190809v284618d4r65674a1409ab0b57@mail.gmail.com>
From: "S. Fricke" <silvio.fricke@googlemail.com>
Reply-To: "S. Fricke" <silvio.fricke@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--HcccYpVZDxQ8hzPO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

> On 9/19/07, S. Fricke <silvio.fricke@googlemail.com> wrote:
> > Hi,
> >
> > how can i configure an "ext interrupt" to high-level? I want a interrup=
tion on
> > IRQ2, but I checked with an oscilloscope that the pin has a low state a=
nd I
> > needs a high state.
> >
> > I have tried, after I got the irq (with irq_of_parse_and_map), set it w=
ith
> >
> >     set_irq_type(irq, IRQ_TYPE_LEVEL_HIGH);
> >
> > But I think it is a system-configuration (irq_desc) and no
> > device-configuration.
>=20
> You shouldn't need to do this.  You set your sense level in the device tr=
ee.
>=20
> From your previous email, your device node looks like this:
> >             intpin@0 {
> >                 interrupt-parent =3D <500>;
> >                 interrupts =3D <1 2 2>;
> >             };
>=20
> Which is IRQ2, EDGE_FALLING.
>=20
> If you change your interrupts property to <1 2 0>, then your sense is
> set to LEVEL_HIGH.  (Seriously, you need to read the interrupts
> section of Documentation/powerpc/mpc52xx-device-tree-bindings.txt.)

I have read it! But another driver on Boot-time pulled my interrupt to low,=
 I
can't do anything except for looking at the oscilloscope

I'm going to disable all unneeded drivers tomorrow morning.

TIA:
Silvio Fricke

--=20
-- S. Fricke ----------------------------- MAILTO:silvio.fricke@gmail.com --
   Diplom-Informatiker (FH)
   Linux-Entwicklung
----------------------------------------------------------------------------


--HcccYpVZDxQ8hzPO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG8XIa8WEBxatmn40RAk00AJ9U+PSxGr0umGkQOWyfbaYwwbEj/wCgtnF8
K7UQHcJCySN0Ah80548z3o0=
=SS+/
-----END PGP SIGNATURE-----

--HcccYpVZDxQ8hzPO--
