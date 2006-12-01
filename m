Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 90D6267BEE
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Dec 2006 05:51:36 +1100 (EST)
In-Reply-To: <Pine.LNX.4.61.0612011153500.15004@ld0175-tx32.am.freescale.net>
References: <Pine.LNX.4.61.0612011153500.15004@ld0175-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B9050CFE-9237-4024-9B1A-6940339FD0F1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2.6.20] powerpc: Changed gianfar device tree definition to
	make it more flexible
Date: Fri, 1 Dec 2006 12:52:27 -0600
To: Andy Fleming <afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[snip]

> +  Optional properties (features):
> +    - gigabit : Indicates support for 1000 Mbit operation
> +    - coalescing : Indicates support for interrupt coalescing
> +    - rmon : Indicates support for RMON-style counters
> +    - checksumming : Indicates support for hardware TCP/UDP  
> checksumming
> +    - vlan-insertion : Indicates support for hardware vlan header  
> insertion
> +    - extended-hash : Indicates support for using the Individual
> +        Address Hash registers to extend the Group Address Hash  
> registers
> +    - padding : Indicates support for padding between the FCB and
> +        the frame
> +    - filer : Indicates support for the Filer
> +    - parseL2 : Indicates support for parsing L2 headers
> +    - parseL3 : Indicates support for parsing L3 headers
> +    - parseL4 : Indicates support for parsing L4 headers

I'm still think that filer, parseL2, parseL3, parseL4 should be  
folded into one attribute. Unless there are plans for version that  
only do some subset.

> +    - multi-queue : Indicates support for sending and receiving

We may want to split this into multi-queue = 4 or something to spec  
how many.  Also you may want to split this into tx-multi-queue and rx- 
multi-queue.  I can for see have non-equal numbers for them.

> +      into multiple queues
> +    - buffer-stashing : Controller can allocate buffers into L2
> +    - buffer-locking : Controller can lock buffers into L2
> +    - bd-stashing : Controller can allocate descriptors into L2
> +    - bd-locking : Controller can lock descriptors into L2
> +


Also

> +    The "eTSEC" model implements all of these, except for the
> +    buffer-locking and bd-locking features.  The "TSEC" model
> +    implements only the first three, and all of the
> +    stashing/locking features.  The "FEC" only supports the
> +    stashing and locking features.
> +
> +
>    Example:
>
>  	ethernet@24000 {
>  		#size-cells = <0>;
>  		device_type = "network";
>  		model = "TSEC";
> +		gigabit;
> +		coalescing;
> +		rmon;
> +		buffer-stashing;
> +		buffer-locking;
> +		bd-stashing;
> +		bd-locking;
>  		compatible = "gianfar";
>  		reg = <24000 1000>;
>  		mac-address = [ 00 E0 0C 00 73 00 ];
> @@ -1238,6 +1274,7 @@ platforms are moved over to use the flat
>      - reg : The ID number for the phy, usually a small integer
>      - linux,phandle :  phandle for this node; likely referenced by an
>        ethernet controller node.
> +    - flags : PHY-specific flags (defined by the device driver)
>
>
>     Example:
> @@ -1246,6 +1283,7 @@ platforms are moved over to use the flat
>  		linux,phandle = <2452000>
>  		interrupt-parent = <40000>;
>  		interrupts = <35 1>;
> +		flags = <0>;
>  		reg = <0>;
>  		device_type = "ethernet-phy";
>  	};
> diff --git a/arch/powerpc/boot/dts/mpc8349emds.dts b/arch/powerpc/ 
> boot/dts/mpc8349emds.dts
> index efceb34..ac1ad6b 100644
> --- a/arch/powerpc/boot/dts/mpc8349emds.dts
> +++ b/arch/powerpc/boot/dts/mpc8349emds.dts
> @@ -117,6 +117,7 @@
>  				linux,phandle = <2452000>;
>  				interrupt-parent = <700>;
>  				interrupts = <11 2>;
> +				flags = <0>;
>  				reg = <0>;
>  				device_type = "ethernet-phy";
>  			};
> @@ -124,6 +125,7 @@
>  				linux,phandle = <2452001>;
>  				interrupt-parent = <700>;
>  				interrupts = <12 2>;
> +				flags = <0>;
>  				reg = <1>;
>  				device_type = "ethernet-phy";
>  			};
> @@ -132,10 +134,13 @@
>  		ethernet@24000 {
>  			device_type = "network";
>  			model = "TSEC";
> +			gigabit;
> +			coalescing;
> +			rmon;
>  			compatible = "gianfar";
>  			reg = <24000 1000>;
> -			address = [ 00 00 00 00 00 00 ];
>  			local-mac-address = [ 00 00 00 00 00 00 ];
> +			address = [ 00 00 00 00 00 00 ];
>  			interrupts = <20 8 21 8 22 8>;
>  			interrupt-parent = <700>;
>  			phy-handle = <2452000>;
> @@ -146,10 +151,13 @@
>  			#size-cells = <0>;
>  			device_type = "network";
>  			model = "TSEC";
> +			gigabit;
> +			coalescing;
> +			rmon;
>  			compatible = "gianfar";
>  			reg = <25000 1000>;
> -			address = [ 00 00 00 00 00 00 ];
>  			local-mac-address = [ 00 00 00 00 00 00 ];
> +			address = [ 00 00 00 00 00 00 ];
>  			interrupts = <23 8 24 8 25 8>;
>  			interrupt-parent = <700>;
>  			phy-handle = <2452001>;
> diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/ 
> boot/dts/mpc8349emitx.dts
> index 27807fc..c8b2fe5 100644
> --- a/arch/powerpc/boot/dts/mpc8349emitx.dts
> +++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
> @@ -116,6 +116,7 @@
>  				linux,phandle = <245201c>;
>  				interrupt-parent = <700>;
>  				interrupts = <12 2>;
> +				flags = <0>;
>  				reg = <1c>;
>  				device_type = "ethernet-phy";
>  			};
> @@ -125,6 +126,7 @@
>  				linux,phandle = <245201f>;
>  				interrupt-parent = <700>;
>  				interrupts = <12 2>;
> +				flags = <0>;
>  				reg = <1f>;
>  				device_type = "ethernet-phy";
>  			};
> @@ -133,10 +135,13 @@
>  		ethernet@24000 {
>  			device_type = "network";
>  			model = "TSEC";
> +			gigabit;
> +			coalescing;
> +			rmon;
>  			compatible = "gianfar";
>  			reg = <24000 1000>;
> -			address = [ 00 00 00 00 00 00 ];
>  			local-mac-address = [ 00 00 00 00 00 00 ];
> +			address = [ 00 00 00 00 00 00 ];
>  			interrupts = <20 8 21 8 22 8>;
>  			interrupt-parent = <700>;
>  			phy-handle = <245201c>;
> @@ -147,6 +152,9 @@
>  			#size-cells = <0>;
>  			device_type = "network";
>  			model = "TSEC";
> +			gigabit;
> +			coalescing;
> +			rmon;
>  			compatible = "gianfar";
>  			reg = <25000 1000>;
>  			address = [ 00 00 00 00 00 00 ];
> diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/ 
> boot/dts/mpc8540ads.dts
> index 5f41c1f..2ea76a1 100644
> --- a/arch/powerpc/boot/dts/mpc8540ads.dts
> +++ b/arch/powerpc/boot/dts/mpc8540ads.dts
> @@ -30,9 +30,9 @@
>  			i-cache-line-size = <20>;	// 32 bytes
>  			d-cache-size = <8000>;		// L1, 32K
>  			i-cache-size = <8000>;		// L1, 32K
> -			timebase-frequency = <0>;	//  33 MHz, from uboot
> -			bus-frequency = <0>;	// 166 MHz
> -			clock-frequency = <0>;	// 825 MHz, from uboot
> +			timebase-frequency = <0>;
> +			bus-frequency = <0>;
> +			clock-frequency = <0>;
>  			32-bit;
>  			linux,phandle = <201>;
>  		};
> @@ -73,6 +73,7 @@
>  				linux,phandle = <2452000>;
>  				interrupt-parent = <40000>;
>  				interrupts = <35 1>;
> +				flags = <0>;
>  				reg = <0>;
>  				device_type = "ethernet-phy";
>  			};
> @@ -80,6 +81,7 @@
>  				linux,phandle = <2452001>;
>  				interrupt-parent = <40000>;
>  				interrupts = <35 1>;
> +				flags = <0>;
>  				reg = <1>;
>  				device_type = "ethernet-phy";
>  			};
> @@ -87,6 +89,7 @@
>  				linux,phandle = <2452003>;
>  				interrupt-parent = <40000>;
>  				interrupts = <37 1>;
> +				flags = <0>;
>  				reg = <3>;
>  				device_type = "ethernet-phy";
>  			};
> @@ -97,10 +100,17 @@
>  			#size-cells = <0>;
>  			device_type = "network";
>  			model = "TSEC";
> +			gigabit;
> +			coalescing;
> +			rmon;
> +			buffer-stashing;
> +			buffer-locking;
> +			bd-stashing;
> +			bd-locking;
>  			compatible = "gianfar";
>  			reg = <24000 1000>;
> -			address = [ 00 E0 0C 00 73 00 ];
> -			local-mac-address = [ 00 E0 0C 00 73 00 ];
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			mac-address = [ 00 00 00 00 00 00 ];
>  			interrupts = <d 2 e 2 12 2>;
>  			interrupt-parent = <40000>;
>  			phy-handle = <2452000>;
> @@ -111,10 +121,17 @@
>  			#size-cells = <0>;
>  			device_type = "network";
>  			model = "TSEC";
> +			gigabit;
> +			coalescing;
> +			rmon;
> +			buffer-stashing;
> +			buffer-locking;
> +			bd-stashing;
> +			bd-locking;
>  			compatible = "gianfar";
>  			reg = <25000 1000>;
> -			address = [ 00 E0 0C 00 73 01 ];
> -			local-mac-address = [ 00 E0 0C 00 73 01 ];
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			mac-address = [ 00 00 00 00 00 00 ];
>  			interrupts = <13 2 14 2 18 2>;
>  			interrupt-parent = <40000>;
>  			phy-handle = <2452001>;
> @@ -125,10 +142,14 @@
>  			#size-cells = <0>;
>  			device_type = "network";
>  			model = "FEC";
> +			buffer-stashing;
> +			buffer-locking;
> +			bd-stashing;
> +			bd-locking;
>  			compatible = "gianfar";
>  			reg = <26000 1000>;
> -			address = [ 00 E0 0C 00 73 02 ];
> -			local-mac-address = [ 00 E0 0C 00 73 02 ];
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			mac-address = [ 00 00 00 00 00 00 ];
>  			interrupts = <19 2>;
>  			interrupt-parent = <40000>;
>  			phy-handle = <2452003>;
> diff --git a/arch/powerpc/boot/dts/mpc8541cds.dts b/arch/powerpc/ 
> boot/dts/mpc8541cds.dts
> index 7be0bc6..240182b 100644
> --- a/arch/powerpc/boot/dts/mpc8541cds.dts
> +++ b/arch/powerpc/boot/dts/mpc8541cds.dts
> @@ -30,9 +30,9 @@
>  			i-cache-line-size = <20>;	// 32 bytes
>  			d-cache-size = <8000>;		// L1, 32K
>  			i-cache-size = <8000>;		// L1, 32K
> -			timebase-frequency = <0>;	//  33 MHz, from uboot
> -			bus-frequency = <0>;	// 166 MHz
> -			clock-frequency = <0>;	// 825 MHz, from uboot
> +			timebase-frequency = <0>;
> +			bus-frequency = <0>;
> +			clock-frequency = <0>;
>  			32-bit;
>  			linux,phandle = <201>;
>  		};
> @@ -73,6 +73,7 @@
>  				linux,phandle = <2452000>;
>  				interrupt-parent = <40000>;
>  				interrupts = <35 0>;
> +				flags = <0>;
>  				reg = <0>;
>  				device_type = "ethernet-phy";
>  			};
> @@ -80,6 +81,7 @@
>  				linux,phandle = <2452001>;
>  				interrupt-parent = <40000>;
>  				interrupts = <35 0>;
> +				flags = <0>;
>  				reg = <1>;
>  				device_type = "ethernet-phy";
>  			};
> @@ -90,9 +92,17 @@
>  			#size-cells = <0>;
>  			device_type = "network";
>  			model = "TSEC";
> +			gigabit;
> +			coalescing;
> +			rmon;
> +			buffer-stashing;
> +			buffer-locking;
> +			bd-stashing;
> +			bd-locking;
>  			compatible = "gianfar";
>  			reg = <24000 1000>;
> -			local-mac-address = [ 00 E0 0C 00 73 00 ];
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			mac-address = [ 00 00 00 00 00 00 ];
>  			interrupts = <d 2 e 2 12 2>;
>  			interrupt-parent = <40000>;
>  			phy-handle = <2452000>;
> @@ -103,9 +113,17 @@
>  			#size-cells = <0>;
>  			device_type = "network";
>  			model = "TSEC";
> +			gigabit;
> +			coalescing;
> +			rmon;
> +			buffer-stashing;
> +			buffer-locking;
> +			bd-stashing;
> +			bd-locking;
>  			compatible = "gianfar";
>  			reg = <25000 1000>;
> -			local-mac-address = [ 00 E0 0C 00 73 01 ];
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			mac-address = [ 00 00 00 00 00 00 ];
>  			interrupts = <13 2 14 2 18 2>;
>  			interrupt-parent = <40000>;
>  			phy-handle = <2452001>;
> diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/ 
> boot/dts/mpc8548cds.dts
> index 893d795..859abdd 100644
> --- a/arch/powerpc/boot/dts/mpc8548cds.dts
> +++ b/arch/powerpc/boot/dts/mpc8548cds.dts
> @@ -1,5 +1,5 @@
>  /*
> - * MPC8555 CDS Device Tree Source
> + * MPC8548 CDS Device Tree Source
>   *
>   * Copyright 2006 Freescale Semiconductor Inc.
>   *
> @@ -30,9 +30,9 @@
>  			i-cache-line-size = <20>;	// 32 bytes
>  			d-cache-size = <8000>;		// L1, 32K
>  			i-cache-size = <8000>;		// L1, 32K
> -			timebase-frequency = <0>;	//  33 MHz, from uboot
> -			bus-frequency = <0>;	// 166 MHz
> -			clock-frequency = <0>;	// 825 MHz, from uboot
> +			timebase-frequency = <0>;
> +			bus-frequency = <0>;
> +			clock-frequency = <0>;
>  			32-bit;
>  			linux,phandle = <201>;
>  		};
> @@ -73,6 +73,7 @@
>  				linux,phandle = <2452000>;
>  				interrupt-parent = <40000>;
>  				interrupts = <35 0>;
> +				flags = <0>;
>  				reg = <0>;
>  				device_type = "ethernet-phy";
>  			};
> @@ -80,6 +81,7 @@
>  				linux,phandle = <2452001>;
>  				interrupt-parent = <40000>;
>  				interrupts = <35 0>;
> +				flags = <0>;
>  				reg = <1>;
>  				device_type = "ethernet-phy";
>  			};
> @@ -88,6 +90,7 @@
>  				linux,phandle = <2452002>;
>  				interrupt-parent = <40000>;
>  				interrupts = <35 0>;
> +				flags = <0>;
>  				reg = <2>;
>  				device_type = "ethernet-phy";
>  			};
> @@ -95,6 +98,7 @@
>  				linux,phandle = <2452003>;
>  				interrupt-parent = <40000>;
>  				interrupts = <35 0>;
> +				flags = <0>;
>  				reg = <3>;
>  				device_type = "ethernet-phy";
>  			};
> @@ -105,9 +109,24 @@
>  			#size-cells = <0>;
>  			device_type = "network";
>  			model = "eTSEC";
> +			gigabit;
> +			coalescing;
> +			rmon;
> +			checksumming;
> +			vlan;
> +			extended-hash;
> +			padding;
> +			filer;
> +			parseL4;
> +			parseL3;
> +			parseL2;
> +			multi-queue;
> +			buffer-stashing;
> +			bd-stashing;
>  			compatible = "gianfar";
>  			reg = <24000 1000>;
> -			local-mac-address = [ 00 E0 0C 00 73 00 ];
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			mac-address = [ 00 00 00 00 00 00 ];
>  			interrupts = <d 2 e 2 12 2>;
>  			interrupt-parent = <40000>;
>  			phy-handle = <2452000>;
> @@ -118,41 +137,86 @@
>  			#size-cells = <0>;
>  			device_type = "network";
>  			model = "eTSEC";
> +			gigabit;
> +			coalescing;
> +			rmon;
> +			checksumming;
> +			vlan;
> +			extended-hash;
> +			padding;
> +			filer;
> +			parseL4;
> +			parseL3;
> +			parseL2;
> +			multi-queue;
> +			buffer-stashing;
> +			bd-stashing;
>  			compatible = "gianfar";
>  			reg = <25000 1000>;
> -			local-mac-address = [ 00 E0 0C 00 73 01 ];
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			mac-address = [ 00 00 00 00 00 00 ];
>  			interrupts = <13 2 14 2 18 2>;
>  			interrupt-parent = <40000>;
>  			phy-handle = <2452001>;
>  		};
> +	/* eTSEC3 and eTSEC4 don't work on older CDS boards
>
>  		ethernet@26000 {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			device_type = "network";
>  			model = "eTSEC";
> +			gigabit;
> +			coalescing;
> +			rmon;
> +			checksumming;
> +			vlan;
> +			extended-hash;
> +			padding;
> +			filer;
> +			parseL4;
> +			parseL3;
> +			parseL2;
> +			multi-queue;
> +			buffer-stashing;
> +			bd-stashing;
>  			compatible = "gianfar";
>  			reg = <26000 1000>;
> -			local-mac-address = [ 00 E0 0C 00 73 02 ];
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			mac-address = [ 00 00 00 00 00 00 ];
>  			interrupts = <f 2 10 2 11 2>;
>  			interrupt-parent = <40000>;
> -			phy-handle = <2452001>;
> +			phy-handle = <2452002>;
>  		};
>
> -/* eTSEC 4 is currently broken
>  		ethernet@27000 {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			device_type = "network";
>  			model = "eTSEC";
> +			gigabit;
> +			coalescing;
> +			rmon;
> +			checksumming;
> +			vlan;
> +			extended-hash;
> +			padding;
> +			filer;
> +			parseL4;
> +			parseL3;
> +			parseL2;
> +			multi-queue;
> +			buffer-stashing;
> +			bd-stashing;
>  			compatible = "gianfar";
>  			reg = <27000 1000>;
> -			local-mac-address = [ 00 E0 0C 00 73 03 ];
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			mac-address = [ 00 00 00 00 00 00 ];
>  			interrupts = <15 2 16 2 17 2>;
>  			interrupt-parent = <40000>;
> -			phy-handle = <2452001>;
> +			phy-handle = <2452003>;
>  		};
> - */
> +	*/
>
>  		serial@4500 {
>  			device_type = "serial";
> diff --git a/arch/powerpc/boot/dts/mpc8555cds.dts b/arch/powerpc/ 
> boot/dts/mpc8555cds.dts
> index 118f5a8..b3c0dc6 100644
> --- a/arch/powerpc/boot/dts/mpc8555cds.dts
> +++ b/arch/powerpc/boot/dts/mpc8555cds.dts
> @@ -30,9 +30,9 @@
>  			i-cache-line-size = <20>;	// 32 bytes
>  			d-cache-size = <8000>;		// L1, 32K
>  			i-cache-size = <8000>;		// L1, 32K
> -			timebase-frequency = <0>;	//  33 MHz, from uboot
> -			bus-frequency = <0>;	// 166 MHz
> -			clock-frequency = <0>;	// 825 MHz, from uboot
> +			timebase-frequency = <0>;
> +			bus-frequency = <0>;
> +			clock-frequency = <0>;
>  			32-bit;
>  			linux,phandle = <201>;
>  		};
> @@ -73,6 +73,7 @@
>  				linux,phandle = <2452000>;
>  				interrupt-parent = <40000>;
>  				interrupts = <35 0>;
> +				flags = <0>;
>  				reg = <0>;
>  				device_type = "ethernet-phy";
>  			};
> @@ -80,6 +81,7 @@
>  				linux,phandle = <2452001>;
>  				interrupt-parent = <40000>;
>  				interrupts = <35 0>;
> +				flags = <0>;
>  				reg = <1>;
>  				device_type = "ethernet-phy";
>  			};
> @@ -90,9 +92,17 @@
>  			#size-cells = <0>;
>  			device_type = "network";
>  			model = "TSEC";
> +			gigabit;
> +			coalescing;
> +			rmon;
> +			buffer-stashing;
> +			buffer-locking;
> +			bd-stashing;
> +			bd-locking;
>  			compatible = "gianfar";
>  			reg = <24000 1000>;
> -			local-mac-address = [ 00 E0 0C 00 73 00 ];
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			mac-address = [ 00 00 00 00 00 00 ];
>  			interrupts = <0d 2 0e 2 12 2>;
>  			interrupt-parent = <40000>;
>  			phy-handle = <2452000>;
> @@ -103,9 +113,17 @@
>  			#size-cells = <0>;
>  			device_type = "network";
>  			model = "TSEC";
> +			gigabit;
> +			coalescing;
> +			rmon;
> +			buffer-stashing;
> +			buffer-locking;
> +			bd-stashing;
> +			bd-locking;
>  			compatible = "gianfar";
>  			reg = <25000 1000>;
> -			local-mac-address = [ 00 E0 0C 00 73 01 ];
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			mac-address = [ 00 00 00 00 00 00 ];
>  			interrupts = <13 2 14 2 18 2>;
>  			interrupt-parent = <40000>;
>  			phy-handle = <2452001>;
> diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/ 
> boot/dts/mpc8560ads.dts
> index 2b16848..8dad554 100644
> --- a/arch/powerpc/boot/dts/mpc8560ads.dts
> +++ b/arch/powerpc/boot/dts/mpc8560ads.dts
> @@ -65,6 +65,7 @@
>  				linux,phandle = <2452000>;
>  				interrupt-parent = <40000>;
>  				interrupts = <35 1>;
> +				flags = <0>;
>  				reg = <0>;
>  				device_type = "ethernet-phy";
>  			};
> @@ -72,6 +73,7 @@
>  				linux,phandle = <2452001>;
>  				interrupt-parent = <40000>;
>  				interrupts = <35 1>;
> +				flags = <0>;
>  				reg = <1>;
>  				device_type = "ethernet-phy";
>  			};
> @@ -79,6 +81,7 @@
>  				linux,phandle = <2452002>;
>  				interrupt-parent = <40000>;
>  				interrupts = <37 1>;
> +				flags = <0>;
>  				reg = <2>;
>  				device_type = "ethernet-phy";
>  			};
> @@ -86,6 +89,7 @@
>  				linux,phandle = <2452003>;
>  				interrupt-parent = <40000>;
>  				interrupts = <37 1>;
> +				flags = <0>;
>  				reg = <3>;
>  				device_type = "ethernet-phy";
>  			};
> @@ -94,9 +98,17 @@
>  		ethernet@24000 {
>  			device_type = "network";
>  			model = "TSEC";
> +			gigabit;
> +			coalescing;
> +			rmon;
> +			buffer-stashing;
> +			buffer-locking;
> +			bd-stashing;
> +			bd-locking;
>  			compatible = "gianfar";
>  			reg = <24000 1000>;
> -			address = [ 00 00 0C 00 00 FD ];
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			mac-address = [ 00 00 00 00 00 00 ];
>  			interrupts = <d 2 e 2 12 2>;
>  			interrupt-parent = <40000>;
>  			phy-handle = <2452000>;
> @@ -107,9 +119,17 @@
>  			#size-cells = <0>;
>  			device_type = "network";
>  			model = "TSEC";
> +			gigabit;
> +			coalescing;
> +			rmon;
> +			buffer-stashing;
> +			buffer-locking;
> +			bd-stashing;
> +			bd-locking;
>  			compatible = "gianfar";
>  			reg = <25000 1000>;
> -			address = [ 00 00 0C 00 01 FD ];
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			mac-address = [ 00 00 00 00 00 00 ];
>  			interrupts = <13 2 14 2 18 2>;
>  			interrupt-parent = <40000>;
>  			phy-handle = <2452001>;
> diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/ 
> boot/dts/mpc8641_hpcn.dts
> index f0c7731..c4fda72 100644
> --- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> +++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> @@ -28,7 +28,7 @@
>  			i-cache-line-size = <20>;	// 32 bytes
>  			d-cache-size = <8000>;		// L1, 32K
>  			i-cache-size = <8000>;		// L1, 32K
> -			timebase-frequency = <0>;	// 33 MHz, from uboot
> +			timebase-frequency = <0>;	// from uboot
>  			bus-frequency = <0>;		// From uboot
>  			clock-frequency = <0>;		// From uboot
>  			32-bit;
> @@ -91,6 +91,7 @@
>  				linux,phandle = <2452000>;
>  				interrupt-parent = <40000>;
>  				interrupts = <4a 1>;
> +				flags = <0>;
>  				reg = <0>;
>  				device_type = "ethernet-phy";
>  			};
> @@ -98,6 +99,7 @@
>  				linux,phandle = <2452001>;
>  				interrupt-parent = <40000>;
>  				interrupts = <4a 1>;
> +				flags = <0>;
>  				reg = <1>;
>  				device_type = "ethernet-phy";
>  			};
> @@ -105,6 +107,7 @@
>  				linux,phandle = <2452002>;
>  				interrupt-parent = <40000>;
>  				interrupts = <4a 1>;
> +				flags = <0>;
>  				reg = <2>;
>  				device_type = "ethernet-phy";
>  			};
> @@ -112,6 +115,7 @@
>  				linux,phandle = <2452003>;
>  				interrupt-parent = <40000>;
>  				interrupts = <4a 1>;
> +				flags = <0>;
>  				reg = <3>;
>  				device_type = "ethernet-phy";
>  			};
> @@ -121,10 +125,24 @@
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			device_type = "network";
> -			model = "TSEC";
> +			model = "eTSEC";
> +			gigabit;
> +			coalescing;
> +			rmon;
> +			vlan;
> +			extended-hash;
> +			padding;
> +			filer;
> +			parseL4;
> +			parseL3;
> +			parseL2;
> +			multi-queue;
> +			buffer-stashing;
> +			bd-stashing;
>  			compatible = "gianfar";
>  			reg = <24000 1000>;
> -			mac-address = [ 00 E0 0C 00 73 00 ];
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			mac-address = [ 00 00 00 00 00 00 ];
>  			interrupts = <1d 2 1e 2 22 2>;
>  			interrupt-parent = <40000>;
>  			phy-handle = <2452000>;
> @@ -134,10 +152,24 @@
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			device_type = "network";
> -			model = "TSEC";
> +			model = "eTSEC";
> +			gigabit;
> +			coalescing;
> +			rmon;
> +			vlan;
> +			extended-hash;
> +			padding;
> +			filer;
> +			parseL4;
> +			parseL3;
> +			parseL2;
> +			multi-queue;
> +			buffer-stashing;
> +			bd-stashing;
>  			compatible = "gianfar";
>  			reg = <25000 1000>;
> -			mac-address = [ 00 E0 0C 00 73 01 ];
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			mac-address = [ 00 00 00 00 00 00 ];
>  			interrupts = <23 2 24 2 28 2>;
>  			interrupt-parent = <40000>;
>  			phy-handle = <2452001>;
> @@ -147,10 +179,24 @@
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			device_type = "network";
> -			model = "TSEC";
> +			model = "eTSEC";
> +			gigabit;
> +			coalescing;
> +			rmon;
> +			vlan;
> +			extended-hash;
> +			padding;
> +			filer;
> +			parseL4;
> +			parseL3;
> +			parseL2;
> +			multi-queue;
> +			buffer-stashing;
> +			bd-stashing;
>  			compatible = "gianfar";
>  			reg = <26000 1000>;
> -			mac-address = [ 00 E0 0C 00 02 FD ];
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			mac-address = [ 00 00 00 00 00 00 ];
>  			interrupts = <1F 2 20 2 21 2>;
>  			interrupt-parent = <40000>;
>  			phy-handle = <2452002>;
> @@ -160,10 +206,24 @@
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			device_type = "network";
> -			model = "TSEC";
> +			model = "eTSEC";
> +			gigabit;
> +			coalescing;
> +			rmon;
> +			vlan;
> +			extended-hash;
> +			padding;
> +			filer;
> +			parseL4;
> +			parseL3;
> +			parseL2;
> +			multi-queue;
> +			buffer-stashing;
> +			bd-stashing;
>  			compatible = "gianfar";
>  			reg = <27000 1000>;
> -			mac-address = [ 00 E0 0C 00 03 FD ];
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			mac-address = [ 00 00 00 00 00 00 ];
>  			interrupts = <25 2 26 2 27 2>;
>  			interrupt-parent = <40000>;
>  			phy-handle = <2452003>;
> diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/ 
> fsl_soc.c
> index ad31e56..57a1a2a 100644
> --- a/arch/powerpc/sysdev/fsl_soc.c
> +++ b/arch/powerpc/sysdev/fsl_soc.c
> @@ -6,6 +6,9 @@
>   * 2006 (c) MontaVista Software, Inc.
>   * Vitaly Bordug <vbordug@ru.mvista.com>
>   *
> + * 2006 (c) Freescale Semiconductor, Inc
> + * Andy Fleming
> + *
>   * This program is free software; you can redistribute  it and/or  
> modify it
>   * under  the terms of  the GNU General  Public License as  
> published by the
>   * Free Software Foundation;  either version 2 of the  License, or  
> (at your
> @@ -178,58 +181,162 @@ static const char *gfar_tx_intr = "tx";
>  static const char *gfar_rx_intr = "rx";
>  static const char *gfar_err_intr = "error";
>
> +struct gfar_flag_info {
> +	const char *name;
> +	u32 flags;
> +};
> +
> +static struct gfar_flag_info __initdata flag_info[] = {
> +	{ "gigabit", FSL_GIANFAR_DEV_HAS_GIGABIT },
> +	{ "coalescing", FSL_GIANFAR_DEV_HAS_COALESCE },
> +	{ "rmon", FSL_GIANFAR_DEV_HAS_RMON },
> +	{ "checksumming", FSL_GIANFAR_DEV_HAS_CSUM },
> +	{ "vlan", FSL_GIANFAR_DEV_HAS_VLAN },
> +	{ "extended-hash", FSL_GIANFAR_DEV_HAS_EXTENDED_HASH },
> +	{ "padding", FSL_GIANFAR_DEV_HAS_PADDING },
> +	{ "filer", FSL_GIANFAR_DEV_HAS_FILER },
> +	{ "parseL4", FSL_GIANFAR_DEV_HAS_PARSE_L4 },
> +	{ "parseL3", FSL_GIANFAR_DEV_HAS_PARSE_L3 },
> +	{ "parseL2", FSL_GIANFAR_DEV_HAS_PARSE_L2 },
> +	{ "multi-queue", FSL_GIANFAR_DEV_HAS_MULTI_QUEUE },
> +	{ "buffer-stashing", FSL_GIANFAR_DEV_HAS_BUF_STASHING },
> +	{ "buffer-locking", FSL_GIANFAR_DEV_HAS_BUF_LOCKING },
> +	{ "bd-stashing", FSL_GIANFAR_DEV_HAS_BD_STASHING },
> +	{ "bd-locking", FSL_GIANFAR_DEV_HAS_BD_LOCKING },
> +};
> +
> +/* Returns a bitfield with the appropriate flasgs set,
> + * based on the device tree */
> +static int __init gfar_get_flags(struct device_node *np)
> +{
> +	int idx;
> +	int device_flags = 0;
> +
> +	for (idx = 0; idx < ARRAY_SIZE(flag_info); idx++)
> +		if (get_property(np, flag_info[idx].name, NULL) != NULL)
> +			device_flags |= flag_info[idx].flags;
> +
> +	return device_flags;
> +}
> +
> +static struct device_node * __init gfar_get_phy_node(struct  
> device_node *np)
> +{
> +	const phandle *ph;
> +	struct device_node *phy;
> +
> +	ph = get_property(np, "phy-handle", NULL);
> +	if (ph == NULL)
> +		return NULL;
> +
> +	phy = of_find_node_by_phandle(*ph);
> +
> +	return phy;
> +}
> +
> +/* Set the phy_id field of gfar_data to the address of the PHY
> + * Set the bus_id field of gfar_data to the memory address of the  
> mdio bus
> + * Set the phy_flags field of gfar_data to passed in values
> + *
> + * returns 0 on success
> + */
> +static int __init gfar_set_phy_info(struct device_node *np,
> +		int *phy_id, int *bus_id, int *phy_flags)
> +{
> +	struct resource res;
> +	struct device_node *phy;
> +	struct device_node *mdio;
> +	const unsigned int *id;
> +	const unsigned int *flags;
> +	int ret;
> +
> +	phy = gfar_get_phy_node(np);
> +	if (phy == NULL)
> +		return -1;
> +
> +	/* Get the PHY address, the parent MDIO bus,
> +	 * and the phy flags, then release the phy node */
> +	id = get_property(phy, "reg", NULL);
> +	flags = get_property(phy, "flags", NULL);
> +	mdio = of_get_parent(phy);
>
> +	/* We're done with the phy node, now */
> +	of_node_put(phy);
> +
> +	/* Set the PHY address */
> +	if (id == NULL)
> +		return -1;
> +
> +	*phy_id = *id;
> +
> +	/* Set the flags */
> +	if (flags == NULL)
> +		return -1;
> +
> +	*phy_flags = *flags;
> +
> +	/* Set the bus id */
> +	if (mdio == NULL)
> +		return -1;
> +
> +	ret = of_address_to_resource(mdio, 0, &res);
> +	of_node_put(mdio);
> +	if (ret)
> +		return -1;
> +
> +	*bus_id = res.start;
> +
> +	return 0;
> +}
> +
>  static int __init gfar_of_init(void)
>  {
>  	struct device_node *np;
> -	unsigned int i;
> +	unsigned int num;
>  	struct platform_device *gfar_dev;
> -	struct resource res;
>  	int ret;
>
> -	for (np = NULL, i = 0;
> +	for (np = NULL, num = 0;
>  	     (np = of_find_compatible_node(np, "network", "gianfar")) !=  
> NULL;
> -	     i++) {
> +	     num++) {
>  		struct resource r[4];
> -		struct device_node *phy, *mdio;
>  		struct gianfar_platform_data gfar_data;
> -		const unsigned int *id;
> -		const char *model;
>  		const void *mac_addr;
> -		const phandle *ph;
> -		int n_res = 2;
> +		int n_res = 0;
>
>  		memset(r, 0, sizeof(r));
>  		memset(&gfar_data, 0, sizeof(gfar_data));
>
>  		ret = of_address_to_resource(np, 0, &r[0]);
> -		if (ret)
> -			goto err;
> +		if (ret) {
> +			printk("gfar %d's address lookup failed\n", num);
> +			continue;
> +		}
>
> -		of_irq_to_resource(np, 0, &r[1]);
> +		gfar_data.device_flags = gfar_get_flags(np);
>
> -		model = get_property(np, "model", NULL);
> +		/* Map all the irq resources, and set n_res to
> +		 * the number of irqs plus 1 (which is the total
> +		 * number of resources) */
> +		while (n_res < 4 &&
> +			of_irq_to_resource(np, n_res, &r[++n_res]) != NO_IRQ);
> +		if (n_res < 2) {
> +			printk("No interrupts found for gfar %d\n", num);
> +			continue;
> +		}
>
> -		/* If we aren't the FEC we have multiple interrupts */
> -		if (model && strcasecmp(model, "FEC")) {
> +		/* If we have 3 interrupts, name them, and set the flag */
> +		if (n_res == 4) {
>  			r[1].name = gfar_tx_intr;
> -
>  			r[2].name = gfar_rx_intr;
> -			of_irq_to_resource(np, 1, &r[2]);
> -
>  			r[3].name = gfar_err_intr;
> -			of_irq_to_resource(np, 2, &r[3]);
> -
> -			n_res += 2;
> -		}
> -
> -		gfar_dev =
> -		    platform_device_register_simple("fsl-gianfar", i, &r[0],
> -						    n_res);
>
> -		if (IS_ERR(gfar_dev)) {
> -			ret = PTR_ERR(gfar_dev);
> -			goto err;
> +			gfar_data.device_flags |=
> +				FSL_GIANFAR_DEV_HAS_MULTI_INTR;
> +		} else if (n_res != 2) {
> +			printk("gfar %d had an unexpected number"
> +					"of interrupts (%d)\n",
> +					num, n_res-1);
> +			continue;
>  		}
>
>  		mac_addr = get_property(np, "local-mac-address", NULL);
> @@ -243,60 +350,31 @@ static int __init gfar_of_init(void)
>  		if (mac_addr)
>  			memcpy(gfar_data.mac_addr, mac_addr, 6);
>
> -		if (model && !strcasecmp(model, "TSEC"))
> -			gfar_data.device_flags =
> -			    FSL_GIANFAR_DEV_HAS_GIGABIT |
> -			    FSL_GIANFAR_DEV_HAS_COALESCE |
> -			    FSL_GIANFAR_DEV_HAS_RMON |
> -			    FSL_GIANFAR_DEV_HAS_MULTI_INTR;
> -		if (model && !strcasecmp(model, "eTSEC"))
> -			gfar_data.device_flags =
> -			    FSL_GIANFAR_DEV_HAS_GIGABIT |
> -			    FSL_GIANFAR_DEV_HAS_COALESCE |
> -			    FSL_GIANFAR_DEV_HAS_RMON |
> -			    FSL_GIANFAR_DEV_HAS_MULTI_INTR |
> -			    FSL_GIANFAR_DEV_HAS_CSUM |
> -			    FSL_GIANFAR_DEV_HAS_VLAN |
> -			    FSL_GIANFAR_DEV_HAS_EXTENDED_HASH;
> +		ret = gfar_set_phy_info(np, &gfar_data.phy_id,
> +				&gfar_data.bus_id, &gfar_data.phy_flags);
> +  		if (ret) {
> +			printk("gfar %d failed to set PHY info\n", num);
> +			continue;
> +  		}
>
> -		ph = get_property(np, "phy-handle", NULL);
> -		phy = of_find_node_by_phandle(*ph);
> -
> -		if (phy == NULL) {
> -			ret = -ENODEV;
> -			goto unreg;
> +		gfar_dev = platform_device_register_simple("fsl-gianfar",
> +				num, &r[0], n_res);
> +		if (IS_ERR(gfar_dev)) {
> +			printk("Failed to register gfar %d due to error %ld\n",
> +					num, PTR_ERR(gfar_dev));
> +			continue;
>  		}
>
> -		mdio = of_get_parent(phy);
> -
> -		id = get_property(phy, "reg", NULL);
> -		ret = of_address_to_resource(mdio, 0, &res);
> +		ret = platform_device_add_data(gfar_dev, &gfar_data,
> +				sizeof(struct gianfar_platform_data));
>  		if (ret) {
> -			of_node_put(phy);
> -			of_node_put(mdio);
> -			goto unreg;
> +			printk("gfar %d data not added\n", num);
> +			platform_device_unregister(gfar_dev);
>  		}
> -
> -		gfar_data.phy_id = *id;
> -		gfar_data.bus_id = res.start;
> -
> -		of_node_put(phy);
> -		of_node_put(mdio);
> -
> -		ret =
> -		    platform_device_add_data(gfar_dev, &gfar_data,
> -					     sizeof(struct
> -						    gianfar_platform_data));
> -		if (ret)
> -			goto unreg;
>  	}
>
>  	return 0;
>
> -unreg:
> -	platform_device_unregister(gfar_dev);
> -err:
> -	return ret;
>  }
>
>  arch_initcall(gfar_of_init);
> @@ -304,13 +382,13 @@ arch_initcall(gfar_of_init);
>  static int __init fsl_i2c_of_init(void)
>  {
>  	struct device_node *np;
> -	unsigned int i;
> +	unsigned int num;
>  	struct platform_device *i2c_dev;
>  	int ret;
>
> -	for (np = NULL, i = 0;
> +	for (np = NULL, num = 0;
>  	     (np = of_find_compatible_node(np, "i2c", "fsl-i2c")) != NULL;
> -	     i++) {
> +	     num++) {
>  		struct resource r[2];
>  		struct fsl_i2c_platform_data i2c_data;
>  		const unsigned char *flags = NULL;
> @@ -319,15 +397,22 @@ static int __init fsl_i2c_of_init(void)
>  		memset(&i2c_data, 0, sizeof(i2c_data));
>
>  		ret = of_address_to_resource(np, 0, &r[0]);
> -		if (ret)
> -			goto err;
> +		if (ret) {
> +			printk("i2c %d could not map registers\n", num);
> +			continue;
> +		}
>
> -		of_irq_to_resource(np, 0, &r[1]);
> +		ret = of_irq_to_resource(np, 0, &r[1]);
> +		if (ret == NO_IRQ) {
> +			printk("i2c %d could not map irq\n", num);
> +			continue;
> +		}
>
> -		i2c_dev = platform_device_register_simple("fsl-i2c", i, r, 2);
> +		i2c_dev = platform_device_register_simple("fsl-i2c", num, r, 2);
>  		if (IS_ERR(i2c_dev)) {
> -			ret = PTR_ERR(i2c_dev);
> -			goto err;
> +			printk("Failed to register i2c %d due to error %ld\n",
> +					num, PTR_ERR(i2c_dev));
> +			continue;
>  		}
>
>  		i2c_data.device_flags = 0;
> @@ -339,20 +424,15 @@ static int __init fsl_i2c_of_init(void)
>  		if (flags)
>  			i2c_data.device_flags |= FSL_I2C_DEV_CLOCK_5200;
>
> -		ret =
> -		    platform_device_add_data(i2c_dev, &i2c_data,
> -					     sizeof(struct
> -						    fsl_i2c_platform_data));
> -		if (ret)
> -			goto unreg;
> +		ret = platform_device_add_data(i2c_dev, &i2c_data,
> +				     sizeof(struct fsl_i2c_platform_data));
> +		if (ret) {
> +			printk("i2c %d data not added\n", num);
> +			platform_device_unregister(i2c_dev);
> +		}
>  	}
>
>  	return 0;
> -
> -unreg:
> -	platform_device_unregister(i2c_dev);
> -err:
> -	return ret;
>  }
>
>  arch_initcall(fsl_i2c_of_init);
> @@ -436,41 +516,44 @@ static enum fsl_usb2_phy_modes determine
>  	return FSL_USB2_PHY_NONE;
>  }
>
> -static int __init fsl_usb_of_init(void)
> +
> +static void fsl_usb_of_init_one(struct device_node *np, unsigned  
> int num,
> +		enum fsl_usb2_operating_modes mode)
>  {
> -	struct device_node *np;
> -	unsigned int i;
> -	struct platform_device *usb_dev_mph = NULL, *usb_dev_dr = NULL;
> +	struct resource r[2];
> +	struct fsl_usb2_platform_data usb_data;
> +	const unsigned char *prop = NULL;
> +	struct platform_device *usb_dev = NULL;
>  	int ret;
>
> -	for (np = NULL, i = 0;
> -	     (np = of_find_compatible_node(np, "usb", "fsl-usb2-mph")) !=  
> NULL;
> -	     i++) {
> -		struct resource r[2];
> -		struct fsl_usb2_platform_data usb_data;
> -		const unsigned char *prop = NULL;
> -
> -		memset(&r, 0, sizeof(r));
> -		memset(&usb_data, 0, sizeof(usb_data));
> +	memset(&r, 0, sizeof(r));
> +	memset(&usb_data, 0, sizeof(usb_data));
>
> -		ret = of_address_to_resource(np, 0, &r[0]);
> -		if (ret)
> -			goto err;
> +	ret = of_address_to_resource(np, 0, &r[0]);
> +	if (ret) {
> +		printk("usb %d could not map registers\n", num);
> +		return;
> +	}
>
> -		of_irq_to_resource(np, 0, &r[1]);
> +	ret = of_irq_to_resource(np, 0, &r[1]);
> +	if (ret == NO_IRQ) {
> +		printk("usb %d could not map irq\n", num);
> +		return;
> +	}
>
> -		usb_dev_mph =
> -		    platform_device_register_simple("fsl-ehci", i, r, 2);
> -		if (IS_ERR(usb_dev_mph)) {
> -			ret = PTR_ERR(usb_dev_mph);
> -			goto err;
> -		}
> +	usb_dev = platform_device_register_simple("fsl-ehci", num, r, 2);
> +	if (IS_ERR(usb_dev)) {
> +		printk("usb %d register failed with error %ld\n",
> +				num, PTR_ERR(usb_dev));
> +		return;
> +	}
>
> -		usb_dev_mph->dev.coherent_dma_mask = 0xffffffffUL;
> -		usb_dev_mph->dev.dma_mask = &usb_dev_mph->dev.coherent_dma_mask;
> +	usb_dev->dev.coherent_dma_mask = 0xffffffffUL;
> +	usb_dev->dev.dma_mask = &usb_dev->dev.coherent_dma_mask;
>
> -		usb_data.operating_mode = FSL_USB2_MPH_HOST;
> +	usb_data.operating_mode = mode;
>
> +	if (mode == FSL_USB2_DR_HOST) {
>  		prop = get_property(np, "port0", NULL);
>  		if (prop)
>  			usb_data.port_enables |= FSL_USB2_PORT0_ENABLED;
> @@ -478,66 +561,36 @@ static int __init fsl_usb_of_init(void)
>  		prop = get_property(np, "port1", NULL);
>  		if (prop)
>  			usb_data.port_enables |= FSL_USB2_PORT1_ENABLED;
> -
> -		prop = get_property(np, "phy_type", NULL);
> -		usb_data.phy_mode = determine_usb_phy(prop);
> -
> -		ret =
> -		    platform_device_add_data(usb_dev_mph, &usb_data,
> -					     sizeof(struct
> -						    fsl_usb2_platform_data));
> -		if (ret)
> -			goto unreg_mph;
>  	}
>
> -	for (np = NULL;
> -	     (np = of_find_compatible_node(np, "usb", "fsl-usb2-dr")) !=  
> NULL;
> -	     i++) {
> -		struct resource r[2];
> -		struct fsl_usb2_platform_data usb_data;
> -		const unsigned char *prop = NULL;
> -
> -		memset(&r, 0, sizeof(r));
> -		memset(&usb_data, 0, sizeof(usb_data));
> +	prop = get_property(np, "phy_type", NULL);
> +	usb_data.phy_mode = determine_usb_phy(prop);
>
> -		ret = of_address_to_resource(np, 0, &r[0]);
> -		if (ret)
> -			goto unreg_mph;
> -
> -		of_irq_to_resource(np, 0, &r[1]);
> +	ret = platform_device_add_data(usb_dev, &usb_data,
> +			sizeof(struct fsl_usb2_platform_data));
> +	if (ret) {
> +		printk("usb %d failed to add data\n", num);
> +		platform_device_unregister(usb_dev);
> +	}
> +}
>
> -		usb_dev_dr =
> -		    platform_device_register_simple("fsl-ehci", i, r, 2);
> -		if (IS_ERR(usb_dev_dr)) {
> -			ret = PTR_ERR(usb_dev_dr);
> -			goto err;
> -		}
>
> -		usb_dev_dr->dev.coherent_dma_mask = 0xffffffffUL;
> -		usb_dev_dr->dev.dma_mask = &usb_dev_dr->dev.coherent_dma_mask;
> +static int __init fsl_usb_of_init(void)
> +{
> +	struct device_node *np;
> +	unsigned int num;
>
> -		usb_data.operating_mode = FSL_USB2_DR_HOST;
> +	for (np = NULL, num = 0;
> +	     (np = of_find_compatible_node(np, "usb", "fsl-usb2-mph")) !=  
> NULL;
> +	     num++)
> +		fsl_usb_of_init_one(np, num, FSL_USB2_MPH_HOST);
>
> -		prop = get_property(np, "phy_type", NULL);
> -		usb_data.phy_mode = determine_usb_phy(prop);
> +	for (np = NULL;
> +	     (np = of_find_compatible_node(np, "usb", "fsl-usb2-dr")) !=  
> NULL;
> +	     num++)
> +		fsl_usb_of_init_one(np, num, FSL_USB2_DR_HOST);
>
> -		ret =
> -		    platform_device_add_data(usb_dev_dr, &usb_data,
> -					     sizeof(struct
> -						    fsl_usb2_platform_data));
> -		if (ret)
> -			goto unreg_dr;
> -	}
>  	return 0;
> -
> -unreg_dr:
> -	if (usb_dev_dr)
> -		platform_device_unregister(usb_dev_dr);
> -unreg_mph:
> -	if (usb_dev_mph)
> -		platform_device_unregister(usb_dev_mph);
> -err:
> -	return ret;
>  }
>
>  arch_initcall(fsl_usb_of_init);
> @@ -587,7 +640,11 @@ static int __init fs_enet_of_init(void)
>  		r[2].name = fcc_regs_c;
>  		fs_enet_data.fcc_regs_c = r[2].start;
>
> -		of_irq_to_resource(np, 0, &r[3]);
> +		ret = of_irq_to_resource(np, 0, &r[3]);
> +		if (ret == NO_IRQ) {
> +			ret = -EINVAL;
> +			goto err;
> +		}
>
>  		fs_enet_dev =
>  		    platform_device_register_simple("fsl-cpm-fcc", i, &r[0], 4);
> @@ -749,7 +806,11 @@ static int __init cpm_uart_of_init(void)
>  			goto err;
>  		r[1].name = scc_pram;
>
> -		of_irq_to_resource(np, 0, &r[2]);
> +		ret = of_irq_to_resource(np, 0, &r[2]);
> +		if (ret == NO_IRQ) {
> +			ret = -EINVAL;
> +			goto err;
> +		}
>
>  		cpm_uart_dev =
>  		    platform_device_register_simple("fsl-cpm-scc:uart", i, &r 
> [0], 3);
> diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
> index 3da29e2..fa2c60d 100644
> --- a/include/linux/fsl_devices.h
> +++ b/include/linux/fsl_devices.h
> @@ -51,6 +51,7 @@ struct gianfar_platform_data {
>  	u32	board_flags;
>  	u32	bus_id;
>  	u32	phy_id;
> +	u32	phy_flags;
>  	u8	mac_addr[6];
>  };
>
> @@ -68,10 +69,18 @@ #define FSL_GIANFAR_DEV_HAS_CSUM		0x0000
>  #define FSL_GIANFAR_DEV_HAS_VLAN		0x00000020
>  #define FSL_GIANFAR_DEV_HAS_EXTENDED_HASH	0x00000040
>  #define FSL_GIANFAR_DEV_HAS_PADDING		0x00000080
> +#define FSL_GIANFAR_DEV_HAS_FILER		0x00000100
> +#define FSL_GIANFAR_DEV_HAS_PARSE_L2		0x00000200
> +#define FSL_GIANFAR_DEV_HAS_PARSE_L3		0x00000300
> +#define FSL_GIANFAR_DEV_HAS_PARSE_L4		0x00000400
> +#define FSL_GIANFAR_DEV_HAS_MULTI_QUEUE		0x00000800
> +#define FSL_GIANFAR_DEV_HAS_BUF_STASHING	0x00001000
> +#define FSL_GIANFAR_DEV_HAS_BUF_LOCKING		0x00002000
> +#define FSL_GIANFAR_DEV_HAS_BD_STASHING		0x00004000
> +#define FSL_GIANFAR_DEV_HAS_BD_LOCKING		0x00008000
>
>  /* Flags in gianfar_platform_data */
>  #define FSL_GIANFAR_BRD_HAS_PHY_INTR	0x00000001 /* set or use a  
> timer */
> -#define FSL_GIANFAR_BRD_IS_REDUCED	0x00000002 /* Set if RGMII,  
> RMII */
>
>  struct fsl_i2c_platform_data {
>  	/* device specific information */
> -- 
> 1.4.2.3
