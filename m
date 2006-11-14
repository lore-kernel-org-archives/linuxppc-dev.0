Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0B11C67D02
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 03:33:54 +1100 (EST)
In-Reply-To: <Pine.LNX.4.60.0611132312430.3789@poirot.grange>
References: <Pine.LNX.4.60.0611011844570.3736@poirot.grange>
	<Pine.LNX.4.60.0611051526510.4214@poirot.grange>
	<4EC85F22-99A9-4B0F-987C-25B715235320@kernel.crashing.org>
	<Pine.LNX.4.60.0611062048080.6091@poirot.grange>
	<Pine.LNX.4.60.0611132312430.3789@poirot.grange>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C14DE3DB-D490-4473-A625-CA71058A1C9E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH/RFC (take 3)] linkstation / kurobox support under
	arch/powerpc
Date: Tue, 14 Nov 2006 10:34:06 -0600
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Out of interest how are you booting this kernel build & dts on the  
linkstation/kurobox? u-boot or wrapper?

> diff --git a/arch/powerpc/boot/dts/kuroboxHG.dts b/arch/powerpc/ 
> boot/dts/kuroboxHG.dts
> new file mode 100644
> index 0000000..6c76ef6
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/kuroboxHG.dts

would make more sense if this file was called linkstation.dts to  
match the Kconfig

This patch is suppose to work on LINKSTATION, Kurobox, and  
KuroboxHG?  If so can you make it more explicit in the comments.  I  
wasn't sure what Kurobox(HG) was intended to mean.  I think just  
listing out Kurobox and KuroboxHG in the comments is fine.


> @@ -0,0 +1,173 @@
> +/*
> + * Device Tree Souce for Buffalo KuroboxHG
> + *
> + * Based on sandpoint.dts
> + *
> + * 2006 (c) G. Liakhovetski <g.liakhovetski@gmx.de>
> + *
> + * This file is licensed under
> + * the terms of the GNU General Public License version 2.  This  
> program
> + * is licensed "as is" without any warranty of any kind, whether  
> express
> + * or implied.
> +
> +XXXX add flash parts, rtc, ??
> +
> +build with: "dtc -f -I dts -O dtb -o kuroboxHG.dtb -V 16  
> kuroboxHG.dts"
> +
> +
> + */
> +
> +/ {
> +	linux,phandle = <1000>;
> +	model = "KuroboxHG";
> +	compatible = "linkstation";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	cpus {
> +		linux,phandle = <2000>;
> +		#cpus = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,603e { /* Really 8241 */
> +			linux,phandle = <2100>;
> +			linux,boot-cpu;
> +			device_type = "cpu";
> +			reg = <0>;
> +			clock-frequency = <fdad680>;	/* Fixed by bootwrapper */
> +			timebase-frequency = <1F04000>; /* Fixed by bootwrapper */
> +			bus-frequency = <0>;		/* From bootloader */
> +			/* Following required by dtc but not used */
> +			i-cache-line-size = <0>;
> +			d-cache-line-size = <0>;
> +			i-cache-size = <4000>;
> +			d-cache-size = <4000>;
> +		};
> +	};
> +
> +	memory {
> +		linux,phandle = <3000>;
> +		device_type = "memory";
> +		reg = <00000000 08000000>;
> +	};
> +
> +	soc10x { /* AFAICT need to make soc for 8245's uarts to be  
> defined */
> +		linux,phandle = <4000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		#interrupt-cells = <2>;
> +		device_type = "soc";
> +		compatible = "mpc10x";
> +		store-gathering = <0>; /* 0 == off, !0 == on */
> +		reg = <80000000 00100000>;
> +		ranges = <80000000 80000000 70000000	/* pci mem space */
> +			  fc000000 fc000000 00100000	/* EUMB */
> +			  fe000000 fe000000 00c00000	/* pci i/o space */
> +			  fec00000 fec00000 00300000	/* pci cfg regs */
> +			  fef00000 fef00000 00100000>;	/* pci iack */
> +
> +		dma@80001100 {
> +			linux,phandle = <4100>;
> +			#interrupt-cells = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			device_type = "dma";
> +			compatible = "fsl-dma";
> +			clock-frequency = <0>;
> +			reg = <80001100 24>;
> +			interrupts = <6 0>;
> +			interrupt-parent = <4400>;
> +		};
> +
> +		dma@80001200 {
> +			linux,phandle = <4200>;
> +			#interrupt-cells = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			device_type = "dma";
> +			compatible = "fsl-dma";
> +			clock-frequency = <0>;
> +			reg = <80001200 24>;
> +			interrupts = <7 0>;
> +			interrupt-parent = <4400>;
> +		};
> +

Can we drop the dma nodes?  are you using them for something.  I'd  
prefer not to specify what they look like until we figure out how to  
handle the various "features" between the families of FSL PPC's that  
share the DMA controller (10x, 824x, 83xx, 85xx)

> +		i2c@80003000 {
> +			linux,phandle = <4300>;
> +			device_type = "i2c";
> +			compatible = "fsl-i2c";
> +			clock-frequency = <0>;

Any reason for adding this clock-frequency property?

> +			reg = <80003000 1000>;
> +			interrupts = <5 2>;
> +			interrupt-parent = <4400>;
> +		};
> +
> +		serial@80004500 {
> +			linux,phandle = <4511>;
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <80004500 8>;
> +			clock-frequency = <7c044a8>;
> +			current-speed = <2580>;
> +			interrupts = <9 2>;
> +			interrupt-parent = <4400>;
> +		};
> +
> +		serial@80004600 {
> +			linux,phandle = <4512>;
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <80004600 8>;
> +			clock-frequency = <7c044a8>;
> +			current-speed = <e100>;
> +			interrupts = <a 0>;
> +			interrupt-parent = <4400>;
> +		};
> +
> +		pic@80040000 {
> +			linux,phandle = <4400>;
> +			#interrupt-cells = <2>;
> +			#address-cells = <0>;
> +			device_type = "open-pic";
> +			compatible = "chrp,open-pic";
> +			interrupt-controller;
> +			reg = <80040000 40000>;
> +			clock-frequency = <0>;		/* ??? */

Any reason for adding this clock-frequency property?


> +			built-in;
> +		};
> +
> +		pci@fec00000 {
> +			linux,phandle = <4500>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			#interrupt-cells = <1>;
> +			device_type = "pci";
> +			compatible = "mpc10x-pci";
> +			reg = <fec00000 400000>;
> +			ranges = <01000000 0        0 fe000000 0 00c00000
> +				  02000000 0 80000000 80000000 0 70000000>;
> +			bus-range = <0 ff>;
> +			clock-frequency = <7f28155>;
> +			interrupt-parent = <4400>;
> +			interrupt-map-mask = <f800 0 0 7>;
> +			interrupt-map = <
> +				/* IDSEL 0x11 - IRQ0 ETH */
> +				5800 0 0 1 4400 0 1
> +				5800 0 0 2 4400 1 1
> +				5800 0 0 3 4400 2 1
> +				5800 0 0 4 4400 3 1
> +				/* IDSEL 0x12 - IRQ1 IDE0 */
> +				6000 0 0 1 4400 1 1
> +				6000 0 0 2 4400 2 1
> +				6000 0 0 3 4400 3 1
> +				6000 0 0 4 4400 0 1
> +				/* IDSEL 0x14 - IRQ3 USB2.0 */
> +				7000 0 0 1 4400 3 1
> +				7000 0 0 2 4400 3 1
> +				7000 0 0 3 4400 3 1
> +				7000 0 0 4 4400 3 1
> +			>;
> +		};
> +	};
> +};
> diff --git a/arch/powerpc/configs/kuroboxhg_defconfig b/arch/ 
> powerpc/configs/kuroboxhg_defconfig
> new file mode 100644
> index 0000000..136632f
> --- /dev/null
> +++ b/arch/powerpc/configs/kuroboxhg_defconfig

similar file rename comment linkstation_defconfig

> @@ -0,0 +1,1577 @@
> +#
> +# Automatically generated make config: don't edit
> +# Linux kernel version: 2.6.19-rc2
> +# Wed Nov  1 16:56:07 2006
> +#
> +# CONFIG_PPC64 is not set
> +CONFIG_PPC32=y
> +CONFIG_PPC_MERGE=y
> +CONFIG_MMU=y
> +CONFIG_GENERIC_HARDIRQS=y
> +CONFIG_IRQ_PER_CPU=y
> +CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> +CONFIG_GENERIC_HWEIGHT=y
> +CONFIG_GENERIC_CALIBRATE_DELAY=y
> +CONFIG_GENERIC_FIND_NEXT_BIT=y
> +CONFIG_PPC=y
> +CONFIG_EARLY_PRINTK=y
> +CONFIG_GENERIC_NVRAM=y
> +CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
> +CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> +CONFIG_PPC_OF=y
> +CONFIG_PPC_UDBG_16550=y
> +# CONFIG_GENERIC_TBSYNC is not set
> +CONFIG_AUDIT_ARCH=y
> +# CONFIG_DEFAULT_UIMAGE is not set

[snip]
