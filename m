Message-ID: <D73A25AA6E54D511AD74009027B1110F5BB0E4@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'Jaap-Jan Boor'" <jjboor@aimsys.nl>,
	"Kevin A. Sapp" <Kevin.Sapp@catapult.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: RAM Disk problems
Date: Wed, 10 Mar 2004 10:11:13 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Also you can try an already created ramdisk that is known to work.  You can
download one from Wolfgang's site.  www.denx.de

-----Original Message-----
From: Jaap-Jan Boor [mailto:jjboor@aimsys.nl]
Sent: Wednesday, March 10, 2004 10:04 AM
To: Kevin A. Sapp
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: RAM Disk problems



Kevin,

I think I once had the same problem and it was caused by
having the kernel cmd line overwritten. You might check
that.

Jaap-Jan

On Wed, 2004-03-10 at 15:31, Kevin A. Sapp wrote:
> Hello,
>
> I am trying to bring up a RAM disk as the root file system.
> Most everything is working until it come's time to mount it.
> The logs are below.
>
> I noticed in mount_block_root the get_fs_names appears
> to returning a zero length string.
>
> I have tried root=/dev/ram
> root=/dev/ram0
> root=/dev/rd/0
> and combinatins with noinitrd.
>
> FYI. The RAM disk will be loaded by a bus master and will have
> to be persistant.
>
> Any suggestions?
> Thanks
> Kevin
>
>
> => bootm 100000 200000
> ## Booting image at 00100000 ...
>    Image Name:   Linux-2.4.20
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    485362 Bytes = 473.10 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> ## Loading RAMDisk Image at 00200000 ...
>    Image Name:   Kevin Simple RAMDisk
>    Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
>    Data Size:    1405884 Bytes =  1.3 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
> ## initrd at 0x00200040 ... 0x003573FB (len=1405884=0x1573BC)
>    Loading Ramdisk to 01c27000, end 01d7e3bc ... OK
> kernel addr:00000000
> machine_init<6>Memory BAT mapping: BAT2=16Mb, BAT3=8Mb, residual: 7Mb
> Linux version 2.4.20 (kevin@linux4) (gcc version 3.2.1) #258 Wed Mar 10
> 07:55:32
>  EST 2004
> setup arch<4>ADS setup arch
> On node 0 totalpages: 7936
> zone(0): 7936 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.
> Kernel command line: root=/dev/ram rw console=ttyS0,9600 nobats
> ip=192.168.82.5
>          console passed ttyS0:0
>             Checking for registered console ttyS
>          Prefered console -1
> ADS init IRQ. NR_IRQS=256
> ADS time init
> ADS calibrate decrementer. FREQ=66666666, tb_ticks_per_jiffy=166666
>            stdio console init
> serial_console_setup
> cons:c00ebc48 str:9600 cons->index:0 Calibrating delay loop... 132.71
> BogoMIPS
> Memory: 28828k available (828k kernel code, 288k data, 48k init, 0k
highmem)
> Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
> Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
> Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
> POSIX conformance testing by UNIFIX
> ADS init
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> Starting kswapd
> devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
> devfs: devfs_debug: 0x0
> devfs: boot_options: 0x1
> pty: 256 Unix98 ptys configured
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> loop: loaded (max 8 devices)
> *********************SERIAL INIT*************
> MPC8260 FCC Ethernet driver
> BD rings initialised, RBASE=1B8160, TBASE=1B8360
> Created eth0
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 2048 bind 4096)
> eth0: OPEN
> IP-Config: Guessing netmask 255.255.255.0
> IP-Config: Complete:
>       device=eth0, addr=192.168.82.5, mask=255.255.255.0,
> gw=255.255.255.255,
>      host=192.168.82.5, domain=, nis-domain=(none),
>      bootserver=255.255.255.255, rootserver=255.255.255.255, rootpath=
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> RAMDISK: Compressed image found at block 0
> Freeing initrd memory: 1372k freed
> Kernel panic: VFS: Unable to mount root fs on 01:00
>  <0>Rebooting in 180 seconds..
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
