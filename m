Date: Thu, 27 Jul 2000 22:50:45 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Joseph Garcia <jpgarcia@execpc.com>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: powerbook hang from post-sleep cdrom access - fix
In-Reply-To: <39809D53.76BEBBB@execpc.com>
Message-ID: <Pine.LNX.4.10.10007272243590.20355-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > OK, that seems to mean wherever we can safely send the drive a reset
> > command after sleep, we should do that. Now under what conditions will a
> > reset command mess up things beyond recovery? Is it possible to sleep the
> > machine while the IDE drive has a request under service?
>
> ide-pmac resets all non-mediabay (non-CD?) ide drives on wake.
> (idepmac_wake_disk)

Fine, so that shouldn't be it.

> looking at the mediabay code, the media bay (at least when containing a CD)
> seems to be reset.  (set_media_bay is called, feature_set(reset) is called on
> the bay, messages confirms call to set_media_bay with a "kernel: media bay 0

I don't think that's the IDE device reset, just a reset for the media bay
controller (or the IDE controller) itself.

> contains a CD-ROM drive" on wake).  are IDE-floppies handled by the mediabay's
> CD code as well?

IDE-floppies in the media bay should be handled by that code.

> Jul 27 12:00:01 momiji kernel: VFS: busy inodes on changed media.

That might be a problem - the mediachange call might conflict with the VFS
still holding open channels to the device?

> PMUD does a sync right before signalling to sleep, so most activity is reduced.
> I think the rest tends to be handled by the kernel's sleep with interrupts
> disabled, etc.
>
> I noticed in browsing the kernel code, there is a file operation called
> revalidate, which takes the same params as check_media_change.  cdrom.c does not
> define this.  Would this be a route worth pursuing over the media change
> solution?

You know, I just remebered the same revalidate call. It's used for disks
when the partition table was changed, and I recall it fails when there are
other open channels to the disk as well. Moreover, check_media_change
should _check_ for media change, not behave as if the media changed (which
may be difficult to do across a sleep if the CD-ROM always reportss 'maybe
the media was changed while I was asleep'. In that case, maybe reading in
the superblock and comparing it with a cached copy should be done (that's
so obvious, it may have been implemented ten years ago :-).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
