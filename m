Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <004f01c3bf0e$1839e2c0$0400a8c0@eurostudio.local>
From: "AlessandroPPC" <aleppcrossi@libero.it>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: self image
Date: Wed, 10 Dec 2003 12:09:33 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_004C_01C3BF16.78D952C0"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.

------=_NextPart_000_004C_01C3BF16.78D952C0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Dear Wolfgang Denk,

I'm just looking at the SELF image and I observed that when I extract the
image and try to rebuild it
(without adding or removing any files) the dimension of result file is about
9KByte greater  than the original.
I have followed the procedure "How to increase the Size of ramdisk" to
generate an 8MByte ramdisk thus I
was expecting a small increase of the bytes amount, but never as reported.
Do you think I'm wrong somewhere?

Here enclosed is the script file.

any helps would be apreciated.
Many thanks
Alessandro.


[root@pegaso SELF]# ll
totale 1380
-rw-r--r--    1 root     root      1400262 dic 10 11:35 pRamdisk
-rwxr-xr-x    1 pegaso   pegaso       1835 dic 10 11:17 self1.sh
-rwxr-xr-x    1 pegaso   pegaso       1189 dic 10 12:01 self.sh
[root@pegaso SELF]# ./self.sh pRamdisk
entrati 21878+1 record
usciti 21878+1 record
ramdisk.gz:      66.6% -- replaced with ramdisk
entrati 8+0 record
usciti 8+0 record
mke2fs 1.27 (8-Mar-2002)
new_ramdisk is mounted; mke2fs forced anyway.  Hope /etc/mtab is incorrect.
Filesystem label=
OS type: Linux
Block size=1024 (log=0)
Fragment size=1024 (log=0)
2048 inodes, 8192 blocks
0 blocks (0.00%) reserved for the super user
First data block=1
1 block group
8192 blocks per group, 8192 fragments per group
2048 inodes per group

Writing inode tables: done
Writing superblocks and filesystem accounting information: done

This filesystem will be automatically checked every 29 mounts or
180 days, whichever comes first.  Use tune2fs -c or -i to override.
tune2fs 1.27 (8-Mar-2002)
Setting maximal mount count to -1
............................................................................
............................................................................
............................................................................
............................................................................
....................................................
630 blocks
Image Name:   DexGate SELF image
Created:      Wed Dec 10 12:01:37 2003
Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
Data Size:    1408989 Bytes = 1375.97 kB = 1.34 MB
Load Address: 0x00000000
Entry Point:  0x00000000
[root@pegaso SELF]#


------=_NextPart_000_004C_01C3BF16.78D952C0
Content-Type: application/octet-stream;
	name="self.sh"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="self.sh"

#!/bin/bash
SOURCE=3Dramdisk
OLD=3Dtmp
NEW=3Dnew
NEWRAMDISK=3Dnew_ramdisk
RESULT=3D/tftpboot/ramdisk.self

if [ -z "$1" ] ; then=20
  echo 'usage: self.sh ramdisk_filename'
  exit 1
fi

if [ ! -e "$1" ] ; then
  echo "file $1 does not exist."
  exit 1
fi

SELFIMAGE=3D$1


mkdir -p $OLD
mkdir -p $NEW
   =20
dd if=3D$SELFIMAGE bs=3D64 skip=3D1 of=3D$SOURCE.gz
gunzip -v $SOURCE.gz

mount -o loop $SOURCE $OLD

dd if=3D/dev/zero of=3D$NEWRAMDISK bs=3D1024k count=3D8
/sbin/mke2fs -F -m0 $NEWRAMDISK
/sbin/tune2fs  -c 0 $NEWRAMDISK


mount -o loop $NEWRAMDISK $NEW
cd $OLD
find . -depth -print | cpio -VBpdum ../$NEW
cd ..
umount $OLD
   =20
umount $NEW
gzip -9 $NEWRAMDISK
/opt/eldk/usr/bin/mkimage -T ramdisk -C gzip -n "DexGate SELF image" -d =
$NEWRAMDISK.gz $RESULT

rm -rf $NEWRAMDISK.gz
rm -rf $SOURCE.gz
rm -rf $SOURCE
rmdir $NEW
rmdir $OLD

------=_NextPart_000_004C_01C3BF16.78D952C0--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
