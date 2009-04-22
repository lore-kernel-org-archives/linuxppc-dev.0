Return-Path: <sfalco@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id 0BD41DE052
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 07:44:42 +1000 (EST)
Message-ID: <49EF8FC5.7080602@harris.com>
Date: Wed, 22 Apr 2009 17:44:37 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: [Question] PPC440EPx SMII ethernet
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We have built a new board based on the PPC440EPx.  We are
using an SMII-mode phy for the ethernet.

The .dts file started as the one for Sequoia, and I have
changed the phy specifier to phy-mode = "smii" - I've also
removed the has-mdio property from RGMII0.  The ethernet
is working in U-Boot, but when Linux tries to start the
emac I get:

PPC 4xx OCP EMAC driver, version 3.54
MAL v2 /plb/mcmal, 2 TX channels, 2 RX channels
ZMII /plb/opb/emac-zmii@ef600d00 initialized
RGMII /plb/opb/emac-rgmii@ef601000 initialized without MDIO support
/plb/opb/emac-zmii@ef600d00: bridge in SMII mode
/plb/opb/emac-rgmii@ef601000: unsupported settings !
/plb/opb/emac-rgmii@ef601000: unsupported settings !

and the ethernet is not functional.  I don't see any
example .dts files for smii mode.  If anyone can tell me
what the .dts settings should be for this configuration,
I'd appreciate it.

The kernel version is 2.6.28.7 - I know that is a bit old
now, but hopefully I can still make progress with it.

Here is the whole .dts section for reference:

	ZMII0: emac-zmii@ef600d00 {
		compatible = "ibm,zmii-440epx", "ibm,zmii";
		reg = <0xef600d00 0x0000000c>;
	};

	RGMII0: emac-rgmii@ef601000 {
		compatible = "ibm,rgmii-440epx", "ibm,rgmii";
		reg = <0xef601000 0x00000008>;
		/* has-mdio; */
	};

	EMAC0: ethernet@ef600e00 {
		device_type = "network";
		compatible = "ibm,emac-440epx", "ibm,emac4";
		interrupt-parent = <&EMAC0>;
		interrupts = <0x0 0x1>;
		#interrupt-cells = <1>;
		#address-cells = <0>;
		#size-cells = <0>;
		interrupt-map = </*Status*/ 0x0 &UIC0 0x18 0x4
				/*Wake*/  0x1 &UIC1 0x1d 0x4>;
		reg = <0xef600e00 0x00000074>;
		local-mac-address = [000000000000];
		mal-device = <&MAL0>;
		mal-tx-channel = <0>;
		mal-rx-channel = <0>;
		cell-index = <0>;
		max-frame-size = <9000>;
		rx-fifo-size = <4096>;
		tx-fifo-size = <2048>;
		phy-mode = "smii";
		phy-map = <0x00000000>;
		zmii-device = <&ZMII0>;
		zmii-channel = <0>;
		rgmii-device = <&RGMII0>;
		rgmii-channel = <0>;
		has-inverted-stacr-oc;
		has-new-stacr-staopc;
	};
