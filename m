Message-ID: <B895EFF5AF34724880036BDB5B5B8148135687@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'Brian S. Park'" <brian@corelis.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: getting Linux working on IBM Walnut demo board
Date: Wed, 28 May 2003 13:59:31 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brian:

Re flash capacity, there was a thread on this some months ago.
There are those who pride themselves on having the most compact
system possible, and who will tell you 2MB is "bloated".  There
are those who prefer to use a standard C library, and who think
5 MB is OK.  So it depends on how much you want to crunch things
down ...

However, I will say that an 8MB flash device should be plenty
for compressed kernel, compressed RAM disk which contains a nice
set of libraries + applications, firmware, etc.  And you might
be able to get by with 4MB.

We use a pair of StrataFlash parts on most all of our boards
-- these are 8MB, 16 bits wide; we usually use a pair of them
(for a 32-bit bus) which gives us 16MB of flash.  And that is
more than plenty.  All my firmware (several different tools)
fit comfortably in the last 1 MB.  I generally put some extras
in my RAM disk, e.g. some largish PDF files (product briefs)
so that a board can run a web server, dishing up some marketing
literature, etc, and I am not one of the people who wants the
tiniest C library, so I am one of the more profligate users.
And my zvmlinux.initrd is generally in the 3-5MB range.  That
leaves space in our 16MB flash for 2-3 of those zvmlinux.initrd's.

-----Original Message-----
From: Brian S. Park [mailto:brian@corelis.com]
Sent: Wednesday, May 28, 2003 1:53 PM
Subject: Re: getting Linux working on IBM Walnut demo board

Thank you all for good suggestions.

It turned out that ELDK default setup does not have any dev files. How do I
create all the dev files I need?

 >[root@karla2 dev]# ls
 >initctl  log  null

Also, I have a general question about Embedded Linux. What is the
reasonable amount of flash to have for a minimally configured Embedded
Linux system?

My target will be running small (<<1MB) program which will take
commands over TCP/IP network. So, I want to know how much flash
memory we should put on our custom target. We do not need support for
PCI/Video/Sound/HD/SCSI/Parallel port/... All we need from the OS is
network support. Probably using Linux is an overkill but since it's
free. :)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
