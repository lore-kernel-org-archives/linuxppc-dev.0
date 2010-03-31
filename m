Return-Path: <pppeterpppan@gmail.com>
Received: from mail-qy0-f184.google.com (mail-qy0-f184.google.com
	[209.85.221.184]) by ozlabs.org (Postfix) with ESMTP id 0FE34B7C67
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 31 Mar 2010 12:46:17 +1100 (EST)
Received: by qyk14 with SMTP id 14so5129603qyk.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Mar 2010 18:46:15 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 31 Mar 2010 09:46:15 +0800
Message-ID: <48abf2c21003301846h67106ce6h8d51ad167374793f@mail.gmail.com>
Subject: I can not get my MII working on MPC8247 with Linux 2.6.32.6
From: Peter Pan <pppeterpppan@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Recently, I'm porting Linux 2.6.32.6 to our customized MPC8247 based
board. Everything is fine out except my ethernets. I uses
cpm2-scc-enet and cpm2-fcc-enet drivers.
My ethernet works fine in U-Boot with the same setting, and our
previous Linux 2.6.22 is also working, so there should be nothing
wrong with the hardware.
The boot log of the MII part is:

CPM2 Bitbanged MII: probed
mdio_bus f0010d00: error probing PHY at address 0
mdio_bus f0010d00: error probing PHY at address 1

I add some print, and find out that the MII bus can not be get the
turn around bit, and can not get the PHYIDs. That makes the PHY probe
failed.
Maybe it's because my wrongly typed dts file? My ethernet part of my
dts file is:
My MDIO pin is using PA23, MDC pin is using PA22.

	soc@f0000000 {
		#address-cells = <1>;
		#size-cells = <1>;
		device_type = "soc";
		compatible = "fsl,mpc8247-immr", "fsl,pq2-soc";
		ranges = <0x0 0xf0000000 0x53000>;
                bus-frequency = <0>; /* Filled in by U-Boot */

		cpm@119c0 {
			#address-cells = <1>;
			#size-cells = <1>;
			#interrupt-cells = <2>;
			compatible = "fsl,mpc8247-cpm", "fsl,cpm2";
			reg = <0x119c0 0x30>;
			ranges;
			muram {
				compatible = "fsl,cpm-muram";
				#address-cells = <1>;
				#size-cells = <1>;
				ranges = <0 0 0x10000>;

				data@0 {
					compatible = "fsl,cpm-muram-data";
					reg = <0x80 0x1f80 0x9800 0x800>;
				};
			};
            mdio@10d00 {
                device_type = "mdio";
                compatible =  "fsl,cpm2-mdio-bitbang";
                reg = <0x10d00 0x14>;
                #address-cells = <1>;
                #size-cells = <0>;
                fsl,mdio-pin = <23>;
                fsl,mdc-pin = <22>;

                PHY0: ethernet-phy@0 {
                    interrupt-parent = <&PIC>;
                    interrupts = <22 8>;
                    reg = <0>;
                    device_type = "ethernet-phy";
                };

		PHY1: ethernet-phy@1 {
			interrupt-parent = <&PIC>;
			interrupts = <22 8>;
			reg = <1>;
			device_type = "ethernet-phy";
		};

            };
            eth0: ethernet@11300 {
                device_type = "network";
                compatible = "fsl,mpc8247-fcc-enet",
                             "fsl,cpm2-fcc-enet";
                reg = <0x11300 0x20 0x8400 0x100 0x11390 0x1>;
                local-mac-address = [ 00 00 00 00 00 00 ];
                interrupts = <32 8>;
                interrupt-parent = <&PIC>;
                phy-handle = <&PHY0>;
                linux,network-index = <0>;
                fsl,cpm-command = <0x12000300>;
                fsl,cpm-txclk = <9>;
                fsl,cpm-rxclk = <10>;
            };
	    eth1: ethernet@11320 {
		device_type = "network";
		compatible = "fsl,mpc8247-fcc-enet",
		             "fsl,cpm2-fcc-enet";
		reg = <0x11320 0x20 0x8500 0x100 0x113b0 0x1>;
		local-mac-address = [ 00 00 00 00 00 00 ];
		interrupts = <33 8>;
		interrupt-parent = <&PIC>;
		phy-handle = <&PHY1>;
		linux,network-index = <1>;
		fsl,cpm-command = <0x16200300>;
                fsl,cpm-txclk = <15>;
                fsl,cpm-rxclk = <16>;
	    };
            eth2: ethernet@11a40 {
                device_type = "network";
                compatible = "fsl,mpc8247-scc-enet",
                             "fsl,cpm2-scc-enet";
                reg = <0x11a40 0x20 0x8200 0x100 0x11390 1>;
                local-mac-address = [00 00 00 00 00 00];
                interrupts = <42 8>;
                interrupt-parent = <&PIC>;
                linux,network-index = <2>;
                fsl,cpm-command = <0x8c00000>;
                fsl,cpm-txclk = <8>;
                fsl,cpm-rxclk = <5>;
            };
            eth3: ethernet@11a60 {
                device_type = "network";
                compatible = "fsl,mpc8247-scc-enet",
                             "fsl,cpm2-scc-enet";
                reg = <0x11a60 0x20 0x8300 0x100 0x11390 1>;
                local-mac-address = [00 00 00 00 00 00];
                interrupts = <43 8>;
                interrupt-parent = <&PIC>;
                linux,network-index = <3>;
                fsl,cpm-command = <0xce00000>;
                fsl,cpm-txclk = <7>;
                fsl,cpm-rxclk = <6>;
            };
        };
    };
