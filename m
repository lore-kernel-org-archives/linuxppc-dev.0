Date: Fri, 4 Aug 2000 11:21:08 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Takashi Oe <toe@unlserve.unl.edu>
cc: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        David Edelsohn <dje@watson.ibm.com>,
        Thomas Graichen <graichen@innominate.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: shifts on 64bit ints 
In-Reply-To: <Pine.LNX.3.96LJ1.1b7.1000803193713.650E-100000@ofey.earthlink.net>
Message-ID: <Pine.HPX.4.10.10008041100270.9070-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 3 Aug 2000, Takashi Oe wrote:

>
> On Fri, 4 Aug 2000, Franz Sirl wrote:
>
> > Oh no!! It's even worse! The kernel implementation of ashldi3, ashrdi3 and
> > lshrdi3 seems broken, see this code in arch/ppc/kernel/misc.S:
>
> The brokenness of those implementations has been noted by Gabriel a long
> time ago, and I believe he even sent a fix to this list once.  For some
> unknown reasons, it has largely been ignored.  I think I can dig out his
> patch if I try hard though.

<rant>
Don't worry, I am by now largely accustomed to the fact that even my most
obvious bugfixes are systematically ignored :-( And in this precise case
there is no excuse, it is a localized patch that does exactly one thing
and does it correctly.
 </rant>

Here is the corresponding part of misc.S in my source (based on
kernel.org 2.4.0-test5, but it does not change anything). Note that the
code is largely taken from the PPC manual examples for multiple
precision shifts (with a tweak to make ashrdi branchless), why reinvent
the wheel when IBM and Motorola have already done it:

/*
 * Extended precision shifts.
 *
 * Updated to be valid for shift counts from 0 to 63 inclusive.
 * -- Gabriel
 *
 * R3/R4 has 64 bit value
 * R5    has shift count
 * result in R3/R4
 *
 *  ashrdi3: arithmetic right shift (sign propagation)
 *  ashldi3: logical shift left
 *  lshrdi3: logical right shift
 */
_GLOBAL(__ashrdi3)
	subfic	r6,r5,32
	srw	r4,r4,r5	# LSW = count > 31 ? 0 : LSW >> count
	addi	r7,r5,32	# could be xori, or addi with -32
	slw	r6,r3,r6	# t1 = count > 31 ? 0 :	MSW << (32-count)
	rlwinm	r8,r7,0,32	# t3 = (count < 32) ? 32 : 0
	sraw	r7,r3,r7	# t2 = MSW >> (count-32)
	or	r4,r4,r6	# LSW |= t1
	slw	r7,r7,r8	# t2 = (count < 32) ? 0 : t2
	sraw	r3,r3,r5	# MSW = MSW >> count
	or	r4,r4,r7	# LSW |= t2
	blr

_GLOBAL(__ashldi3)
	subfic	r6,r5,32
	slw	r3,r3,r5	# MSW = count > 31 ? 0 : MSW << count
	addi	r7,r5,32	# could be xori, or addi with -32
	srw	r6,r4,r6	# t1 = count > 31 ? 0 :	LSW >> (32-count)
	slw	r7,r4,r7	# t2 = count < 32 ? 0 :	LSW << (count-32)
	or	r3,r3,r6	# MSW |= t1
	slw	r4,r4,r5	# LSW = LSW << count
	or	r3,r3,r7	# MSW |= t2
	blr

_GLOBAL(__lshrdi3)
	subfic	r6,r5,32
	srw	r4,r4,r5	# LSW = count > 31 ? 0 : LSW >> count
	addi	r7,r5,32	# could be xori, or addi with -32
	slw	r6,r3,r6	# t1 = count > 31 ? 0 :	MSW << (32-count)
	srw	r7,r3,r7	# t2 = count < 32 ? 0 :	MSW >> (count-32)
	or	r4,r4,r6	# LSW |= t1
	srw	r3,r3,r5	# MSW = MSW >> count
	or	r4,r4,r7	# LSW |= t2
	blr

Would some kind soul push it to the bk tree (I don't ant push access to
the bk tree, my link is too slow and I would lock the reepository for eons
even for small accesses). Somebody wants to volunteer to do it ?

I plan to send a lot of small obvious bugfixes in the next 3-4 weeks, the
diffs between  my tree and the official one now run in the megabyte range,
and this is too much (would the BitKeeper tree accept the VME patches and
PrePboot BTW ?)

What I would for one like to see is that people that write a patch that
may affect other machines than their own first publish it on this list and
wait a couple of days for comment and test results before pushing it to
the official source tree, somewhat like what happens on gcc-patches.

Almost every time I apply a new official patch, something silly breaks
my machines. I'm now accustomed and it's much easier thanks to BitKeeper
(although I base all my work on kernel.org's tree, just built a BK
repository out of it). A little discipline in this respect could only help
given the variety of PPC machines. Oh well, I can always dream...

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
