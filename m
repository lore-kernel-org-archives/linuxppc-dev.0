Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 37062DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 04:57:36 +1000 (EST)
In-Reply-To: <20070802173536.GA25643@localhost.localdomain>
References: <20070802173335.GA25369@localhost.localdomain>
	<20070802173536.GA25643@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5C596943-5C01-4097-940C-29FF46E49BA7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 1/2] [RFC][POWERPC] MPC832x_RDB: update dts to use spi,
	register mmc_spi stub
Date: Thu, 2 Aug 2007 13:58:47 -0500
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


On Aug 2, 2007, at 12:35 PM, Anton Vorontsov wrote:

> mmc_spi already tested to work. When it will hit mainline
> the only change that will be needed is replacing "spidev"
> by "mmc_spi".
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  arch/powerpc/boot/dts/mpc832x_rdb.dts     |   27 +++++++++++++-
>  arch/powerpc/platforms/83xx/mpc832x_rdb.c |   55 ++++++++++++++++++ 
> +++++++++++
>  2 files changed, 81 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/ 
> boot/dts/mpc832x_rdb.dts
> index e9c332f..5ed92ca 100644
> --- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
> +++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
> @@ -183,6 +183,21 @@

[snip]

> @@ -206,16 +221,26 @@
>  		};
>
>  		spi@4c0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
>  			device_type = "spi";
> +			fsl,device-id = <1>;
>  			compatible = "fsl_spi";
>  			reg = <4c0 40>;
>  			interrupts = <2>;
>  			interrupt-parent = <&qeic>;
> -			mode = "cpu";
> +			mode = "cpu-qe";
> +			pio-handle = <&spi1pio>;
> +
> +			mmc@0 {
> +				reg = <0>;
> +				pio-handle = <&mmc0pio>;
> +			};
>  		};

I'm still against this.  Why don't we just do this in 83xx/mpc832x_rdb.c

- k
