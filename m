Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <3.0.3.32.20020621143133.006d37a8@hollabaugh.com>
Date: Fri, 21 Jun 2002 14:31:33 -0600
To: Jerry Van Baren <vanbaren_gerald@si.com>,
	linuxppc-embedded@lists.linuxppc.org
From: "Dr. Craig Hollabaugh" <craig@hollabaugh.com>
Subject: Re: Can I run linux without a file system?
In-Reply-To: <5.1.0.14.2.20020621155315.05f3e830@falcon.si.com>
References: <20020621194234.37274.qmail@web21103.mail.yahoo.com>
 <200206211835.g5LIZDL01282@hofr.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 04:12 PM 6/21/2002 -0400, Jerry Van Baren wrote:
>
>You need at least a RAM file system for "/" and a bunch of subdirectories
>such as /dev, /lib, etc.  The common way to do this on a minimalistic
>system is to create a file system image in ROM (often compressed) and copy
>it to RAM on start up.  Given the questions you are asking, I am very
>confident creating a minimal RAM disk image will challenge you sufficiently
>:-).  I'm not being snide, lots of people with lots of linux knowledge have
>tried and failed.  Most people use someone else's pre-configured minimal
>file systems and add/subtract (mostly add :-) programs to it.  This is
>because it is very, very hard to create a minimal file system (that works,
>that is).

I disagree. Creating a minimal root filesystem is easy once you understand what
happens when init executes. (Shameless plug here) In my Embedded Linux book, I show
you exactly the files needed to get bash running with a network connection. You use ldd to find out lib dependencies. Then copy binaries you want with their libs and some config files and your done. Here's my script to build such a root filesystem (http://www.embeddedlinuxinterfacing.com/chapters/04/buildrootfilesystem/buildrootfilesystem). Look it over, it probably won't make much sense without reading chapter 4.

I can say that a minimum RedHat install uses 29,296 files – 382.020MB, debian 10,734 files - 67.428MB, my minimal root filesystem 82 files and 4.8MB.


Here's a listing of tftproot directory

root@tbdev1[513]: cd /tftpboot/powerpc-rootfs/
root@tbdev1[514]: du -s
4824    .
root@tbdev1[515]: find .
.
./dev
./dev/tty
./dev/tty0
./dev/ttyS0
./dev/console
./dev/null
./dev/ram
./dev/initctl
./dev/mem
./dev/pts
./dev/ptyp0
./dev/ttyp0
./etc
./etc/init.d
./etc/init.d/rcS
./etc/init.d/umountfs
./etc/protocols
./etc/services
./etc/fstab
./etc/inittab
./etc/resolv.conf
./etc/mtab
./bin
./bin/bash
./bin/cat
./bin/ls
./bin/mount
./bin/umount
./bin/ps
./bin/df
./bin/kill
./bin/ping
./bin/chmod
./bin/touch
./bin/rm
./bin/echo
./bin/sh
./sbin
./sbin/init
./sbin/ifconfig
./sbin/route
./sbin/depmod
./sbin/insmod
./sbin/lsmod
./sbin/rmmod
./lib
./lib/ld-2.2.3.so
./lib/ld.so.1
./lib/libc-2.2.3.so
./lib/libc.so.6
./lib/libutil-2.2.3.so
./lib/libutil.so.1
./lib/libncurses.so.5
./lib/libncurses.so.5.2
./lib/libdl-2.2.3.so
./lib/libdl.so.2
./lib/libnss_dns-2.2.3.so
./lib/libnss_dns.so.2
./lib/libnss_files-2.2.3.so
./lib/libnss_files.so.2
./lib/libresolv-2.2.3.so
./lib/libresolv.so.2
./lib/libproc.so.2.0.7
./lib/librt-2.2.3.so
./lib/librt.so.1
./lib/libpthread-0.9.so
./lib/libpthread.so.0
./lib/libm-2.2.3.so
./lib/libm.so.6
./lib/libstdc++-3-libc6.1-2-2.10.0.so
./lib/libstdc++-libc6.1-2.so.3
./usr
./usr/bin
./usr/bin/telnet
./usr/bin/gdbserver
./usr/lib
./proc
./tmp


root@tbdev1[516]: find . | wc
     82      82    1212


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
