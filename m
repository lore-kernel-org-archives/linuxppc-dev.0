Message-ID: <3A5B343C.EF427147@dspace.de>
Date: Tue, 09 Jan 2001 16:54:36 +0100
From: Andreas Schreckenberg <ASchreckenberg@dspace.de>
Reply-To: Andreas Schreckenberg <ASchreckenberg@dspace.de>
MIME-Version: 1.0
To: Tania Oka <tania@centurysys.co.jp>,
        Embedded Linux list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: problem mounting ramdisk
References: <3A54C5E5.23A76888@dspace.de> <3A5B06B6.536B2B02@centurysys.co.jp>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tania Oka wrote:
>

Hello,

> I had a similar problem (with the "attempt to access beyond end of device" symptom)
> when the size of my initrd exceeded the ...

Thanks a lot. Yes indeed the problem was the ramdisk size.

#!/bin/sh
dd if=/dev/zero of=/dev/ram bs=1k count=4096
mke2fs -m0 /dev/ram

I changed Line 3 (give mke2fs the right number of blocks):
mke2fs -vm0 /dev/ram 4096 and add the line ramdisk_size=4096 to the kernel.

...
RAM disk driver initialized:  16 RAM disks of 4096K size
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 36k init 28k prep 4k pmac 12k open firmware
...

Vola. The ramdisk starts.

But my sash do not come up.
The kernel hangs without panic issues.

I used in /bin (the sash seems to be a little big):
-rwxr-xr-x   1 root     root       467284 Jan  5 11:32 sash
lrwxrwxrwx   1 root     root            4 Jan  5 17:19 sh -> sash

from:
hhl-ppc_7xx-sash-3.4-5.noarch.rpm  (alien -t because I use debian)
                         ^ ??? (the problem)
-> hhl-ppc_7xx-sash-3.4.tgz
(from the Monta Vista Hardhat /pub/CDK/1.2/latest/PowerPC/ppc_7xx/RPMS)

I compiled the kernel with CONFIG_BINFMT_ELF without CONFIG_SASH.
Do I need CONFIG_BINFMT_ELF32 or CONFIG_SASH ? What the difference ?

When I try to cross compile the sash:
...
powerpc-linux-gcc -static -s -o sash sash.o cmds.o cmd_dd.o cmd_ed.o cmd_grep.o cmd_ls.o cmd_tar.o cmd_gzip.o cmd_find.o
cmd_file.o cmd_chattr.o cmd_ar.o utils.o
/usr/local/powerpc-linux/bin/ld: cannot open crt1.o: No such file or directory
collect2: ld returned 1 exit status
make: *** [sash] Error 1
...

crt1.o = "c run time environment"

What's my problem ? I'm a bloody newbie to linux kernel/cross development :-)
Hope I am not offtopic here.

I installed gcc-2.95.2 and binutils-2.9.5.0.22 on my host described in
http://members.nbci.com/greyhams/linux/PowerPC-Embedded-HOWTO.html
(enough to build the kernel)

Is there anybody who can give me a valid ramdisk_image for a PPC750 System.
I need: cat,ls,insmod,bash and sash
(the ramdisk should be not greater then 16M)
Write to: ASchreckenberg@dspace.de

Any help would be welcome...

bye
Andreas
--
          Life's not fair. But the root password helps ! :-)
                   http://schrecky.home.pages.de

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
