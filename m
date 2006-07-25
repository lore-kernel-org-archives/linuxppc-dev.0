Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 2B32267B80
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Jul 2006 03:07:24 +1000 (EST)
Message-ID: <44C65097.2030601@ru.mvista.com>
Date: Tue, 25 Jul 2006 21:10:47 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Edward Jubenville <edjubenville@adelphia.net>
Subject: Re: Slow boot with NFS, server not responding
References: <GPECLCIGPLHEOMGPMCPAOEIIDNAA.edjubenville@adelphia.net>
In-Reply-To: <GPECLCIGPLHEOMGPMCPAOEIIDNAA.edjubenville@adelphia.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Edward,

Did you try using ethereal or tcpdump to see what is going on the wire?

I doubt this is your case, but once I've seen a similar behaviour (different
board and CPU!) when an ethernet controller had small Rx FIFO and no DMA, and the
driver was not able to read the first 1.5kB packet of the 4kB NFS read reply
out of the FIFO before the next portion of the same read reply overflows
the FIFO. This led to endless retransmissions etc.
pings are 56-byte + some overhead by default, so they worked OK.

Thanks,
Andrei

Edward Jubenville wrote:
> I am having trouble booting the kernel with a root file system over NFS.
> Once the kernel has mounted the file system, it cycles through this pair of
> messages, endlessly:
> 
> 	nfs: server 192.168.0.39 not responding, still trying
> 	nfs: server 192.168.0.39 OK
> 
> I can't figure out if this is a configuration problem or a hardware problem
> with our new board.  Booting in EXTREMELY slow, but manages to make some
> progress.  At first, I thought that I had an NFS server configuration or
> firewall problem.  But eventually, I discovered that the kernel had some
> success mounting the root file system because I started seeing messages from
> the init scripts.  Neither the BDI2000 or u-boot had any problem using the
> network hardware, so I suspect something must be misconfigured in the
> kernel.  While these messages are appearing, I can ping the board without
> any dropped packets.
> 
> The board is modeled after the Freescale Lite5200 (IceCube), but uses an
> MPC5200B processor.  The development environment is ELDK 3.1.1 with the
> ELDK's CVS development tree of Linux 2.4.25.
> 
> Here is the console log during kernel startup...
> I've also attached our kernel .config file.
> 
> ****************************************
> ==> bootm 0xff100000
> bootm 0xff100000
> ## Booting image at ff100000 ...
>    Image Name:   Linux PPC MPC5200 2.4
>    Created:      2006-07-19  22:31:09 UTC
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    884063 Bytes = 863.3 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb
> Linux version 2.4.25 (ejubenville@cvs) (gcc version 3.3.3 (DENX ELDK 3.1.1
> 3.3.3-9)) #3 Wed Jul 19 15:30:56 PDT 2006
> On node 0 totalpages: 16384
> zone(0): 16384 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.
> Kernel command line: root=/dev/nfs rw nfsroot=192.168.0.39:/opt/eldk/ppc_6xx
> ip=192.168.0.73:192.168.0.39:192.168.0.3:255.255.255.0:mmt1::off
> Calibrating delay loop... 307.20 BogoMIPS
> Memory: 62176k available (1496k kernel code, 504k data, 76k init, 0k
> highmem)
> Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
> Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
> Mount cache hash table entries: 512 (order: 0, 4096 bytes)
> Buffer cache hash table entries: 4096 (order: 2, 16384 bytes)
> Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
> POSIX conformance testing by UNIFIX
> PCI: Probing PCI hardware
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> Starting kswapd
> Journalled Block Device driver loaded
> devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
> devfs: devfs_debug: 0x0
> devfs: boot_options: 0x1
> JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
> pty: 256 Unix98 ptys configured
> devfs_register(cua): could not append to parent, err: -17
> devfs_register(cua): could not append to parent, err: -17
> ttyS0 on PSC1
> ttyS1 on PSC2
> ttyS2 on PSC3
> RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
> loop: loaded (max 8 devices)
> Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> Port Config is: 0x11050004
> ipb=132MHz, set clock period to 7
> GPIO config: 11050004
> ATA invalid: 01000000
> ATA hostcnf: 03000000
> ATA pio1   : 100a0a00
> ATA pio2   : 02040600
> XLB Arb cnf: 0000a366
> mpc5xxx_ide: Setting up IDE interface ide0...
> ATA DMA task: 5
> Probing IDE interface ide0...
> hda: SanDisk SDCFB-4096, CFA DISK drive
> hda: Setting MDMA 2 timings
> hda: Setting PIO 4 timings
> ide0 at 0xf0003a60-0xf0003a67,0xf0003a5c on irq 45
> hda: attached ide-disk driver.
> hda: 8005536 sectors (4099 MB) w/1KiB Cache, CHS=7942/16/63, DMA
> Partition check:
>  /dev/ide/host0/bus0/target0/lun0:<7>Unhandled interrupt 1a, disabled
>  [PTBL] [992/128/63] p1
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 4096 bind 8192)
> eth0: Phy @ 0x0, type LXT971 (0x001378e2)
> IP-Config: Complete:
>       device=eth0, addr=192.168.0.73, mask=255.255.255.0, gw=192.168.0.3,
>      host=mmt1, domain=, nis-domain=(none),
>      bootserver=192.168.0.39, rootserver=192.168.0.39, rootpath=
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> Looking up port of RPC 100003/2 on 192.168.0.39
> Looking up port of RPC 100005/1 on 192.168.0.39
> VFS: Mounted root (nfs filesystem).
> Mounted devfs on /dev
> Freeing unused kernel memory: 76k init
> nfs: server 192.168.0.39 not responding, still trying
> nfs: server 192.168.0.39 OK
> ****************************************
> 
> The "not responding" and "OK" keep repeating at a slow rate,
> eventually interspersed with messages from the init process.
> 
> Any help would be appreciated.  Thanks.
> 
> Ed Jubenville
> 
