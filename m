Message-ID: <3B37189D7A56D511B404000629EE15D843772B@4rf_nz.local.4rf.com>
From: Richard Laing <Richard.Laing@4rf.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Problem with ramdisk image
Date: Mon, 25 Nov 2002 14:09:24 +1300
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am having a problem getting a ramdisk image to start correctly. I am
building for an RPX-Lite target using a 2.4.19 kernel and a ramdisk image
containing Busybox (statically linked against uClibc), TinyLogin Net-Snmp
and Zebra built using uClibc shared libraries. If I run the kernel and use
the file system over NFS then the system boots and runs as expected, if
however I build the ramdisk.image.gz and use make zImage.initrd it starts
but there is a problem with the file system. The relevant messages are as
follows:

RAMDISK: Compressed image found at block 0
crc error<6>Freeing initrd memory: 1251k freed
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 52k init
init started: Busybox v0.60.5 (...

# mount
rootfs on / type rootfs (rw)
/dev/ram on / type ext2 (rw)
proc on /proc type proc (rw)
# snmpd
EXT2-fs error (device ramdisk(1,0)):ext2_check_page: bad entry in directory
#22
EXT2-fs error (device ramdisk(1,0)):ext2_check_page: bad entry in directory
#20
snmpd: No such file or directory
# ls -l sbin/snmpd
-rwxr-xr-x   1 0       0    760916 Nov 21  2002 sbin/snmpd

I am cross-compiling from a PC for the target.

It appears that the ramdisk image is corrupt (crc error<6>) and yet busybox
works correctly, only the dynamically linked applications fail. If I unzip
and mount the ramdisk.image.gz file the filesystem check says it is okay.

I am assuming I have missed something either in the build process or in my
configuration of the system.

/etc/inittab is:

::sysinit:/etc/init.d/rcS
::respawn:/bin/ash
::shutdown:/etc/init.d/umountfs
::restart:/sbin/init

/etc/init.d/rcS is:

#!/bin/ash
/bin/mount -n -o remount,rw /

# Clear out mtab
> /etc/mtab

/bin/mount -a


/etc/fstab is

# <file system >     <mount point>   <type>    <options>  <dump> <pass>
proc                 /proc           proc      defaults   0       0
/dev/ram             /               ext2      defaults   1       1

Any ideas would be appreciated.

Cheers
Richard Laing

--
4RF Communications
Wellington, New Zealand
+64 4 499 6000 (Phone)
Richard.Laing@4RF.Com (Email)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
