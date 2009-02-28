Return-Path: <mike@it-loops.com>
Received: from lvps87-230-0-242.dedicated.hosteurope.de
	(lvps87-230-0-242.dedicated.hosteurope.de [87.230.0.242])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "plesk", Issuer "plesk" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id E2D27DDD0B
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Mar 2009 00:42:04 +1100 (EST)
Message-Id: <9A97F1E3-3EAE-4CCE-9C5A-5F73F5B492F1@it-loops.com>
From: Michael Guntsche <mike@it-loops.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <A3092716-D25B-409A-B422-AE2F6E7AADA1@it-loops.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: PHY not found after migration of gianfar driver to an
	of_platform_driver
Date: Sat, 28 Feb 2009 14:41:56 +0100
References: <D5EBE54F-FD6D-4973-8835-33541ADCBABD@it-loops.com>
	<F79A1F44-A17D-483B-9FC9-D5C4D6AEBE6C@it-loops.com>
	<A3092716-D25B-409A-B422-AE2F6E7AADA1@it-loops.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hello list,

Just a little update and one question.

I spent this night to create a DTS file for the board. I took the  
output of the existing /proc/device-tree as basis and added  
information regarding the TBI's.
Then I created a simpleImage.

/dts-v1/;

/ {
	linux,phandle = <0x100>;
	#size-cells = <0x1>;
	#address-cells = <0x1>;
	compatible = "MPC83xx";
	model = "RB600";

	chosen {
		linux,platform = <0x8062>;
		linux,initrd = <0x477000 0x0>;
		linux,stdout-path = "/soc8343@e0000000/serial@4500";
		interrupt-controller = <0x700>;
		bootargs = "root=/dev/sda2 console=ttyS0,115200 board=mpc8343 boot=1";
	};

I left root in there so I do not need to add a kernparm segment, I  
think this is not best practice but it works for now.


	cf@f9200000 {
		lb-timings = <0x5dc 0x3e8 0x1194 0x5dc 0x2af8>;
		interrupt-at-level = <0x0>;
		interrupt-parent = <0x700>;
		interrupts = <0x16 0x8>;
		lbc_extra_divider = <0x1>;
		reg = <0xf9200000 0x200000>;
		device_type = "rb,cf";
	};

	cf@f9000000 {
		lb-timings = <0x5dc 0x3e8 0x1194 0x5dc 0x2af8>;
		interrupt-at-level = <0x0>;
		interrupt-parent = <0x700>;
		interrupts = <0x14 0x8>;
		lbc_extra_divider = <0x1>;
		reg = <0xf9000000 0x200000>;
		device_type = "rb,cf";
	};

	flash {
		reg = <0xff800000 0x20000>;
	};

	nnand {
		reg = <0xf0000000 0x1000>;
	};

	nand {
		ale = <0x400 0x6>;
		cle = <0x400 0x5>;
		nce = <0x400 0x4>;
		rdy = <0x400 0x3>;
		reg = <0xf8000000 0x1000>;
		device_type = "rb,nand";
	};

	fancon {
		interrupt-parent = <0x700>;
		interrupts = <0x17 0x8>;
		sense = <0x400 0x7>;
		fan_on = <0x400 0x9>;
	};

	soc8343@e0000000 {
		bus-frequency = <0x1>;
		reg = <0xe0000000 0x200>;
		ranges = <0x0 0xe0000000 0x100000>;
		device_type = "soc";
		#interrupt-cells = <0x2>;
		#size-cells = <0x1>;
		#address-cells = <0x1>;

		led {
			user_led = <0x400 0x8>;
		};

		beeper {
			reg = <0x500 0x100>;
		};

		gpio@0 {
			reg = <0xc08 0x4>;
			device-id = <0x0>;
			compatible = "gpio";
			device_type = "gpio";
			linux,phandle = <0x400>;
		};

		ethernet@24000 {
			phy-handle = <0x80001>;
			tbi-handle = <&tbi1>;

TBI-Handle1

			interrupt-parent = <0x700>;
			interrupts = <0x20 0x8 0x21 0x8 0x22 0x8>;
			mac-address = [00 0c 42 28 de 4f];
			reg = <0x24000 0x1000>;
			compatible = "gianfar";
			model = "TSEC";
			device_type = "network";
		};

		ethernet@25000 {
			phy-handle = <0x80000>;
			tbi-handle = <&tbi0>;
TBI-Handle2
			interrupt-parent = <0x700>;
			interrupts = <0x23 0x8 0x24 0x8 0x25 0x8>;
			mac-address = [00 0c 42 28 de 4e];
			reg = <0x25000 0x1000>;
			compatible = "gianfar";
			model = "TSEC";
			device_type = "network";
		};

		mdio@24520 {
			#size-cells = <0x0>;
			#address-cells = <0x1>;
			linux,phandle = <0x800>;
			reg = <0x24520 0x20>;
			compatible = "fsl,gianfar-mdio";

Here I replace gianfar with fsl,gianfar-mdio
			
			ethernet-phy@0 {
				device_type = "ethernet-phy";
				reg = <0x0>;
				linux,phandle = <0x80000>;
			};

			ethernet-phy@1 {
				device_type = "ethernet-phy";
				reg = <0x1>;
				linux,phandle = <0x80001>;
			};

			tbi0: tbi-phy@11 {
				reg = <0x11>;
				device_type = "tbi-phy";
			};
		};

		mdio@25520 {
			#address-cells = <1>;
			#size-cells = <0>;
			compatible = "fsl,gianfar-tbi";
			reg = <0x25520 0x20>;

			tbi1: tbi-phy@11 {
				reg = <0x11>;
				device_type = "tbi-phy";
			};
		};

Additional entry for the second tbi

		pic@700 {
			device_type = "ipic";
			built-in;
			reg = <0x700 0x100>;
			#interrupt-cells = <0x2>;
			#address-cells = <0x0>;
			interrupt-controller;
			linux,phandle = <0x700>;
		};

		pci@8500 {
			device_type = "pci";
			compatible = "83xx";
			reg = <0x8500 0x100>;
			#address-cells = <0x3>;
			#size-cells = <0x2>;
			#interrupt-cells = <0x1>;
			ranges = <0x2000000 0x0 0x80000000 0x80000000 0x0 0x20000000  
0x1000000 0x0 0x0 0xd0000000 0x0 0x4000000>;
			bus-range = <0x0 0x0>;
			interrupt-map = <0x5800 0x0 0x0 0x1 0x700 0x15 0x8 0x6000 0x0 0x0  
0x1 0x700 0x30 0x8 0x6000 0x0 0x0 0x2 0x700 0x11 0x8 0x6800 0x0 0x0  
0x1 0x700 0x11 0x8 0x6800 0x0 0x0 0x2 0x700 0x12 0x8 0x7000 0x0 0x0  
0x1 0x700 0x12 0x8 0x7000 0x0 0x0 0x2 0x700 0x13 0x8 0x7800 0x0 0x0  
0x1 0x700 0x13 0x8 0x7800 0x0 0x0 0x2 0x700 0x30 0x8 0x8000 0x0 0x0  
0x1 0x700 0x30 0x8 0x8000 0x0 0x0 0x2 0x700 0x12 0x8 0x8000 0x0 0x0  
0x3 0x700 0x11 0x8 0x8000 0x0 0x0 0x4 0x700 0x13 0x8 0xa000 0x0 0x0  
0x1 0x700 0x30 0x8 0xa000 0x0 0x0 0x2 0x700 0x11 0x8 0xa000 0x0 0x0  
0x3 0x700 0x12 0x8 0xa000 0x0 0x0 0x4 0x700 0x13 0x8 0xa800 0x0 0x0  
0x1 0x700 0x11 0x8 0xa800 0x0 0x0 0x2 0x700 0x12 0x8 0xa800 0x0 0x0  
0x3 0x700 0x13 0x8 0xa800 0x0 0x0 0x4 0x700 0x30 0x8>;
			interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
			linux,phandle = <0x8500>;
		};

		serial@4500 {
			interrupt-parent = <0x700>;
			interrupts = <0x9 0x8>;
			clock-frequency = <0xfe4f840>;
			reg = <0x4500 0x100>;
			compatible = "ns16550";
			device_type = "serial";
		};

		wdt@200 {
			reg = <0x200 0x100>;
			compatible = "mpc83xx_wdt";
			device_type = "watchdog";
		};
	};

	memory {
		reg = <0x0 0x8000000>;
		linux,phandle = <0x300>;
		device_type = "memory";
	};

	cpus {
		linux,phandle = <0x200>;
		#size-cells = <0x0>;
		#address-cells = <0x1>;
		#cpus = <0x1>;

		PowerPC,8343E@0 {
			linux,boot-cpu;
			linux,phandle = <0x201>;
			32-bit;
			clock-frequency = <0x17d77460>;
			timebase-frequency = <0x3f93e10>;
			i-cache-size = <0x8000>;
			d-cache-size = <0x8000>;
			i-cache-line-size = <0x20>;
			d-cache-line-size = <0x20>;
			reg = <0x0>;
			device_type = "cpu";
		};
	};
};


Now my questions:

* In arch/powerpc/boot/wrapper I had to increase the link_address  
otherwise I got an error during boot.

       Insufficient memory for kernel at address...

My initial vmlinux file was 6MB but increasing link_address > 0x47xxxx  
gave me an out of memory region error. Is this a bootloader related  
issue?
I am asking since I did not find the message in the kernel sources.
During boot it looks for a partition of type 0x27 and if it is there  
it expects a linux kernel to be there. Without the simpleImage the  
kernel could be larger as 4MB (6, 8 or even 10) and it booted.
With the simpleimage everything > ~ 4.6MB gives me the error.
For now I keep the memory image at 4MB. The boot process of this board  
works the following way.

* My two gianfar devices are detected, BUT the order is reversed  
between ETH0<->ETH1.
Is there a way to define the order they appear, or is the probing non- 
deterministic?
I am asking because I want to keep the order like it was before if  
possible.


* kernparm:
with the old kernel image I had to add a kernparm entry so I could  
specify the root device. As mentioned earlier, for now I have this in  
the DTS file.
If I want to get rid of it I have to extract the kernel from the  
simpleimage, add the segment and put it back in again because adding  
the segment to the simpleimage won't do anything, right?


Kind regards,
Michael
