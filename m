Date: Mon, 28 Feb 2000 20:13:49 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Detlef Fliegl <fliegl@in.tum.de>
cc: Jack Howarth <howarth@bromo.med.uc.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Stability of 2.3.47 (G4)
In-Reply-To: <38BAA220.BD8D31C0@in.tum.de>
Message-ID: <Pine.HPX.4.10.10002281941520.21544-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Mon, 28 Feb 2000, Detlef Fliegl wrote:

> Yes I know - it seems to be a memory consistency problem. Roman
> Weissgaerber (the author of the OHCI driver) is already informed and he
> has access to our G4 for further testing.

I have some doubts about memory consistency with smart PCI bridges if you
don't set the global bit in the PTE. What happens if you use the SMP
definition of _PAGE_BASE in asm/pgtable.h ? Write gathering in the CPU may
simply bypass all coherency mechanisms by allocating a cache line which is
being written to without signalling it on the bus, I don't see anything in
the PCI specifications preventing a bridge from actually prefetching
memory contents and caching them.

#define _PAGE_BASE      _PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_COHERENT

I also have a strange problems on my 750 based MVME2400, the system boots
perfectly from power off, but a reboot leads to strange problems with
messages like (2.3.45):

*ap++ == 0x55
Report this to bash-maintainers@prep.ai.mit.edu

Setting clock  (utc): Sun Feb 27 16:25:52 /etc/localtime 2000
/etc/rc.d/rc.sysin
it: line 2:    68 Segmentation fault      initlog -n $0 -s "$1" -e 1

Last login: Sun Feb 27 17:24:33 on ttyS0
[: too many arguments

In other cases I had illegal instructions or ld.so bug messages, ld.so
would enter an apparently infinite loop when trying to load the init code
(system hang just after Freeing unused memory which I traced with a few
printk; it depends on your definition of infinity but not a single page
fault in one night and still responsive to interrupts). But this only
happens at the second (and following) reboots after power up.

It works perfectly on a 603e, and 2.2.12 also works on both
kinds of machines without problems. I added a zeroing of all free memory
in the bootloader and the problems have disappeared, this is the only clue
I have right now, has anybody had a similar experience ?

I suspected L2 cache coherency lost during early boot but this looks weird
since uncompressing the kernel should completely thrash the 1Mb
L2 cache (compressed + uncompressed kernel > 2Mb).

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
