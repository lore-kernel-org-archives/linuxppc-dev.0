Message-ID: <37C36F87.4B23BE60@dgs.monash.edu.au>
Date: Wed, 25 Aug 1999 14:22:32 +1000
From: Brendan Simon <brendan@dgs.monash.edu.au>
Reply-To: brendan@dgs.monash.edu.au
MIME-Version: 1.0
To: linux-embedded <linux-embedded@waste.org>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Embedded LinuxPPC questions.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Some time ago I tried to compile the LinuxPPC kernel for the Motorola
ADS860 board.  During the build of the egcs-1.1.2 GNU Compiler
Collection as a powerpc-linux cross-compiler, I was advised to
preinstall runtime libraries and headers.  The following rpm files were
suggested (glibc-2.1-1a.ppc.rpm & glibc-devel-2.1-1a.ppc.rpm).  The
cross-compiler built successfully and and I was able to compile the
2.2.5 kernel.  I had unpacked the mbxroot.min.gz files to a linux
machine and exported these files via nfs.  The linux kerenl did boot and
uncompress, mounted the root filesystem via nfs and then failed when
trying to fopen("/dev/console").  I got stuck and I had to move on to
other things due to work committments.

I now wish to get LinuxPPC going and have time to think about possible
problems.  I'm hoping someone can answer these questions.

1) The installed libraries on the ix86 host are from glibc-2.1.  I
notice that the libc in the mbxroot filesystem is libc-1.99.  Could this
be why fopen("/dev/console") does not work.  If so, would getting the
glibc sources, recompiling and installing them in the cross-linux
toolchain and the nfs root filesystem, fix the problems ?  Here a
listing of the mbxroot filesystem.

        # ls -lR
        total 488
        drwxrwxrwx   2 1000     root         1024 Jul 15 15:57 bin
        drwxrwxrwx   2 root     root         1024 Sep  8  1998 dev
        drwxrwxrwx   2 1000     root         1024 Sep  8  1998 lib
        drwxrwxrwx   2 root     root         1024 Jul  8 23:14 tmp
        -rwxr-xrwx   1 1000     root       492532 Sep  8  1998 zImage

        bin:
        total 425
        -rwxr-xrwx   1 1000     root        54584 Sep  8  1998 ls
        -rwxr-xrwx   1 1000     root       375704 Sep  8  1998 sh

        dev:
        total 0
        lrwxrwxrwx   1 root     root            5 Jul  1 22:13 console
-> ttyS0
        crw-rw-rw-   1 root     root       5,   0 Sep  8  1998 tty
        crw-rw-rw-   1 root     root       4,  64 Sep  8  1998 ttyS0

        lib:
        total 920
        -rwxrwxrwx   1 1000     root        77398 Sep  8  1998 ld.so.1
        -rwxrwxrwx   1 1000     root       825404 Sep  8  1998
libc-1.99.so
        lrwxrwxrwx   1 root     root           12 Jul  1 22:13 libc.so.6
-> libc-1.99.so
        lrwxrwxrwx   1 root     root           19 Jul  1 22:13
libtermcap.so.2 -> libtermcap.so.2.0.8
        -rwxrwxrwx   1 1000     root        30152 Sep  8  1998
libtermcap.so.2.0.8

        tmp:
        total 0

2) I have a 8MB flash disk that I could put the root filesystem on to
avoid the nfs stuff.  I saw the ATA_FLASH pre-processor definition in
the sources but it has a #if 0 around it.  How do I go about booting
from a rootfilesystem on an ATA Flash Disk ?  Would later kernels have
better support for this ?

3) What is the states of the romfs (I think that is what it is called).
Is this used for filesystems stored in linear non-volatile memory
devices and can one put an initial root filesystem  on it ?  Any
pointers to information on how to use romfs ?

4) The ADS860 support I have was via patches from Magnus Damm.  It was
supposed to be put into the kernel CVS sources sometime ago but I
haven't seen any mail to indicate this has happened.  Can anyone confirm
if it is in CVS ?  If not, is it likely to be put in CVS at any stage ?

5) Do the linux-2.2.x kernels compile with GCC-2.95.x ?

Thanks,
Brendan Simon.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
