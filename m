Return-Path: <pannir@xsmail.com>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D583F1A0401
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jun 2014 20:35:01 +1000 (EST)
Message-Id: <1402655698.25732.128363405.372AD838@webmail.messagingengine.com>
From: Pannirselvam Kanagaratnam <pannir@xsmail.com>
To: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: Device Tree Binding for DSA on P1023RDB
Date: Fri, 13 Jun 2014 18:34:58 +0800
In-Reply-To: <1402608088.6603.549.camel@snotra.buserror.net>
References: <5399C8F2.8060108@xsmail.com>
 <1402608088.6603.549.camel@snotra.buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Fri, Jun 13, 2014, at 05:21 AM, Scott Wood wrote:
> On Thu, 2014-06-12 at 23:36 +0800, Pannirselvam Kanagaratnam wrote:
> > The QORIQ P1023RDB has an option to populate the Marvell 88E6165
> > Ethernet switch. We populated this device and was able to initialize
> > it as a basic switch in U-Boot. However, the switch driver was not
> > loaded upon kernel bootup. DSA kernel config was enabled for the
> > 88E6165. The following patch was applied:
> > 
> > 
> > http://patchwork.ozlabs.org/patch/230257/
> > 
> > 
> > The switch is attached to phy address 0x3 via dtsec2. My dts file is
> > as below. Would appreciate any feedback on whether the DSA is
> > correctly structured in the dts.
> 
> If you have a dtsec driver you're not working with an upstream kernel
> (or you've ported a lot of SDK code to it)...  What tree are you working
> with?  Are there prerequisites to the above patch that you might be
> missing?
> 

I am using QorIQ-SDK-V1.5-20131219-yocto (3.8-r11.1). Not sure if I am
missing
any prerequisites. 

> The above patch is a platform driver and you put the node in the
> toplevel device tree node.  Have you added marvell,dsa to the list of
> compatible strings that get probed (of_device_ids in corenet_generic.c
> or an equivalent list in your SDK kernel)?
> > 

I was missing this. I added it in arch/powerpc/platforms/85xx/common.c

After adding the above, the driver is now attempting to probe. However,
I got the following message:

Distributed Switch Architecture driver version 0.1
dsa: probe of dsa.16 failed with error -22

I dumped the mdio, mdio_bus and ethernet parameters:

1) For mdio = of_parse_phandle(np, "dsa,mii-bus", 0); I get the
following:
np-name: dsa
mdio-name: mdio
mdio-type: <NULL>
mdio-full-name: /soc@ff600000/fman@100000/mdio@e1120 

2) mdio_bus = of_mdio_find_bus(mdio);
mdio_bus_name: Freescale PowerQUICC MII Bus
mdio_bus_id: mdio@ff7e1120

3) ethernet = of_parse_phandle(np, "dsa,ethernet", 0);
ethernet-name: ethernet
ethernet-type: <NULL>
ethernet-full-name: /soc@ff600000/fman@100000/ethernet@e2000

Anything amiss here?

> >     dsa@0 {
> >             compatible = "marvell,dsa";
> >             #address-cells = <2>;
> >             #size-cells = <0>;
> > 
> >             interrupts = <3>;
> 
> This interrupts property needs to be four cells rather than one, if MPIC
> is the parent -- assuming you have #interrupt-cells = <4> and not some
> old device tree with #interrupt-cells = <2>, but in any case you need
> more than one cell.
> 

The interrupt is an optional entry and not supported by the driver. I
have omitted it for now.

Pannir
