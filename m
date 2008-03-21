Return-Path: <jblack547@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id E6B3DDDF2A
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 22 Mar 2008 08:35:06 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so367941anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Mar 2008 14:35:05 -0700 (PDT)
Message-ID: <b77025b40803211435g25e8cee7w75bfe4ed9c13796@mail.gmail.com>
Date: Fri, 21 Mar 2008 15:35:05 -0600
From: "James Black" <jblack547@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: muram in device tree for mpc8250 in arch/powerpc
In-Reply-To: <47E41BE7.9020109@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <b77025b40803191006m60dc3145la368ac227df43b17@mail.gmail.com>
	<20080319174001.GF7962@ld0162-tx32.am.freescale.net>
	<b77025b40803191107x2f9a7884n9b7f062fcf45370@mail.gmail.com>
	<b77025b40803201102w200dde6fuc4235d9a3cb8b0dd@mail.gmail.com>
	<47E2AADD.6090101@freescale.com>
	<b77025b40803201602q68fce3e1j703502a270351179@mail.gmail.com>
	<20080321161833.GA4170@loki.buserror.net>
	<b77025b40803211314g74a41aa9of01f7cf3560a2505@mail.gmail.com>
	<47E41BE7.9020109@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks much for the help Scott. Do you feel that the dts is correct
now and probably not the culprit? Do you have 2.6.24.2 running on
other boards? I've been checking u-boot to make sure that nothing over
there is messing me up. I noticed that there are new CFG_.. I'm using

#define CONFIG_OF_LIBFDT
#define CONFIG_OF_BOARD_SETUP
#define CONFIG_OF_HAS_UBOOT_ENV
#define CONFIG_OF_HAS_BD_T
#define CONFIG_OF_BOARD_SETUP
#define CONFIG_OF_BOOT_CPU      0

#define OF_CPU  "PowerPC,8250@0"
#define OF_SOC  "soc0@f0000000"
#define OF_TBCLK        (bd->bi_busfreq / 4)
#define OF_STDOUT_PATH  "/soc/cpm/serial@11a00"


/*
 * Device Tree for the CTA5000S board with an MPC8250 chip.
 * Device Tree for the PQ2FADS-ZU board with an MPC8280 chip.
 *
 * Copyright 2007 Freescale Semiconductor Inc.
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 */

/ {
	model = "cta5000s";
	compatible = "fsl,cta5000s";
	#address-cells = <1>;
	#size-cells = <1>;

	cpus {
		#address-cells = <1>;
		#size-cells = <0>;

		PowerPC,8250@0 {
			device_type = "cpu";
			reg = <0>;
			d-cache-line-size = <20>;
			i-cache-line-size = <20>;
			d-cache-size = <4000>;
			i-cache-size = <4000>;
			timebase-frequency = <0>;
			clock-frequency = <0>;
		};
	};

	memory {
		device_type = "memory";
		reg = <0 0>;
	};

	localbus@f0010100 {
		compatible = "fsl,mpc8250-localbus",
                   "fsl,pq2-localbus";

		#address-cells = <2>;
		#size-cells = <1>;
		reg = <f0010100 60>;
		ranges = <0 0 fe000000 00200000>;

		flash@fe000000,0 {
			compatible = "cfi-flash";
			reg = <0 fe000000  00200000>;
			bank-width = <2>;
			device-width = <1>;
		};
	};

	soc@f0000000 {
		#address-cells = <1>;
		#size-cells = <1>;
		device_type = "soc";
		compatible = "fsl,mpc8250", "fsl,pq2-soc";
		ranges = <00000000 f0000000 00014000>;

		// Temporary -- will go away once kernel uses ranges for get_immrbase().
		reg = <f0000000 00014000>;

		cpm@119c0 {
			#address-cells = <1>;
			#size-cells = <1>;
			#interrupt-cells = <2>;
			compatible = "fsl,mpc8250-cpm", "fsl,cpm2";
			reg = <119c0 30>;
			ranges;

			muram@0 {
				#address-cells = <1>;
				#size-cells = <1>;
				ranges = <0 0 10000>;

				data{
					compatible = "fsl,cpm-muram-data";
					reg = <0 4000>;
				};
			};

			brg@119f0 {
				compatible = "fsl,mpc8250-brg",
				             "fsl,cpm2-brg",
				             "fsl,cpm-brg";
				reg = <119f0 10>;
			};

			serial@11a00 {
				device_type = "serial";
				compatible = "fsl,mpc8250-scc-uart",
				             "fsl,cpm2-scc-uart";
				reg = <11a00 20 8000 100>;
				interrupts = <28 8>;
				interrupt-parent = <&PIC>;
				fsl,cpm-brg = <1>;
				fsl,cpm-command = <00800000>;
			};

			serial@11a40 {
				device_type = "serial";
				compatible = "fsl,mpc8250-scc-uart",
				             "fsl,cpm2-scc-uart";
				reg = <11a40 20 8200 100>;
				interrupts = <2a 8>;
				interrupt-parent = <&PIC>;
				fsl,cpm-brg = <5>;
				fsl,cpm-command = <08c00000>;
			};

			ethernet@11300 {
				device_type = "network";
				compatible = "fsl,mpc8250-fcc-enet",
				             "fsl,cpm2-fcc-enet";
				reg = <11300 20 8400 100>;
				interrupts = <20 8>;
				interrupt-parent = <&PIC>;
				linux,network-index = <0>;
				fsl,cpm-command = <12000300>;
			};
		};

		PIC: interrupt-controller@10c00 {
			#interrupt-cells = <2>;
			interrupt-controller;
			reg = <10c00 80>;
			compatible = "fsl,mpc8250-pic", "fsl,cpm2-pic";
		};

	};

	chosen {
		linux,stdout-path = "/soc/cpm/serial@11a00";
	};
};

I think I'll try fresh source in 2.6.24, if I get the same result,
I'll give 2.6.25 a shot.

Again Thanks much...

Jim Black


On Fri, Mar 21, 2008 at 2:34 PM, Scott Wood <scottwood@freescale.com> wrote:
> James Black wrote:
>  > I've compiled the kernel with gcc 4.0.0 and  4.2.2 both versions have
>  > the same problem. Should I try the 2.6.25 kernel since the 2.6.19
>  > works just fine.
>
>  It's worth a try.  Also, since it seems to be a random corruption issue,
>  make sure that no DMA is left running by the firmware (try resetting the
>  CPM (though you'll have to turn off the early udbg output)), that you're
>  not trying to use more memory than you have, etc.  Try dumping various
>  registers to see if anything significant is different compared to 2.6.19.
>
>  If none of that helps, then I'm out of ideas as far as debug-by-email
>  goes...
>
>
>  > I've stripped the kernel options down almost as far
>  > as I can go.
>
>  You turned off too much. :-)
>  Turn kallsyms back on, so you get symbols in crash dumps.
>
>  -Scott
>
