Message-Id: <5.1.0.14.0.20020718123424.00a88c50@pop1.mail.com>
Date: Thu, 18 Jul 2002 12:36:55 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Mark Chambers <markc@mail.com>
Subject: porting problem
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've ported 2.4.7 to our custom MPC860 board and gotten to the 90% point,
and I've lost traction. I've pasted below the screendump of a bug that I
can reproduce at will. I would appreciate any tips on how to proceed. He's
what I've found:

Address c00ba024 is in dev_watchdog() in /net/sched/sch_generic.c,
source line 29 if (dev_qdisc != &noop_qdisc) {
which is assembly: l r0,184(r31)
and r31 is -1 as you can see.

going up the stack trace, c00b9f50 is in qdisc_restart(), source line 95 of
sch_generic.c,
if (dev->hard_start_xmit(skb,dev) == 0) {

so where did dev_watchdog() get called from? I would have expected it from
run_timer_list() but then why not in lr? I'm lost.


loaded at: 00400000 0040B234
board data at: 004001BC 00400210
relocated to: 00200100 00200154
zimage at: 0040B234 0049266A
initrd at: 0049266A 005DE6C4
avail ram: 005DF000 04000000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.4.7 (mark@RedHatLinux) (gcc version 2.95.3 20010111
(prerelease/
franzo/20010111)) #123 Wed Jul 17 19:24:49 EDT 2002
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line:
Decrementer Frequency = 184320000/60
Calibrating delay loop... 48.33 BogoMIPS
Memory: 61576k available (1024k kernel code, 384k data, 52k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
devfs: v0.107 (20010709) Richard Gooch (rgooch@atnf.csiro.au)
devfs: devfs_debug: 0x0
devfs: boot_options: 0x2
CPM UART driver version 0.03
devfs: devfs_register(): device already registered: "ttyS"
devfs: devfs_register(): device already registered: "ttyS"
devfs: devfs_register(): device already registered: "cua"
devfs: devfs_register(): device already registered: "cua"
ttyS00 at 0x0280 is a SMC
ttyS01 at 0x0100 is a SCC
ttyS02 at 0x0200 is a SCC
block: queued sectors max/low 40813kB/13604kB, 128 slots per queue
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
hda: IBM-DKLA-23240, ATA DISK drive
ide0 at 0x000-0x007,0x10019 on irq 6
hda: 6354432 sectors (3253 MB) w/460KiB Cache, CHS=6304/16/63
Partition check:
/dev/ide/host0/bus0/target0/lun0: p1
eth0: FEC ENET Version 0.2, FEC irq 9, addr 00:d0:87:00:00:01
eth0: Phy @ 0x0, type LXT970 (0x78100003)
loop: loaded (max 8 devices)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1328k freed
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
Íinit started: BusyBox v0.60.2 (2002.03.02-02:12+0000) mul
ti-call Remounting the root filesystem read-write.
Mounting local file systems...
not mounted anything
Initializing random number generator... done.

Please press Enter to activate this console.
sh-2.05# ifconfig eth0 192.168.1.4
eth0: config: auto-negotiation on, 100FDX, 100HDX, 10FDX, 10HDX.
sh-2.05# ping 192.168.1.6
PING 192.168.1.6 (192.168.1.6): 56 data bytes
64 bytes from 192.168.1.6: icmp_seq=0 ttl=255 time=3.9 ms
64 bytes from 192.168.1.6: icmp_seq=1 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=2 ttl=255 time=1.4 ms
64 bytes from 192.168.1.6: icmp_seq=3 ttl=255 time=1.4 ms
64 bytes from 192.168.1.6: icmp_seq=4 ttl=255 time=1.4 ms
64 bytes from 192.168.1.6: icmp_seq=5 ttl=255 time=1.4 ms
64 bytes from 192.168.1.6: icmp_seq=6 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=7 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=8 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=9 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=10 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=11 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=12 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=13 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=14 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=15 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=16 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=17 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=18 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=19 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=20 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=21 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=22 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=23 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=24 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=25 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=26 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=27 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=28 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=29 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=30 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=31 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=32 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=33 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=34 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=35 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=36 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=37 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=38 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=39 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=40 ttl=255 time=1.4 ms
64 bytes from 192.168.1.6: icmp_seq=41 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=42 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=43 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=44 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=45 ttl=255 time=1.4 ms
64 bytes from 192.168.1.6: icmp_seq=46 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=47 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=48 ttl=255 time=1.5 ms
64 bytes from 192.168.1.6: icmp_seq=49 ttl=255 time=1.5 ms
Oops: kernel access of bad area, sig: 11
NIP: C00BA024 XER: 00000000 LR: C00B9F50 SP: C3BAFC70 REGS: c3bafbc0 TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 000000B7, DSISR: 0000001F
TASK = c3bae000[25] 'ping' Last syscall: 102
last math 00000000 last altivec 00000000
GPR00: C00B44A4 C3BAFC70 C3BAE000 FFFFFFFF 00000007 0000000F C02B1C67 00000000
GPR08: C02B1B60 FFFFFFFF C0150000 01000000 00010800 1001B6E0 00000000 00000000
GPR16: 10010000 10010000 10010000 10010000 00009032 03BAFF40 00000000 C00029BC
GPR24: C00DD6D8 C3BAFD68 C3B3F0B0 0000000E C0150000 C0402090 C02B1B60 FFFFFFFF
Call backtrace:
C00B9F50 C00B44A4 C00B8EE0 C00C2200 C00C2F5C C00DDA44 C00E55B8
C00ACA54 C00ADA10 C00AE2FC C000277C 0000057A 00000221 100015F8
7FFFFBC8 00000605 10001540 0FF0A298 00000000
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
Rebooting in 180 seconds..


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
