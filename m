Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id EC528DDED9
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 03:59:50 +1100 (EST)
Message-ID: <47E7DDFE.1060805@grandegger.com>
Date: Mon, 24 Mar 2008 17:59:42 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Bartlomiej Sieka <tur@semihalf.com>
Subject: Re: [POWERPC] mpc52xx: Amalgamated dts fixes and updates
References: <47E2723D.1090101@grandegger.com>
	<47E281B6.20702@denx.de>	<fa686aa40803201650t289cd800gfda389b192c1834c@mail.gmail.com>	<47E2FC3E.1020705@semihalf.com>	<fa686aa40803201720l3e42c983se121ebc257c89912@mail.gmail.com>
	<20080321235633.GB345@frozen.semihalf.com>
In-Reply-To: <20080321235633.GB345@frozen.semihalf.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Anatolij Gustschin <agust@denx.de>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Bartlomiej Sieka wrote:
> The bulk of this patch is taken from
> http://patchwork.ozlabs.org/linuxppc/patch?q=Balakowicz&id=16197, with few
> other updates, in particluar one posted by Anatolij Gustschin, which fixes
> an Oops during boot.
>     
> Signed-off-by: Marian Balakowicz <m8@semihalf.com>
> ---
> Anatolij, would you like to add your S-O-B?
> 
> diff --git a/arch/powerpc/boot/dts/cm5200.dts b/arch/powerpc/boot/dts/cm5200.dts
> index 30737ea..8b2e8e4 100644
> --- a/arch/powerpc/boot/dts/cm5200.dts
> +++ b/arch/powerpc/boot/dts/cm5200.dts
> @@ -159,6 +159,7 @@
>  		};
>  
>  		dma-controller@1200 {
> +			device_type = "dma-controller";
>  			compatible = "fsl,mpc5200b-bestcomm","fsl,mpc5200-bestcomm";
>  			reg = <1200 80>;
>  			interrupts = <3 0 0  3 1 0  3 2 0  3 3 0
> @@ -212,13 +213,31 @@
>  		ethernet@3000 {
>  			device_type = "network";
>  			compatible = "fsl,mpc5200b-fec","fsl,mpc5200-fec";
> -			reg = <3000 800>;
> +			reg = <3000 400>;
>  			local-mac-address = [ 00 00 00 00 00 00 ];
>  			interrupts = <2 5 0>;
>  			interrupt-parent = <&mpc5200_pic>;
> +			phy-handle = <&phy0>;
> +		};
> +
> +		mdio@3000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "mdio";
> +			compatible = "fsl,mpc5200b-mdio";
> +			reg = <3000 400>;       // fec range, since we need to setup fec interrupts
> +			interrupts = <2 5 0>;   // these are for "mii command finished", not link changes & co.
> +			interrupt-parent = <&mpc5200_pic>;
> +
> +			phy0:ethernet-phy@0 {
> +				device_type = "ethernet-phy";
> +				reg = <0>;
> +			};
>  		};
>  
>  		i2c@3d40 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
>  			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
>  			reg = <3d40 40>;
>  			interrupts = <2 10 0>;
> @@ -231,4 +250,22 @@
>  			reg = <8000 4000>;
>  		};
>  	};
> +
> +	lpb {
> +		model = "fsl,lpb";
> +		compatible = "fsl,lpb";
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		ranges = <0 0 fc000000 2000000>;
> +
> +		// 16-bit flash device at LocalPlus Bus CS0
> +		flash@0,0 {
> +			compatible = "cfi-flash";
> +			reg = <0 0 2000000>;
> +			bank-width = <2>;
> +			device-width = <2>;
> +			#size-cells = <1>;
> +			#address-cells = <1>;
> +		};
> +	};
>  };
> diff --git a/arch/powerpc/boot/dts/motionpro.dts b/arch/powerpc/boot/dts/motionpro.dts
> index 76951ab..9ca81ff 100644
> --- a/arch/powerpc/boot/dts/motionpro.dts
> +++ b/arch/powerpc/boot/dts/motionpro.dts
> @@ -127,6 +127,13 @@
>  			interrupt-parent = <&mpc5200_pic>;
>  		};
>  
> +		mscan@900 {
> +			compatible = "mpc5200b-mscan\0mpc5200-mscan";
> +			interrupts = <2 11 0>;
> +			interrupt-parent = <&mpc5200_pic>;
> +			reg = <900 80>;
> +		};
> +

If I remember correctly, the motionpro board has only _one_ MSCAN port
wired. Therefore please discard the above hunk.

Wolfgang.
