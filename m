Message-ID: <3773907C.D0EC7644@sei.co.kr>
Date: Fri, 25 Jun 1999 23:21:49 +0900
From: "KiPyo Ryu" <kpryu@sei.co.kr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Help! How to install linux on MBX860 IDE hard disk?
Content-Type: text/plain; charset=EUC-KR
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all,

I have a MBX860 with 32MB RAM, a 4GB IDE hard disk and a floppy.
I would like to install linux on a MBX860 hard disk.
I have some question to install linux on a MBX860 IDE hard disk.

I downloaded the following files from
ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded/
mbxnotes, embedded_notes, mbxroot.full.tgz, zImage.mbx-2.2.0-pre6,
embedded-2.2p7.tar.gz


1) I have untarred 'mbxroot.full.tgz' in the /sys directory.
2) I have made arch/ppc/defconfig file by using configuration of the
mbxnotes.
   I don't know how to make it exactly.
3) I have compiled on a PowerPC Linux.

4) My server(PowerPC Host) configuration for booting is as follows:
    -> /etc/inetd.conf
===========================================================================

    tftp   dgram udp wait root /usr/sbin/tcpd    in.tftpd /sys/mbxroot
    bootps dgram udp wait root /usr/sbin/tcpd    bootpd
===========================================================================

    -> /etc/exports ==> I don't know how to make it exactly.
===========================================================================

    /sys/mbxroot
===========================================================================

    -> /etc/services
===========================================================================

    bootps    67/udp            # bootp server
    bootpc    68/udp            # bootp client
    tftp      69/udp            # tftp client
===========================================================================

    -> /etc/bootptab ==> I don't know how to make it exactly.
===========================================================================

# bootptab file
#
.default:\
 :sm=255.255.255.0:\
 :ht=ethernet:\
 :bf=/sys/mbxroot/zImage:
 :ha=08003e25cb18:ip=210.96.178.73:tc=.default:hd=/sys/mbxroot:
===========================================================================

    -> /etc/fstab
===========================================================================

/dev/sda1               /                       ext2    defaults 1 1
/dev/sda3               /home                   ext2    defaults 1 2
/dev/sda2               swap                    swap    defaults 0 0
/dev/fd0                /mnt/floppy             ext2    noauto   0 0
none                    /proc                   proc    defaults 0 0
===========================================================================

    -> /etc/mtab
===========================================================================

/dev/sda1 / ext2 rw 0 0
none /proc proc rw 0 0
/dev/sda3 /home ext2 rw 0 0
===========================================================================

4) I have booted with the created zImage via nfs.
    Dump message is as follows :
    Please let me know what's wrong in this procedure.

===========================================================================

EPPC-Bug>pl 20 0
Network Booting from: MPC860, Controller 20, Device 0
Loading: /sys/mbxroot/zImage

Client IP Address      = 210.96.178.73
Server IP Address      = 210.96.178.72
Gateway IP Address     = 0.0.0.0
Subnet IP Address Mask = 255.255.255.0
Boot File Name         = /sys/mbxroot/zImage
Argument File Name     =

Bytes Received =&460572, Bytes Loaded =&460572
Bytes/Second   =&230286, Elapsed Time =2 Second(s)
loaded at:     00210000 0030E42C
relocated to:  00100000 001FE42C
board data at: 023F4558 023F4580
relocated to:  00200100 00200128
zimage at:     00216000 0026F092
avail ram:     0030E42C 00600000

Linux/PPC load: root=/dev/nfs nfsaddrs=210.96.178.73:210.96.178.72
nfsroot=210.9
6.178.72:/sys/mbxroot hdb=noprobe hda=8944,15,63
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.2.0-pre7 (root@linuxppc.sei.co.kr) (gcc version
egcs-2.90.25 980
302 (egcs-1.0.2 prerelease)) #1 Mon May 17 21:08:28 KST 1999
Boot arguments: root=/dev/nfs nfsaddrs=210.96.178.73:210.96.178.72
nfsroot=210.9
6.178.72:/sys/mbxroot hdb=noprobe hda=8944,15,63
time_init: decrementer frequency = 150000000/60
ide_setup: hdb=noprobe
ide_setup: hda=8944,15,63
Calibrating delay loop... 39.63 BogoMIPS
Memory: 35400k available (652k kernel code, 772k data, 40k init)
[c0000000,c2400
000]
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
Starting kswapd v 1.5
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
CPM UART driver version 0.02
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0380 is a SMC
ttyS02 at 0x0100 is a SCC
ttyS03 at 0x0200 is a SCC
RAM disk driver initialized:  16 RAM disks of 4096K size
hda: no response (status = 0xec)
hda: non-IDE drive, CHS=8944/15/63
ide0 at 0x000-0x007,0x000 on irq 30
Sizeof nbd_request needs to be 28 in order to work!
CPM ENET Version 0.1, 08:00:3e:25:cb:18
IP-Config: Guessing netmask 255.255.255.0
Partition check:
Looking up port of RPC 100003/2 on 210.96.178.72
Looking up port of RPC 100005/1 on 210.96.178.72
VFS: Mounted root (NFS filesystem).
Freeing unused kernel memory: 40k init 28k prep 4k pmac
bash# /sbin/fdisk /dev/hda
hda: driver not present
hda: driver not present

Unable to open /dev/hda
bash#
===========================================================================

How come the above dump message of 'Unable to open /dev/hda' happen?

Can anybody see what I'm doing wrong, or at least give me a few hints
where to look?

Thank you for your help.

Kipyo Ryu.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
