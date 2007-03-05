Return-Path: <tnt@246tNt.com>
Received: from outmx011.isp.belgacom.be (outmx011.isp.belgacom.be
	[195.238.5.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 28F97DDF2B
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  5 Mar 2007 21:54:37 +1100 (EST)
Received: from outmx011.isp.belgacom.be (localhost [127.0.0.1])
	by outmx011.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l25AsLKu024272
	for <linuxppc-embedded@ozlabs.org>; Mon, 5 Mar 2007 11:54:22 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45EBF6B3.2080808@246tNt.com>
Date: Mon, 05 Mar 2007 11:53:39 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Domen Puncer <domen.puncer@telargo.com>
Subject: Re: [PATCH try3] lite5200(b) support for i2c
References: <20070302104718.GU4397@moe.telargo.com>
	<20070305100802.GV4397@moe.telargo.com>
	<45EBEFEE.9030309@246tNt.com>
	<20070305104031.GW4397@moe.telargo.com>
In-Reply-To: <20070305104031.GW4397@moe.telargo.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Domen Puncer wrote:
> Add fsl-i2c to mpc5200 i2c node in device tree, and enable FSL_SOC.
>
> Tested to work with built-in eeprom on lite5200b.
>
>
> Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
>   
Acked-by: Sylvain Munaut <tnt@246tNt.com>


I'll make sure this is included in my next merge batch to Paul.

    Sylvain

> ---
> D'oh, of course it makes more sense under PPC_MPC52xx.
>
>  arch/powerpc/Kconfig                |    1 +
>  arch/powerpc/boot/dts/lite5200.dts  |    6 ++++--
>  arch/powerpc/boot/dts/lite5200b.dts |    6 ++++--
>  3 files changed, 9 insertions(+), 4 deletions(-)
>
> Index: grant.git/arch/powerpc/Kconfig
> ===================================================================
> --- grant.git.orig/arch/powerpc/Kconfig
> +++ grant.git/arch/powerpc/Kconfig
> @@ -434,6 +434,7 @@ config PPC_CHRP
>  
>  config PPC_MPC52xx
>  	bool
> +	select FSL_SOC
>  	default n
>  
>  config PPC_MPC5200
> Index: grant.git/arch/powerpc/boot/dts/lite5200b.dts
> ===================================================================
> --- grant.git.orig/arch/powerpc/boot/dts/lite5200b.dts
> +++ grant.git/arch/powerpc/boot/dts/lite5200b.dts
> @@ -323,20 +323,22 @@
>  
>  		i2c@3d00 {
>  			device_type = "i2c";
> -			compatible = "mpc5200b-i2c\0mpc5200-i2c";
> +			compatible = "mpc5200b-i2c\0mpc5200-i2c\0fsl-i2c";
>  			cell-index = <0>;
>  			reg = <3d00 40>;
>  			interrupts = <2 f 0>;
>  			interrupt-parent = <500>;
> +			fsl5200-clocking;
>  		};
>  
>  		i2c@3d40 {
>  			device_type = "i2c";
> -			compatible = "mpc5200b-i2c\0mpc5200-i2c";
> +			compatible = "mpc5200b-i2c\0mpc5200-i2c\0fsl-i2c";
>  			cell-index = <1>;
>  			reg = <3d40 40>;
>  			interrupts = <2 10 0>;
>  			interrupt-parent = <500>;
> +			fsl5200-clocking;
>  		};
>  		sram@8000 {
>  			device_type = "sram";
> Index: grant.git/arch/powerpc/boot/dts/lite5200.dts
> ===================================================================
> --- grant.git.orig/arch/powerpc/boot/dts/lite5200.dts
> +++ grant.git/arch/powerpc/boot/dts/lite5200.dts
> @@ -318,20 +318,22 @@
>  
>  		i2c@3d00 {
>  			device_type = "i2c";
> -			compatible = "mpc5200-i2c";
> +			compatible = "mpc5200-i2c\0fsl-i2c";
>  			cell-index = <0>;
>  			reg = <3d00 40>;
>  			interrupts = <2 f 0>;
>  			interrupt-parent = <500>;
> +			fsl5200-clocking;
>  		};
>  
>  		i2c@3d40 {
>  			device_type = "i2c";
> -			compatible = "mpc5200-i2c";
> +			compatible = "mpc5200-i2c\0fsl-i2c";
>  			cell-index = <1>;
>  			reg = <3d40 40>;
>  			interrupts = <2 10 0>;
>  			interrupt-parent = <500>;
> +			fsl5200-clocking;
>  		};
>  		sram@8000 {
>  			device_type = "sram";
>
>   
