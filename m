Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0103.outbound.protection.outlook.com [157.56.111.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F0E5E1A0676
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 11:14:48 +1100 (AEDT)
Message-ID: <1444868072.5185.214.camel@freescale.com>
Subject: Re: devicetree and IRQ7 mapping for T1042(mpic)
From: Scott Wood <scottwood@freescale.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 14 Oct 2015 19:14:32 -0500
In-Reply-To: <1444867898.5185.213.camel@freescale.com>
References: <1444851451.28972.59.camel@transmode.se>
 <1444867898.5185.213.camel@freescale.com>
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

On Wed, 2015-10-14 at 19:11 -0500, Scott Wood wrote:
> On Wed, 2015-10-14 at 19:37 +0000, Joakim Tjernlund wrote:
> > I am trying to figure out how to describe/map external IRQ7 in the 
> > devicetree.
> > 
> > Basically either IRQ7 to be left alone by Linux(becase u-boot already set 
> > it up)
> > or map IRQ7 to sie 0(MPIC_EILR7=0xf0) and prio=0xf(MPIC_EIVPR7=0x4f0000)
> > 
> > There is no need for SW handler because IRQ7 will be routed to the DDR 
> > controller
> > and case an automatic Self Refresh just before CPU reset.
> > 
> > I cannot figure out how to do this. Any ideas?
> > 
> > If not possible from devicetree, then can one do it from board code?
> 
> The device tree describes the hardware.  Priority is configuration, and 
> thus 
> doesn't belong there.  You can call mpic_irq_set_priority() from board code.
> 
> Likewise, the fact that you want to route irq7 to sie0 is configuration, 
> not 
> hardware description.  At most, the device tree should describe is what is 
> connected to each sie output.  There's no current Linux support for routing 
> an interrupt to sie or anything other than "int".

BTW, priority is meaningless for interrupts routed to sie.

-Scott
