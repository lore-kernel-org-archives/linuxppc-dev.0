Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: brian.auld@adic.com
Message-ID: <995FF289C9D69747A09E4299264459540C109861@penguin.adic.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Bare bones filesytem using Karim's book
Date: Mon, 2 Jun 2003 14:18:36 -0700 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I have used pre-built tool-chains/filesytems to boot linux on a 440GP ebony platform in the past using u-boot and an nfs mounted root filesystem.

After getting Karim's new book, I have been trying some things from scratch. I've built the tool-chain and I'm now trying to boot my kernel on ebony using a filesystem that was built according to the guidelines in Chapter 6 (Root Filesystem Content). I'm pretty sure I have followed the book to a tee (busybox not LFS), however, my boot sequence appears to be stopping at the point init is supposed to run.

Any quick thoughts on why this might be happening? To provide a comparison benchmark as I worked through this, I copied the (i) dev files, (ii) inittab and (iii) rc.sysinit from chapter 6 of the book (my "from scratch filesytem") to the ELDK stripped down target filesystem and this setup still boots. As for my stripped down ELDK, I have stripped it to the point where the following remains:

glibc-ppc_4xx-2.2.5-0.19a
libtermcap-devel-ppc_4xx-2.0.8-28
cracklib-dicts-ppc_4xx-2.7-12
pam-devel-ppc_4xx-0.75-19
fileutils-ppc_4xx-4.1-4
mingetty-ppc_4xx-0.9.4-18
gawk-ppc_4xx-3.1.0-3
SysVinit-ppc_4xx-2.78-19
e2fsprogs-devel-ppc_4xx-1.26-1.72
modutils-ppc_4xx-2.4.13-0.7.1a
bash-ppc_4xx-2.05-8
net-tools-ppc_4xx-1.60-3
portmap-ppc_4xx-4.0-38a
initscripts-ppc_4xx-6.43-1c
termcap-ppc_4xx-11.0.1-10
kernel-headers-ppc_4xx-2.4.4-1
glibc-common-ppc_4xx-2.2.5-0.19a
glibc-devel-ppc_4xx-2.2.5-0.19a
glib-ppc_4xx-1.2.10-5
libtermcap-ppc_4xx-2.0.8-28
cracklib-ppc_4xx-2.7-12
pam-ppc_4xx-0.75-19
textutils-ppc_4xx-2.0.14-2
mount-ppc_4xx-2.11g-5a
setup-ppc_4xx-2.3.4-1b
sh-utils-ppc_4xx-2.0.11-5
e2fsprogs-ppc_4xx-1.26-1.72
logrotate-ppc_4xx-3.5.9-1
sysklogd-ppc_4xx-1.4.1-4
util-linux-ppc_4xx-2.11f-17
busybox-ppc_4xx-0.60.1-17

Most of the above were left in as I felt they needed to be there or they were "required" sysVinit or initscripts, which I didn't want to remove...

Below is a log of my boot log for the "from scratch" filesystem. The stripped down ELDK filesystem still boots.

=============================================
Environment size: 509/4092 bytes
=> run bootcmd
ENET Speed is 100 Mbps - HALF duplex connection
ARP broadcast 1
TFTP from server 172.16.77.152; our IP address is 172.16.77.156
Filename '/tftpboot/vmlinux-iscsi-kernel'.
Load address: 0x100000
Loading: #################################################################
         #################################################
done
Bytes transferred = 583522 (8e762 hex)
## Booting image at 00100000 ...
   Image Name:   Linux-2.4.20
   Created:      2003-06-01  19:36:59 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    583458 Bytes = 569.8 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.4.20 (test@ppc-dev) (gcc version 2.95.3 20010315 (release)) #1 Sun Jun 1 15:34:30 EDT 2003
IBM Ebony port (C) 2002 MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw nfsroot=172.16.77.152:/home/test/mcb/usr/iscsi-rootfs ip=172.16.77.156:172.16.77.152:172.16.77.1:255.255.255.0:EBONY-3::off console=ttyS0
Calibrating delay loop... 599.65 BogoMIPS
Memory: 127760k available (940k kernel code, 344k data, 212k init, 0k highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0xfdfe9200 (irq = 0) is a 16550A
ttyS01 at 0xfdfe8300 (irq = 1) is a 16550A
Zmii bridge in RMII mode
eth0: Phy @ 0x8, type Am79c875A (0x00225541)
Reset ethernet interfaces
Zmii bridge in RMII mode
eth1: Phy @ 0x9, type Am79c875A (0x00225541)
Reset ethernet interfaces
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
eth0: IBM EMAC: link up, 100 Mbps Half Duplex, auto-negotiation complete.
eth0: IBM EMAC: MAC 00:04:ac:e3:1a:51.
eth0: IBM EMAC: open completed

eth1: IBM EMAC: link up, 10 Mbps Half Duplex.
eth1: IBM EMAC: MAC 00:04:ac:e3:1a:52.
eth1: IBM EMAC: open completed

IP-Config: Complete:
      device=eth0, addr=172.16.77.156, mask=255.255.255.0, gw=172.16.77.1,
     host=EBONY-3, domain=, nis-domain=(none),
     bootserver=172.16.77.152, rootserver=172.16.77.152, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 172.16.77.152
Looking up port of RPC 100005/1 on 172.16.77.152
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 212k init
==================================================

The "Freeing unused kernel memory:..." line is where it stops. Any ideas?

Thanks,

-- Brian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
