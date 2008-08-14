Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw3.extranet.thmulti.com (dmzraw3.extranet.thmulti.com
	[141.11.234.71]) by ozlabs.org (Postfix) with ESMTP id CFDE0DDEE3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Aug 2008 22:32:07 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [PATCH] RE: Some memory (DDR2 ECC Dual Rank) just doesn't work! Can
	anyone pointme to how to debug this hang?
Date: Thu, 14 Aug 2008 14:05:49 +0200
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7AD38359@rennsmail04.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: "Vince Asbridge" <vasbridge@sanblaze.com>,
	"linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Cc: u-boot@lists.denx.de
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Vince Asbridge wrote:
> We have an 8548 design, which implements a DDR2 on a SODIMM=20
> We have an issue with dual rank memory (specific part number Viking =
VR5DR287218EBSS1), which is a 1G ECC Registered SODIMM part, with two =
ranks.
> Our platform wires CS0 and CS1 to the SODIMM slot.=20
> At uBoot, all is well.=A0 Memory is discovered as ECC 533, 1G DDR2 =
64Bit 4 beat bursts, and mtest can read and write all 1G of the SODIMM.
[...]
> Other DDR2s (identical except for vendor and # of ranks), work =
perfectly!=20
> Anyone got a clue what I could look at to try to figure this out?=20
> We've tried enable / disable ECC at uboot=20
> We've tried enable / disable Interleaving at uboot=20
> uboot always works (and can read/write entire DDR), Linux always hangs =
on boot!=20

U-Boot is too gentle when testing SDRAM. Make sure the caches are =
enabled
under U-Boot, and put on heavy stress with DMA, pipelined prefetch's, =
etc.
This is what your CPU is enduring under Linux.=20

Your question is definitely a question for the U-Boot mailing list.
BTW, what is the version of U-Boot in use? U-Boot is still missing
the following patch:

MPC85xx BA bits not set for 3-bit bank address DIMM of CS1

The current implementation set the number of bank address bits
(BA) in the processor for CS0 but not for CS1.=20

Signed-off-by: Stephane Fillod <stephane.fillod@thomson.net>

--- u-boot/cpu/mpc85xx/spd_sdram.c
+++ u-boot/cpu/mpc85xx/spd_sdram.c
@@ -365,6 +365,7 @@
                ddr->cs1_config =3D ( 1<<31
                                    | (odt_rd_cfg << 20)
                                    | (odt_wr_cfg << 16)
+                                   | (ba_bits << 14)
                                    | (spd.nrow_addr - 12) << 8
                                    | (spd.ncol_addr - 8) );
                debug("DDR: cs1_bnds   =3D 0x%08x\n", ddr->cs1_bnds);



Otherwise, recompile with -DDEBUG and CFG_CMD_SDRAM, grab the Viking =
datasheet=20
and a scope, and a full cup of coffee/tea much needed during =
cross-checking :-)

Cheers
--=20
Stephane
