Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: brian.auld@adic.com
Message-ID: <995FF289C9D69747A09E42992644595405B23649@penguin.adic.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Kernel boot: 'Kernel command line' not getting bootargs?????
Date: Tue, 4 Feb 2003 11:39:39 -0800 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ebony/440GP progress update.

I'm almost there ... I can smell it, I can taste it, I can hear it .... but
I just can't see or feel it yet.

Wolfgang mentioned this in a previous post. As everyone knows, appropriate
bootargs need to be passed for the kernel to boot with an nfs-mounted root
filesystem. I've triple checked everything and am 99.9999% sure I'm setting
the bootargs appropriately. For some reason, whenever I try booting, the
'Kernel command line:' always says 'ip=on'. I searched the archives and
couldn't anyone that had a similar problem.

I 'll attach my boot log with a printout of my u-boot env vars along the
way:

*************************************************************************
*************************************************************************
***************************   BOOT LOG  *********************************
*************************************************************************
*************************************************************************
U-Boot 0.2.0 (Jan 31 2003 - 05:12:55)

IBM PowerPC 440 Rev. C
Board: IBM 440GP Evaluation Board (Ebony)
        VCO: 800 MHz
        CPU: 400 MHz
        PLB: 133 MHz
        OPB: 66 MHz
        EPB: 66 MHz
I2C:   ready
DRAM:  I2c read: failed 4
I2c read: failed 4
128 MB
FLASH:  4.5 MB
PCI:   Bus Dev VenId DevId Class Int
In:    serial
Out:   serial
Err:   serial
KGDB:  kgdb ready
ready
BEDBUG:ready
=> printenv
baudrate=9600
ethaddr=00:04:AC:E3:1B:54
serial#=ADIC-Ebony1-iSCSI
bootcmd=bootp; setenv bootargs root=/dev/nfs rw
nfsroot=$(serverip):$(rootpath)
ip=$(ipaddr):$(serverip):$(gatewayip):$(netmask):$(hostname)::off; bootm
bootdelay=5
stdin=serial
stdout=serial
stderr=serial

Environment size: 272/4092 bytes
=> bootp
ENET Speed is 100 Mbps - HALF duplex connection
BOOTP broadcast 1
DHCP client bound to address 172.16.77.152
ARP broadcast 1
TFTP from server 172.16.77.151; our IP address is 172.16.77.152
Filename '/tftpboot/vmlinux.PPCBoot'.
Load address: 0x100000
Loading: #################################################################
         ####################################################
done
Bytes transferred = 594015 (9105f hex)
=> printenv
baudrate=9600
ethaddr=00:04:AC:E3:1B:54
serial#=ADIC-Ebony1-iSCSI
bootcmd=bootp; setenv bootargs root=/dev/nfs rw
nfsroot=$(serverip):$(rootpath)
ip=$(ipaddr):$(serverip):$(gatewayip):$(netmask):$(hostname)::off; bootm
bootdelay=5
stdin=serial
stdout=serial
stderr=serial
bootfile=/tftpboot/vmlinux.PPCBoot
filesize=9105f
gatewayip=172.16.77.1
netmask=255.255.255.0
hostname=ebony1-linux-iSCSI
rootpath=/opt/eldk/ppc_4xx
ipaddr=172.16.77.152
serverip=172.16.77.151

Environment size: 465/4092 bytes
=> bootm
## Booting image at 00100000 ...
   Image Name:   Linux-2.4.20
   Created:      2003-02-03  18:02:31 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    593951 Bytes = 580 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.4.20 (root@ppc-dev) (gcc version 2.95.4 20010319
(prerelease/franzo/20011204)) #1 Mon Feb 3 12:59:58 EST 2003
IBM Ebony port (C) 2002 MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
>>>>>>>>>>>>>>>>>>>>>>>>>>>>
****************************
Kernel command line: ip=on * Why does this not reflect my bootarg??
****************************
<<<<<<<<<<<<<<<<<<<<<<<<<<<<
Calibrating delay loop... 599.65 BogoMIPS
Memory: 127720k available (968k kernel code, 356k data, 212k init, 0k
highmem)
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
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
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
eth0: IBM EMAC: MAC 00:04:ac:e3:1b:54.
eth0: IBM EMAC: open completed

eth1: IBM EMAC: link up, 10 Mbps Half Duplex.
eth1: IBM EMAC: MAC 00:04:ac:e3:1b:55.
eth1: IBM EMAC: open completed

Sending BOOTP requests . OK
IP-Config: Got BOOTP answer from 172.16.77.151, my address is 172.16.77.152
IP-Config: Complete:
      device=eth0, addr=172.16.77.152, mask=255.255.255.0, gw=172.16.77.1,
     host=ebony1-linux-iSCSI, domain=adic.com, nis-domain=(none),
     bootserver=172.16.77.151, rootserver=172.16.77.151,
rootpath=/opt/eldk/ppc_4xx
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 172.16.77.151
Looking up port of RPC 100005/1 on 172.16.77.151
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 212k init
modprobe: modprobe: Can't open dependencies file
/lib/modules/2.4.20/modules.dep (No such file or directory)
INIT: version 2.78 booting
INIT: /etc/inittab[2]: missing action field
INIT: /etc/inittab[13]: missing action field
INIT: /etc/inittab[16]: missing action field
INIT: /etc/inittab[20]: process field too long
INIT: /etc/inittab[21]: missing action field
INIT: /etc/inittab[22]: missing action field
INIT: Entering runlevel: 3
INIT: no more processes left in this runlevel

*************************************************************************
*************************************************************************
*********************** BOOT LOG END     ********************************
*************************************************************************
*************************************************************************

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
