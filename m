Date: Fri, 9 May 2003 13:34:17 -0400
From: Kent Borg <kentborg@borg.org>
To: Dale Farnsworth <dale@farnsworth.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Shared Interrupts Question (2.4)
Message-ID: <20030509133417.B26462@borg.org>
References: <20030508160856.A18714@borg.org> <20030508211426.GA1440@rover.farnsworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030508211426.GA1440@rover.farnsworth.org>; from dale@farnsworth.org on Thu, May 08, 2003 at 02:14:26PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, May 08, 2003 at 02:14:26PM -0700, Dale Farnsworth wrote:
> Create and register a board-specific interrupt driver.  Assign it
> a range of irqs (non-conflicting with the main interrupt driver).
> When called with an irq outside its range, the board-specific driver
> routines forward the call to the main driver.

Cool, cool...

> The board-specific driver does a request_irq at init time for the
> one main irq it is multiplexing.

What does my handler on the main irq do?  Perhaps nothing?

I am figuring I supply my own get_irq call, and it returns one of this
new interrupt range, or if none, calls the previous get_irq.  If I
never let the main irq number come back, my handler on the main irq
never gets called, right?  If so, why am calling request_irq in the
first place?  To keep the system from puking on spurious interrupts?
(But if I answer the get_irq, and if I never answer the main irq
number, how would it know?)


Thanks,

-kb, the Kent who thinks he is getting close.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
