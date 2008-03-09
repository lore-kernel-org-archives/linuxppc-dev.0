Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 26E42DDDF0
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2008 03:59:28 +1100 (EST)
Date: Sun, 9 Mar 2008 19:59:14 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: hs@denx.de
Subject: Re: [Patch] 8xx: MGSUVD support
Message-ID: <20080309195914.69d51e68@kernel.crashing.org>
In-Reply-To: <47D3B44D.8070909@denx.de>
References: <47D3B44D.8070909@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Heiko,

On Sun, 09 Mar 2008 10:56:29 +0100
Heiko Schocher wrote:

> Hello,
> 
> the following patch adds support for the MPC852 based mgsuvd board
> from keymile.
Looks good overall. Please add supported/working/not working etc SoC devices state along with the patch 
description. Also a few really small comments below...

> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
>  arch/powerpc/boot/dts/mgsuvd.dts      |  158 +++++++
>  arch/powerpc/configs/mgsuvd_defconfig |  827
> +++++++++++++++++++++++++++++++++
> arch/powerpc/platforms/8xx/Kconfig    |    7 +
> arch/powerpc/platforms/8xx/Makefile   |    1 +
> arch/powerpc/platforms/8xx/mgsuvd.c   |  138 ++++++ 5 files changed,
> 1131 insertions(+), 0 deletions(-) create mode 100644
> arch/powerpc/boot/dts/mgsuvd.dts create mode 100644
> arch/powerpc/configs/mgsuvd_defconfig create mode 100644
> arch/powerpc/platforms/8xx/mgsuvd.c
> 
> diff --git a/arch/powerpc/boot/dts/mgsuvd.dts
> b/arch/powerpc/boot/dts/mgsuvd.dts new file mode 100644
> index 0000000..629cb6d
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/mgsuvd.dts
> @@ -0,0 +1,158 @@
> +/*
> + * MGSUVD Device Tree Source
> + *
> + * Copyright 2008 DENX Software Engineering GmbH
> + * Heiko Schocher <hs@denx.de>
> + *
> + * This program is free software; you can redistribute  it and/or
> modify it
> + * under  the terms of  the GNU General  Public License as published
> by the
> + * Free Software Foundation;  either version 2 of the  License, or
> (at your
> + * option) any later version.
> + */
> +
> +
> +/ {
> +	model = "MGSUVD";
> +	compatible = "keymile,mgsuvd";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,866@0 {
But it's mpc852, isn't it?

> +			device_type = "cpu";
> +			reg = <0>;
> +			d-cache-line-size = <d#16>;
> +			i-cache-line-size = <d#16>;
> +			d-cache-size = <d#8192>;
> +			i-cache-size = <d#8192>;
> +			timebase-frequency = <0>;  /* Filled in by
> u-boot */
> +			bus-frequency = <0>;  /* Filled in by u-boot
> */
> +			clock-frequency = <0>; /* Filled in by
> u-boot */
> +			interrupts = <f 2>;	// decrementer
> interrupt
I would like all the comments to be consistent C style (because that's it for the most other dts'es).

[....]
-- 
Sincerely, Vitaly
