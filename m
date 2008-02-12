Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 5B532DDEC3
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 21:08:23 +1100 (EST)
Date: Tue, 12 Feb 2008 21:08:18 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Manish Ahuja <ahuja@austin.ibm.com>
Subject: Re: [PATCH 3/8] pseries: phyp dump: use sysfs to release reserved mem
Message-Id: <20080212210818.7b9099a4.sfr@canb.auug.org.au>
In-Reply-To: <47B146BE.5010807@austin.ibm.com>
References: <4782B985.2090508@austin.ibm.com> <47B13D2E.1070001@austin.ibm.com>
	<47B146BE.5010807@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__12_Feb_2008_21_08_18_+1100_GWI6ECfjm9.ivPiW"
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, linasvepstas@gmail.com,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__12_Feb_2008_21_08_18_+1100_GWI6ECfjm9.ivPiW
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Manish,

Just a small comment.

On Tue, 12 Feb 2008 01:11:58 -0600 Manish Ahuja <ahuja@austin.ibm.com> wrot=
e:
>
> +	/* Is there dump data waiting for us? */
> +	rtas =3D of_find_node_by_path("/rtas");
> +	dump_header =3D of_get_property(rtas, "ibm,kernel-dump", &header_len);

You need an of_node_put(rtas) here.

> +	if (dump_header =3D=3D NULL) {
> +		release_all();
> +		return 0;
> +	}

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__12_Feb_2008_21_08_18_+1100_GWI6ECfjm9.ivPiW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHsXAXTgG2atn1QN8RAnwAAJ9UR/4KrNoWMtWPgrqxw4jMAGYe9gCgkH56
Or4E4o4DLd8mMHS6V/ZTzY4=
=UnPk
-----END PGP SIGNATURE-----

--Signature=_Tue__12_Feb_2008_21_08_18_+1100_GWI6ECfjm9.ivPiW--
