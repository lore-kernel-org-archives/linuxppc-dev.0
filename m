Return-Path: <dgibson@ozlabs.org>
Date: Tue, 11 Dec 2007 10:03:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH RFC 7/7] [POWERPC] MPC8360E-RDK: add support for NAND
	on UPM
Message-ID: <20071210230321.GA5495@localhost.localdomain>
References: <20071210204705.GA31263@localhost.localdomain>
	<20071210204951.GG32278@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071210204951.GG32278@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 10, 2007 at 11:49:51PM +0300, Anton Vorontsov wrote:
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  arch/powerpc/boot/dts/mpc836x_rdk.dts     |   24 +++++++++++++++++++++++-
>  arch/powerpc/platforms/83xx/Kconfig       |    2 ++
>  arch/powerpc/platforms/83xx/mpc836x_rdk.c |    1 +
>  3 files changed, 26 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/mpc836x_rdk.dts b/arch/powerpc/boot/dts/mpc836x_rdk.dts
> index a1b2da6..f57ba53 100644
> --- a/arch/powerpc/boot/dts/mpc836x_rdk.dts
> +++ b/arch/powerpc/boot/dts/mpc836x_rdk.dts
> @@ -115,7 +115,7 @@
>  			device_type = "ipic";
>  		};
>  
> -		par_io@1400 {
> +		qe_pio: par_io@1400 {
>  			reg = <0x1400 0x100>;
>  			num-ports = <7>;
>  		};
> @@ -229,4 +229,26 @@
>  			interrupt-parent = <&ipic>;
>  		};
>  	};
> +
> +	localbus@e0005000 {
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		compatible = "fsl,mpc8360erdk-localbus",
> +			     "fsl,mpc8360e-localbus",
> +			     "fsl,pq2pro-localbus";
> +		reg = <0xe0005000 0xd8>;
> +		ranges = <1 0 0x60000000 1>;

The bridge translates a range one byte wide?  I don't think so...

> +
> +		nand-flash@1,0 {
> +			compatible = "STMicro,NAND512W3A2BN6E", "fsl,upm-nand";
> +			reg = <1 0 1>;

The device has a register window *one byte* wide?  That seems
improbable...

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
