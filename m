Message-ID: <39809D53.76BEBBB@execpc.com>
Date: Thu, 27 Jul 2000 15:36:35 -0500
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: powerbook hang from post-sleep cdrom access - fix
References: <Pine.LNX.4.10.10007272146140.2350-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:
> > My expirience is that just reading the drive causes a problem, much like
> > userspace trying to read it.  there is also the door locking feature that I
> > suppose could be done explicitly on wakeup if mounted.  I dont know what else a
> > "media change" ctl entails, but it seems to do enough to get the cdrom back to
> > where it left off.
>
> OK, that seems to mean wherever we can safely send the drive a reset
> command after sleep, we should do that. Now under what conditions will a
> reset command mess up things beyond recovery? Is it possible to sleep the
> machine while the IDE drive has a request under service?

ide-pmac resets all non-mediabay (non-CD?) ide drives on wake.
(idepmac_wake_disk)

looking at the mediabay code, the media bay (at least when containing a CD)
seems to be reset.  (set_media_bay is called, feature_set(reset) is called on
the bay, messages confirms call to set_media_bay with a "kernel: media bay 0
contains a CD-ROM drive" on wake).  are IDE-floppies handled by the mediabay's
CD code as well?

By mutual exclusion, it would appear we already reset ide devices upon wake.
the media change call may be what we need to get the removable media to re-init
their status.  I did get the following VFS message, which may cause concern.

Jul 27 12:00:01 momiji pmud[330]: system awake again
Jul 27 12:00:01 momiji pmud[330]: running /etc/power/pwrctl wakeup ac
Jul 27 12:00:01 momiji pwrctl: calling /etc/power/pwrctl-local wakeup ac
Jul 27 12:00:01 momiji kernel: VFS: busy inodes on changed media.

PMUD does a sync right before signalling to sleep, so most activity is reduced.
I think the rest tends to be handled by the kernel's sleep with interrupts
disabled, etc.

I noticed in browsing the kernel code, there is a file operation called
revalidate, which takes the same params as check_media_change.  cdrom.c does not
define this.  Would this be a route worth pursuing over the media change
solution?

--
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

An error occurred while booting.  Please try again.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
