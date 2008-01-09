Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id F00C5DDFA7
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 08:47:18 +1100 (EST)
Date: Thu, 10 Jan 2008 08:47:03 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 2/4 v2] PS3: Add logical performance monitor repository
	routines
Message-Id: <20080110084703.9bb09c39.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.64.0801091100470.1492@vixen.sonytel.be>
References: <477EF59C.2070809@am.sony.com> <47846B38.7010409@am.sony.com>
	<20080109181501.334e98c8.sfr@canb.auug.org.au>
	<Pine.LNX.4.64.0801091100470.1492@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__10_Jan_2008_08_47_03_+1100_Bly+6TudCjn1Rb6i"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Takashi Yamamoto <TakashiA.Yamamoto@jp.sony.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__10_Jan_2008_08_47_03_+1100_Bly+6TudCjn1Rb6i
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Jan 2008 11:01:38 +0100 (CET) Geert Uytterhoeven <Geert.Uytterhoe=
ven@sonycom.com> wrote:
>
> On Wed, 9 Jan 2008, Stephen Rothwell wrote:
> > On Tue, 08 Jan 2008 22:35:36 -0800 Geoff Levand <geoffrey.levand@am.son=
y.com> wrote:
> > >
> > > +int ps3_repository_read_num_pu(unsigned int *num_pu)
> > > +{
> > > +	int result;
> > > +	u64 v1;
> > > +
> > > +	v1 =3D 0;
> > > +	result =3D read_node(PS3_LPAR_ID_CURRENT,
> > > +			   make_first_field("bi", 0),
> > > +			   make_field("pun", 0),
> > > +			   0, 0,
> > > +			   &v1, NULL);
> > > +	*num_pu =3D v1;
> >=20
> > Why not just pass "num_pu" instead of &v1 to read_node()?
>=20
> We need a temporary because num_pu and v1 differ in size.
> The alternative is to make num_pu u64.

Ooops, sorry.  I read the second one first and didn't look hard enough
when I came back to this one.

> > > +int ps3_repository_read_pu_id(unsigned int pu_index, u64 *pu_id)
> > > +{
> > > +	int result;
> > > +	u64 v1;
> > > +
> > > +	v1 =3D 0;
> > > +	result =3D read_node(PS3_LPAR_ID_CURRENT,
> > > +		make_first_field("bi", 0),
> > > +		make_field("pu", pu_index),
> > > +		0, 0,
> > > +		&v1, NULL);
> > > +	*pu_id =3D v1;
> >=20
> > Similarly with "pu_id"?
>=20
> Yep, here we don't need the temporary.

Which, of course means that the "result" temporary isn't needed either.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__10_Jan_2008_08_47_03_+1100_Bly+6TudCjn1Rb6i
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHhUDcTgG2atn1QN8RArZuAJ9GHQ0GvnspVHbJNOeHgbJsv2vGMwCglGQM
po0PU0hyYczGZM2asBXDsT8=
=B2H3
-----END PGP SIGNATURE-----

--Signature=_Thu__10_Jan_2008_08_47_03_+1100_Bly+6TudCjn1Rb6i--
