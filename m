Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B7DC167B8F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Oct 2006 05:51:30 +1000 (EST)
Date: Thu, 19 Oct 2006 23:51:23 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: "Kalle Pokki" <kalle.pokki@iki.fi>
Subject: Re: [PATCH] CPM_UART: Fix non-console initialisation
Message-ID: <20061019235123.2e542229@localhost.localdomain>
In-Reply-To: <a425f86c0610191240q3be8bc87q7f20a345e27a5d3d@mail.gmail.com>
References: <Pine.OSF.4.61.0610191525580.318096@kosh.hut.fi>
	<20061019231455.0ea159e1@localhost.localdomain>
	<a425f86c0610191240q3be8bc87q7f20a345e27a5d3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_ZGONDm5r75icQ/ypXEmMiys";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Sig_ZGONDm5r75icQ/ypXEmMiys
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Oct 2006 22:40:27 +0300
Kalle Pokki wrote:

> On 10/19/06, Vitaly Bordug <vbordug@ru.mvista.com> wrote:
> > And we end up with init_portdesc called unconditionally? this would
> > likely break, or at least confuse the code, that uses platform dev
> > to pass resources offsets.
>=20
> Well now that I look at it again, we should probably do
>=20
> if (cpm_uart_no =3D=3D 0)
>      cpm_uart_init_portdesc();
>=20
> to make it at least a little less confusing. Remember that
> init_portdesc() is not called when using platform device, so this
> should not affect those targets using it at all.
>=20
ok.
> > Personally, I don't care much of compat stuff, unless it is
> > breaking/confusing targets using proper resources...
>=20
> I'm sure there are still lots of people using the compat mode. As long
> as we have it, it should be kept functional.
I'm not for removing it - just any update to the compat stuff should=20
not touch platform-managed/ make it more  complex/confusing to deal with.

I believe it's cumbersome enough yet :-)


>=20
>=20
-Vitaly

--Sig_ZGONDm5r75icQ/ypXEmMiys
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFN9c7uOg9JvQhSEsRAvT/AKCmX/JZhqd6i4bJ3VVTNmTpcFv6NwCfdcBF
W8ITTvThQX8GI/ffLLJg8EA=
=e8eC
-----END PGP SIGNATURE-----

--Sig_ZGONDm5r75icQ/ypXEmMiys--
