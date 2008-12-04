Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5E275DDE07
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2008 04:48:11 +1100 (EST)
Message-ID: <493817AE.1070303@freescale.com>
Date: Thu, 04 Dec 2008 11:47:26 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Andre Schwarz <andre.schwarz@matrix-vision.de>
Subject: Re: "eth1: Could not attach to PHY" on MPC8349e-MITX
References: <ed82fe3e0812040915i696e99bep75a37b0e38154415@mail.gmail.com>
	<49381662.2020302@matrix-vision.de>
In-Reply-To: <49381662.2020302@matrix-vision.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, afleming@freescale.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andre Schwarz wrote:
> Timur,
> 
> is it possible that the PHY adress doesn't match the one specified in
> the dts ?

What part of the DTS contains the PHY address?  I have this:

	mdio@24520 {
		#address-cells = <1>;
		#size-cells = <0>;
		compatible = "fsl,gianfar-mdio";
		reg = <0x24520 0x20>;

		/* Vitesse 8201 */
		phy1c: ethernet-phy@1c {
			interrupt-parent = <&ipic>;
			interrupts = <18 0x8>;
			reg = <0x1c>;
			device_type = "ethernet-phy";
		};
	};

	enet1: ethernet@25000 {
		cell-index = <1>;
		device_type = "network";
		model = "TSEC";
		compatible = "gianfar";
		reg = <0x25000 0x1000>;
		local-mac-address = [ 00 00 00 00 00 00 ];
		interrupts = <35 0x8 36 0x8 37 0x8>;
		phy-connection-type = "mii";
		interrupt-parent = <&ipic>;
		/* Vitesse 7385 isn't on the MDIO bus */
		fixed-link = <1 1 1000 0 0>;
		linux,network-index = <1>;
	};

-- 
Timur Tabi
Linux kernel developer at Freescale
