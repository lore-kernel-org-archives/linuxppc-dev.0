Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: brian.auld@adic.com
Message-ID: <995FF289C9D69747A09E42992644595405B23645@penguin.adic.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: I can smell it ... I'm almost there
Date: Mon, 3 Feb 2003 11:31:20 -0800 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Embedded linux on 440GP/ebony progress update using ELDK and
linuxppc_2_4_devel all the way.

I'm almost there. As you can see from the attachment below, linux gets
loaded, the root filesystem gets mounted via nfs, and then I get some error
messages. Maybe I could get on the right track if someone would be kind
enough to given me a hint on the following:

(1) modprobe. The kernel I built is 2.4.20 and the directory in
    {/opt/eldk/ppc_4xx)/lib/modules is 2.4.4 .... hence the modprobe errors.
    Do I have to get this squared away before I get to a bash prompt, and if
    yes, how would I go about it?
      - Is there a "make modules, make modules install" step that I have to
        take ... similar to workstation (non-embedded) kernel re-builds.

(2) There is no {/opt/eldk/ppc_4xx}/etc/fstab file which seems to cause
    several errors towards the bottom of my boot log. Is there information
    somewhere on how '{/opt/eldk/ppc_4xx}/etc/fstab' is supposed to be
    setup, if at all?


I'm going to attached the boot log even though it gets kind of ugly at the
bottom ... that's where all the juicy stuff is. The end of the log is
basically where the boot sequence stops ... unless there's some loooong
timer that hasn't popped yet.

-- Brian

***************************************************************************
********************  kernel-boot-log *************************************
***************************************************************************
=> bootp
ENET Speed is 100 Mbps - HALF duplex connection
BOOTP broadcast 1
DHCP client bound to address 172.16.77.152
ARP broadcast 1
TFTP from server 172.16.77.151; our IP address is 172.16.77.152
Filename '/tftpboot/vmlinux.PPCBoot'.
Load address: 0x100000
Loading: #################################################################
         #################################################
done
Bytes transferred = 583425 (8e701 hex)
=> bootm
## Booting image at 00100000 ...
   Image Name:   Linux-2.4.20
   Created:      2003-02-02  12:23:34 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    583361 Bytes = 569.7 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Linux version 2.4.20 (root@ppc-dev.adic.com) (gcc version 2.95.4 20010319
(prerelease/franzo/20011204)) #1 Sun Feb 2 07:21:09 EST 2003
IBM Ebony port (C) 2002 MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Kernel command line: ip=on
Calibrating delay loop... 599.65 BogoMIPS
Memory: 127756k available (940k kernel code, 348k data, 212k init, 0k
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
/etc/rc.sysinit: /etc/sysconfig/network: Read-only file system
                Welcome to DENX Embedded Linux Environment
                Press 'I' to enter interactive startup.
Mounting proc filesystem:  [  OK  ]
Configuring kernel parameters:  [  OK  ]
Setting clock : Sat Jul  5 12:41:59 EDT 2031 [  OK  ]
/etc/rc.sysinit: /etc/fstab: Read-only file system
/etc/rc.sysinit: /etc/fstab: Read-only file system
Activating swap partitions:  swapon: cannot open /etc/fstab: No such file or
directory
[FAILED]
Setting hostname ebony1-linux-iSCSI:  [  OK  ]
modprobe: Can't open dependencies file /lib/modules/2.4.20/modules.dep (No
such file or directory)
grep: /etc/fstab: No such file or directory
/etc/rc.sysinit: /etc/mtab: Read-only file system
can't create lock file /etc/mtab~55: Read-only file system (use -n flag to
override)
can't create lock file /etc/mtab~56: Read-only file system (use -n flag to
override)
Finding module dependencies:  depmod: Can't open
/lib/modules/2.4.20/modules.dep for writing
[FAILED]
Checking filesystems
WARNING: couldn't open /etc/fstab: No such file or directory
[  OK  ]
Mounting local filesystems:  can't create lock file /etc/mtab~81: Read-only
file system (use -n flag to override)
[FAILED]
rm: cannot unlink `/var/run/utmp': Read-only file system
/etc/rc.sysinit: /var/run/utmp: Read-only file system
touch: creating `/var/log/wtmp': Read-only file system
      chgrp: changing group of `/var/run/utmp': Read-only file system
       chgrp: changing group of `/var/log/wtmp': Read-only file system
        chmod: changing permissions of `/var/log/wtmp': Read-only file
system
         swapon: cannot open /etc/fstab: No such file or directory
Enabling swap space:  [  OK  ]
/etc/rc.sysinit: /var/log/dmesg: Read-only file system
/etc/rc.sysinit: /var/log/ksyms.0: Read-only file system
touch: creating `/.autofsck': Read-only file system
INIT: Entering runlevel: 3
/etc/rc.d/rc: /var/run/runlevel.dir: Read-only file system
Starting system logger:


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
