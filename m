Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5396ADDE28
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 23:17:50 +1000 (EST)
In-Reply-To: <20070507232634.GA11166@blade.az.mvista.com>
References: <20070425213700.GA8814@blade.az.mvista.com>
	<20070426000852.GA2193@localhost.localdomain>
	<20070426003748.GA30730@blade.az.mvista.com>
	<9903F55A-5E4E-42CE-8C27-6B7143B9FE25@kernel.crashing.org>
	<20070501183220.GA6426@blade.az.mvista.com>
	<20070507232634.GA11166@blade.az.mvista.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3EF891D2-F973-43D6-B43B-B8BBC4269C60@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: add dts entries to 85xx for EDAC
Date: Tue, 8 May 2007 08:16:52 -0500
To: Dave Jiang <djiang@mvista.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 7, 2007, at 6:26 PM, Dave Jiang wrote:

> Adding memory-controller and l2-cache-controller entries to be used  
> by EDAC as
> of_devices.

we should distinguish the memory controllers on 8540/8560 (DDR1) from  
the one on 8548 (DDR1 & DDR2).

- k


>
> Signed-off-by: Dave Jiang <djiang@mvista.com>
>
> ---
>
>  arch/powerpc/boot/dts/mpc8540ads.dts |   16 ++++++++++++++++
>  arch/powerpc/boot/dts/mpc8548cds.dts |   16 ++++++++++++++++
>  arch/powerpc/boot/dts/mpc8560ads.dts |   18 +++++++++++++++++-
>  3 files changed, 49 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/ 
> boot/dts/mpc8540ads.dts
> index f261d64..f411bc1 100644
> --- a/arch/powerpc/boot/dts/mpc8540ads.dts
> +++ b/arch/powerpc/boot/dts/mpc8540ads.dts
> @@ -48,6 +48,22 @@
>  		reg = <e0000000 00100000>;	// CCSRBAR 1M
>  		bus-frequency = <0>;
>
> +		memory-controller@2000 {
> +			compatible = "fsl,85xx-memory-controller";
> +			reg = <2000 1000>;
> +			interrupt-parent = <&mpic>;
> +			interrupts = <2 2>;
> +		};
> +
> +		l2-cache-controller@20000 {
> +			compatible = "fsl,85xx-memory-controller";
> +			reg = <20000 1000>;
> +			cache-line-size = <20>;	// 32 bytes
> +			cache-size = <40000>;	// L2, 256K
> +			interrupt-parent = <&mpic>;
> +			interrupts = <0 2>;
> +		};
> +
>  		i2c@3000 {
>  			device_type = "i2c";
>  			compatible = "fsl-i2c";
> diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/ 
> boot/dts/mpc8548cds.dts
> index b2b2200..9de5c3a 100644
> --- a/arch/powerpc/boot/dts/mpc8548cds.dts
> +++ b/arch/powerpc/boot/dts/mpc8548cds.dts
> @@ -48,6 +48,22 @@
>  		reg = <e0000000 00100000>;	// CCSRBAR 1M
>  		bus-frequency = <0>;
>
> +		memory-controller@2000 {
> +			compatible = "fsl,85xx-memory-controller";
> +			reg = <2000 1000>;
> +			interrupt-parent = <&mpic>;
> +			interrupts = <2 2>;
> +		};
> +
> +		l2-cache-controller@20000 {
> +			compatible = "fsl,85xx-l2-cache-controller";
> +			reg = <20000 1000>;
> +			cache-line-size = <20>;	// 32 bytes
> +			cache-size = <40000>;	// L2, 256K
> +			interrupt-parent = <&mpic>;
> +			interrupts = <0 2>;
> +		};
> +
>  		i2c@3000 {
>  			device_type = "i2c";
>  			compatible = "fsl-i2c";
> diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/ 
> boot/dts/mpc8560ads.dts
> index 1f2afe9..6e59364 100644
> --- a/arch/powerpc/boot/dts/mpc8560ads.dts
> +++ b/arch/powerpc/boot/dts/mpc8560ads.dts
> @@ -48,6 +48,22 @@
>  		reg = <e0000000 00000200>;
>  		bus-frequency = <13ab6680>;
>
> +		memory-controller@2000 {
> +			compatible = "fsl,85xx-memory-controller";
> +			reg = <2000 1000>;
> +			interrupt-parent = <&mpic>;
> +			interrupts = <2 2>;
> +		};
> +
> +		l2-cache-controller@20000 {
> +			compatible = "fsl,85xx-l2-cache-controller";
> +			reg = <20000 1000>;
> +			cache-line-size = <20>;	// 32 bytes
> +			cache-size = <40000>;	// L2, 256K
> +			interrupt-parent = <&mpic>;
> +			interrupts = <0 2>;
> +		};
> +
>  		mdio@24520 {
>  			device_type = "mdio";
>  			compatible = "gianfar";
> @@ -110,7 +126,7 @@
>  			#address-cells = <3>;
>  			compatible = "85xx";
>  			device_type = "pci";
> -			reg = <8000 400>;
> +			reg = <8000 1000>;
>  			clock-frequency = <3f940aa>;
>  			interrupt-map-mask = <f800 0 0 7>;
>  			interrupt-map = <
