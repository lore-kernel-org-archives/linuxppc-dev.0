Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 95BA5DDE99
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 14:45:48 +1100 (EST)
Date: Tue, 8 Jan 2008 14:45:37 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Manish Ahuja <ahuja@austin.ibm.com>
Subject: Re: [PATCH 4/8] pseries: phyp dump: use sysfs to release reserved mem
Message-Id: <20080108144537.39f21cd4.sfr@canb.auug.org.au>
In-Reply-To: <4782C225.3060305@austin.ibm.com>
References: <4782B985.2090508@austin.ibm.com> <4782C225.3060305@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__8_Jan_2008_14_45_37_+1100_7YkG=IEzQ/=w0ONY"
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, linasvepstas@gmail.com,
	lkessler@us.ibm.com, strosake@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__8_Jan_2008_14_45_37_+1100_7YkG=IEzQ/=w0ONY
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 07 Jan 2008 18:21:57 -0600 Manish Ahuja <ahuja@austin.ibm.com> wrot=
e:
>
> +static int __init phyp_dump_setup(void)
> +{
>
> +	/* Is there dump data waiting for us? */
> +	rtas =3D of_find_node_by_path("/rtas");
> +	dump_header =3D of_get_property(rtas, "ibm,kernel-dump", &header_len);
                                                               ^^^^^^^^^^^
You could pass NULL here as header_len appears to be unused. Also you
need "of_node_put(rtas)" somewhere (probably just here would do).

> +	if (dump_header =3D=3D NULL) {
> +		release_all();
> +		return 0;
> +	}
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__8_Jan_2008_14_45_37_+1100_7YkG=IEzQ/=w0ONY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHgvHlTgG2atn1QN8RArgBAJ9Izo2stkgjSBFe0GWS74KhhsgueQCfVcMG
KacokBkuwY1NiDYSSSdFkos=
=/yWJ
-----END PGP SIGNATURE-----

--Signature=_Tue__8_Jan_2008_14_45_37_+1100_7YkG=IEzQ/=w0ONY--
