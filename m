Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id C4C6FDDE1F
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2008 04:56:42 +1100 (EST)
Message-ID: <493819D8.8040300@matrix-vision.de>
Date: Thu, 04 Dec 2008 18:56:40 +0100
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: "eth1: Could not attach to PHY" on MPC8349e-MITX
References: <ed82fe3e0812040915i696e99bep75a37b0e38154415@mail.gmail.com>
	<49381662.2020302@matrix-vision.de>
	<493817AE.1070303@freescale.com>
In-Reply-To: <493817AE.1070303@freescale.com>
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

Timur Tabi schrieb:
> Andre Schwarz wrote:
>   
>> Timur,
>>
>> is it possible that the PHY adress doesn't match the one specified in
>> the dts ?
>>     
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
>   
Your PHY is not on the MDIO bus, i.e. can not be programmed or queried.
Maybe your kernel lacks the mdio-less configuration ?
> 		/* Vitesse 7385 isn't on the MDIO bus */
> 		fixed-link = <1 1 1000 0 0>;
> 		linux,network-index = <1>;
> 	};
>
>   


MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
