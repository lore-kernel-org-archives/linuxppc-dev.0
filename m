Return-Path: <vasbridge@sanblaze.com>
Received: from mail.gazungle.com (mail.gazungle.com [207.210.240.68])
	by ozlabs.org (Postfix) with ESMTP id 0E042DE38F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Aug 2008 01:57:48 +1000 (EST)
From: "Vince Asbridge" <vasbridge@sanblaze.com>
To: "'Fillod Stephane'" <stephane.fillod@thomson.net>,
	"'linuxppc-embedded'" <linuxppc-embedded@ozlabs.org>
Subject: RE: [PATCH] RE: Some memory (DDR2 ECC Dual Rank) just doesn't work!
	Can anyone pointme to how to debug this hang?
Date: Thu, 14 Aug 2008 12:05:00 -0400
Message-ID: <0b1f01c8fe27$81d6b250$4b01a8c0@sanblaze.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <0B45E93C5FF65740AEAE690BF3848B7AD38359@rennsmail04.eu.thmulti.com>
Cc: u-boot@lists.denx.de, 'Stephen Shirron' <sshirron@sanblaze.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Stephane,

Thanks so much for your prompt reply.

We will pursue your suggestions, and let the forum know what we find.  =
We're
at 1.3.0 uboot version.

Vince

> -----Original Message-----
> From: Fillod Stephane [mailto:stephane.fillod@thomson.net]=20
> Sent: Thursday, August 14, 2008 8:06 AM
> To: Vince Asbridge; linuxppc-embedded
> Cc: u-boot@lists.denx.de
> Subject: [PATCH] RE: Some memory (DDR2 ECC Dual Rank) just=20
> doesn't work! Can anyone pointme to how to debug this hang?
>=20
> Vince Asbridge wrote:
> > We have an 8548 design, which implements a DDR2 on a SODIMM=20
> We have an=20
> > issue with dual rank memory (specific part number Viking=20
> VR5DR287218EBSS1), which is a 1G ECC Registered SODIMM part,=20
> with two ranks.
> > Our platform wires CS0 and CS1 to the SODIMM slot.=20
> > At uBoot, all is well.=A0 Memory is discovered as ECC 533, 1G=20
> DDR2 64Bit 4 beat bursts, and mtest can read and write all 1G=20
> of the SODIMM.
> [...]
> > Other DDR2s (identical except for vendor and # of ranks),=20
> work perfectly!=20
> > Anyone got a clue what I could look at to try to figure this out?=20
> > We've tried enable / disable ECC at uboot We've tried=20
> enable / disable=20
> > Interleaving at uboot uboot always works (and can read/write entire=20
> > DDR), Linux always hangs on boot!
>=20
> U-Boot is too gentle when testing SDRAM. Make sure the caches=20
> are enabled under U-Boot, and put on heavy stress with DMA,=20
> pipelined prefetch's, etc.
> This is what your CPU is enduring under Linux.=20
>=20
> Your question is definitely a question for the U-Boot mailing list.
> BTW, what is the version of U-Boot in use? U-Boot is still=20
> missing the following patch:
>=20
> MPC85xx BA bits not set for 3-bit bank address DIMM of CS1
>=20
> The current implementation set the number of bank address bits
> (BA) in the processor for CS0 but not for CS1.=20
>=20
> Signed-off-by: Stephane Fillod <stephane.fillod@thomson.net>
>=20
> --- u-boot/cpu/mpc85xx/spd_sdram.c
> +++ u-boot/cpu/mpc85xx/spd_sdram.c
> @@ -365,6 +365,7 @@
>                 ddr->cs1_config =3D ( 1<<31
>                                     | (odt_rd_cfg << 20)
>                                     | (odt_wr_cfg << 16)
> +                                   | (ba_bits << 14)
>                                     | (spd.nrow_addr - 12) << 8
>                                     | (spd.ncol_addr - 8) );
>                 debug("DDR: cs1_bnds   =3D 0x%08x\n", ddr->cs1_bnds);
>=20
>=20
>=20
> Otherwise, recompile with -DDEBUG and CFG_CMD_SDRAM, grab the=20
> Viking datasheet and a scope, and a full cup of coffee/tea=20
> much needed during cross-checking :-)
>=20
> Cheers
> --
> Stephane
>=20
>=20
>=20
