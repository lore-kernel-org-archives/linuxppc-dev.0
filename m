From: Gabriel Paubert <paubert@iram.es>
Date: Mon, 28 Apr 2003 10:53:42 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: Fred Gray <fegray@socrates.berkeley.edu>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: ppc_irq_dispatch_handler dominating profile?
Message-ID: <20030428085342.GA7396@iram.es>
References: <20030427194236.GC25907@socrates.berkeley.edu> <16044.23965.747962.112267@nanango.paulus.ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <16044.23965.747962.112267@nanango.paulus.ozlabs.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Apr 28, 2003 at 08:45:49AM +1000, Paul Mackerras wrote:
>
> Fred Gray writes:
>
> > In both cases, ppc_irq_dispatch_handler is the "winner."  I'm not very familiar
> > with the kernel profiler, especially on the PowerPC, so I don't know whether
> > or not this is likely to be an artifact of piled-up timer interrupts.
> > Otherwise, it suggests that something dramatically inefficient is
> > happening in the interrupt handling chain, since it spends twice as much
> > time here as it does touching all of the outgoing data for the copy and
> > checksum.
>
> ppc_irq_dispatch_handler is the first place where interrupts get
> turned on in the interrupt handling path, so all the time spent saving
> registers and finding out which interrupt occurred gets attributed to
> it.
>
> How many interrupts per second are you handling?  A 200MHz 604e isn't
> a fast processor by today's standards.  Also, how fast is your memory
> system?  I would be a little surprised if the memory controller could
> deliver any more than about 100MB/s.

Hmmm, I get more than 100MB/s on my MVME2600 with a 200MHz 603e,
although not the half GB/s Motorola claims it is capable of. But a 604
should be a bit faster. The chipset is old (1997) but it was rather
fast when it came out, especially because the memory interface is 128
bits wide. This said, putting a gbit Ethernet (PMC module I suppose)
on it is stretching it a bit.

Is the 100Mb/s of the builtin interface too slow for you?

	Gabriel.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
