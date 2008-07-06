Return-Path: <dgibson@ozlabs.org>
Date: Mon, 7 Jul 2008 09:50:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andre Schwarz <andre.schwarz@matrix-vision.de>
Subject: Re: [PATCH] Add MPC5200B base board mvBC-P
Message-ID: <20080706235046.GA6267@yookeroo.seuss>
References: <486E515B.80508@matrix-vision.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <486E515B.80508@matrix-vision.de>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 04, 2008 at 06:35:39PM +0200, Andre Schwarz wrote:
> The mvBlueCOUGAR-P is a MPC5200B based camera system with Intel Gigabit ethernet
> controller (using e1000). It's just another MPC5200_simple board.
> 
> Signed-off-by: Andre Schwarz <andre.schwarz@matrix-vision.de>
[snip]
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/mvbc-p.dts
> @@ -0,0 +1,206 @@

[snip]
> +		dma-controller@1200 {
> +			device_type = "dma-controller";

No device_type here.

> +			compatible = "fsl,mpc5200-bestcomm";
> +			reg = <0x1200 0x80>;
> +			interrupts = <3 0 0  3 1 0  3 2 0  3 3 0
> +				3 4 0  3 5 0  3 6 0  3 7 0
> +				3 8 0  3 9 0  3 10 0  3 11 0
> +				3 12 0  3 13 0  3 14 0  3 15 0>;
> +			interrupt-parent = <&mpc5200_pic>;
> +		};
> +
> +		xlb@1f00 {
> +			compatible = "fsl,mpc5200-xlb";
> +			reg = <0x1f00 0x100>;
> +		};
> +
> +		serial0: serial@2000 {		// PSC1
> +			device_type = "serial";
> +			compatible = "fsl,mpc5200-psc-uart";
> +			port-number = <0>;
> +			reg = <0x2000 0x100>;
> +			interrupts = <2 1 0>;
> +			interrupt-parent = <&mpc5200_pic>;
> +		};
> +
> +		i2c@3d00 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "fsl,mpc5200-i2c","fsl-i2c";
> +			reg = <0x3d00 0x40>;
> +			interrupts = <2 15 0>;
> +			interrupt-parent = <&mpc5200_pic>;
> +			fsl5200-clocking;
> +		};
> +
> +		i2c@3d40 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "fsl,mpc5200-i2c","fsl-i2c";
> +			reg = <0x3d40 0x40>;
> +			interrupts = <2 16 0>;
> +			interrupt-parent = <&mpc5200_pic>;
> +			fsl5200-clocking;
> +		};
> +		sram@8000 {
> +			compatible = "fsl,mpc5200-sram","sram";
> +			reg = <0x8000 0x4000>;
> +		};
> +	};

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
