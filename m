Return-Path: <felix@embedded-sol.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F2724B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 16:15:44 +1000 (EST)
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0FE04DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 16:15:43 +1000 (EST)
Message-ID: <4A83AF5A.1040202@embedded-sol.com>
Date: Thu, 13 Aug 2009 09:14:50 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Feng Kan <fkan@amcc.com>
Subject: Re: [PATCH 1/1 v1] powerpc44x: Add Eiger AMCC (AppliedMicro) PPC460SX
	evaluation board support.
References: <1250123927-29167-1-git-send-email-fkan@amcc.com>
In-Reply-To: <1250123927-29167-1-git-send-email-fkan@amcc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Tai Tri Nguyen <ttnguyen@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Feng Kan wrote:
> This patch adds support for the AMCC (AppliedMicro) PPC460SX Eiger evaluation board.
> 
> Signed-off-by: Tai Tri Nguyen <ttnguyen@amcc.com>
> Acked-by: Feng Kan <fkan@amcc.com>
> Acked-by: Tirumala Marri <tmarri@amcc.com>
> ---
>  arch/powerpc/boot/dts/eiger.dts            |  421 ++++++++++
>  arch/powerpc/configs/44x/eiger_defconfig   | 1200 ++++++++++++++++++++++++++++
>  arch/powerpc/platforms/44x/Kconfig         |   12 +
>  arch/powerpc/platforms/44x/ppc44x_simple.c |    1 +
>  4 files changed, 1634 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/eiger.dts
>  create mode 100644 arch/powerpc/configs/44x/eiger_defconfig
> 
> diff --git a/arch/powerpc/boot/dts/eiger.dts b/arch/powerpc/boot/dts/eiger.dts
> new file mode 100644
> index 0000000..c4a934f
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/eiger.dts
> @@ -0,0 +1,421 @@
> +/*
> + * Device Tree Source for AMCC (AppliedMicro) Eiger(460SX)
> + *
> + * Copyright 2009 AMCC (AppliedMicro) <ttnguyen@amcc.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without
> + * any warranty of any kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +
> +/ {
> +	#address-cells = <2>;
> +	#size-cells = <1>;
> +	model = "amcc,eiger";
> +	compatible = "amcc,eiger";
> +	dcr-parent = <&{/cpus/cpu@0}>;
> +
> +	aliases {
> +		ethernet0 = &EMAC0;
> +		ethernet1 = &EMAC1;
> +		ethernet2 = &EMAC2;
> +		ethernet3 = &EMAC3;
> +		serial0 = &UART0;
> +		serial1 = &UART1;
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu@0 {
> +			device_type = "cpu";
> +			model = "PowerPC,460SX";
> +			reg = <0x00000000>;
> +			clock-frequency = <0>; /* Filled in by U-Boot */
> +			timebase-frequency = <0>; /* Filled in by U-Boot */
> +			i-cache-line-size = <32>;
> +			d-cache-line-size = <32>;
> +			i-cache-size = <32768>;
> +			d-cache-size = <32768>;
> +			dcr-controller;
> +			dcr-access-method = "native";
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x00000000 0x00000000>; /* Filled in by U-Boot */
> +	};
> +
> +	UIC0: interrupt-controller0 {
> +		compatible = "ibm,uic-460sx","ibm,uic";
> +		interrupt-controller;
> +		cell-index = <0>;
> +		dcr-reg = <0x0c0 0x009>;
> +		#address-cells = <0>;
> +		#size-cells = <0>;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	UIC1: interrupt-controller1 {
> +		compatible = "ibm,uic-460sx","ibm,uic";
> +		interrupt-controller;
> +		cell-index = <1>;
> +		dcr-reg = <0x0d0 0x009>;
> +		#address-cells = <0>;
> +		#size-cells = <0>;
> +		#interrupt-cells = <2>;
> +		interrupts = <0x1e 0x4 0x1f 0x4>; /* cascade */
> +		interrupt-parent = <&UIC0>;
> +	};
> +
> +	UIC2: interrupt-controller2 {
> +		compatible = "ibm,uic-460sx","ibm,uic";
> +		interrupt-controller;
> +		cell-index = <2>;
> +		dcr-reg = <0x0e0 0x009>;
> +		#address-cells = <0>;
> +		#size-cells = <0>;
> +		#interrupt-cells = <2>;
> +		interrupts = <0xa 0x4 0xb 0x4>; /* cascade */
> +		interrupt-parent = <&UIC0>;
> +	};
> +
> +	UIC3: interrupt-controller3 {
> +		compatible = "ibm,uic-460sx","ibm,uic";
> +		interrupt-controller;
> +		cell-index = <3>;
> +		dcr-reg = <0x0f0 0x009>;
> +		#address-cells = <0>;
> +		#size-cells = <0>;
> +		#interrupt-cells = <2>;
> +		interrupts = <0x10 0x4 0x11 0x4>; /* cascade */
> +		interrupt-parent = <&UIC0>;
> +	};
> +
> +	SDR0: sdr {
> +		compatible = "ibm,sdr-460sx";
> +		dcr-reg = <0x00e 0x002>;
> +	};
> +
> +	CPR0: cpr {
> +		compatible = "ibm,cpr-460sx";
> +		dcr-reg = <0x00c 0x002>;
> +	};
> +
> +	plb {
> +		compatible = "ibm,plb-460sx", "ibm,plb4";
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		ranges;
> +		clock-frequency = <0>; /* Filled in by U-Boot */
> +
> +		SDRAM0: sdram {
> +			compatible = "ibm,sdram-460sx", "ibm,sdram-405gp";
> +			dcr-reg = <0x010 0x002>;
> +		};
> +
> +		MAL0: mcmal {
> +			compatible = "ibm,mcmal-460sx", "ibm,mcmal2";
> +			dcr-reg = <0x180 0x62>;
> +			num-tx-chans = <4>;
> +			num-rx-chans = <32>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			interrupt-parent = <&UIC1>;
> +			interrupts = <	/*TXEOB*/ 0x6 0x4
> +					/*RXEOB*/ 0x7 0x4
> +					/*SERR*/  0x1 0x4
> +					/*TXDE*/  0x2 0x4
> +					/*RXDE*/  0x3 0x4
> +					/*COAL TX0*/ 0x18 0x2
> +					/*COAL TX1*/ 0x19 0x2
> +					/*COAL TX2*/ 0x1a 0x2
> +					/*COAL TX3*/ 0x1b 0x2
> +					/*COAL RX0*/ 0x1c 0x2
> +					/*COAL RX1*/ 0x1d 0x2
> +					/*COAL RX2*/ 0x1e 0x2
> +					/*COAL RX3*/ 0x1f 0x2>;
> +		};
> +
> +		POB0: opb {
> +			compatible = "ibm,opb-460sx", "ibm,opb";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0xb0000000 0x00000004 0xb0000000 0x50000000>;
> +			clock-frequency = <0>; /* Filled in by U-Boot */
> +
> +			EBC0: ebc {
> +				compatible = "ibm,ebc-460sx", "ibm,ebc";
> +				dcr-reg = <0x012 0x002>;
> +				#address-cells = <2>;
> +				#size-cells = <1>;
> +				clock-frequency = <0>; /* Filled in by U-Boot */
> +				/* ranges property is supplied by U-Boot */
> +				interrupts = <0x6 0x4>;
> +				interrupt-parent = <&UIC1>;
> +
> +				nor_flash@0,0 {
> +					compatible = "amd,s29gl512n", "cfi-flash";
> +					bank-width = <2>;
> +					/* reg property is supplied in by U-Boot */
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +					partition@0 {
> +						label = "kernel";
> +						reg = <0x00000000 0x001e0000>;
> +					};
> +					partition@1e0000 {
> +						label = "dtb";
> +						reg = <0x001e0000 0x00020000>;
> +					};
> +					partition@200000 {
> +						label = "ramdisk";
> +						reg = <0x00200000 0x01400000>;
> +					};
> +					partition@1600000 {
> +						label = "jffs2";
> +						reg = <0x01600000 0x00400000>;
> +					};
> +					partition@1a00000 {
> +						label = "user";
> +						reg = <0x01a00000 0x02560000>;
> +					};
> +					partition@3f60000 {
> +						label = "env";
> +						reg = <0x03f60000 0x00040000>;
> +					};
> +					partition@3fa0000 {
> +						label = "u-boot";
> +						reg = <0x03fa0000 0x00060000>;
> +					};
> +				};
> +
> +				ndfc@1,0 {
> +					compatible = "ibm,ndfc";
> +					/* reg property is supplied by U-boot */
> +					ccr = <0x00003000>;

Why don't you set EBCC bit in CCR ? It seems to be required for normal operation.


> +					bank-settings = <0x80002222>;
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +
> +					nand {
> +						#address-cells = <1>;
> +						#size-cells = <1>;
> +						partition@0 {
> +							label = "uboot";
> +							reg = <0x00000000 0x00200000>;
> +						};
> +						partition@200000 {
> +							label = "uboot-environment";
> +							reg = <0x00200000 0x00100000>;
> +						};
> +						partition@300000 {
> +							label = "linux";
> +							reg = <0x00300000 0x00300000>;
> +						};
> +						partition@600000 {
> +							label = "root-file-system";
> +							reg = <0x00600000 0x01900000>;
> +						};
> +						partition@1f00000 {
> +							label = "device-tree";
> +							reg = <0x01f00000 0x00020000>;
> +						};
> +						partition@1f20000 {
> +							label = "data";
> +							reg = <0x01f20000 0x060E0000>;
> +						};
> +					};
> +				};
> +			};
> +

Felix.
