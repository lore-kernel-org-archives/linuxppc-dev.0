Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id EA9CCDDE2D
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 04:58:39 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so166863anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 09:58:38 -0800 (PST)
Message-ID: <fa686aa40801170930h21c16e4fy26f10f8409084539@mail.gmail.com>
Date: Thu, 17 Jan 2008 10:30:19 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Rigby" <jrigby@freescale.com>
Subject: Re: [Add mpc5121 support PATCH v2 4/8] Device tree for MPC5121 ADS
In-Reply-To: <1200519447-25555-4-git-send-email-jrigby@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1200519447-25555-1-git-send-email-jrigby@freescale.com>
	<1200519447-25555-2-git-send-email-jrigby@freescale.com>
	<1200519447-25555-3-git-send-email-jrigby@freescale.com>
	<1200519447-25555-4-git-send-email-jrigby@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/16/08, John Rigby <jrigby@freescale.com> wrote:
> Minimal tree for mpc5121 ads.
>
> Signed-off-by: John Rigby <jrigby@freescale.com>
> ---
>  arch/powerpc/boot/dts/mpc5121ads.dts |  116 ++++++++++++++++++++++++++++++++++
>  1 files changed, 116 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/mpc5121ads.dts
>
> diff --git a/arch/powerpc/boot/dts/mpc5121ads.dts b/arch/powerpc/boot/dts/mpc5121ads.dts
> new file mode 100644
> index 0000000..fac1f15
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/mpc5121ads.dts
> @@ -0,0 +1,116 @@
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
> +/ {
> +       model = "MPC5121ADS";

Model should also use the form "fsl,mpc5121ads".  I think lowercase is
also preferred.

> +       compatible = "fsl,mpc5121ads";
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
> +                       d-cache-line-size = <20>;       // 32 bytes
> +                       i-cache-line-size = <20>;       // 32 bytes
> +                       d-cache-size = <8000>;          // L1, 32K
> +                       i-cache-size = <8000>;          // L1, 32K
> +                       timebase-frequency = <d#49500000>; // 49.5 MHz (csb/4)
> +                       bus-frequency = <d#198000000>;  // 198 MHz csb bus
> +                       clock-frequency = <d#396000000>;// 396 MHz ppc core
> +               };
> +       };
> +
> +       memory {
> +               device_type = "memory";
> +               reg = <00000000 10000000>;      // 256MB at 0
> +       };
> +
> +       localbus@80000020 {
> +               compatible = "fsl,mpc5121ads_localbus";

fsl,mpc5121ads-localbus (use dash instead of underscore)

> +               #address-cells = <2>;
> +               #size-cells = <1>;
> +               reg = <80000020 40>;
> +
> +               ranges = <0 0 fc000000 04000000
> +                         2 0 82000000 00008000>;
> +
> +               flash@0,0 {
> +                       compatible = "cfi-flash";
> +                       reg = <0 0 4000000>;
> +                       bank-width = <4>;
> +                       device-width = <1>;
> +               };
> +
> +               board-control@2,0 {
> +                       compatible = "fsl,mpc5121ads-cpld";
> +                       reg = <2 0 8000>;
> +               };
> +       };
> +
> +       soc@80000000 {
> +               compatible = "fsl,mpc5121-immr";
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               #interrupt-cells = <2>;
> +               ranges = <0 80000000 400000>;
> +               reg = <80000000 400000>;
> +               bus-frequency = <d#66000000>;   // 66 MHz ips bus
> +
> +
> +               // IPIC
> +               // interrupts cell = <intr #, sense>
> +               // sense values match linux IORESOURCE_IRQ_* defines:
> +               // sense == 8: Level, low assertion
> +               // sense == 2: Edge, high-to-low change
> +               //
> +               ipic: interrupt-controller@c00 {
> +                       compatible = "fsl,ipic";

for completeness: compatible = "fsl,mpc5121-ipic", "fsl,ipic";

> +                       interrupt-controller;
> +                       #address-cells = <0>;
> +                       #interrupt-cells = <2>;
> +                       reg = <c00 100>;
> +               };
> +
> +               // 512x PSCs are not 52xx PSCs compatible
> +               // PSC3 serial port A aka ttyPSC0
> +               serial@11300 {
> +                       device_type = "serial";
> +                       compatible = "fsl,mpc5121-psc-uart";
> +                       port-number = <0>;  // Logical port assignment

This should be going away in short order.  I hope to have some code
written soon which will use aliases for assigning the port number.

> +                       cell-index = <3>;
> +                       reg = <11300 100>;
> +                       interrupts = <28 8>; // actually the fifo irq

Hmmm, interesting.  Perhaps it would be better to leave the interrupts
property out of this node and have a fsl,fifo-handle property pointing
to the fifo node.

> +                       interrupt-parent = < &ipic >;
> +               };
> +
> +               // PSC4 serial port B aka ttyPSC1
> +               serial@11400 {
> +                       device_type = "serial";
> +                       compatible = "fsl,mpc5121-psc-uart";
> +                       port-number = <1>;  // Logical port assignment
> +                       cell-index = <4>;
> +                       reg = <11400 100>;
> +                       interrupts = <28 8>; // actually the fifo irq
> +                       interrupt-parent = < &ipic >;
> +               };
> +
> +               pscsfifo@11f00 {
> +                       compatible = "fsl,mpc512x-psc-fifo";

fsl,mpc5121-psc-fifo.  mpc512x isn't real, it's a made up wildcard.
It's better to be specific.

> +                       reg = <11f00 100>;
> +                       interrupts = <28 8>;
> +                       interrupt-parent = < &ipic >;
> +               };
> +       };
> +};
> --

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
