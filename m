From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Thu, 8 May 2003 14:14:26 -0700
To: Kent Borg <kentborg@borg.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Shared Interrupts Question (2.4)
Message-ID: <20030508211426.GA1440@rover.farnsworth.org>
References: <20030508160856.A18714@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030508160856.A18714@borg.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, May 08, 2003 at 08:08:56PM +0000, Kent Borg wrote:
>
> I am trying to understand "kinda shared" interrupts.
>
> There are various interrupts in my not-yet-released CPU, and I have
> interrupt code that knows how to talk to them.  So far so good.  I
> also have an external interrupt controller that groups together 18
> external interrupt sources and sends them in one CPU pin.  This
> external controller has a register for enabling interrupts, and a
> register for status/acknowledge.  Pretty standard.
>
> The CPU code doesn't know about the external controller.  It seems
> silly to rewrite the CPU-specific interrput code to accommodate this
> board-specific detail (besides then my code won't match Dale's).  So I
> figure I tell the kernel I am doing shared interrupts.
>
> So where do I enable, disable, and acknowledge these external bits?
> Specifically, I am trying to get a couple of serial ports working.  I
> can put conditional code in serial.c startup() to enable these
> interrupts, but how do I know which serial port?  Add a conditionally
> compiled sub-IRQ number to serial_state structure?
>
> Is there a cleaner way?

Create and register a board-specific interrupt driver.  Assign it
a range of irqs (non-conflicting with the main interrupt driver).
When called with an irq outside its range, the board-specific driver
routines forward the call to the main driver.  The board-specific driver
does a request_irq at init time for the one main irq it is multiplexing.

-Dale

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
