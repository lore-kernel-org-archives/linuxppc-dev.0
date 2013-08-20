Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 04DC62C010E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2013 09:20:21 +1000 (EST)
Message-ID: <1377040803.3370.88.camel@snotra.buserror.net>
Subject: Re: [RFC PATCH 1/1] powerpc/embedded6xx: Add support for
 Motorola/Emerson MVME5100.
From: Scott Wood <scottwood@freescale.com>
To: Stephen N Chivers <schivers@csc.com.au>
Date: Tue, 20 Aug 2013 18:20:03 -0500
In-Reply-To: <OFE172B06C.BE11BDC5-ONCA257BCC.007C0097-CA257BCD.000D984C@csc.com>
References: <OFBCFBBD51.E4ECB0DF-ONCA257BC0.0083C866-CA257BC1.0000531E@csc.com>
 <1376012120.4514.86.camel@snotra.buserror.net>
 <OFE172B06C.BE11BDC5-ONCA257BCC.007C0097-CA257BCD.000D984C@csc.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 Chris Proctor <cproctor@csc.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-08-20 at 13:28 +1100, Stephen N Chivers wrote:
> Scott Wood <scottwood@freescale.com> wrote on 08/09/2013 11:35:20 AM:
> 
> > From: Scott Wood <scottwood@freescale.com>
> > To: Stephen N Chivers <schivers@csc.com.au>
> > Cc: <benh@kernel.crashing.org>, <paulus@samba.org>, Chris Proctor 
> > <cproctor@csc.com.au>, <linuxppc-dev@lists.ozlabs.org>
> > Date: 08/09/2013 11:36 AM
> > Subject: Re: [RFC PATCH 1/1] powerpc/embedded6xx: Add support for 
> > Motorola/Emerson MVME5100.
> > 
> > simple-bus may be applicable here (in addition to a specific
> > compatible).
> >
> The HAWK ASIC is a difficult beast. I still cannot get a positive
> identification as to what it is (Motorola/Freescale part number
> unknown, not even the part number on the chip on the board helps....).
> The best I can come up with is that it is a tsi108 without
> the ethenets.
> So device_type will be tsi-bridge and compatible will be
> tsi108-bridge.

Don't use device_type.  compatible should include "hawk" in the name
(especially if you're not sure what's really in it), and/or the part
number on the chip.  If you're convinced it's fully compatible with
tsi108-bridge you can add that as a second compatible value, though
given the uncertainty it's probably better to just teach Linux to look
for the new compatible.

If devices on the bus can be used without any special bus setup or
knowledge, then you can add a compatible of "simple-bus" to the end.

> > Why not just look for a chrp,iic node directly?
> >
> I was following the model used in other places, like chrp/setup.c.

Not all examples are good examples. :-)

> > > +       if ((np = of_find_compatible_node(NULL, "pci", "mpc10x-pci"))) 
> {
> > 
> > Why insist on the device_type?
> >
> Following the model in the linkstation (kurobox) platform support. 

Drop the device_type check.

> > > +static void
> > > +mvme5100_restart(char *cmd)
> > > +{
> > > +       volatile ulong          i = 10000000;
> > > +
> > > +
> > > +       local_irq_disable();
> > > +       _nmask_and_or_msr(0, MSR_IP);
> > 
> > Does "mtmsr(mfmsr() | MSR_IP)" not work?
> >
> Don't know. Is from the original code by Matt Porter.

It actually appears that there are no callers remaining that use the
"and" portion of the functionality.  In fact there are no callers that
use it for anything other than setting MSR_IP. :-P

> > > +       out_8((u_char *) BOARD_MODRST_REG, 0x01);
> > > +
> > > +       while (i-- > 0);
> > 
> > Do not use a loop to implement a delay.
> >
> Taken from the original code. But at this point the board
> is going to reset and reboot via firmware, as /sbin/reboot
> or /sbin/halt has been invoked.

Still, it's just a bad idea.  What's wrong with udelay()?

Or just use an infinite loop.  How much value is there really in timing
out here?

> > > +static void __init
> > > +mvme5100_set_bat(void)
> > > +{
> > > +
> > > +
> > > +       mb();
> > > +       mtspr(SPRN_DBAT1U, 0xf0001ffe);
> > > +       mtspr(SPRN_DBAT1L, 0xf000002a);
> > > +       mb();
> > > +       setbat(1, 0xfe000000, 0xfe000000, 0x02000000, 
> PAGE_KERNEL_NCG);
> > > +}
> > 
> > It is no longer allowed to squat on random virtual address space like
> > this.  If you really need a BAT you'll have to allocate the virtual
> > address properly.
> >
> Yes. I found that this was an anathema when researching the port in
> 2010 but I couldn't find any practical solution at the time.
> The code is called early to ensure that the hawk registers are available.
> sysdev/cpm_common.c does the same thing.

> What is the correct solution?

ioremap() has special code to function early (using ioremap_bot).

If you still need to use a BAT that early, reserve the space with
asm/fixmap.h or by adding a function to the early ioremap code to just
reserve the space.  Or better, improve the ioremap code to be capable of
creating a BAT (or equivalent) when requested.

-Scott
