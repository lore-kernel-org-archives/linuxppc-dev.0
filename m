Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3AD1B573.457F6DC6@enst.fr>
Date: Mon, 09 Apr 2001 15:13:23 +0200
From: Stefan Nunninger <stefan.nunninger@enst.fr>
Reply-To: nunninger@web.de
MIME-Version: 1.0
To: linuxppc-embedded List <linuxppc-embedded@lists.linuxppc.org>
Subject: Question about memorylocation of ramdisk
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello everybody,

I fear this question has been discussed before as it seems to be
crutial for getting a ramdisk to work. However while searching the
archive I did not find a proper answer. So I hope you are not too
annoyed if I ask here.

I use a ramdisk of 4MB size. This ramdisk is compressed to a size of
about 1.4MB. Now I load the objectfile containing the bootloader,
compressed kernel and ramdisk to address 0x200000 in RAM. After
starting, the bootloader uncompresses the kernel and copies it to
address 0x0. Assuming a kernel of 500kB size the uncompressed kernel
now reaches from 0 to 0x7d000. Some time later the kernel
uncompresses the ramdisk and places it right behind the kernel in
memory. Thus the
uncompressed ramdisk reaches from 0x7d000 up to 0x47d000. However
this is clearly the location where the compressed ramdisk resides
which will be overwritten before being uncompressed completely. Thus
I
get the impression something is wrong here.
I assume this problem arises because I use the RAM instead Flash. I
can not put the binary file into flash though as I have only 512kB
of Flash available currently.

Probaby I would not ask about this if I did had problems using my
ramdisk. I found that depending on the amount of used space in the
ramdisk it either works or fails. A very small ramdisk with only a
standalone shell seems to work fine. If I add some applications  to
the ramdisk the shell does not start up any more. I assume this is
due
to the problem described above.

I moved the loading address to higher addresses as for instance
0x600000. This seems to improve the situation sightly as the ramdisk
can be a bit bigger. But still if I use near to 4MB the
shell does not start up. I saw several behaviours. First and most
often I see that execve starts the init process and return without
error. However the shell as defined in the inittab file is not
started or at least I don't
see the login prompt.

Somethimes I also see this error message:
INIT: PANIC: segmentation violation! sleeping for 30 seconds

I'm using linux 2.2.14 from Montavista on a custom board with an
MPC860, 512kB Flash and 16MB Ram.

Thanks in advance for any response.
	Stefan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
