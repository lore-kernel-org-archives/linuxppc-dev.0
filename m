Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <885489B3B89FB6449F93E525DF78777F064533@srvnt506.ALLOPTIC.COM>
From: "Muaddi, Cecilia" <cecilia.muaddi@alloptic.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: BDI-2000
Date: Wed, 8 Jan 2003 12:12:12 -0800 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

Looks like I made a typo and changed my kernel virtual address
in the makefile to 0x0c000000 instead of the default at 0xc0000000

So, after changed the kernel address to 0xc0000000 the kernel did
bootup with the following dump:
        Module Name: ../images/zImage.srec
        Entry Location: 0x400000
Starting at 0x400000...

loaded at:     00400000 0040C30C
board data at: 004001C0 004001E4
relocated to:  0040C0E8 0040C10C
zimage at:     0040C30C 004BC471
avail ram:     004BD000 00800000

Linux/PPC load: console=ttyS0,9600 nfsroot=192.168.0.59:/exports/onu860
ip=192.1
68.0.238::255.255.255.0
Uncompressing Linux... done.
Now booting the kernel
Linux version 2.4.7-timesys-3.1.254 (cmuaddi@localhost.localdomain) (gcc
version
 2.95.2 19991024 (release)) #42 Wed Jan 8 10:51:27 PST 2003
On node 0 totalpages: 2048
zone(0): 2048 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600 nfsroot=192.168.0.59:/exports/onu860
ip=
192.168.0.238::255.255.255.0
Decrementer Frequency = 187500000/60
Memory: 5380k available (1624k kernel code, 676k data, 56k init, 0k highmem)
Calibrating delay loop... 49.76 BogoMIPS
Dentry-cache hash table entries: 1024 (order: 1, 8192 bytes)
Inode-cache hash table entries: 512 (order: 0, 4096 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 2048 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
devfs: v0.107 (20010709) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
pty: 256 Unix98 ptys configured
block: queued sectors max/low 3373kB/1124kB, 64 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
eth0: CPM ENET Version 0.2 on SCC1, 00:00:00:00:00:00
eth1: FEC ENET Version 0.2, FEC irq 3, addr 00:00:00:80:00:00
loop: loaded (max 8 devices)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 16 buckets, 2Kbytes
TCP: Hash tables configured (established 16 bind 26)
IP-Config: Incomplete network configuration information.
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.0.59
RPC: sendmsg returned error 101
portmap: RPC call returned error 101
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 192.168.0.59
RPC: sendmsg returned error 101
portmap: RPC call returned error 101
Root-NFS: Unable to get mountd port number from server, using default
RPC: sendmsg returned error 101
mount: RPC call returned error 101
Root-NFS: Server returned error -101 while mounting /exports/onu860
VFS: Unable to mount root fs via NFS, trying floppy.
request_module[block-major-2]: Root fs not mounted
VFS: Cannot open root device "" or 02:00
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 02:00
Rebooting in 180 seconds..


Looks like my IP has some problem.  I will like to use the BDI with the ddd
for debugging
on my linux server.  When i start the ddd with the following command as
suggested
by the appnote

ddd -debugger gdb -gdb vmlinux

(gdb)target remote bdi:2001
Remote packet too long:
c00021a00040b..............

It seems there is a problem between the BDI and the DDD on my linux PC.  I
am running
redHat 8.0, GNU DDD 3.3.1 (i686-pc-linux-gnu)

Any help will be greatly appreciated.

Thanks

Cecilia

-----Original Message-----
From: Kerl, John [mailto:John.Kerl@Avnet.com]
Sent: Wednesday, January 08, 2003 9:44 AM
To: 'Marius Groeger'; 'cecilia.muaddi@alloptic.com'
Cc: 'linuxppc-embedded@lists.linuxppc.org'
Subject: Re: BDI-2000

I think Marius' problem and mine were generalizations
of the same issue -- there can't be *any* mappings in
the kernel with virtual address below 0xc0000000.
(This includes regions mapped 1-1 as a special case.)
I couldn't put the IMMR at 0x38000000; I moved it to
0xf0000000.  Marius found that on-chip RAM was mapped
at 0x70000000; that was bad too.  Also the CPLD on
my board which does LED control is mapped in at
0xf8000000 -- also above the 0xc0000000.  So I am
skeptical when Cecilia says she has "some other IO
mapped to miscellaneous addresses".  What are those
miscellaneous virtual addresses?

The difference, though, is that Marius & I both had
problems entering user mode.  Cecilia's is just a few
lines from the top of head_8xx.S, without yet having
made any subroutine calls to anything more complicated.
There's not much room for anything to have gone wrong
yet, in the Linux kernel code.  So I agree that getting
the vxWorks boot ROM out of the picture (e.g. using
PPCBoot instead) would be an interesting test.

-----Original Message-----
From: Marius Groeger [mailto:mag@sysgo.de]
Sent: Wednesday, January 08, 2003 10:21 AM
To: Wells, Charles
Cc: 'linuxppc-embedded@lists.linuxppc.org'
Subject: Re: BDI-2000

On Wed, 8 Jan 2003, Wells, Charles wrote:

> When I read Cecilia's post, I assumed what the statement "proven hardware
> platform" meant was that the vxworks O/S and user tasks exercised all the
> peripheral hardware; i.e., the SDRAM works, the ROM works, the FLASH works,
> the console works, etc.  So, that statement made sense to me.  While Linux

vxWorks doesn't use the MMU as much as Linux does. On Linux, the kernel and
all processes run in their own address space. The memory accesses involved
for cache or tlb refills are quite different to what's happening in a
vxWorks setup. Again, I'm probably overly pessimistic here, but we _have_
seen HW problems that just didn't show up when running vxWorks (AFAIR it was
a burst access on some early G4 based system.)

On a related matter, the following might also be interesting, especially
regarding the question of what firmware to use. The vxWorks boot-loader
tends to initialise _a lot_ of things you don't necessarily need. For
instance, on IBM405 based systems it sets up the on-chip RAM at address
0x70000000. Not a good idea when switching to user-mode the first time. Took
me quite some time to find this one... ;-)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
