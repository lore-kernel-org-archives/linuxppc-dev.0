Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <0509218DDAD7D6118055006008F6D5F6A1E3A2@postal.viasat.com>
From: "Pagnotta, Chris" <chris.pagnotta@viasat.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Hanging Init
Date: Tue, 10 Dec 2002 14:52:11 -0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I figure I am at the last stage in boot (I hope). I am however having an
issue that I was hoping someone
may shed some light on. I am having a hanging init.

1) I rebuilt busybox and here are the dependencies:

lb-deviant-linux:/home/eldk/eldk-ppc-linux-x86-2.0.2/usr/bin#
./ppc-linux-strings /tftpboot/powerpc/bin/busybox | grep lib    /lib/ld.so.1
libc.so.6
/lib/modules/


2) Here is the lib. Everything seems ok here

lb-deviant-linux:/home/eldk/eldk-ppc-linux-x86-2.0.2/usr/bin# ls -l
/tftpboot/powerpc/lib
total 1990
-rwxr-xr-x    1 root     root       453086 Dec  9 07:59 ld-2.2.5.so
lrwxrwxrwx    1 root     root           11 Dec  9 08:00 ld.so -> ld-2.2.5.so
lrwxrwxrwx    1 root     root           11 Dec  9 08:00 ld.so.1 ->
ld-2.2.5.so
-rwxr-xr-x    1 root     root      1325740 Nov 25 08:20 libc-2.2.5.so
lrwxrwxrwx    1 root     root            9 Nov 26 08:19 libc.so -> libc.so.6
lrwxrwxrwx    1 root     root           13 Nov 20 09:50 libc.so.6 ->
libc-2.2.5.so
-rwxr-xr-x    1 root     root       246266 Dec 10 12:25
libnss_files-2.2.5.so
lrwxrwxrwx    1 root     root           21 Dec 10 12:27 libnss_files.so.2 ->
libnss_files-2.2.5.so

3) Here is the output from PPCBoot. It looks like NFS mount was successfull.
I am using
   NFS mount server that run in user space NOT kernel. Don't know of this
makes any difference,
   but I was able to NFS mount the directory from another machine.
	mount -t nfs 172.25.4.55:/tftpboot/powerpc/ /mnt/nfs.


=> tftpboot
ENET Speed is 10 Mbps - HALF duplex connection
ARP broadcast 1
TFTP from server 172.25.4.55; our IP address is 172.25.4.57
Filename '/tftpboot/powerpc/vmlinux.PPCBoot'.
Load address: 0x400000
Loading: *########################################T ###################T
######
	 #################################################################
	 ############################################
done
Bytes transferred = 888431 (d8e6f hex)
=> boots

** Device 0 not available
## Booting image at 00400000 ...
   Image Name:   Linux-2.4.19-pre6
   Created:      2002-12-09  15:28:09 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    888367 Bytes = 867 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:mapin_ram done
MMU:setio
MMU:exit
setup_arch: enter
setup_arch: bootmem
arch: exit
Linux version 2.4.19-pre6 (cpagnotta@lb-deviant-linux) (gcc version 2.95.4
20010319 (prerelease/franzo/20011204)) #10 Mon Dec 9 07:26:53 PST 2002
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs nfsroot=/tftpboot/powerpc
ip=172.25.4.57:172.25.4.55:172.25.4.55:255.255.0.0:lb-vib-linux::off
Calibrating delay loop... 263.78 BogoMIPS
Memory: 127124k available (1504k kernel code, 668k data, 208k init, 0k
highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
PCI: moved device 00:06.1 resource 4 (101) to 1000

Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis Communications
AB.
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-proc.o version 2.6.1 (20010825)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0xef600300 (irq = 0) is a 16550A
ttyS01 at 0xef600400 (irq = 1) is a 16550A
ttyS02 at 0xf4100000 (irq = 26) is a ST16650V2
ttyS03 at 0xf4200000 (irq = 26) is a ST16650V2
PPC 405 watchdog driver v0.5
IBM gpio driver version 02.01.21.d
GPIO #0 at 0xc900d700
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
eth0: Phy @ 0x1, type LXT971A (0x001378e2)
pcnet32.c:v1.27a 10.02.2002 tsbogend@alpha.franken.de
Equalizer1996: $Revision: 1.2.1 $ $Date: 1996/09/22 13:52:00 $ Simon Janes
(simon@ncm.com)
Universal TUN/TAP device driver 1.4 (C)1999-2001 Maxim Krasnyansky
NFTL driver: nftlcore.c $Revision: 1.85 $, nftlmount.c $Revision: 1.25 $
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
Reset ethernet interfaces
eth0: IBM EMAC: link up, 10 Mbps Half Duplex, auto-negotiation complete.
eth0: IBM EMAC: MAC 00:60:c2:0a:00:1f.
eth0: IBM EMAC: open completed
IP-Config: Complete:
      device=eth0, addr=172.25.4.57, mask=255.255.0.0, gw=172.25.4.55,
     host=lb-vib-linux, domain=, nis-domain=(none),
     bootserver=172.25.4.55, rootserver=172.25.4.55, rootpath=
ip_conntrack (1024 buckets, 8192 max)
ip_tables: (C) 2000-2002 Netfilter core team
arp_tables: (C) 2002 David S. Miller
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Root-NFS: Mounting /tftpboot/powerpc on server 172.25.4.55 as root
Root-NFS:     rsize = 4096, wsize = 4096, timeo = 7, retrans = 3
Root-NFS:     acreg (min,max) = (3,60), acdir (min,max) = (30,60)
Root-NFS:     nfsd port = -1, mountd port = 0, flags = 00000200
Looking up port of RPC 100003/2 on 172.25.4.55
Root-NFS: Portmapper on server returned 2049 as nfsd port
Looking up port of RPC 100005/1 on 172.25.4.55
Root-NFS: mountd port is 812
NFS:      nfs_mount(ac190437:/tftpboot/powerpc)
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 208k init   (We are just in a hang state)

init does not seem to be executed.

Here is one more thing from my exports dir


/tftpboot/powerpc       172.25.0.0/255.255.0.0(rw,no_root_squash)

Please let me know if you have any suggestions.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
