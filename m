Date: Tue, 26 Sep 2000 20:35:23 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: R Shapiro <rshapiro@bbn.com>,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 with rage II/rage pro -- multi-headed display!
In-Reply-To: <Pine.LNX.4.10.10009261825540.373-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.10.10009262028450.20839-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > Are there known X-related problems using BootX?
> >
> > You were looking at it, from what I guess. Apple's drivers set up
> > overlapping areas for MMIO and VRAM, and X fixes this by disabling one of
> > these. Unfortunatly, the kernel doesn't notice.
>
> Fortunately these PCI assignment bugs should be circumvented by the new PCI
> code we're working on.

... in 2.4.x, I believe. Problem is, most people aren't crazy enough to
use 2.4.0 (-test8 in particular).

All you can do in 2.2 is the 'pick and pray' approach: pick an alternate
address for MMIO bases on some heuristics or wild guesses, and pray you
don't trample on other card's resources. Works for me, but I warn anyone
to be careful with that method.

I've posted such a patch to debian-powerpc when one user there had this
problem. That was before I learned booting with yaboot avoids the problem.
If the resource conflict also happens on oldworld machines, I'd still
prefer some suggestions to foolproof the patch (as in: how can I figure
out if a region has been allocated by another card? What bits from the
config registers should I look at?).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
