Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.tip.net.au [IPv6:2402:b800:7003:1::44])
	by ozlabs.org (Postfix) with ESMTP id B632BB71CE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Aug 2011 18:33:37 +1000 (EST)
Date: Wed, 10 Aug 2011 18:33:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 1/3] powerpc: numa: Remove double of_node_put in
	hot_add_node_scn_to_nid
Message-Id: <20110810183328.cfdfeec82b0d9eb0721687a8@canb.auug.org.au>
In-Reply-To: <20110810064937.424887717@samba.org>
References: <20110810064937.424887717@samba.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__10_Aug_2011_18_33_28_+1000_rfCKpOUiTUuU8yTy"
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Wed__10_Aug_2011_18_33_28_+1000_rfCKpOUiTUuU8yTy
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Anton,

On Wed, 10 Aug 2011 16:49:34 +1000 Anton Blanchard <anton@samba.org> wrote:
>
> During memory hotplug testing, I got the following warning:
>=20
>=20
> ERROR: Bad of_node_put() on /memory@0
>=20
> of_find_node_by_type() loop does of_node_put for us so remove the
> duplicate one inside the loop.

But does an of_node_get() on its return value ..

> Signed-off-by: Anton Blanchard <anton@samba.org>
> Cc: stable@kernel.org
> ---
>=20
> Index: linux-powerpc/arch/powerpc/mm/numa.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-powerpc.orig/arch/powerpc/mm/numa.c	2011-06-06 08:07:35.1487080=
89 +1000
> +++ linux-powerpc/arch/powerpc/mm/numa.c	2011-08-10 11:31:59.723379868 +1=
000
> @@ -1214,7 +1214,6 @@ int hot_add_node_scn_to_nid(unsigned lon
>  			break;
>  		}
> =20
> -		of_node_put(memory);
>  		if (nid >=3D 0)
>  			break;
>  	}

Won't that need an of_node_put(memory) after the loop if (nid >=3D 0) ?  In
fact you should be able to just move the of_node_put(memory) to after the
loop since of_node_put(NULL) is fine.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__10_Aug_2011_18_33_28_+1000_rfCKpOUiTUuU8yTy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOQkJYAAoJEDMEi1NhKgbso7IIAIxL4b/OE5SuXVJTigQTc1C9
7vUtL0UuG9DwfIQk6zAJfDNq3+VqCR0pRyHUtO5uWzy17rCq0oajoeBFq85M6RO7
wfc37aYHnw66cV7pT9jB/0ZFLCfU5gRky9H+w7XVrojVYL8Z/RKb60YhE9lFMdId
i2VQbYSKabGDlqfxWExgKd039u1yY5+BdcbAnIGw0V1Yva4760Fa+BuqTViRAM4T
s8csMaiPmK1Y61Cip2T4ci+svPn0BtPVW0dpR9H5iURiI5rmbX7RpgUhLljcJJmn
Q4AGokjPkdUXVVzs2h3fu6EsH+IcTHSdi638cv6i2Pp3hB3yQvkDz5w+IYiUiF4=
=mJz2
-----END PGP SIGNATURE-----

--Signature=_Wed__10_Aug_2011_18_33_28_+1000_rfCKpOUiTUuU8yTy--
