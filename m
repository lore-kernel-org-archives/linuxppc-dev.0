Return-Path: <glikely@secretlab.ca>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.237])
	by ozlabs.org (Postfix) with ESMTP id BCEA3DDF13
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Jun 2008 16:12:34 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id d8so2688671qbc.37
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 23:12:33 -0700 (PDT)
Date: Sun, 29 Jun 2008 00:12:30 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: John Rigby <jrigby@freescale.com>
Subject: Re: [Resend][PATCH 1/8][Version 2] MPC5121 Update MPC5121ADS
	device tree
Message-ID: <20080629061230.GK13876@secretlab.ca>
References: <20080625203051.4FE882F123B@rumpole.eng.lineo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080625203051.4FE882F123B@rumpole.eng.lineo.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 18, 2008 at 02:24:46PM -0600, John Rigby wrote:
> Updated device tree for MPC5121ADS

Really should be more detailed in the commit message.

> 
> Signed-off-by: John Rigby <jrigby@freescale.com>
> ---
>  arch/powerpc/boot/dts/mpc5121ads.dts |  309 ++++++++++++++++++++++++++++++++-
>  1 files changed, 299 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/mpc5121ads.dts b/arch/powerpc/boot/dts/mpc5121ads.dts
> index 94ad7b2..67dc920 100644
> --- a/arch/powerpc/boot/dts/mpc5121ads.dts
> +++ b/arch/powerpc/boot/dts/mpc5121ads.dts
> @@ -1,7 +1,7 @@
>  /*
> - * MPC5121E MDS Device Tree Source
> + * MPC5121E ADS Device Tree Source
>   *
> - * Copyright 2007 Freescale Semiconductor Inc.
> + * Copyright 2007,2008 Freescale Semiconductor Inc.
>   *
>   * This program is free software; you can redistribute  it and/or modify it
>   * under  the terms of  the GNU General  Public License as published by the
> @@ -17,6 +17,10 @@
>  	#address-cells = <1>;
>  	#size-cells = <1>;
>  
> +	aliases {
> +		pci = &pci;
> +	};
> +
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> @@ -39,6 +43,39 @@
>  		reg = <0x00000000 0x10000000>;	// 256MB at 0
>  	};
>  
> +	mbx@20000000 {
> +		compatible = "fsl,mpc5121-mbx";
> +		reg = <0x20000000 0x4000>;
> +		interrupts = <66 0x8>;
> +		interrupt-parent = < &ipic >;
> +	};
> +
> +	sram@30000000 {
> +		compatible = "fsl,mpc5121-sram";
> +		reg = <0x30000000 0x20000>;		// 128K at 0x30000000
> +	};
> +
> +	nfc@40000000 {
> +		compatible = "fsl,mpc5121-nfc";
> +		reg = <0x40000000 0x100000>;	// 1M at 0x40000000
> +		interrupts = <6 8>;
> +		interrupt-parent = < &ipic >;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		bank-width = <1>;
> +		// ADS has two Hynix 512MB Nand flash chips in a single
> +		// stacked package .
> +		chips = <2>;
> +		nand0@0 {
> +			label = "nand0";
> +			reg = <0x00000000 0x02000000>; 	// first 32 MB of chip 0
> +		};
> +		nand1@20000000 {
> +			label = "nand1";
> +			reg = <0x20000000 0x02000000>; 	// first 32 MB of chip 1
> +		};
> +	};
> +
>  	localbus@80000020 {
>  		compatible = "fsl,mpc5121ads-localbus";
>  		#address-cells = <2>;
> @@ -51,18 +88,56 @@
>  		flash@0,0 {
>  			compatible = "cfi-flash";
>  			reg = <0 0x0 0x4000000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
>  			bank-width = <4>;
> -			device-width = <1>;
> +			device-width = <2>;
> +			protected@0 {
> +				label = "protected";
> +				reg = <0x00000000 0x00040000>;  // first sector is protected
> +				read-only;
> +			};
> +			filesystem@40000 {
> +				label = "filesystem";
> +				reg = <0x00040000 0x03c00000>;  // 60M for filesystem
> +			};
> +			kernel@3c40000 {
> +				label = "kernel";
> +				reg = <0x03c40000 0x00280000>;  // 2.5M for kernel
> +			};
> +			device-tree@3ec0000 {
> +				label = "device-tree";
> +				reg = <0x03ec0000 0x00040000>;  // one sector for device tree
> +			};
> +			u-boot@3f00000 {
> +				label = "u-boot";
> +				reg = <0x03f00000 0x00100000>;  // 1M for u-boot
> +				read-only;
> +			};
>  		};
>  
>  		board-control@2,0 {
>  			compatible = "fsl,mpc5121ads-cpld";
>  			reg = <0x2 0x0 0x8000>;
>  		};
> +
> +		cpld_pic: pic@2,a {
> +			compatible = "fsl,mpc5121ads-cpld-pic";
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			reg = <0x2 0xa 0x5>;
> +			interrupt-parent = < &ipic >;
> +			// irq routing
> +			//	all irqs but touch screen are routed to irq0 (ipic 48)
> +			//	touch screen is statically routed to irq1 (ipic 17)
> +			//	so don't use it here
> +			interrupts = <48 0x8>;
> +		};
>  	};
>  
>  	soc@80000000 {
>  		compatible = "fsl,mpc5121-immr";
> +		device_type = "soc";

Don't do this.  I know it exists on older board ports, but it is bad
practice.  Depend entirely on the compatible value instead.

>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		#interrupt-cells = <2>;
> @@ -85,38 +160,252 @@
>  			reg = <0xc00 0x100>;
>  		};
>  
> -		// 512x PSCs are not 52xx PSCs compatible
> +		rtc@a00 {	// Real time clock
> +			compatible = "fsl,mpc5121-rtc";
> +			reg = <0xa00 0x100>;
> +			interrupts = <79 0x8 80 0x8>;
> +			interrupt-parent = < &ipic >;
> +		};
> +
> +		clock@f00 {	// Clock control
> +			compatible = "fsl,mpc5121-clock";
> +			reg = <0xf00 0x100>;
> +		};
> +
> +		pmc@1000{  //Power Management Controller
> +			compatible = "fsl,mpc5121-pmc";
> +			reg = <0x1000 0x100>;
> +			interrupts = <83 0x2>;
> +			interrupt-parent = < &ipic >;
> +		};
> +
> +		gpio@1100 {
> +			compatible = "fsl,mpc5121-gpio";
> +			reg = <0x1100 0x100>;
> +			interrupts = <78 0x8>;
> +			interrupt-parent = < &ipic >;
> +		};
> +
> +		mscan@1300 {
> +			compatible = "fsl,mpc5121-mscan";
> +			cell-index = <0>;
> +			interrupts = <12 0x8>;
> +			interrupt-parent = < &ipic >;
> +			reg = <0x1300 0x80>;
> +		};
> +
> +		mscan@1380 {
> +			compatible = "fsl,mpc5121-mscan";
> +			cell-index = <1>;
> +			interrupts = <13 0x8>;
> +			interrupt-parent = < &ipic >;
> +			reg = <0x1380 0x80>;
> +		};
> +
> +		i2c@1700 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "fsl-i2c";

should be 'compatible = "fsl,mpc5121-i2c", "fsl-i2c";' for completeness.
Ditto through the rest of the i2c nodes.

> +			cell-index = <0>;
> +			reg = <0x1700 0x20>;
> +			interrupts = <9 0x8>;
> +			interrupt-parent = < &ipic >;
> +			fsl5200-clocking;
> +		};
> +
> +		i2c@1720 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "fsl-i2c";
> +			cell-index = <1>;
> +			reg = <0x1720 0x20>;
> +			interrupts = <10 0x8>;
> +			interrupt-parent = < &ipic >;
> +			fsl5200-clocking;
> +		};
> +
> +		i2c@1740 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "fsl-i2c";
> +			cell-index = <2>;
> +			reg = <0x1740 0x20>;
> +			interrupts = <11 0x8>;
> +			interrupt-parent = < &ipic >;
> +			fsl5200-clocking;
> +		};
> +
> +		i2ccontrol@1760 {
> +			compatible = "fsl,mpc5121-i2c-ctrl";
> +			reg = <0x1760 0x8>;
> +		};
> +
> +		axe@2000 {
> +			compatible = "fsl,mpc5121-axe";
> +			reg = <0x2000 0x100>;
> +			interrupts = <42 0x8>;
> +			interrupt-parent = < &ipic >;
> +		};
> +
> +		display@2100 {
> +			compatible = "fsl-diu";

should be 'compatible = "fsl,mpc5121-diu", "fsl-diu".

Actually, I don't like "fsl-diu" at all and I'd rather see it gone
entirely, but that is a separate battle.

> +			reg = <0x2100 0x100>;
> +			interrupts = <64 0x8>;
> +			interrupt-parent = < &ipic >;
> +		};
> +
> +		mdio@2800 {
> +			compatible = "fsl,mpc5121-fec-mdio";
> +			reg = <0x2800 0x800>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			phy: ethernet-phy@0 {
> +				reg = <1>;
> +				device_type = "ethernet-phy";
> +			};
> +		};
> +
> +		ethernet@2800 {
> +			device_type = "network";
> +			compatible = "fsl,mpc5121-fec";
> +			reg = <0x2800 0x800>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			interrupts = <4 0x8>;
> +			interrupt-parent = < &ipic >;
> +			phy-handle = < &phy >;
> +			fsl,align-tx-packets = <4>;
> +		};
> +
> +		// 5121e has two dr usb modules
> +		// mpc5121_ads only uses USB0
> +
> +		// USB1 using external ULPI PHY
> +		//usb@3000 {
> +		//	compatible = "fsl-usb2-dr";

I know it is commented out, but same comment applies.

> +		//	reg = <0x3000 0x1000>;
> +		//	#address-cells = <1>;
> +		//	#size-cells = <0>;
> +		//	interrupt-parent = < &ipic >;
> +		//	interrupts = <43 0x8>;
> +		//	dr_mode = "otg";
> +		//	phy_type = "ulpi";
> +		//	port1;
> +		//};
> +
> +		// USB0 using internal UTMI PHY
> +		usb@4000 {
> +			compatible = "fsl-usb2-dr";

ditto

> +			reg = <0x4000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupt-parent = < &ipic >;
> +			interrupts = <44 0x8>;
> +			dr_mode = "otg";
> +			phy_type = "utmi_wide";
> +			port0;
> +		};
> +
> +		// IO control
> +		ioctl@a000 {
> +			compatible = "fsl,mpc5121-ioctl";
> +			reg = <0xA000 0x1000>;
> +		};
> +
> +		pata@10200 {
> +			compatible = "fsl,mpc5121-pata";
> +			reg = <0x10200 0x100>;
> +			interrupts = <5 0x8>;
> +			interrupt-parent = < &ipic >;
> +		};
> +
> +		// 512x PSCs are not 52xx PSC compatible
>  		// PSC3 serial port A aka ttyPSC0
>  		serial@11300 {
>  			device_type = "serial";
> -			compatible = "fsl,mpc5121-psc-uart";
> +			compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";

I'm not sure about this, it kind of mixes usages.  But on the other
hand, it gracefully solves the problem of identifying all PSCs,
regardless of the mode....  it doesn't break any major conventions, so
yeah; this is probably good.

g.
