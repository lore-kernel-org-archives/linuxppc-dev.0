Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 69D37DDE0F
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2008 04:56:35 +1100 (EST)
Date: Thu, 4 Dec 2008 20:56:34 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: "eth1: Could not attach to PHY" on MPC8349e-MITX
Message-ID: <20081204175634.GA31505@oksana.dev.rtsoft.ru>
References: <ed82fe3e0812040915i696e99bep75a37b0e38154415@mail.gmail.com>
	<49381662.2020302@matrix-vision.de>
	<493817AE.1070303@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <493817AE.1070303@freescale.com>
Cc: Andre Schwarz <andre.schwarz@matrix-vision.de>, netdev@vger.kernel.org,
	afleming@freescale.com, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 04, 2008 at 11:47:26AM -0600, Timur Tabi wrote:
> Andre Schwarz wrote:
> > Timur,
> > 
> > is it possible that the PHY adress doesn't match the one specified in
> > the dts ?
> 
> What part of the DTS contains the PHY address?  I have this:
> 
> 	mdio@24520 {
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 		compatible = "fsl,gianfar-mdio";
> 		reg = <0x24520 0x20>;
> 
> 		/* Vitesse 8201 */
> 		phy1c: ethernet-phy@1c {
> 			interrupt-parent = <&ipic>;
> 			interrupts = <18 0x8>;
> 			reg = <0x1c>;
> 			device_type = "ethernet-phy";
> 		};
> 	};
> 
> 	enet1: ethernet@25000 {
> 		cell-index = <1>;
> 		device_type = "network";
> 		model = "TSEC";
> 		compatible = "gianfar";
> 		reg = <0x25000 0x1000>;
> 		local-mac-address = [ 00 00 00 00 00 00 ];
> 		interrupts = <35 0x8 36 0x8 37 0x8>;
> 		phy-connection-type = "mii";
> 		interrupt-parent = <&ipic>;
> 		/* Vitesse 7385 isn't on the MDIO bus */
> 		fixed-link = <1 1 1000 0 0>;

^^^ That one. The Vitesse 7385 isn't on the MDIO bus, so the fixed
link (drivers/net/phy/fixed.c) driver is used for this ethernet port.

> 		linux,network-index = <1>;
> 	};

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
