Date: Wed, 27 Sep 2000 20:21:32 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        R Shapiro <rshapiro@bbn.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 with rage II/rage pro -- multi-headed display!
In-Reply-To: <Pine.LNX.4.10.10009271317210.383-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.10.10009272017090.27656-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > I've posted such a patch to debian-powerpc when one user there had this
> > problem. That was before I learned booting with yaboot avoids the problem.
> > If the resource conflict also happens on oldworld machines, I'd still
> > prefer some suggestions to foolproof the patch (as in: how can I figure
> > out if a region has been allocated by another card? What bits from the
> > config registers should I look at?).
>
> You should walk all PCI devices and construct your own resource tree from
> pci_dev->base_address[i]. After that you know the conflicts and unassigned
> addresses and can look for free space. Unfortunately this is probably nearly
> as much work as backporting the 2.4.x PCI resource code (which is tested,
> unlike new code you would invent).

Yep, I'm aware of that. I'm way too lazy to backport the PCI resource code
and the problem seemed solved by using yaboot for me. I didn't
fully realize the Wallstreet doesn't have this option.

Instead of walking the whole device tree, I hope to get away with just
picking a free area (assuming pci_dev->base_address[i] == 0 means free)
instead. But I won't get to it before the weekend. If BenH implements a
cleaner way, the better.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
