Date: Thu, 25 May 2000 10:20:01 -0400 (EDT)
From: "Mark S. Mathews" <mark@absoval.com>
To: SangTae Ha <stha@postech.edu>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: How to load kernel on RPX Lite Board ?
In-Reply-To: <01a301bfc629$393f1ee0$dc52df8d@oslo>
Message-ID: <Pine.LNX.3.96.1000525100001.30564B-100000@tristar.cc.absoval.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Could you telll me what's difference between powerpc-linux-objcopy and zsrec?

I believe (but not sure) that zsrec discards the ELF header and uses it's
own image location assumptions.  It's magic....and just works.  ;-)
The zsrec source isn't too tough to look at if you really need to know.

> Can we burn this S-record file into flash memory insead of loading into
> memory?  Some changes needed, doesn't it?

The quickest way to do this for the first time is to use the RPX utility
(RPXU) to:

1) Copy your kernel image to RAM using RPXU tftp
2) Use the RPXU flash program command to copy from RAM to flash
3) Use the RPXU to jump to your flash load address

The system/decompress/kernel initialization code is smart enough to figure
out where the image is located and then do the right thing.  I'm not sure
who's responsible for that little piece of magic (Cort? Dan?), but it's
really pretty slick.


> what is next step?

> I read LDP(Linux Documentation Project). There are many choices to mount
> root file system. NFS, initrd, ..? I really want to know how to mount
> root file system.

You can mount the rootfs via network using a couple of methods:
1) use bootp/dhcp to let the kernel determine its network address and
nfsroot location
2) specify these parameters at the bootprompt.

Ramdisk rootfs isn't too tough either.  Create your rootfs image (see
HOWTO), copy it to the arch/ppc/mbxboot directory as the file
ramdisk.image.gz and then do 'make zImage.initrd' at the kernel top level
directory.  Now zsrec the resulting image, load it into the rpx, run it
and specify 'root=/dev/ram' on the boot prompt (or modify misc.c to use
the appropriate default).  You'll need to make sure your rootfs isn't
larger than 4MB.  If it is you'll need to add the 'ramdisk_size' parameter
to your bootstring.

One caveat:  Once you add a ramdisk, your srec image will probably be too
large to successfully tftp due to a limitation of the RPXU.  Use the
'split -C' command to make it into several smaller files and load each one
separately.

-Mark

Mark S. Mathews

AbsoluteValue Systems      Web:    http://www.absoval.com
P.O. Box 941149            e-mail: mark@absoval.com
Maitland, FL 32794-1149    Phone:  407.644.8582
USA                        Fax:    407.539.1294


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
