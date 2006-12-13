Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id 416F567C4E
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 20:59:52 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] Adapt spi_mpc83xx SPI driver for 832x
Date: Wed, 13 Dec 2006 10:59:49 +0100
Message-ID: <F6AD7E21CDF4E145A44F61F43EE6D939BA6B69@tmnt04.transmode.se>
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "Vitaly Wool" <vitalywool@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Vitaly Wool [mailto:vitalywool@gmail.com]=20
> Sent: 13 December 2006 10:44
> To: Joakim Tjernlund
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] Adapt spi_mpc83xx SPI driver for 832x
>=20
> On 12/13/06, Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
>=20
> 	The MPC 832x has a different SPI controller i/f, probably due to
> 	its QUICC engine support. This patch adapts the=20
> spi_mpx83xx driver to
> 	be usable on QE based 83xx cpus.
> =09
>=20
>=20
> First, I'm pretty much against sending such patches to arch=20
> lists and not to subsystem lists.

OK, you don't want it on this list at all then?
=20
>=20
> @@ -99,31 +105,39 @@ static inline u32 mpc83xx_spi_read_reg(_
>         return in_be32(reg);
>  }
>=20
> Then,  this=20
> +       *rx++ =3D (type)(data >> shift);                       =20
>             \
> and this=20
> +       data =3D *tx++ << shift;                                  \
>=20
> pieces of code are potentially dangerous (what if 'shift' is=20
> something like 'x & 0xf3 << 4' ?)

>From this I think you want to change it to:
+       *rx++ =3D (type)(data >> (shift));

and=20
+       data =3D *tx++ << (shift);

Will do and resubmit to spi-devel-general@lists.sourceforge.net
as requested by you and Leo.

 Jocke
