Date: Fri, 21 Sep 2001 01:28:11 -0400 (EDT)
Message-Id: <200109210528.f8L5SBb443059@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linuxppc-dev@lists.linuxppc.org
Cc: dan@mvista.com, mbs@mc.com
Subject: Re: ppc LE questions (seeking help hand info pointers)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek writes:

> Another technical reason is as the processor family moves forward,
> less and less little endian support is provided. In the case of
> the 7450, there are instructions that trap to the kernel to be
> emulated in LE mode, that are executed in the core in BE mode.

Quit spreading FUD. The 7450 has _better_ LE support than the 7400
and 7410 did. With the 7450, misaligned LE memory operations now
perform just as well as misaligned BE memory operations.

I checked the errata too. Total BE/LE differences I found:


1. TLBMISS always has a BE address. Motorola's example code for
   software TLB reloads has a "xori" instruction to deal with this.

2. No string/multi load/store instructions in LE mode.
   According to Motorola's 32-bit arch book, these instructions
   are expected to be slow anyway. (They sure aren't RISC!)
   Indeed, the 7450 doesn't handle them well even in BE mode.

3. The MPC106 chip ("Grackle" host bridge) won't work.

4. The MPC107 chip (another host bridge) won't tolerate unaligned data.

5. LE mode enables address munging. :-)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
