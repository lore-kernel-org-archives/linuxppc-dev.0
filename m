Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/1][PPC] Test value, not 1 in print_insn_spu(),
	arch/powerpc/xmon/spu-dis.c
From: Michael Ellerman <michael@ellerman.id.au>
To: Roel Kluin <12o3l@tiscali.nl>
In-Reply-To: <479DE26F.9050105@tiscali.nl>
References: <479DE26F.9050105@tiscali.nl>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-U2oLK8QOOir0Q/fLR5IM"
Date: Wed, 30 Jan 2008 00:24:12 +1100
Message-Id: <1201613053.26410.23.camel@concordia>
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


--=-U2oLK8QOOir0Q/fLR5IM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-01-28 at 15:10 +0100, Roel Kluin wrote:
> untested, please confirm:
> The '|| 1' does nothing, should this be corrected like my patch does?
> --
> Test value, not 1.
>=20
> Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
> ---
> diff --git a/arch/powerpc/xmon/spu-dis.c b/arch/powerpc/xmon/spu-dis.c
> index e5f8983..74d45fb 100644
> --- a/arch/powerpc/xmon/spu-dis.c
> +++ b/arch/powerpc/xmon/spu-dis.c
> @@ -222,7 +222,7 @@ print_insn_spu (unsigned long insn, unsigned long mem=
addr)
>  	      break;
>  	    case A_U18:
>  	      value =3D DECODE_INSN_U18 (insn);
> -	      if (value =3D=3D 0 || 1)
> +	      if (value =3D=3D 0 || value =3D=3D 1)
>  		{
>  		  hex_value =3D value;
>  		  printf("%u", value);

The original binutils code looks like:

            case A_U18:
              value =3D DECODE_INSN_U18 (insn);
              if (value =3D=3D 0 || !(*info->symbol_at_address_func)(0, inf=
o))
                {
                  hex_value =3D value;
                  (*info->fprintf_func) (info->stream, "%u", value);
                }
              else
                (*info->print_address_func) (value, info);
              break;

We don't have a symbol_at_address_func() so we always guess there isn't
a symbol at the address, as if the function had returned 0. Which gives
us:
              if (value =3D=3D 0 || !0)
or
              if (value =3D=3D 0 || 1)

The reason I left it like that rather than removing the if, was to
minimise the diff between the kernel version of spu-dis.c and the
binutils version.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-U2oLK8QOOir0Q/fLR5IM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHnyj8dSjSd0sB4dIRAnTSAJ0XaPvzp4MFbI3oQtS0lpjKYKPUJgCfVRJ0
wATre0G2Mvr2N8Sg1bdc2HM=
=ut+2
-----END PGP SIGNATURE-----

--=-U2oLK8QOOir0Q/fLR5IM--
