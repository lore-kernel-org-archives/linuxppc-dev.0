Message-Id: <200003072200.XAA00434@piglet.grunz.lu>
Date: Tue, 7 Mar 2000 23:00:27 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Grabbing an Interrupt for a Brain-dead PCI Device
To: grant@borg.umn.edu
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.SGI.4.21.0003071435240.45384-100000@brule.borg.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

On   7 Mar, this message from Grant Erickson echoed through cyberspace:
> The device has an interrupt at INTA#. Unfortunately, the device being dumb
> as it is, doesn't utilize the interrupt pin register to advertise that it
> does in fact have an interrupt there. So, I assume that once again, the
> PROM doesn't give it one.

Of course not... how should it know? But....

> Is there a way, in Linux, for me to programmatically and manually assign
> an interrupt to this device as might have been done in the PROM? I'm
> guessing I have to twiddle some registers in the North Bridge, correct?

As far as I know, yes, it depends on the host bridge. However, I don't
think there's any bridge configuration involved here, as the interrupt
pin routing would rather be done in hardware.

If this is in a PowerMac (at least those previous to UMA), then there
is a fixed IRQ per physical slot. All 4 PCI interrupt lines are OR'ed
together per slot.

However, there are other IRQ routing schemes as well... the above being
the easiest one, because the IRQ value can be hardcoded based on the
slot, which you can determine by software.

Plus, there are ways to determine an unknown IRQ by letting the device
generate an interrupt, and seing what IRQ it comes in on. You might
find more info in 'Linux Device Drivers' by Alessandro Rubini.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
