Return-Path: <dgibson@ozlabs.org>
Date: Sat, 11 Oct 2008 17:56:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/3] powerpc: add driver for simple GPIO banks
Message-ID: <20081011065618.GA11731@yookeroo.seuss>
References: <20081010165410.GA4291@oksana.dev.rtsoft.ru>
	<20081010165501.GB4291@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081010165501.GB4291@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 10, 2008 at 08:55:01PM +0400, Anton Vorontsov wrote:
> The driver supports very simple GPIO controllers, that is, when a
> controller provides just a 'data' register. Such controllers may be
> found in various BCSRs (Board's FPGAs used to control board's
> switches, LEDs, chip-selects, Ethernet/USB PHY power, etc).
> 
> So far we support only 1-byte GPIO banks. Support for other widths may
> be implemented when/if needed.
> 
> p.s.
> To avoid "made up" compatible entries (like compatible = "simple-gpio"),
> boards must call the simple_gpiochip_init() to pass the compatible
> string.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  Documentation/powerpc/dts-bindings/fsl/board.txt |   30 ++++
>  arch/powerpc/platforms/Kconfig                   |   11 ++
>  arch/powerpc/sysdev/Makefile                     |    1 +
>  arch/powerpc/sysdev/simple_gpio.c                |  157 ++++++++++++++++++++++
>  arch/powerpc/sysdev/simple_gpio.h                |   13 ++
>  5 files changed, 212 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/sysdev/simple_gpio.c
>  create mode 100644 arch/powerpc/sysdev/simple_gpio.h
> 
> diff --git a/Documentation/powerpc/dts-bindings/fsl/board.txt b/Documentation/powerpc/dts-bindings/fsl/board.txt
> index 74ae6f1..e97877f 100644
> --- a/Documentation/powerpc/dts-bindings/fsl/board.txt
> +++ b/Documentation/powerpc/dts-bindings/fsl/board.txt
> @@ -27,3 +27,33 @@ Example (MPC8610HPCD):
>  		compatible = "fsl,fpga-pixis";
>  		reg = <0xe8000000 32>;
>  	};
> +
> +* Freescale BCSR GPIO banks
> +
> +Some BCSR registers act as simple GPIO controllers, each such
> +register can be represented by the gpio-controller node.
> +
> +Required properities:
> +- compatible : Should be "fsl,<board>-bcsr-gpio";
> +- reg : Should contain the address and the lenght of the GPIO bank
> +  register;
> +- #gpio-cells : Should be two. The first cell is the pin number and the
> +  second cell is used to specify optional paramters (currently unused);
> +- gpio-controller : Marks the port as GPIO controller.
> +
> +Example:
> +
> +	bcsr@1,0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "board-control";

This device_type field should not be used.  I know it is in the
existing samples, which is another bug.  But please don't document it
(and thereby further encourage it).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
