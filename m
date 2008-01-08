Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E6413DDEB9
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 14:17:01 +1100 (EST)
Date: Tue, 8 Jan 2008 14:16:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Manish Ahuja <ahuja@austin.ibm.com>
Subject: Re: [PATCH 3/8] pseries: phyp dump: reserve-release proof-of-concept
Message-Id: <20080108141650.cab0cb85.sfr@canb.auug.org.au>
In-Reply-To: <4782C2FB.7020105@austin.ibm.com>
References: <4782B985.2090508@austin.ibm.com> <4782C2FB.7020105@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__8_Jan_2008_14_16_50_+1100_1Prz7ht565upfccq"
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

--Signature=_Tue__8_Jan_2008_14_16_50_+1100_1Prz7ht565upfccq
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Manish,

Just some trivial things ...

On Mon, 07 Jan 2008 18:25:31 -0600 Manish Ahuja <ahuja@austin.ibm.com> wrot=
e:
>
>=20
> +++ linux-2.6.24-rc2-git4/include/asm-powerpc/phyp_dump.h	2007-11-19 17:4=
4:21.000000000 -0600
> +#ifndef _PPC64_PHYP_DUMP_H

We more usually use _ASM_POWERPC_PHYP_DUMP_H

> +#define _PPC64_PHYP_DUMP_H
> +
> +#ifdef CONFIG_PHYP_DUMP

Do these things really need protecting by this CONFIG variable? i.e. does
anything change depending on the visibility of these various symbols?

> +++ linux-2.6.24-rc2-git4/arch/powerpc/platforms/pseries/phyp_dump.c	2007=
-11-19 19:07:49.000000000 -0600
> @@ -0,0 +1,71 @@
> +/*
> + * Hypervisor-assisted dump
> + *
> + * Linas Vepstas, Manish Ahuja 2007
> + * Copyrhgit (c) 2007 IBM Corp.
      ^^^^^^^^^
typo.  and you should really be using '=C2=A9' in new copyright notices (or
nothing).

> +/**
> + * release_memory_range -- release memory previously lmb_reserved
> + * @start_pfn: starting physical frame number
> + * @nr_pages: number of pages to free.
> + *
> + * This routine will release memory that had been previously
> + * lmb_reserved in early boot. The released memory becomes
> + * available for genreal use.
                    ^^^^^^^
typo.

> +release_memory_range(unsigned long start_pfn, unsigned long nr_pages)
> +{
> +	struct page *rpage;
> +	unsigned long end_pfn;
> +	long i;
> +
> +	end_pfn =3D start_pfn + nr_pages;
> +
> +	for (i=3Dstart_pfn; i <=3D end_pfn; i++) {

spaces around '=3D'

> +static int __init phyp_dump_setup(void)
> +{

> +}
> +
> +subsys_initcall(phyp_dump_setup);

Normally we don't leave a blank line here.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__8_Jan_2008_14_16_50_+1100_1Prz7ht565upfccq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHgusmTgG2atn1QN8RAknIAJwO53jI0lkVAaHPDyMWBd17tUacvQCfcuPx
hoShvWzsNevK24//yU8BkR0=
=XKdR
-----END PGP SIGNATURE-----

--Signature=_Tue__8_Jan_2008_14_16_50_+1100_1Prz7ht565upfccq--
