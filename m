From: Paul Mackerras <paulus@linuxcare.com>
To: linuxppc-dev@lists.linuxppc.org,
        "Marcus H. Mendenhall" <marcus.h.mendenhall@vanderbilt.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard Media Bay
Date: Wed, 23 Feb 2000 09:48:03 +1100
Content-Type: text/plain
References: <v04210100b4d850bf623c@[129.59.235.41]>
MIME-Version: 1.0
Message-Id: <00022309583800.20436@argo.linuxcare.com.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 23 Feb 2000, Marcus H. Mendenhall wrote:

> If I boot with my zip drive (VST Zip) in the bay, I can read and
> write from this drive.  If I then eject the Zip, insert a CD-ROM
> drive, eject it, and re-insert the CD-ROM, I can only access the

(do you mean "re-insert the Zip"?)

> drive as read-only.  Also, if I boot with the CD-ROM in, the Zi is
> then read-only when inserted.

Hmmm... interesting.  I've never tried with a zip drive, I don't have one.

> I have looked through a couple of spots in the kernel already, to wit:
> drivers/macintosh/mediabay.c
> drivers/block/ide-floppy.c (since the zip seems to be handled as a floppy)

An ATAPI floppy, yes, I would think.

> and I cannot see where the decision is made as to whether a floppy
> shows up as write-protected or not.  There is only one reference to
> the wp flag, and at first glance, this wasn't even accessed.  I
> supposed I could try to hack the flag to always-writable anytime a
> zip is put in,  but this might then mishandle read-only zips (which I
> have never checked if they work anyway).
>
> Does anyone out there have enough intimate familiarity with the
> drivers to know exactly where to poke?  (Paul M., are you listening?)

I'm not particularly familiar with the IDE driver code myself.  I would
need to trace through it to find out where things are going wrong.  A good
starting place would be to strace the mount command to see first of all
which system call is failing when you try to access it read-write.

> A related question is whether the DMA capability should get turned on
> for the zip.  Does it have the same capabilities as a regular IDE
> drive, or is it really a lot more like a floppy in its interface?

Potentially it could do DMA.  You can find out with `hdparm -i /dev/hda'.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
