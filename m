Return-Path: <sfr@canb.auug.org.au>
Date: Sun, 16 Sep 2007 22:31:13 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [PATCH 4/7] powerpc: BestComm core support for Freescale MPC5200
Message-Id: <20070916223113.0259fe32.sfr@canb.auug.org.au>
In-Reply-To: <1189940011134-git-send-email-tnt@246tNt.com>
References: <11899400103383-git-send-email-tnt@246tNt.com>
	<1189940011134-git-send-email-tnt@246tNt.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__16_Sep_2007_22_31_13_+1000_60W_WR4Y80jX0XPZ"
Cc: Grant Likely <glikely@gmail.com>, Paul Mackerras <paulus@samba.org>,
	PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__16_Sep_2007_22_31_13_+1000_60W_WR4Y80jX0XPZ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 16 Sep 2007 12:53:27 +0200 Sylvain Munaut <tnt@246tNt.com> wrote:
>
> +++ b/arch/powerpc/sysdev/bestcomm/Makefile
> @@ -0,0 +1,8 @@
> +#
> +# Makefile for BestComm & co
> +#
> +
> +bestcomm-core-objs	:=3D bestcomm.o sram.o
> +
> +obj-$(CONFIG_PPC_BESTCOMM)		+=3D bestcomm-core.o

Or just obj-y since the whole makefile is dependent on CONFIG_PPC_BESTCOMM.

> +++ b/arch/powerpc/sysdev/bestcomm/bestcomm.c
>
> +#include <asm/io.h>
> +#include <asm/irq.h>
> +#include <asm/prom.h>
> +#include <asm/mpc52xx.h>
> +#include <asm/of_device.h>
> +#include <asm/of_platform.h>

Please include linux/of_device.h and linux/of_platform.h instead.
And linux/of.h instead of asm/prom.h.

> +	ofn_bcom =3D op->node;
> +	of_node_get(ofn_bcom);

The usual idiom is ofn_bcom =3D of_get_node(op->node);

> +	/* Save the node */
> +	bcom_eng->ofnode =3D ofn_bcom;
> +
> +	/* Get, reserve & map io */
> +	if (of_address_to_resource(bcom_eng->ofnode, 0, &res_bcom)) {
                                   ^^^^^^^^^^^^^^^^
Any reason not to use ofn_bcom here?

> +	/* Error path */
> +error_unmap:
> +	iounmap(bcom_eng->regs);
> +error_release:
> +	release_mem_region(res_bcom.start, sizeof(struct mpc52xx_sdma));
> +error_sramclean:
> +	bcom_sram_cleanup();
> +error_ofput:
> +	of_node_put(bcom_eng->ofnode);
                    ^^^^^^^^^^^^^^^^
And here?  Also bcom_eng doesn't get freed in the error path.

> +++ b/arch/powerpc/sysdev/bestcomm/bestcomm_priv.h
> +#include <linux/spinlock.h>
> +#include <asm/io.h>
> +#include <asm/prom.h>

Again please include linux/of.h instead of asm/prom.h

> +++ b/arch/powerpc/sysdev/bestcomm/sram.c
> +
> +#include <asm/io.h>
> +#include <asm/mmu.h>
> +#include <asm/prom.h>

And again.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__16_Sep_2007_22_31_13_+1000_60W_WR4Y80jX0XPZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG7SIWTgG2atn1QN8RAsBWAJ47+zkjoReuAlymNnmPp2ItEje3eQCfY3QL
B3DN5F1NcRke0L7OsR1ywy8=
=7xFp
-----END PGP SIGNATURE-----

--Signature=_Sun__16_Sep_2007_22_31_13_+1000_60W_WR4Y80jX0XPZ--
