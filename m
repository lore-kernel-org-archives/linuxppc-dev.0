Date: Sat, 19 Jun 2004 09:59:53 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	Alan Cox <alan@www.pagan.org.uk>, Nicolas DET <nd@bplan-gmbh.de>,
	Linux-USB <linux-usb-devel@lists.sourceforge.net>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [linux-usb-devel] [Patch] for UHCI driver (from kernel 2.6.6).
In-Reply-To: <1087595028.2061.295.camel@gaston>
Message-ID: <Pine.LNX.4.44L0.0406190953120.19842-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 18 Jun 2004, Benjamin Herrenschmidt wrote:

> > I recently changed a few mb() calls to wmb(), because they only protected
> > data the CPU was writing to be read by the device.  Do you think changing
> > all the wmb()'s back to mb()'s would make a difference?
> >
> > (Actually it seems likely that this is _not_ directly related to the
> > original problem, but it might be important anyway.)
>
> Well, the problem on ppc is that the eieio done by wmb() (or implicitely
> done by all writeX IO accessors) will only order stores in the same
> domain. That is cacheable aren't ordered vs. non cacheables.

I'm not familiar with the term "eieio"; can you explain it?

> For example, write to a descriptor in memory, then writel() to your
> device, that isn't guaranteed to happen in order.

Then it shouldn't matter for what I'm doing, which involves multiple
writes to the same region of "consistent" memory.  Or maybe it's only
"coherent" memory -- the important thing is that the first write must
complete and be visible to the device's DMA before the second.  wmb()
will suffice for that, right?

> In this case, you indeed need an mb(), but that's a ppc thing and the
> race on ppc32 CPUs is quite small (though ppc64, typically POWER4 and
> POWER5, will eat you for lunch with their multiple deep store queues).

Thanks,

Alan Stern


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
