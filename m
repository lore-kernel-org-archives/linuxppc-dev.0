Message-Id: <5.1.0.14.2.20031012203903.02e546d8@mail.ebshome.net>
Date: Sun, 12 Oct 2003 20:50:22 -0700
To: "Jacky Lam" <jackylam@astri.org>
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: Walnut PCI bridge can't be detected
Cc: <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <003e01c39136$d0125630$2803050a@JackyLam>
References: <001d01c39133$20f088a0$2803050a@JackyLam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 08:05 PM 10/12/2003, Jacky Lam wrote:
> >
> > Dear all,
> >
> >     Concerning my pervious posts about the problem on receiving interrupt
> > from PCI cards. I guess it is the problem of PCI bridge..(at least I think
> > it is related).

snip

> >     Also, under /proc/bus/pci and /proc/pci, I can't see any information
> > about the brdige.

This is normal.

Also, according to the log you posted bus enumeration was successful and
your device (es1371) was found. So I don't think you have a problem with a
bridge.

FYI, bridge is not responsible for delivering IRQs from your card. IRQ
lines from the PCI slots are directly wired to the UIC (see
walnut::ppc405_map_irq for actual mapping).

According to your log you have inserted card into the PCI slot 1, is this
correct ?

If you still suspect that you have bridge problem, just insert some other
PCI card which is know to be supported by PPC kernel and see...

Also, I don't like these messages "alloc_area_pte: page already exists". It
may be some other problem, though.

Eugene


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
