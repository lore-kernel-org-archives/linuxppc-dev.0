Date: Thu, 25 Mar 1999 12:20:33 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Paul.Mackerras@cs.anu.edu.au
cc: bh40@calva.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: Blue G3 and machine check
In-Reply-To: <199903242312.KAA31937@tango.anu.edu.au>
Message-ID: <Pine.HPP.3.96.990325105034.1078R-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 25 Mar 1999, Paul Mackerras wrote:

> Gabriel Paubert <paubert@iram.es> wrote:
> 
> > Note that you probably only need to protect the PCI config space accesses,
> 
> If we are getting machine checks on config space accesses, then it is
> truly borken.  Config spaces accesses in PCI are supposed to return ~0
> if there is no device there, precisely so that you can safely probe to
> see whether the device is there.

No, the PCI connector also has a presence detect pin which should be used
for this. The PCI specification is very clear that the only cycles
which are expected to end with a Master Abort are the special cycles.
Configuration cycles are like any other cycles and a Mater Abort may
result in a device pulling the SERR line and taking exceptions in this
case. 
  
> Did the original poster say whether the machine checks were on config
> space accesses or I/O or memory space accesses?  It's common enough for
> drivers written for intel linux to go probing I/O ports to try to find
> devices to talk to. 

They were on PCI config space IIRC. 

> I think this is not sufficient because you are not generally
> guaranteed anything about the state of the registers after a machine
> check.  AFAICS, we would have to save the contents of all the
> registers (at least all of the callee-saved ones) and restore them
> from memory if a machine check occurs.  We could use setjmp/longjmp to
> do this.  And yes, we do need the sync after the access, but I don't
> see why we would need the isync.


No I don't think we need the isync after either, and perhaps not before
since sync guarantees "that no subsequent instructions appear to be
initiated until the sync instruction completes".  There is also a
recoverable flag in the MSR and I don't know what its state was in this
case. 

But the worst is that you are not guaranteed anything about SRR0, so an in
memory per processor flag telling 'hey, I might actually get a machine
check, might be required'. For the registers, I can't believe that after a
sync/isync sequence, any implementation will ever randomly modify any
other register than the destination for the loads (and the address
register for update form instructions). 

And yes, I just reread the following: "Note that if the error is caused by
the memory subsystem, incorrect data could be loaded into the processor
and register contents could be corrupted regardless of whether the
exception is considered recoverable by the SRR1 bit corresponding to
MSR[RI]." 

But I interpret it as the registers modified by the instruction and the
potential use of the corrupted data by subsequent instructions, which
should be bounded by following sync; if you interpret it very liberally
all registers could be corrupted, not only GPR (including the stack
pointer) but why not also LR, CTR, XER, CR, FPRs, FPSCR, BATS, segments,
timebase, decrementer, SDR1, SPRGn, HID0 and others.

	Gabriel.




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
