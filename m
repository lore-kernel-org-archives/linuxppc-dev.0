Date: Fri, 10 Mar 2000 13:48:10 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
cc: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        Kostas Gewrgiou <gewrgiou@imbc.gr>,
        Michel Danzer <michdaen@iiic.ethz.ch>, linuxppc-dev@lists.linuxppc.org
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work on pp
 cwith r128
In-Reply-To: <Pine.LNX.3.96.1000309082908.3748C-100000@deepspace.mklinux.org>
Message-ID: <Pine.HPX.4.10.10003101341450.22162-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 9 Mar 2000, David A. Gatwood wrote:

> > So 601's have no problems with sync and isync, just eieio?  AFAIK, there is
> > some code snippet in the kernel that somehow works around a 601 problem
> > with one of the synchronization instructions but I don't remember which one
> > right off hand.
>
> There's a bug on certain cards in x100-land that makes them crash on
> sync() and eieio().  isync() is irrelevant on a 601, since there's not a
> separate instruction cache.

What do you mean with x100 ? Is it a series of PMAC models ? sync and
eieio perform an address-only bus broadcast that should be terminated by
the host bridge but never to the PCI bus so they can't crash HW. Is the
host bridge/memory controller really that buggy ?

And isync is not irrelevant on any processor since a) it flushes the
instruction queue and b) it ensures that the effect of all previous
instructions on machine state is taken into account before the next
instruction executes (that's important if you change context by changing
segment registers or modify some MSR bits).

	Gabriel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
