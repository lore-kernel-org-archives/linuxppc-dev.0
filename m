From: Gabriel Paubert <paubert@iram.es>
Date: Tue, 29 Apr 2003 14:08:38 +0200
To: Fred Gray <fegray@socrates.berkeley.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ppc_irq_dispatch_handler dominating profile?
Message-ID: <20030429120838.GA18537@iram.es>
References: <20030427194236.GC25907@socrates.berkeley.edu> <16044.23965.747962.112267@nanango.paulus.ozlabs.org> <20030428085342.GA7396@iram.es> <20030428124224.GC26408@socrates.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030428124224.GC26408@socrates.berkeley.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hi Fred,

On Mon, Apr 28, 2003 at 05:42:24AM -0700, Fred Gray wrote:
>
> On Mon, Apr 28, 2003 at 10:53:42AM +0200, Gabriel Paubert wrote:
> > Hmmm, I get more than 100MB/s on my MVME2600 with a 200MHz 603e,
> > although not the half GB/s Motorola claims it is capable of. But a 604
> > should be a bit faster. The chipset is old (1997) but it was rather
> > fast when it came out, especially because the memory interface is 128
> > bits wide. This said, putting a gbit Ethernet (PMC module I suppose)
> > on it is stretching it a bit.
> >
> > Is the 100Mb/s of the builtin interface too slow for you?
>
> Hi, Gabriel, (...and many thanks for your hard work porting Linux to these
>   boards in the first place--I am extremely glad to be in a position to leave
>   vxWorks behind)

Glad that it helped. And another "customer" of my MVME port (and
perhaps VME driver too) which I discover right now ;-)

(I'm planning to do a port of late 2.5/early 2.6 in less than a year,
I don't know exactly when but I shall have to do it).

> The gigabit Ethernet is indeed on a PMC module (from SBS Technologies,
> PMC-Gigabit-ST3).  Our electronics generates about 15 MB/s per VME crate;
> it's digitizing tracks left by muons in a time-projection chamber.
> There are two crates, each with this rate, each equipped with an MVME2600
> with an gigabit card, and they have to transfer this firehose of data to a
> computer that will do some as-yet-undefined online data reduction and
> send the result to an LTO 2 tape robot.  So, yes, we need about 50% more
> throughput than the built-in 10/100 Ethernet port could provide, and we need
> it with enough CPU time left over to manage the VME readout.

Ok, I use them differently. The 6 MVME 2600 I have doing data acquisition
produce very little data on the network (<300 kB/s, but they process it quite
a lot, including a Fourier transform, bewteen acquisition and sending). Newer
systems use MVME2400 which are way faster. The main problem I had (solved now) is
that 4 of my boards are from the first batches and that I had to carefully
work around the pile of bugs of the Universe I PCI<->VME bridge.

>
> Fortunately, though, we don't need the whole gigabit.  I agree that would
> probably be well-nigh impossible.  Still, I'm very interested in understanding
> why the interrupt overhead seems to be so high at our 10 to 15 MB/s
> interrupt rate.

How many interrupts do you have altogether, how many VME interrupts too
if it's not secret (cat /proc/bus/vme/interrupts if you use my driver).

Do you have lots of bad interrupts (cat /proc/interrupts)?

Do you know how much time you spend in the VME interrupt routines
(which are run with interrupts masked if you use my driver, but there
is really no other solution, the Universe being essentially a cascaded
interrupt controller) ?

Do you know the percentage of bus utilization due to DMA ?

Do both machines exhibit the same problem ?

Which kernel version are you using?

	Regards,
	Gabriel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
