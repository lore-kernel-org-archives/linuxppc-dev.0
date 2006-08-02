Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Fix loop logic in irq_alloc_virt()
From: Michael Ellerman <michael@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <20060802004852.C66FB67B7F@ozlabs.org>
References: <20060802004852.C66FB67B7F@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-t6Zjw82D9tghU598sXPr"
Date: Wed, 02 Aug 2006 14:20:53 +1000
Message-Id: <1154492453.14858.5.camel@localhost.localdomain>
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


--=-t6Zjw82D9tghU598sXPr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-08-02 at 10:48 +1000, Michael Ellerman wrote:
> There's a bug in irq_alloc_virt() if it's asked for more than 1 interrupt=
,
> if it can't find a slot it might look past the end of the irq_map.
>=20
> I think this is a fix. No one in the kernel actually calls this with
> count > 1, so it's not critical.

> Index: to-merge/arch/powerpc/kernel/irq.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- to-merge.orig/arch/powerpc/kernel/irq.c
> +++ to-merge/arch/powerpc/kernel/irq.c
> @@ -745,14 +744,16 @@ unsigned int irq_alloc_virt(struct irq_h
>  	/* Look for count consecutive numbers in the allocatable
>  	 * (non-legacy) space
>  	 */
> -	for (i =3D NUM_ISA_INTERRUPTS; i <=3D limit; ) {
> -		for (j =3D i; j < (i + count); j++)
> -			if (irq_map[j].host !=3D NULL) {
> -				i =3D j + 1;
> -				continue;
> -			}
> -		found =3D i;
> -		break;

To be clear: the bug is that the continue affects the inner for loop,
not the outer one, so i becomes j + 1 and then we continue the inner
loop without checking if i is still <=3D limit.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-t6Zjw82D9tghU598sXPr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBE0CgldSjSd0sB4dIRAliLAKClxAG6/ot1lcWYqOONQtCiyc29TQCeKrho
nws3H7BDXKEbxS7zLq/Kd9A=
=Q56t
-----END PGP SIGNATURE-----

--=-t6Zjw82D9tghU598sXPr--
