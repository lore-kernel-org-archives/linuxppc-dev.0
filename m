Message-Id: <5.1.0.14.2.20020123063051.022dc4e0@falcon.si.com>
Date: Wed, 23 Jan 2002 06:51:43 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: RE: FW: Linux on 857T?
In-Reply-To: <C08678384BE7D311B4D70004ACA371050B7632B1@amer22.avnet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Just one dumb question: do you have branches to self in ALL the unused
exceptions (since you don't appear to be using any in your monitor, that
would be all but the reset exception)?  Is it possible you are getting a
different exception and your CPU is executing uninitialized memory (opcode
0x00xxxxxx appears to be illegal -- opcodes 0xFFxxxxxx are floating point
instructions that tend to cause floating point exceptions).

Try filling all unused memory (or at least the exception vector area) with
branches to self.  If I read my S-record file correctly, this looks like
0x48000000.  Now if your CPU decides to jump somewhere unexpected, at least
you will stop it in its tracks at the (unexpected) destination and be able
to see where it jumped to.  The question remains "why" at that point, but
you will have one more piece of the puzzle, as well as a smoking gun to
beat up your hardware guys up (to mix my metaphors :-).

If unexpected jumps are occurring, you could also try filling memory with a
jump to a routine that toggles an output line.  If you get lucky and it
works, you can trigger your logic analyzer on the output line and get a
back trace of where you were before you jumped.

Good luck, sounds like flaky hardware.  That's always the worst thing to
debug :-(.

gvb


At 06:36 PM 1/22/2002 -0700, Kerl, John wrote:

[snip]

>We have three alpha boards which are in some working order.
>Board A, let's call it, is the best one, and the one I've
>been using for all the things I discussed in my recent
>postings.  Boards B and C, on the other hand, haven't been
>"working" for a few weeks, so I pretty much forgot about
>them, as I will explain.

[major snip]

>* On board A, this works fine.  But on boards B and C,
>   the probe reveals that I am taking an ITLB miss (!!!)
>   while trying to return from the LED-write routine.
>   The latter is very simple; it looks like this:
>
>         #define CPLD_ADDR 0x38100002
>         #define CPLD_REG  (*(volatile int16u *)CPLD_ADDR)
>
>         void LED_dev_write(
>                 int32u value)
>         {
>         #ifndef NO_LED // In the build file
>                 CPLD_REG = ((~(int16u)value & 0xff) << 8);
>         #endif
>         }
>
>   which just boils down to about a half-dozen instructions,
>   ending in an sth and a blr.
>
>* The probe shows instructions up to the sth, but not the blr.
>   Instead, the next value for the PC, as I single-step in the
>   probe, is 0x00001104 (which is the NIP for ITLB-miss exception).
>
>Now, if I #define NO_LED in my build file, then the debug
>monitor doesn't write LEDs -- and runs fine (!) on all
>three boards.  And the only code change between those two
>cases is whether or not I do that LED write via the CPLD.
>
>There are two very weird things:
>
>* On all three boards, currently the MMU and cache are
>   never enabled by any copy of my debug monitor.  Only
>   Linux enables them, when and if I run it. I don't see how
>   I can *possibly* be taking an ITLB miss in my code when
>   the MMU is not even enabled.  In fact, I can print out the
>   MSR in my debug monitor & see that bits 24-25 are zero.
>
>* Even if the TLBs are somehow used when the MMU is not
>   enabled (I need to check the 857 manual), I see *no* way
>   I should ever be getting any TLB miss.  The DTLB and ITLB
>   are both supposedly 32 entries each; I am only loading up
>   21 entries for data and 11 for instructions with a very
>   simple 1-1 virtual-physical mapping, with 8MB page sizes.
>   TLB entries should (in my understanding) *never* get
>   pushed out, if I'm not putting new ones in.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
