Return-Path: <dgibson@ozlabs.org>
Date: Mon, 10 Nov 2008 20:40:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Martyn Welch <martyn.welch@gefanuc.com>
Subject: Re: [PATCH] powerpc: Watchdog timer support for GE Fanuc SBC610
Message-ID: <20081110094021.GB30412@yookeroo.seuss>
References: <20081107143818.9129.47899.stgit@ubuntu8041.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081107143818.9129.47899.stgit@ubuntu8041.localdomain>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 07, 2008 at 02:38:22PM +0000, Martyn Welch wrote:
> Support for the SBC610 VPX Single Baord Computer from GE Fanuc (PowerPC
> MPC8641D).
> 
> This patch adds support for the watchdog timer in the devices main FPGA.
> There are two identical watchdog timers at different offsets in the main
> FPGA, this driver is capable of supporting one of them. The watchdog timers
> are also capable of generating interrupts at a user-configurable threshold,
> though support for this operation is currently not supported by the driver.
> 
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> ---
> 
>  arch/powerpc/boot/dts/gef_sbc610.dts           |   19 +
>  arch/powerpc/configs/86xx/gef_sbc610_defconfig |    1 
>  drivers/watchdog/Kconfig                       |    6 
>  drivers/watchdog/Makefile                      |    1 
>  drivers/watchdog/gef_wdt.c                     |  333 ++++++++++++++++++++++++
>  5 files changed, 360 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/gef_sbc610.dts b/arch/powerpc/boot/dts/gef_sbc610.dts
> index 1f7833c..5c7a38a 100644
> --- a/arch/powerpc/boot/dts/gef_sbc610.dts
> +++ b/arch/powerpc/boot/dts/gef_sbc610.dts
> @@ -88,6 +88,25 @@
>  			compatible = "gef,fpga-regs";
>  			reg = <0x4 0x0 0x40>;
>  		};
> +
> +		wdt@4,2000 {
> +			#interrupt-cells = <2>;

#interrupt-cells doesn't belong here.  That's just for interrupt
controllers or interrupt nexuses, neither of which this appears to be.

> +			device_type = "watchdog";

No device_type either.

> +			compatible = "gef,fpga-wdt";
> +			reg = <0x4 0x2000 0x8>;
> +			interrupts = <0x1a 0x4>;
> +			interrupt-parent = <&gef_pic>;
> +		};
> +		/* Second watchdog available, driver currently supports one.
> +		wdt@4,2010 {
> +			#interrupt-cells = <2>;
> +			device_type = "watchdog";
> +			compatible = "gef,fpga-wdt";
> +			reg = <0x4 0x2010 0x8>;
> +			interrupts = <0x1b 0x4>;
> +			interrupt-parent = <&gef_pic>;
> +		};

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
