Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound5-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 75393DDDFA
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Nov 2007 11:28:41 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Xilinx devicetrees
Date: Tue, 27 Nov 2007 16:28:33 -0800
In-Reply-To: <474CAE70.3030005@itee.uq.edu.au>
References: <47480CF0.7090105@dlasys.net>
	<fa686aa40711240912r192aba72o2cbdb798370e7b7c@mail.gmail.com>
	<20071125052459.DA8B1EE805F@mail70-blu.bigfish.com>
	<4749425C.5060207@dlasys.net>
	<20071125181506.EE2041BA004F@mail141-cpk.bigfish.com>
	<474CAE70.3030005@itee.uq.edu.au>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "John Williams" <jwilliams@itee.uq.edu.au>
Message-Id: <20071128002835.068BE16A005D@mail198-sin.bigfish.com>
Cc: Michal Simek <simekm2@fel.cvut.cz>,
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

=20
> -----Original Message-----
> From: John Williams [mailto:jwilliams@itee.uq.edu.au]=20
> Sent: Tuesday, November 27, 2007 3:55 PM
> To: Stephen Neuendorffer
> Cc: David H. Lynch Jr.; linuxppc-embedded; Michal Simek
> Subject: Re: Xilinx devicetrees
>=20
>=20
> MicroBlaze is a highly configurable CPU in terms of its=20
> instruction set,=20
> features and so on.  To make use of this, it is essential that each=20
> kernel image be compiled to match the CPU configuration.  While a=20
> generic kernel, making use of no features (MUL, DIV, Shift,=20
> MSR ops etc)=20
> would run on any CPU, performance would be abysmal.

I think the userspace is actually much more critical than the kernel for
most of these things (with the exception of msrset/msrclr, and the
barrel shifter perhaps).  Unfortunately, even if you implement an
alternatives-style mechanism for the kernel, you're still hosed for
userspace.  Once I a big enough system, it's just unfeasible to
recompile everything anyway.  I think this is where autoconfig starts to
break down.

> In my view it's not acceptable to present these as options=20
> for the user=20
> to select at kernel config time. With N yes/no parameters, there is 1=20
> correct configuration, and 2^N-1 incorrect ones.  The odds of=20
> the user=20
> falling upon a configuration that at worst fails to boot, or=20
> at best is=20
> not optimally matched to the hardware, are high.

Yes.  Autoconfig does handle this in a fairly nice way.

> This same issue also applies to C libraries and apps - they must be=20
> compiled with prior knowledge of the CPU.  This is why our=20
> microblaze-uclinux-gcc toolchain, with multilib'd uClibc, is=20
> almost 400meg!
>=20
> Wrapping every mul, div, shift etc in a function call is clearly not=20
> feasible.  Things like the msrset/msrclr ops have a modest but=20
> measurable impact on kernel code size and performance - it's just not=20
> reasonable to add any level of indirection in there.
>=20
> I have thought about dynamic (boot-time) code re-writing as one=20
> possibility here, but it very quickly gets nasty.  All of the=20
> "optimised" opcodes (MUL/DIV/Shift etc) are smaller than=20
> their emulated=20
> counterparts, so in principle we could re-write the text segment with=20
> the optimised opcode, then NOP pad, but that's still inefficient.  As=20
> soon as we start talking about dynamic code relocation, re-writing=20
> relative offsets in loops, ... yuck..  We'd be putting half of mb-ld=20
> into the arch early boot code (or bootloader...)
>=20
> The opposite approach, to build with all instructions enabled and=20
> install exception handlers to deal with the fixups, is also=20
> pretty awful.

It's not nice, I agree.  I think the key principle should be that I
should be able to get a system working as quickly as possible, and I
might optimize things later.  One thing that device trees will allow is
for *all* the drivers to get compiled in to the kernel, and only as a
late stage operation does a designer need to start throwing things away.
Using traps I can easily start with a 'kitchen sink' design, and start
discarding processor features, relying on the traps.  When I get low
enough down on the performance curve, I can uas an autoconfig-type
mechanism to regain a little of what I lost by optimizing away the trap
overhead.=20

Personally, I think the easiest way out of all this is to just have less
configurability.  For microblaze in general, this is too much of a
restriction, but microblaze used as a control processor running linux,
there are probably just a few design points that really make sense
(probably size optimized: no options except maybe msrset/msrclr, and the
kitchen sink).  If we go that far, we don't really need people to ever
run autoconfig, or kernels, or anything.  Especially considering there
is no easy way of selecting which of the 2^N design points I want
*anyway*. :)

> I find myself asking the question - for what use cases does=20
> the current=20
> static approach used in MicroBlaze (with the PetaLinux BSP /=20
> Kconfig.auto) *not* work?
>=20
> One compromise approach might be to have a script in=20
> arch/microblaze/scripts, called by the arch Makefile, that=20
> cracks open=20
> the DT at build time and extracts appropriate cpu flags.

Hmm... interesting idea, although parsing the source is likely
difficult...  It's probably not worth it to go this far, I think.   As
you say, why doesn't autoconfig of today work fine for this.

> Finally, what is the LKML position on DT files going into the kernel=20
> source tree?

Source .dts go in and get compiled to binary blobs at compile time.  The
'big' recent controversy is whether the source->binary compiler dtc
should be mirrored in the Linux tree or not.

Steve
