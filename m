Message-Id: <4.3.2.20001024114927.00b55f00@falcon.si.com>
Date: Tue, 24 Oct 2000 12:37:19 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: SBC8260, kernel 2.4.0-test8, initrd
In-Reply-To: <0G2X009AGV5CS2@pmdf-it.hasler.ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The basic problem is that your root file system isn't valid.  What do
you think should be your root file system and how should it be
mounted?  Are you NFS mounting it?  If so, are you exporting it
properly from your host?

Kernel panic: VFS: Unable to mount root fs on 01:00
I believe this means that it is looking at major device 1, minor device
0 which is set to /dev/ram0 on my x86 linux box.  A few lines before
this I see "Freeing initrd memory: 4194300k freed".  I would jump to
the conclusion that your RAM disk is gone at this point.  If you are
subsequently trying to mount /dev/ram0 as your root file system, that
would be bad.

How do you have BootP configured?  What does the host return?

No answers, but a lot of questions.  If you cannot dazzle them with
brilliance, baffle them with more questions :-).

gvb


At 04:27 PM 10/24/00 +0100, Ruedi.Hofer@ascom.ch wrote:
>Hi,
>
>I try to boot linux 2.4.0test8 on my sbc8260 with an initrd.
>
>make zImage.initrd generates the appropriate file which I load
>into my memory.
>
>Unfortunately, I get the strange error below...
>
>Any ideas???
>
>\Ruedi
>
>
>
>
>Starting at 0x400000...
>
>CPU/CPM/BUS: 198/132/66 Mhz
>
>Ethernet (in decimal): 0:160:30:1:4:5
>
>loaded at:     00400000 0040B274
>board data at: 00FFFFC0 00FFFFEC
>relocated to:  00200100 0020012C
>zimage at:     0040B274 00480312
>initrd at:     00480312 00481408
>avail ram:     00482000 01000000
>
>Linux/PPC load:
>Uncompressing Linux...done.
>Now booting the kernel
>Total memory = 16MB; using 0kB for hash table (at 00000000)
>Linux version 2.4.0-test8 (root@linux01) (gcc version 2.95.2 19991030
>(2.95.3 pr
>erelease/franzo)) #27 Tue Oct 24 15:12:45 CEST 2000
>Boot arguments: root=/dev/ram
>On node 0 totalpages: 4096
>zone(0): 4096 pages.
>zone(1): 0 pages.
>zone(2): 0 pages.
>Kernel command line: root=/dev/ram
>Warning: real time clock seems stuck!
>Calibrating delay loop... 131.89 BogoMIPS
>Memory: 14760k available (884k kernel code, 388k data, 52k init, 0k
>highmem)
>Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
>Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
>Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
>Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
>POSIX conformance testing by UNIFIX
>Linux NET4.0 for Linux 2.4
>Based upon Swansea University Computer Society NET3.039
>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
>NET4: Linux TCP/IP 1.0 for NET4.0
>IP Protocols: ICMP, UDP, TCP
>IP: routing cache hash table of 512 buckets, 4Kbytes
>TCP: Hash tables configured (established 1024 bind 1024)
>Starting kswapd v1.7
>CPM UART driver version 0.01
>ttyS00 at 0x0000 is a SMC
>ttyS01 at 0x0040 is a SMC
>pty: 256 Unix98 ptys configured
>RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
>eth0: SCC ENET Version 0.1, 00:a0:1e:01:04:05
>eth1: FCC ENET Version 0.2, 00:a0:1e:41:04:05
>fec: Phy @ 0x1, type 0x010fd04b
>RAMDISK: Compressed image found at block 0
>Freeing initrd memory: 4194300k freed
>Sending BOOTP requests.... OK
>IP-Config: Got BOOTP answer from 10.1.20.2, my address is 10.1.20.1
>ip_conntrack (128 buckets, 1024 max)
>kmem_create: Forcing size word alignment - nfs_fh
>Kernel panic: VFS: Unable to mount root fs on 01:00
>Rebooting in 180 seconds..


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
