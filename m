Return-Path: <jwilliams@itee.uq.edu.au>
Received: from mailhub4.uq.edu.au (mailhub4.uq.edu.au [130.102.149.131])
	by ozlabs.org (Postfix) with ESMTP id 5BF04DDE27
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Nov 2007 11:52:54 +1100 (EST)
Message-ID: <474CBBDE.9010007@itee.uq.edu.au>
Date: Wed, 28 Nov 2007 10:52:46 +1000
From: John Williams <jwilliams@itee.uq.edu.au>
MIME-Version: 1.0
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: Xilinx devicetrees
References: <47480CF0.7090105@dlasys.net>
	<fa686aa40711240912r192aba72o2cbdb798370e7b7c@mail.gmail.com>
	<20071125052459.DA8B1EE805F@mail70-blu.bigfish.com>
	<4749425C.5060207@dlasys.net>
	<20071125181506.EE2041BA004F@mail141-cpk.bigfish.com>
	<474CAE70.3030005@itee.uq.edu.au>
	<20071128002835.068BE16A005D@mail198-sin.bigfish.com>
In-Reply-To: <20071128002835.068BE16A005D@mail198-sin.bigfish.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Stephen Neuendorffer wrote:

>>From: John Williams [mailto:jwilliams@itee.uq.edu.au] 

>>MicroBlaze is a highly configurable CPU in terms of its 
>>instruction set, 
>>features and so on.  To make use of this, it is essential that each 
>>kernel image be compiled to match the CPU configuration.  While a 
>>generic kernel, making use of no features (MUL, DIV, Shift, 
>>MSR ops etc) 
>>would run on any CPU, performance would be abysmal.
> 
> I think the userspace is actually much more critical than the kernel for
> most of these things (with the exception of msrset/msrclr, and the
> barrel shifter perhaps).  Unfortunately, even if you implement an
> alternatives-style mechanism for the kernel, you're still hosed for
> userspace.  

I haven't benchmarks each option on the kernel - you are right that 
shift is a big one, but mul I think is also important, given that every 
array access generates an integer multiply,

Once I a big enough system, it's just unfeasible to
> recompile everything anyway.  I think this is where autoconfig starts to
> break down.

I'm not sure I agree, here, given that most people building MicroBlaze 
systems are doing so with uClinux-dist (or PetaLinux), you can do a full 
rebuilt, kernel libs apps, in a couple of minutes.  Much shorter than 
sythnesis and P&R, that's for sure (and runtime is linear in size, 
unlike P&R :)

> It's not nice, I agree.  I think the key principle should be that I
> should be able to get a system working as quickly as possible, and I
> might optimize things later.  One thing that device trees will allow is
> for *all* the drivers to get compiled in to the kernel, and only as a
> late stage operation does a designer need to start throwing things away.
> Using traps I can easily start with a 'kitchen sink' design, and start
> discarding processor features, relying on the traps.  When I get low
> enough down on the performance curve, I can uas an autoconfig-type
> mechanism to regain a little of what I lost by optimizing away the trap
> overhead. 

OK, but now we have a kernel dependent on *3* files - a DTS, a 
Kconfig.auto, and (indirectly) the bitstream itself.

> Personally, I think the easiest way out of all this is to just have less
> configurability.  For microblaze in general, this is too much of a
> restriction, but microblaze used as a control processor running linux,
> there are probably just a few design points that really make sense
> (probably size optimized: no options except maybe msrset/msrclr, and the
> kitchen sink).  If we go that far, we don't really need people to ever
> run autoconfig, or kernels, or anything.  Especially considering there
> is no easy way of selecting which of the 2^N design points I want
> *anyway*. :)

My experience tells me that if the microblaze can be configured in a 
particular way, *someone* will want to do it (and still boot linux on 
it!)  We still have people building MicroBlaze 3.00 in Spartan2E, with 
EDK 6.3.  And autoconfig works!  Exceptions on/off, MMU on/off (runtime 
configurable on that?).

Our ability to plug into the backend design database of EDK presents a 
great opportunity - truly automatically configured kernels.  I think we 
have a responsibility to leverage that power.    We are already there 
with the static approach, I think we just need to make sure that 
persists into the dynamic approach, and that we find a good mix of the two.

There are of course some semantic issues that the EDK cannot 
automatically resolve - relative ordering and priority of multiple 
peripheral instances for example.

>>One compromise approach might be to have a script in 
>>arch/microblaze/scripts, called by the arch Makefile, that 
>>cracks open 
>>the DT at build time and extracts appropriate cpu flags.
> 
> Hmm... interesting idea, although parsing the source is likely
> difficult...  It's probably not worth it to go this far, I think.   As
> you say, why doesn't autoconfig of today work fine for this.

Well, copying multiple configuration files into the kernel is not ideal. 
  Surely a little perl or python script would do the trick?  DTS syntax 
is pretty clean, just find the CPU node and off we go.  Multiple CPU, 
well... :)

>>Finally, what is the LKML position on DT files going into the kernel 
>>source tree?
> 
> 
> Source .dts go in and get compiled to binary blobs at compile time.  The
> 'big' recent controversy is whether the source->binary compiler dtc
> should be mirrored in the Linux tree or not.

OK.

Another thing I suggested to Michal recently, perhaps we need 
kernel/lib/libof to store common OF / DT handling code.  Much better 
than duplicating it accross microblaze and PPC, and maybe other arch's 
would also see the light..  That would also add a claim for the DTC to 
go in scripts/

John
