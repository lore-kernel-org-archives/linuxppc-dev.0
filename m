Date: Thu, 9 Mar 2000 18:46:43 +0100 (MET)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.15pre11 on PB Lombard
In-Reply-To: <20000308105356.021134@mailhost.mipsys.com>
Message-ID: <Pine.SOL.3.95.1000309182200.26688A-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 8 Mar 2000, Benjamin Herrenschmidt wrote:

> On Tue, Mar 7, 2000, Derek Homeier <supas100@astrophysik.uni-kiel.de> wrote:
>
> >... some 2^4 adresses or so follow, which I could write down if anyone
> >will find them useful. I can't get anything beyond that, because xmon
> >prints everything else black on black!
> >
> >This happens both with CONFIG_MAC_FLOPPY set or unset (the above is without
> >floppy driver)
>
> Check that you didn't include inadvertently the legacy PC floppy driver
>
Oh right, CONFIG_BLK_DEV_FD dunnit! I wonder how I came to include it, since
I usually start with pmac_defconfig and from that only remove stuff I don't
need, except for few things like the USB drivers. It boots, however, and
I even got the SUN12x22 font to work now, thank you!
What's still causing problems is the DMA code, however. There's still the

: hda: Enabling MultiWord DMA 2
: hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
: hdc: packet command error: error=0x54
: ATAPI device hdc:
:   Error: Illegal request -- (Sense key=0x05)
:   Invalid field in command packet -- (asc=0x24, ascq=0x00)
:   The failed "Start Stop Unit" packet command was:
:   "1b 00 00 00 03 00 00 00 00 00 00 00 "
: cdrom: open failed.

error on startup. I can't see if this is directly causing any problems, but
the performance for hdc is frequently down to 0.8 MB/s. Apparently ejecting
and reloading the disk is sufficient to bring it back to 1.6 MB/s, but after
returning from sleep it's down again (this is the 24X CD-ROM on a 333 MHz
PB 101, FYI). Well, at least I found an easy workaround now...

I also noticed that power consumption during sleep had dramatically increased
with the previous 2.2.15pre kernels; I'm currently checking out if that problem
persists.

Thanks again,
							Derek

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
