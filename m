Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B9663DDECA
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 05:57:46 +1000 (EST)
In-Reply-To: <20071018180104.GB16748@localhost.localdomain>
References: <2eed9d85d53305b2b0d6e8f8287148f7a600ad19.1192730268.git.avorontsov@ru.mvista.com>
	<20071018180104.GB16748@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C2A61B74-FDB4-4571-A2F4-F0B7317FD7C7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3 2/2] [POWERPC] MPC8568E-MDS: add support for flash
Date: Thu, 18 Oct 2007 14:58:25 -0500
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 18, 2007, at 1:01 PM, Anton Vorontsov wrote:

> MPC8568E-MDS have 1 32MB Spansion x16 CFI flash chip. Let's use it.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  arch/powerpc/boot/dts/mpc8568mds.dts |   34 +++++++++++++++++++++++ 
> ++++++++++-
>  1 files changed, 33 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/ 
> boot/dts/mpc8568mds.dts
> index be8d512..758ada4 100644
> --- a/arch/powerpc/boot/dts/mpc8568mds.dts
> +++ b/arch/powerpc/boot/dts/mpc8568mds.dts
> @@ -47,12 +47,44 @@
>  		#size-cells = <1>;
>  		compatible = "fsl,mpc8568-localbus";
>  		reg = <e0005000 d8>;
> -		ranges = <1 0 f8000000 0008000>;
> +		ranges = <1 0 f8000000 0008000
> +			  0 0 fe000000 2000000>;
>
>  		bcsr@1,0 {
>  			device_type = "board-control";
>  			reg = <1 0 8000>;
>  		};
> +
> +		flash@0,0 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "Spansion,S29GL256N11TFIV2O", "cfi-flash";
> +			reg = <0 0 2000000>;
> +			bank-width = <2>;
> +			device-width = <1>;
> +

Are you basing the partition map on something or making it up?   
Clearly hrcw & u-boot are at fixed offsets, wondering about kernel &  
rootfs?

> +			hrcw@0 {
> +				label = "hrcw";
> +				reg = <0 20000>;
> +				read-only;
> +			};
> +
> +			kernel@20000 {
> +				label = "kernel";
> +				reg = <20000 200000>;
> +			};
> +
> +			rootfs@220000 {
> +				label = "rootfs";
> +				reg = <220000 1d60000>;
> +			};
> +
> +			uboot@1f80000 {
> +				label = "u-boot";
> +				reg = <1f80000 80000>;
> +				read-only;
> +			};
> +		};
>  	};
>
>  	soc8568@e0000000 {
> -- 
> 1.5.0.6
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
