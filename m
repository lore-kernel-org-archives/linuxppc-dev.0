MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Subject: RE: Question on the fs choice
Date: Thu, 13 May 2004 06:54:55 -0600
Message-ID: <065ACD8E84315E4394C835E398C8D5EB09223A@cossmgmbx02.email.corp.tld>
From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> From: Zajac Adam-AAZ004 [mailto:Adam.Zajac@motorola.com]
> Sent: Wednesday, May 12, 2004 9:00 PM
> To: VanBaren, Gerald (AGRE); linuxppc-embedded@lists.linuxppc.org;
> 'wd@denx.de'
> Subject: RE: Question on the fs choice
>
>
> Gerald, Wolfgang,

[snip]

>
> I've contacted SanDisk regarding their warranty of surviving a power
> shortage in the middle of a write-cycle and received a
> document explaining
> the expected behavior.
> Here's an introductory quote:

[snip]

> These particular SanDisk cards are equipped with an enhanced
> version of the
> internal controller that is capable of surviving such
> scenario leaving the
> card in a robust state.
> At worst, the user loses the data that was being written to a
> particular
> sector while the power failure happened.
> Case 1: the data errors are corrected
> Case 2: the old data is restored back to the sector
> Case 3: the user loses the data on the sector
>
> One of the recommendations was to implement a 100 millisecond
> power back-up
> provided for the card to finish its internal write cycle. Of
> course, this
> can only be applied  to the systems where the user cannot
> yank the card out
> directly. For example, digital cameras have a sensor on the
> card's cover to
> signal such event.

The 100mSec power holdup (implying a power fail interrupt to the processor and associated cleanup code so it does not write to the CF when the power goes away) is very important.  The case I was referring to previously had no power fail warning (it was raw flash, not CF, but unless your CF has BIG caps built in this is immaterial).  A very low but NON-zero percentage of the time, the processor would start a write sequence and power would fail before the start address was set properly: probably between the write unlock sequence and the actual write to the device.  I speculate that the flash is then vulnerable since the write sequence was successfully completed, and the processor did some random writes that happened to hit the flash address space as its address, data, and control lines spasmed due to the power loss.  In this case the flash chip would scribble on a random sector.  Bad, really bad.

> Coming back to the CF card discussion subject, does anybody
> know how the
> "power failure" scenario is resolved at such commercial
> platforms as pocket
> pc's and digital cameras utilizing CF cards?

They all (?) use the FAT (VFAT) file system and I would speculate that they do not do any write caching (almost universal FAT file system convention).  Then they close their eyes and hope for the best ;-).  Seriously, they all warn you in the manual to NOT remove the CF while it is busy.

Incidentally, you can mount linux file systems with inhibited caching (use the "sync" option for synchronous writing -- i.e. no write caching).  A journaling file system is probably better, but putting "sync" in your /etc/fstab would be a simple and easy fix to try.

gvb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
