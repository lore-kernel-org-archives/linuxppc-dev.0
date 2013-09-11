Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AF5912C0112
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2013 09:41:52 +1000 (EST)
Message-ID: <1378942885.12204.448.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/2] powerpc/fsl-booke: Add initial T104x_QDS board support
From: Scott Wood <scottwood@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Date: Wed, 11 Sep 2013 18:41:25 -0500
In-Reply-To: <1378882706-19488-1-git-send-email-prabhakar@freescale.com>
References: <1378882706-19488-1-git-send-email-prabhakar@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Priyanka Jain <Priyanka.Jain@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Poonam Aggrwal <poonam.aggrwal@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-09-11 at 12:28 +0530, Prabhakar Kushwaha wrote:
>  Add support for T104x board in board file t104x_qds.c, It is common fo=
r
>  both T1040 and T1042 as they share same QDS board.
>=20
>  T1040QDS board Overview
>  -----------------------
>  - SERDES Connections, 8 lanes supporting:
>       =E2=80=94 PCI Express: supporting Gen 1 and Gen 2;
>       =E2=80=94 SGMII
>       =E2=80=94 QSGMII
>       =E2=80=94 SATA 2.0
>       =E2=80=94 Aurora debug with dedicated connectors (T1040 only)
>  - DDR Controller
>      - Supports rates of up to 1600 MHz data-rate
>      - Supports one DDR3LP UDIMM/RDIMMs, of single-, dual- or quad-rank=
 types.
>  -IFC/Local Bus
>      - NAND flash: 8-bit, async, up to 2GB.
>      - NOR: 8-bit or 16-bit, non-multiplexed, up to 512MB
>      - GASIC: Simple (minimal) target within Qixis FPGA
>      - PromJET rapid memory download support
>  - Ethernet
>      - Two on-board RGMII 10/100/1G ethernet ports.
>      - PHY #0 remains powered up during deep-sleep (T1040 only)
>  - QIXIS System Logic FPGA
>  - Clocks
>      - System and DDR clock (SYSCLK, =E2=80=9CDDRCLK=E2=80=9D)
>      - SERDES clocks
>  - Power Supplies
>  - Video
>      - DIU supports video at up to 1280x1024x32bpp
>  - USB
>      - Supports two USB 2.0 ports with integrated PHYs
>      =E2=80=94 Two type A ports with 5V@1.5A per port.
>      =E2=80=94 Second port can be converted to OTG mini-AB
>  - SDHC
>      - SDHC port connects directly to an adapter card slot, featuring:
>      - Supporting SD slots for: SD, SDHC (1x, 4x, 8x) and/or MMC
>      =E2=80=94 Supporting eMMC memory devices
>  - SPI
>     -  On-board support of 3 different devices and sizes
>  - Other IO
>     - Two Serial ports
>     - ProfiBus port
>     - Four I2C ports
>=20
>  Add T104xQDS support in Kconfig and Makefile. Also create device tree.
>=20
> Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> ---
> Based upon git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linu=
x.git
>=20
> TODO: Add noded for ethernet and board stuff

"board stuff"?

Isn't "board stuff" the whole point of this patch? :-)

>  arch/powerpc/boot/dts/t1040qds.dts      |  201 +++++++++++++++++++++++=
++++++++
>  arch/powerpc/boot/dts/t1042qds.dts      |  201 +++++++++++++++++++++++=
++++++++
>  arch/powerpc/platforms/85xx/Kconfig     |   20 +++
>  arch/powerpc/platforms/85xx/Makefile    |    1 +
>  arch/powerpc/platforms/85xx/t104x_qds.c |  102 ++++++++++++++++
>  5 files changed, 525 insertions(+)
>  create mode 100644 arch/powerpc/boot/dts/t1040qds.dts
>  create mode 100644 arch/powerpc/boot/dts/t1042qds.dts
>  create mode 100644 arch/powerpc/platforms/85xx/t104x_qds.c
>=20
> diff --git a/arch/powerpc/boot/dts/t1040qds.dts b/arch/powerpc/boot/dts=
/t1040qds.dts
> new file mode 100644
> index 0000000..cea5632
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/t1040qds.dts
> @@ -0,0 +1,201 @@
> +/*
> + * T1040QDS Device Tree Source
> + *
> + * Copyright 2013 Freescale Semiconductor Inc.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions =
are met:
> + *     * Redistributions of source code must retain the above copyrigh=
t
> + *	 notice, this list of conditions and the following disclaimer.
> + *     * Redistributions in binary form must reproduce the above copyr=
ight
> + *	 notice, this list of conditions and the following disclaimer in th=
e
> + *	 documentation and/or other materials provided with the distributio=
n.
> + *     * Neither the name of Freescale Semiconductor nor the
> + *	 names of its contributors may be used to endorse or promote produc=
ts
> + *	 derived from this software without specific prior written permissi=
on.
> + *
> + *
> + * ALTERNATIVELY, this software may be distributed under the terms of =
the
> + * GNU General Public License ("GPL") as published by the Free Softwar=
e
> + * Foundation, either version 2 of that License or (at your option) an=
y
> + * later version.
> + *
> + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor "AS IS" AND AN=
Y
> + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE I=
MPLIED
> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE =
ARE
> + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR=
 ANY
> + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL =
DAMAGES
> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR =
SERVICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CA=
USED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, =
OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE U=
SE OF THIS
> + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +/include/ "fsl/t104xsi-pre.dtsi"
> +
> +/ {
> +	model =3D "fsl,T1040QDS";
> +	compatible =3D "fsl,T1040QDS";
> +	#address-cells =3D <2>;
> +	#size-cells =3D <2>;
> +	interrupt-parent =3D <&mpic>;
> +
> +	aliases {
> +		 /* TODO */
> +		};

TODO?  Did you mean this patch as an RFC?

Also, whitespace.

> +		i2c@118000 {
> +                        pca9547@77 {
> +                                compatible =3D "philips,pca9547";
> +                                reg =3D <0x77>;
> +                        };
> +                       rtc@68 {
> +                                compatible =3D "dallas,ds3232";
> +                                reg =3D <0x68>;
> +                                interrupts =3D <0x1 0x1 0 0>;
> +                        };
> +		};
> +
> +	};

Whitespace

> +
> +	pci0: pcie@ffe240000 {
> +		reg =3D <0xf 0xfe240000 0 0x10000>;
> +		ranges =3D <0x02000000 0 0xe0000000 0xc 0x00000000 0x0 0x10000000
> +			  0x01000000 0 0x00000000 0xf 0xf8000000 0x0 0x00010000>;
> +		pcie@0 {
> +			ranges =3D <0x02000000 0 0xe0000000
> +				  0x02000000 0 0xe0000000
> +				  0 0x10000000
> +
> +				  0x01000000 0 0x00000000
> +				  0x01000000 0 0x00000000
> +				  0 0x00010000>;
> +		};
> +	};
> +
> +	pci1: pcie@ffe250000 {
> +		reg =3D <0xf 0xfe250000 0 0x10000>;
> +		ranges =3D <0x02000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x10000000
> +			  0x01000000 0x0 0x00000000 0xf 0xf8010000 0x0 0x00010000>;
> +		pcie@0 {
> +			ranges =3D <0x02000000 0 0xe0000000
> +				  0x02000000 0 0xe0000000
> +				  0 0x10000000
> +
> +				  0x01000000 0 0x00000000
> +				  0x01000000 0 0x00000000
> +				  0 0x00010000>;
> +		};
> +	};
> +
> +	pci2: pcie@ffe260000 {
> +		reg =3D <0xf 0xfe260000 0 0x1000>;
> +		ranges =3D <0x02000000 0 0xe0000000 0xc 0x40000000 0 0x10000000
> +			  0x01000000 0 0x00000000 0xf 0xf8020000 0 0x00010000>;
> +		pcie@0 {
> +			ranges =3D <0x02000000 0 0xe0000000
> +				  0x02000000 0 0xe0000000
> +				  0 0x10000000
> +
> +				  0x01000000 0 0x00000000
> +				  0x01000000 0 0x00000000
> +				  0 0x00010000>;
> +		};
> +	};
> +
> +	pci3: pcie@ffe270000 {
> +		reg =3D <0xf 0xfe270000 0 0x10000>;
> +		ranges =3D <0x02000000 0 0xe0000000 0xc 0x60000000 0 0x10000000
> +			  0x01000000 0 0x00000000 0xf 0xf8030000 0 0x00010000>;
> +		pcie@0 {
> +			ranges =3D <0x02000000 0 0xe0000000
> +				  0x02000000 0 0xe0000000
> +				  0 0x10000000
> +
> +				  0x01000000 0 0x00000000
> +				  0x01000000 0 0x00000000
> +				  0 0x00010000>;
> +		};
> +	};
> +};

Maybe some of this stuff could be put in a common dtsi between t1040 and
t1042?

Ideally for t1042 you'd just take the entire t1040 tree as an include,
and add the switch

> diff --git a/arch/powerpc/platforms/85xx/t104x_qds.c b/arch/powerpc/pla=
tforms/85xx/t104x_qds.c
> new file mode 100644
> index 0000000..d28da14
> --- /dev/null
> +++ b/arch/powerpc/platforms/85xx/t104x_qds.c
> @@ -0,0 +1,102 @@
> +/*
> + * T104x QDS Setup
> + * Should apply for QDS platform of T1040 and it's personalities.
> + * viz T1040/T1042
> + *
> + * Copyright 2013 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute	it and/or modif=
y it
> + * under  the terms of	the GNU General	 Public License as published by=
 the
> + * Free Software Foundation;  either version 2 of the  License, or (at=
 your
> + * option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/kdev_t.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/phy.h>
> +
> +#include <asm/time.h>
> +#include <asm/machdep.h>
> +#include <asm/pci-bridge.h>
> +#include <mm/mmu_decl.h>
> +#include <asm/prom.h>
> +#include <asm/udbg.h>
> +#include <asm/mpic.h>
> +
> +#include <linux/of_platform.h>
> +#include <sysdev/fsl_soc.h>
> +#include <sysdev/fsl_pci.h>
> +#include <asm/ehv_pic.h>
> +
> +#include "corenet_ds.h"

You don't need all of these includes.

> +define_machine(t104x_qds) {
> +	.name			=3D "T104x QDS",
> +	.probe			=3D t104x_qds_probe,

Should we have two machine descriptions, so that the proper chip name
shows up (e.g. in /proc/cpuinfo)?

> +/* coreint doesn't play nice with lazy EE, use legacy mpic for now */
> +#ifdef CONFIG_PPC64
> +	.get_irq		=3D mpic_get_irq,
> +#else
> +	.get_irq		=3D mpic_get_coreint_irq,
> +#endif

This isn't true any more.  When submitting code that was copied from
elsewhere, please check whether there were any updates in the code that
you copied from (unless you copied from b4qds, which the update missed
-- I just sent a patch to fix that).

-Scott
