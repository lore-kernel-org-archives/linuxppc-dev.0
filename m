Message-ID: <3AEEF758.FEF4A65D@denise.shiny.it>
Date: Tue, 01 May 2001 19:50:16 +0200
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 9.1 Gbyte SCSI Drive
References: <Pine.LNX.4.21L.0104291944440.17913-100000@unix47.andrew.cmu.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > [root@Jay linux]# /sbin/pdisk -i
> > Top level command (? for help): e /dev/sdb
> > Edit /dev/sdb -
> > Command (? for help): i
> > map already exists
>   ^^^ seems to suggest that you did not use dd to zero your partition map
> before trying this experiment.


[root@Jay Giu]# dd if=/dev/zero of=/dev/sdb bs=1048576 count=100
100+0 records in
100+0 records out

[root@Jay Giu]# /sbin/pdisk -i
Top level command (? for help): e
Name of device: /dev/sdb
pdisk: No valid block 1 on '/dev/sdb'
Edit /dev/sdb -
Command (? for help): I
A physical block is 1 bytes: 2048
A logical block is 512 bytes: 2048
size of 'device' is 310352 blocks (2048 byte blocks):
new size of 'device' is 310352 blocks (2048 byte blocks)
Command (? for help): s 3
Command (? for help): p

Partition map (with 2048 byte blocks) on '/dev/sdb'
 #:                type name   length   base   ( size )
 1: Apple_partition_map Apple       3 @ 1
 2:          Apple_Free Extra  310348 @ 4      (606.1M)

Device block size=2048, Number of Blocks=310352 (606.2M)
DeviceType=0x0, DeviceId=0x0

Command (? for help): r 2 1
Command (? for help): p

Partition map (with 2048 byte blocks) on '/dev/sdb'
 #:                type name   length   base   ( size )
 1:          Apple_Free Extra  310348 @ 4      (606.1M)
 2: Apple_partition_map Apple       3 @ 1

Device block size=2048, Number of Blocks=310352 (606.2M)
DeviceType=0x0, DeviceId=0x0

Command (? for help): w
Writing the map destroys what was there before. Is that okay? [n/y]: y
The partition table has been altered!

Command (? for help): q
Top level command (? for help): q
[root@Jay Giu]# /sbin/mke2fs -b 2048 -m 0 /dev/sdb1
mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
Filesystem label=
OS type: Linux
Block size=2048 (log=1)
Fragment size=2048 (log=1)
77824 inodes, 310348 blocks
0 blocks (0.00%) reserved for the super user
First data block=0
19 block groups
16384 blocks per group, 16384 fragments per group
4096 inodes per group
Superblock backups stored on blocks:
	16384, 49152, 81920, 114688, 147456

Writing inode tables: done
Writing superblocks and filesystem accounting information: done
[root@Jay Giu]#


It works fine. Are you sure your HD is ok ?

Bye.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
