Date: Wed, 8 Mar 2000 12:47:16 -0600
From: Grant Erickson <grant@borg.umn.edu>
To: Michel Lanners <mlan@cpu.lu>
cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
        Matt Porter <mmporter@home.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Grabbing an Interrupt for a Brain-dead PCI Device
In-Reply-To: <200003072200.XAA00434@piglet.grunz.lu>
Message-ID: <Pine.SGI.4.21.0003081136360.51665-100000@brule.borg.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks for all the assistance on this issue thus far. This has been an
interesting trial under the guise of "life is just unnecessarily hard when
hardware designers fail to do things the right way."

My system:
	Power Macintosh G3 300

So, after playing with a few other PCI cards, I find:

                 ---------------------------------------------------------
     Board Slot  |      0      |      1      |      2      |      3      |
                 ---------------------------------------------------------
Pin  Product     |  IRQ   Dev  |  IRQ   Dev  |  IRQ   Dev  |  IRQ    Dev |
                 ---------------------------------------------------------
 A   AMD Lance   |   25    15  |   24    14  |   23    13  |   --     -- |
 A   ATI Rage*   |   --    --  |   --    --  |   --    --  |   22     18 |
 A   Prisa NetFX |   25    15  |   24    14  |   23    13  |   --     -- |
 A** My Device   |   --    15  |   --    14  |   --    13  |   --     -- |
                 ---------------------------------------------------------

  * The ATI Rage is soldered onto the motherboard.
 ** My brain-dead PCI device uses INTA# but doesn't advertise it via the
    PCI_INTERRUPT_PIN register.

So after experimenting with this for a while, I think* that I can assign
the interrupt based on the PCI device the card is assigned.

Also, regarding memory address space resources, is there a routine I can
call that says "Assign this card some resource space because it hasn't
been assigned one yet"?

Thanks again,

Grant


On Tue, 7 Mar 2000, Michel Lanners wrote:
> On   7 Mar, this message from Grant Erickson echoed through cyberspace:
> > The device has an interrupt at INTA#. Unfortunately, the device being dumb
> > as it is, doesn't utilize the interrupt pin register to advertise that it
> > does in fact have an interrupt there. So, I assume that once again, the
> > PROM doesn't give it one.
>
> Of course not... how should it know? But....
>
> > Is there a way, in Linux, for me to programmatically and manually assign
> > an interrupt to this device as might have been done in the PROM? I'm
> > guessing I have to twiddle some registers in the North Bridge, correct?
>
> As far as I know, yes, it depends on the host bridge. However, I don't
> think there's any bridge configuration involved here, as the interrupt
> pin routing would rather be done in hardware.
>
> If this is in a PowerMac (at least those previous to UMA), then there
> is a fixed IRQ per physical slot. All 4 PCI interrupt lines are OR'ed
> together per slot.
>
> However, there are other IRQ routing schemes as well... the above being
> the easiest one, because the IRQ value can be hardcoded based on the
> slot, which you can determine by software.
>
> Plus, there are ways to determine an unknown IRQ by letting the device
> generate an interrupt, and seing what IRQ it comes in on. You might
> find more info in 'Linux Device Drivers' by Alessandro Rubini.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
