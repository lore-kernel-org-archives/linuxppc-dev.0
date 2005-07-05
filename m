Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (unknown [217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C22AE67C66
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Jul 2005 20:46:18 +1000 (EST)
Date: Tue, 5 Jul 2005 11:45:50 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: "debora" <deboralh@fel.com.cn>
Message-Id: <20050705114550.30aaf1d8.ajz@cambridgebroadband.com>
In-Reply-To: <000c01c58149$94e7c4a0$0600a8c0@sinoveesc24ljh>
References: <000c01c58149$94e7c4a0$0600a8c0@sinoveesc24ljh>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mpc823 scc2 as eth0, nfs slow with linuxppc-2.4.25, but ok with
 linuxppc-2.4.4, why?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Your .config has probably changed when you upgraded your kernel.  It may be that
you've lost NFS v3 support and it's falling back on v1 support.  Check you have
v3 configured.  You need

CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_ROOT_NFS=y

Alex


On Tue, 5 Jul 2005 18:09:07 +0800
"debora" <deboralh@fel.com.cn> wrote:

> 
> 
> Hello All,
> 
> My board uses a MPC823 and SCC2 as its ethernet interface.
> 
> display "nfs: server 192.168.0.82 not responding, still trying"
>         "nfs: server 192.168.0.82 OK"
> when boot with linux-2.4.25, but ok with linux-2.4.4
> 
> Below is what it looks like when booting.
> 
> 
> boot with linux-2.4.25:
> eth0: CPM ENET Version 0.2 on SCC2, 42:dd:0c:46:e8:b8
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 2048 bind 4096)
> IP-Config: Complete:
>       device=eth0, addr=192.168.0.182, mask=255.255.255.0, gw=192.168.0.1,
>      host=192.168.0.182, domain=, nis-domain=(none),
>      bootserver=192.168.0.82, rootserver=192.168.0.82, rootpath=
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> Looking up port of RPC 100003/2 on 192.168.0.82
> Looking up port of RPC 100005/1 on 192.168.0.82
> VFS: Mounted root (nfs filesystem).
> Freeing unused kernel memory: 52k init
> nfs: server 192.168.0.82 not responding, still trying
> nfs: server 192.168.0.82 OK
> nfs: server 192.168.0.82 not responding, still trying
> nfs: server 192.168.0.82 not responding, still trying
> nfs: server 192.168.0.82 OK
> nfs: server 192.168.0.82 OK
>                 Welcome to Sinovee Linux 2.0 (Overlord)
>                 Press 'I' to enter interactive startup.
> Mounting proc filesystem:  nfs: server 192.168.0.82 not responding, still
> trying nfs: server 192.168.0.82 OK
> [  OK  ]
> Configuring kernel parameters:  [  OK  ]
> Setting clock (utc): Wed Jun 22 17:36:00 CST 2005 [  OK  ]
> Activating swap partitions:  [  OK  ]
> Setting hostname 192.168.0.182:  [  OK  ]
> Starting watchdog: [OK]
> Watchdog daemon ver 0.1, (c) 2002, FEL co. ltd.
> watchdog: No such device
> INIT: Entering runlevel: 3
> Entering non-interactive startup
> Starting xinetd: nfs: server 192.168.0.82 not responding, still trying
> nfs: server 192.168.0.82 OK
> [  OK  ]
> 
> Sinovee Linux 2.0 (Overlord)
> Kernel 2.4.4 on an MPC8xx
> 192 login: root
> nfs: server 192.168.0.82 not responding, still trying
> nfs: server 192.168.0.82 OK
> sh-2.04#
> sh-2.04#
> 
> boot with linux-2.4.4:
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> Kernel command line: root=/dev/nfs rw console=ttyS0,19200
> nfsroot=192.168.0.82:/ prj/sc8xx/root
> ip=192.168.0.182:192.168.0.82:192.168.0.1:255.255.255.0::eth0:off Decrementer
> Frequency: 4687500 Calibrating delay loop... 74.75 BogoMIPS
> Memory: 30744k available (1004k kernel code, 376k data, 48k init, 0k highmem)
> Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
> Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
> Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
> POSIX conformance testing by UNIFIX
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Starting kswapd v1.8
> CPM UART driver version 0.03
> ttyS0 on SMC1 at 0x0280, BRG1
> ttyS1 on SMC2 at 0x0380, BRG2
> pty: 256 Unix98 ptys configured
> WDT_8xx: SWT not enabled by firmware, SYPCR=0xffffff88
> block: queued sectors max/low 20357kB/6785kB, 64 slots per queue
> RAMDISK driver initialized: 16 RAM disks of 6144K size 1024 blocksize
> eth0: CPM ENET Version 0.21 on SCC2, 42:dd:0c:46:e8:b8
> loop: loaded (max 8 devices)
> Using configured DiskOnChip probe address 0x80000000
> DiskOnChip 2000 found at address 0x80000000
> Flash chip found: Manufacturer ID: 98, Chip ID: 75 (Toshiba TC58256FT/DC)
> 1 flash chips found. Total DiskOnChip size: 32 MiB
> NFTL driver: nftlcore.c $Revision: 1.83 $, nftlmount.c $Revision: 1.23 $
> Cannot calculate an NFTL geometry to match size of 0xf760.
> Using C:989 H:16 S:4 (== 0xf740 sects)
> Partition check:
>  nftla: nftla1
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 2048 bind 2048)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> Looking up port of RPC 100003/2 on 192.168.0.82
> Looking up port of RPC 100005/2 on 192.168.0.82
> VFS: Mounted root (nfs filesystem).
> Freeing unused kernel memory: 48k init
> INIT: version 2.78 booting
>                 Welcome to Sinovee Linux 2.0 (Overlord)
>                Press 'I' to enter interactive startup.
> Mounting proc filesystem:  [  OK  ]
> Configuring kernel parameters:  [  OK  ]
> Setting clock (utc): Fri Jun 24 02:00:28 CST 2005 [  OK  ]
> Activating swap partitions:  [  OK  ]
> Setting hostname 192.168.0.182:  [  OK  ]
> Starting watchdog: Watchdog daemon ver 0.1, (c) 2002, FEL co. ltd.
> watchdog: No such device
> [OK]
> INIT: Entering runlevel: 3
> Entering non-interactive startup
> Starting xinetd: [  OK  ]
> 
> Sinovee Linux 2.0 (Overlord)
> Kernel 2.4.4 on an MPC8xx
> 
> 192 login:
> 
> 
