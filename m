Message-ID: <903E17B6FF22A24C96B4E28C2C0214D7012BB2F7@sr-bng-exc01.int.tsbu.net>
From: "Karoliya, Abhishek" <Abhishek.Karoliya@fci.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: 2.4.18mvl30 & 1 GB Board
Date: Fri, 31 Oct 2003 22:44:00 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

   I am trying to bring up Linux {2.4.18 from MontaVista PE3.0 } on a 1GB of
SDRAM board having 7447+MV64360 combination.
With No high mem enabled in the kernel, it just hangs at saying freeing
unused kernel memory . {Attached the dump and also bdi output when it
freezes}

Enabling high mem support also yields similar results.

However when the same board is configured as 512 MB by firmware {a
proprietary one}, Linux comes properly to prompt.
Shouldn't the board boot above in 1GB configuration properly with just 768
MB of memory?
My ultimate aim is to make the entire 1GB of memory useable , so I chose
this as the first step to that end.

Please provide some pointers in this direction.

Thanks a lot
Abhishek

********** Kernel Dump **********
                            Memory BAT mapping: BAT2=256Mb, BAT3=256Mb,
residual
: 512Mb
Warning, memory limited to 768 Mb, use CONFIG_HIGHMEM to reach 1024 Mb
Total memory = 768MB; using 2048kB for hash table (at c0200000)
Linux version 2.4.18_mvl30 (abhishek@idc_linux_bld01.in.fci.com) (gcc
version 3.
2.1 20020930 (MontaVista)) #7 Fri Oct 31 20:11:06 IST 2003
Force PPMC280 Development Board
On node 0 totalpages: 196608
zone(0): 196608 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,115200 root=/dev/ram
mtdparts=0:3072k(kernel)
,22528k(Ramdisk),39680k(JFFS2)
time_init: decrementer frequency = 33.250000 MHz
Calibrating delay loop... 663.55 BogoMIPS
Memory: 750264k available (992k kernel code, 408k data, 176k init, 0k
highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 2 of device 00:00.0
PCI: Cannot allocate resource region 4 of device 00:00.0
PCI: Cannot allocate resource region 4 of device 00:00.1
PCI: Cannot allocate resource region 0 of device 00:00.2
PCI: Cannot allocate resource region 2 of device 00:00.2
PCI: Cannot allocate resource region 4 of device 00:00.3
PCI: Cannot allocate resource region 5 of device 00:00.4
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Disabling the Out Of Memory Killer
i2c-core.o: i2c core module version 2.6.2 (20011118)
pty: 256 Unix98 ptys configured
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 131072K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 4.3.2-k1
Copyright (c) 1999-2002 Intel Corporation.
i2c-algo-mv64360: I2C MV64360 Module
AT24C64 EEPROM detected.
Intializing AT24CXX eeprom driver.
Initializing MAX9600 RTC driver.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 20198k freed
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 176k init

<<<<  just hangs here  >>>>>>>>

*********BDI Dump when it hangs *********

BDI>halt
    Target CPU        : MPC7457 Rev.1
    Target state      : debug mode
    Debug entry cause : instruction address breakpoint
    Current PC        : 0xfffffffc
    Current CR        : 0xffffffff
    Current MSR       : 0xffffffbf
    Current LR        : 0xffffffff
BDI>r
GPR00: 00000000 7ffffc30 00000000 00000000
GPR04: 00000000 00000000 30026940 300030a8
GPR08: 7ffffc50 00000000 00000000 00000000
GPR12: 20000000 00000000 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000
GPR20: 00000000 7ffffee0 7ffffe68 7ffffe6c
GPR24: 7ffffe70 7ffffc38 00000000 00000000
GPR28: 7ffffc38 00000000 30026940 00000000
CR   : ffffffff     MSR: ffffffbf
BDI>t
    Target CPU        : MPC7457 Rev.1
    Target state      : debug mode
    Debug entry cause : trace
    Current PC        : 0xfffffffc
    Current CR        : 0xffffffff
    Current MSR       : 0xffffffbf
    Current LR        : 0xfffffffc
BDI>t
    Target CPU        : MPC7457 Rev.1
    Target state      : debug mode
    Debug entry cause : program exception
    Current PC        : 0xfffffffc
    Current CR        : 0xffffffff
    Current MSR       : 0xffffffbf
    Current LR        : 0xfffffffc
# Step timeout detected
BDI>t
    Target CPU        : MPC7457 Rev.1
    Target state      : debug mode
    Debug entry cause : COP freeze (startup)
    Current PC        : 0xfffffffc
    Current CR        : 0xffffffff
    Current MSR       : 0xffffffbf
    Current LR        : 0xfffffffc
# Step timeout detected
BDI>t
    Target CPU        : MPC7457 Rev.1
    Target state      : debug mode
    Debug entry cause : COP freeze (startup)
    Current PC        : 0xfffffffc
    Current CR        : 0xffffffff
    Current MSR       : 0xffffffbf
    Current LR        : 0xfffffffc
# Step timeout detected
BDI>go
BDI>halt
    Target CPU        : MPC7457 Rev.1
    Target state      : debug mode
    Debug entry cause : COP freeze (startup)
    Current PC        : 0xfffffffc
    Current CR        : 0xffffffff
    Current MSR       : 0xffffffbf
    Current LR        : 0xfffffffc


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
