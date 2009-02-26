Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (unknown [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id 78369DDD1C
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Feb 2009 05:28:52 +1100 (EST)
Message-ID: <49A6DF58.1050202@mlbassoc.com>
Date: Thu, 26 Feb 2009 11:28:40 -0700
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Linux PPC Development <linuxppc-dev@ozlabs.org>
Subject: OF -> platform_device
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm trying to use some drivers which are not yet OF aware
(in particular net/dsa).  In order to use these drivers, I
need platform_device pointers for my network any MII bus (PHY).

In the OF world, how do I get to these?  I have a MPC834x
based board and somehow I need access to these devices (from
my DTS file):

		mdio@24520 {
			#address-cells = <1>;
			#size-cells = <0>;
			compatible = "fsl,gianfar-mdio";
			reg = <0x24520 0x20>;

			phy0: ethernet-phy@0 {
				interrupt-parent = <&ipic>;
				interrupts = <17 0x8>;
				reg = <0x1>;
				device_type = "ethernet-phy";
			};
			phy1: ethernet-phy@1 {
				interrupt-parent = <&ipic>;
				interrupts = <18 0x8>;
				reg = <0x2>;
				device_type = "ethernet-phy";
			};
		};

		enet0: ethernet@24000 {
			cell-index = <0>;
			device_type = "network";
			model = "TSEC";
			compatible = "gianfar";
			reg = <0x24000 0x1000>;
			local-mac-address = [ 00 08 e5 11 32 33 ];
			interrupts = <32 0x8 33 0x8 34 0x8>;
			interrupt-parent = <&ipic>;
			phy-handle = <&phy0>;
			linux,network-index = <0>;
		};

		enet1: ethernet@25000 {
			cell-index = <1>;
			device_type = "network";
			model = "TSEC";
			compatible = "gianfar";
			reg = <0x25000 0x1000>;
			local-mac-address = [ 00 08 e5 11 32 34 ];
			interrupts = <35 0x8 36 0x8 37 0x8>;
			interrupt-parent = <&ipic>;
			phy-handle = <&phy1>;
			linux,network-index = <1>;
		};

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
