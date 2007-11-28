Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id DAB2FDDDDB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Nov 2007 11:27:58 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so237950anc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Nov 2007 16:27:56 -0800 (PST)
Message-ID: <fa686aa40711271627m6866c563sac08ab60443adbfe@mail.gmail.com>
Date: Tue, 27 Nov 2007 17:27:56 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Williams" <jwilliams@itee.uq.edu.au>
Subject: Re: Xilinx devicetrees
In-Reply-To: <474CAE70.3030005@itee.uq.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47480CF0.7090105@dlasys.net>
	<fa686aa40711240912r192aba72o2cbdb798370e7b7c@mail.gmail.com>
	<20071125052459.DA8B1EE805F@mail70-blu.bigfish.com>
	<4749425C.5060207@dlasys.net>
	<20071125181506.EE2041BA004F@mail141-cpk.bigfish.com>
	<474CAE70.3030005@itee.uq.edu.au>
Cc: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>,
	Michal Simek <simekm2@fel.cvut.cz>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/27/07, John Williams <jwilliams@itee.uq.edu.au> wrote:
> Hi folks,
>
> Stephen Neuendorffer wrote:
>
> >  >    Binding it to a kernel, is a non-starter for us.
> >
> > I agree that this is not the best way of leveraging the power of device
> > trees.  The point is that by using a device tree, you haven't lost
> > anything you can do currently.  In the future we might have one kernel
> > which supports all versions of all our IP, along with all flavors of
> > microblaze and powerpc...  You would only ever need to recompile this
> > kernel as a final optimization, if at all.
>
> I strongly support the OF / device tree work being done, from its own
> perspective and also as a path to MicroBlaze/PPC unification, however
> there is one critical difference that I have not seen adequately
> addressed yet.
>
> MicroBlaze is a highly configurable CPU in terms of its instruction set,
> features and so on.  To make use of this, it is essential that each
> kernel image be compiled to match the CPU configuration.  While a
> generic kernel, making use of no features (MUL, DIV, Shift, MSR ops etc)
> would run on any CPU, performance would be abysmal.

Looks like you've found the point of diminishing returns.  :-)  It is
probably not appropriate to try and encode CPU configuration into the
device tree *unless* it is only used to determine whether or not the
kernel as compiled will run on that CPU; but even by then you're
already running code on the platform.  :-)

>
> In my view it's not acceptable to present these as options for the user
> to select at kernel config time. With N yes/no parameters, there is 1
> correct configuration, and 2^N-1 incorrect ones.  The odds of the user
> falling upon a configuration that at worst fails to boot, or at best is
> not optimally matched to the hardware, are high.
>
> This same issue also applies to C libraries and apps - they must be
> compiled with prior knowledge of the CPU.  This is why our
> microblaze-uclinux-gcc toolchain, with multilib'd uClibc, is almost 400meg!
>
> Wrapping every mul, div, shift etc in a function call is clearly not
> feasible.  Things like the msrset/msrclr ops have a modest but
> measurable impact on kernel code size and performance - it's just not
> reasonable to add any level of indirection in there.
>
> I have thought about dynamic (boot-time) code re-writing as one
> possibility here, but it very quickly gets nasty.  All of the
> "optimised" opcodes (MUL/DIV/Shift etc) are smaller than their emulated
> counterparts, so in principle we could re-write the text segment with
> the optimised opcode, then NOP pad, but that's still inefficient.  As
> soon as we start talking about dynamic code relocation, re-writing
> relative offsets in loops, ... yuck..  We'd be putting half of mb-ld
> into the arch early boot code (or bootloader...)
>
> The opposite approach, to build with all instructions enabled and
> install exception handlers to deal with the fixups, is also pretty awful.
>
> I find myself asking the question - for what use cases does the current
> static approach used in MicroBlaze (with the PetaLinux BSP /
> Kconfig.auto) *not* work?
>
> One compromise approach might be to have a script in
> arch/microblaze/scripts, called by the arch Makefile, that cracks open
> the DT at build time and extracts appropriate cpu flags.
>
> Finally, what is the LKML position on DT files going into the kernel
> source tree?

arch/powerpc is awash with .dts files in the kernel tree.  It's a
practice that is encouraged  for most of the embedded boards.  :-)

However, for something like xilinx virtex ppc and microblaze it
probably doesn't make much sense for anything other than the Xilinx
reference design bitstreams.  (at least in mainline)

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
