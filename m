Return-Path: <glikely@secretlab.ca>
Received: from mail-pz0-f42.google.com (mail-pz0-f42.google.com
	[209.85.210.42]) by ozlabs.org (Postfix) with ESMTP id 9D491B6F10
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 10:35:04 +1000 (EST)
Received: by pzk30 with SMTP id 30so1301368pzk.15
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Jul 2010 17:35:03 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Sun, 25 Jul 2010 18:35:01 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Mingkai Hu <Mingkai.hu@freescale.com>
Subject: Re: [PATCH 6/6] DTS: add SPI flash(s25fl128p01) support on p4080ds
	and mpc8536ds board
Message-ID: <20100726003501.GE25419@angua.secretlab.ca>
References: <1279591705-7574-1-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-2-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-3-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-4-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-5-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-6-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-7-git-send-email-Mingkai.hu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1279591705-7574-7-git-send-email-Mingkai.hu@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 20, 2010 at 10:08:25AM +0800, Mingkai Hu wrote:
> Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
> ---
>  arch/powerpc/boot/dts/mpc8536ds.dts |   52 +++++++++++++++++++++++++++++++++++
>  arch/powerpc/boot/dts/p4080ds.dts   |    9 ++----
>  2 files changed, 55 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/mpc8536ds.dts b/arch/powerpc/boot/dts/mpc8536ds.dts
> index 815cebb..e5d07ec 100644
> --- a/arch/powerpc/boot/dts/mpc8536ds.dts
> +++ b/arch/powerpc/boot/dts/mpc8536ds.dts
> @@ -108,6 +108,58 @@
>  			};
>  		};
>  
> +		spi@7000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "fsl,espi";
> +			reg = <0x7000 0x1000>;
> +			interrupts = <59 0x2>;
> +			interrupt-parent = <&mpic>;
> + 			fsl,espi-num-chipselects = <4>;
> +
> + 			flash@0 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> + 				compatible = "spansion,s25sl12801";

whitespace inconsitencies

> +				reg = <0>;
> +				spi-max-frequency = <40000000>;
> +				partition@u-boot {
> +					label = "u-boot";
> +					reg = <0x00000000 0x00100000>;
> +					read-only;
> +				};
> +				partition@kernel {
> +					label = "kernel";
> +					reg = <0x00100000 0x00500000>;
> +					read-only;
> +				};
> +				partition@dtb {
> +					label = "dtb";
> +					reg = <0x00600000 0x00100000>;
> +					read-only;
> +				};
> +				partition@fs {
> +					label = "file system";
> +					reg = <0x00700000 0x00900000>;
> +				};
> +			};
> + 			flash@1 {
> + 				compatible = "spansion,s25sl12801";
> +				reg = <1>;
> +				spi-max-frequency = <40000000>;
> +			};
> + 			flash@2 {
> + 				compatible = "spansion,s25sl12801";
> +				reg = <2>;
> +				spi-max-frequency = <40000000>;
> +			};
> + 			flash@3 {
> + 				compatible = "spansion,s25sl12801";

whitespace inconsitencies

> +				reg = <3>;
> +				spi-max-frequency = <40000000>;
> +			};
> +		};
> +
>  		dma@21300 {
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
> index 6b29eab..ac7dd23 100644
> --- a/arch/powerpc/boot/dts/p4080ds.dts
> +++ b/arch/powerpc/boot/dts/p4080ds.dts
> @@ -236,22 +236,19 @@
>  		};
>  
>  		spi@110000 {
> -			cell-index = <0>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			compatible = "fsl,espi";
>  			reg = <0x110000 0x1000>;
>  			interrupts = <53 0x2>;
>  			interrupt-parent = <&mpic>;
> -			espi,num-ss-bits = <4>;
> -			mode = "cpu";
> + 			fsl,espi-num-chipselects = <4>;
>  
> -			fsl_m25p80@0 {
> + 			flash@0 {
>  				#address-cells = <1>;
>  				#size-cells = <1>;
> -				compatible = "fsl,espi-flash";
> + 				compatible = "spansion,s25sl12801";

whitespace inconsistencies

>  				reg = <0>;
> -				linux,modalias = "fsl_m25p80";
>  				spi-max-frequency = <40000000>; /* input clock */
>  				partition@u-boot {
>  					label = "u-boot";
> -- 
> 1.6.4
> 
> 
