Message-ID: <EFB813091B18D511BD3600508B644F820A617EF3@tx14exm06.ftw.mot.com>
From: Zajac Adam-AAZ004 <Adam.Zajac@motorola.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Summary: Question on the fs choice (long)
Date: Wed, 19 May 2004 17:59:18 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thank y'all for providing a valuable input into the discussion on working
with the CF cards in embedded environment and selecting an appropriate FS.

To wrap things up I'd like to address some of the concerns that you were
expressing most frequently.

1. CF card may end up at a random state upon power failure (data gets lost
in a random manner).
	The solution we're gonna pursue is based on SanDisk recommendation
to provide some power back-up for a 100ms period after the main power goes
down. We decided to introduce some modification to that method and supply
the power to the CF card ONLY with some extra capacitors.
Statistically speaking, the card is most vulnerable to the power failure
when the internal controller performs its write cycles to the memory array
(it's only presented to the external interface as cyl/head/sect layout).
When we go over the actual compact flash access protocol (ATA mode) it takes
at least 3 (16-bit mode) to 7 (8-bit mode) writes to the controller
registers before  you can start pumping the data to the CF data register to
let the internal controller populate the card's sector (it's always one
sector at a time). So, even if this protocol is broken by some power failure
the card's controller should have enough time to finish its internal
operation (100ms) and remain in a sane condition. The only data that would
be lost is the sector that was being written to. Since, we don't provide the
back-up power to the CPU, any interference from that side is eliminated.
Besides, under sunny day operation the longest delay that's required for the
ATA-based access protocol is 450ns after accessing a command register (again
100ms provides a good safety margin).

2. Modern compact flash cards (e.g. SDCFB-xx-201 series) can be safely used
as a main storage medium for commercial applications.
	Wolfgang advised me to be careful with making such statements and I
have to agree with him. I need to re-phrase that sentence and I'm gonna say
that "SOME of the modern compact flash cards  can be used as a main storage
medium for commercial applications, BUT they need to be very CAREFULLY
selected".
I think it's a very deceitful advertising that some commercial platforms
(digital cameras, pocket PC's etc.) work with all CF cards. Yes, for most of
the time any card will do its job of storing data just fine. But there's
this one power failure or glitch that separates good from bad and ugly
(someone responded to my email that digital cameras want you to reformat the
card).
To me selecting the right components is the main principle of designing a
reliable embedded platform. If we want to provide some level of reliability
we just can't physically support all types of cards manufactured worldwide.
Like I said, the user can use any CF card that fits the socket, but it's
always at her/his own risk (of potentially loosing data).
This is similar to building your home PC. The users who want it to be a
solid rock machine, usually resort to better components or well-known
brands, although any no-name PS, motherboard and HD theoretically should
work with one another.

3. FS selection and root file system setup
I appreciated the comments from Gerald and David regarding the FS operation
details.
We're using the CF to store some large images and for most of the time I can
have the card mounted as read-only. However, we need to have a capability of
upgrading these images occasionally.
I think I may pursue the setup similar to the one described by Stephen
Mattin and have my CF mounted as read-only for most of the time and re-mount
it to read-write only when the software upgrades are needed. We also have a
16MB bulk flash on the card that I may use for these root file system
directories that would require persistent changes (using JFFS2).
Right now I'm running ext2 and we still haven't decided if we should switch
to ext3. David pointed out that multiple writes of the journal may shorten
the lifetime of the card. It's a very legitimate argument that I can't
ignore. I also find an idea of setting RAID-3, RAID-5 very interesting but
just don't know how I could practically implement it and if it would be
beneficial to the system setup.

Thank you again for all your responses.
Best regards,

Adam Zajac


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
