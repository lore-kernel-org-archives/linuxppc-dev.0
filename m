Date: Mon, 28 Apr 2003 00:33:18 -0700
From: Fred Gray <fegray@socrates.berkeley.edu>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ppc_irq_dispatch_handler dominating profile?
Message-ID: <20030428073318.GA26408@socrates.berkeley.edu>
References: <20030427194236.GC25907@socrates.berkeley.edu> <16044.23965.747962.112267@nanango.paulus.ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <16044.23965.747962.112267@nanango.paulus.ozlabs.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Apr 28, 2003 at 08:45:49AM +1000, Paul Mackerras wrote:
> ppc_irq_dispatch_handler is the first place where interrupts get
> turned on in the interrupt handling path, so all the time spent saving
> registers and finding out which interrupt occurred gets attributed to
> it.
>
> How many interrupts per second are you handling?  A 200MHz 604e isn't
> a fast processor by today's standards.  Also, how fast is your memory
> system?  I would be a little surprised if the memory controller could
> deliver any more than about 100MB/s.
>
> I think that you will have to use interrupt mitigation to go any
> faster, and I will be amazed if you can actually do 1Gb/s with an old
> slow system such as you have.

Hi, Paul,

Interrupt throttling is enabled on the card.  According to /proc/interrupts,
there were about 1250 eth0 interrupts per second while running, which doesn't
seem like so terribly many.  I can tune this parameter: larger interrupt
throttling rates definitely increase throughput for low MTUs (1500) but not
large MTUs (16000).  The profile traces that I posted were for an MTU of 16000.

Fortunately, I don't actually need to saturate the gigabit link for my
application.  I need to deliver about 15 MB/s worth of data to a server
from each of a few VME crates, and I need to be able to do this with some
CPU time left over to transfer the data over the VME bus from our custom
electronics (which can in principle be done with zero-copy DMA, though
currently the driver does a kernel-to-user copy).

Bandwidth tests over the loopback interface give 36.6 MB/s for the normal
socket API and 87.5 MB/s for the zero-copy path (which is a one-copy path
when the recipient is on the same host).  So, your 100 MB/s estimate is
just about right on.

It seems odd to me that the vast majority of the work involved in handling the
interrupt is in saving registers and finding a handler, and not in the handler
itself.  Is there any good way that I can test whether the system is (e.g.)
spending a lot of time waiting on the spinlocks in ppc_irq_dispatch_handler?

Thanks very much for your help,

-- Fred

-- Fred Gray / Visiting Postdoctoral Researcher                         --
-- Department of Physics / University of California, Berkeley           --
-- fegray@socrates.berkeley.edu / phone 510-642-4057 / fax 510-642-9811 --

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
