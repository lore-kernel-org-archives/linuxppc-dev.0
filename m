Date: Wed, 2 Feb 2000 22:31:50 +0100 (MET)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: BenH <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Getting G3 Powerbook to sleep
In-Reply-To: <20000202220232.017890@192.168.1.10>
Message-ID: <Pine.SOL.3.95.1000202220809.14750A-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,
I sent this over to the development list...
On Wed, 2 Feb 2000, BenH wrote:

bh40> On Wed, Feb 2, 2000, Derek Homeier
bh40> <supas100@saturn.astrophysik.uni-kiel.de> wrote:
bh40>
bh40> >Feb  1 09:53:40 miranda kernel: media bay 0 contains a CD-ROM drive
bh40> >Feb  1 09:53:40 miranda kernel: hda: Enabling MultiWord DMA 2
bh40> >Feb  1 09:53:40 miranda kernel: hdc: Enabling MultiWord DMA 2
bh40> >Feb  1 09:53:40 miranda kernel: ADB keyboard at 2, handler 1
bh40> >Feb  1 09:53:40 miranda kernel: ADB mouse at 3, handler set to 4 (trackpad)
bh40> >Feb  1 09:53:40 miranda kernel: hda: Enabling MultiWord DMA 2
bh40> >Feb  1 09:53:40 miranda kernel: hda: timeout waiting for DMA
bh40> >Feb  1 09:53:40 miranda kernel: hda: irq timeout: status=0x00 { }
bh40> >Feb  1 09:53:40 miranda kernel: hda: status error: status=0x58 { DriveReady
bh40> >SeekComplete DataRequest }
bh40> >Feb  1 09:53:40 miranda kernel: hda: drive not ready for command
bh40> >Feb  1 09:53:40 miranda kernel: ide0: reset: success
bh40> >Feb  1 09:53:40 miranda kernel: hdc: Enabling MultiWord DMA 2
bh40> >Feb  1 10:09:20 miranda syslogd 1.3-3: restart.
bh40> >...
bh40>
bh40> That's interesting. I've not seen those happenings yet. It looks like the
bh40> kernel tries to set MDMA on the disk twice. Does it hang or does it work
bh40> after that ?
bh40>
In the above case, I did a hard reboot at about 10:05. Similar things did happen
after the disk came back from auto-standby. I think, on some occasions it also
came back a while after the timeouts were reported, probably with less heavy
disk access, but I'd have to look up the logs for that.

bh40> I may have to bump up a bit the various timers used when waking up from sleep.
bh40>
bh40> >I also get error messages for the cdrom with about every kernel since 2.2.14,
bh40> >at least.
bh40> >
bh40> >Feb  1 10:09:28 miranda kernel: hda: Enabling MultiWord DMA 2
bh40> >Feb  1 10:09:28 miranda kernel: hdc: packet command error: status=0x51 {
bh40> >DriveReady SeekComplete Error }
bh40> >Feb  1 10:09:29 miranda kernel: hdc: packet command error: error=0x54
bh40> >Feb  1 10:09:29 miranda kernel: ATAPI device hdc:
bh40> >Feb  1 10:09:29 miranda kernel:   Error: Illegal request -- (Sense key=0x05)
bh40> >Feb  1 10:09:28 miranda pmud: pmud startup succeeded
bh40> >Feb  1 10:09:29 miranda kernel:   Invalid field in command packet --
bh40> (asc=0x24,
bh40> >ascq=0x00)
bh40> >Feb  1 10:09:29 miranda kernel:   The failed "Start Stop Unit" packet command
bh40> >was:
bh40> >Feb  1 10:09:29 miranda kernel:   "1b 00 00 00 03 00 00 00 00 00 00 00 "
bh40> >Feb  1 10:09:29 miranda kernel: cdrom: open failed.
bh40>
bh40> I beleive thosse are harmless. Do you have a CD in the drive when that
bh40> happens ?
bh40>
bh40> >Note: I _can_ read the cdrom, though. But I suspect these kind of dma errors
bh40> >cause the kernel to panick under heavy disk access.
bh40>
bh40> Do those CDROM messages appear on wakeup from sleep ?
bh40>
They consistently appear at boot, without a CD in the drive. They may occur on
wakeup when there _is_ a CD in the drive (and mounted) during sleep, I think.
I'll check the log files.

CDROM performance also is still a bit, hmm, inconsistent. Sometimes I had it
at 1.8 MByte/sec after one boot, and only 0.8 MByte/sec after the next
reboot with the same kernel, but the tendency seems to go towards the
higher performance.

HTH,
								Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
