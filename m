Return-Path: <mike@it-loops.com>
Received: from lvps87-230-0-242.dedicated.hosteurope.de
	(lvps87-230-0-242.dedicated.hosteurope.de [87.230.0.242])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "plesk", Issuer "plesk" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id EF9AFDDD1C
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Feb 2009 10:38:30 +1100 (EST)
Message-Id: <F79A1F44-A17D-483B-9FC9-D5C4D6AEBE6C@it-loops.com>
From: Michael Guntsche <mike@it-loops.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <D5EBE54F-FD6D-4973-8835-33541ADCBABD@it-loops.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: PHY not found after migration of gianfar driver to an
	of_platform_driver
Date: Fri, 27 Feb 2009 00:38:24 +0100
References: <D5EBE54F-FD6D-4973-8835-33541ADCBABD@it-loops.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Some more information regarding this board. This is the output of

dtc /proc/device/ree:

I removed all information not relevant to networking

/dts-v1/;

/ {
	linux,phandle = <0x100>;
	#size-cells = <0x1>;
	#address-cells = <0x1>;
	compatible = "MPC83xx";
	model = "RB600";

	
	soc8343@e0000000 {
		bus-frequency = <0x1>;
		reg = <0xe0000000 0x200>;
		ranges = <0x0 0xe0000000 0x100000>;
		device_type = "soc";
		#interrupt-cells = <0x2>;
		#size-cells = <0x1>;
		#address-cells = <0x1>;

	
		gpio@0 {
			reg = <0xc08 0x4>;
			device-id = <0x0>;
			compatible = "gpio";
			device_type = "gpio";
			linux,phandle = <0x400>;
		};

		ethernet@24000 {
			phy-handle = <0x80001>;
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
			interrupt-parent = <0x700>;
			interrupts = <0x23 0x8 0x24 0x8 0x25 0x8>;
			mac-address = [00 0c 42 28 de 4e];
			reg = <0x25000 0x1000>;
			compatible = "gianfar";
			model = "TSEC";
			device_type = "network";
		};

		mdio@24520 {
			#size-cells = <0x1>;
			#address-cells = <0x1>;
			linux,phandle = <0x800>;
			reg = <0x24520 0x20>;
			compatible = "gianfar";
			device_type = "mdio";

			ethernet-phy@1 {
				device_type = "ethernet-phy";
				reg = <0x1>;
				linux,phandle = <0x80001>;
			};

			ethernet-phy@0 {
				device_type = "ethernet-phy";
				reg = <0x0>;
				linux,phandle = <0x80000>;
			};
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


I still do not understand why phy_attach fails. Does someone have an  
idea or can tell me how to debug this further?

Kind regards,
Michael
