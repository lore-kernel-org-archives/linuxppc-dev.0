Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Tue, 10 Apr 2001 16:07:03 +0200 (MET DST)
From: "WN.Jacobs" <WN.Jacobs@net.HCC.nl>
Reply-To: WN.Jacobs@net.HCC.nl
To: linuxppc-embedded@lists.linuxppc.org
Subject: Linux 2.5 + PPCBOOT and boot arguments transfer
Message-ID: <Pine.GSO.4.21.0104101605470.18610-100000@hatert.nijmegen.inter.nl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On our STK860L boards running PPCBOOT (0.7.1 or 0.8.3) we use
linux 2.4.0-test13-pre2 and a NFS file system without a problem:
ppcboot 0.7.1 (Apr 10 2001 - 12:03:33)

Initializing...
  CPU:   XPC860xxZPnnD3 at 80 MHz: 4 kB I-Cache 4 kB D-Cache FEC present
  Board: ### No HW ID - assuming TQM8xxL
  DRAM:  16 MB
  FLASH:  8 MB
  Input:  serial
  Output: serial

Hit any key to stop autoboot:  0
BOOTP broadcast 1
ARP broadcast 0
TFTP from server 192.7.1.37; our IP address is 192.7.1.61
Filename 'stk860l-linux-2.4.img'.
Load address: 0x100000
Loading: #########################################################################################
done
## Booting Linux kernel at 00100000 ...
   Image Name:   STK860L
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    451627 Bytes = 441 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.4.0-test13-pre2 (willy@suns100c21) (gcc version 2.95.2
19991024 (release)) #14 Fri Feb 9 14:11:45 MET 2001
Boot arguments: root=/dev/nfs rw
nfsroot=192.7.1.37:/opt/hardhat/devkit/ppc/8xx/target
ip=192.7.1.61:192.7.1.37::255.255.255.0:::off
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw
nfsroot=192.7.1.37:/opt/hardhat/devkit/ppc/8xx/target
ip=192.7.1.61:192.7.1.37::255.255.255.0:::off
etc.

Switching to the latest linux 2.5 (from FSMLABS) with the same PPCBOOT
(+bootargs) now shows:

## Booting Linux kernel at 00100000 ...
   Image Name:   STK860L
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    447951 Bytes = 437 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.4.2 (willy@suns100c21) (gcc version 2.95.2 19991024
(release)) #10 Tue Apr 10 15:42:40 MET DST 2001
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: ip=autoconf
Decrementer Frequency = 300000000/60
Calibrating delay loop... 79.66 BogoMIPS
Memory: 14856k available (840k kernel code, 340k data, 40k init, 0k
highmem)
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
CPM UART driver version 0.03
ttyS00 at 0x0280 is a SMC
pty: 256 Unix98 ptys configured
block: queued sectors max/low 9792kB/3264kB, 64 slots per queue
eth0: CPM ENET Version 0.2 on SCC1, 00:40:2f:00:4c:08
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
IP-Config: Incomplete network configuration information.
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Root-NFS: No NFS server available, giving up.
VFS: Unable to mount root fs via NFS, trying floppy.
request_module[block-major-2]: Root fs not mounted
VFS: Cannot open root device "" or 02:00
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 02:00
Rebooting in 180 seconds..

For some reason the boot arguments are not recognized by Linux.
Did anyone else had the same problem?

Regards,
---
willy


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
