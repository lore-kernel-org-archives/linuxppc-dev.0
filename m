Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 61B11DE8FD
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 10:47:48 +1100 (EST)
Date: Thu, 8 Jan 2009 10:47:31 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH] infiniband/ehca: use consistent type
Message-Id: <20090108104731.6135319c.sfr@canb.auug.org.au>
In-Reply-To: <adazli2ud36.fsf@cisco.com>
References: <20081231141453.45d7f2c1.sfr@canb.auug.org.au>
	<adazli2ud36.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__8_Jan_2009_10_47_31_+1100_vvae_d6ol7O_vfig"
Cc: Heiko J Schick <schickhj@de.ibm.com>, Joachim Fenkes <fenkes@de.ibm.com>,
	ppc-dev <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	general@lists.openfabrics.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__8_Jan_2009_10_47_31_+1100_vvae_d6ol7O_vfig
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Roland,

On Wed, 07 Jan 2009 11:32:13 -0800 Roland Dreier <rdreier@cisco.com> wrote:
>
> If we're going to clean this code up, does it make sense to take it
> further?  More precisely, your patch does:
>=20
> @@ -226,7 +226,7 @@ u64 hipz_h_alloc_resource_eq(const struct ipz_adapter=
_handle adapter_handle,
>  			     u32 *eq_ist)
>  {
>  	u64 ret;
> -	u64 outs[PLPAR_HCALL9_BUFSIZE];
> +	unsigned long outs[PLPAR_HCALL9_BUFSIZE];
>  	u64 allocate_controls;
>=20
> but every parameter of ehca_plpar_hcall9() is unsigned long, and the
> return value is a signed long.  So should we change ret to long and all
> these other declarations to unsigned long while we're touching the code
> here?

At least all the others are passed by value and the normal arithmetic
promotion rules apply so no warnings are issued.  I will see how much of
a pain it is to change the others.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__8_Jan_2009_10_47_31_+1100_vvae_d6ol7O_vfig
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkllPxMACgkQjjKRsyhoI8zgmwCdFRa/El/eC3azYZpe37BLyDLM
N9EAoJ1dWpJ5w/BUqYQAawLD4P2VgqJX
=rxj8
-----END PGP SIGNATURE-----

--Signature=_Thu__8_Jan_2009_10_47_31_+1100_vvae_d6ol7O_vfig--
