Mime-Version: 1.0
Message-Id: <v04210100b4d850bf623c@[129.59.235.41]>
Date: Tue, 22 Feb 2000 08:49:15 -0600
To: linuxppc-dev@lists.linuxppc.org
From: "Marcus H. Mendenhall" <marcus.h.mendenhall@vanderbilt.edu>
Subject: Lombard Media Bay
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have been poking (in my limited spare time) at a problem I have
been having with the handling of the media bay on my PBG3 Broze (1999
Lombard... just to get in all the aliases this machine goes by :-) ).

If I boot with my zip drive (VST Zip) in the bay, I can read and
write from this drive.  If I then eject the Zip, insert a CD-ROM
drive, eject it, and re-insert the CD-ROM, I can only access the
drive as read-only.  Also, if I boot with the CD-ROM in, the Zi is
then read-only when inserted.

I have looked through a couple of spots in the kernel already, to wit:
drivers/macintosh/mediabay.c
drivers/block/ide-floppy.c (since the zip seems to be handled as a floppy)

and I cannot see where the decision is made as to whether a floppy
shows up as write-protected or not.  There is only one reference to
the wp flag, and at first glance, this wasn't even accessed.  I
supposed I could try to hack the flag to always-writable anytime a
zip is put in,  but this might then mishandle read-only zips (which I
have never checked if they work anyway).

Does anyone out there have enough intimate familiarity with the
drivers to know exactly where to poke?  (Paul M., are you listening?)

A related question is whether the DMA capability should get turned on
for the zip.  Does it have the same capabilities as a regular IDE
drive, or is it really a lot more like a floppy in its interface?


Marcus Mendenhall

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
