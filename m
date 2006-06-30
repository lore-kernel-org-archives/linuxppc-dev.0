Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BCE3067B34
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jun 2006 14:11:57 +1000 (EST)
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467306E04FE8@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD467306E04FE8@zch01exm40.ap.freescale.net>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2DBCF828-2B92-48A3-9937-1B6D0818AF5B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [FYI] dts file for MPC8360EPB support
Date: Thu, 29 Jun 2006 23:11:51 -0500
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> // QE
> 	qe@e0100000 {
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		#interrupt-cells = <2>;
> 		device_type = "qe";
> 		model = "QE";
> 		ranges = <0 e0100000 00100000>;
> 		reg = <e0100000 480>;
> 		brg-frequency = <0>;
> 		bus-frequency = <179A7B00>;
>
> 		spi@4c0 {
> 			device_type = "spi";
> 			compatible = "fsl_spi";
> 			reg = <4c0 40>;
> 			interrupts = <82 0>;
> 			interrupt-parent = <700>;
> 			mode = "cpu";
> 		};
>
> 		spi@500 {
> 			device_type = "spi";
> 			compatible = "fsl_spi";
> 			reg = <500 40>;
> 			interrupts = <81 0>;
> 			interrupt-parent = <700>;
> 			mode = "cpu";
> 		};
>
> 		brg@640 {
> 			device_type = "brg";
> 			reg = <668 4>;
> 		};

brg isn't described in your patch to the flat dev tree spec.

>
> 		usb@6c0 {
> 			device_type = "usb";
> 			compatible = "qe_udc";
> 			reg = <6c0 40>;
> 			reg_pram = <8B00 100>;
> 			interrupts = <8b 0>;
> 			interrupt-parent = <700>;
> 			mode = "slave";
> 		};
>
> 		ucc@2000 {
> 			device_type = "network";
> 			compatible = "ucc_geth";
> 			model = "UCC";
> 			device-id = <1>;
> 			reg = <2000 200 8400 100>;
> 			interrupts = <a0 0>;
> 			interrupt-parent = <700>;
> 			mac-address = [ 00 04 9f 00 23 23 ];
> 			rx-clock = <0>;
> 			tx-clock = <19>;
> 			phy-handle = <212000>;
> 			pio-handle = <140001>;
> 		};
>
> 		ucc@3000 {
> 			device_type = "network";
> 			compatible = "ucc_geth";
> 			model = "UCC";
> 			device-id = <2>;
> 			reg = <3000 200 8500 100>;
> 			interrupts = <a1 0>;
> 			interrupt-parent = <700>;
> 			mac-address = [ 00 11 22 33 44 55 ];
> 			rx-clock = <0>;
> 			tx-clock = <14>;
> 			phy-handle = <212001>;
> 			pio-handle = <140002>;
> 		};
>
> 		mdio@2120 {
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 			reg = <2120 18>;
> 			device_type = "mdio";
> 			compatible = "ucc_geth_phy";
>
> 			ethernet-phy@00 {
> 				linux,phandle = <212000>;
> 				interrupt-parent = <700>;
> 				interrupts = <11 1>;
> 				reg = <0>;
> 				device_type = "ethernet-phy";
> 				interface = <6>; //ENET_1000_GMII
> 			};
> 			ethernet-phy@01 {
> 				linux,phandle = <212001>;
> 				interrupt-parent = <700>;
> 				interrupts = <12 1>;
> 				reg = <1>;
> 				device_type = "ethernet-phy";
> 				interface = <6>;
> 			};
> 		};
> 		
> 	};
> };
>
>
> --
> Leo Li
> Freescale Semiconductor
>
> LeoLi@freescale.com
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
