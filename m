Return-Path: <galak@kernel.crashing.org>
Message-Id: <F90E02DE-8497-4E97-8891-B09D4302F423@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <1212130188-28835-3-git-send-email-wg@grandegger.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 2/4] [POWERPC] 85xx: support for the TQM8548 module using
	the big Flash
Date: Fri, 30 May 2008 15:01:34 -0500
References: <1212130188-28835-1-git-send-email-wg@grandegger.com>
	<1212130188-28835-2-git-send-email-wg@grandegger.com>
	<1212130188-28835-3-git-send-email-wg@grandegger.com>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 30, 2008, at 1:49 AM, Wolfgang Grandegger wrote:

> Some TQM85xx boards could be equipped with up to 1 GiB (NOR) flash
> memory and therefore a modified memory map is required and setup by
> the board loader. This patch adds an appropriate DTS file.
>
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> ---
> arch/powerpc/boot/dts/tqm8548-bigflash.dts |  371 +++++++++++++++++++ 
> +++++++++
> 1 files changed, 371 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/tqm8548-bigflash.dts
>
> diff --git a/arch/powerpc/boot/dts/tqm8548-bigflash.dts b/arch/ 
> powerpc/boot/dts/tqm8548-bigflash.dts
> new file mode 100644
> index 0000000..895bb80
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/tqm8548-bigflash.dts
> @@ -0,0 +1,371 @@
> +/*
> + * TQM8548 Device Tree Source
> + *
> + * Copyright 2006 Freescale Semiconductor Inc.
> + * Copyright 2008 Wolfgang Grandegger <wg@denx.de>
> + *
> + * This program is free software; you can redistribute  it and/or  
> modify it
> + * under  the terms of  the GNU General  Public License as  
> published by the
> + * Free Software Foundation;  either version 2 of the  License, or  
> (at your
> + * option) any later version.
> + */
> +
> +/dts-v1/;
> +
> +/ {
> +	model = "tqm,8548";
> +	compatible = "tqm,8548", "tqm,85xx";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	aliases {
> +		ethernet0 = &enet0;
> +		ethernet1 = &enet1;
> +		ethernet2 = &enet2;
> +		ethernet3 = &enet3;
> +
> +		serial0 = &serial0;
> +		serial1 = &serial1;
> +		pci0 = &pci0;
> +		pci1 = &pci1;
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,8548@0 {
> +			device_type = "cpu";
> +			reg = <0>;
> +			d-cache-line-size = <32>;	// 32 bytes
> +			i-cache-line-size = <32>;	// 32 bytes
> +			d-cache-size = <0x8000>;	// L1, 32K
> +			i-cache-size = <0x8000>;	// L1, 32K
> +			timebase-frequency = <0>;	// from U-Boot
> +			bus-frequency = <0>;	// from U-Boot
> +			clock-frequency = <0>;	// from U-Boot

add next-level-cache = <&L2>;

>
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x20000000>;
> +	};
> +
> +	soc8548@e0000000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "soc";
> +		ranges = <0x0 0xa0000000 0x100000>;
> +		reg = <0xa0000000 0x1000>;	// CCSRBAR
> +		bus-frequency = <0>;
> +
> +		memory-controller@2000 {
> +			compatible = "fsl,8548-memory-controller";
> +			reg = <0x2000 0x1000>;
> +			interrupt-parent = <&mpic>;
> +			interrupts = <18 2>;
> +		};
> +
> +		l2-cache-controller@20000 {

add L2 label (L2 : l2-cache-...)

> +			compatible = "fsl,8548-l2-cache-controller";
> +			reg = <0x20000 0x1000>;
> +			cache-line-size = <32>;	// 32 bytes
> +			cache-size = <0x80000>;	// L2, 512K
> +			interrupt-parent = <&mpic>;
> +			interrupts = <16 2>;
> +		};
> +
> +


>
> +		mpic: pic@40000 {
> +			clock-frequency = <0>;
remove clock-frequency

>
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			reg = <0x40000 0x40000>;
> +			compatible = "chrp,open-pic";
> +			device_type = "open-pic";
> +                        big-endian;

remove big-endian.
>
> +		};
> +	};
> +

- k
