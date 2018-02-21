Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmgJP4qFxzDrKT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 01:45:24 +1100 (AEDT)
Date: Wed, 21 Feb 2018 15:44:10 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: christophe leroy <christophe.leroy@c-s.fr>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org,
 Joel Stanley <joel@jms.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Balbir Singh <bsingharora@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/6] powerpc/mm/32: Use pfn_valid to check if pointer is
 in RAM
Message-ID: <20180221144410.ckm4m366scrgk2rm@latitude>
References: <20180220161424.5421-1-j.neuschaefer@gmx.net>
 <20180220161424.5421-2-j.neuschaefer@gmx.net>
 <0d14cb2c-dd00-d258-cb15-302b2a9d684f@c-s.fr>
 <20180221135119.d3qgvdck5yruomi7@latitude>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="fphdnp5fz5oqdxfs"
In-Reply-To: <20180221135119.d3qgvdck5yruomi7@latitude>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--fphdnp5fz5oqdxfs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2018 at 02:51:19PM +0100, Jonathan Neusch=C3=A4fer wrote:
[...]
> While looking through arch/powerpc/mm, I noticed that there's a
> page_is_ram function, which simply uses the memblocks directly, on
> PPC32.

Oops, I misread the code here. memblock is used on PPC64.

> It seems like a good candidate for the RAM check in
> __ioremap_caller, except that there's this code, which apparently
> trashes memblock 0 completely on non-CONFIG_NEED_MULTIPLE_NODES:
>=20
>   https://elixir.bootlin.com/linux/v4.16-rc2/source/arch/powerpc/mm/mem.c=
#L223
>=20
>=20
> Thanks,
> Jonathan Neusch=C3=A4fer



--fphdnp5fz5oqdxfs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJajYW6AAoJEAgwRJqO81/bFD4P/jXB4GtqWaVXyc+1KcLnz2dz
y1sAXcvxMgvHA+saHWsoUzMD1T8QR+7Q5N5PKUFmeWPDLAjAJq8LyuVt/oxsey5f
EnBNlLGohqO4uF934qHvrDnfyopqesJWAx/v3/ioMAc34b5LX7wRH234hV1H/dyf
U85qSkTHTpH4bRxZyXwddsJFtEfKkE34oupi4YU4AX5VctNzCuW9eR4GE2BpJ6Iw
ibMaw/9U3hOO6ok2Wa3h6GgcqcNH0uD9TFLnvLbjCZJzCsGjCui/TGTb5tysLsoM
4qhJsJwSo0GAAzxtrrKevrV6qEezwFUIGk/certOiAz8BGhmOYqDFoItiYpYpf0K
aHrDj9MoviIaqfIdCfZCGp0t6fnt1cJb7a/wkbkORfqrsTjjZb0UTwvEgCIhrcy5
L9MEh7p2HLgwlRzW6nlZI6RdpuJK65RnVfIYN0Y+VVt4riBkMRBSiRs/wMFNI2YM
I41aDYtkpSl9ve0V+h+gUS/vjqaE8MkZlNobTt1TW+qmPPmquaHvLekeC27dGtwu
PlfOjWYMceMyqRd4iIcRZ2eQEUvslg9g94Yyl0FmFDMQLCJM1f6PW8FEKlA8pGSL
h+BwphnRhFAABKHC+0AaKpaBOWM9OVwL+LWkeeQifRao1IpL1Ml+E26Xl7icqIFE
4uM02EJ0azFFfpUdczVu
=K2aT
-----END PGP SIGNATURE-----

--fphdnp5fz5oqdxfs--
