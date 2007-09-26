Return-Path: <sfr@canb.auug.org.au>
Date: Wed, 26 Sep 2007 10:44:19 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH 2/2] fsl/embedded6xx: don't cast the result of
	of_get_property
Message-Id: <20070926104419.1b92002e.sfr@canb.auug.org.au>
In-Reply-To: <1189748800.165997.810365539433.2.gpush@pokey>
References: <1189748800.165136.731062325870.1.gpush@pokey>
	<1189748800.165997.810365539433.2.gpush@pokey>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__26_Sep_2007_10_44_19_+1000_0RoX4d1__iFx+l0A"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__26_Sep_2007_10_44_19_+1000_0RoX4d1__iFx+l0A
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Sep 2007 15:46:40 +1000 Jeremy Kerr <jk@ozlabs.org> wrote:
>
> -	avr_clock =3D *(u32*)of_get_property(avr, "clock-frequency", &len);
> -	phys_addr =3D ((u32*)of_get_property(avr, "reg", &len))[0];
> +	phys_addr =3D of_get_property(avr, "reg", &len);
> +	avr_clock_prop =3D of_get_property(avr, "clock-frequency", &len);

If you don't use the value of the len variable, then you can pass NULL to
of_get_property.

> +	if (!avr_clock || !phys_addr[0])

Not *phys_addr?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__26_Sep_2007_10_44_19_+1000_0RoX4d1__iFx+l0A
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG+atnTgG2atn1QN8RAvQKAJ9lIyrmmEjYM6kAuSQYoUibBPU2GACfeqaw
VLzzrHf5iSliEJpoWUa7kh0=
=+US9
-----END PGP SIGNATURE-----

--Signature=_Wed__26_Sep_2007_10_44_19_+1000_0RoX4d1__iFx+l0A--
