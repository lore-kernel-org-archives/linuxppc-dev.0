Message-ID: <392EA227.41945656@embeddededge.com>
Date: Fri, 26 May 2000 12:11:19 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "Brown, David (dbrown03)" <DBrown03@harris.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Questions about 8xxrom
References: <BE1C564723B3D21191FD0000F840E39801D81549@rfcmx2.rfc.comm.harris.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Brown, David (dbrown03)" wrote:

>
> Now, I've gone back to try the ELF method.  My flash starts at FF800000, and
> the zImage.initrd is stored at the beginning of flash.


As I have said many times, and as recently as yesterday, the zImage
(especially with initrd) was never intended to be a proper ELF image.
It is the most compressed set of bits possible to minimize storage
in a device.  The ELF header is an artifact of the tools used to create
zImage, and should simply be stripped.  The zImage is a "self extracting"
image that is loaded into ram or flash rom.  When you are loading this
from a file system or via TFTP, you know the size to load into memory.
If you are loading from some medium, like a raw flash card, you have
to make some assumptions about the size or tack a few bytes on the front
that indicate the length.  Most systems have some custom boot loader
that requires a special, very small header, or they just jump to the
start of the image in flash rom.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
