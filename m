Subject: RE: Cramfs root file system
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 22 Nov 2002 09:25:09 +0200
Message-ID: <7899847F7C05BE43A0687AD18D97DA2207F286@srv_mail.azisa.co.za>
From: "Flavio Pereira" <flavio.pereira@za.flextronics.com>
To: "Dennis Khoo" <dkhoo@atmxdsl.com>,
	"LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all / Dennis

>1)   in kernel file init/main.c 's dev_name_struct,  add entry for
> "mtdblock", 0x1f00
>if it's not there already.
>
>2) in ppcboot =>setenv bootargs init=/linuxrc root=/dev/mtdblockx

I added the mtdblock entry and, yes it seems to have helped. The kernel
however now returns...

mtdblock_open
ok
mtdblock: read on "initrd" at 0x400, size 0x400
mtdblock: read on "initrd" at 0x0, size 0x1000
mtdblock: read on "initrd" at 0x1000, size 0x1000
mtdblock: read on "initrd" at 0x2000, size 0x1000
mtdblock: read on "initrd" at 0x3000, size 0x1000
wrong magic
VFS: Mounted root (jffs filesystem) readonly.

Ive looked at the kernel code, and it looks like it doesn't support a
cramfs system only jffs (ROM systems anyway). Can anyone confirm whether
Linux 2.4.4 supports cramfs for root file systems?

Thanks
Flavio Pereira


-----Original Message-----
From: Dennis Khoo [mailto:dkhoo@atmxdsl.com]
Sent: Thursday, November 21, 2002 9:18 PM
To: Flavio Pereira; LinuxPPC
Subject: Re: Cramfs root file system

Flavio,

> Please append a correct "root=" boot option
> Kernel panic: VFS: Unable to mount root fs on 02:00
>
> Now, is it possible to do what Im trying to do, if so are there any
> suggestions as to what I'm doing wrong?
>

I saw the same error when I was trying to mount jffs2 as root.  Maybe
your
problem is similar to mine.

My solution:

1)   in kernel file init/main.c 's dev_name_struct,  add entry for
 "mtdblock", 0x1f00
if it's not there already.

2) in ppcboot =>setenv bootargs init=/linuxrc root=/dev/mtdblockx

Hope this helps.

Dennis Khoo
Software Engineer
Adapcom, Inc


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
