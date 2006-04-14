Return-Path: <michael@ellerman.id.au>
Subject: Re: [patch][rfc]flattened device tree: Passing a dtb (blob) to Linux.
From: Michael Ellerman <michael@ellerman.id.au>
To: Jimi Xenidis <jimix@watson.ibm.com>
In-Reply-To: <52F25F7B-ED3C-4A72-A8C9-3631D8D83357@watson.ibm.com>
References: <5148225C-AE27-4365-A1C2-40C46491AF0D@watson.ibm.com>
	<1144969933.4935.45.camel@localhost.localdomain>
	<52F25F7B-ED3C-4A72-A8C9-3631D8D83357@watson.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-+RshDvleMe0GuYXf15cA"
Date: Fri, 14 Apr 2006 18:19:50 +0200
Message-Id: <1145031590.13366.5.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-+RshDvleMe0GuYXf15cA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-04-14 at 08:45 -0400, Jimi Xenidis wrote:
> On Apr 13, 2006, at 7:12 PM, Benjamin Herrenschmidt wrote:
> >
> > We should make lmb_reserve() of redudant/overlapping entries become
> > harmless I think.
>=20
> Hmm.. I think it would be worthy of a warning, no?

Definitely. We had weird bugs in kexec because regions were overlapping.
I just haven't got 'round to writing the patch .. maybe I should :)

> > We need to be backward compatible with earlier blobs
> > that do contain themselves in the reserve map
>=20
> Do you think it is possible that the blob may have a single =20
> reservation that includes the blob but is larger? if not then we =20
> could simply do..

Well it's definitely possible, but I don't know if anyone actually does
it. But I guess we should try to be nice and not warn for old blobs.

This patch looks like a decent approach, although I'd want to add a
check so that if the blob is reserved _three_ times we do warn, it's
getting a bit silly isn't it :)

cheers

> --
> diff -r eb0990a251a9 arch/powerpc/kernel/prom.c
> --- a/arch/powerpc/kernel/prom.c	Thu Mar 30 22:05:40 2006 -0500
> +++ b/arch/powerpc/kernel/prom.c	Fri Apr 14 08:44:10 2006 -0400
> @@ -1129,9 +1129,17 @@ static void __init early_reserve_mem(voi
> {
> 	u64 base, size;
> 	u64 *reserve_map;
> +	unsigned long self_base;
> +	unsigned long self_size;
> 	reserve_map =3D (u64 *)(((unsigned long)initial_boot_params) +
> 					initial_boot_params->off_mem_rsvmap);
> +
> +	/* before we do anything, lets reserve the dt blob */
> +	self_base =3D __pa((unsigned long)initial_boot_params);
> +	self_size =3D initial_boot_params->totalsize;
> +	lmb_reserve(self_base, self_size);
> +
> #ifdef CONFIG_PPC32
> 	/*
> 	 * Handle the case where we might be booting from an old kexec
> @@ -1146,6 +1154,9 @@ static void __init early_reserve_mem(voi
> 			size_32 =3D *(reserve_map_32++);
> 			if (size_32 =3D=3D 0)
> 				break;
> +			/* skip if the reservation is for the blob */
> +			if (base_32 =3D=3D self_base && size_32 =3D=3D self_size)
> +				continue;
> 			DBG("reserving: %x -> %x\n", base_32, size_32);
> 			lmb_reserve(base_32, size_32);
> 		}
> @@ -1157,6 +1168,9 @@ static void __init early_reserve_mem(voi
> 		size =3D *(reserve_map++);
> 		if (size =3D=3D 0)
> 			break;
> +		/* skip if the reservation is for the blob */
> +		if (base =3D=3D self_base && size =3D=3D self_size)
> +			continue;
> 		DBG("reserving: %llx -> %llx\n", base, size);
> 		lmb_reserve(base, size);
> 	}
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-+RshDvleMe0GuYXf15cA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEP8umdSjSd0sB4dIRAiMgAJ9uKw9FF6sny+MDRpcgO9VB431WkwCgx2RX
Lqtyhbsj9ZNeSS1EhlSJZHo=
=AevQ
-----END PGP SIGNATURE-----

--=-+RshDvleMe0GuYXf15cA--
