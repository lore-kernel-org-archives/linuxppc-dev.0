Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by ozlabs.org (Postfix) with ESMTP id 3B920DE17E
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 03:35:47 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so165217anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 08:35:46 -0800 (PST)
Message-ID: <fa686aa40801100835u256e4be2s484ec6546bcd2fc0@mail.gmail.com>
Date: Thu, 10 Jan 2008 09:35:46 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH v2] [POWERPC] Update MPC8610 HPCD to support audio drivers
In-Reply-To: <1199732204578-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1199732204949-git-send-email-timur@freescale.com>
	<1199732204578-git-send-email-timur@freescale.com>
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/7/08, Timur Tabi <timur@freescale.com> wrote:
> Update the MPC8610 HPCD files to support the audio driver.  Update
> booting-without-of.txt with information on the SSI device.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> Updated based on comments from mailing lists.  Split the patch into two parts.
>
> This patch applies on top of
> git://git.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git.
>
>  Documentation/powerpc/booting-without-of.txt |   40 ++++++
>  arch/powerpc/boot/dts/mpc8610_hpcd.dts       |  110 ++++++++++++++++-
>  arch/powerpc/configs/mpc8610_hpcd_defconfig  |  171 +++++++++++++++++++++++++-
>  arch/powerpc/platforms/86xx/mpc8610_hpcd.c   |   18 +++
>  4 files changed, 335 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
> index e9a3cb1..826af91 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -53,6 +53,7 @@ Table of Contents
>        j) CFI or JEDEC memory-mapped NOR flash
>        k) Global Utilities Block
>        l) Xilinx IP cores
> +      p) Freescale Synchronous Serial Interface
>
>    VII - Specifying interrupt information for devices
>      1) interrupts property
> @@ -2514,6 +2515,45 @@ platforms are moved over to use the flattened-device-tree model.
>        Requred properties:
>         - current-speed : Baud rate of uartlite
>
> +    p) Freescale Synchronous Serial Interface
> +
> +       The SSI is a serial device that communicates with audio codecs.  It can
> +       be programmed in AC97, I2S, left-justified, or right-justified modes.
> +
> +       Required properties:
> +       - compatible      : compatible list, containing "fsl,ssi"
> +       - cell-index      : the SSI, <0> = SSI1, <1> = SSI2, and so on
> +       - reg             : offset and length of the register set for the device
> +       - interrupts      : <a b> where a is the interrupt number and b is a
> +                            field that represents an encoding of the sense and
> +                           level information for the interrupt.  This should be
> +                           encoded based on the information in section 2)
> +                           depending on the type of interrupt controller you
> +                           have.
> +       - interrupt-parent : the phandle for the interrupt controller that
> +                            services interrupts for this device.
> +       - fsl,mode        : the operating mode for the SSI interface
> +                           "i2s-slave" - I2S mode, SSI is clock slave
> +                           "i2s-master" - I2S mode, SSI is clock master
> +                           "lj-slave" - left-justified mode, SSI is clock slave
> +                           "lj-master" - l.j. mode, SSI is clock master
> +                           "rj-slave" - right-justified mode, SSI is clock slave
> +                           "rj-master" - r.j., SSI is clock master
> +                           "ac97-slave" - AC97 mode, SSI is clock slave
> +                           "ac97-master" - AC97 mode, SSI is clock master
> +
> +       Optional properties:
> +       - codec           : child node that defines an audio codec connected
> +                           to this SSI
> +
> +       Child 'codec' node required properties:
> +       - compatible      : compatible list, contains the name of the codec
> +
> +       Child 'codec' node optional properties:
> +       - bus-frequency   : The frequency of the input clock, which typically
> +                            comes from an on-board dedicated oscillator.
> +
> +
>     More devices will be defined as this spec matures.
>
>  VII - Specifying interrupt information for devices
> diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
> index 966edf1..fda0ace 100644
> --- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
> +++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
> @@ -1,7 +1,7 @@
>  /*
>   * MPC8610 HPCD Device Tree Source
>   *
> - * Copyright 2007 Freescale Semiconductor Inc.
> + * Copyright 2007-2008 Freescale Semiconductor Inc.
>   *
>   * This program is free software; you can redistribute  it and/or modify it
>   * under the terms of the GNU General Public License Version 2 as published
> @@ -42,6 +42,7 @@
>                 #size-cells = <1>;
>                 #interrupt-cells = <2>;
>                 device_type = "soc";
> +               compatible = "fsl,mpc8610";

Something like "fsl,mpc8610-immr" might be a better choice here.  This
node doesn't actually describe the entire chip (for example, the PPC
cores are in the cpus node); but it does describe the internally
memory mapped registers.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
