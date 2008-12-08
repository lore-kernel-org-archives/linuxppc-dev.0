Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8B02BDDDEA
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2008 10:10:37 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e38.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mB8N9Rin010435
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Dec 2008 16:09:27 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mB8NAYx4189124
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Dec 2008 16:10:34 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mB8NAXp0020947
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Dec 2008 16:10:33 -0700
Date: Mon, 8 Dec 2008 18:10:06 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Erickson <gerickson@nuovations.com>
Subject: Re: PPC4xx ECC Configs, Defines and Source
Message-ID: <20081208181006.6900303b@zod.rchland.ibm.com>
In-Reply-To: <C562DAC1.1352D%gerickson@nuovations.com>
References: <20081208202152.GA10929@yoda.jdub.homelinux.org>
	<C562DAC1.1352D%gerickson@nuovations.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 08 Dec 2008 14:08:01 -0800
Grant Erickson <gerickson@nuovations.com> wrote:

> On 12/8/08 12:21 PM, Josh Boyer wrote:
> > On Mon, Dec 08, 2008 at 11:28:15AM -0800, Grant Erickson wrote:
> >> Does anyone have any strong preferences on where configurations, definitions
> >> and sources for a PPC4xx ECC monitoring and reporting driver should go?
> >> 
> >> Specifically, this concerns ECC handling code for the IBM DDR2 ECC
> >> controller found in the 405EX[r], 440SP, 440SPe, 460EX and 460GT. However,
> >> I'd like to do this in a way that other ECC contributors and maintainers can
> >> build on.
> >> 
> >> Static Configs
> >> --------------
> >> 
> >> I thought I might leverage the definitions Stefan Roese came up with for
> >> u-boot for the base memory controller:
> >> 
> >>    CONFIG_PPC4xx_IBM_SDRAM:   Applicable to 405GP, 405CR, 405EP, AP1000,
> >>                               and ML2
> >>    CONFIG_PPC4xx_IBM_DDR:     Applicable to 440GP, 440GX, 440EP, and 440GR
> >>    CONFIG_PPC4xx_DENALI_DDR2: Applicable to 440EPX and 440GRX
> >>    CONFIG_PPC4xx_IBM_DDR2:    Applicable to 405EX[r], 440SP, 440SPe, 460EX
> >>                               and 460GT.
> > 
> > Config options for what?  Enabling certain function?  Not sure that's needed
> > if we can get away with it by just binding to the appropriate controller.
> 
> A good clarifying question. The configs would cover enabling compiled-in or
> module support for the ECC monitoring and reporting code under discussion. I
> suspect embedded platforms that do not have ECC would not want to compile
> support for this.

Hm.  Still not sure about that.  We have a multi-board config that
still needs to work, so we'd theoretically want to be able to enable
all, some, or none of these and not have the kernel freak out.  Hence
the DTS bindings are important.

> >> Controlling whether ECC monitoring and reporting support should be compiled
> >> in or a module:
> >> 
> >>    CONFIG_PPC_ECC or CONFIG_ECC
> > 
> > That's a bit too generic, unless you are trying to make a menu list under
> > that which would be used to allow people to enable things like:
> > CONFIG_4XX_ECC, CONFIG_FSL_ECC, etc.
> 
> I'll have to think about this some more. More elaboration below.
> 
> Today, we can choose CONFIG_405EX. That nails down CONFIG_PPC4xx_IBM_DDR2
> leaving the only open question at that point as to whether CONFIG_ECC is
> 'y', 'n' or 'm'.

Well, at the moment CONFIG_PPC4xx_IBM_DDR2 doesn't exist, and has no
meaning.  Adding a Kconfig option for it just so you can select an ECC
option seems superfluous.  Because if you select no for ECC, then you
have a Kconfig option that does nothing.  You could simply have:

CONFIG_4xx_IBM_DDR2_ECC

or something like that.

> That said, I am sure I am thinking too "statically" about compile-time
> configuration, however.
> 
> >> Source
> >> ------
> >> 
> >>    arch/powerpc/sysdev/
> >>        ppc4xx_ibm_sdram_ecc.c [future]
> >>        ppc4xx_ibm_ddr_ecc.c [future]
> >>        ppc4xx_ibm_ddr2_ecc.c
> >>        ppc4xx_ibm_ddr2denali_ecc.c [future]
> > 
> > Why is there a need to have so many files?  I would think you could
> > have a single file with all the ECC monitoring implementations in it
> > called ppc4xx_ecc.c (or such).  Surely they would share some amount
> > of code?
> 
> Based on my foggy memory of the 405GP (ibm_sdram_ecc) roughly ten years ago,
> a cursory look at today's Denali controller (from u-boot code), and the
> 405EX[r], the ECC handling code for these is all quite different.
> 
> There will likely be some common, shared code and that could go in something
> like ppc4xx_ecc.c. My focus is only on the 405EX[r] and the associated DDR2
> controller, so further abstraction will probably occur once another
> controller is integrated.

I'll buy that.  Just start with ppc4xx_ecc.c with your initial support
and then we can refactor as other implementations get added (if they
do).

> >> Headers and Defines
> >> -------------------
> >> 
> >>    arch/powerpc/include/asm/ppc4xx_ibm_ddr2.h
> >> 
> >>    OR
> >> 
> >>    arch/powerpc/sysdev/ppc4xx_ibm_ddr2.h
> > 
> > That depends on the contents of the file.  If it's DCR defines, etc
> > it should be in the dcr-regs.h file.  Otherwise, I would think having
> > the header in sysdev should be sufficient unless there is some other
> > facility that would need whatever the contents there are.
> 
> Thanks for the confirmation. That was my operating assumption. They would be
> DCR sub-definitions, such as:

Those you can probably leave in the local .h file.

> Regarding other items that might go into the DTS, I don't have enough
> visibility into the other processors that this controller is used on (440SP,
> 440SPe, 460EX and 460GT) beyond the 405EX[r]; however, I am guessing the
> interrupts are almost guaranteed to be different from processor to processor
> suggesting an entry akin to:

<snip>

>         SDRAM0: memory-controller {
>             compatible = "ibm,sdram-405ex", "ibm,sdram-4xx-ddr2";
>             dcr-reg = <0x010 0x002>;
>             ...
>             interrupt-parent = <&SDRAM0>;
>             interrupts = <0x0 0x1>;
>             interrupt-map = </* ECCDED Error */ 0x0 &UIC2 0x5 0x4
>                              /* ECCSEC Error */ 0x1 &UIC2 0x6 0x4>;
>             ...
>         };

More like this one.

> or some such. My DTS expertise is near zero and growing.

That's pretty darn good so far.

Just to make sure, are you planning on just implementing a driver to
deal with whatever settings the bootloader configured?  E.g., if ECC is
enabled deal with correctable/uncorrectable errors and if not, do
nothing?  Basically you are looking to implement a scrub driver, yes?

I ask because since ECC is memory module specific and memory controller
setup is pretty tricky, I think it's best to leave whatever
configuration the bootloader set and work with that.  Having to redo
memory controller setups in Linux to enable ECC isn't something I'd
look forward to.

josh
