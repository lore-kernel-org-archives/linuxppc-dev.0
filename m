Message-ID: <392D7B80.73E54AFF@embeddededge.com>
Date: Thu, 25 May 2000 15:14:08 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "Mark S. Mathews" <mark@absoval.com>
CC: SangTae Ha <stha@postech.edu>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: How to load kernel on RPX Lite Board ?
References: <Pine.LNX.3.96.1000525100001.30564B-100000@tristar.cc.absoval.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Mark S. Mathews" wrote:

> I believe (but not sure) that zsrec discards the ELF header and uses it's
> own image location assumptions.  It's magic....and just works.  ;-)
> The zsrec source isn't too tough to look at if you really need to know.

It's not magic, I was just too lazy to find all of the objcopy
parameters that would do the same thing :-).  The "magic" (which has
been recently broken for some targets in 2.3.99) is in the zImage.

The zImage is a 64K ELF header (which should be discarded) followed by
a simple relocate/uncompress set of functions with a compressed kernel
and optional compressed ram disk packed against these functions.  There
are some assumptions built into these functions, and externally you should
not try to map any structure to this file.  Strip the 64K header and
you just have a linear array of bits that can be safely loaded anywhere
at or above a 2 Mbyte address (5 Mbyte for 8260).  Jump to the first
location and it will go.  Other processor architectures follow this
model as well.

A very important note.....Because of the initrd logic in the Linux
kernel, you can't uncompress a ram disk from Flash rom, it must be
in RAM (pages are discarded when this is done).  The "magic" functions
assume if loaded above 16 Mbytes, and a ram disk is attached, the
ram disk portion of the image must be copied to ram.  If loading in
ram above 16 Mbytes this will result in an unnecessary copying of
the ram disk image, so it is probably best to load the image somewhere
below 16 Mbytes if in memory.  There are lots of other assumptions
and "special" memory locations used within these functions to support
a variety of loading options on various boards and products.  It is
best you realize this is a bunch of bits for production use and don't
try to modify it for something else.  Lots of people depend on this
image as it is.


All zsrec does is skip the ELF header, then convert the remaining
bits to S-records with a base address you can specify.  The default
base is 2M bytes because it was written for small memory 8xx systems.
Specifiy a different address with the -s start option, followed by
a hex base address.  This is required for the 8260 zImage.  Or better,
write your own program that can download/flash the binary without an
S-record conversion.

There are other programs (which I don't have but know other people do :-)
that will convert this zImage into binary formats supported by BDM/JTAG
download tools.  Basically, just strip the ELF header and tack a
simple binary header to the top.  Everyone (until recently) seemed
to like this approach because it was quick and easy, and there aren't
any symbols or other debug information that make this a useful ELF
image.  It is also the most compact Flash ROM image that reduces the
requirements on that resource.

> 1) Copy your kernel image to RAM using RPXU tftp
> 2) Use the RPXU flash program command to copy from RAM to flash
> 3) Use the RPXU to jump to your flash load address

The file arch/ppc/mbxboot/misc.c contains an "RPX Signature" for
autoboot.  There is an address you can modify that reflects the
actual load location in Flash rom.  I chose to use FF840000 as that
is the first of the 256K sectors on a 8M Flash board.  The smaller
sectors preceeding this location are used for the new RPX bootloader
or by existing products for non-volatile storage.

I believe all of this information (and more) is provided from Embedded
Planet and MontaVista as part of the Linux Planet development kit.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
