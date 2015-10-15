Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0113.outbound.protection.outlook.com [157.56.111.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 433AE1A06C1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 18:14:45 +1100 (AEDT)
Message-ID: <1444893272.5185.243.camel@freescale.com>
Subject: Re: devicetree and IRQ7 mapping for T1042(mpic)
From: Scott Wood <scottwood@freescale.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 15 Oct 2015 02:14:32 -0500
In-Reply-To: <1444893103.28972.68.camel@transmode.se>
References: <1444851451.28972.59.camel@transmode.se>
 <1444867898.5185.213.camel@freescale.com>
 <1444893103.28972.68.camel@transmode.se>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-10-15 at 07:11 +0000, Joakim Tjernlund wrote:
> On Wed, 2015-10-14 at 19:11 -0500, Scott Wood wrote:
> > On Wed, 2015-10-14 at 19:37 +0000, Joakim Tjernlund wrote:
> > > I am trying to figure out how to describe/map external IRQ7 in the 
> > > devicetree.
> > > 
> > > Basically either IRQ7 to be left alone by Linux(becase u-boot already 
> > > set 
> > > it up)
> > > or map IRQ7 to sie 0(MPIC_EILR7=0xf0) and prio=0xf(MPIC_EIVPR7=0x4f0000)
> > > 
> > > There is no need for SW handler because IRQ7 will be routed to the DDR 
> > > controller
> > > and case an automatic Self Refresh just before CPU reset.
> > > 
> > > I cannot figure out how to do this. Any ideas?
> > > 
> > > If not possible from devicetree, then can one do it from board code?
> > 
> > The device tree describes the hardware.  Priority is configuration, and 
> > thus 
> > doesn't belong there.  You can call mpic_irq_set_priority() from board 
> > code.
> 
> Right.
> 
> > 
> > Likewise, the fact that you want to route irq7 to sie0 is configuration, 
> > not 
> > hardware description.  At most, the device tree should describe is what 
> > is 
> > connected to each sie output.  There's no current Linux support for 
> > routing 
> > an interrupt to sie or anything other than "int".
> 
> That explains why I could not find any mpic function for that ..
> 
> I found mpic dev. trees property "protected-sources" which might do what I 
> want, just
> leave the the irq alone but I cannot figure out what value to write there.
> Could you give me any example how to calculate dev. tree irq number for 
> IRQ7?
> 
> The mpic.txt mentions "Interrupt Source Configuration Registers" but google 
> did
> not turn up anything useful for me.

The device tree number for external IRQ 7 is 7.  Another option is to use the 
pic-no-reset property.

-Scott
