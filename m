Return-Path: <dgibson@ozlabs.org>
Date: Tue, 8 Jul 2008 13:16:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: John Linn <john.linn@xilinx.com>
Subject: Re: [PATCH] [V2] powerpc: Xilinx: add dts file for ML507 board
Message-ID: <20080708031641.GA1549@yookeroo.seuss>
References: <20080707180508.4E2CBE8081@mail72-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080707180508.4E2CBE8081@mail72-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 07, 2008 at 11:04:59AM -0700, John Linn wrote:
> This new file adds support for the ML507 board which
> has a Virtex 5 FXT FPGA with a 440.
> 
> Signed-off-by: John Linn <john.linn@xilinx.com>
> ---
> V2
> 	Converted to dts-v1 format.
> 	Changed to match a newer reference design.
> 
>  arch/powerpc/boot/dts/virtex440-ml507.dts |  296 +++++++++++++++++++++++++++++
>  1 files changed, 296 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/virtex440-ml507.dts
> 
> diff --git a/arch/powerpc/boot/dts/virtex440-ml507.dts b/arch/powerpc/boot/dts/virtex440-ml507.dts
> new file mode 100644
> index 0000000..d10a993
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/virtex440-ml507.dts
> @@ -0,0 +1,296 @@
> +/*
> + * This file supports the Xilinx ML507 board with the 440 processor.
> + * A reference design for the FPGA is provided at http://git.xilinx.com.
> + *
> + * (C) Copyright 2008 Xilinx, Inc.
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2. This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "xlnx,virtex440";
> +	dcr-parent = <&ppc440_0>;
> +	model = "testing";
> +	DDR2_SDRAM: memory@0 {
> +		device_type = "memory";
> +		reg = < 0 0x10000000 >;
> +	} ;
> +	chosen {
> +		bootargs = "console=ttyS0 ip=on root=/dev/ram";

Bootargs like this should not typically go in the dts file.

> +		linux,stdout-path = "/plb@0/serial@83e00000";
> +	} ;
> +	cpus {
> +		#address-cells = <1>;
> +		#cpus = <1>;
> +		#size-cells = <0>;
> +		ppc440_0: cpu@0 {
> +			clock-frequency = "";

Presumably this is supposed to be filled in by the bootloader.  But in
any case it shouldn't be a string.

[snip]
> +			DMA0: sdma@80 {
> +				compatible = "xlnx,ll-dma-1.00.a";
> +				dcr-reg = < 0x80 0x11 >;
> +				interrupt-parent = <&xps_intc_0>;
> +				interrupts = < 9 2 0xa 2 >;
> +			} ;

Putting devices under the cpu node is certainly... atypical.  It's not
obviously wrong, for a dcr device like this, but we probably want a
little more discussion before establishing a convention like this.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
