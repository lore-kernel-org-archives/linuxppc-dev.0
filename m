Date: Thu, 6 May 2004 09:13:07 +0900 (KST)
From: =?EUC-KR?B?wOXH/L/t?= <jazz0719@dreamwiz.com>
Subject: [Q]Ethernet problem on Walnut ref board(PPC405GP) using Kernel 2.6     
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <20040506001307.0000976E029002F4@mail0.dreamwiz.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I got problems to activate ethernet on Walnut ref board(PPC405GP) using Linux kernel v. 2.6.x

In linuxppc_2_4_devel(http://www.denx.de) environment, it works fine and
the ethernet is recognized from menuconfig setting below.
Network device support --->
  On-chip net devices --->
    [*] IBM on-chip ethernet (which is ported by montavista)
the source directory is drivers/net/ibm_emac/*

BUT in linux kernel 2.6.5, there is no source included(drivers/net/ibm_emac) and
no menuconfig option to select '[*] IBM on-chip ethernet '

Is there other way to activate ethernet on Walnut without using the above setting in v.2.4
Do I have to any extra work to make the ethernet be working in kernel 2.6 ?? please help me...

Thanks in advance.

booting messages is as follows...

*** kernel v.2.6.5 ***
Linux version 2.6.5 (root@hwjang) (gcc version 3.2.2 20030217 (Yellow Dog Linux 3.0 3.2.2-2a_1)) #2 Fri Apr 23 17:26:58 KST 2004
IBM Walnut port (C) 2000-2002 MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 8192
  DMA zone: 8192 pages, LIFO batch:2
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: root=/dev/nfs rw ip=192.168.1.200:192.168.1.210:192.168.1.1:255.255.255.0::eth0:off nfsroot=192.168.1.210:/root/Work0PID hash table entries: 256 (order 8: 2048 bytes)
Memory: 30672k available (1264k kernel code, 344k data, 88k init, 0k highmem)
Calibrating delay loop... 199.16 BogoMIPS
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: Probing PCI hardware
Serial: 8250/16550 driver $Revision: 1.90 $ 6 ports, IRQ sharing disabled
ttyS0 at MMIO 0x0 (irq = 0) is a 16550A
ttyS1 at MMIO 0x0 (irq = 1) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 5120K size 1024 blocksize
loop: loaded (max 8 devices)
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
NET: Registered protocol family 1
IP-Config: Device `eth0' not found.
Looking up port of RPC 100003/2 on 192.168.1.210
RPC: sendmsg returned error 101
portmap: RPC call returned error 101
Root-NFS: Unable to get nfsd port number from server, using default
Looking up port of RPC 100005/1 on 192.168.1.210
RPC: sendmsg returned error 101
portmap: RPC call returned error 101
Root-NFS: Unable to get mountd port number from server, using default
RPC: sendmsg returned error 101
mount: RPC call returned error 101
Root-NFS: Server returned error -101 while mounting /root/Work/poswatch_linux/toolchain_ppc/eldk_3.0/ppc_4xx
hwjang : mount_root() 4
VFS: Unable to mount root fs via NFS, trying floppy.
hwjang : mount_root() 6
hwjang : mount_root() 7
Oops: kernel access of bad area, sig: 11 [#1]
NIP: 00000000 LR: C0182EB4 SP: C021DF40 REGS: c021de90 TRAP: 0401 Not tainted
MSR: 00029230 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c1feb8d0[1] 'swapper' Last syscall: 120
PLB0: bear= 0x00004000 acr= 0x00000000 besr= 0x00000000
PLB0 to OPB: bear= 0x02300010 besr0= 0x00000000 besr1= 0x00000000
GPR00: C0182E98 C021DF40 C1FEB8D0 C013C334 00003EAB C0146D3A C021DEE0 0000000A
GPR08: 00000000 00000000 FFFFFFFF 00000000 24004022
Call trace: [c01832f4] [c01833b0] [c000243c] [c00093b8]
Kernel panic: Attempted to kill init!
 <0>Rebooting in 180 seconds..


*** kernel.v.2.4 ***
Linux version 2.4.18_mvl30-walnut (root@hwjang) (gcc version 3.2.1 20020930 (MontaVista)) #17 Fri Jan 9 18:15:08 KST 2004
IBM Walnut (IBM405GP) Platform
Port by MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw ip=192.168.1.200:192.168.1.210:192.168.1.1:255.255.255.0::eth0:off nfsroot=192.168.1.210:/root/Work0Calibrating delay loop... 199.88 BogoMIPS
Memory: 30612k available (1120k kernel code, 420k data, 76k init, 0k highmem)
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
OCP uart ver 1.2 init complete
Starting kswapd
Disabling the Out Of Memory Killer
i2c-core.o: i2c core module version 2.6.2 (20011118)
initialize_kbd: Keyboard reset failed, no ACK
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0xef600300 (irq = 0) is a 16550A
ttyS01 at 0xef600400 (irq = 1) is a 16550A
block: 64 slots per queue, batch=16
RAMDISK driver initialized: 16 RAM disks of 5120K size 1024 blocksize
loop: loaded (max 8 devices)
eth0: Phy @ 0x1, type DP83843 (0x20005c10)
Reset ethernet interfaces
SCSI subsystem driver Revision: 1.00
qlogicisp : PCI not present
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
opening eth0 on emac 0
eth0: IBM EMAC: link up, 10 Mbps Half Duplex, auto-negotiation complete.
eth0: IBM EMAC: MAC 00:04:ac:e3:12:24.
eth0: IBM EMAC: open completed
IP-Config: Complete:
      device=eth0, addr=192.168.1.200, mask=255.255.255.0, gw=192.168.1.1,
     host=192.168.1.200, domain=, nis-domain=(none),
     bootserver=192.168.1.210, rootserver=192.168.1.210, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.1.210
Looking up port of RPC 100005/1 on 192.168.1.210


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
