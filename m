Return-Path: <glikely@secretlab.ca>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.27])
	by ozlabs.org (Postfix) with ESMTP id 05440B7D42
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 23:15:18 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so353450qwe.15
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 04:15:16 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4B99DE95.8010304@freemail.hu>
References: <4B934CCA.8030608@freemail.hu>
	<fa686aa41003080934q5d5bebabl7d582d1264da4dcd@mail.gmail.com>
	<4B95458A.4000304@freemail.hu>
	<fa686aa41003081108v31e73660pa817863e5aa73653@mail.gmail.com>
	<4B95F298.5040000@freemail.hu>
	<fa686aa41003082335t5a5d642fi13c81e4b84f7b697@mail.gmail.com>
	<4B9889AC.4080309@freemail.hu> <20100311062331.GI11655@yookeroo>
	<4B99DE95.8010304@freemail.hu>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 12 Mar 2010 05:14:56 -0700
Message-ID: <fa686aa41003120414j48825e7cr952336703fe03b04@mail.gmail.com>
Subject: Re: Freescale MPC5554 device tree (was: cross-compiling Linux for
	PowerPC e200 core?)
To: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2010/3/11 N=E9meth M=E1rton <nm127@freemail.hu>:
> Hi,
>
> thank you for the comments, I reworked the Freescale MPC5554 device tree
> accordingly. I'm listening for comments on this draft.
>
> Regards,
>
> =A0 =A0 =A0 =A0M=E1rton N=E9meth
>
> ---
> From: M=E1rton N=E9meth <nm127@freemail.hu>
>
> Add device tree for Freescale MPC5554.
>
> Signed-off-by: M=E1rton N=E9meth <nm127@freemail.hu>
> ---
> diff -uprN linux-2.6.33.orig/arch/powerpc/boot/dts/mpc5554.dts linux/arch=
/powerpc/boot/dts/mpc5554.dts
> --- linux-2.6.33.orig/arch/powerpc/boot/dts/mpc5554.dts 1970-01-01 01:00:=
00.000000000 +0100
> +++ linux/arch/powerpc/boot/dts/mpc5554.dts =A0 =A0 2010-03-12 07:22:37.0=
00000000 +0100
> @@ -0,0 +1,189 @@
> +/*
> + * Freescale MPC5554 Device Tree Source
> + *
> + * Based on MPC5553/5554 Microcontroller Reference Manual, Rev. 4.0, 04/=
2007
> + * http://www.freescale.com/files/32bit/doc/ref_manual/MPC5553_MPC5554_R=
M.pdf
> + *
> + * Copyright 2010 M=E1rton N=E9meth
> + * M=E1rton N=E9meth <nm127@freemail.hu>
> + *
> + * This program is free software; you can redistribute =A0it and/or modi=
fy it
> + * under =A0the terms of =A0the GNU General =A0Public License as publish=
ed by the
> + * Free Software Foundation; =A0either version 2 of the =A0License, or (=
at your
> + * option) any later version.
> + */
> +
> +/dts-v1/;
> +
> +/ {
> + =A0 =A0 =A0 model =3D "MPC5554";
> + =A0 =A0 =A0 compatible =3D "fsl,MPC5554EVB"; =A0 =A0 =A0 =A0 =A0// Free=
scale MPC5554 Evaluation Board
> + =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 #size-cells =3D <1>;

also need: interrupt-parent =3D <&intc>;

I describe why later...

> +
> + =A0 =A0 =A0 cpus {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu@0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "cpu";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "PowerPC,555=
4";

I'd rather see the same convention used here as for all the other
compatible values in this file.  ie:

compatible =3D "fsl,mpc5554-e200z6", "fsl,powerpc-e200z6";

Dave, what do you think?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d-cache-line-size =3D <32>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i-cache-line-size =3D <32>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d-cache-size =3D <0x8000>; =
=A0 =A0 =A0 =A0// L1, 32KiB
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i-cache-size =3D <0x8000>; =
=A0 =A0 =A0 =A0// L1, 32KiB
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timebase-frequency =3D <0>;=
 =A0 =A0 =A0 // from bootloader
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus-frequency =3D <0>; =A0 =
=A0 =A0 =A0 =A0 =A0// from bootloader
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-frequency =3D <0>; =
=A0 =A0 =A0 =A0 =A0// from bootloader
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 memory@40000000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "memory";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x40000000 0x10000>; =A0 =A0 // 32=
KiB internal SRAM
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 xbar@fff04000 { =A0 =A0 =A0 =A0 // System Bus Crossbar Swit=
ch (XBAR)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5554-xbar";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 // The full memory range is covered by XBAR
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges =3D <>;

An empty ranges property looks like this:

ranges;

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bridge@fff00000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5554=
-pbridge-b";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges =3D <0 0xe0000000 0x=
20000000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0xfff00000 0x4000>=
;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ecsm@fff40000 { =A0 =A0 =A0=
 =A0 // Error Correction Status Module (ECSM)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =
=3D "fsl,mpc5554-ecsm";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x=
fff40000 0x4000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 edma@fff44000 { =A0 =A0 =A0=
 =A0 // Enhanced DMA Controller (eDMA)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =
=3D "fsl,mpc5554-edma";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x=
fff44000 0x4000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 intc@fff48000 { =A0 =A0 =A0=
 =A0 // Interrupt Controller (INTC)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =
=3D "fsl,mpc5554-intc";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x=
fff48000 0x4000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };

Need a label on this node so that the rest of the tree can find it,
and it needs the interrupt-controller and #interrupt-cells properties:

                       intc: intc@fff48000 {         // Interrupt
Controller (INTC)
                               compatible =3D "fsl,mpc5554-intc";
                               interrupt-controller;
                               #interrupt-cells =3D <2>;
                               reg =3D <0xfff48000 0x4000>;
                       };

I've set #interrupt-cells to 2 which is fairly typical on fsl parts,
but that may or may not make sense.  You need to decide how each
device is going to specify it's interrupt line.  Often the first cell
is the hardware interrupt number, and the second cell encodes the
sense (high, low, edge).  Conversely, PCI interrupts only use
#interrupt-cells =3D <1> because all PCI irqs use the active low sense.

Then, each device in the tree should have an 'interrupts =3D < [hwirq#]
[sense]>;' property.

Otherwise, starting to look pretty good.

g.
