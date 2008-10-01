Return-Path: <dgibson@ozlabs.org>
Date: Wed, 1 Oct 2008 11:17:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Martyn Welch <martyn.welch@gefanuc.com>
Subject: Re: [PATCH v2] powerpc: GE Fanuc's FPGA based PIC controller on
	the SBC610
Message-ID: <20081001011753.GA30810@yookeroo.seuss>
References: <20080930153058.29602.28885.stgit@ubuntu8041.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080930153058.29602.28885.stgit@ubuntu8041.localdomain>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 30, 2008 at 04:34:56PM +0100, Martyn Welch wrote:
> Support for the SBC610 VPX Single Board Computer from GE Fanuc (PowerPC MPC8641D).
> 
> A number of MPC8641D based route interrupts for on-board interrupts through
> a FPGA based interrupt controller, which is chained with the
> MPC8641D's mpic. This patch provides a basic driver to allow basic routing
> of interrupts to the mpic.
> 
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> ---
> 
> Kumar: Thank you for you fast response.
> 
> Change for version 2:
>  * Driver moved from sysdev to platform/86xx
> 
>  arch/powerpc/boot/dts/gef_sbc610.dts     |   38 ++++
>  arch/powerpc/platforms/86xx/Makefile     |    2 
>  arch/powerpc/platforms/86xx/gef_pic.c    |  258 ++++++++++++++++++++++++++++++
>  arch/powerpc/platforms/86xx/gef_pic.h    |   11 +
>  arch/powerpc/platforms/86xx/gef_sbc610.c |   25 +++
>  5 files changed, 328 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/gef_sbc610.dts b/arch/powerpc/boot/dts/gef_sbc610.dts
> index 80b79e4..d7a591b 100644
> --- a/arch/powerpc/boot/dts/gef_sbc610.dts
> +++ b/arch/powerpc/boot/dts/gef_sbc610.dts
> @@ -67,6 +67,36 @@
>  		reg = <0x0 0x40000000>;	// set by uboot
>  	};
>  
> +	localbus@fef05000 {
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		compatible = "fsl,mpc8641-localbus", "simple-bus";
> +		reg = <0xf8005000 0x1000>;
> +		interrupts = <19 2>;
> +		interrupt-parent = <&mpic>;
> +
> +		ranges = <0 0 0xff000000 0x01000000     // 16MB Boot flash
> +			  1 0 0xe8000000 0x08000000     // Paged Flash 0
> +			  2 0 0xe0000000 0x08000000     // Paged Flash 1
> +			  3 0 0xfc100000 0x00020000     // NVRAM
> +			  4 0 0xfc000000 0x00008000     // FPGA
> +			  5 0 0xfc008000 0x00008000     // AFIX FPGA
> +			  6 0 0xfd000000 0x00800000     // IO FPGA (8-bit)
> +			  7 0 0xfd800000 0x00800000>;   // IO FPGA (32-bit)
> +
> +		gef_pic: pic@4,4000 {
> +			#interrupt-cells = <2>;
> +			interrupt-controller;
> +			device_type = "interrupt-controller";

I don't think you should need this device_type.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
