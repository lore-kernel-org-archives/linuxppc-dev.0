Date: Tue, 30 Mar 1999 09:44:48 +1000
Message-Id: <199903292344.JAA03278@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: paubert@iram.es
CC: bh40@calva.net, linuxppc-dev@lists.linuxppc.org
In-reply-to: <Pine.HPP.3.96.990325105034.1078R-100000@gra-ux1.iram.es>
	(message from Gabriel Paubert on Thu, 25 Mar 1999 12:20:33 +0100
	(MET))
Subject: Re: Blue G3 and machine check
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.HPP.3.96.990325105034.1078R-100000@gra-ux1.iram.es>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert <paubert@iram.es>

> No, the PCI connector also has a presence detect pin which should be used
> for this. The PCI specification is very clear that the only cycles
> which are expected to end with a Master Abort are the special cycles.
> Configuration cycles are like any other cycles and a Mater Abort may
> result in a device pulling the SERR line and taking exceptions in this
> case. 

The PCI spec says that the host bridge must unambiguously report
attempts to read the vendor ID of nonexistent devices, and that it is
adequate for the host bridge to return ~0 on read accesses to config
space registers of nonexistent devices.

I guess a machine check can be regarded as pretty unambiguous.
Sigh. :-(

> But the worst is that you are not guaranteed anything about SRR0, so an in
> memory per processor flag telling 'hey, I might actually get a machine
> check, might be required'. For the registers, I can't believe that after a
> sync/isync sequence, any implementation will ever randomly modify any
> other register than the destination for the loads (and the address
> register for update form instructions). 

Imagine that an interrupt occurs between the load/store and the sync.
The CPU could be in full superscalar flight when it gets the error
ack.  The registers could certainly be in an inconsistent state when
we get to the machine check handler.  So we at least need to disable
interrupts around the access.

> And yes, I just reread the following: "Note that if the error is caused by
> the memory subsystem, incorrect data could be loaded into the processor
> and register contents could be corrupted regardless of whether the
> exception is considered recoverable by the SRR1 bit corresponding to
> MSR[RI]." 
> 
> But I interpret it as the registers modified by the instruction and the
> potential use of the corrupted data by subsequent instructions, which
> should be bounded by following sync; if you interpret it very liberally
> all registers could be corrupted, not only GPR (including the stack
> pointer) but why not also LR, CTR, XER, CR, FPRs, FPSCR, BATS, segments,
> timebase, decrementer, SDR1, SPRGn, HID0 and others.

Indeed. :-)

I think it's likely that the following sequence will work OK:

	mtmsr to disable interrupts
	sync
	load/store
	sync
	re-enable interrupts if necessary

and if we get a machine check on the second sync, the registers should
be OK.

Thoughts?

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
