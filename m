Message-ID: <3933FD49.3B33F5EF@embeddededge.com>
Date: Tue, 30 May 2000 13:41:29 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "Brown, David (dbrown03)" <DBrown03@harris.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Questions about 8xxrom
References: <BE1C564723B3D21191FD0000F840E39801D8154E@rfcmx2.rfc.comm.harris.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Brown, David (dbrown03)" wrote:

> .....  But 8xxrom was
> intended to work with disk in addition to flash, so I started exploring why
> ELF-loading didn't work.

There have been lots of changes since I originally wrote the code.  I
didn't have the disk loading, but I can speculate on the trouble.

If you are trying to load zImage, it simply isn't going to work.  I
am exhausted at explaining why, but one more time.......

The zImage is simple.  It is not an ELF image.  Strip the 64k header
from the image.  Load the bits at or above 0x00200000.  Jump to the
first instruction.

If you are loading from a disk, which I presume has a file system, you
know the size of the file.  Just load it.  I know originally the loader
knew it had to load at or above 0x00200000.......It also knew it was
loading a zImage, and if the ELF header was found knew what it could
believe or not and how to start a zImage.  I don't know what the code
looks like today, as I am still using the old stuff from years ago.


> c) The problem with initrd decompression was that the board descriptor data
> was copied explicitly to 0x200000 which happened to be in the middle of
> initrd.

It shouldn't be.  You didn't follow the instructions.....Load the zImage
at or above 0x00200000, jump to the first instruction.  FYI, 8260 is
load at or above 0x00480000.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
