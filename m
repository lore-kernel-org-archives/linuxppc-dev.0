Return-Path: <dgibson@ozlabs.org>
Date: Mon, 16 Jun 2008 17:26:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH] [82xx] powerpc: Add support for mpc8247 based board
	MGCOGE from keymile.
Message-ID: <20080616072625.GB28470@yookeroo.seuss>
References: <20080612153215.GB2756@loki.buserror.net>
	<4852A144.6090204@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4852A144.6090204@denx.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jun 13, 2008 at 06:33:08PM +0200, Heiko Schocher wrote:
> Hello Scott,
> 
> here comes the updated version for the mgcoge port, with your
> suggestions:
> 
> [powerpc] Added support for the MPC8247 based board MGCOGE
>             from Keymile.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
>  arch/powerpc/boot/dts/mgcoge.dts      |  174 +++++++
>  arch/powerpc/configs/mgcoge_defconfig |  900 +++++++++++++++++++++++++++++++++
>  arch/powerpc/platforms/82xx/Kconfig   |    8 +
>  arch/powerpc/platforms/82xx/Makefile  |    1 +
>  arch/powerpc/platforms/82xx/mgcoge.c  |  130 +++++
>  5 files changed, 1213 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/mgcoge.dts
>  create mode 100644 arch/powerpc/configs/mgcoge_defconfig
>  create mode 100644 arch/powerpc/platforms/82xx/mgcoge.c
> 
> diff --git a/arch/powerpc/boot/dts/mgcoge.dts b/arch/powerpc/boot/dts/mgcoge.dts
> new file mode 100644
> index 0000000..54d49c5
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/mgcoge.dts
[snip]
> +	localbus@f0010100 {
> +		compatible = "fsl,mpc8247-localbus",
> +		             "fsl,pq2-localbus",
> +		             "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		reg = <0xf0010100 0x40>;
> +
> +		ranges = <0 0 0xfe000000 0x00400000
> +			  1 0 0x50000000 0x20000000
> +			>; /* Filled in by U-Boot */
> +
> +		flash@0,0 {
> +			compatible = "cfi-flash";
> +			reg = <0 0x0 0x400000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			bank-width = <1>;
> +			device-width = <1>;
> +			partition@0 {
> +				label = "u-boot";
> +				reg = <0 0x40000>;
> +			};
> +			partition@40000 {
> +				label = "env";
> +				reg = <0x40000 0x20000>;
> +			};
> +			partition@60000 {
> +				label = "kernel";
> +				reg = <0x60000 0x220000>;
> +			};
> +			partition@280000 {
> +				label = "dtb";
> +				reg = <0x280000 0x20000>;
> +			};
> +		};
> +
> +		flash@5,0 {

>From the 'reg' below and the 'ranges' above, this looks like it should
be "flash@1,0".

> +			compatible = "cfi-flash";
> +			reg = <1 0x0 0x2000000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			bank-width = <2>;
> +			device-width = <2>;
> +			partition@0 {
> +				label = "ramdisk";
> +				reg = <0 0x7a0000>;
> +			};
> +			partition@7a0000 {
> +				label = "user";
> +				reg = <0x7a0000 0x1860000>;
> +			};
> +		};
> +	};

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
