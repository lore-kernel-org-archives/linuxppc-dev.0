From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Fri, 9 May 2003 19:00:14 -0700
To: Kent Borg <kentborg@borg.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Shared Interrupts Question (2.4)
Message-ID: <20030510020014.GA4135@rover.farnsworth.org>
References: <20030508160856.A18714@borg.org> <20030508211426.GA1440@rover.farnsworth.org> <20030509133417.B26462@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030509133417.B26462@borg.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, May 09, 2003 at 05:34:17PM +0000, Kent Borg wrote:
> On Thu, May 08, 2003 at 02:14:26PM -0700, Dale Farnsworth wrote:
> > Create and register a board-specific interrupt driver.  Assign it
> > a range of irqs (non-conflicting with the main interrupt driver).
> > When called with an irq outside its range, the board-specific driver
> > routines forward the call to the main driver.
>
> Cool, cool...
>
> > The board-specific driver does a request_irq at init time for the
> > one main irq it is multiplexing.
>
> What does my handler on the main irq do?  Perhaps nothing?

Nothing.  You make sure that get_irq never returns that irq, so
the handler won't be called.

> I am figuring I supply my own get_irq call, and it returns one of this
> new interrupt range, or if none, calls the previous get_irq.  If I
> never let the main irq number come back, my handler on the main irq
> never gets called, right?  If so, why am calling request_irq in the
> first place?

To enable (unmask) the main irq.  I think you're right, it's better
to not call request_irq and just enable the irq directly.

> To keep the system from puking on spurious interrupts?
> (But if I answer the get_irq, and if I never answer the main irq
> number, how would it know?)

I'd call the main get_irq before checking for interrupt in my range.

my_get_irq() {
	int irq = main_get_irq();

	if (irq != my_irq)
		return irq;

	/* find which irq in my range cascaded into my_irq */
	irq = find_cascaded_irq();

	return irq;
}

-Dale

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
