Return-Path: <alan@akb.net>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.182])
	by ozlabs.org (Postfix) with ESMTP id B7DD4DDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Sep 2007 08:21:38 +1000 (EST)
Received: by el-out-1112.google.com with SMTP id s27so2728ele
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Sep 2007 15:21:37 -0700 (PDT)
Message-ID: <bfa0697f0709181521r62c81b55q65cd49d4e4ba3637@mail.gmail.com>
Date: Tue, 18 Sep 2007 16:21:36 -0600
From: "Alan Bennett" <alan@akb.net>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: device tree question
In-Reply-To: <46F04BCE.8060007@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <bfa0697f0709181343m1fc9f9b9u8acd429663d1adae@mail.gmail.com>
	<46F04BCE.8060007@freescale.com>
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

I finally saw some light, though not much, and have made several
changes to a new dts file.

BTW: I've lost my __log_buf
  was 02aec04 now it's not there, nor is it Load Address: 0x00400000 +  02aec04


BRx/ORx=CSx
128MB flash: CS0 = F800_0000 f800_0000
128MB flash: CS4 = D000_0000 f800_0000
128MB SDRAM: CS1 = 0000_0000 f800_0000
CS2 = E400_0000 fff0_0000
CS5 = E410_0000 fff0_0000
CS6 = E420_0000 fff0_0000

/ {
	model = "MPC8248";
	compatible = "fsl,mpc8248";
	#address-cells = <1>;
	#size-cells = <1>;

	cpus {
		#address-cells = <1>;
		#size-cells = <0>;

		PowerPC,8272@0 {
			device_type = "cpu";
			reg = <0>;
			d-cache-line-size = <d#32>;
			i-cache-line-size = <d#32>;
			d-cache-size = <d#16384>;
			i-cache-size = <d#16384>;
			timebase-frequency = <0>;
			bus-frequency = <0>;
			clock-frequency = <0>;
		};
	};

	memory {
		device_type = "memory";
		reg = <0 0>;
	};

	localbus@f0010100 {
		compatible = "fsl,mpc8248-localbus",
		             "fsl,pq2-localbus";
		#address-cells = <2>;
		#size-cells = <1>;
		reg = <f0010100 40>;

		ranges = <0 0 f8000000 08000000
		          1 0 f4000000 00008000
		          3 0 d0000000 08000000
			  5 0 f4100000 00100000
			  6 0 f4200000 00100000>;
		flash@0,0 {
			compatible = "jedec-flash";
			reg = <0 0 8000000>;
			bank-width = <1>;
			device-width = <32>;
		};
		board-control@1,0 {
			reg = <1 0 20>;
			compatible = "fsl,mpc8248-bcsr";
		};
		flash2@3,0 {
			compatible = "jedec-flash";
			reg = <0 0 8000000>;
			bank-width = <1>;
			device-width = <32>;
		};
		dualportram@1,0 {
			reg = <5 0 100000>;
			compatible = "fsl,mpc8248-dualportram";
		};
		dualportcsr@1,0 {
			reg = <6 0 100000>;
			compatible = "fsl,mpc8248-dualportcsr";
		};
	};

	soc@f0000000 {
		#address-cells = <1>;
		#size-cells = <1>;
		device_type = "soc";
		compatible = "fsl,mpc8272", "fsl,pq2-soc";
		ranges = <00000000 f0000000 00053000>;

		// Temporary -- will go away once kernel uses ranges for get_immrbase().
		reg = <f0000000 00053000>;

		cpm@119c0 {
			#address-cells = <1>;
			#size-cells = <1>;
			compatible = "fsl,mpc8272-cpm", "fsl,cpm2";
			reg = <119c0 30 0 2000>;
			ranges;

			brg@119f0 {
				compatible = "fsl,mpc8272-brg",
				             "fsl,cpm2-brg",
				             "fsl,cpm-brg";
				reg = <119f0 10 115f0 10>;
			};

			serial@11a00 {
				device_type = "serial";
				compatible = "fsl,mpc8272-scc-uart",
				             "fsl,cpm2-scc-uart";
				reg = <11a00 20 8000 100>;
				interrupts = <28 8>;
				interrupt-parent = <&PIC>;
				fsl,cpm-brg = <1>;
				fsl,cpm-command = <00800000>;
			};

			serial@11a82 {
				device_type = "serial";
				compatible = "fsl,mpc8272-smc-uart",
				             "fsl,cpm2-smc-uart";
				reg = <11a82 20 8300 100>;
				interrupts = <2b 8>;
				interrupt-parent = <&PIC>;
				fsl,cpm-brg = <4>;
				fsl,cpm-command = <0ce00000>;
			};

			mdio@10d40 {
				device_type = "mdio";
				compatible = "fsl,mpc8272ads-mdio-bitbang",
				             "fsl,mpc8272-mdio-bitbang",
				             "fsl,cpm2-mdio-bitbang";
				reg = <10d40 14>;
				#address-cells = <1>;
				#size-cells = <0>;
				fsl,mdio-pin = <12>;
				fsl,mdc-pin = <13>;

				PHY0: ethernet-phy@0 {
					interrupt-parent = <&PIC>;
					interrupts = <17 8>;
					reg = <0>;
					device_type = "ethernet-phy";
				};

				PHY1: ethernet-phy@1 {
					interrupt-parent = <&PIC>;
					interrupts = <17 8>;
					reg = <3>;
					device_type = "ethernet-phy";
				};
			};

			ethernet@11300 {
				device_type = "network";
				compatible = "fsl,mpc8272-fcc-enet",
				             "fsl,cpm2-fcc-enet";
				reg = <11300 20 8400 100 11390 1>;
				local-mac-address = [ 00 00 00 00 00 00 ];
				interrupts = <20 8>;
				interrupt-parent = <&PIC>;
				phy-handle = <&PHY0>;
				linux,network-index = <0>;
				fsl,cpm-command = <12000300>;
			};

			ethernet@11320 {
				device_type = "network";
				compatible = "fsl,mpc8272-fcc-enet",
				             "fsl,cpm2-fcc-enet";
				reg = <11320 20 8500 100 113b0 1>;
				local-mac-address = [ 00 00 00 00 00 00 ];
				interrupts = <21 8>;
				interrupt-parent = <&PIC>;
				phy-handle = <&PHY1>;
				linux,network-index = <1>;
				fsl,cpm-command = <16200300>;
			};
		};

		PIC: interrupt-controller@10c00 {
			#interrupt-cells = <2>;
			interrupt-controller;
			reg = <10c00 80>;
			compatible = "fsl,mpc8272-pic", "fsl,cpm2-pic";
		};

	};

	chosen {
		linux,stdout-path = "/soc/cpm/serial@11a82";
	};
};
