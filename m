Return-Path: <bwarren@qstreams.com>
Received: from smtp102.biz.mail.re2.yahoo.com (smtp102.biz.mail.re2.yahoo.com
	[68.142.229.216]) by ozlabs.org (Postfix) with SMTP id 25F8BDDFA9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Jun 2007 02:50:39 +1000 (EST)
Subject: Re: 83xx: requesting external interrupts
From: Ben Warren <bwarren@qstreams.com>
To: joakim.tjernlund@transmode.se
In-Reply-To: <1183116892.20673.66.camel@gentoo-jocke.transmode.se>
References: <46434C1E.3020004@cambridgebroadband.com>
	<1178816847.9018.2.camel@saruman.qstreams.net>
	<46443784.3060600@cambridgebroadband.com>
	<1178892748.9018.13.camel@saruman.qstreams.net>
	<1183116892.20673.66.camel@gentoo-jocke.transmode.se>
Content-Type: text/plain
Date: Fri, 29 Jun 2007 12:43:55 -0400
Message-Id: <1183135436.20367.28.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Jocke,

On Fri, 2007-06-29 at 13:34 +0200, Joakim Tjernlund wrote:
<snip>
> I too am adding such a IRQ for my PHY connected to external IRQ2.
> The PHY is connetced to UCC2.
> I have this in my DTS for the PHY:
> 	mdio@2320 {
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
>  /* All external IRQs + Generic timer IRQs must be initialized by BSP */
>  const int bsp_irqs[] = {48, 17, 18, 19, 20, 21, 22, 23, 90, 78, 84, 72};
>  for (i=0;i<sizeof(bsp_irqs)/sizeof(bsp_irqs[0]);i++)
> 	virq = irq_create_mapping(NULL, bsp_irqs[i]);
> code in my bsp. There is one difference though.
> Printing the irq num in phy_interrupt:
> static irqreturn_t phy_interrupt(int irq, void *dev_id)
> {
> 	struct net_device *dev = (struct net_device *)dev_id;
> 	struct ucc_geth_private *ugeth = netdev_priv(dev);
> 
> 	ugeth_vdbg("%s: IN", __FUNCTION__);
> 	printk(KERN_ERR "PHY IRQ:%d \n", irq);
> 
> Shows a difference:
> with the bsp code added it prints:
> PHY IRQ:18
> and when I remove the bsp code it prints:
> PHY IRQ:19
> 
> So what is correct, should I add the bsp code or not?
> 
>  Jocke
I had to add this board initialization code because on my CPU (8349),
certain interrupts weren't automatically mapped by built-in kernel code.
Interrupts simply weren't firing, because they hadn't been enabled in
the IPIC.  Your case is different, because the MDIO device tree entry is
parsed by common code (arch/powerpc/sysdev/something).  

You probably don't need to explicitly map IRQs unless they're being used
by custom device drivers.  I don't know why you'd get a different
virtual mapping, though.  I guess you're effectively mapping the same
IRQ twice, and I don't know what that does.  Part of me wants to say "if
it works properly, who cares", but that's how we get into trouble...

Somebody like Kumar Gala could probably provide a real answer. 

regards,
Ben
