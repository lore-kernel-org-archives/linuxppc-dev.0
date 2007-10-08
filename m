Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id 5900BDDEE3
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Oct 2007 16:44:44 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1646765wag
	for <linuxppc-dev@ozlabs.org>; Sun, 07 Oct 2007 23:44:44 -0700 (PDT)
Message-ID: <fa686aa40710072344j15e40083x5a9790ed7eeeffdb@mail.gmail.com>
Date: Mon, 8 Oct 2007 00:44:43 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Marian Balakowicz" <m8@semihalf.com>
Subject: Re: [PATCH 07/15] [POWERPC] Promess Motion-PRO DTS
In-Reply-To: <4708C22D.5060805@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47075FA7.3030108@semihalf.com> <4708C22D.5060805@semihalf.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/7/07, Marian Balakowicz <m8@semihalf.com> wrote:
>
> Add device tree source file for Motion-PRO board.
>
> Signed-off-by: Marian Balakowicz <m8@semihalf.com>
> ---
>
>  motionpro.dts |  334 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 334 insertions(+)
>
> diff --git a/arch/powerpc/boot/dts/motionpro.dts b/arch/powerpc/boot/dts/motionpro.dts
> new file mode 100644
> index 0000000..4b197c8
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/motionpro.dts
> @@ -0,0 +1,334 @@
> +/*
> + * Motion-PRO board Device Tree Source, based on Lite5200B DTS.
> + *
> + * Copyright (C) 2007 Semihalf
> + * Modified for CM5200 by Marian Balakowicz <m8@semihalf.com>
> + *
> + * Copyright 2006-2007 Secret Lab Technologies Ltd.
> + * Grant Likely <grant.likely@secretlab.ca>
> + *
> + * Copyright (C) 2007 DENX Software Engineering
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +/*
> + * WARNING: Do not depend on this tree layout remaining static just yet.
> + * The MPC5200 device tree conventions are still in flux
> + * Keep an eye on the linuxppc-dev mailing list for more details
> + */
> +
> +/ {
> +       model = "fsl,motionpro";
> +       // revision = "1.0";
> +       compatible = "fsl,motionpro\0generic-mpc5200";

Not 'fsl,'

> +               pci@0d00 {
> +                       #interrupt-cells = <1>;
> +                       #size-cells = <2>;
> +                       #address-cells = <3>;
> +                       device_type = "pci";
> +                       compatible = "mpc5200b-pci\0mpc5200-pci";
> +                       reg = <d00 100>;
> +                       interrupt-map-mask = <f800 0 0 7>;
> +                       interrupt-map = <c000 0 0 1 &mpc5200_pic 0 0 3 // 1st slot
> +                                        c000 0 0 2 &mpc5200_pic 1 1 3
> +                                        c000 0 0 3 &mpc5200_pic 1 2 3
> +                                        c000 0 0 4 &mpc5200_pic 1 3 3
> +
> +                                        c800 0 0 1 &mpc5200_pic 1 1 3 // 2nd slot
> +                                        c800 0 0 2 &mpc5200_pic 1 2 3
> +                                        c800 0 0 3 &mpc5200_pic 1 3 3
> +                                        c800 0 0 4 &mpc5200_pic 0 0 3>;
> +                       clock-frequency = <0>; // From boot loader
> +                       interrupts = <2 8 0 2 9 0 2 a 0>;
> +                       interrupt-parent = <&mpc5200_pic>;
> +                       bus-range = <0 0>;
> +                       ranges = <42000000 0 80000000 80000000 0 20000000
> +                                 02000000 0 a0000000 a0000000 0 10000000
> +                                 01000000 0 00000000 b0000000 0 01000000>;
> +               };

PCI should no longer be a child of the soc node.

> +
> +               spi@f00 {
> +                       device_type = "spi";
> +                       compatible = "mpc5200b-spi\0mpc5200-spi";
> +                       reg = <f00 20>;
> +                       interrupts = <2 d 0 2 e 0>;
> +                       interrupt-parent = <&mpc5200_pic>;
> +               };
> +
> +               usb@1000 {
> +                       device_type = "usb-ohci-be";
> +                       compatible = "mpc5200b-ohci\0mpc5200-ohci\0ohci-be";
> +                       reg = <1000 ff>;
> +                       interrupts = <2 6 0>;
> +                       interrupt-parent = <&mpc5200_pic>;
> +               };
> +
> +               bestcomm@1200 {
> +                       device_type = "dma-controller";
> +                       compatible = "mpc5200b-bestcomm\0mpc5200-bestcomm";
> +                       reg = <1200 80>;
> +                       interrupts = <3 0 0  3 1 0  3 2 0  3 3 0
> +                                     3 4 0  3 5 0  3 6 0  3 7 0
> +                                     3 8 0  3 9 0  3 a 0  3 b 0
> +                                     3 c 0  3 d 0  3 e 0  3 f 0>;
> +                       interrupt-parent = <&mpc5200_pic>;
> +               };
> +
> +               xlb@1f00 {
> +                       compatible = "mpc5200b-xlb\0mpc5200-xlb";
> +                       reg = <1f00 100>;
> +               };
> +
> +               serial@2000 {           // PSC1
> +                       device_type = "serial";
> +                       compatible = "mpc5200b-psc-uart\0mpc5200-psc-uart";
> +                       port-number = <0>;  // Logical port assignment
> +                       cell-index = <0>;
> +                       reg = <2000 100>;
> +                       interrupts = <2 1 0>;
> +                       interrupt-parent = <&mpc5200_pic>;
> +               };
> +
> +               // PSC2 in spi master mode
> +               spi@2200 {              // PSC2
> +                       device_type = "spi";
> +                       compatible = "mpc5200b-psc-spi\0mpc5200-psc-spi";
> +                       cell-index = <1>;
> +                       reg = <2200 100>;
> +                       interrupts = <2 2 0>;
> +                       interrupt-parent = <&mpc5200_pic>;
> +               };
> +
> +               // PSC5 in uart mode example

Not an example if it is uncommented, change your comment.

> +               serial@2800 {           // PSC5
> +                       device_type = "serial";
> +                       compatible = "mpc5200b-psc-uart\0mpc5200-psc-uart";
> +                       port-number = <4>;  // Logical port assignment
> +                       cell-index = <4>;
> +                       reg = <2800 100>;
> +                       interrupts = <2 c 0>;
> +                       interrupt-parent = <&mpc5200_pic>;
> +               };
> +
> +               ethernet@3000 {
> +                       device_type = "network";
> +                       compatible = "mpc5200b-fec\0mpc5200-fec";
> +                       reg = <3000 800>;
> +                       mac-address = [ 02 03 04 05 06 07 ]; // Bad!

I really should fix this in the lite5200 device tree.

> +                       interrupts = <2 5 0>;
> +                       interrupt-parent = <&mpc5200_pic>;
> +               };
> +
> +               ata@3a00 {
> +                       device_type = "ata";
> +                       compatible = "mpc5200b-ata\0mpc5200-ata";
> +                       reg = <3a00 100>;
> +                       interrupts = <2 7 0>;
> +                       interrupt-parent = <&mpc5200_pic>;
> +               };
> +
> +               i2c@3d40 {
> +                       device_type = "i2c";
> +                       compatible = "mpc5200b-i2c\0mpc5200-i2c\0fsl-i2c";
> +                       cell-index = <1>;
> +                       reg = <3d40 40>;
> +                       interrupts = <2 10 0>;
> +                       interrupt-parent = <&mpc5200_pic>;
> +                       fsl5200-clocking;
> +               };
> +               sram@8000 {
> +                       device_type = "sram";
> +                       compatible = "mpc5200b-sram\0mpc5200-sram\0sram";
> +                       reg = <8000 4000>;
> +               };
> +
> +       };
> +       kollmorgen {
> +               device_type = "kollmorgen";
> +               compatible = "kollmorgen";
> +               reg = <50000000 ffff>;
> +               interrupts = <1 1 0>;
> +               interrupt-parent = <&mpc5200_pic>;
> +       };
> +       cpld {
> +               device_type = "cpld";
> +               compatible = "cpld";
> +               reg = <50010000 ffff>;
> +       };
> +       anybus {
> +               device_type = "anybus";
> +               compatible = "anybus";
> +               reg = <50020000 ffff>;
> +       };
> +       pro_module_general {
> +               device_type = "pro_module_general";
> +               compatible = "pro_module_general";

compatible properties should use '<manufacturer>,' prefixes.

> +               reg = <50020000 3>;
> +       };
> +       pro_module_dio {
> +               device_type = "pro_module_dio";
> +               compatible = "pro_module_dio";
> +               reg = <50020800 2>;
> +       };

So; what are 'kollmogens', 'anybusses' and 'pro_modules'?  This stuff
have some documentation attached to it.  If these are devices which
are only on this board; then I think you can just add comments about
each node to describe them.  If they are devices which will appear on
other boards, you should describe them in
Documentation/powerpc/booting-without-of.txt.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
