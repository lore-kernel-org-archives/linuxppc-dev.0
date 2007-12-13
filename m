Return-Path: <CFester@iphase.com>
Received: from exmail.interphase.iphase.com (h88.iphase.com [157.175.3.88])
	by ozlabs.org (Postfix) with ESMTP id 06ED3DDDEB
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 14:02:15 +1100 (EST)
Subject: Re: [PATCH RFC 0/7] "NAND on UPM" and related patches
From: Chris Fester <cfester@iphase.com>
To: avorontsov@ru.mvista.com
In-Reply-To: <20071210204705.GA31263@localhost.localdomain>
References: <20071210204705.GA31263@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 12 Dec 2007 21:01:29 -0600
Message-Id: <1197514889.12803.140.camel@kaboom.lisle.iphase.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: cfester@iphase.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-12-10 at 23:47 +0300, Anton Vorontsov wrote:
> Hi all,
> 
> Here are patches to support NAND on UPM. That driver is generic for
> all processors with FSL UPMs. And because of that, few more patches are
> needed -- GPIO API and generic FSL UPM functions.
> I would appreciate any comments and suggestions, thanks!

Hi Anton,

Apologies for not getting back sooner to comment...

We've been using a home-brewed UPM driver for our NAND for a while now.
There's several issues we've hit that I figured I would share.  The
issues involve deficiencies of both the UPM and the NAND part itself.

We modeled our driver loosely after the suggestions in this white paper:
http://www.freescale.com/files/32bit/doc/white_paper/NANDFLASHWP.pdf?fpsp=1&WT_TYPE=WhitePapers&WT_VENDOR=FREESCALE&WT_FILE_FORMAT=pdf&WT_ASSET=Documentation
We also connected the NAND according to the suggestions in the above
document.  

Something that you should be made aware of right away about the UPM -
you do not have control of the logic lines all of the time.  You only
can control them during a transaction (in our case, a byte transaction).
In other words, the time that is between reading/writing bytes, or
putting the address on the bus, or asserting commands you are not able
to hold the lines to a certain state.  Most of the control lines coming
from the UPM default to a logic 1 when unused (I believe only one
defaults to a logic 0).

The first issue is timings between versions of processors.  We've got
one board using an MPC8349 running a 1Gb ST micro part (NAND01G-B).
Another board is an MPC8347 using the same 1Gb ST micro part.  After
much time analyzing logic analyzer captures we found that write pulses
with the 8349 had to be shifted to the left a half clock in order to
properly latch the data on the bus.  This was unexpected given the two
boards are very similar and the processors are in the same family.  I
suppose the fix was easy enough, we just had to make a new version of
the microcode.  What's interesting is that Freescale said that there's
nothing different between the two processors' UPMs.  Yet there is a
distinct difference between local bus behavior on the 2 cpus, our LA
captures prove it.

The second issue was with interrupts during reads.  We noticed that some
of our boards experienced ECC errors while reading the NAND.  Logic
analyzer captures and debugging revealed that when an interrupt happened
while the driver's read code was executing, the UPM went into an idle
state, and the chip select of the part went high.  This may not be a
problem for other NAND parts, but for our ST Micro parts, the spec says
that if CS is held high for more than 100us, the part will exit page
read mode.  The default state of the UPM pins are high, so when the UPM
is idle all the signals are at logic 1.  

Anyways, when the interrupt had completed, or driver wasn't aware that
an interrupt had occurred, so it continued to do it's read loop.  The ST
Micro part was now in an undefined state.  The page read appeared to
continue just fine, but we almost always had one or more bits corrupted
for the very first resuming data byte.  

The fix that we ultimately did was to move the chip select control from
the UPM to a GPIO from the processor.  This forced the chip to never
"sleep" during an interrupt, because we could keep the chip select low
for the entire page read transaction.  This brought up other minor
issues.  You must make sure that your boot loader (U-Boot in our case)
sets the GPIO data BEFORE it sets the GPIO direction.  Otherwise the
NAND will automatically enter a start up read condition that will drive
the local bus, causing anything else on the local bus (such as a NOR
flash) to be useless...

The latest version of the app note online (link above) does not mention
the problem you may experience with interrupts.  I requested from our
Freescale support contact that Freescale document this fact and make it
available to others such that they won't bump into the same problems we
did!

The THIRD issue we had (actually, are having) is very related to our
second issue.  Our customer now wants a 2Gb NAND on our board.  We
swapped the chip out.  We included one more address byte transaction
that is needed with the larger part in the driver.  And it doesn't work.
The part is considered to be the "bigger brother" to the 1Gb part, but
apparently enough of it's state machine has changed that it doesn't
tolerate the AL and CL lines going high while chip select is low.
Incidentally, when debugging our second issue we were told by ST Micro
support that the only time AL and CL were sampled by the NAND was when
W# and R# were driven low.  Had we known that the 2Gb part wouldn't have
worked, we would have done much more major reworking to the NAND
subsystem when we respun our board.

This mail isn't meant to be a rant.  Everyone knows that this kind of
low-level hardware/software work is difficult.  This mail is meant to
caution you against using the NAND with the UPM.  Freescale may say that
it works, and present you a pretty looking white paper, but it's really
kludgy and you are pretty guaranteed to have problems.  Please encourage
your board designers to hook the NAND to some sort of CPLD device rather
than the UPM.  At least with a CPLD you have some real control over the
state of the control lines.

If you for whatever reason are stuck with the UPM...
1.)  Get your hardware people to stick inverters on the AL and CL lines.
Adjust your UPM microcode accordingly.
2.)  Put your CS under control of a GPIO pin.
3.)  Buy a nice logic analyzer, because you're going to need it!!!

I hope this helps someone out there... I've been spending a lot of time
on-and-off on this.  Every time we think we have it right one little
seemingly benign change throws the whole thing out the window...

Okie, happy coding,

Chris Fester
