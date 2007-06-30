Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id C37AFDDF86
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  1 Jul 2007 00:02:58 +1000 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'Andy Fleming'" <afleming@freescale.com>
Subject: RE: 83xx: requesting external interrupts
Date: Sat, 30 Jun 2007 16:02:50 +0200
Message-ID: <004501c7bb1f$58c84a50$0e67a8c0@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1B23F0C1-3BDF-434B-BF90-E75BB4C3994B@freescale.com>
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

 

> -----Original Message-----
> From: Andy Fleming [mailto:afleming@freescale.com] 
> Sent: den 30 juni 2007 01:55
> To: Joakim Tjernlund
> Cc: bwarren@qstreams.com; linuxppc-embedded@ozlabs.org
> Subject: Re: 83xx: requesting external interrupts
> 
> 
> On Jun 29, 2007, at 06:34, Joakim Tjernlund wrote:
> > mdio@2320 {
> > 			#address-cells = <1>;
> > 			#size-cells = <0>;
> > 			reg = <2320 18>;
> > 			device_type = "mdio";
> > 			compatible = "ucc_geth_phy";
> >
> > 			phy1: ethernet-phy@0 {
> > 				interrupt-parent = <&ipic>;
> > 				interrupts = <12 2>; //EXT IRQ2
> > 				reg = <0>; // 0
> > 				device_type = "ethernet-phy";
> > 				interface = <3>; //ENET_100_MII
> > 			};
> >
> > Now the things is that the IRQ works with and without the
> >  /* All external IRQs + Generic timer IRQs must be initialized by  
> > BSP */
> >  const int bsp_irqs[] = {48, 17, 18, 19, 20, 21, 22, 23, 90, 78,  
> > 84, 72};
> >  for (i=0;i<sizeof(bsp_irqs)/sizeof(bsp_irqs[0]);i++)
> > 	virq = irq_create_mapping(NULL, bsp_irqs[i]);
> 
> 
> This isn't how to use the device tree.  That is, you *aren't* using  
> the device tree.  You want to read the node of every device you want  
> to set up, and create the mapping.  Look at irq_of_parse_and_map().   
> Look in include/asm-powerpc/prom.h, at of_irq_to_resource(), which  
> maps an irq in the device tree.

I use both!
I see that ipic.c does all the work for me, so I should just drop
the above code. It is strange though that the virq # changes if
I keep the code.

hmm, maybe if I sort the bsp_irqs[] list numerically it will be the same?
Am at home ATM so I can't verify.

 Jocke
