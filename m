Date: Tue, 30 Mar 1999 13:41:41 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Paul.Mackerras@cs.anu.edu.au
cc: bh40@calva.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: Blue G3 and machine check
In-Reply-To: <199903292344.JAA03278@tango.anu.edu.au>
Message-ID: <Pine.HPP.3.96.990330131656.1043J-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 30 Mar 1999, Paul Mackerras wrote:

> The PCI spec says that the host bridge must unambiguously report
> attempts to read the vendor ID of nonexistent devices, and that it is
> adequate for the host bridge to return ~0 on read accesses to config
> space registers of nonexistent devices.
> 
> I guess a machine check can be regarded as pretty unambiguous.
> Sigh. :-(

Indeed. But if it only happens on access through the P2P bridges, it means
that the bridge transforms Master Abort on the secondary side into Target
Aborts on the primary. IIRC there is a bit in the configuration of the
bridge to control this. 

> Imagine that an interrupt occurs between the load/store and the sync.
> The CPU could be in full superscalar flight when it gets the error
> ack.  The registers could certainly be in an inconsistent state when
> we get to the machine check handler.  So we at least need to disable
> interrupts around the access.

I always sais that the first thing to do is to disable interrupts. There
is no hope of getting it running with interrupts enabled. Indeed all
accesses to the PCI config space should performed with interrupts disabled
and protected by a spinlock on SMP; given the indirect nature of most
bridges, a layer that locks and checks for basically valid parameters as
done on Intel in arch/i386/kernel/bios32.c is necessary: most ECC memory
controllers report error status in PCI config space and you need to access
it from interrupts if you decide to hanle memory errors properly. But you
need to be extremely careful because of the situation that miht arise: you
hold a spinlock, a machine check occurs and you try to get the same
spinlock to clear the error status. Deadlock in sight...

> > And yes, I just reread the following: "Note that if the error is caused by
> > the memory subsystem, incorrect data could be loaded into the processor
> > and register contents could be corrupted regardless of whether the
> > exception is considered recoverable by the SRR1 bit corresponding to
> > MSR[RI]." 
> > 
> > But I interpret it as the registers modified by the instruction and the
> > potential use of the corrupted data by subsequent instructions, which
> > should be bounded by following sync; if you interpret it very liberally
> > all registers could be corrupted, not only GPR (including the stack
> > pointer) but why not also LR, CTR, XER, CR, FPRs, FPSCR, BATS, segments,
> > timebase, decrementer, SDR1, SPRGn, HID0 and others.
> 
> Indeed. :-)
> 
> I think it's likely that the following sequence will work OK:
> 
> 	mtmsr to disable interrupts
> 	sync
> 	load/store
> 	sync
> 	re-enable interrupts if necessary
> 
> and if we get a machine check on the second sync, the registers should
> be OK.
> 
> Thoughts?

Willl SRR0 point at or after the sync instruction ? Adding an isync
stops fetching and might act as a barrier on the point to which 
SRR0 progresses. 

It needs some checking, and it might also depend on the actual delay on
the machine check in the bridge and processor; in most processors the
machine check and interrupts pins are filtered and take a few clocks to
reach the core, the transfer error acknowlegde does obviously not suffer
from this problem. 

	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
