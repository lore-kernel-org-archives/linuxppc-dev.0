Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 18E1CDDF14
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 12:42:21 +1100 (EST)
Date: Thu, 11 Dec 2008 12:42:11 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH 2/3] convert cpu_to_l2cache() to of_find_next_cache_node()
Message-Id: <20081211124211.c3bb5442.sfr@canb.auug.org.au>
In-Reply-To: <1228956366-17593-2-git-send-email-ntl@pobox.com>
References: <1228956366-17593-1-git-send-email-ntl@pobox.com>
	<1228956366-17593-2-git-send-email-ntl@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__11_Dec_2008_12_42_11_+1100_TcdrFrL.9cCbuSGK"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__11_Dec_2008_12_42_11_+1100_TcdrFrL.9cCbuSGK
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nathan,

On Wed, 10 Dec 2008 18:46:05 -0600 Nathan Lynch <ntl@pobox.com> wrote:
>
> @@ -418,13 +416,7 @@ static struct device_node *cpu_to_l2cache(int cpu)
>  	if (np =3D=3D NULL)
>  		return NULL;
> =20
> -	php =3D of_get_property(np, "l2-cache", NULL);
> -	if (php =3D=3D NULL)
> -		return NULL;
> -	ph =3D *php;
> -	of_node_put(np);
> -
> -	return of_find_node_by_phandle(ph);
> +	return of_find_next_cache_node(np);
>  }

This leaks a reference on np ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__11_Dec_2008_12_42_11_+1100_TcdrFrL.9cCbuSGK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklAb/MACgkQjjKRsyhoI8xN6ACgsFHNxqEcdjV2wWCAr4XEbc7L
gsUAn35jhC7Nd4M1VaJghq0AkExxMjpN
=vfXh
-----END PGP SIGNATURE-----

--Signature=_Thu__11_Dec_2008_12_42_11_+1100_TcdrFrL.9cCbuSGK--
