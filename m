Date: Wed, 8 Mar 2000 07:15:54 -0700
From: Matt Porter <mmporter@home.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Michel Lanners <mlan@cpu.lu>, grant@borg.umn.edu,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Grabbing an Interrupt for a Brain-dead PCI Device
Message-ID: <20000308071553.A5939@home.com>
References: <200003072200.XAA00434@piglet.grunz.lu> <Pine.GSO.4.10.10003080927450.1992-100000@dandelion.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.10.10003080927450.1992-100000@dandelion.sonytel.be>; from Geert.Uytterhoeven@sonycom.com on Wed, Mar 08, 2000 at 09:31:42AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 08, 2000 at 09:31:42AM +0100, Geert Uytterhoeven wrote:
>
> On Tue, 7 Mar 2000, Michel Lanners wrote:
> > If this is in a PowerMac (at least those previous to UMA), then there
> > is a fixed IRQ per physical slot. All 4 PCI interrupt lines are OR'ed
> > together per slot.
> >
> > However, there are other IRQ routing schemes as well... the above being
> > the easiest one, because the IRQ value can be hardcoded based on the
> > slot, which you can determine by software.
>
> The most popular routing scheme looks like this:
>
>     #INTA(slot_nr) -> pci_int(slot_nr % 4)
>     #INTB(slot_nr) -> pci_int((slot_nr+1) % 4)
>     #INTC(slot_nr) -> pci_int((slot_nr+2) % 4)
>     #INTD(slot_nr) -> pci_int((slot_nr+3) % 4)
>
> where
>
>     pci_int(0) = #INTW
>     pci_int(1) = #INTX
>     pci_int(2) = #INTY
>     pci_int(3) = #INTZ
>
> Hence if all boards use one interrupt (the first interrupt on a board _must_ be
> #INTA), they're evenly spread across the available interrupt sources.

This is documented in the PCI spec as the suggested method of routing irqs.
We usually call it the standard PCI swizzle, since the interrupts
tumble as they pass through each bridge.  I added this algorithm into
prep_pci.c for MCG boards recently since it is pretty crucial for CPCI
systems that are loaded up with bridges.  There are also plenty of regular
PCI boards that have a P2P and multiple single function devices on board
that also require this routing (old dual Ethernet cards come to mind,
slapping two 21x4x chips and a transparent bridge onboard).

--
Matt Porter
mmporter@home.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
