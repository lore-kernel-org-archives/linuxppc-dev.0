Date: Wed, 11 Jun 2003 08:51:14 -0400
From: Kent Borg <kentborg@borg.org>
To: eric lescouet <eric.lescouet@Jaluna.COM>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Why ack interrupt before calling handler?
Message-ID: <20030611085114.B26856@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3EE71F77.80200@Jaluna.COM>; from eric.lescouet@Jaluna.COM on Wed, Jun 11, 2003 at 02:24:23PM +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jun 11, 2003 at 02:24:23PM +0200, eric lescouet wrote:
> This would prevent a level triggered interrupt to be raised again when enabling
> interrupts at processor level, until the called handler clear the interrupt
> condition on the device.

And it occurs to me that unless an interrupt can be "queued" between
the time the handler has checked (one last time) for all pending work
and the PPC code re-enables the interrupt at the PIC level, this would
be a window in which an edge-triggered interrupt could be lost.

> Any way, note that these routines called from irq.c are PIC driver
> specific,

Yes.  I have one set of PIC code that is for an interrupt controller
that is on-chip with the CPU, and I have a second set of PIC code for
a cascaded interrupt controller that is implemented in an off-chip
FPGA.  It is kind of cool that such nested complexity can be so nicely
represented to the kernel by simply having a single flat list of IRQs.
(I didn't spot that simple solution, Dale Farnsworth had to point it
out to me.)


Thanks,

-kb, the Kent who is willing to learn from others.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
