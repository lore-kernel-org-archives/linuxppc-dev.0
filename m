From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16044.23965.747962.112267@nanango.paulus.ozlabs.org>
Date: Mon, 28 Apr 2003 08:45:49 +1000 (EST)
To: Fred Gray <fegray@socrates.berkeley.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ppc_irq_dispatch_handler dominating profile?
In-Reply-To: <20030427194236.GC25907@socrates.berkeley.edu>
References: <20030427194236.GC25907@socrates.berkeley.edu>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Fred Gray writes:

> In both cases, ppc_irq_dispatch_handler is the "winner."  I'm not very familiar
> with the kernel profiler, especially on the PowerPC, so I don't know whether
> or not this is likely to be an artifact of piled-up timer interrupts.
> Otherwise, it suggests that something dramatically inefficient is
> happening in the interrupt handling chain, since it spends twice as much
> time here as it does touching all of the outgoing data for the copy and
> checksum.

ppc_irq_dispatch_handler is the first place where interrupts get
turned on in the interrupt handling path, so all the time spent saving
registers and finding out which interrupt occurred gets attributed to
it.

How many interrupts per second are you handling?  A 200MHz 604e isn't
a fast processor by today's standards.  Also, how fast is your memory
system?  I would be a little surprised if the memory controller could
deliver any more than about 100MB/s.

I think that you will have to use interrupt mitigation to go any
faster, and I will be amazed if you can actually do 1Gb/s with an old
slow system such as you have.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
