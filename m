Date: Wed, 11 Jun 2003 08:39:53 -0400
From: Kent Borg <kentborg@borg.org>
To: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Why ack interrupt before calling handler?
Message-ID: <20030611083953.A26856@borg.org>
References: <20030606142939.B15725@borg.org> <1055327622.26152.70.camel@spawn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1055327622.26152.70.camel@spawn>; from kenneth.johansson@etx.ericsson.se on Wed, Jun 11, 2003 at 12:33:42PM +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jun 11, 2003 at 12:33:42PM +0200, Kenneth Johansson wrote:
> I don't know what code you are looking at but generally you want to
> first ack to avoid the race condition that would otherwise be present if
> you first run your interrupt routine then ack. How would you know that
> it was in fact not a new interrupt condition that you have not taken
> care of you just removed.

In my case I have a level-triggered interrupt that is latched by the
hardware.

So the first ack tells the interrupt controller to forget about it,
but as the interrupting hardware has not yet been serviced, the
level-triggered interrupt is still being asserted, so that ack becomes
a nop.

Now the specific handler gets called, it deals with the specifics of
the situation, removing the cause of the interrupt, and returns.

Finally the interrupt end gets called, which acks and enables the
interrupt.  This ack actually does something for me.

I am thinking that the general purpose PPC code does the early
ack for edge-triggered circumstances.  For latched level-triggered
cases there is no harm in the extra early ack.


Thanks,

-kb, the Kent whose nose has been closely in that code because he has
been chasing a spurious interrupt problem.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
