Date: Wed, 20 Mar 02 18:13:19 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0203210213.AA15856@ivan.Harhan.ORG>
To: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek <dan@embeddededge.com> wrote:

> The only reason _any_ Ethernet
> information had been passed between the bootloader and the kernel
> was for the processors with internal peripherals and a variety of
> methods that were used for retrieving the MAC address.

Yes, and this is how it should be.

Now not just for Ethernet, but for any peripherals built into the CPU, the
system controller, or the board custom logic we need bi_recs to tell the kernel
how it's wired. Like if some random peripheral chip (not PCI or somesuch, but
"system" type that we have to have hard knowledge of) has a pin that can be
tied high or low that affects its operation and the Linux driver needs to know
how it's tied, we need to have the board firmware pass this magic info via
bi_recs (now it's done either with a board #ifdef maze or .config options). I
don't think there should be .config options for things that are fixed hard in
PCB traces or in silicon, and board #ifdefs are ugly. bi_recs are the answer.
That's why I included is_rmii and phy_addr in BI_GT64260_ETH_CFG.

> There are
> already Linux methods for configuring network interfaces, we don't
> need to add another one.

Exactly. Things like 10 vs. 100 Mbps shouldn't be in bi_recs because they are
up to the user to decide and Linux already provides standard mechanisms for
them. bi_recs should be used only for stuff that's completely involuntary,
i.e., to describe how the board is wired. This way they can be completely
hidden from the user who can't override a PCB trace in software anyway.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
