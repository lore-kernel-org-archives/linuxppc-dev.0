Subject: Re: [linux-usb-devel] [Patch] for UHCI driver (from kernel 2.6.6).
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	Alan Cox <alan@www.pagan.org.uk>, Nicolas DET <nd@bplan-gmbh.de>,
	Linux-USB <linux-usb-devel@lists.sourceforge.net>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.LNX.4.44L0.0406181737520.1334-100000@ida.rowland.org>
References: <Pine.LNX.4.44L0.0406181737520.1334-100000@ida.rowland.org>
Content-Type: text/plain
Message-Id: <1087595028.2061.295.camel@gaston>
Mime-Version: 1.0
Date: Fri, 18 Jun 2004 16:43:49 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2004-06-18 at 16:41, Alan Stern wrote:
> On Fri, 18 Jun 2004, Benjamin Herrenschmidt wrote:
>
> > I think it's more likely we are dealing with an ordering issue of
> > accesses to memory vs. mmio, those aren't order unless you use memory
> > barriers. Actually, it's worse, you need a full mb() to order them,
> > which is why lately, we made ppc64 writeX() do full sync's ... that sucks
> > but it's near to impossible to get an abstract IO API that would cover
> > our needs here and still make other archs happy it seems...
>
> I recently changed a few mb() calls to wmb(), because they only protected
> data the CPU was writing to be read by the device.  Do you think changing
> all the wmb()'s back to mb()'s would make a difference?
>
> (Actually it seems likely that this is _not_ directly related to the
> original problem, but it might be important anyway.)

Well, the problem on ppc is that the eieio done by wmb() (or implicitely
done by all writeX IO accessors) will only order stores in the same
domain. That is cacheable aren't ordered vs. non cacheables.

For example, write to a descriptor in memory, then writel() to your
device, that isn't guaranteed to happen in order.

In this case, you indeed need an mb(), but that's a ppc thing and the
race on ppc32 CPUs is quite small (though ppc64, typically POWER4 and
POWER5, will eat you for lunch with their multiple deep store queues).

Ben


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
