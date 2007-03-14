Return-Path: <bounces@nabble.com>
Received: from talk.nabble.com (www.nabble.com [72.21.53.35])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 83F1EDDDE9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Mar 2007 17:41:37 +1100 (EST)
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50) id 1HRNAz-0004Ul-Ko
	for linuxppc-embedded@ozlabs.org; Tue, 13 Mar 2007 23:41:33 -0700
Message-ID: <9469217.post@talk.nabble.com>
Date: Tue, 13 Mar 2007 23:41:33 -0700 (PDT)
From: Nethra <nethra_gmit@yahoo.co.in>
To: linuxppc-embedded@ozlabs.org
Subject: jffs2-No space left on device
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


hi..
I m using custom board same as MPC8272ADS board,
                                            linux is montavista 2.6.10
                                            boot loader is u-boot-1.1.2.
I m getting jffs2 mounting on PQ2FADS-ZU board.

Through nfs mounting of root file system.I m trying jffs2 mounting without
any image( with empty patition).. it is giving 100% of space is used.I m
getting same output with jffs2 image also.
what is the actual problem?

Here is the output...
root@cashel:/# od -x /dev/mtd2 | less
0000000 ffff ffff ffff ffff ffff ffff ffff ffff
*
14000000
root@cashel:/# mount -t jffs2 /dev/mtdblock2 /mnt
root@cashel:/# dfErase at 0x002c0000 failed immediately: -EROFS. Is the
sector l
ocked?
Erase at 0x002a0000 failed immediately: -EROFS. Is the sector locked?
Erase at 0x00280000 failed immediately: -EROFS. Is the sector locked?
Erase at 0x00260000 failed immediately: -EROFS. Is the sector locked?
Erase at 0x00240000 failed immediately: -EROFS. Is the sector locked?
Erase at 0x00220000 failed immediately: -EROFS. Is the sector locked?
Erase at 0x00200000 failed immediately: -EROFS. Is the sector locked?
Erase at 0x001e0000 failed immediately: -EROFS. Is the sector locked?
Erase at 0x001c0000 failed immediately: -EROFS. Is the sector locked?
Erase at 0x001a0000 failed immediately: -EROFS. Is the sector locked?
Erase at 0x00180000 failed immediately: -EROFS. Is the sector locked?
Erase at 0x00160000 failed immediately: -EROFS. Is the sector locked?
Erase at 0x00140000 failed immediately: -EROFS. Is the sector locked?
Erase at 0x00120000 failed immediately: -EROFS. Is the sector locked?
Erase at 0x00100000 failed immediately: -EROFS. Is the sector locked?
Erase at 0x000e0000 failed immediately: -EROFS. Is the sector locked?
Erase at 0x000c0000 failed immediately: -EROFS. Is the sector locked?
Erase at 0x000a0000 failed immediately: -EROFS. Is the sector locked?
Erase at 0x00080000 failed immediately: -EROFS. Is the sector locked?
Erase at 0x00060000 failed immediately: -EROFS. Is the sector locked?
Erase at 0x00040000 failed immediately: -EROFS. Is the sector locked?
Erase at 0x00020000 failed immediately: -EROFS. Is the sector locked?
Erase at 0x00000000 failed immediately: -EROFS. Is the sector locked?
Erase at 0x002e0000 failed immediately: -EROFS. Is the sector locked?

root@cashel:/# df
Filesystem           1K-blocks      Used Available Use% Mounted on
rootfs                74393444  60054060  10499452  86% /
/dev/root             74393444  60054060  10499452  86% /
tmpfs                     6952         0      6952   0% /tmp
/dev/root             74393444  60054060  10499452  86% /dev/.static/dev
none                     10240      2172      8068  22% /dev
tmpfs                     6952         0      6952   0% /dev/shm
/dev/mtdblock2            3072      3072         0 100% /mnt

root@cashel:/# mount
rootfs on / type rootfs (rw)
/dev/root on / type nfs
(rw,v2,rsize=4096,wsize=4096,hard,udp,nolock,addr=192.16
8.178.110)
proc on /proc type proc (rw,nodiratime)
sysfs on /sys type sysfs (rw)
tmpfs on /tmp type tmpfs (rw)
/dev/root on /dev/.static/dev type nfs
(rw,v2,rsize=4096,wsize=4096,hard,udp,nol
ock,addr=192.168.178.110)
none on /dev type tmpfs (rw)
devpts on /dev/pts type devpts (rw)
tmpfs on /dev/shm type tmpfs (rw)
/dev/mtdblock2 on /mnt type jffs2 (rw,noatime)

root@cashel:/# df
Filesystem           1K-blocks      Used Available Use% Mounted on
rootfs                74393444  60054060  10499452  86% /
/dev/root             74393444  60054060  10499452  86% /
tmpfs                     6952         0      6952   0% /tmp
/dev/root             74393444  60054060  10499452  86% /dev/.static/dev
none                     10240      2172      8068  22% /dev
tmpfs                     6952         0      6952   0% /dev/shm
/dev/mtdblock2            3072      3072         0 100% /mnt
root@cashel:/# df
Filesystem           1K-blocks      Used Available Use% Mounted on
rootfs                74393444  60054060  10499452  86% /
/dev/root             74393444  60054060  10499452  86% /
tmpfs                     6952         0      6952   0% /tmp
/dev/root             74393444  60054060  10499452  86% /dev/.static/dev
none                     10240      2172      8068  22% /dev
tmpfs                     6952         0      6952   0% /dev/shm
/dev/mtdblock2            3072      3072         0 100% /mnt
root@cashel:/# df
Filesystem           1K-blocks      Used Available Use% Mounted on
rootfs                74393444  60054060  10499452  86% /
/dev/root             74393444  60054060  10499452  86% /
tmpfs                     6952         0      6952   0% /tmp
/dev/root             74393444  60054060  10499452  86% /dev/.static/dev
none                     10240      2172      8068  22% /dev
tmpfs                     6952         0      6952   0% /dev/shm
/dev/mtdblock2            3072      3072         0 100% /mnt


After mounting also mtd2 device is empty..

root@cashel:/# od -x /dev/mtd2 | less
0000000 ffff ffff ffff ffff ffff ffff ffff ffff
*
14000000
root@cashel:/# cat /proc/mtd
dev:    size   erasesize  name
mtd0: 00020000 00020000 "HRCW"
mtd1: 00060000 00020000 "bootloader"
mtd2: 00300000 00020000 "User fs"
root@cashel:/#
root@cashel:/# cd /mnt
root@cashel:/mnt# ls
root@cashel:/mnt# touch nethra
touch: cannot touch `nethra': No space left on device
root@cashel:/mnt#


thanks in advance..

Nethra


-- 
View this message in context: http://www.nabble.com/jffs2-No-space-left-on-device-tf3400453.html#a9469217
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
