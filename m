Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <EFB813091B18D511BD3600508B644F820A617EC3@tx14exm06.ftw.mot.com>
From: Zajac Adam-AAZ004 <Adam.Zajac@motorola.com>
To: "'VanBaren, Gerald (AGRE)'" <Gerald.VanBaren@smiths-aerospace.com>,
	linuxppc-embedded@lists.linuxppc.org, "'wd@denx.de'" <wd@denx.de>
Subject: RE: Question on the fs choice
Date: Wed, 12 May 2004 20:00:01 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Gerald, Wolfgang,

Thank you for your prompt response to my post.
I had been aware of the CF card corruption problem that exists for some
cards under power failure scenario prior to posting my questions but was
seeking some advice from experts on the subject.
Since building embedded systems equipped with a compact flash card as a main
storage medium is an interesting issue per se, I think it's at least
worthwhile to exchange some experience with the users of that group.

I've contacted SanDisk regarding their warranty of surviving a power
shortage in the middle of a write-cycle and received a document explaining
the expected behavior.
Here's an introductory quote:

"If power is removed while the flash memory cells are being programmed, it
could leave
them in a partially programmed state. The partially programmed state will be
very
different from the intended final state. In that type of situation, the
write operation will
result in a corrupt sector. This condition is referred to as a write abort
situation.1 It is
critical for the flash card to consistently report write-abort situations to
the host so that
the host can take appropriate action.
Write-Abort Situations
Three situations can arise when using write abort:
− Case 1 Write abort results in a correctable ECC error.
− Case 2 Write abort results in an uncorrectable ECC error.
− Case 3 Write abort results in an undetected ECC.
In the undetected ECC case, if a large number of bits are in the wrong
state, it may result
in a situation where the ECC circuitry fails to detect the error, or it may
detect an error
and attempt to correct it but instead result in the wrong data after
correction."

We've been using two types of SanDisk cards for our systems:
SDCFB-64-201-80  - 64MB
SDCFB-512-201-00 - 512MB

These particular SanDisk cards are equipped with an enhanced version of the
internal controller that is capable of surviving such scenario leaving the
card in a robust state.
At worst, the user loses the data that was being written to a particular
sector while the power failure happened.
Case 1: the data errors are corrected
Case 2: the old data is restored back to the sector
Case 3: the user loses the data on the sector

One of the recommendations was to implement a 100 millisecond power back-up
provided for the card to finish its internal write cycle. Of course, this
can only be applied  to the systems where the user cannot yank the card out
directly. For example, digital cameras have a sensor on the card's cover to
signal such event.

To cut the long story short I personally believe (based on the number of
stress tests we perform on our target platforms) that modern compact flash
cards (e.g. SDCFB-xx-201 series) can be safely used as a main storage medium
for commercial applications.

Resolving a file system corruption upon an unexpected power failure should
just be the matter of selecting one of the journaling systems (ext3, XFS,
ReiserFS etc.). BTW, we're still evaluating which FS to choose and by far
Ext3 looks like the best candidate due to its backward compatibility with
Ext2.

Coming back to the CF card discussion subject, does anybody know how the
"power failure" scenario is resolved at such commercial platforms as pocket
pc's and digital cameras utilizing CF cards?

Regards,
Adam


-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org] On Behalf Of VanBaren,
Gerald (AGRE)
Sent: Wednesday, May 12, 2004 8:14 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Question on the fs choice



Sorry for following up my own post, but this is a very interesting talk on
EXT3 which has application to all journaling file systems...
  http://olstrans.sourceforge.net/release/OLS2000-ext3/OLS2000-ext3.html

A very interesting quote:
  Now, disks these days actually make these guarantees. If you start a write
  operation to a disk, then even if the power fails in the middle of that
  sector write, the disk has enough power available, and it can actually
steal
  power from the rotational energy of the spindle; it has enough power to
  complete the write of the sector that's being written right now. In all
  cases, the disks make that guarantee. [23m, 41s]

This is Wolfgang's and my point about CF: the CF itself does not have
sufficient energy storage inside it to guarantee completion of a write
operation.  In addition, our local experience with flash chips is that a
power fail during a write operation can scribble on RANDOM locations in the
flash chip.  The intuitive assumption is that a power fail during a CF write
will corrupt ONLY the sector that is the target of the write operation.
This is NOT a good assumption.

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
