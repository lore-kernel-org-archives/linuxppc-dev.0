MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Question on the fs choice
Date: Wed, 12 May 2004 07:13:30 -0600
Message-ID: <065ACD8E84315E4394C835E398C8D5EB092237@cossmgmbx02.email.corp.tld>
From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sorry for following up my own post, but this is a very interesting talk on EXT3 which has application to all journaling file systems...
  http://olstrans.sourceforge.net/release/OLS2000-ext3/OLS2000-ext3.html

A very interesting quote:
  Now, disks these days actually make these guarantees. If you start a write
  operation to a disk, then even if the power fails in the middle of that
  sector write, the disk has enough power available, and it can actually steal
  power from the rotational energy of the spindle; it has enough power to
  complete the write of the sector that's being written right now. In all
  cases, the disks make that guarantee. [23m, 41s]

This is Wolfgang's and my point about CF: the CF itself does not have sufficient energy storage inside it to guarantee completion of a write operation.  In addition, our local experience with flash chips is that a power fail during a write operation can scribble on RANDOM locations in the flash chip.  The intuitive assumption is that a power fail during a CF write will corrupt ONLY the sector that is the target of the write operation.  This is NOT a good assumption.

gvb

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of
> VanBaren, Gerald (AGRE)
> Sent: Wednesday, May 12, 2004 8:37 AM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: RE: Question on the fs choice
>
>
>
> Journaling file systems don't cure corruption on power fail,
> they just make the power fail recovery faster by eliminating
> the full fsck disk scan and significantly reduce the
> probability of corruption due to the transactional nature.
> The assumption with a journaling file system is that the
> power fail only corrupted the last (partial) transaction.
> With normal usage patterns this is a good assumption
> (spinning disk physics probably help, but write caches in
> disks are going to hurt).  With CF under heavy power failure
> cycles, this might not be as good an assumption.
>
> There was a slashdot item yesterday pointing to a benchmark
> of various journaling file systems.  In the discussion, one
> point that was made was that ext3 journals the data as well
> as the metadata by default where the other journaling file
> systems journal only the metadata (directory info).  I
> presume this was accurate (hey, it was on ./ which guarantees
> accuracy, right? ;-).  Whichever fs you pick, you probably
> want to journal the data as well as the metadata.
>
> A suggestion is to have multiple partitions on your CF and
> use RAID-3 or RAID-5.  The assumption here is that a power
> fail-induced physical corruption would corrupt only one of
> the partitions which could then be rebuilt due to the RAID
> redundancy.  The journaled file system would then eliminate
> the fsck on start up and make the file system itself
> consistant and the RAID redundancy would (presumably) fix any
> low level errors that the unexpected power fail could induce.
>
> ...or maybe a journaling file system is good enough.
>
> gvb
>
>
> > -----Original Message-----
> > From: owner-linuxppc-embedded@lists.linuxppc.org
> > [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On
> Behalf Of Zajac
> > Adam-AAZ004
> > Sent: Tuesday, May 11, 2004 7:20 PM
> > To: 'linuxppc-embedded@lists.linuxppc.org'
> > Subject: Question on the fs choice
> >
> >
> >
> > Hello,
> >
> > We've built a custom board based on MPC8540 that runs Linux
> > OS and utilizes
> > compact flash card to store the kernel on a raw-data
> > partition (read-only)
> > and root file system on an Ext2 partition (read-write). As
> > Ext2 is not a
> > journaling FS, in case of any power failure the file system
> > is not cleanly
> > unmounted and the fscheck complains upon a system start-up.
> > Also, sometimes the file system partition gets corrupted when
> > we power-cycle
> > the card instead of shutting the system down gracefully (the
> > card is build
> > to be "hot-swappable" so we test it on purpose).
> >
> > I saw Wolfgang Denx's post discouraging any use of the CF
> cards for an
> > embedded platform where write operations are performed under
> > power-failure
> > prone environment. Unfortunately, this is the reality we're
> > facing on our
> > card.
> >
> > I'm seeking some help with selecting the file system that
> > would survive
> > power failure if the CF card didn't get damaged during a
> > write cycle (we're
> > gonna perform a thorough testing to assess the severity of
> > that issue).
> >
> > I've seen some articles suggesting one of the journaling
> > systems, like Ext3,
> > XFS or ReiserFS.
> >
> > Has anybody successfully implemented any of these FS systems
> > on an embedded
> > platform equipped with a compact flash card working as a
> main storage
> > medium?
> >
> > Any help would be greatly appreciated.
> >
> > Adam Zajac
> > Motorola Inc, Global Telecom Solutions Sector
> > 5555 N Beach St, Mailstop 8E, Fort Worth, TX 76137-2794
> > Phone: (817) 245-7963
> >
> >
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
