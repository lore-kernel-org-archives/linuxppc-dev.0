Message-Id: <200012141836.NAA21519@lub0148.lss.emc.com>
Date: Thu, 14 Dec 2000 13:36:28 -0500 (EST)
From: Louis Krigovski <lkrigovs@emc.com>
Reply-To: Louis Krigovski <lkrigovs@emc.com>
Subject: Re: EST SBC8260
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I found few more things:

Once its stuck I can see CPU spining on exception 800 (Floating Point
Unavailable) which calls load_up_fpu. Then load_up_fpu in turn
enables FPU bit in msr and executes lfd     fr0,THREAD_FPSCR-4(r5)
which in turns generates trap 800 and again calls load_up_fpu.
  So I am spining in those 2 functions. Any idea how to approach finding
what is causing it. According to MontaVista manual thing should just boot
up.

--Louis

> Date: Fri, 8 Dec 2000 10:17:00 -0500 (EST)
> From: Louis Krigovski <lkrigovs@emc.com>
> Subject: EST SBC8260
> To: linuxppc-embedded@lists.linuxppc.org
> MIME-Version: 1.0
> Content-MD5: 6/JpVvWXvOpkV8MzNhI1rA==
> X-Mailing-List: <linuxppc-embedded@lists.linuxppc.org>
> X-Loop: linuxppc-embedded@lists.linuxppc.org
>
>
> Hi,
>   I am trying to boot HardHat Linux on EST SBC8260 board and I am stuck
>   with following error:
>
>   tty_io.c: process 1 (swapper) used obsolete /dev/cua - update software to
> use /dev/ttyS0
>
>   I tried replacing all occurences of TTYAUX_MAJOR to TTY_MAJOR in uart.c
>   and I also tried making console symbolic link to ttyS0, but neither
>   change helped. Any idea what might be causing it?
>
>   Thanks,
>
>   --Louis
>
>
>
> Linux version 2.4.0-test2 (lkrigovs@lub1021.lss.emc.com) (gcc version 2.95.2
> 19991030 (2.95.3 prerelease/franzo)) #27 Fri Dec 8 10:01:12 EST 2000
> Boot arguments: root=/dev/nfs rw
> nfsroot=168.159.39.21:/opt/hardhat/devkit/ppc/82xx/target
> nfsaddrs=168.159.39.21
> On node 0 totalpages: 2560
> zone(0): 2560 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.
> Kernel command line: root=/dev/nfs rw
> nfsroot=168.159.39.21:/opt/hardhat/devkit/ppc/82xx/target
> nfsaddrs=168.159.39.21
> Calibrating delay loop... 87.86 BogoMIPS
> Memory: 8732k available (868k kernel code, 376k data, 52k init)
> [c0000000,c0a00000]
> Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
> Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
> Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
> kmem_create: Poisoning requested, but con given - bdev_cache
> Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
> kmem_create: Poisoning requested, but con given - inode_cache
> POSIX conformance testing by UNIFIX
> Linux NET4.0 for Linux 2.3
> Based upon Swansea University Computer Society NET3.039
> kmem_create: Poisoning requested, but con given - skbuff_head_cache
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 512 bind 512)
> Starting kswapd v1.6
> CPM UART driver version 0.01
> ttyS00 at 0x0000 is a SMC
> ttyS01 at 0x0040 is a SMC
> ttyS02 at 0x8100 is a SCC
> ttyS03 at 0x8200 is a SCC
> pty: 256 Unix98 ptys configured
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> loop: registered device at major 7
> loop: enabling 8 loop devices
> eth0: SCC ENET Version 0.1, 00:a0:11:22:22:68
> eth1: FCC ENET Version 0.1, 00:a0:11:a2:22:68
> Sending BOOTP requests.... OK
> IP-Config: Got BOOTP answer from 168.159.39.21, my address is 168.159.38.189
> kmem_create: Forcing size word alignment - nfs_fh
> Looking up port of RPC 100003/2 on 168.159.39.21
> Looking up port of RPC 100005/2 on 168.159.39.21
> VFS: Mounted root (nfs filesystem).
> Freeing unused kernel memory: 52k init
> tty_io.c: process 1 (swapper) used obsolete /dev/cua - update software to
> use /dev/ttyS0
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
