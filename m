Message-ID: <3C39FF41.87AD961A@web.de>
Date: Mon, 07 Jan 2002 21:04:17 +0100
From: Frank Haverkamp <f.haverkamp@web.de>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: How many Interrupts at the same time?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

we have a custom made 403 based board with up to 128 interrupts which
may occur simultaniously. After reading the interrupt handling code, we
came to the
conclusion that when too many interrupts are stacked, the kernel stack
will overflow.

When the first interrupt is handled the kernel leaves do_IRQ and returns
to the assembly code
in entry.S where in do_soft_irq() the interrupts are reenabled due to
issuing sti(). When
EE in the MSR is enabled the system will execute the next exception and
store another sizeof
(struct pt_regs) bytes on the stack plus some additional data
(stackframe, link reg., etc.).
 This sums up to 184 bytes each. This leaves room for 30-40 interrupts
until we will get an
 overflow. But we need in worst case space for 128 interrupts.

 Is there a mistake in our analysis? Do other people have the same
problem and probably already
a solution? What options do we have?

 Frank Haverkamp
 & Joern Engel


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
