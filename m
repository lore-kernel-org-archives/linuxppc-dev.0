Return-Path: <dgibson@ozlabs.org>
Date: Tue, 26 Aug 2008 15:24:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [RFC PATCH 2/2] powerpc/83xx: mpc836x_mds: add support for USB
	Host
Message-ID: <20080826052404.GB8401@yookeroo.seuss>
References: <20080825152736.GB25178@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080825152736.GB25178@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 25, 2008 at 07:27:36PM +0400, Anton Vorontsov wrote:
> Various changes to support QE USB Host on a MPC8360E-MDS board:
> 
> - Update the device tree per QE USB bindings;
> - Configure QE Par IO;
> - Set up BCSR for both USB Host and Peripheral modes;
> - Add timer (GTM) node;
> - Add gpio-controller node for BCSR13 bank;
> - Select FSL_GTM, QE_GPIO and OF_SIMPLE_GPIO.
> 
> The work is loosely based on Li Yang's patch[1], which is used
> to support peripheral mode only.
> 
> [1] http://ozlabs.org/pipermail/linuxppc-dev/2008-August/061357.html
> 
> The s-o-b line of the original patch preserved here.
> 
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  arch/powerpc/boot/dts/mpc836x_mds.dts     |   44 +++++++++++++++++++++++++++-
>  arch/powerpc/platforms/83xx/Kconfig       |    3 ++
>  arch/powerpc/platforms/83xx/mpc836x_mds.c |   31 +++++++++++++++++++-
>  3 files changed, 75 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
> index ada8446..0be98f3 100644
> --- a/arch/powerpc/boot/dts/mpc836x_mds.dts
> +++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
> @@ -69,8 +69,19 @@
>  		};
>  
>  		bcsr@1,0 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
>  			device_type = "board-control";

Not the fault of this patch, obviously, but this device_type should
never have been here.

>  			reg = <1 0 0x8000>;
> +			ranges = <0 1 0 0x8000>;
> +
> +			bcsr13: gpio-controller@d {
> +				#gpio-cells = <2>;
> +				compatible = "fsl,mpc8360mds-bcsr-gpio",
> +					     "simple-gpio-bank";
> +				reg = <0xd 1>;
> +				gpio-controller;
> +			};
>  		};
>  	};
>  
> @@ -191,10 +202,21 @@
>  		};
>  
>  		par_io@1400 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
>  			reg = <0x1400 0x100>;
> +			ranges = <0 0x1400 0x100>;
>  			device_type = "par_io";

Nor this one

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
