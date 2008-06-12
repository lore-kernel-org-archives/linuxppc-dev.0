Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id D1E97DDF5F
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 00:10:48 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so410900yxg.39
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 07:10:47 -0700 (PDT)
Message-ID: <fa686aa40806120710g67761ectfee1e3f0916b0eb@mail.gmail.com>
Date: Thu, 12 Jun 2008 08:10:47 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David Jander" <david.jander@protonic.nl>
Subject: Re: [PATCH 1/2] Added support for PRTLVT based boards (MPC5121)
In-Reply-To: <200806121344.26883.david.jander@protonic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200806121344.26883.david.jander@protonic.nl>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Looking even better.  Just a few more comments.  I'll probably be able
to pick up the next one for inclusion in 2.6.27.

On Thu, Jun 12, 2008 at 5:44 AM, David Jander <david.jander@protonic.nl> wrote:
>  Made MPC5121_ADS board support generic:
>  Renamed arch/powerpc/platforms/512x/mpc5121_ads.c and added list of supported
>  boards.
>  For both MPC5121 ADS or PRTLVT support, just select "MPC5121_GENERIC" and use
>  the corresponding device-tree.
>
> Signed-off-by: David Jander <david@protonic.nl>
> ---
>  arch/powerpc/boot/dts/prtlvt.dts                   |  272 ++++++++++++++++++++
>  arch/powerpc/platforms/512x/Kconfig                |   14 +-
>  arch/powerpc/platforms/512x/Makefile               |    2 +-
>  .../512x/{mpc5121_ads.c => mpc5121_generic.c}      |   38 ++-
>  4 files changed, 307 insertions(+), 19 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/prtlvt.dts
>  rename arch/powerpc/platforms/512x/{mpc5121_ads.c => mpc5121_generic.c} (73%)
>
> diff --git a/arch/powerpc/boot/dts/prtlvt.dts b/arch/powerpc/boot/dts/prtlvt.dts
> new file mode 100644
> index 0000000..a011c8c
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/prtlvt.dts
> @@ -0,0 +1,272 @@
> +/*
> + * Device tree source for PRTLVT based boards, base on:
> + * MPC5121E MDS Device Tree Source
> + *
> + * Copyright 2007 Freescale Semiconductor Inc.
> + * Copyright 2008 Protonic Holland
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
> +       compatible = "prt,prtlvt";
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
> +       flash@fe000000 {

There should probably be a node to describe the local bus that the
flash is attached to and this flash node should be a child of the bus.

> +               compatible = "amd,s29gl256n", "cfi-flash";
> +               reg = <0xfe000000 0x02000000>;
> +               bank-width = <2>;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               rootfs@0 {
> +                       label = "rootfs";
> +                       reg = <0x00000000 0x01800000>;
> +               };
> +               config@1800000 {
> +                       label ="config0";
> +                       reg = <0x01800000 0x00200000>;
> +               };
> +               config@1a00000 {
> +                       label ="config1";
> +                       reg = <0x01a00000 0x00200000>;
> +               };
> +               kernel@1c00000 {
> +                       label ="kernel";
> +                       reg = <0x01c00000 0x002e0000>;
> +               };
> +               dt@1ee0000 {
> +                       label ="devicetree";
> +                       reg = <0x01ee0000 0x00020000>;
> +               };
> +               uboot@1ee0000 {
> +                       label ="uboot";
> +                       reg = <0x01f00000 0x00100000>;
> +               };
> +       };

I'm still not all that keen on encoding the partition information into
the 'stock' device tree included with the kernel as it is more of a
configuration description that is more properly supplied by the
bootloader.  This is a debate that has been going back and forth over
the last few months, so there isn't a solid concensus yet, but my
preference is to remove or comment out the partition information for
now.

> +               i2ccontrol@1760 {
> +                       compatible = "fsl,mpc5121-i2c-ctrl";
> +                       reg = <0x1760 0x8>;
> +               };
> +
> +               diu@2100 {

(nitpick) There is a recommended practice that says node names should
be generic as much as possible, so I think this should probably be
video@2100.  The compatible value is fine.

> +               ethernet@2800 {
> +                       compatible = "fsl,mpc5121-fec";
> +                       reg = <0x2800 0x800>;
> +                       local-mac-address = [ 00 00 00 00 00 00 ];
> +                       interrupts = <0x4 0x8 >;
> +                       interrupt-parent = < &ipic >;
> +                       phy-handle = < &phy >;
> +               };
> +
> +               // This dma controller is not compatible with fsldma
> +               dma2@14000 {

Also for generic names; 'dma@14000' makes more sense than 'dma2@14000'.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
