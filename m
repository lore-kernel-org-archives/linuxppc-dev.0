Mime-Version: 1.0
Message-Id: <p05100302b7d16386402f@[10.0.0.42]>
In-Reply-To: <200109211848.f8LImlT19616@saturn.cs.uml.edu>
References: <200109211848.f8LImlT19616@saturn.cs.uml.edu>
Date: Fri, 21 Sep 2001 17:22:29 -0700
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
	linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: ppc LE questions (seeking help hand info pointers)
Cc: dan@mvista.com, hobold@Informatik.Uni-Bremen.DE,
	nicoya@apia.dhs.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 2:48 PM -0400 9/21/01, Albert D. Cahalan wrote:

>Now do an unconditional 64-bit byte swap on the motherboard.
>Consider an array of four __u16 values affected by this.
>They get converted from big-endian to little-endian, and they
>get moved to different addresses. Excellent! All the weirdness
>just cancels out, giving perfect little-endian. This works for
>8-bit, 16-bit, 32-bit, and 64-bit data. Life is good.
>For correct PCI operation, just disable the byte swapping
>currently done by the IO access macros. Drivers will work.

OK.  I was going to object that it would break on misaligned data but
after working out an example it appears that works too.

>To make this extra clear, I'll explain why the Mac doesn't do
>motherboard-based swapping for PCI. Apple had to run the ppc
>in big-endian mode to keep 680x0 developers happy, to help with
>680x0 emulation, and maybe to work well with NuBUS.

Also because the early PowerPCs simply didn't provide a usable LE mode.

BTW, I believe NuBus is LE.

>Mark does have such a motherboard, and does have the toolchain.
>So, no need to hassle him about the need for LE or his ability
>to compile stuff correctly.

OK, so there is at least one example of a board designed for PPC LE.  :)

>Changes needed for 75x0 chips on little-endian motherboards:
>
>1. new MSR values
>2. load the whole MSR, not just the lower half
>3. a way to disable the PCI byte swapping that the ppc port does
>4. a "xori" instruction if using the 7450's software TLB reload
>5. removal of crummy load/store string/multiple instructions
>6. write page table entries with a 64-bit write, or word swap

Assuming you've identified all the needed changes for PPC LE with a
LE board (*), I humbly submit that Mark & co. should get to work
making a patch if they really want this feature.  The only item which
might touch very much code is #5 (anybody know how frequently such
instructions are used?), and a strong argument can be made that those
instructions should not be used by anybody given their clearly
deprecated status.  The rest of it is small enough to be maintained
outside the regular trees, so they will not lose big time if it gets
refused for integration.

(*) I'm not convinced there won't be other gotchas.  There are
probably corner cases where unexpected things will happen.  And
drivers might need a cleanup or two.  And there may be processor
models that simply won't work well or at all due to bugs, but people
building LE PPC motherboards can worry about that.

--
Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
