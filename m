Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id 2AF3CDDFB5
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 02:58:19 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1617007anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 08 Jan 2008 07:58:18 -0800 (PST)
Message-ID: <fa686aa40801080758o35dce96ej5db45576769561a5@mail.gmail.com>
Date: Tue, 8 Jan 2008 08:58:17 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Li Yang" <leoli@freescale.com>
Subject: Re: [PATCH 1/3] add default device trees for MPC837x MDS board
In-Reply-To: <1199707400-23588-1-git-send-email-leoli@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1199707400-23588-1-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Leo,

comments below.  I've made my comments on the first file, but they
apply to the other two also.

Cheers,
g.


On 1/7/08, Li Yang <leoli@freescale.com> wrote:
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> address comments and use new dts spec.
>
>  arch/powerpc/boot/dts/mpc8377_mds.dts |  277 +++++++++++++++++++++++++++++++
>  arch/powerpc/boot/dts/mpc8378_mds.dts |  263 +++++++++++++++++++++++++++++
>  arch/powerpc/boot/dts/mpc8379_mds.dts |  291 +++++++++++++++++++++++++++++++++
>  3 files changed, 831 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
> new file mode 100644
> index 0000000..b50b5f9
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
> @@ -0,0 +1,277 @@
> +/*
> + * MPC8377E MDS Device Tree Source
> + *
> + * Copyright 2007 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +/ {
> +       model = "fsl,mpc8377emds";
> +       compatible = "fsl,mpc8377emds","fsl,mpc837xmds";

Compatibility at the board level is a really hard thing to claim.  I'd
drop the "fsl,mpc837xmds" here and make the platform code bind to
either.

> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +
> +       aliases {
> +               ethernet0 = &enet0;
> +               ethernet1 = &enet1;
> +               serial0 = &serial0;
> +               serial1 = &serial1;
> +               pci0 = &pci0;
> +       };
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               PowerPC,8377@0 {
> +                       device_type = "cpu";
> +                       reg = <0>;
> +                       d-cache-line-size = <20>;
> +                       i-cache-line-size = <20>;
> +                       d-cache-size = <8000>;          // L1, 32K
> +                       i-cache-size = <8000>;          // L1, 32K
> +                       timebase-frequency = <0>;
> +                       bus-frequency = <0>;
> +                       clock-frequency = <0>;
> +               };
> +       };
> +
> +       memory {
> +               device_type = "memory";
> +               reg = <00000000 20000000>;      // 512MB at 0
> +       };
> +
> +       soc@e0000000 {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               device_type = "soc";

I recommend dropping device_type and adding 'compatible = "fsl,mpc8377-immr";'

> +               ranges = <0 e0000000 00100000>;
> +               reg = <e0000000 00000200>;
> +               bus-frequency = <0>;
> +
> +               wdt@200 {
> +                       compatible = "mpc83xx_wdt";

"fsl,mpc8377_wdt", "fsl,mpc83xx_wdt" as per generic names recommended practice.

> +                       reg = <200 100>;
> +               };
> +
> +               i2c@3000 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       cell-index = <0>;
> +                       compatible = "fsl-i2c";
> +                       reg = <3000 100>;
> +                       interrupts = <e 8>;
> +                       interrupt-parent = < &ipic >;
> +                       dfsrr;
> +               };
> +
> +               i2c@3100 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       cell-index = <1>;
> +                       compatible = "fsl-i2c";
> +                       reg = <3100 100>;
> +                       interrupts = <f 8>;
> +                       interrupt-parent = < &ipic >;
> +                       dfsrr;
> +               };
> +
> +               spi@7000 {
> +                       compatible = "fsl_spi";
> +                       reg = <7000 1000>;
> +                       interrupts = <10 8>;
> +                       interrupt-parent = < &ipic >;
> +                       mode = "cpu";
> +               };
> +
> +               /* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
> +               usb@23000 {
> +                       compatible = "fsl-usb2-dr";
> +                       reg = <23000 1000>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       interrupt-parent = < &ipic >;
> +                       interrupts = <26 8>;
> +                       phy_type = "utmi_wide";

fsl,phy_type please.

> +               };
> +
> +               mdio@24520 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       compatible = "fsl,gianfar-mdio";
> +                       reg = <24520 20>;
> +                       phy2: ethernet-phy@2 {
> +                               interrupt-parent = < &ipic >;
> +                               interrupts = <11 8>;
> +                               reg = <2>;
> +                               device_type = "ethernet-phy";
> +                       };
> +                       phy3: ethernet-phy@3 {
> +                               interrupt-parent = < &ipic >;
> +                               interrupts = <12 8>;
> +                               reg = <3>;
> +                               device_type = "ethernet-phy";
> +                       };
> +               };
> +
> +               enet0: ethernet@24000 {
> +                       cell-index = <0>;
> +                       device_type = "network";
> +                       model = "eTSEC";

Drop model property

> +                       compatible = "gianfar";
> +                       reg = <24000 1000>;
> +                       local-mac-address = [ 00 00 00 00 00 00 ];
> +                       interrupts = <20 8 21 8 22 8>;
> +                       phy-connection-type = "mii";
> +                       interrupt-parent = < &ipic >;
> +                       phy-handle = < &phy2 >;
> +               };
> +
> +               enet1: ethernet@25000 {
> +                       cell-index = <1>;
> +                       device_type = "network";
> +                       model = "eTSEC";

Drop model property.

> +                       compatible = "gianfar";
> +                       reg = <25000 1000>;
> +                       local-mac-address = [ 00 00 00 00 00 00 ];
> +                       interrupts = <23 8 24 8 25 8>;
> +                       phy-connection-type = "mii";
> +                       interrupt-parent = < &ipic >;
> +                       phy-handle = < &phy3 >;
> +               };
> +
> +               serial0: serial@4500 {
> +                       cell-index = <0>;
> +                       device_type = "serial";
> +                       compatible = "ns16550";
> +                       reg = <4500 100>;
> +                       clock-frequency = <0>;
> +                       interrupts = <9 8>;
> +                       interrupt-parent = < &ipic >;
> +               };
> +
> +               serial1: serial@4600 {
> +                       cell-index = <1>;
> +                       device_type = "serial";
> +                       compatible = "ns16550";
> +                       reg = <4600 100>;
> +                       clock-frequency = <0>;
> +                       interrupts = <a 8>;
> +                       interrupt-parent = < &ipic >;
> +               };
> +
> +               crypto@30000 {
> +                       model = "SEC3";

Drop model property and encode relevant info into compatible.

> +                       compatible = "talitos";
> +                       reg = <30000 10000>;
> +                       interrupts = <b 8>;
> +                       interrupt-parent = < &ipic >;
> +                       /* Rev. 3.0 geometry */
> +                       num-channels = <4>;
> +                       channel-fifo-len = <18>;
> +                       exec-units-mask = <000001fe>;
> +                       descriptor-types-mask = <03ab0ebf>;
> +               };
> +
> +               sdhc@2e000 {
> +                       model = "eSDHC";
> +                       compatible = "fsl,esdhc";

Drop the model property and change compatible to "fsl,mpc8377-esdhc".

> +                       reg = <2e000 1000>;
> +                       interrupts = <2a 8>;
> +                       interrupt-parent = < &ipic >;
> +               };
> +
> +               sata@18000 {
> +                       compatible = "fsl,mpc8379-sata", "fsl,pq2pro-sata";
> +                       reg = <18000 1000>;
> +                       interrupts = <2c 8>;
> +                       interrupt-parent = < &ipic >;
> +               };
> +
> +               sata@19000 {
> +                       compatible = "fsl,mpc8379-sata", "fsl,pq2pro-sata";
> +                       reg = <19000 1000>;
> +                       interrupts = <2d 8>;
> +                       interrupt-parent = < &ipic >;
> +               };
> +
> +               /* IPIC
> +                * interrupts cell = <intr #, sense>
> +                * sense values match linux IORESOURCE_IRQ_* defines:
> +                * sense == 8: Level, low assertion
> +                * sense == 2: Edge, high-to-low change
> +                */
> +               ipic: pic@700 {
> +                       compatible = "fsl,ipic";
> +                       interrupt-controller;
> +                       #address-cells = <0>;
> +                       #interrupt-cells = <2>;
> +                       reg = <700 100>;
> +               };
> +       };
> +
> +       pci0: pci@e0008500 {
> +               cell-index = <0>;
> +               interrupt-map-mask = <f800 0 0 7>;
> +               interrupt-map = <
> +
> +                               /* IDSEL 0x11 */
> +                                8800 0 0 1 &ipic 14 8
> +                                8800 0 0 2 &ipic 15 8
> +                                8800 0 0 3 &ipic 16 8
> +                                8800 0 0 4 &ipic 17 8
> +
> +                               /* IDSEL 0x12 */
> +                                9000 0 0 1 &ipic 16 8
> +                                9000 0 0 2 &ipic 17 8
> +                                9000 0 0 3 &ipic 14 8
> +                                9000 0 0 4 &ipic 15 8
> +
> +                               /* IDSEL 0x13 */
> +                                9800 0 0 1 &ipic 17 8
> +                                9800 0 0 2 &ipic 14 8
> +                                9800 0 0 3 &ipic 15 8
> +                                9800 0 0 4 &ipic 16 8
> +
> +                               /* IDSEL 0x15 */
> +                                a800 0 0 1 &ipic 14 8
> +                                a800 0 0 2 &ipic 15 8
> +                                a800 0 0 3 &ipic 16 8
> +                                a800 0 0 4 &ipic 17 8
> +
> +                               /* IDSEL 0x16 */
> +                                b000 0 0 1 &ipic 17 8
> +                                b000 0 0 2 &ipic 14 8
> +                                b000 0 0 3 &ipic 15 8
> +                                b000 0 0 4 &ipic 16 8
> +
> +                               /* IDSEL 0x17 */
> +                                b800 0 0 1 &ipic 16 8
> +                                b800 0 0 2 &ipic 17 8
> +                                b800 0 0 3 &ipic 14 8
> +                                b800 0 0 4 &ipic 15 8
> +
> +                               /* IDSEL 0x18 */
> +                                c000 0 0 1 &ipic 15 8
> +                                c000 0 0 2 &ipic 16 8
> +                                c000 0 0 3 &ipic 17 8
> +                                c000 0 0 4 &ipic 14 8>;
> +               interrupt-parent = < &ipic >;
> +               interrupts = <42 8>;
> +               bus-range = <0 0>;
> +               ranges = <02000000 0 90000000 90000000 0 10000000
> +                         42000000 0 80000000 80000000 0 10000000
> +                         01000000 0 00000000 e0300000 0 00100000>;
> +               clock-frequency = <0>;
> +               #interrupt-cells = <1>;
> +               #size-cells = <2>;
> +               #address-cells = <3>;
> +               reg = <e0008500 100>;
> +               compatible = "fsl,mpc8349-pci";
> +               device_type = "pci";
> +       };
> +};
> diff --git a/arch/powerpc/boot/dts/mpc8378_mds.dts b/arch/powerpc/boot/dts/mpc8378_mds.dts
> new file mode 100644
> index 0000000..bd9545d
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/mpc8378_mds.dts
> @@ -0,0 +1,263 @@
> +/*
> + * MPC8378E MDS Device Tree Source
> + *
> + * Copyright 2007 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +/ {
> +       model = "fsl,mpc8378emds";
> +       compatible = "fsl,mpc8378emds","fsl,mpc837xmds";

Again, board level compatibility is very difficult to claim.
fsl,mpc837xmds doesn't make much sense here.  Just make the platform
code bind on all the variants.

> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +
> +       aliases {
> +               ethernet0 = &enet0;
> +               ethernet1 = &enet1;
> +               serial0 = &serial0;
> +               serial1 = &serial1;
> +               pci0 = &pci0;
> +       };
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               PowerPC,8378@0 {
> +                       device_type = "cpu";
> +                       reg = <0>;
> +                       d-cache-line-size = <20>;
> +                       i-cache-line-size = <20>;
> +                       d-cache-size = <8000>;          // L1, 32K
> +                       i-cache-size = <8000>;          // L1, 32K
> +                       timebase-frequency = <0>;
> +                       bus-frequency = <0>;
> +                       clock-frequency = <0>;
> +               };
> +       };
> +
> +       memory {
> +               device_type = "memory";
> +               reg = <00000000 20000000>;      // 512MB at 0
> +       };
> +
> +       soc@e0000000 {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               device_type = "soc";

Drop device_type and add compatible

> +               ranges = <0 e0000000 00100000>;
> +               reg = <e0000000 00000200>;
> +               bus-frequency = <0>;
> +
> +               wdt@200 {
> +                       compatible = "mpc83xx_wdt";
> +                       reg = <200 100>;
> +               };
> +
> +               i2c@3000 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       cell-index = <0>;
> +                       compatible = "fsl-i2c";
> +                       reg = <3000 100>;
> +                       interrupts = <e 8>;
> +                       interrupt-parent = < &ipic >;
> +                       dfsrr;
> +               };
> +
> +               i2c@3100 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       cell-index = <1>;
> +                       compatible = "fsl-i2c";
> +                       reg = <3100 100>;
> +                       interrupts = <f 8>;
> +                       interrupt-parent = < &ipic >;
> +                       dfsrr;
> +               };
> +
> +               spi@7000 {
> +                       compatible = "fsl_spi";
> +                       reg = <7000 1000>;
> +                       interrupts = <10 8>;
> +                       interrupt-parent = < &ipic >;
> +                       mode = "cpu";
> +               };
> +
> +               /* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
> +               usb@23000 {
> +                       compatible = "fsl-usb2-dr";
> +                       reg = <23000 1000>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       interrupt-parent = < &ipic >;
> +                       interrupts = <26 8>;
> +                       phy_type = "utmi_wide";
> +               };
> +
> +               mdio@24520 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       compatible = "fsl,gianfar-mdio";
> +                       reg = <24520 20>;
> +                       phy2: ethernet-phy@2 {
> +                               interrupt-parent = < &ipic >;
> +                               interrupts = <11 8>;
> +                               reg = <2>;
> +                               device_type = "ethernet-phy";
> +                       };
> +                       phy3: ethernet-phy@3 {
> +                               interrupt-parent = < &ipic >;
> +                               interrupts = <12 8>;
> +                               reg = <3>;
> +                               device_type = "ethernet-phy";
> +                       };
> +               };
> +
> +               enet0: ethernet@24000 {
> +                       cell-index = <0>;
> +                       device_type = "network";
> +                       model = "eTSEC";
> +                       compatible = "gianfar";
> +                       reg = <24000 1000>;
> +                       local-mac-address = [ 00 00 00 00 00 00 ];
> +                       interrupts = <20 8 21 8 22 8>;
> +                       phy-connection-type = "mii";
> +                       interrupt-parent = < &ipic >;
> +                       phy-handle = < &phy2 >;
> +               };
> +
> +               enet1: ethernet@25000 {
> +                       cell-index = <1>;
> +                       device_type = "network";
> +                       model = "eTSEC";
> +                       compatible = "gianfar";
> +                       reg = <25000 1000>;
> +                       local-mac-address = [ 00 00 00 00 00 00 ];
> +                       interrupts = <23 8 24 8 25 8>;
> +                       phy-connection-type = "mii";
> +                       interrupt-parent = < &ipic >;
> +                       phy-handle = < &phy3 >;
> +               };
> +
> +               serial0: serial@4500 {
> +                       cell-index = <0>;
> +                       device_type = "serial";
> +                       compatible = "ns16550";
> +                       reg = <4500 100>;
> +                       clock-frequency = <0>;
> +                       interrupts = <9 8>;
> +                       interrupt-parent = < &ipic >;
> +               };
> +
> +               serial1: serial@4600 {
> +                       cell-index = <1>;
> +                       device_type = "serial";
> +                       compatible = "ns16550";
> +                       reg = <4600 100>;
> +                       clock-frequency = <0>;
> +                       interrupts = <a 8>;
> +                       interrupt-parent = < &ipic >;
> +               };
> +
> +               crypto@30000 {
> +                       model = "SEC3";
> +                       compatible = "talitos";
> +                       reg = <30000 10000>;
> +                       interrupts = <b 8>;
> +                       interrupt-parent = < &ipic >;
> +                       /* Rev. 3.0 geometry */
> +                       num-channels = <4>;
> +                       channel-fifo-len = <18>;
> +                       exec-units-mask = <000001fe>;
> +                       descriptor-types-mask = <03ab0ebf>;
> +               };
> +
> +               sdhc@2e000 {
> +                       model = "eSDHC";
> +                       compatible = "fsl,esdhc";
> +                       reg = <2e000 1000>;
> +                       interrupts = <2a 8>;
> +                       interrupt-parent = < &ipic >;
> +               };
> +
> +               /* IPIC
> +                * interrupts cell = <intr #, sense>
> +                * sense values match linux IORESOURCE_IRQ_* defines:
> +                * sense == 8: Level, low assertion
> +                * sense == 2: Edge, high-to-low change
> +                */
> +               ipic: pic@700 {
> +                       compatible = "fsl,ipic";
> +                       interrupt-controller;
> +                       #address-cells = <0>;
> +                       #interrupt-cells = <2>;
> +                       reg = <700 100>;
> +               };
> +       };
> +
> +       pci0: pci@e0008500 {
> +               cell-index = <0>;
> +               interrupt-map-mask = <f800 0 0 7>;
> +               interrupt-map = <
> +
> +                               /* IDSEL 0x11 */
> +                                8800 0 0 1 &ipic 14 8
> +                                8800 0 0 2 &ipic 15 8
> +                                8800 0 0 3 &ipic 16 8
> +                                8800 0 0 4 &ipic 17 8
> +
> +                               /* IDSEL 0x12 */
> +                                9000 0 0 1 &ipic 16 8
> +                                9000 0 0 2 &ipic 17 8
> +                                9000 0 0 3 &ipic 14 8
> +                                9000 0 0 4 &ipic 15 8
> +
> +                               /* IDSEL 0x13 */
> +                                9800 0 0 1 &ipic 17 8
> +                                9800 0 0 2 &ipic 14 8
> +                                9800 0 0 3 &ipic 15 8
> +                                9800 0 0 4 &ipic 16 8
> +
> +                               /* IDSEL 0x15 */
> +                                a800 0 0 1 &ipic 14 8
> +                                a800 0 0 2 &ipic 15 8
> +                                a800 0 0 3 &ipic 16 8
> +                                a800 0 0 4 &ipic 17 8
> +
> +                               /* IDSEL 0x16 */
> +                                b000 0 0 1 &ipic 17 8
> +                                b000 0 0 2 &ipic 14 8
> +                                b000 0 0 3 &ipic 15 8
> +                                b000 0 0 4 &ipic 16 8
> +
> +                               /* IDSEL 0x17 */
> +                                b800 0 0 1 &ipic 16 8
> +                                b800 0 0 2 &ipic 17 8
> +                                b800 0 0 3 &ipic 14 8
> +                                b800 0 0 4 &ipic 15 8
> +
> +                               /* IDSEL 0x18 */
> +                                c000 0 0 1 &ipic 15 8
> +                                c000 0 0 2 &ipic 16 8
> +                                c000 0 0 3 &ipic 17 8
> +                                c000 0 0 4 &ipic 14 8>;
> +               interrupt-parent = < &ipic >;
> +               interrupts = <42 8>;
> +               bus-range = <0 0>;
> +               ranges = <02000000 0 90000000 90000000 0 10000000
> +                         42000000 0 80000000 80000000 0 10000000
> +                         01000000 0 00000000 e0300000 0 00100000>;
> +               clock-frequency = <0>;
> +               #interrupt-cells = <1>;
> +               #size-cells = <2>;
> +               #address-cells = <3>;
> +               reg = <e0008500 100>;
> +               compatible = "fsl,mpc8349-pci";
> +               device_type = "pci";
> +       };
> +};
> diff --git a/arch/powerpc/boot/dts/mpc8379_mds.dts b/arch/powerpc/boot/dts/mpc8379_mds.dts
> new file mode 100644
> index 0000000..4d651a3
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/mpc8379_mds.dts
> @@ -0,0 +1,291 @@
> +/*
> + * MPC8379E MDS Device Tree Source
> + *
> + * Copyright 2007 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +/ {
> +       model = "fsl,mpc8379emds";
> +       compatible = "fsl,mpc8379emds","fsl,mpc837xmds";
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +
> +       aliases {
> +               ethernet0 = &enet0;
> +               ethernet1 = &enet1;
> +               serial0 = &serial0;
> +               serial1 = &serial1;
> +               pci0 = &pci0;
> +       };
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               PowerPC,8379@0 {
> +                       device_type = "cpu";
> +                       reg = <0>;
> +                       d-cache-line-size = <20>;
> +                       i-cache-line-size = <20>;
> +                       d-cache-size = <8000>;          // L1, 32K
> +                       i-cache-size = <8000>;          // L1, 32K
> +                       timebase-frequency = <0>;
> +                       bus-frequency = <0>;
> +                       clock-frequency = <0>;
> +               };
> +       };
> +
> +       memory {
> +               device_type = "memory";
> +               reg = <00000000 20000000>;      // 512MB at 0
> +       };
> +
> +       soc@e0000000 {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               device_type = "soc";
> +               ranges = <0 e0000000 00100000>;
> +               reg = <e0000000 00000200>;
> +               bus-frequency = <0>;
> +
> +               wdt@200 {
> +                       compatible = "mpc83xx_wdt";
> +                       reg = <200 100>;
> +               };
> +
> +               i2c@3000 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       cell-index = <0>;
> +                       compatible = "fsl-i2c";
> +                       reg = <3000 100>;
> +                       interrupts = <e 8>;
> +                       interrupt-parent = < &ipic >;
> +                       dfsrr;
> +               };
> +
> +               i2c@3100 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       cell-index = <1>;
> +                       compatible = "fsl-i2c";
> +                       reg = <3100 100>;
> +                       interrupts = <f 8>;
> +                       interrupt-parent = < &ipic >;
> +                       dfsrr;
> +               };
> +
> +               spi@7000 {
> +                       compatible = "fsl_spi";
> +                       reg = <7000 1000>;
> +                       interrupts = <10 8>;
> +                       interrupt-parent = < &ipic >;
> +                       mode = "cpu";
> +               };
> +
> +               /* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
> +               usb@23000 {
> +                       compatible = "fsl-usb2-dr";
> +                       reg = <23000 1000>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       interrupt-parent = < &ipic >;
> +                       interrupts = <26 8>;
> +                       phy_type = "utmi_wide";
> +               };
> +
> +               mdio@24520 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       compatible = "fsl,gianfar-mdio";
> +                       reg = <24520 20>;
> +                       phy2: ethernet-phy@2 {
> +                               interrupt-parent = < &ipic >;
> +                               interrupts = <11 8>;
> +                               reg = <2>;
> +                               device_type = "ethernet-phy";
> +                       };
> +                       phy3: ethernet-phy@3 {
> +                               interrupt-parent = < &ipic >;
> +                               interrupts = <12 8>;
> +                               reg = <3>;
> +                               device_type = "ethernet-phy";
> +                       };
> +               };
> +
> +               enet0: ethernet@24000 {
> +                       cell-index = <0>;
> +                       device_type = "network";
> +                       model = "eTSEC";
> +                       compatible = "gianfar";
> +                       reg = <24000 1000>;
> +                       local-mac-address = [ 00 00 00 00 00 00 ];
> +                       interrupts = <20 8 21 8 22 8>;
> +                       phy-connection-type = "mii";
> +                       interrupt-parent = < &ipic >;
> +                       phy-handle = < &phy2 >;
> +               };
> +
> +               enet1: ethernet@25000 {
> +                       cell-index = <1>;
> +                       device_type = "network";
> +                       model = "eTSEC";
> +                       compatible = "gianfar";
> +                       reg = <25000 1000>;
> +                       local-mac-address = [ 00 00 00 00 00 00 ];
> +                       interrupts = <23 8 24 8 25 8>;
> +                       phy-connection-type = "mii";
> +                       interrupt-parent = < &ipic >;
> +                       phy-handle = < &phy3 >;
> +               };
> +
> +               serial0: serial@4500 {
> +                       cell-index = <0>;
> +                       device_type = "serial";
> +                       compatible = "ns16550";
> +                       reg = <4500 100>;
> +                       clock-frequency = <0>;
> +                       interrupts = <9 8>;
> +                       interrupt-parent = < &ipic >;
> +               };
> +
> +               serial1: serial@4600 {
> +                       cell-index = <1>;
> +                       device_type = "serial";
> +                       compatible = "ns16550";
> +                       reg = <4600 100>;
> +                       clock-frequency = <0>;
> +                       interrupts = <a 8>;
> +                       interrupt-parent = < &ipic >;
> +               };
> +
> +               crypto@30000 {
> +                       model = "SEC3";
> +                       compatible = "talitos";
> +                       reg = <30000 10000>;
> +                       interrupts = <b 8>;
> +                       interrupt-parent = < &ipic >;
> +                       /* Rev. 3.0 geometry */
> +                       num-channels = <4>;
> +                       channel-fifo-len = <18>;
> +                       exec-units-mask = <000001fe>;
> +                       descriptor-types-mask = <03ab0ebf>;
> +               };
> +
> +               sdhc@2e000 {
> +                       model = "eSDHC";
> +                       compatible = "fsl,esdhc";
> +                       reg = <2e000 1000>;
> +                       interrupts = <2a 8>;
> +                       interrupt-parent = < &ipic >;
> +               };
> +
> +               sata@18000 {
> +                       compatible = "fsl,mpc8379-sata", "fsl,pq2pro-sata";
> +                       reg = <18000 1000>;
> +                       interrupts = <2c 8>;
> +                       interrupt-parent = < &ipic >;
> +               };
> +
> +               sata@19000 {
> +                       compatible = "fsl,mpc8379-sata", "fsl,pq2pro-sata";
> +                       reg = <19000 1000>;
> +                       interrupts = <2d 8>;
> +                       interrupt-parent = < &ipic >;
> +               };
> +
> +               sata@1a000 {
> +                       compatible = "fsl,mpc8379-sata", "fsl,pq2pro-sata";
> +                       reg = <1a000 1000>;
> +                       interrupts = <2e 8>;
> +                       interrupt-parent = < &ipic >;
> +               };
> +
> +               sata@1b000 {
> +                       compatible = "fsl,mpc8379-sata", "fsl,pq2pro-sata";
> +                       reg = <1b000 1000>;
> +                       interrupts = <2f 8>;
> +                       interrupt-parent = < &ipic >;
> +               };
> +
> +               /* IPIC
> +                * interrupts cell = <intr #, sense>
> +                * sense values match linux IORESOURCE_IRQ_* defines:
> +                * sense == 8: Level, low assertion
> +                * sense == 2: Edge, high-to-low change
> +                */
> +               ipic: pic@700 {
> +                       compatible = "fsl,ipic";
> +                       interrupt-controller;
> +                       #address-cells = <0>;
> +                       #interrupt-cells = <2>;
> +                       reg = <700 100>;
> +               };
> +       };
> +
> +       pci0: pci@e0008500 {
> +               cell-index = <0>;
> +               interrupt-map-mask = <f800 0 0 7>;
> +               interrupt-map = <
> +
> +                               /* IDSEL 0x11 */
> +                                8800 0 0 1 &ipic 14 8
> +                                8800 0 0 2 &ipic 15 8
> +                                8800 0 0 3 &ipic 16 8
> +                                8800 0 0 4 &ipic 17 8
> +
> +                               /* IDSEL 0x12 */
> +                                9000 0 0 1 &ipic 16 8
> +                                9000 0 0 2 &ipic 17 8
> +                                9000 0 0 3 &ipic 14 8
> +                                9000 0 0 4 &ipic 15 8
> +
> +                               /* IDSEL 0x13 */
> +                                9800 0 0 1 &ipic 17 8
> +                                9800 0 0 2 &ipic 14 8
> +                                9800 0 0 3 &ipic 15 8
> +                                9800 0 0 4 &ipic 16 8
> +
> +                               /* IDSEL 0x15 */
> +                                a800 0 0 1 &ipic 14 8
> +                                a800 0 0 2 &ipic 15 8
> +                                a800 0 0 3 &ipic 16 8
> +                                a800 0 0 4 &ipic 17 8
> +
> +                               /* IDSEL 0x16 */
> +                                b000 0 0 1 &ipic 17 8
> +                                b000 0 0 2 &ipic 14 8
> +                                b000 0 0 3 &ipic 15 8
> +                                b000 0 0 4 &ipic 16 8
> +
> +                               /* IDSEL 0x17 */
> +                                b800 0 0 1 &ipic 16 8
> +                                b800 0 0 2 &ipic 17 8
> +                                b800 0 0 3 &ipic 14 8
> +                                b800 0 0 4 &ipic 15 8
> +
> +                               /* IDSEL 0x18 */
> +                                c000 0 0 1 &ipic 15 8
> +                                c000 0 0 2 &ipic 16 8
> +                                c000 0 0 3 &ipic 17 8
> +                                c000 0 0 4 &ipic 14 8>;
> +               interrupt-parent = < &ipic >;
> +               interrupts = <42 8>;
> +               bus-range = <0 0>;
> +               ranges = <02000000 0 90000000 90000000 0 10000000
> +                         42000000 0 80000000 80000000 0 10000000
> +                         01000000 0 00000000 e0300000 0 00100000>;
> +               clock-frequency = <0>;
> +               #interrupt-cells = <1>;
> +               #size-cells = <2>;
> +               #address-cells = <3>;
> +               reg = <e0008500 100>;
> +               compatible = "fsl,mpc8349-pci";
> +               device_type = "pci";
> +       };
> +};
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
