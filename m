Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D0393B70DA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Feb 2011 19:47:39 +1100 (EST)
Subject: RE: Open Firmware and interrupt trigger
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Robert Thorhuus <robert.thorhuus@ericsson.com>
In-Reply-To: <9081694521850B4D91387C8C2E612B591062A0DD26@ESESSCMS0361.eemea.ericsson.se>
References: <20110223043015.20795.37090.stgit@localhost6.localdomain6>
	<20110223043345.20795.2936.stgit@localhost6.localdomain6>
	<4D6551EF.70207@gmail.com>
	<9081694521850B4D91387C8C2E612B591062A0D5CA@ESESSCMS0361.eemea.ericsson.se>
	<1298580418.8833.428.camel@pasglop>
	<9081694521850B4D91387C8C2E612B591062A0DD26@ESESSCMS0361.eemea.ericsson.se>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 25 Feb 2011 19:47:29 +1100
Message-ID: <1298623649.8833.603.camel@pasglop>
Mime-Version: 1.0
Cc: "avorontsov@mvista.com" <avorontsov@mvista.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-02-25 at 08:29 +0100, Robert Thorhuus wrote:
> Thank you Benjamin!
> 
> Sorry for not using your qouting schema :(
> 
> Benjamin, you are right about the IRQ flags. Those interrupt.h flags
> seems to differ from my processor reference manual.

Check the bindings or the driver. IE. What interrupt controller does
your board/processor use ? Use the flags defined by the device-tree
bindings for that controller.

> None the less. Antov, I saw that the code snippet I refer to below:
> 
> > 	ret = of_irq_to_resource(dn, 0, &irq_res);
> > 	if (ret == NO_IRQ)
> > 		irq_res.start = irq_res.end = 0;
> > 	else
> > 		irq_res.flags = 0;
> 
> , originates from the first version of the file pata_of_platform.c and
> you are the creator :)

I don't think so :-)

>From the git commit logs:

Author: Anton Vorontsov <avorontsov@ru.mvista.com>  2008-01-10 06:10:41
Committer: Olof Johansson <olof@lixom.net>  2008-01-16 03:23:43

> Could you explain the hardcoded ".flags = 0" part? 
> Looking amatuer-vise in the code it seems that the only thing one is
> able to control (through Device Tree) regarding interrupts and pata,
> is the actual IRQ number. Is this a correct assumption?

I think the trick is that of_irq_to_resource() will establish the right
trigger settings already, so the flags might not be relevant from a
driver standpoint. 0 means use the default as established by
of_irq_to_resource() when it creates the interrupt mapping for that
interrupt.

I suspect the problem might be the value in your device-tree being
incorrect. You need to dbl check the binding (ie. the definition of that
value for your specific type of interrupt controller). You won't find
that in the processor documentation but rather in the binding document
describing the way that interrupt controller is represented in a
device-tree.

Tell us what the interrupt controller is (what your platform/processor
is) and we should be able to help you get it right.

Cheers,
Ben.

> Thanks
> BR
> Robert
> 
> 
> -----Original Message-----
> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org] 
> Sent: den 24 februari 2011 21:47
> To: Robert Thorhuus
> Cc: linuxppc-dev@lists.ozlabs.org
> Subject: Re: Open Firmware and interrupt trigger
> 
> On Wed, 2011-02-23 at 22:18 +0100, Robert Thorhuus wrote:
> > Hello!
> > 
> > I'm quite new to linux and Open Firmware.
> > 
> > I have a PPC processor. To this I have a Compact Flash connected.
> The Compact Flash is using external interrupt 0 of the processor.
> > In my DTS file I have specified a Compact Flash node and within it I
> have an interrupt element:
> > interrupt = <0 2 0 0>;
> > 
> > Here I thought the first number was the ID of the interrupt and the
> second one should be a number indicating how the interrupt is
> triggered (high, low, raising, falling).
> > 
> > The interrupt is active low.
> > 
> > But I could not get it to work which ever value I chose.
> > 
> > Looking in the code I found this in function __devinit
> pata_of_platform_probe in file pata_of_platform.c:
> > 
> > 	ret = of_irq_to_resource(dn, 0, &irq_res);
> > 	if (ret == NO_IRQ)
> > 		irq_res.start = irq_res.end = 0;
> > 	else
> > 		irq_res.flags = 0;
> > 
> > Here "flags" will be zero whatever I do in the DTS. As far as I can
> understand the flags are defined in interrupts.h:
> > #define IRQF_TRIGGER_NONE       0x00000000
> > #define IRQF_TRIGGER_RISING     0x00000001
> > #define IRQF_TRIGGER_FALLING    0x00000002
> > #define IRQF_TRIGGER_HIGH       0x00000004
> > #define IRQF_TRIGGER_LOW        0x00000008
> 
> Actually, the .dts flags depend on the specific interrupt controller
> you are using. For example, MPIC uses a different mapping scheme (for
> historical reasons). Check booting-without-of.txt.
> 
> > So modifying the code to:
> > 	else
> > 		irq_res.flags = 2;
> > 
> > I get it to work.
> > 
> > Could someone please explain to me why the "flags" parameter is
> hardcoded zero or just point in a good direction.
> 
> That does indeed look odd. Might be worth trying to figure out with
> the git history who came up with that code in the first place and ask
> that person. Without answer, I think it's valid to patch that out.
> 
> Cheers,
> Ben.
> 
> > Thank you
> > 
> > BR
> > Robert
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
