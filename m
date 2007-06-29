Return-Path: <afleming@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BA508DDF88
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Jun 2007 09:55:01 +1000 (EST)
In-Reply-To: <1183116892.20673.66.camel@gentoo-jocke.transmode.se>
References: <46434C1E.3020004@cambridgebroadband.com>
	<1178816847.9018.2.camel@saruman.qstreams.net>
	<46443784.3060600@cambridgebroadband.com>
	<1178892748.9018.13.camel@saruman.qstreams.net>
	<1183116892.20673.66.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1B23F0C1-3BDF-434B-BF90-E75BB4C3994B@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: 83xx: requesting external interrupts
Date: Fri, 29 Jun 2007 18:54:52 -0500
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 29, 2007, at 06:34, Joakim Tjernlund wrote:
> mdio@2320 {
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 			reg = <2320 18>;
> 			device_type = "mdio";
> 			compatible = "ucc_geth_phy";
>
> 			phy1: ethernet-phy@0 {
> 				interrupt-parent = <&ipic>;
> 				interrupts = <12 2>; //EXT IRQ2
> 				reg = <0>; // 0
> 				device_type = "ethernet-phy";
> 				interface = <3>; //ENET_100_MII
> 			};
>
> Now the things is that the IRQ works with and without the
>  /* All external IRQs + Generic timer IRQs must be initialized by  
> BSP */
>  const int bsp_irqs[] = {48, 17, 18, 19, 20, 21, 22, 23, 90, 78,  
> 84, 72};
>  for (i=0;i<sizeof(bsp_irqs)/sizeof(bsp_irqs[0]);i++)
> 	virq = irq_create_mapping(NULL, bsp_irqs[i]);


This isn't how to use the device tree.  That is, you *aren't* using  
the device tree.  You want to read the node of every device you want  
to set up, and create the mapping.  Look at irq_of_parse_and_map().   
Look in include/asm-powerpc/prom.h, at of_irq_to_resource(), which  
maps an irq in the device tree.


Andy
