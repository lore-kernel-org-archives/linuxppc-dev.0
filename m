Message-ID: <38BF4A07.3474B5FB@redhat.com>
Date: Fri, 03 Mar 2000 00:13:43 -0500
From: Doug Ledford <dledford@redhat.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org, "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: Need reports about PCI I/O conflicts
References: <20000302152244.014464@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> Hi all !
>
> I need reports about the PCI I/O space conflicts that have been mentioned
> here. According to Apple, there is no known OF bug.
>
> Please include your machine model, the dump of /proc/pci, and eventually
> the result of lsprop on the offending card /proc/device-tree entries.
>
> Note about the Adaptec problem reported earlier, this is apparently not
> an OF bug, but a combination of an OF "feature" along with a bug in
> Michel patches.
>
> What I think happens is that the firmware (and I suspect this is done by
> the Adaptec OF code on the card, not by OF itself) will "disable" the IO
> accesses and decides that the card should use only memory-mapped
> registers on PPC. It does this by writing 0 in the io space register, but
> doesn't disable IO accesses to the card in the PCI config header (or
> maybe they get re-enabled by the kernel fixup code). Also, I still have
> to check if the bit 0 is actually 0 or 1.
>
> However, Michel code doesn't see this and do it's fixup, causing a
> remapping of the io space to fe000000 instead of leaving 0, which may let
> some driver think the address was actually assigned. This is a problem
> since in theory, io 0 is perfectly valid, isn't it ? In this case, it
> should be considered wrong.
>
> Anyway, I don't see at first why the driver would not work since both
> cards have a valid memory base and the driver should be compiled with
> MMIO enabled on PPC, and so should not use the IO address anyway.

The driver wants to see a valid IO region in the config registers or else it
interprets the card as disabled.  It also wants to see a unique value on each
card or else it interprets everything but the first instance as duplicates of
the first and ignores them (certain PCI busses have resulted in devices being
in the list multiple times, and certain BIOSes use setting the IO space to 0
to signal a card that is disabled in the BIOS).  The driver already knows that
on PPC it needs to use MMAP I/O registers, so there isn't any hints needed
from the OF, and those hints only complicate matters further when trying to
keep the driver uniform across multiple architectures.  If this is going to be
an ongoing problem, then I can make changes to the driver, it just means
having a few more #ifdef(__powerpc__) type stuff (ick).



--

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
