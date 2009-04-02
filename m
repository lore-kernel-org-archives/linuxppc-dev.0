Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 44994DDE1A
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Apr 2009 14:23:48 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1LpDWo-0007n2-PX
	for linuxppc-dev@ozlabs.org; Wed, 01 Apr 2009 20:23:42 -0700
Message-ID: <22840131.post@talk.nabble.com>
Date: Wed, 1 Apr 2009 20:23:42 -0700 (PDT)
From: "Sauce.Cheng" <chmhou@sina.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: issue at the beginning of kernel booting
In-Reply-To: <20090327161522.GA7809@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <20090327083628.4C3E93EE530@mail2-203.sinamail.sina.com.cn>
	<20090327161522.GA7809@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


thanks Scott
> Another thing that would generally be good is to keep replies on the 
> list rather than taking it to private e-mail as soon as someone replies.

> Someone else may have something helpful to say based on your followup, 
> or may have the same problem and be helped by the conclusion.

ok~ excuse for my mistake, thank you for your words. i will do it like you
say from now on. it surely be better.

> I don't see where you set up a BAT that covers 0xf0000000.

if i have to set up a BAT that cover 0xF0000000. i had a debug with LEDs
like that in u-boot code. everything is //normal. 0xF00000000 is the value
of CFG_IMMR(CONFIG_SYS_IMMR) that memory map register, it is the phy address
and //base //address of all internal regishters, isnt? you mean that if i
set BATs, i should not get the phy address like in the //front ?

> Do you have a correct fdt, that matches a platform that is enabled in 
> your .config?

i think so, i used mpc8272ads_defconfig becasue my processor is mpc8272, i
got a mail before about modifying and //config fdt file mpc8272ads.dts. i
fixed up my file like that.

i tried 
CONFIG_PPC_EARLY_DEBUG_CPM=y 
CONFIG_PPC_EARLY_DEBUG_CPM_ADDR=0xf00000008	
how can i make sure CPM_ADDR, 0xf0000008 is default value 

now it show as follow. i select smc1 as console. please check it and give me
some advice.

/ {
	model = "MPC8272ADS";
	compatible = "fsl,mpc8272ads";
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
		compatible = "fsl,mpc8272-localbus",
		             "fsl,pq2-localbus";
		#address-cells = <2>;
		#size-cells = <1>;
		reg = <f0010100 40>;
/* chengmo : modify by my own device */
		ranges = <0 0 FFF00000 00080000	//CS0: Flahs 512k
		          2 0 00000000 02000000	//CS2: SDRAM 32M
						>;

		flash@0,0 {
			compatible = "cfi-flash";
			reg = <0 0 00080000>;
			bank-width = <4>;
			device-width = <1>;	// 16 bits
		};

		PCI_PIC: interrupt-controller@3,0 {
			compatible = "fsl,mpc8272ads-pci-pic",
			             "fsl,pq2ads-pci-pic";
			#interrupt-cells = <1>;
			interrupt-controller;
			reg = <3 0 8>;
			interrupt-parent = <&PIC>;
			interrupts = <14 8>;
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
			reg = <119c0 30>;
			ranges;

			muram@0 {
				#address-cells = <1>;
				#size-cells = <1>;
				ranges = <0 0 10000>;

				data@0 {
					compatible = "fsl,cpm-muram-data";
					reg = <0 2000 9800 800>;
				};
			};

			brg@119f0 {
				compatible = "fsl,mpc8272-brg",
				             "fsl,cpm2-brg",
				             "fsl,cpm-brg";
				reg = <119f0 10 115f0 10>;
			};

			serial@11a82 {
				device_type = "serial";
				compatible = "fsl,mpc8272-smc-uart",
				             "fsl,cpm2-smc-uart";
				reg = <11a82 20 87FC 100>;
				interrupts = <28 8>;
				interrupt-parent = <&PIC>;
				fsl,cpm-brg = <1>;
				fsl,cpm-command = <00800000>;
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

-- 
View this message in context: http://www.nabble.com/issue-at-the-beginning-of-kernel-booting-tp22741532p22840131.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
