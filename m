Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7A704DDEDD
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 16:20:14 +1100 (EST)
Message-Id: <EB293853-B27A-4B0E-AEEB-8D3F09E8F12D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20071211212247.GB3620@loki.buserror.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 2/3] mpc82xx: Embedded Planet EP8248E support
Date: Thu, 13 Dec 2007 23:19:33 -0600
References: <20071211212247.GB3620@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 11, 2007, at 3:22 PM, Scott Wood wrote:

> This board is also resold by Freescale under the names
> "QUICCStart MPC8248 Evaluation System" and "CWH-PPC-8248N-VE".
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/boot/Makefile             |    3 +-
> arch/powerpc/boot/dts/ep8248e.dts      |  193 +++++++
> arch/powerpc/boot/ep8248e.c            |   55 ++
> arch/powerpc/boot/wrapper              |    2 +-
> arch/powerpc/configs/ep8248e_defconfig |  864 +++++++++++++++++++++++ 
> +++++++++
> arch/powerpc/platforms/82xx/Kconfig    |   13 +
> arch/powerpc/platforms/82xx/Makefile   |    1 +
> arch/powerpc/platforms/82xx/ep8248e.c  |  321 ++++++++++++
> include/asm-powerpc/mpc8260.h          |    1 +
> 9 files changed, 1451 insertions(+), 2 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/ep8248e.dts
> create mode 100644 arch/powerpc/boot/ep8248e.c
> create mode 100644 arch/powerpc/configs/ep8248e_defconfig
> create mode 100644 arch/powerpc/platforms/82xx/ep8248e.c


>
> diff --git a/arch/powerpc/boot/dts/ep8248e.dts b/arch/powerpc/boot/ 
> dts/ep8248e.dts
> new file mode 100644
> index 0000000..ee8405d
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/ep8248e.dts
> @@ -0,0 +1,193 @@
> +/*
> + * Device Tree for the Embedded Planet EP8248E board running  
> PlanetCore.
> + *
> + * Copyright 2007 Freescale Semiconductor Inc.
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

Can we make this a /dts-v1/; since its new.
>
> +/ {
> +	model = "EP8248E";
> +	compatible = "fsl,ep8248e";
> +	#address-cells = <1>;
> +	#size-cells = <1>;

Add a aliases { } and can we use that instead of linux,network-index  
and linux,planetcore-label.

> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,8248@0 {
> +			device_type = "cpu";
> +			reg = <0>;
> +			d-cache-line-size = <d#32>;
> +			i-cache-line-size = <d#32>;
> +			d-cache-size = <d#16384>;
> +			i-cache-size = <d#16384>;
> +			timebase-frequency = <0>;
> +			clock-frequency = <0>;
> +		};
> +	};
> +
> +	localbus {
> +		compatible = "fsl,ep8248e-localbus",
> +		             "fsl,mpc8248-localbus",
> +		             "fsl,pq2-localbus";
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		reg = <f0010100 40>;
> +
> +		ranges = <0 0 fc000000 04000000
> +		          1 0 fa000000 00008000>;
> +
> +		flash@0,3800000 {
> +			compatible = "cfi-flash";
> +			reg = <0 3800000 800000>;
> +			bank-width = <4>;
> +			device-width = <2>;
> +		};
> +
> +		bcsr@1,0 {
> +			#address-cells = <2>;
> +			#size-cells = <1>;
> +			reg = <1 0 10>;
> +			compatible = "fsl,ep8248e-bcsr";
> +			ranges;
> +
> +			mdio {
> +				device_type = "mdio";
> +				compatible = "fsl,ep8248e-mdio-bitbang";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <1 8 1>;
> +
> +				PHY0: ethernet-phy@0 {
> +					interrupt-parent = <&PIC>;
> +					reg = <0>;
> +					device_type = "ethernet-phy";
> +				};
> +
> +				PHY1: ethernet-phy@1 {
> +					interrupt-parent = <&PIC>;
> +					reg = <1>;
> +					device_type = "ethernet-phy";
> +				};
> +			};
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0 0>;
> +	};
> +
> +	soc@f0000000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "soc";
> +		compatible = "fsl,mpc8248", "fsl,pq2-soc";
> +		ranges = <00000000 f0000000 00053000>;
> +
> +		// Temporary -- will go away once kernel uses ranges for  
> get_immrbase().
> +		reg = <f0000000 00053000>;
> +
> +		cpm@119c0 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			#interrupt-cells = <2>;
> +			compatible = "fsl,mpc8248-cpm", "fsl,cpm2";
> +			reg = <119c0 30>;
> +			ranges;
> +
> +			muram {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0 0 10000>;
> +
> +				data@0 {
> +					compatible = "fsl,cpm-muram-data";
> +					reg = <0 1100 1140 ec0 9800 800>;
> +				};
> +			};
> +
> +			brg@119f0 {
> +				compatible = "fsl,mpc8272-brg",
> +				             "fsl,cpm2-brg",
> +				             "fsl,cpm-brg";
> +				reg = <119f0 10 115f0 10>;
> +			};
> +
> +			/* Monitor port/SMC1 */
> +			serial@11a80 {
> +				device_type = "serial";
> +				compatible = "fsl,mpc8248-smc-uart",
> +				             "fsl,cpm2-smc-uart";
> +				reg = <11a80 20 1100 40>;
> +				interrupts = <4 8>;
> +				interrupt-parent = <&PIC>;
> +				fsl,cpm-brg = <7>;
> +				fsl,cpm-command = <1d000000>;
> +				linux,planetcore-label = "SMC1";
> +			};
> +
> +			/* "Serial" port/SCC1 */
> +			serial@11a00 {
> +				device_type = "serial";
> +				compatible = "fsl,mpc8248-scc-uart",
> +				             "fsl,cpm2-scc-uart";
> +				reg = <11a00 20 8000 100>;
> +				interrupts = <28 8>;
> +				interrupt-parent = <&PIC>;
> +				fsl,cpm-brg = <1>;
> +				fsl,cpm-command = <00800000>;
> +				linux,planetcore-label = "SCC1";
> +			};
> +
> +			ethernet@11300 {
> +				device_type = "network";
> +				compatible = "fsl,mpc8248-fcc-enet",
> +				             "fsl,cpm2-fcc-enet";
> +				reg = <11300 20 8400 100 11390 1>;
> +				local-mac-address = [ 00 00 00 00 00 00 ];
> +				interrupts = <20 8>;
> +				interrupt-parent = <&PIC>;
> +				phy-handle = <&PHY0>;
> +				linux,network-index = <0>;
> +				fsl,cpm-command = <12000300>;
> +			};
> +
> +			ethernet@11320 {
> +				device_type = "network";
> +				compatible = "fsl,mpc8248-fcc-enet",
> +				             "fsl,cpm2-fcc-enet";
> +				reg = <11320 20 8500 100 113b0 1>;
> +				local-mac-address = [ 00 00 00 00 00 00 ];
> +				interrupts = <21 8>;
> +				interrupt-parent = <&PIC>;
> +				phy-handle = <&PHY1>;
> +				linux,network-index = <1>;
> +				fsl,cpm-command = <16200300>;
> +			};
> +
> +			usb@11b60 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,mpc8248-usb",
> +				             "fsl,cpm2-usb";
> +				reg = <11b60 18 8b00 100>;
> +				interrupt-parent = <&PIC>;
> +				interrupts = <b 8>;
> +				fsl,cpm-command = <2e600000>;
> +			};
> +		};
> +
> +		PIC: interrupt-controller@10c00 {
> +			#interrupt-cells = <2>;
> +			interrupt-controller;
> +			reg = <10c00 80>;
> +			compatible = "fsl,mpc8248-pic", "fsl,pq2-pic";
> +		};
> +	};
> +};

- k
