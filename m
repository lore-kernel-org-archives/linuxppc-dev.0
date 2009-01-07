Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 2C2EC47755
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 09:50:50 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 07 Jan 2009 23:50:48 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <20090107190718.GA17427@ld0162-tx32.am.freescale.net>
Message-ID: <20090107225048.23020@gmx.net>
MIME-Version: 1.0
References: <20090107135457.234150@gmx.net>
	<20090107190718.GA17427@ld0162-tx32.am.freescale.net>
Subject: Re: [PATCH 2/5] powerpc: Generic device tree for all AmigaOne boards
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Wed, 7 Jan 2009 09:41:14 -0700
> Von: "Grant Likely" <grant.likely@secretlab.ca>
> An: "Gerhard Pircher" <gerhard_pircher@gmx.net>
> CC: linuxppc-dev@ozlabs.org
> Betreff: Re: [PATCH 2/5] powerpc: Generic device tree for all AmigaOne boards

> Sounds to me like you need different device tree variants for each of
> the AmigaOne boards.  Do any of the boards have physical PCI slots?
> If so, then the lack of an interrupt map will break them.
Yes, all AmigaOne boards have physical PCI slots (at least 1). The different
interrupt routing wasn't a problem so far, as the firmware writes the IRQ number
to the interrupt line register of every PCI device.
Currently the kernel reads the IRQ number from this register, if there is no
interrupt mapping property. I know that it's not a good idea to rely on kernel
fallback behavior, but it makes a lot of things easier in this case.

> > +/ {
> > +       model = "AmigaOne";
> > +       compatible = "eyetech,amigaone","mai-logic,teron";
> 
> Experience has shown that trying to claim one board to be compatible
> with another is too ambiguous.  It is better to make the board level
> compatible property have a single value specifying the exact board
> model and have the platform support code include a list of supported
> board models.  Otherwise you end up with odd heuristic code to try and
> differentiate between the models (for bug fixes and such).
Okay, I'll remove the "mai-logic,teron" entry. I have never seen a MAI Teron
in the wild, so I can't even tell if it uses a U-boot firmware.

> > +               host@0 {
> > +                       compatible = "pciclass,0600";
> > +                       vendor-id = <0x000010cc>;
> > +                       device-id = <0x00000660>;
> > +                       revision-id = <0x00000001>;
> > +                       class-code = <0x00060000>;
> > +                       subsystem-id = <0>;
> > +                       subsystem-vendor-id = <0>;
> > +                       devsel-speed = <0x00000001>;
> > +                       66mhz-capable;
> > +                       min-grant = <0>;
> > +                       max-latency = <0>;
> > +                       // AGP aperture is unset.
> > +//                     reg = <0x42000010 0 0x00000000 0 0x00400000>;
> > +//                     assigned-addresses = <0x42000010 0 0x00000000 0
> 0x00400000>;
> > +               };
> 
> What does this node describe?  Is it something that isn't probeable?
Yes, the information in this node is probeable. Originally I planned to add
some child nodes to this node, as the PCI host bridge contains other PCI
functions (e.g. power management) which are not probeable. The host bridge
has an index register, which switches between the host bridge config space
and the config space of the other PCI functions. I don't know yet how this is
described correctly in a device tree, so I'll probably remove this node for now.

> > +                       8042@60 {
> > +                               device_type = "8042";
> > +                               reg = <1 0x00000060 0x00000001
> > +                                      1 0x00000064 0x00000001>;
> > +                               // IRQ1, IRQ12 (rising edge)
> > +                               interrupts = <1 3 12 3>;
> 
> For the flattened device tree, I think we've settled on the convention
> that every node with an IRQ connection should have both the
> interrupt-parent and interrupts properties.  (ie. don't rely on the
> parent node's interrupt-parent property.)
Even for ISA devices?

> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +
> > +                               keyboard@0 {
> > +                                       device_type = "keyboard";
> 
> Drop device type in the flattened tree.  There are a few places where
> you still need to have it for Linux to work; but it Linux doesn't look
> for it, then don't add it.
Okay.

> > +                       serial@3f8 {
> > +                               device_type = "serial";
> > +                               compatible = "pnpPNP,501","pnpPNP,500";
> > +                               reg = <1 0x000003f8 0x00000008>;
> > +                               // IRQ4 (rising edge)
> > +                               interrupts = <4 3>;
> > +                               clock-frequency = <1843200>;
> > +                               current-speed = <115200>;
> > +                       };
> > +
> > +                       serial@2f8 {
> > +                               device_type = "serial";
> > +                               compatible = "pnpPNP,501","pnpPNP,500";
> > +                               reg = <1 0x000002f8 0x00000008>;
> > +                               // IRQ3 (rising edge)
> > +                               interrupts = <3 3>;
> > +                               clock-frequency = <1843200>;
> > +                               current-speed = <115200>;
> > +                       };
> > +
> > +                       parallel@378 {
> > +                               device_type = "parallel";
> > +                               // No ECP support for now, otherwise add
> "pnpPNP,401".
> > +                               compatible = "pnpPNP,400";
> > +                               reg = <1 0x00000378 0x00000003
> > +                                      1 0x00000778 0x00000003>;
> > +/*                             interrupts = <7 0>; */
> > +                               // Parallel port DMA mode unknown.
> > +/*                             dma = <0x3 0x0 0x0 0x0>; */
> > +                       };
> > +
> > +                       fdc@3f0 {
> > +                               device_type = "fdc";
> > +                               compatible = "pnpPNP,700";
> > +                               reg = <1 0x000003f0 0x00000008>;
> > +                               // IRQ6 (rising edge)
> > +                               interrupts = <6 3>;
> > +                               // Floppy DMA mode unknown.
> > +/*                             dma = < >; */
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +
> > +                               disk@0 {
> > +                                       device_type = "block";
> > +                                       reg = <0>;
> > +                               };
> > +                       };
> > +               };
> > +
> > +               ide@7,1 {
> > +                       compatible = "pciclass,01018a";
> > +                       vendor-id = <0x00001106>;
> > +                       device-id = <0x00000571>;
> > +                       revision-id = <0x00000006>;
> 
> Can this PCI device be probed?  Typically PCI devices don't get added
> to the flattened device tree because PCI is a probeable bus.
Yes, it can be probed. I thought it would be a good idea to include it,
because the IDE controller operates in legacy mode. I planned to specify the
two legacy interrupts in this node (as you can see), but the kernel didn't like
them.

Thanks!

Gerhard

-- 
Sensationsangebot verlängert: GMX FreeDSL - Telefonanschluss + DSL 
für nur 16,37 Euro/mtl.!* http://dsl.gmx.de/?ac=OM.AD.PD003K1308T4569a
