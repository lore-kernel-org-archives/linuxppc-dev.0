Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 69DC41A018F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 09:10:42 +1100 (AEDT)
Date: Thu, 13 Nov 2014 09:10:36 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH]  of/base: Fix PowerPC address parsing hack
Message-ID: <20141113091036.4e9ec43d@canb.auug.org.au>
In-Reply-To: <1415771461.5124.33.camel@kernel.crashing.org>
References: <1415771461.5124.33.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YVBg/yUUqmVzB6hR1OqPj5B"; protocol="application/pgp-signature"
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Olof Johansson <olof@lixom.net>, Rob Herring <robherring2@gmail.com>,
 Grant Likely <grant.likely@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/YVBg/yUUqmVzB6hR1OqPj5B
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ben,

Urk!  :-)

How about:

On Wed, 12 Nov 2014 16:51:01 +1100 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index e371825..e37f017 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -7,6 +7,10 @@
>  #include <linux/pci_regs.h>
>  #include <linux/string.h>
> =20
> +#ifdef CONFIG_PPC
> +#include <asm/machdep.h>

#define IS_PMAC	machine_is(pmac)
#else
#define IS_PMAC	(0)

> +#endif
> +
>  /* Max address size we deal with */
>  #define OF_MAX_ADDR_CELLS	4
>  #define OF_CHECK_ADDR_COUNT(na)	((na) > 0 && (na) <=3D OF_MAX_ADDR_CELLS)
> @@ -428,12 +432,13 @@ static int of_translate_one(struct device_node *par=
ent, struct of_bus *bus,
>  	 * This code is only enabled on powerpc. --gcl
>  	 */
>  	ranges =3D of_get_property(parent, rprop, &rlen);
> -#if !defined(CONFIG_PPC)
> +#if defined(CONFIG_PPC)
> +	if (!machine_is(powermac))
> +#endif /* defined(CONFIG_PPC) */
>  	if (ranges =3D=3D NULL) {

if ((!IS_PMAC) && (ranges =3D=3D NULL)) {

> -		pr_err("OF: no ranges; cannot translate\n");
> +		pr_debug("OF: no ranges; cannot translate\n");
>  		return 1;
>  	}
> -#endif /* !defined(CONFIG_PPC) */
>  	if (ranges =3D=3D NULL || rlen =3D=3D 0) {
>  		offset =3D of_read_number(addr, na);
>  		memset(addr, 0, pna * 4);

There might be a better identifier than IS_PMAC ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/YVBg/yUUqmVzB6hR1OqPj5B
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUY9rhAAoJEMDTa8Ir7ZwVyfsP/1M0ZtuUeLMWMgKhzS6/A3If
pye7dEoEUIRdBDpXuYg5UZZ3D2yFDHaIOH/zXvgl3c22kwAOJjQXlly4TnukC8uu
aBrv0cZe4D0yLLfKVEUjKbfpOqm8A8Upw+C//WmC8HkPT2P8AlfvaKD46uCwSsLR
qplNmMfiQMJnUMjeTJu0T4Gq4O12VoWhR9UVgMBjqDJDblhHh0P2iB6iQnVghZVd
Y6Ch0ilsvAgcPWC6Or7lvOqNQkTtFSnOfT3E/cLWE6t20Su1mEXCAmDZQ5pBa9/E
HIYbnuCnFOnIu9Jn3IFkT+H9Kfpr6+2cnAdiGLPAbFkMziJsNcARaiLtXZH9i4ue
h/Hsg4ieHE7vor9MAVOLbNV0hYmjwzq6ahJ6nzF+5cRL3VOZnVDMzIURrU2K7t0j
pze6Lu0JWjeLVJmXEyaJC1ylON9S19hMsg0Ki6AR+tvO+4S/SFKot7l/SdkBIIep
+G0KBZHWF3M5ZlxsTBJ0XvKtdwgq0h/KKGbyaL2ByG31L6XIDFI2yM5lZ56kzdGL
ivqpd1zVH5mcx/38twxQe/rwNVK8p7j0X4/YEqYED1WeqGbWowrY4ga9sm5XXS3T
1CwZELExTkUowzexEnkYbXZQ8B3KbD09ePBIHnczDHHijXh/y9ZZkS7InqaLU0lL
kmSWYQ6iLYdZGpYMZaoA
=UoQz
-----END PGP SIGNATURE-----

--Sig_/YVBg/yUUqmVzB6hR1OqPj5B--
