Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sLqZj0kzZzDrcD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Aug 2016 17:40:29 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id ez1so5835925pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Aug 2016 00:40:28 -0700 (PDT)
Date: Sat, 27 Aug 2016 15:40:13 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Rob Herring <robh+dt@kernel.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/5] of/platform: introduce a generic way to declare a
 platform bus
Message-ID: <20160827074012.GA28370@pek-khao-d1>
References: <1471918019-19472-1-git-send-email-haokexin@gmail.com>
 <1471918019-19472-4-git-send-email-haokexin@gmail.com>
 <CAL_JsqK42T1M3MO26p46K0zTuvGUAdMWAf4FHGVpAJgDa+SudQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
In-Reply-To: <CAL_JsqK42T1M3MO26p46K0zTuvGUAdMWAf4FHGVpAJgDa+SudQ@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 25, 2016 at 08:44:56AM -0500, Rob Herring wrote:
> On Mon, Aug 22, 2016 at 9:06 PM, Kevin Hao <haokexin@gmail.com> wrote:
> > The specific buses which need to be probed at boot time are different
> > between platforms. Instead of put all the buses into the default
> > of_default_bus_match_table[] match tables, this patch introduces a
> > general way to declare a platform bus.
>=20
> I'd prefer to not do this with linker sections if possible. Doesn't
> PPC have machine descriptors that you could add the match table to? If
> that table exists then arch_want_default_of_probe could return a
> pointer to it.

Hmm, I thought about adding a match table in ppc_md. But it is very arch
specific. I thought maybe other archs also need to probe some arch or even
board specific bus, so I introduces these arch independent macros and wish
it may be useful for other archs. :-)

>=20
> Are there any platforms that work with the default match table?

Yes, some boards can work with the default match table. But most won't.

> I'd be
> fine with adding some strings to the default if that helps.
>=20
> { .type =3D "soc", },
>=20
> device_type is deprecated for FDT, so this shouldn't be needed except
> for really old stuff.
>=20
> { .compatible =3D "soc", },
>=20
> Doesn't appear in kernel dts files. Could be out of tree or old ones?
>=20
> { .compatible =3D "simple-bus" },
>=20
> Already handled.
>=20
> { .compatible =3D "gianfar" },
>=20
> Seems like the children of this should be probed by the gianfar driver.
>=20
> { .compatible =3D "gpio-leds", },
>=20
> I don't think this is needed.
>=20
> { .type =3D "qe", },
>=20
> Again, deprecated.
>=20
> { .compatible =3D "fsl,qe", },
>=20
> No issue to add this. Though, you could also probe it from mpc85xx_qe_ini=
t().

Do you mean we put all the probe of the specific bus into the corresponding
drivers? Yes, if we do so, we probably can shrink the default match table to
be something like this:
	{ .compatible =3D "soc", },
	{ .compatible =3D "simple-bus" },

OK, now we have three options to fix this issue:
a) Create a separate link section to contain all the buses needed to be pro=
bed.
   Just as what this patch does.

b) Put the match table into the machine descriptor.

c) Sprinkle the probe of all the specific bus into the corresponding driver
   (such as gian, pcie controller) and the default probe function only hand=
le
   the very common buses.

So what option do you guys think is best?

Thanks,
Kevin

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXwUPcAAoJEJNY7TDerrFxwjgH/3dF+BIlYMrSFEvc5oitj6oD
CdVFlE2Q2PjvYFsd49KG2ZPEJ/VeSG7Ejt8DCgNysJi8Oh0luC7vKSBvKhm76GSm
+iPm5Y6P59XBidggbpvbIc1bWERGBodNQSWF/0rJyuobreJ8LA+OJxcNEdzLwBXi
jUBBcCH5WMrUj4KpYNManCaJcJNxFtD2qatpxIIzRmjm8ZMbQoHlxtJ0em2D/Vy3
ICpGothvD17taXt/T68ksIwI5ovmpTXX9CoOdRB0v1DG8ODva3BBto05x9LclfXr
3+IQOYgHE/ZO7TLfAXAQEbEjJv/infPMj8bh58FtSG7ySSZgTEJlnf7fuziZYIw=
=qwi0
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
