Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id 667ED67A3B
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Dec 2006 19:20:47 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 2.6.20] powerpc: Changed gianfar device tree definition
	tomake it more flexible
Date: Mon, 4 Dec 2006 09:20:36 +0100
Message-ID: <F6AD7E21CDF4E145A44F61F43EE6D939B5008F@tmnt04.transmode.se>
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "Andy Fleming" <afleming@freescale.com>, <linuxppc-dev@ozlabs.org>,
	"Paul Mackerras" <paulus@samba.org>,
	"Kumar Gala" <galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From:=20
> linuxppc-dev-bounces+joakim.tjernlund=3Dtransmode.se@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+joakim.tjernlund=3Dtransmode.se@ozl
> abs.org] On Behalf Of Andy Fleming
> Sent: 01 December 2006 18:57
> To: linuxppc-dev@ozlabs.org; Paul Mackerras; Kumar Gala
> Subject: [PATCH 2.6.20] powerpc: Changed gianfar device tree=20
> definition tomake it more flexible
>=20
> The old gianfar node definition used a concept of "models" to
> determine the feature bits and interrupt settings to pass to the
> driver.  This won't scale well when the hardware designers come
> up with new and (hopefully) interesting variants of the eTSEC.
> So one goal of this patch is to prepare for that eventuality by
> listing the features, rather than inferring them.
>=20
> And then, incidentally, some of the code was cleaned up so that
> initialization functions will skip devices which encounter
> errors, rather than bailing.  The CPM devices were not modified
> in this way, as they are more complex.
>=20
> Finally, all the dts files with gianfar nodes were updated to use
> the new feature bits and the new interface field, and the various
> MAC address conventions were all accommodated by preserving the
> currently-used field, while adding local-mac-address, which will
> be used in the future (once u-boot changes have been made).
> Signed-off-by: Andrew Fleming <afleming@freescale.com>

[SNIP]

> +
> +static struct gfar_flag_info __initdata flag_info[] =3D {
> +	{ "gigabit", FSL_GIANFAR_DEV_HAS_GIGABIT },
> +	{ "coalescing", FSL_GIANFAR_DEV_HAS_COALESCE },
> +	{ "rmon", FSL_GIANFAR_DEV_HAS_RMON },
> +	{ "checksumming", FSL_GIANFAR_DEV_HAS_CSUM },
> +	{ "vlan", FSL_GIANFAR_DEV_HAS_VLAN },
> +	{ "extended-hash", FSL_GIANFAR_DEV_HAS_EXTENDED_HASH },
> +	{ "padding", FSL_GIANFAR_DEV_HAS_PADDING },
> +	{ "filer", FSL_GIANFAR_DEV_HAS_FILER },
> +	{ "parseL4", FSL_GIANFAR_DEV_HAS_PARSE_L4 },
> +	{ "parseL3", FSL_GIANFAR_DEV_HAS_PARSE_L3 },
> +	{ "parseL2", FSL_GIANFAR_DEV_HAS_PARSE_L2 },
> +	{ "multi-queue", FSL_GIANFAR_DEV_HAS_MULTI_QUEUE },
> +	{ "buffer-stashing", FSL_GIANFAR_DEV_HAS_BUF_STASHING },
> +	{ "buffer-locking", FSL_GIANFAR_DEV_HAS_BUF_LOCKING },
> +	{ "bd-stashing", FSL_GIANFAR_DEV_HAS_BD_STASHING },
> +	{ "bd-locking", FSL_GIANFAR_DEV_HAS_BD_LOCKING },
> +};

Shouldn't these be  mapped to generic names(drop the GIANFAR name)?
The newer UCC also have sevral of these capabilities and it seems
to me that one can use the same names instead of making a similar table.

 Jocke
