Date: Fri, 18 Jun 2004 17:41:22 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	Alan Cox <alan@www.pagan.org.uk>, Nicolas DET <nd@bplan-gmbh.de>,
	Linux-USB <linux-usb-devel@lists.sourceforge.net>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [linux-usb-devel] [Patch] for UHCI driver (from kernel 2.6.6).
In-Reply-To: <1087594287.8697.291.camel@gaston>
Message-ID: <Pine.LNX.4.44L0.0406181737520.1334-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 18 Jun 2004, Benjamin Herrenschmidt wrote:

> I think it's more likely we are dealing with an ordering issue of
> accesses to memory vs. mmio, those aren't order unless you use memory
> barriers. Actually, it's worse, you need a full mb() to order them,
> which is why lately, we made ppc64 writeX() do full sync's ... that sucks
> but it's near to impossible to get an abstract IO API that would cover
> our needs here and still make other archs happy it seems...

I recently changed a few mb() calls to wmb(), because they only protected
data the CPU was writing to be read by the device.  Do you think changing
all the wmb()'s back to mb()'s would make a difference?

(Actually it seems likely that this is _not_ directly related to the
original problem, but it might be important anyway.)

Alan Stern


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
