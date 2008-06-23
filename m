Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/1] Change the default link address for pSeries zImage
	kernels.
From: Michael Ellerman <michael@ellerman.id.au>
To: Tony Breeds <tony@bakeyournoodle.com>
In-Reply-To: <1a551391a3c4925271cc86cb2e957aaccb0b599c.1214208801.git.tony@bakeyournoodle.com>
References: <1a551391a3c4925271cc86cb2e957aaccb0b599c.1214208801.git.tony@bakeyournoodle.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-LADZtEevsbUli/Iq5e+6"
Date: Mon, 23 Jun 2008 22:20:37 +1000
Message-Id: <1214223637.7573.2.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-LADZtEevsbUli/Iq5e+6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-06-23 at 18:13 +1000, Tony Breeds wrote:
> Currently we set the start of the .text section to be 4Mb for pSeries.
> In situations where the zImage is > 8Mb we'll fail to boot (due to
> overlapping with OF).  Move .text in a zImage from 4MB to 64MB (well past=
 OF).
...
> diff --git a/arch/powerpc/boot/oflib.c b/arch/powerpc/boot/oflib.c
> index 95b8fd6..93a1a84 100644
> --- a/arch/powerpc/boot/oflib.c
> +++ b/arch/powerpc/boot/oflib.c
> @@ -168,8 +168,19 @@ void *of_claim(unsigned long virt, unsigned long siz=
e, unsigned long align)
> =20
>  void *of_vmlinux_alloc(unsigned long size)
>  {
> -	void *p =3D malloc(size);
> -
> +	unsigned long start =3D (unsigned long)_start, end =3D (unsigned long)_=
end;
> +	void *addr;
> +	void *p;
> +
> +	/* With some older POWER4 firmware the we need to claim the area

Sorry, typo/grammaro :/                     ^^^^^^

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-LADZtEevsbUli/Iq5e+6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIX5UVdSjSd0sB4dIRAlVjAKCe1TcR6eyaXT6l1Nhtmg/GD/BOWQCfW/Ec
kd1nRE9H/x0Ccrf1ecaIKXU=
=HnPE
-----END PGP SIGNATURE-----

--=-LADZtEevsbUli/Iq5e+6--
