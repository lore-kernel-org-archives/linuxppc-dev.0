Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 67303DE0CC
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 10:23:20 +1000 (EST)
Date: Fri, 13 Jun 2008 10:23:13 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Robert Jennings <rcj@linux.vnet.ibm.com>
Subject: Re: [PATCH 02/19] powerpc: Split processor entitlement retrieval
	and gathering to helper routines
Message-Id: <20080613102313.0ce30d4d.sfr@canb.auug.org.au>
In-Reply-To: <20080612220858.GI30916@linux.vnet.ibm.com>
References: <20080612215312.GF30916@linux.vnet.ibm.com>
	<20080612220858.GI30916@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__13_Jun_2008_10_23_13_+1000_ULgxxAZUBJWQrBFe"
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, David Darrington <ddarring@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__13_Jun_2008_10_23_13_+1000_ULgxxAZUBJWQrBFe
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Robert,

On Thu, 12 Jun 2008 17:08:58 -0500 Robert Jennings <rcj@linux.vnet.ibm.com>=
 wrote:
>
> -		seq_printf(m, "R4=3D0x%lx\n", h_entitled);
> -		seq_printf(m, "R5=3D0x%lx\n", h_unallocated);
> -		seq_printf(m, "R6=3D0x%lx\n", h_aggregation);
> -		seq_printf(m, "R7=3D0x%lx\n", h_resource);

This changes a user visible interface by removing the above.  I don't
know if this matters (probably not), but it should be mentioned in the
changelog.

> +	if (new_entitled)
> +		*new_weight =3D current_weight;
> +
> +	if (new_weight)
> +		*new_entitled =3D current_entitled;

These look fishy - checking one pointer for NULL and then updating via
the other pointer.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__13_Jun_2008_10_23_13_+1000_ULgxxAZUBJWQrBFe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhRvfEACgkQTgG2atn1QN+rUgCeOgxggsUjWdvB6lJnIFPuNSP3
RZIAnjpqCPk7hzr08nSjCWVhfafWO8Ff
=Pqdv
-----END PGP SIGNATURE-----

--Signature=_Fri__13_Jun_2008_10_23_13_+1000_ULgxxAZUBJWQrBFe--
