Date: Fri, 21 Sep 2001 14:48:47 -0400 (EDT)
Message-Id: <200109211848.f8LImlT19616@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linuxppc-dev@lists.linuxppc.org
Cc: dan@mvista.com, hobold@Informatik.Uni-Bremen.DE,
	tas@mindspring.com, nicoya@apia.dhs.org
Subject: Re: ppc LE questions (seeking help hand info pointers)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


It is clear to me that most people don't truly understand the
implications of address munging when running the PowerPC in
little-endian mode. I'll try to explain.

The important point: motherboards make all the difference

On a Mac, you have a big-endian CPU crudely connected to the
little-endian PCI bus. You have to swap bytes. If you put the
CPU into little-endian mode, you end up with big-endian data
going to the wrong addresses. Everything looks little-endian
to the CPU, but PCI now needs address anti-munging in addition
to the byte swapping that the ppc port already does. Badness!
(though a little-endian user-space would be fine with this)

Now do an unconditional 64-bit byte swap on the motherboard.
Consider an array of four __u16 values affected by this.
They get converted from big-endian to little-endian, and they
get moved to different addresses. Excellent! All the weirdness
just cancels out, giving perfect little-endian. This works for
8-bit, 16-bit, 32-bit, and 64-bit data. Life is good.
For correct PCI operation, just disable the byte swapping
currently done by the IO access macros. Drivers will work.

Given a little-endian motherboard (reversed byte lanes), running
the CPU in the normal big-endian mode would require the same
sort of anti-munging that you'd need for little-endian on a Mac.

To make this extra clear, I'll explain why the Mac doesn't do
motherboard-based swapping for PCI. Apple had to run the ppc
in big-endian mode to keep 680x0 developers happy, to help with
680x0 emulation, and maybe to work well with NuBUS. The PCI host
bridge won't always be aware of data sizes due to write combining
and compiler optimization, so it can't fix things nicely. Apple
could have done an unconditional 64-bit swap, fixing the byte
order while screwing up the addresses... eh, why bother?

Thus one should run the CPU in little-endian mode if and only
if one has a motherboard that does an unconditional 64-bit swap.

Mark does have such a motherboard, and does have the toolchain.
So, no need to hassle him about the need for LE or his ability
to compile stuff correctly.

Changes needed for 75x0 chips on little-endian motherboards:

1. new MSR values
2. load the whole MSR, not just the lower half
3. a way to disable the PCI byte swapping that the ppc port does
4. a "xori" instruction if using the 7450's software TLB reload
5. removal of crummy load/store string/multiple instructions
6. write page table entries with a 64-bit write, or word swap

Changes needed for the 405 chip, AFAIK:

1. a way to disable the PCI byte swapping that the ppc port does
2. one bit different in the TLB entries

Changes needed for 75x0 chips on the Mac, if feeling insane:

1. new MSR values
2. load the whole MSR, not just the lower half
3. PCI address anti-munging (keep existing byte swap too)
4. a "xori" instruction if using the 7450's software TLB reload
5. removal of crummy load/store string/multiple instructions
6. write page table entries with a 64-bit write, or word swap


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
