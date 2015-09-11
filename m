Return-Path: <afleming@gmail.com>
Received: from mail-ig0-x231.google.com (mail-ig0-x231.google.com
 [IPv6:2607:f8b0:4001:c05::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6A4151A2B14
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2015 11:51:37 +1000 (AEST)
Received: by igbkq10 with SMTP id kq10so31008327igb.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2015 18:51:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1441217278-21618-1-git-send-email-afleming@gmail.com>
References: <1441175814-14940-1-git-send-email-afleming@gmail.com>
 <1441217278-21618-1-git-send-email-afleming@gmail.com>
Date: Thu, 10 Sep 2015 20:51:34 -0500
Message-ID: <CAKWjMd45zYZefWWxsdOO2BE2CYOTpdbXzXz6caN9Sr8XUF6PgA@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/85xx: Add support for Varisys Cyrus board
From: Andy Fleming <afleming@gmail.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: Scott Wood <scottwood@freescale.com>,
 Kumar Gala <galak@kernel.crashing.org>, Alex Perez <aperez@alexperez.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ping? I'd love if this could go in for 4.3

On Wed, Sep 2, 2015 at 1:07 PM, Andy Fleming <afleming@gmail.com> wrote:
> This board uses a P5020 chip, and boots just fine using
> the corenet_generic code. The device tree is very similar to the
> P5020DS, except that there is no Flash memory. The environment is,
> instead, stored on an MMC card on the motherboard.
>
> Signed-off-by: Andy Fleming <afleming@gmail.com>
> ---
> v2: Moved dts to cyrus_p5020.dts so we can add a p5040 version later
>     Corrected the model/compatible to varisys,CYRUS
>
>  arch/powerpc/boot/dts/cyrus_p5020.dts         | 155 ++++++++++++++++++++++++++
>  arch/powerpc/platforms/85xx/corenet_generic.c |   1 +
>  2 files changed, 156 insertions(+)
>  create mode 100644 arch/powerpc/boot/dts/cyrus_p5020.dts
>
> diff --git a/arch/powerpc/boot/dts/cyrus_p5020.dts b/arch/powerpc/boot/dts/cyrus_p5020.dts
> new file mode 100644
> index 0000000..493c6d6
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/cyrus_p5020.dts
> @@ -0,0 +1,155 @@
> +/*
> + * Cyrus 5020 Device Tree Source, based on p5020ds.dts
> + *
> + * Copyright 2015 Andy Fleming
> + *
> + * p5020ds.dts copyright:
> + * Copyright 2010 - 2014 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +/include/ "fsl/p5020si-pre.dtsi"
> +
> +/ {
> +       model = "varisys,CYRUS";
> +       compatible = "varisys,CYRUS";
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +       interrupt-parent = <&mpic>;
> +
> +       memory {
> +               device_type = "memory";
> +       };
> +
> +       reserved-memory {
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +
> +               bman_fbpr: bman-fbpr {
> +                       size = <0 0x1000000>;
> +                       alignment = <0 0x1000000>;
> +               };
> +               qman_fqd: qman-fqd {
> +                       size = <0 0x400000>;
> +                       alignment = <0 0x400000>;
> +               };
> +               qman_pfdr: qman-pfdr {
> +                       size = <0 0x2000000>;
> +                       alignment = <0 0x2000000>;
> +               };
> +       };
> +
> +       dcsr: dcsr@f00000000 {
> +               ranges = <0x00000000 0xf 0x00000000 0x01008000>;
> +       };
> +
> +       bportals: bman-portals@ff4000000 {
> +               ranges = <0x0 0xf 0xf4000000 0x200000>;
> +       };
> +
> +       qportals: qman-portals@ff4200000 {
> +               ranges = <0x0 0xf 0xf4200000 0x200000>;
> +       };
> +
> +       soc: soc@ffe000000 {
> +               ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
> +               reg = <0xf 0xfe000000 0 0x00001000>;
> +               spi@110000 {
> +               };
> +
> +               i2c@118100 {
> +               };
> +
> +               i2c@119100 {
> +                       rtc@6f {
> +                               compatible = "microchip,mcp7941x";
> +                               reg = <0x6f>;
> +                       };
> +               };
> +       };
> +
> +       rio: rapidio@ffe0c0000 {
> +               reg = <0xf 0xfe0c0000 0 0x11000>;
> +
> +               port1 {
> +                       ranges = <0 0 0xc 0x20000000 0 0x10000000>;
> +               };
> +               port2 {
> +                       ranges = <0 0 0xc 0x30000000 0 0x10000000>;
> +               };
> +       };
> +
> +       lbc: localbus@ffe124000 {
> +               reg = <0xf 0xfe124000 0 0x1000>;
> +               ranges = <0 0 0xf 0xe8000000 0x08000000
> +                         2 0 0xf 0xffa00000 0x00040000
> +                         3 0 0xf 0xffdf0000 0x00008000>;
> +       };
> +
> +       pci0: pcie@ffe200000 {
> +               reg = <0xf 0xfe200000 0 0x1000>;
> +               ranges = <0x02000000 0 0xe0000000 0xc 0x00000000 0x0 0x20000000
> +                         0x01000000 0 0x00000000 0xf 0xf8000000 0x0 0x00010000>;
> +               pcie@0 {
> +                       ranges = <0x02000000 0 0xe0000000
> +                                 0x02000000 0 0xe0000000
> +                                 0 0x20000000
> +
> +                                 0x01000000 0 0x00000000
> +                                 0x01000000 0 0x00000000
> +                                 0 0x00010000>;
> +               };
> +       };
> +
> +       pci1: pcie@ffe201000 {
> +               reg = <0xf 0xfe201000 0 0x1000>;
> +               ranges = <0x02000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x20000000
> +                         0x01000000 0x0 0x00000000 0xf 0xf8010000 0x0 0x00010000>;
> +               pcie@0 {
> +                       ranges = <0x02000000 0 0xe0000000
> +                                 0x02000000 0 0xe0000000
> +                                 0 0x20000000
> +
> +                                 0x01000000 0 0x00000000
> +                                 0x01000000 0 0x00000000
> +                                 0 0x00010000>;
> +               };
> +       };
> +
> +       pci2: pcie@ffe202000 {
> +               reg = <0xf 0xfe202000 0 0x1000>;
> +               ranges = <0x02000000 0 0xe0000000 0xc 0x40000000 0 0x20000000
> +                         0x01000000 0 0x00000000 0xf 0xf8020000 0 0x00010000>;
> +               pcie@0 {
> +                       ranges = <0x02000000 0 0xe0000000
> +                                 0x02000000 0 0xe0000000
> +                                 0 0x20000000
> +
> +                                 0x01000000 0 0x00000000
> +                                 0x01000000 0 0x00000000
> +                                 0 0x00010000>;
> +               };
> +       };
> +
> +       pci3: pcie@ffe203000 {
> +               reg = <0xf 0xfe203000 0 0x1000>;
> +               ranges = <0x02000000 0 0xe0000000 0xc 0x60000000 0 0x20000000
> +                         0x01000000 0 0x00000000 0xf 0xf8030000 0 0x00010000>;
> +               pcie@0 {
> +                       ranges = <0x02000000 0 0xe0000000
> +                                 0x02000000 0 0xe0000000
> +                                 0 0x20000000
> +
> +                                 0x01000000 0 0x00000000
> +                                 0x01000000 0 0x00000000
> +                                 0 0x00010000>;
> +               };
> +       };
> +};
> +
> +/include/ "fsl/p5020si-post.dtsi"
> diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
> index b395571..76e521e 100644
> --- a/arch/powerpc/platforms/85xx/corenet_generic.c
> +++ b/arch/powerpc/platforms/85xx/corenet_generic.c
> @@ -161,6 +161,7 @@ static const char * const boards[] __initconst = {
>         "fsl,T1042RDB",
>         "fsl,T1042RDB_PI",
>         "keymile,kmcoge4",
> +       "varisys,CYRUS",
>         NULL
>  };
>
> --
> 1.9.1
>
