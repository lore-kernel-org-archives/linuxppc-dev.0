Date: Thu, 6 Jul 2000 19:55:44 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Michael Lundkvist <ml@epact.se>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Going from 2.2.12 to 2.2.17pre10
In-Reply-To: <qp66qji2pq.fsf@erbium.epact.se>
Message-ID: <Pine.HPX.4.10.10007061943050.21326-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Hi,

> > What's your version of fdisk ?
>
> It seems like Hollis Blanchard was right so I'm doing a reinstall with
> 2.2.16 instead.

Ok, never had any problems with SCSI since DMA always gets the byte order
right ;-)

> > Under 2.2.12 dd if=/dev/hda of=xxx bs=512 count=1 and see what comes out.
> > Can PPCBUG actually boot from these disks ?
> >
>
> Nope. I think I'll go for Bugboot. Ramix also talked about the
> possibility of modifying PPCBug to add support for the Ramix 233.

Where is and what is Bugboot ?

> > > fsmlabs Bitkeeper repository?
> >
> > I have 2.4.0-test2 running on an MVME2600, look at:
> >
> > 	ftp://vlab1.iram.es/pub/linux-2.4
> >
> > did not try the MVME2400 yet (they are all in use for real tasks, I'm
> > waiting for more and have to develop on the 16Mb MVME2600 :-(). But I
> > only have SCSI disks or NFSRoot.
> >
>
> OK. I'll try that on a MVME2400.
>
> We have ~25 MVME2400 just lying around here since they haven't been
> able to get VxWorks working properly on them yet. :)
>
> > I have a 2.2.16 kernel compiled but never booted, I could give you R/O
> > access to my BK trees if you want (but the machine on which they are is
> > not up 100% of the time).
> >
> > 	Gabriel.
>
> How much difference is there between that and the main kernel?

Quite a lot. A complete bootloader, drivers for VME and many small patches
in the arch/ppc/kernel subtree. A diffstat of both patches gives:

 73 files changed, 19880 insertions, 478 deletions

> The main reason I'm moving from the 2.2.12 is that it wasn't stable
> under load on the MVME2400. I figured it was pointless to try to debug
> it on an old kernel.

I had to shut down an MVME2600 after 6 months of uptime with this kernel
for hardware upgrade. It is used as a server for all the nfsroot machines
and to compile all the software for these (and sometimes heavily swapping:
3 compiles in parallel in 32 Mb or RAM are noticeable). The MVME2400 have
never been under serious load, so I don't know if they have specific
problems but the kernel is essentially the same (less drivers and
filesystems).

I have not heavily stress-tested 2.4.0-test2 (well recompiling kernels and
performing bitkeeper patch imports is kind of stress testing I/O,
especially with 16Mb), I had some filesystem problems in 2.3.50 but they
have vanished it seems.

	Gabriel.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
