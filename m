Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 7EFA7DDFEF
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 04:25:39 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1624944anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 08 Jan 2008 09:25:39 -0800 (PST)
Message-ID: <fa686aa40801080925t47eb08fbyb2497424a1c1fa73@mail.gmail.com>
Date: Tue, 8 Jan 2008 10:25:38 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Rigby" <jrigby@freescale.com>
Subject: Re: [PATCH 4/7] Device tree for MPC5121 ADS
In-Reply-To: <1199808093-15929-5-git-send-email-jrigby@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1199808093-15929-1-git-send-email-jrigby@freescale.com>
	<1199808093-15929-2-git-send-email-jrigby@freescale.com>
	<1199808093-15929-3-git-send-email-jrigby@freescale.com>
	<1199808093-15929-4-git-send-email-jrigby@freescale.com>
	<1199808093-15929-5-git-send-email-jrigby@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Comments below.

On 1/8/08, John Rigby <jrigby@freescale.com> wrote:
> Bare minimum tree containing only
> what is currently supported.
>
> Signed-off-by: John Rigby <jrigby@freescale.com>
> ---
>  arch/powerpc/boot/dts/mpc5121ads.dts |  102 ++++++++++++++++++++++++++++++++++
>  1 files changed, 102 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/mpc5121ads.dts
>
> diff --git a/arch/powerpc/boot/dts/mpc5121ads.dts b/arch/powerpc/boot/dts/mpc5121ads.dts
> new file mode 100644
> index 0000000..26471ff
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/mpc5121ads.dts
> @@ -0,0 +1,102 @@
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
> +       compatible = "MPC5121ADS";

"fsl, mpc5121ads" (drop the caps and use the fsl, prefix)

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
> +                       ref-frequency = <3ef1480>;      // 66MHz ref clock
> +                       timebase-frequency = <2f34f60>; // 49.5MHz (396MHz/8) makes time tick correctly
> +                       bus-frequency = <bcd3d80>;      // 198MHz csb bus
> +                       clock-frequency = <179a7b00>;   // 396MHz ppc core ??
> +                       32-bit;
> +               };
> +       };
> +
> +       memory {
> +               device_type = "memory";
> +               reg = <00000000 10000000>;      // 256MB at 0
> +       };
> +
> +       cpld@82000000 {
> +               device_type = "board-control";
> +               reg = <82000000 8000>;
> +       };
> +
> +       soc5121@80000000 {

soc@80000000

"soc<cpu>@<addr>" is no longer recommended.

> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               #interrupt-cells = <2>;
> +               device_type = "soc";

- Drop device_type property
- add: compatible = "fsl,mpc5121-immr";

> +               ranges = <0 80000000 400000>;
> +               reg = <80000000 400000>;
> +               ref-frequency = <3ef1480>;      // 66MHz ref
> +               bus-frequency = <5e69ec0>;      // 99MHz ips ref
> +
> +               // IPIC
> +               // interrupts cell = <intr #, sense>
> +               // sense values match linux IORESOURCE_IRQ_* defines:
> +               // sense == 8: Level, low assertion
> +               // sense == 2: Edge, high-to-low change
> +               //
> +               ipic: pic@c00 {
> +                       interrupt-controller;
> +                       #address-cells = <0>;
> +                       #interrupt-cells = <2>;
> +                       reg = <c00 100>;
> +                       built-in;
> +                       device_type = "ipic";
> +               };
> +
> +               // 512x PSCs are not 52xx PSCs compatible
> +               // PSC3 serial port A aka ttyPSC0
> +               serial@11300 {
> +                       device_type = "serial";
> +                       compatible = "mpc512x-psc-uart";

Specify the *exact* version in compatible first.  You can add generic
forms after that if you like, but the first entry should always be
exact (as per the generic names recommended practice).  It should be:
compatible = "fsl,mpc5121-psc-uart".

Also, make sure all compatible properties have the 'fsl,' prefix.

> +                       port-number = <0>;  // Logical port assignment
> +                       cell-index = <3>;
> +                       reg = <11300 100>;
> +                       interrupts = <28 8>; // actually the fifo irq
> +                       interrupt-parent = < &ipic >;
> +               };
> +
> +               // PSC4 serial port B aka ttyPSC1
> +               serial@11400 {
> +                       device_type = "serial";
> +                       compatible = "mpc512x-psc-uart";
> +                       port-number = <1>;  // Logical port assignment

Drop port-number.  Aliases will be used instead.

> +                       cell-index = <4>;
> +                       reg = <11400 100>;
> +                       interrupts = <28 8>; // actually the fifo irq
> +                       interrupt-parent = < &ipic >;
> +               };
> +
> +               pscsfifo@11f00 {
> +                       compatible = "mpc512x-pscsfifo";
> +                       reg = <11f00 100>;
> +                       interrupts = <28 8>;
> +                       interrupt-parent = < &ipic >;
> +               };
> +       };
> +};
> --
> 1.5.3.5.726.g41a7a
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
