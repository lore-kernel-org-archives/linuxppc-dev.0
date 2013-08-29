Return-Path: <schivers@csc.com.au>
Received: from mail1.bemta8.messagelabs.com (mail1.bemta8.messagelabs.com
 [216.82.243.199])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.bemta8.messagelabs.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 14F792C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Aug 2013 08:36:46 +1000 (EST)
In-Reply-To: <OFA6564D85.57B12E50-ONCA257BCF.00042385-CA257BCF.00055385@LocalDomain>
References: <OFBCFBBD51.E4ECB0DF-ONCA257BC0.0083C866-CA257BC1.0000531E@csc.com>	
 <1376012120.4514.86.camel@snotra.buserror.net>
 <OFE172B06C.BE11BDC5-ONCA257BCC.007C0097-CA257BCD.000D984C@csc.com>
 <1377040803.3370.88.camel@snotra.buserror.net>
 <OFA6564D85.57B12E50-ONCA257BCF.00042385-CA257BCF.00055385@LocalDomain>
To: Stephen N Chivers <schivers@csc.com.au>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 1/1] powerpc/embedded6xx: Add support for
 Motorola/Emerson MVME5100.
From: Stephen N Chivers <schivers@csc.com.au>
Message-ID: <OFD512862F.4C1E4180-ONCA257BD6.007BB9B7-CA257BD6.007C2E60@csc.com>
Date: Fri, 30 Aug 2013 09:36:23 +1100
Content-Type: text/plain; charset="US-ASCII"
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org, Chris Proctor <cproctor@csc.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stephen N Chivers/AUS/CSC wrote on 08/22/2013 10:58:10 AM:

> From: Stephen N Chivers/AUS/CSC
> To: Scott Wood <scottwood@freescale.com>
> Cc: benh@kernel.crashing.org, Chris Proctor <cproctor@csc.com.au>, 
> linuxppc-dev@lists.ozlabs.org, paulus@samba.org, Stephen N Chivers 
> <schivers@csc.com.au>
> Date: 08/22/2013 10:58 AM
> Subject: Re: [RFC PATCH 1/1] powerpc/embedded6xx: Add support for 
> Motorola/Emerson MVME5100.
> 
> Scott Wood <scottwood@freescale.com> wrote on 08/21/2013 09:20:03 AM:
> 
> > From: Scott Wood <scottwood@freescale.com>
> > To: Stephen N Chivers <schivers@csc.com.au>
> > Cc: <benh@kernel.crashing.org>, Chris Proctor <cproctor@csc.com.au>,
> > <linuxppc-dev@lists.ozlabs.org>, <paulus@samba.org>
> > Date: 08/21/2013 09:20 AM
> > Subject: Re: [RFC PATCH 1/1] powerpc/embedded6xx: Add support for 
> > Motorola/Emerson MVME5100.
> > 
> > On Tue, 2013-08-20 at 13:28 +1100, Stephen N Chivers wrote:
> > > Scott Wood <scottwood@freescale.com> wrote on 08/09/2013 11:35:20 
AM:
> > > 
> > > > From: Scott Wood <scottwood@freescale.com>
> > > > To: Stephen N Chivers <schivers@csc.com.au>
> > > > Cc: <benh@kernel.crashing.org>, <paulus@samba.org>, Chris Proctor 
> > > > <cproctor@csc.com.au>, <linuxppc-dev@lists.ozlabs.org>
> > > > Date: 08/09/2013 11:36 AM
> > > > Subject: Re: [RFC PATCH 1/1] powerpc/embedded6xx: Add support for 
> > > > Motorola/Emerson MVME5100.
> > > > 
> > > > simple-bus may be applicable here (in addition to a specific
> > > > compatible).
> > > >
> > > The HAWK ASIC is a difficult beast. I still cannot get a positive
> > > identification as to what it is (Motorola/Freescale part number
> > > unknown, not even the part number on the chip on the board 
helps....).
> > > The best I can come up with is that it is a tsi108 without
> > > the ethenets.
> > > So device_type will be tsi-bridge and compatible will be
> > > tsi108-bridge.
> > 
> > Don't use device_type.  compatible should include "hawk" in the name
> > (especially if you're not sure what's really in it), and/or the part
> > number on the chip.  If you're convinced it's fully compatible with
> > tsi108-bridge you can add that as a second compatible value, though
> > given the uncertainty it's probably better to just teach Linux to look
> > for the new compatible.
> > 
> > If devices on the bus can be used without any special bus setup or
> > knowledge, then you can add a compatible of "simple-bus" to the end.
> > 
> > > > Why not just look for a chrp,iic node directly?
> > > >
> > > I was following the model used in other places, like chrp/setup.c.
> > 
> > Not all examples are good examples. :-)
> > 
> > > > > +       if ((np = of_find_compatible_node(NULL, "pci", 
> "mpc10x-pci"))) 
> > > {
> > > > 
> > > > Why insist on the device_type?
> > > >
> > > Following the model in the linkstation (kurobox) platform support. 
> > 
> > Drop the device_type check.
> > 
> > > > > +static void
> > > > > +mvme5100_restart(char *cmd)
> > > > > +{
> > > > > +       volatile ulong          i = 10000000;
> > > > > +
> > > > > +
> > > > > +       local_irq_disable();
> > > > > +       _nmask_and_or_msr(0, MSR_IP);
> > > > 
> > > > Does "mtmsr(mfmsr() | MSR_IP)" not work?
> > > >
> > > Don't know. Is from the original code by Matt Porter.
> > 
> > It actually appears that there are no callers remaining that use the
> > "and" portion of the functionality.  In fact there are no callers that
> > use it for anything other than setting MSR_IP. :-P
> > 
> > > > > +       out_8((u_char *) BOARD_MODRST_REG, 0x01);
> > > > > +
> > > > > +       while (i-- > 0);
> > > > 
> > > > Do not use a loop to implement a delay.
> > > >
> > > Taken from the original code. But at this point the board
> > > is going to reset and reboot via firmware, as /sbin/reboot
> > > or /sbin/halt has been invoked.
> > 
> > Still, it's just a bad idea.  What's wrong with udelay()?
> > 
> > Or just use an infinite loop.  How much value is there really in 
timing
> > out here?
> > 
> > > > > +static void __init
> > > > > +mvme5100_set_bat(void)
> > > > > +{
> > > > > +
> > > > > +
> > > > > +       mb();
> > > > > +       mtspr(SPRN_DBAT1U, 0xf0001ffe);
> > > > > +       mtspr(SPRN_DBAT1L, 0xf000002a);
> > > > > +       mb();
> > > > > +       setbat(1, 0xfe000000, 0xfe000000, 0x02000000, 
> > > PAGE_KERNEL_NCG);
> > > > > +}
> > > > 
> > > > It is no longer allowed to squat on random virtual address space 
like
> > > > this.  If you really need a BAT you'll have to allocate the 
virtual
> > > > address properly.
> > > >
> > > Yes. I found that this was an anathema when researching the port in
> > > 2010 but I couldn't find any practical solution at the time.
> > > The code is called early to ensure that the hawk registers are 
available.
> > > sysdev/cpm_common.c does the same thing.
> > 
> > > What is the correct solution?
> > 
> > ioremap() has special code to function early (using ioremap_bot).
> > 
> > If you still need to use a BAT that early, reserve the space with
> > asm/fixmap.h or by adding a function to the early ioremap code to just
> > reserve the space.  Or better, improve the ioremap code to be capable 
of
> > creating a BAT (or equivalent) when requested.
> >
> It is really interesting. Given that the UART implementation on the
> HAWK is such that legacy_serial will not set up an early console it
> is very likely that the address translation set up by the bat is not
> required.
> I can probably replace the physical addresses used in:
> 
>  setup_indirec_pci(hose, 0, 0xfe000cf8, 0xfe000cfc, 0);
> 
> with remapped equivalents. But, with the setbat eliminated, the
> line:
> 
>  pcibios_alloc_controller(dev);
> 
> silently (remember no early console, due to UART reg-shift) panics.
> It is happening at the point where the newly allocated PHB
> structure is being added to the "hose_list" in pci-common.c.
> 
> So, I think there is some side effect due to the call to the setbat with 
the
> PAGE_KERNEL_NCG parameter that I do not yet understand.
>
The problem has disappeared after rearranging the code in the board 
support
file (moving mvme5100_setup_bridge did the trick) and I now have a booting
MVME5100 without resorting to "setbat" in early initialization. 
> > -Scott
> > 
> > 
> > 
