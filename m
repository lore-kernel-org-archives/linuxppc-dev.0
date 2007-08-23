Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 68C7FDDF0F
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 16:14:03 +1000 (EST)
Date: Thu, 23 Aug 2007 16:13:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/2] [POWERPC] Size swapper_pg_dir correctly
Message-Id: <20070823161351.2a5f8096.sfr@canb.auug.org.au>
In-Reply-To: <DDBA4998-5BCC-413A-9759-3815693A68E6@kernel.crashing.org>
References: <20070823130913.2e9db6eb.sfr@canb.auug.org.au>
	<20070823131032.04d929e7.sfr@canb.auug.org.au>
	<DDBA4998-5BCC-413A-9759-3815693A68E6@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__23_Aug_2007_16_13_51_+1000_3ynvb930n/BHWoeV"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__23_Aug_2007_16_13_51_+1000_3ynvb930n/BHWoeV
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Aug 2007 22:26:35 -0500 Kumar Gala <galak@kernel.crashing.org> w=
rote:
>
> > +#ifdef CONFIG_PPC64
> > +	DEFINE(PGD_TABLE_SIZE, PGD_TABLE_SIZE);
> > +#endif
>=20
> Why limit this to ppc64?  The cleanup should be reasonable for all ppc.

Because PGD_TABLE_SIZE only exists for ppc64 :-) for ppc32 the
swapper_pg_dir will always be 1 page, right?

So we could have
#define PGD_TABLE_SIZE PAGE_SIZE
for 32 bit and then go around and change the swapper_pg_dir's, but that
would be a separate patch.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__23_Aug_2007_16_13_51_+1000_3ynvb930n/BHWoeV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGzSWqTgG2atn1QN8RAq8tAJwPFLAEiFYHZc6mI392s+JbgwZ3hQCgjepk
0dCkrTC39+6BR+69IeQEYzM=
=jtUC
-----END PGP SIGNATURE-----

--Signature=_Thu__23_Aug_2007_16_13_51_+1000_3ynvb930n/BHWoeV--
