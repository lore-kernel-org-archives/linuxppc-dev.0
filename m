Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 5A29C67B53
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jun 2006 14:46:59 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k5U63wRr007147
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jun 2006 00:03:58 -0600 (MDT)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k5U4kts0013802
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jun 2006 23:46:57 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD467306E04FE9@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: "'Kumar Gala'" <galak@kernel.crashing.org>
Subject: RE: [FYI] dts file for MPC8360EPB support
Date: Fri, 30 Jun 2006 12:46:52 +0800
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Best Regards,
Leo


> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Friday, June 30, 2006 12:12 PM
> To: Li Yang-r58472
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [FYI] dts file for MPC8360EPB support
> 
> 
> > // QE
> > 	qe@e0100000 {
> > 		#address-cells = <1>;
> > 		#size-cells = <1>;
> > 		#interrupt-cells = <2>;
> > 		device_type = "qe";
> > 		model = "QE";
> > 		ranges = <0 e0100000 00100000>;
> > 		reg = <e0100000 480>;
> > 		brg-frequency = <0>;
> > 		bus-frequency = <179A7B00>;
> >
> > 		spi@4c0 {
> > 			device_type = "spi";
> > 			compatible = "fsl_spi";
> > 			reg = <4c0 40>;
> > 			interrupts = <82 0>;
> > 			interrupt-parent = <700>;
> > 			mode = "cpu";
> > 		};
> >
> > 		spi@500 {
> > 			device_type = "spi";
> > 			compatible = "fsl_spi";
> > 			reg = <500 40>;
> > 			interrupts = <81 0>;
> > 			interrupt-parent = <700>;
> > 			mode = "cpu";
> > 		};
> >
> > 		brg@640 {
> > 			device_type = "brg";
> > 			reg = <668 4>;
> > 		};
> 
> brg isn't described in your patch to the flat dev tree spec.

After discussion with Vitaly, I removed it from the spec as it is not used currently.  We will add it in, when it is necessary.  I forgot to update my dts file though  :)
> 
> >
> > 		usb@6c0 {
> > 			device_type = "usb";
> > 			compatible = "qe_udc";
> > 			reg = <6c0 40>;
> > 			reg_pram = <8B00 100>;
> > 			interrupts = <8b 0>;
> > 			interrupt-parent = <700>;
> > 			mode = "slave";
> > 		};
> >
> > 		ucc@2000 {
> > 			device_type = "network";
> > 			compatible = "ucc_geth";
> > 			model = "UCC";
> > 			device-id = <1>;
> > 			reg = <2000 200 8400 100>;
> > 			interrupts = <a0 0>;
> > 			interrupt-parent = <700>;
> > 			mac-address = [ 00 04 9f 00 23 23 ];
> > 			rx-clock = <0>;
> > 			tx-clock = <19>;
> > 			phy-handle = <212000>;
> > 			pio-handle = <140001>;
> > 		};
> >
> > 		ucc@3000 {
> > 			device_type = "network";
> > 			compatible = "ucc_geth";
> > 			model = "UCC";
> > 			device-id = <2>;
> > 			reg = <3000 200 8500 100>;
> > 			interrupts = <a1 0>;
> > 			interrupt-parent = <700>;
> > 			mac-address = [ 00 11 22 33 44 55 ];
> > 			rx-clock = <0>;
> > 			tx-clock = <14>;
> > 			phy-handle = <212001>;
> > 			pio-handle = <140002>;
> > 		};
> >
> > 		mdio@2120 {
> > 			#address-cells = <1>;
> > 			#size-cells = <0>;
> > 			reg = <2120 18>;
> > 			device_type = "mdio";
> > 			compatible = "ucc_geth_phy";
> >
> > 			ethernet-phy@00 {
> > 				linux,phandle = <212000>;
> > 				interrupt-parent = <700>;
> > 				interrupts = <11 1>;
> > 				reg = <0>;
> > 				device_type = "ethernet-phy";
> > 				interface = <6>; //ENET_1000_GMII
> > 			};
> > 			ethernet-phy@01 {
> > 				linux,phandle = <212001>;
> > 				interrupt-parent = <700>;
> > 				interrupts = <12 1>;
> > 				reg = <1>;
> > 				device_type = "ethernet-phy";
> > 				interface = <6>;
> > 			};
> > 		};
> >
> > 	};
> > };
> >
> >
> > --
> > Leo Li
> > Freescale Semiconductor
> >
> > LeoLi@freescale.com
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
