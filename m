Message-Id: <v04003a00b2c3f68d12ab@[205.161.35.44]>
In-Reply-To: <13981.45420.95483.559227@lassi.cygnus.co.uk>
References: 
 <Pine.LNX.3.96.990113130000.3632F-100000@persephone.cs.nmt.edu>
 <13980.23937.676502.388522@lassi.cygnus.co.uk>
 <Pine.LNX.3.96.990113130000.3632F-100000@persephone.cs.nmt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 14 Jan 1999 14:46:20 -0500
To: Jesper Skov <jskov@cygnus.co.uk>
From: Douglas Godfrey <dvdoug@tiac.net>
Subject: Re: Synchronization [was Re: The Magic Show: kernel_map()
 disappearing]
Cc: linuxppc-dev@lists.linuxppc.org, Jes Sorensen <Jes.Sorensen@cern.ch>,
        alan@cymru.net, Linux/APUS mailing list <linux-apus@sunsite.auc.dk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


If you define a structure with an independant spinlock for each driver
and change the iobarrier() macro to iobarrier(lock) and iobarrier(unlock)
you can get correct MP behavior without slowing down UP systems. The MP
version of iobarrier() would do a eieio instruction and then acquire/release
the spinlock and while the UP version would just do a eieio. MP systems will
incurr the overhead of locating and locking/unlocking the spinlock. UP
systems will have no overhead beond the eieio. The lock/unlock parameter
would be ignored for UP systems and required for MP systems.

For both Nubus and PCI PPC systems the requirement is just that only 1
driver at a time and access a device and that load/stores be done in
strict program order.

For Example:
While the SCSI driver is setting up a read I/O, it is perfectly OK for a
serial driver to be writing to a serial port on another CPU. The PCI accesses
for the 2 drivers can be interleaved in any order as long as each driver's
accesses are in proper sequence.


At 3:57 AM -0500 1/14/99, Jesper Skov wrote: [Synchronization [was Re: The
Magic Show: kernel_map()]
>>>>>> "Cort" == Cort Dougan <cort@persephone.cs.nmt.edu> writes:
>
>Cort> You're right, that was an oversight on my part.  I'll fix the
>Cort> mistake.  I'll commit that to vger now.  I'm going to leave the
>Cort> sync in there as well, to make sure that things stall until the
>Cort> writes are done.
>
>Cort> }The reordering thing can also be achieved with 'sync', but it
>Cort> stalls }the CPU until all IO has completed. 'eieio' is the
>Cort> correct solution }(IMHO.. And Motos NSHO btw)
>
>
>OK, core of the problem is that I don't know what mb() is supposed to
>do. Here's what we have on the PPC:
>
> sync : stall CPU until all IO has completed.
> eieio: prevent CPU from reordering/collapsing reads/writes to memory.
>        (but otherwise run at full steam!)
>
>We would want to use eieio for drivers and such accessing their
>controller in a strict serialized manner. We would want to use sync
>for SMP related stuff since it ensures, well, synchronization between
>multiple CPUs wrt memory access.
>
>Using sync for drivers is a bad idea; it's overkill, stalling the
>CPU for no good reason.
>
>That's why I added the iobarrier() macros (adding _w/_r/_rw on Alan's
>request) that are only related to IO synchronization within the same
>CPU. Essentially it's just renaming the eieio() macro already used in
>many PPC drivers because it's a bad name; Linux/APUS will be sharing
>drivers with Linux/m68k where eieio isn't such a helpful name.
>
>Given that mb() was defined as sync, I assumed mb() to be the common
>Linux name for a thingie used for SMP synchronization.
>
>I may have been wrong. iobarrier() may not be such a good name after
>all, but I think it's important for the names to reflect the semantics
>of the function. And there are two separate synchronization semantics
>required (at least on the PPC) - I don't want to merge them just
>because there's already a common Linux function that's named mb()
>(memory barrier, presumably).
>
>Don't know what the functions/macros should be named, but it would be
>nice if:
>
> a) the names reflected semantics: CPU internal IO synchronization vs
>    inter-CPU synchronization.
>
> b) the names were common on all Linux
>    archs, defined as do {} while(0) when not applicable.
>
>
>For bigger brains to discuss further. I rest my case :)
>
>Jesper


Thanx...
  Doug



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
