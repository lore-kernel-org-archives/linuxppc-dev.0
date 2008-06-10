Return-Path: <glikely@secretlab.ca>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.242])
	by ozlabs.org (Postfix) with ESMTP id 5169DDE244
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 06:37:21 +1000 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so1070349hsz.9
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 13:37:19 -0700 (PDT)
Message-ID: <fa686aa40806101337k45fc0b1bm95a6dc49541bcd66@mail.gmail.com>
Date: Tue, 10 Jun 2008 14:37:18 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David Jander" <david@protonic.nl>
Subject: Re: [PATCH] prtlvt board support (MPC5121e) added
In-Reply-To: <200806101842.36755.david@protonic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200806101842.36755.david@protonic.nl>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks for the patch, comments below.

BTW, When sending to the mailing list, please don't use bcc: or hide
the recipients.

Cheers,
g.

On Tue, Jun 10, 2008 at 10:29 AM, David Jander <david@protonic.nl> wrote:
> Signed-off-by: David Jander <david@protonic.nl>
> ---
>  arch/powerpc/boot/dts/prtlvt.dts     |  280 ++++++++++++++++++++++++++++++++++
>  arch/powerpc/platforms/512x/Kconfig  |    9 +
>  arch/powerpc/platforms/512x/Makefile |    1 +
>  arch/powerpc/platforms/512x/prtlvt.c |  105 +++++++++++++
>  4 files changed, 395 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/prtlvt.dts
>  create mode 100644 arch/powerpc/platforms/512x/prtlvt.c
>
> diff --git a/arch/powerpc/boot/dts/prtlvt.dts b/arch/powerpc/boot/dts/prtlvt.dts
> new file mode 100644
> index 0000000..238dc89
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/prtlvt.dts
> @@ -0,0 +1,280 @@
> +/*
> + * MPC5121E MDS Device Tree Source
> + *
> + * Copyright 2007 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> + /* compile with: ./dtc -p 10240 -R 20 -I dts -o prtlvt.dtb -O dtb -b 0 dts/prtlvt.dts */
> +
> +/dts-v1/;
> +
> +/ {
> +       model = "prtlvt";
> +       compatible = "fsl,prtlvt";

Not true.  This board is not manufactured by Freescale, so you should
not use the 'fsl,' prefix.  Use your companies name or stock ticker
symbol instead.

> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               PowerPC,5121@0 {
> +                       device_type = "cpu";
> +                       reg = <0>;
> +                       d-cache-line-size = <0x20>;     // 32 bytes
> +                       i-cache-line-size = <0x20>;     // 32 bytes
> +                       d-cache-size = <0x8000>;        // L1, 32K
> +                       i-cache-size = <0x8000>;        // L1, 32K
> +                       timebase-frequency = <50000000>;// 50 MHz (csb/4)
> +                       bus-frequency = <200000000>;    // 200 MHz csb bus
> +                       clock-frequency = <400000000>;  // 400 MHz ppc core
> +               };
> +       };
> +
> +       memory {
> +               device_type = "memory";
> +               reg = <0x00000000 0x10000000>;  // 256MB at 0
> +       };
> +
> +       localbus@80000020 {
> +               compatible = "fsl,prtlvt-localbus";

This doesn't look right.  The local bus is not board specific; it is
SoC specific.  So this should be:

compatible = "fsl,mpc5121-localbus", "simple-bus";

> +               #address-cells = <2>;
> +               #size-cells = <1>;
> +               reg = <0x80000020 0x40>;
> +
> +               ranges = <0x0 0x0 0xfe000000 0x02000000>;
> +
> +               flash@0,0 {
> +                       compatible = "cfi-flash";
> +                       reg = <0 0x0 0x4000000>;
> +                       bank-width = <4>;
> +                       device-width = <1>;
> +               };
> +       };
> +
> +       soc@80000000 {
> +               compatible = "fsl,mpc5121-immr";
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               #interrupt-cells = <2>;
> +               ranges = <0x0 0x80000000 0x400000>;
> +               reg = <0x80000000 0x400000>;
> +               bus-frequency = <66000000>;     // 66 MHz ips bus
> +
> +
> +               // IPIC
> +               // interrupts cell = <intr #, sense>
> +               // sense values match linux IORESOURCE_IRQ_* defines:
> +               // sense == 8: Level, low assertion
> +               // sense == 2: Edge, high-to-low change
> +               //
> +               ipic: interrupt-controller@c00 {
> +                       compatible = "fsl,mpc5121-ipic", "fsl,ipic";
> +                       interrupt-controller;
> +                       #address-cells = <0>;
> +                       #interrupt-cells = <2>;
> +                       reg = <0xc00 0x100>;
> +               };
> +
> +               // 512x PSCs are not 52xx PSCs compatible
> +               // PSC0 serial port A aka ttyPSC0
> +               serial@11000 {
> +                       device_type = "serial";
> +                       compatible = "fsl,mpc5121-psc-uart";
> +                       // Logical port assignment needed until driver
> +                       // learns to use aliases
> +                       port-number = <0>;
> +                       cell-index = <0>;
> +                       reg = <0x11000 0x100>;
> +                       interrupts = <0x28 0x8>; // actually the fifo irq
> +                       interrupt-parent = < &ipic >;
> +               };
> +
> +               // PSC1 serial port A aka ttyPSC1
> +               serial@11100 {
> +                       device_type = "serial";
> +                       compatible = "fsl,mpc5121-psc-uart";
> +                       // Logical port assignment needed until driver
> +                       // learns to use aliases
> +                       port-number = <1>;
> +                       cell-index = <1>;
> +                       reg = <0x11100 0x100>;
> +                       interrupts = <0x28 0x8>; // actually the fifo irq
> +                       interrupt-parent = < &ipic >;
> +               };
> +
> +               // PSC2 serial port A aka ttyPSC2
> +               serial@11200 {
> +                       device_type = "serial";
> +                       compatible = "fsl,mpc5121-psc-uart";
> +                       // Logical port assignment needed until driver
> +                       // learns to use aliases
> +                       port-number = <2>;
> +                       cell-index = <2>;
> +                       reg = <0x11200 0x100>;
> +                       interrupts = <0x28 0x8>; // actually the fifo irq
> +                       interrupt-parent = < &ipic >;
> +               };
> +
> +               // PSC3 serial port A aka ttyPSC3
> +               serial@11300 {
> +                       device_type = "serial";
> +                       compatible = "fsl,mpc5121-psc-uart";
> +                       // Logical port assignment needed until driver
> +                       // learns to use aliases
> +                       port-number = <3>;
> +                       cell-index = <3>;
> +                       reg = <0x11300 0x100>;
> +                       interrupts = <0x28 0x8>; // actually the fifo irq
> +                       interrupt-parent = < &ipic >;
> +               };
> +
> +               pscsfifo@11f00 {
> +                       compatible = "fsl,mpc5121-psc-fifo";
> +                       reg = <0x11f00 0x100>;
> +                       interrupts = <0x28 0x8>;
> +                       interrupt-parent = < &ipic >;
> +               };
> +
> +               i2c@1700 {
> +                       device_type = "i2c";

Drop this device_type property

> +                       compatible = "fsl-i2c";

should be: compatible = "fsl,mpc5121-i2c", "fsl-i2c";

> +                       reg = <0x1700 0x20>;
> +                       interrupts = <0x9 0x8>;
> +                       interrupt-parent = < &ipic >;
> +                       fsl5200-clocking;
> +               };
> +
> +               i2c@1720 {
> +                       device_type = "i2c";
> +                       compatible = "fsl-i2c";

Ditto

> +                       reg = <0x1720 0x20>;
> +                       interrupts = <0xa 0x8>;
> +                       interrupt-parent = < &ipic >;
> +                       fsl5200-clocking;
> +               };
> +
> +               i2c@1740 {
> +                       device_type = "i2c";
> +                       compatible = "fsl-i2c";

Ditto

> +                       reg = <0x1740 0x20>;
> +                       interrupts = <0xb 0x8>;
> +                       interrupt-parent = < &ipic >;
> +                       fsl5200-clocking;
> +               };
> +
> +               i2ccontrol@1760 {
> +                       compatible = "fsl-512x-i2c-ctrl";

This doesn't look right.  Correct format is: compatible = "fsl,5121-i2c-ctrl";

> +                       reg = <0x1760 0x8>;
> +               };
> +
> +               //axe@2000 {
> +               //      compatible = "mpc512x-axe";
> +               //      reg = <2000 100>;
> +               //      interrupts = <2a 8>;
> +               //      interrupt-parent = < &ipic >;
> +               //};
> +
> +               diu@2100 {
> +                       compatible = "fsl-diu";

This doesn't look right either, "fsl-diu" is the wrong format, but you
many not be able to do anything about that.  At the very least, this
one should be: compatible = "fsl,mpc5121-diu", "fsl-diu";

> +                       reg = <0x2100 0x100>;
> +                       interrupts = <0x40 0x8>;
> +                       interrupt-parent = < &ipic >;
> +                       clk-name = "diu_clk";
> +                       clk-parent = "ips_clk";
> +                       clk-ctrl = <0x1 0x1f>; // sccr2 bit 31
> +               };
> +
> +               mdio@2800 {
> +                       device_type = "mdio";
> +                       compatible = "fsl,mpc5121-fec-mdio";
> +                       reg = <0x2800 0x800>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       phy: ethernet-phy@0 {
> +                               reg = <1>;
> +                               device_type = "ethernet-phy";
> +                       };
> +               };
> +
> +               ethernet@2800 {
> +                       device_type = "network";
> +                       compatible = "fsl,mpc5121-fec";
> +                       reg = <0x2800 0x800>;
> +                       local-mac-address = [ 00 00 00 00 00 00 ];
> +                       interrupts = <0x4 0x8 >;
> +                       interrupt-parent = < &ipic >;
> +                       phy-handle = < &phy >;
> +               };
> +
> +               // 5121e has two dr usb modules
> +               // mpc5121_ads only uses port0

This comment is obviously irrelevant

> +
> +               // port1 using extern ULPI PHY
> +               usb@3000 {
> +                       device_type = "usb";
> +                       compatible = "fsl-usb2-dr";

Again, need the mpc5121 specific value before the common one.

> +                       reg = <0x3000 0x1000>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       interrupt-parent = < &ipic >;
> +                       interrupts = <0x2c 0x8>;
> +                       dr_mode = "otg";
> +                       phy_type = "ulpi";
> +                       port1;
> +               };
> +
> +               // port0 using internal UTMI PHY
> +               usb@4000 {
> +                       device_type = "usb";
> +                       compatible = "fsl-usb2-dr";

Ditto

> +                       reg = <0x4000 0x1000>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       interrupt-parent = < &ipic >;
> +                       interrupts = <0x2b 0x8>;
> +                       dr_mode = "otg";
> +                       phy_type = "utmi";
> +                       port0;
> +               };
> +
> +               // PSC4 in SPI mode (eg ADS touchscreen interface)
> +               //spi@11400 {
> +               //      device_type = "spi";
> +               //      compatible = "mpc512x-psc-spi";
> +               //      cell-index = <4>;
> +               //      reg = <11400 100>;
> +               //      interrupts = <20 8>;
> +               //      interrupt-parent = < &ipic >;
> +               //};

If it is not being used, then I would drop this node entirely (but
that is personal preference).  If you keep it, fix the compatible
value.

> +
> +               // PSC5 in ac97 mode
> +               // ac97@11500 {
> +               //      device_type = "sound";
> +               //      compatible = "mpc512x-psc-ac97";
> +               //      cell-index = <5>;
> +               //      reg = <11500 100>;
> +               //      interrupts = <21 8>;    // FIXME
> +               //      interrupt-parent = < &ipic >;
> +               //};

Ditto

> +
> +               dma2@14000 {
> +                       compatible = "mpc512x-dma2";

Fix compatible

> +                       reg = <0x14000 0x1800>;
> +                       interrupts = <0x41 0x8>;
> +                       interrupt-parent = < &ipic >;
> +               };
> +
> +               sata@20000 {
> +                       compatible = "mpc512x-sata";

Fix compatible

> +                       reg = <0x20000 0x2000>;
> +                       interrupts = <0x2d 0x8 0x56 0x8>;
> +                       interrupt-parent = < &ipic >;
> +               };
> +       };
> +};
> diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms/512x/Kconfig
> index 4c0da0c..d8c72d6 100644
> --- a/arch/powerpc/platforms/512x/Kconfig
> +++ b/arch/powerpc/platforms/512x/Kconfig
> @@ -17,3 +17,12 @@ config MPC5121_ADS
>        help
>          This option enables support for the MPC5121E ADS board.
>        default n
> +
> +config PRTLVT
> +       bool "Protonic LVT family of MPC5121 based boards"
> +       depends on PPC_MULTIPLATFORM && PPC32
> +       select DEFAULT_UIMAGE
> +       select PPC_MPC5121
> +       help
> +         This option enables support for the Protonic LVT family (ZANMCU and VICVT2).
> +       default n
> diff --git a/arch/powerpc/platforms/512x/Makefile b/arch/powerpc/platforms/512x/Makefile
> index 232c89f..d0fe46e 100644
> --- a/arch/powerpc/platforms/512x/Makefile
> +++ b/arch/powerpc/platforms/512x/Makefile
> @@ -2,3 +2,4 @@
>  # Makefile for the Freescale PowerPC 512x linux kernel.
>  #
>  obj-$(CONFIG_MPC5121_ADS)      += mpc5121_ads.o
> +obj-$(CONFIG_PRTLVT)           += prtlvt.o
> diff --git a/arch/powerpc/platforms/512x/prtlvt.c b/arch/powerpc/platforms/512x/prtlvt.c
> new file mode 100644
> index 0000000..225636b
> --- /dev/null
> +++ b/arch/powerpc/platforms/512x/prtlvt.c

Looks like you've just duplicated mpc5121_ads.c.  You should just add
your boards name to the mpc5121_ads_probe function.  Bonus points if
you rename the .c file to something more generic.  You only need a new
board file if your board needs something special.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
