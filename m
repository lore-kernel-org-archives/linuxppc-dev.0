Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F2335DE39D
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 04:18:42 +1000 (EST)
Message-ID: <48ADB153.20208@freescale.com>
Date: Thu, 21 Aug 2008 13:17:55 -0500
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Martyn Welch <martyn.welch@gefanuc.com>
Subject: Re: [PATCH 1/2] powerpc: Board support for GE Fanuc SBC610
References: <20080821133852.17201.3862.stgit@welchma.Radstone.Local>
	<20080821144144.fed06908.martyn.welch@gefanuc.com>
In-Reply-To: <20080821144144.fed06908.martyn.welch@gefanuc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Martyn Welch wrote:
> Support for the SBC610 VPX Single Board Computer from GE Fanuc (PowerPC
> MPC8641D).
> 
> This is the basic board support for GE Fanuc's SBC610, a 6U single board
> computer, based on Freescale's MPC8641D.
> 
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> ---
> 
>  arch/powerpc/boot/dts/gef_sbc610.dts     |  268 ++++++++++++++++++++++++++++++
>  arch/powerpc/platforms/86xx/Kconfig      |    9 +
>  arch/powerpc/platforms/86xx/Makefile     |    1 
>  arch/powerpc/platforms/86xx/gef_sbc610.c |  187 +++++++++++++++++++++
>  4 files changed, 464 insertions(+), 1 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/gef_sbc610.dts
>  create mode 100644 arch/powerpc/platforms/86xx/gef_sbc610.c
> 
> 

> +	soc8641@fef00000 {

No "8641" in this name, please.

Oh, and drop the ""32-bit" in the CPU sections too.

> +		ecc@2000 {
> +			device_type = "dram-controller";

Hmmm, I suspect that should be dropped.

> +			compatible = "mpc86xx";

And that changed to indicate some form of controller thing.
Using "mpc86xx" here is just not right at all.

> +
> +                serial0: serial@4500 {
> +                        cell-index = <0>;
> +                        device_type = "serial";
> +                        compatible = "ns16550";
> +                        reg = <0x00004500 0x00000100>;
> +			clock-frequency = <0>;
> +                        interrupts = <0x2a 0x2>;
> +                        interrupt-parent = <&mpic>;
> +                };
> +
> +                serial1: serial@4600 {
> +                        cell-index = <1>;
> +                        device_type = "serial";
> +                        compatible = "ns16550";
> +                        reg = <0x00004600 0x00000100>;
> +			clock-frequency = <0>;
> +                        interrupts = <0x1c 0x2>;
> +                        interrupt-parent = <&mpic>;
> +                };

There's some form of indenting issue there...

> +		mpic: pic@40000 {
> +			clock-frequency = <0>;
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			reg = <0x00040000 0x00040000>;
> +			built-in;
> +			compatible = "chrp,open-pic";
> +			device_type = "open-pic";
> +                        big-endian;

IIRC, we dropped "big-endian" too. (?)



> diff --git a/arch/powerpc/platforms/86xx/gef_sbc610.c b/arch/powerpc/platforms/86xx/gef_sbc610.c
> new file mode 100644
> index 0000000..6b92876
> --- /dev/null
> +++ b/arch/powerpc/platforms/86xx/gef_sbc610.c
> @@ -0,0 +1,187 @@

> +
> +/*
> + * Based on: mpc86xx_hpcn.c
> + *
> + * MPC86xx HPCN board specific routines
> + *
> + * Recode: ZHANG WEI <wei.zhang@freescale.com>
> + * Initial author: Xianghua Xiao <x.xiao@freescale.com>
> + *
> + * Copyright 2006 Freescale Semiconductor Inc.
> + *
> + */

This seems misleading some.  Sure, state your attributions
and derivation sources, but this also still looks like it
is stating that it *is* the MPC86xx HPCN board code.

Thanks,
jdl
