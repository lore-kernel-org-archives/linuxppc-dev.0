Message-ID: <3AB8A7B0.3179CF4C@enst.fr>
Date: Wed, 21 Mar 2001 14:08:00 +0100
From: Stefan Nunninger <stefan.nunninger@enst.fr>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: strange problem while booting
References: <3AB7E349.8AC5A1B0@enst.fr> <3AB7FFF6.EB575041@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Dan,

Dan Malek wrote:
> >  loaded at:     00100000 00100000
>
> You have to load the bits into memory at or above 0x200000...NO, don't
> change anything in the Makefile, just load the resulting bits like
> this.  The zImage decompressor has to relocate itself to 0x100000.
> There
> isn't any bss space allocated between the end of the data and the start
> of the zImage/initrd in the downloaded image.  Your decompressor code is
> likely writing over the images.

The original value in the /mbxboot/Makefile from montavista was
0x180000. I changed this to 0x100000 because a older version we were
working on used this value. Anyway changing the value to 0x200000 or
0x300000 as well as 0x180000 did not change anything in the
described behaviour of linux.

This is what I got to see for a value of 0x200000:

--------------------------------------------------------
 decomp : ZIMAGE_OFFSET: 0001C1F0
INITRD_OFFSET: 00077DE7
INITRD_SIZE: 0014D729
 loaded at:     00200000 00202A40
 board data at: 002001E4 00200210
 relocated to:  001F0100 001F012C
ZIMAGE_OFFSET: 0001C1F0
zimage_start : 0020C1F0
zimage_size : 00032B98
 initrd_start : 00267DE7
 initrd_end   : 003B5510
 zimage at:     0020C1F0 0023ED88
 initrd at:     00267DE7 003B5510
 avail ram:     003B6000 01000000
Linux/PPC load:
Uncompressing Linux...
Gunzip ...
 Dest address   : 00000000
 Dest length    : 00100000
 Source address : 0020C1F0
Now booting the kernel
... nothing more

Also I can't really believe that the kernel or the bootloader is
overwritten. If that were the case I would expect that nothing works
at all. But as I said at least on one debugging system the kernel
always reaches the point where it tries to load the ramdisk.

It might well be that the ramdisk is overwritten though. This could
explain why it can not be loaded. Still I can not find a reason for
the kernel to stop or to print such strange characters on the serial
line.

Do you (or anyone else) have some other suggestion what I could do?

Thank you
	Stefan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
