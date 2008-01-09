Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 859C8DDF61
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 18:15:13 +1100 (EST)
Date: Wed, 9 Jan 2008 18:15:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch 2/4 v2] PS3: Add logical performance monitor repository
	routines
Message-Id: <20080109181501.334e98c8.sfr@canb.auug.org.au>
In-Reply-To: <47846B38.7010409@am.sony.com>
References: <477EF59C.2070809@am.sony.com>
	<47846B38.7010409@am.sony.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__9_Jan_2008_18_15_01_+1100_t0K9mJof6y_lquVt"
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

--Signature=_Wed__9_Jan_2008_18_15_01_+1100_t0K9mJof6y_lquVt
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 08 Jan 2008 22:35:36 -0800 Geoff Levand <geoffrey.levand@am.sony.co=
m> wrote:
>
> +int ps3_repository_read_num_pu(unsigned int *num_pu)
> +{
> +	int result;
> +	u64 v1;
> +
> +	v1 =3D 0;
> +	result =3D read_node(PS3_LPAR_ID_CURRENT,
> +			   make_first_field("bi", 0),
> +			   make_field("pun", 0),
> +			   0, 0,
> +			   &v1, NULL);
> +	*num_pu =3D v1;

Why not just pass "num_pu" instead of &v1 to read_node()?

> +int ps3_repository_read_pu_id(unsigned int pu_index, u64 *pu_id)
> +{
> +	int result;
> +	u64 v1;
> +
> +	v1 =3D 0;
> +	result =3D read_node(PS3_LPAR_ID_CURRENT,
> +		make_first_field("bi", 0),
> +		make_field("pu", pu_index),
> +		0, 0,
> +		&v1, NULL);
> +	*pu_id =3D v1;

Similarly with "pu_id"?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__9_Jan_2008_18_15_01_+1100_t0K9mJof6y_lquVt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHhHR5TgG2atn1QN8RApYEAJ91ItpRYW8Xqh5nmoD3yjcv0wnu5QCgl/wn
MxUDJ4IRErYTVm0AOzuj0/U=
=dvcu
-----END PGP SIGNATURE-----

--Signature=_Wed__9_Jan_2008_18_15_01_+1100_t0K9mJof6y_lquVt--
