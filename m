Date: Tue, 7 Mar 2000 22:00:10 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Grant Erickson <grant@borg.umn.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Grabbing an Interrupt for a Brain-dead PCI Device
In-Reply-To: <Pine.SGI.4.21.0003071435240.45384-100000@brule.borg.umn.edu>
Message-ID: <Pine.LNX.4.05.10003072154320.484-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 7 Mar 2000, Grant Erickson wrote:
> So, unfortunately, I didn't do the design for this "dumb" PCI device and
> neither can I fix its shortcomings in these regards.

Hmm... That's bad luck. Then you have to do some things manually (read: in your
own code).

> Below, we've acknowledged and discovered how to sort of work-around the
> problem of the invalid vendor ID and the base address. Now, I've yet
> another problem.
>
> The device has an interrupt at INTA#. Unfortunately, the device being dumb
> as it is, doesn't utilize the interrupt pin register to advertise that it
> does in fact have an interrupt there. So, I assume that once again, the
> PROM doesn't give it one.
>
> Is there a way, in Linux, for me to programmatically and manually assign
> an interrupt to this device as might have been done in the PROM? I'm
> guessing I have to twiddle some registers in the North Bridge, correct?

In most machines, PCI interrupt routing is hardwired on the motherboard.  Hence
you probably don't have to program the North Bridge for that.

Furthermore the interrupt pin register is read-only on normal cards, and
initialized to INTA#. It's not used by the PCI device itself. The interrupt
number register is read-write and is only there so the PROM code (which is
supposed to know the interrupt routing on the motherboard) can fill in the
correct value and applications can read it back later.

I think it's sufficient to let your PCI fixup code fix up the interrupt fields
in the struct pci_dev that corresponds to your weird device.

Good luck!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
