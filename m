Date: Wed, 8 Mar 2000 09:31:42 +0100 (MET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Michel Lanners <mlan@cpu.lu>
cc: grant@borg.umn.edu, linuxppc-dev@lists.linuxppc.org
Subject: Re: Grabbing an Interrupt for a Brain-dead PCI Device
In-Reply-To: <200003072200.XAA00434@piglet.grunz.lu>
Message-ID: <Pine.GSO.4.10.10003080927450.1992-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 7 Mar 2000, Michel Lanners wrote:
> If this is in a PowerMac (at least those previous to UMA), then there
> is a fixed IRQ per physical slot. All 4 PCI interrupt lines are OR'ed
> together per slot.
>
> However, there are other IRQ routing schemes as well... the above being
> the easiest one, because the IRQ value can be hardcoded based on the
> slot, which you can determine by software.

The most popular routing scheme looks like this:

    #INTA(slot_nr) -> pci_int(slot_nr % 4)
    #INTB(slot_nr) -> pci_int((slot_nr+1) % 4)
    #INTC(slot_nr) -> pci_int((slot_nr+2) % 4)
    #INTD(slot_nr) -> pci_int((slot_nr+3) % 4)

where

    pci_int(0) = #INTW
    pci_int(1) = #INTX
    pci_int(2) = #INTY
    pci_int(3) = #INTZ

Hence if all boards use one interrupt (the first interrupt on a board _must_ be
#INTA), they're evenly spread across the available interrupt sources.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248638 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
