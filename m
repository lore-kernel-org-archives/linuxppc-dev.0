Date: Sun, 10 Jan 1999 16:02:04 +0100
To: linuxppc-dev@lists.linuxppc.org, Paul Mackerras <paulus@cs.anu.edu.au>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: macserial, DMA, some questions
Message-Id: <19990110160204.018268@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi All !

I'm working on implementing DMA (and other stuffs like power on/power off
of the SCC for power saving on PowerBooks) in linux serial drivers for
PowerMacs (macserial.c) and I have a couple of questions related to linux
serial implementation.

 - I've added code that enables or disables the SCC channels and core in
Apple's ASICs depending on it's use. The code is an extension (and bug
fix) of my previous code for the internal modem and is called in
startup() and shutdown() functions where, obviously, the SCC is
initialized and disabled. However, there is one thing I'm not completely
sure of:

In the macserial_init() function, there is a test agains "is_cons" (a
member of the channel structure) and if true, Tx and Rx interrupts are
enabled. This is done without (at least I've not seen it) calling startup
and without any other SCC initialisation, and with my new code, this
won't work since by default, SCC is shut down until the driver is first
opened (except when using xmon or kgdb). Also I didn't find any place
where "is_cons" is either initialised or set to true.


 - The driver maintains _two_ images of all SCC registers in the arrays
"curregs" and "pendregs". However, I didn't find a single place in the
code where "pendregs" is actually read, it looks like datas in "curregs"
is always copied to "pendregs" but "pendregs" is never used. Can I just
get rid of it ?


 - The driver uses a spinlock for register access, but no spinlock is
used at all for higher level manipulations like startup or shutdown for
example. The driver just uses ordinary save_flags();cli() stuffs. Isn't
this buggy ? I was thinking about replacing all occurences of cli()-based
synchros by spinlock_irqsave and protecting the interrupt handler itself
with spinlock, am I wrong ? (I don't have an SMP machine to test with).


 - Could someone explain me the goal of the task-queue based "wakeup"
mechanism ? If I correctly understand, when chars are written, if the
transmit buffer contains less than WAKEUP_CHARS chars, a TTY function is
called to ask for more, that's it ? This one will be not simple to adapt
to DMA. Are we sure we will get chars to send immediately ? I mean, with
this code, _each_ character sent with a tx buffer containing less than
256 chars will cause execution of a task queue and call to the wakeup
function. Isn't this a little bit too "violent" ? Shouldn't we "remember"
that we have sent this event, and avoid resending it again and again... ? 
Also, the way it's implemented, the event will be set at interrupt time,
a task queue will be scheduled, and the bh handler will test&clear the
event. That means that if several interrupts occur before the bh happens
we will re-queue the task queue again and again. Shouldn't we test&set
the bit and only queue the bh if the bit was not previously set ?


 - Finally, what is the exact different between rs_start/rs_stop and
rs_throttle/rs_unthrottle ? It looks like the throttle things is actually
the flow-control, that's it ?


Benjamin.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
