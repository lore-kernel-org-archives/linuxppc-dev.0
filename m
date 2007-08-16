Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] [POWERPC] Invalid semicolon after if statement
From: Michael Ellerman <michael@ellerman.id.au>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@helsinki.fi>
In-Reply-To: <Pine.LNX.4.64.0708151644090.15670@kivilampi-30.cs.helsinki.fi>
References: <Pine.LNX.4.64.0708151644090.15670@kivilampi-30.cs.helsinki.fi>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-iAoc3Yby5fKEIL8I0I/i"
Date: Thu, 16 Aug 2007 18:08:22 +1000
Message-Id: <1187251702.8375.43.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-iAoc3Yby5fKEIL8I0I/i
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-08-16 at 01:03 +0300, Ilpo J=C3=A4rvinen wrote:
> A similar fix to netfilter from Eric Dumazet inspired me to
> look around a bit by using some grep/sed stuff as looking for
> this kind of bugs seemed easy to automate. This is one of them
> I found where it looks like this semicolon is not valid.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@helsinki.fi>
> ---
>=20
> ...Since I'm not familiar with these parts of the kernel, you might know=20
> better than I do if this is stuff is valid...
>=20
>  arch/powerpc/mm/hash_utils_64.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils=
_64.c
> index f178957..a47151e 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -795,7 +795,7 @@ void hash_preload(struct mm_struct *mm, unsigned long=
 ea,
> =20
>  #ifdef CONFIG_PPC_MM_SLICES
>  	/* We only prefault standard pages for now */
> -	if (unlikely(get_slice_psize(mm, ea) !=3D mm->context.user_psize));
> +	if (unlikely(get_slice_psize(mm, ea) !=3D mm->context.user_psize))
>  		return;
>  #endif

Er yeah that's bad. On kernels with MM_SLICES set we never prefault
anything .. oops ..

And testing confirms that's what's happening, with the semicolon gone we
do prefault somethings.

Thanks to the frickin compiler for warning us, not.

This should probably go to stable for 22 IMHO.

Nice catch Ilpo, perhaps someone should hack sparse to check for that
sort of thing.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-iAoc3Yby5fKEIL8I0I/i
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGxAX2dSjSd0sB4dIRAm6WAJ9fuayq0rOU7G/IUutlitLMgN6jeACfbY9+
qgXbRHQ6piWjZKAY3O8mBp4=
=2u+E
-----END PGP SIGNATURE-----

--=-iAoc3Yby5fKEIL8I0I/i--
