Message-ID: <9CFB9DA5261CD611A29B00508B7890480B842F73@ex-deu-munich02.force.de>
From: "Demke, Torsten" <Torsten.Demke@fci.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: dma_alloc_init badness ??
Date: Tue, 20 Jul 2004 13:26:29 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

Im currently porting our application from 2.4.22 to 2.6.
CPU is MPC852T and the bootloader is u-boot.

The kernel boot prints a warning in dma_alloc_init,
but Im not sure what that exactly means, and how to solve
the problem:(
Can anybody here please give me some help?

Here is the output:
...
Linux version 2.6.8-rc1 (root@shepard) (gcc version 3.3.4 (Debian)) #2 Tue
Jul 20 12:33:08 CEST 2004
SMC1 uCode patch installed
SMC1 relocated to 0x1fc0
On node 0 totalpages: 16384
  DMA zone: 16384 pages, LIFO batch:4
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: console=ttyS1,38400 root=/dev/nfs rw
nfsroot=192.168.111.21:/opt/eldk/ppc_8xx
ip=192.168.111.117:192.168.111.23:192.168.111.184:255.255.255.0:ShMC:eth0:of
f
PID hash table entries: 512 (order 9: 4096 bytes)
Decrementer Frequency = 187500000/60
Warning: real time clock seems stuck!
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 62208k available (1872k kernel code, 584k data, 76k init, 0k
highmem)
Calibrating delay loop... 48.12 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Badness in dma_alloc_init at arch/ppc/kernel/dma-mapping.c:342   <<<<<<<<<<<
?????????
Call trace:
 [c0009880] dump_stack+0x18/0x28
 [c0006d58] check_bug_trap+0x84/0xac
 [c0006ec4] ProgramCheckException+0x144/0x194
 [c00065f0] ret_from_except_full+0x0/0x4c
 [c025370c] dma_alloc_init+0x44/0xa0
 [c02507ac] do_initcalls+0x54/0xfc
 [c0002220] init+0x2c/0xf4
 [c0009098] kernel_thread+0x44/0x60
NET: Registered protocol family 16
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
JFFS2 version 2.2. (C) 2001-2003 Red Hat, Inc.
udf: registering filesystem
Initializing Cryptographic API
ipmi message handler version v32
ipmi device interface version v32
IPMI System Interface driver version v32, KCS version v32, SMIC version v32,
BT version v32
ipmi_si: Trying "bt" at memory address 0x8000000
 IPMI bt interface initialized
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at MMIO 0x8008000 (irq = 12) is a ST16654
ttyS1 at MMIO 0x8010000 (irq = 4) is a ST16654
Serial: CPM driver $Revision: 0.01 $
ttyCPM0 at MMIO 0xff000a00 (irq = 46) is a CPM UART
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
loop: loaded (max 8 devices)
Using anticipatory io scheduler
28F256K3 UserFlash: Found 1 x16 devices at 0x0 in 16-bit bank
 Intel/Sharp Extended Query Table at 0x0031
cfi_cmdset_0001: Erase suspend on write enabled
Using buffer write method
Creating 5 MTD partitions on "28F256K3 UserFlash":
0x00000000-0x00060000 : "U-boot image"
0x00060000-0x00080000 : "U-boot Environment Variables"
0x00080000-0x00280000 : "Kernel Image"
0x00280000-0x00c80000 : "Initial ramdisk image"
0x00c80000-0x02000000 : "JFFS2 partition"
mice: PS/2 mouse device common for all mice
eth0: FEC ENET Version 0.2, FEC irq 3, MII irq 6, addr 00:80:42:13:b7:ef
eth0: Detecting Phy devices
eth0: Phy[0] @ 0x1, type LXT971 (0x001378e2)
eth0: Phy[16] @ 0x11, type BCM5222 (0x00406322)
eth0: Phy[17] @ 0x12, type BCM5222 (0x00406322)
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
NET: Registered protocol family 17
IP-Config: Complete:
      device=eth0, addr=192.168.111.117, mask=255.255.255.0,
gw=192.168.111.184,
     host=ShMC, domain=, nis-domain=(none),
     bootserver=192.168.111.23, rootserver=192.168.111.21, rootpath=
Looking up port of RPC 100003/2 on 192.168.111.21
eth0: status: link up, 100 Mbps Half Duplex, auto-negotiation complete.
Looking up port of RPC 100005/1 on 192.168.111.21
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 76k init


Thanks for your help.

Torsten

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
