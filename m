Message-ID: <D73A25AA6E54D511AD74009027B1110F5BAFA4@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'AlessandroPPC'" <aleppcrossi@libero.it>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: ram root filesystem
Date: Wed, 3 Dec 2003 12:52:58 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Try the ram disk at
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/SELF/images/ppc_82xx/

-----Original Message-----
From: AlessandroPPC [mailto:aleppcrossi@libero.it]
Sent: Wednesday, December 03, 2003 12:49 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: ram root filesystem



Hi to all,

I'm developing a custom application on 8260 based board. I have first used
the ELDK package version 2.0.2 with Kernel 2.4.4
and nfs root filesystem. Now I want migrate my application on the system
using ram fs instead of nfs.
To do this I have generated a ramdisk image derived from ELDK fs eliminating
superfluous packages and using a makefile with
this instructions:

 @echo "********************************************"
 @echo "create root files system"
 @echo "********************************************"
 rm -rf $(BUILD)/var/log/tegated
 mkdir $(BUILD)/var/log/tegated
 rm -rf $(RAMFS)/tmp/
 mkdir $(RAMFS)/tmp
 dd if=/dev/zero of=$(RAMFS)/ramrootfs bs=1k count=36864
 mke2fs -F -m0 $(RAMFS)/ramrootfs
 mount -o loop -t ext2 $(RAMFS)/ramrootfs $(RAMFS)/tmp
 cp -av $(BUILD)/* $(RAMFS)/tmp
 umount $(RAMFS)/tmp
 cat $(RAMFS)/ramrootfs | gzip -9 > $(IMGTGZ)
 /opt/eldk/usr/bin/mkimage -T ramdisk -C gzip -n "DexGate filesystem
image" -d $(IMGTGZ) $(RAMDSK)
 rm -rf $(RAMFS)/tmp/
 @echo "********************************************"
 @echo "Ramdisk image now in /tftpboot/ramdisk"
 @echo "********************************************"


In this way I'm able obtain a valid ramdisk image to download on my board
using ppcboot. giving the commands

bootp 0x2500000 /tftpboot/image
BOOTP broadcast 1
ARP broadcast 1
TFTP from server 10.0.0.4; our IP address is 10.0.0.20
Filename '/tftpboot/image'.
Load address: 0x2500000
Loading: #################################################################
         #######################################################
done
Bytes transferred = 610742 (951b6 hex)
fec001> bootp 0x2600000 /tftpboot/ramdisk
BOOTP broadcast 1
ARP broadcast 2
TFTP from server 10.0.0.4; our IP address is 10.0.0.20
Filename '/tftpboot/ramdisk'.
Load address: 0x2600000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
done
Bytes transferred = 11645509 (b1b245 hex)
fec001> setenv bootargs root=/dev/ram rw
fec001> bootm 0x2500000 0x2600000

At this point the system boots and the kernel mounts the ram disk but at
time of rc.sysint script I have this error :

VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 60k init
INIT: version 2.78 booting

Mounting proc filesystem                   :  [  OK  ]
Configuring kernel parameters              :  [  OK  ]
Setting clock : Wed Dec 31 19:00:15 EST 1969  [  OK  ]
Activating swap partitions                 :  [  OK  ]
Setting hostname 10.0.0.20                 :  [  OK  ]
Checking root filesystem
/dev/ram:
The superblock could not be read or does not describe a correct ext2
filesystem.  If the device is valid and it really contains an ext2
filesystem (and not swap or ufs or something else), then the superblock
is corrupt, and you might try running e2fsck with an alternate superblock:
    e2fsck -b 8193 <device>

[/sbin/fsck.ext2 (1) -- /] fsck.ext2 -a /dev/ram
fsck.ext2: Bad magic number in super-block while trying to open /dev/ram
[FAILED]

*** An error occurred during the file system check.
*** Dropping you to a shell; the system will reboot
*** when you leave the shell.
Give root password for maintenance
(or type Control-D for normal startup):


Notice that if  I write  rc.sysinit script to skip "Checking root
filesystem" I obtain the prompt but the syslogd deamon fails the startup.

>From ELDK distribution I have changed /etc/fstab file in

/dev/ram                /               ext2    defaults       0 0
none                    /proc           proc    defaults       0 0

and /etc/mtab file in

/dev/ram / ext2 rw 0 0
none /proc proc rw 0 0

Someone can say why fsck is not able to check ram fs and if the syslogd
problem is related to ram fs?

thanks to all,
Regards,
Alessandro.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
