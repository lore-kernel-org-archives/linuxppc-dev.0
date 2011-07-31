Return-Path: <glikely@secretlab.ca>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1CA21B7235
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  1 Aug 2011 00:26:32 +1000 (EST)
Received: by wwj40 with SMTP id 40so3795564wwj.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 31 Jul 2011 07:26:28 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Sat, 30 Jul 2011 22:05:25 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 2/4] powerpc, mpc52xx: add a4m072 board support
Message-ID: <20110731040525.GL24334@ponder.secretlab.ca>
References: <1308729311-15375-1-git-send-email-hs@denx.de>
	<1308729311-15375-3-git-send-email-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308729311-15375-3-git-send-email-hs@denx.de>
Cc: devicetree-discuss@ozlabs.org, linuxppc-dev@lists.ozlabs.org,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 22, 2011 at 09:55:09AM +0200, Heiko Schocher wrote:
> Signed-off-by: Heiko Schocher <hs@denx.de>
> cc: Grant Likely <grant.likely@secretlab.ca>
> cc: devicetree-discuss@ozlabs.org
> cc: Wolfgang Denk <wd@denx.de>
> ---
> For this patchseries following patch is needed:
> 
> http://patchwork.ozlabs.org/patch/91919/
> 
> Grant? Do you have some comments on that patch?
> 
>  arch/powerpc/boot/dts/a4m072.dts             |  273 ++++++++++++++++++++++++++
>  arch/powerpc/platforms/52xx/mpc5200_simple.c |    1 +
>  2 files changed, 274 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/a4m072.dts
> 
> diff --git a/arch/powerpc/boot/dts/a4m072.dts b/arch/powerpc/boot/dts/a4m072.dts
> new file mode 100644
> index 0000000..cea1c6f
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/a4m072.dts
> @@ -0,0 +1,273 @@
> +/*
> + * a4m072 board Device Tree Source
> + *
> + * Copyright (C) 2011 DENX Software Engineering GmbH
> + * Heiko Schocher <hs@denx.de>
> + *
> + * Copyright (C) 2007 Semihalf
> + * Marian Balakowicz <m8@semihalf.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +/dts-v1/;
> +
> +/ {
> +	model = "anonymous,a4m072";
> +	compatible = "anonymous,a4m072";

anonymous?  This bears some description.

Also, 5200b boards can use the mpc5200b.dtsi include file.  This one
should too.

> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	interrupt-parent = <&mpc5200_pic>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,5200@0 {
> +			device_type = "cpu";
> +			reg = <0>;
> +			d-cache-line-size = <32>;
> +			i-cache-line-size = <32>;
> +			d-cache-size = <0x4000>;	// L1, 16K
> +			i-cache-size = <0x4000>;	// L1, 16K
> +			timebase-frequency = <0>; /* From boot loader */
> +			bus-frequency = <0>; /* From boot loader */
> +			clock-frequency = <0>; /* From boot loader */
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x04000000>;
> +	};
> +
> +	soc5200@f0000000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "fsl,mpc5200b-immr";
> +		ranges = <0 0xf0000000 0x0000c000>;
> +		reg = <0xf0000000 0x00000100>;
> +		bus-frequency = <0>; /* From boot loader */
> +		system-frequency = <0>; /* From boot loader */
> +
> +		cdm@200 {
> +			compatible = "fsl,mpc5200b-cdm","fsl,mpc5200-cdm";
> +			reg = <0x200 0x38>;
> +			fsl,ext_48mhz_en = <0x0>;
> +			fsl,fd_enable = <0x01>;
> +			fsl,fd_counters = <0xbbbb>;
> +		};
> +
> +		mpc5200_pic: interrupt-controller@500 {
> +			// 5200 interrupts are encoded into two levels;
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			compatible = "fsl,mpc5200b-pic","fsl,mpc5200-pic";
> +			reg = <0x500 0x80>;
> +		};
> +
> +		timer@600 {
> +			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
> +			reg = <0x600 0x80>;
> +			interrupts = <1 9 0>;
> +			fsl,has-wdt;
> +		};
> +
> +		gpt3: timer@630 { /* General Purpose Timer in GPIO mode */
> +			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
> +			reg = <0x630 0x10>;
> +			interrupts = <1 12 0>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +		};
> +
> +		gpt4: timer@640 { /* General Purpose Timer in GPIO mode */
> +			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
> +			reg = <0x640 0x10>;
> +			interrupts = <1 13 0>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +		};
> +
> +		gpt5: timer@650 { /* General Purpose Timer in GPIO mode */
> +			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
> +			reg = <0x650 0x10>;
> +			interrupts = <1 14 0>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +		};
> +
> +		can@900 {
> +			compatible = "fsl,mpc5200b-mscan","fsl,mpc5200-mscan";
> +			interrupts = <2 17 0>;
> +			reg = <0x900 0x80>;
> +		};
> +
> +		can@980 {
> +			compatible = "fsl,mpc5200b-mscan","fsl,mpc5200-mscan";
> +			interrupts = <2 18 0>;
> +			reg = <0x980 0x80>;
> +		};
> +
> +		gpio_simple: gpio@b00 {
> +			compatible = "fsl,mpc5200b-gpio","fsl,mpc5200-gpio";
> +			reg = <0xb00 0x40>;
> +			interrupts = <1 7 0>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			fsl,port_config = <0x19051444>;
> +		};
> +
> +		gpio_wkup: gpio@c00 {
> +			compatible = "fsl,mpc5200b-gpio-wkup","fsl,mpc5200-gpio-wkup";
> +			reg = <0xc00 0x40>;
> +			interrupts = <1 8 0 0 3 0>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +		};
> +
> +		usb@1000 {
> +			compatible = "fsl,mpc5200b-ohci","fsl,mpc5200-ohci","ohci-be";
> +			reg = <0x1000 0xff>;
> +			interrupts = <2 6 0>;
> +		};
> +
> +		dma-controller@1200 {
> +			compatible = "fsl,mpc5200b-bestcomm","fsl,mpc5200-bestcomm";
> +			reg = <0x1200 0x80>;
> +			interrupts = <3 0 0  3 1 0  3 2 0  3 3 0
> +			              3 4 0  3 5 0  3 6 0  3 7 0
> +			              3 8 0  3 9 0  3 10 0  3 11 0
> +			              3 12 0  3 13 0  3 14 0  3 15 0>;
> +		};
> +
> +		xlb@1f00 {
> +			compatible = "fsl,mpc5200b-xlb","fsl,mpc5200-xlb";
> +			reg = <0x1f00 0x100>;
> +		};
> +
> +		psc@2000 {
> +			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
> +			reg = <0x2000 0x100>;
> +			interrupts = <2 1 0>;
> +		};
> +
> +		psc@2200 {
> +			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
> +			reg = <0x2200 0x100>;
> +			interrupts = <2 2 0>;
> +		};
> +
> +		psc@2400 {
> +			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
> +			reg = <0x2400 0x100>;
> +			interrupts = <2 3 0>;
> +		};
> +
> +		psc@2c00 {
> +			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
> +			reg = <0x2c00 0x100>;
> +			interrupts = <2 4 0>;
> +		};
> +
> +		ethernet@3000 {
> +			compatible = "fsl,mpc5200b-fec","fsl,mpc5200-fec";
> +			reg = <0x3000 0x400>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			interrupts = <2 5 0>;
> +			phy-handle = <&phy0>;
> +		};
> +
> +		mdio@3000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "fsl,mpc5200b-mdio","fsl,mpc5200-mdio";
> +			reg = <0x3000 0x400>;
> +			interrupts = <2 5 0>;
> +
> +			phy0: ethernet-phy@1f {
> +				reg = <0x1f>;
> +				interrupts = <1 2 0>; /* IRQ 2 active low */
> +			};
> +		};
> +
> +		ata@3a00 {
> +			compatible = "fsl,mpc5200b-ata","fsl,mpc5200-ata";
> +			reg = <0x3a00 0x100>;
> +			interrupts = <2 7 0>;
> +		};
> +
> +		i2c@3d40 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
> +			reg = <0x3d40 0x40>;
> +			interrupts = <2 16 0>;
> +
> +			 hwmon@2e {
> +				compatible = "nsc,lm87";
> +				reg = <0x2e>;
> +			};
> +			 rtc@51 {
> +				compatible = "nxp,rtc8564";
> +				reg = <0x51>;
> +			};
> +		};
> +
> +		sram@8000 {
> +			compatible = "fsl,mpc5200b-sram","fsl,mpc5200-sram";
> +			reg = <0x8000 0x4000>;
> +		};
> +	};
> +
> +	localbus {
> +		compatible = "fsl,mpc5200b-lpb","simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		ranges = <0 0 0xfe000000 0x02000000
> +			  1 0 0x62000000 0x00400000
> +			  2 0 0x64000000 0x00200000
> +			  3 0 0x66000000 0x01000000
> +			  6 0 0x68000000 0x01000000
> +			  7 0 0x6a000000 0x00000004
> +			 >;
> +
> +		flash@0,0 {
> +			compatible = "cfi-flash";
> +			reg = <0 0 0x02000000>;
> +			bank-width = <2>;
> +			#size-cells = <1>;
> +			#address-cells = <1>;
> +		};
> +		sram0@1,0 {
> +			compatible = "mtd-ram";
> +			reg = <1 0x00000 0x00400000>;
> +			bank-width = <2>;
> +		};
> +	};
> +
> +	pci@f0000d00 {
> +		#interrupt-cells = <1>;
> +		#size-cells = <2>;
> +		#address-cells = <3>;
> +		device_type = "pci";
> +		compatible = "fsl,mpc5200-pci";
> +		reg = <0xf0000d00 0x100>;
> +		interrupt-map-mask = <0xf800 0 0 7>;
> +		interrupt-map = <
> +				 /* IDSEL 0x16 */
> +				 0xc000 0 0 1 &mpc5200_pic 1 3 3
> +				 0xc000 0 0 2 &mpc5200_pic 1 3 3
> +				 0xc000 0 0 3 &mpc5200_pic 1 3 3
> +				 0xc000 0 0 4 &mpc5200_pic 1 3 3>;
> +		clock-frequency = <0>; /* From boot loader */
> +		interrupts = <2 8 0 2 9 0 2 10 0>;
> +		bus-range = <0 0>;
> +		ranges = <0x42000000 0 0x80000000 0x80000000 0 0x10000000
> +			  0x02000000 0 0x90000000 0x90000000 0 0x10000000
> +			  0x01000000 0 0x00000000 0xa0000000 0 0x01000000>;
> +	};
> +};
> diff --git a/arch/powerpc/platforms/52xx/mpc5200_simple.c b/arch/powerpc/platforms/52xx/mpc5200_simple.c
> index e36d6e2..192b4ff 100644
> --- a/arch/powerpc/platforms/52xx/mpc5200_simple.c
> +++ b/arch/powerpc/platforms/52xx/mpc5200_simple.c
> @@ -50,6 +50,7 @@ static void __init mpc5200_simple_setup_arch(void)
>  
>  /* list of the supported boards */
>  static const char *board[] __initdata = {
> +	"anonymous,a4m072",
>  	"intercontrol,digsy-mtc",
>  	"manroland,mucmc52",
>  	"manroland,uc101",
> -- 
> 1.7.5.4
> 
