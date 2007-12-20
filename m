Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F3970DDE39
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 10:54:18 +1100 (EST)
Message-Id: <1B437E39-4FA7-4657-9EE2-EBDD37F1106A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <11981624742139-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 3/4] sbc8560: Add device tree source for Wind River
	SBC8560 board
Date: Thu, 20 Dec 2007 17:54:13 -0600
References: <11981624722785-git-send-email-paul.gortmaker@windriver.com>
	<11981624732110-git-send-email-paul.gortmaker@windriver.com>
	<11981624741263-git-send-email-paul.gortmaker@windriver.com>
	<11981624742139-git-send-email-paul.gortmaker@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 20, 2007, at 8:54 AM, Paul Gortmaker wrote:

> This adds the device tree source for the Wind River SBC8560 board.   
> The
> biggest difference between this and the MPC8560ADS reference platform
> is the use of an external 16550 compatible UART instead of the CPM2.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> arch/powerpc/boot/dts/sbc8560.dts |  202 ++++++++++++++++++++++++++++ 
> +++++++++
> 1 files changed, 202 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/sbc8560.dts b/arch/powerpc/boot/ 
> dts/sbc8560.dts
> new file mode 100644
> index 0000000..85fc488
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/sbc8560.dts
> @@ -0,0 +1,202 @@
> +/*
> + * SBC8560 Device Tree Source
> + *
> + * Copyright 2007 Wind River Systems Inc.
> + *
> + * Paul Gortmaker (see MAINTAINERS for contact information)
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

can you look at converting this to a dts-v1 format.

>
> +
> +/ {
> +	model = "SBC8560";
> +	compatible = "SBC8560";
> +	#address-cells = <1>;
> +	#size-cells = <1>;

add aliases.

>
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,8560@0 {
> +			device_type = "cpu";
> +			reg = <0>;
> +			d-cache-line-size = <20>;	// 32 bytes
> +			i-cache-line-size = <20>;	// 32 bytes
> +			d-cache-size = <8000>;		// L1, 32K
> +			i-cache-size = <8000>;		// L1, 32K
> +			timebase-frequency = <0>;	// From uboot
> +			bus-frequency = <0>;
> +			clock-frequency = <0>;
> +			32-bit;
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <00000000 20000000>;
> +	};
> +
> +	soc8560@ff700000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		#interrupt-cells = <2>;
> +		device_type = "soc";
> +		ranges = <0 ff700000 00100000>;
> +		reg = <ff700000 00100000>;
> +		bus-frequency = <0>;
> +
> +		memory-controller@2000 {
> +			compatible = "fsl,8560-memory-controller";
> +			reg = <2000 1000>;
> +			interrupt-parent = <&mpic>;
> +			interrupts = <12 2>;
> +		};
> +
> +		l2-cache-controller@20000 {
> +			compatible = "fsl,8560-l2-cache-controller";
> +			reg = <20000 1000>;
> +			cache-line-size = <20>;	// 32 bytes
> +			cache-size = <40000>;	// L2, 256K
> +			interrupt-parent = <&mpic>;
> +			interrupts = <10 2>;
> +		};
> +
> +		i2c@3000 {
> +			device_type = "i2c";
> +			compatible = "fsl-i2c";
> +			reg = <3000 100>;
> +			interrupts = <2b 2>;
> +			interrupt-parent = <&mpic>;
> +			dfsrr;
> +		};

See updates for i2c controllers in the for-2.6.25 branch.

>
> +
> +		mdio@24520 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "mdio";
> +			compatible = "gianfar";

seem updates to mdio in for-2.6.25 branch.

>
> +			reg = <24520 20>;
> +			phy0: ethernet-phy@19 {
> +				interrupt-parent = <&mpic>;
> +				interrupts = <6 1>;
> +				reg = <19>;
> +				device_type = "ethernet-phy";
> +			};
> +			phy1: ethernet-phy@1a {
> +				interrupt-parent = <&mpic>;
> +				interrupts = <7 1>;
> +				reg = <1a>;
> +				device_type = "ethernet-phy";
> +			};
> +		};
> +
> +		ethernet@24000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "network";
> +			model = "TSEC";
> +			compatible = "gianfar";
> +			reg = <24000 1000>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			interrupts = <1d 2 1e 2 22 2>;
> +			interrupt-parent = <&mpic>;
> +			phy-handle = <&phy0>;

see updates to enet nodes.

>
> +		};
> +
> +		ethernet@25000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "network";
> +			model = "TSEC";
> +			compatible = "gianfar";
> +			reg = <25000 1000>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			interrupts = <23 2 24 2 28 2>;
> +			interrupt-parent = <&mpic>;
> +			phy-handle = <&phy1>;
> +		};
> +

- k
