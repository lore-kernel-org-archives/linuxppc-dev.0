Date: Tue, 12 Sep 2000 10:21:18 +0200 (CEST)
From: Tilmann Bitterberg <tibit-ibm@bitterberg.de>
To: Paul Mackerras <paulus@linuxcare.com.au>
cc: Linuxppc Development Mailing List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_HIGHMEM problems
In-Reply-To: <14777.65296.649836.830091@argo.linuxcare.com.au>
Message-ID: <Pine.LNX.4.21.0009111414180.2121-100000@ford>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 9 Sep 2000, Paul Mackerras wrote:

> Well, we would need to know where the machine check happened,
> preferably with a stack trace.

Sorry for not contributing this information.

The "Machine check" doesn't throws me into xmon, so I placed an
xmon(0); in init/main.c just before execve("/sbin/init" ...

Everything looks ok there, but when I use the 's' command to go
to the next instruction I get the machine check:

/* with phys_mem.regions[0].size = real_ram, total = real_ram */
Machine check in kernel mode.
Caused by (from SRR1=81032): Machine check signal
NIP: C0010E70 XER: 00000000 LR: C0033B00 REGS: c01a8cf0 TRAP: 0200
MSR: 00081032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c01a6ff0[0] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: 00000000 C01A8DA0 C01A6FF0 FE400000 C020C07C 00001000 FE40007C 10000000
GPR08: 10000000 00000385 00001032 C0210000 24000029 00000000 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 00001032 001A8ED0 00001032 C0004C6C
GPR24: 00000001 C0650498 00000001 00000001 C0350C00 FE400000 C0350B80 C29FFFC0
Call backtrace:
C00E32B8 C00E31F0 C00E34C0 C00CBF7C C00E5978 C00DBA50 C0005AD8
C0005C28 C0004C6C C0006120 C0006134 C01CA788 00003904
Kernel panic: machine check
In interrupt handler - not syncing
Rebooting in 180 seconds..RTAS system-reboot returned -1

The bootlog: (long lines  wrapped)

instantiating rtas at 00600000 ... done
opening display /pci@fee00000/display@b... ok
copying OF device tree...done
returning 01400000  from prom_init
I have found 2048MB RAM
 Total memory = 640MB; using 2048kB for hash table (at c0800000)
mapin_ram: mem_base is at (0)
mapin_ram: max_size is at (268435456)
mapin_ram: total_lowmem is at (671088640)
Linux version 2.4.0-test8 (root@karl.de.ibm.com) (gcc version 2.95.2)
Boot arguments: root=/dev/sda2 mem=2048M console=tty0
OpenPIC addrs: ffc00000 feff7c00 feef7c00
RTAS Event Scan Rate: 1 (2999 jiffies)
On node 0 totalpages: 524288
zone(0): 163840 pages.
zone(1): 0 pages.
zone(2): 360448 pages.
Kernel command line: root=/dev/sda2 mem=2048M console=tty0
OpenPIC Version 1.2 (8 CPUs and 1 IRQ sources) at ffc00000
OpenPIC timer frequency is not set
time_init: decrementer frequency = 100.004177 MHz
Console: colour dummy device 80x25
Calibrating delay loop... 799.54 BogoMIPS
Memory: 2058760k available (1376k kernel code, 864k data, 244k init, \
                 1441792k highmem)
Dentry-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Buffer-cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
POSIX conformance testing by UNIFIX
....
Macintosh non-volatile memory driver v1.0
mice: PS/2 mouse device common for all mice
kmem_create: Forcing size word alignment - nfs_fh
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 244k init 32k prep 16k pmac
Mem-info:
Free pages:      2050880kB (1441792kB HighMem)
( Free: 512720, lru_cache: 4 (256 512 768) )
   00 DMA: 2*4kB 3*8kB 2*16kB 0*32kB 2*64kB 1*128kB 0*256kB \
            1*512kB 0*1024kB 297*2048kB = 609088k)
  L00 Normal: = 0kB)
   00 HighMem: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB\
                   0*512kB 0*1024kB 704*2048kB = 144)
Swap cache: add 0, delete 0, find 0/0
Free swap:            0kB
524288 pages of RAM
360448 pages of HIGHMEM
514571 free pages
9525 reserved pages
0 pages shared
0 pages swap cached
0 pages in page table cache
Buffer memory:       16kB
Process  Pid      Ctx   Ctx<<4 Last Sys        pc     task
swapper    1        0        0      120 ?00000000 c2a1c000 current
kswapd     2        0        0       -1 ?00000000 c067c000
kflushd    3        0        0       -1 ?00000000 c067a000
kupdate    4        0        0       -1 ?00000000 c0678000
vector: 0 at pc = c0003ad8, lr = c0003ad8, msr = 9032, sp = c2a1df30 [c2a1de78]
current = c2a1c000, pid = 1, comm = swapper
mon> s

Tilmann
--
/usr/games/fortune: No such file or directory


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
