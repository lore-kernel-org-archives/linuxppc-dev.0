Return-Path: <sojkam1@fel.cvut.cz>
Received: from smtpx.feld.cvut.cz (smtpx.feld.cvut.cz [147.32.192.33])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xpWYz03QqzDrbN
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 19:03:02 +1000 (AEST)
From: Michal Sojka <sojkam1@fel.cvut.cz>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Unable to handle kernel paging request for unaligned access
Date: Fri, 08 Sep 2017 10:55:46 +0200
Message-ID: <877ex9lgbx.fsf@steelpick.2x.cz>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

commit 31bfdb036f12 ("powerpc: Use instruction emulation infrastructure
to handle alignment faults", 2017-08-30) breaks my MPC5200B system. Boot
log is below. Let me know if you need more information to debug the
problem.

Best regards,
-Michal Sojka


Linux version 4.13.0-rc2+ (wsh@steelpick) (gcc version 4.7.2 (OSELAS.Toolchain-2012.12.1)) #33 Fri Sep 8 09:36:26 CEST 2017
Found initrd at 0xc7c38000:0xc7e5f499
Using mpc5200-simple-platform machine description
-----------------------------------------------------
Hash_size         = 0x0
phys_mem_size     = 0x8000000
dcache_bsize      = 0x20
icache_bsize      = 0x20
cpu_features      = 0x0000000000020460
  possible        = 0x0000000005a6fd77
  always          = 0x0000000000020000
cpu_user_features = 0x8c000000 0x00000000
mmu_features      = 0x00010000
-----------------------------------------------------
PCI host bridge /pci@f0000d00 (primary) ranges:
 MEM 0x0000000080000000..0x000000009fffffff -> 0x0000000080000000 Prefetch
 MEM 0x00000000a0000000..0x00000000afffffff -> 0x00000000a0000000 
  IO 0x00000000b0000000..0x00000000b0ffffff -> 0x0000000000000000
Zone ranges:
  DMA      [mem 0x0000000000000000-0x0000000007ffffff]
  Normal   empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000000000-0x0000000007ffffff]
Initmem setup node 0 [mem 0x0000000000000000-0x0000000007ffffff]
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
Kernel command line: console=ttyPSC0,115200
PID hash table entries: 512 (order: -1, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 125136K/131072K available (1924K kernel code, 88K rwdata, 188K rodata, 108K init, 187K bss, 5936K reserved, 0K cma-reserved)
Kernel virtual memory layout:
  * 0xfffdf000..0xfffff000  : fixmap
  * 0xfcffb000..0xfe000000  : early ioremap
  * 0xc9000000..0xfcffb000  : vmalloc & ioremap
SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS: 512, nr_irqs: 512, preallocated irqs: 16
MPC52xx PIC is up and running!
clocksource: timebase: mask: 0xffffffffffffffff max_cycles: 0x79c5e18f3, max_idle_ns: 440795202740 ns
clocksource: timebase mult[1e4d9365] shift[24] registered
console [ttyPSC0] enabled
pid_max: default: 4096 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
random: get_random_u32 called from 0xc00d06f4 with crng_init=0
NET: Registered protocol family 16
mpc52xx_irqhost_map: Critical IRQ #3 is unsupported! Nopping it.
PCI: Probing PCI hardware
PCI host bridge to bus 0100:00
pci_bus 0100:00: root bus resource [io  0x0000-0xffffff]
pci_bus 0100:00: root bus resource [mem 0x80000000-0x9fffffff pref]
pci_bus 0100:00: root bus resource [mem 0xa0000000-0xafffffff]
pci_bus 0100:00: root bus resource [bus 00-ff]
DMA: MPC52xx BestComm driver
Unable to handle kernel paging request for unaligned access at address 0xc9018020
Faulting instruction address: 0xc0013a38
Oops: Kernel access of bad area, sig: 7 [#1]
BE mpc5200-simple-platform
CPU: 0 PID: 1 Comm: swapper Not tainted 4.13.0-rc2+ #33
task: c781c000 task.stack: c7820000
NIP:  c0013a38 LR: c00f5d70 CTR: 0000000f
REGS: c7821ce0 TRAP: 0600   Not tainted  (4.13.0-rc2+)
MSR:  00009032 <EE,ME,IR,DR,RI>  CR: 48000088  XER: 2000005f
DAR: c9018020 DSISR: 00017c07 
GPR00: 00000007 c7821d90 c781c000 c9018000 00000000 00000200 c901801c 00000004 
GPR08: 00000200 0000000f 00000700 c9018000 24000044 00000000 c00043c8 00000000 
GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000001c 
GPR24: c0240000 00000000 00000000 c0230f10 c01f2808 00000000 c0240000 c78035a0 
Call Trace:
[c7821d90] [c00f5d2c] 0xc00f5d2c (unreliable)
[c7821de0] [c01111d8] 0xc01111d8
[c7821df0] [c010ff48] 0xc010ff48
[c7821e20] [c0110074] 0xc0110074
[c7821e40] [c010e4a4] 0xc010e4a4
[c7821e70] [c010ecd8] 0xc010ecd8
[c7821e90] [c01107fc] 0xc01107fc
[c7821ea0] [c02119b0] 0xc02119b0
[c7821f00] [c0211b70] 0xc0211b70
[c7821f30] [c00043e0] 0xc00043e0
[c7821f40] [c000e2e4] 0xc000e2e4
--- interrupt: 0 at   (null)
    LR =   (null)
Instruction dump:
7d072a14 5509d97e 3529ffff 40810038 68e0001c 5400f0bf 41820010 7c0903a6 
94860004 4200fffc 7d2903a6 38e00004 <7c0737ec> 38c60020 4200fff8 550506fe 
---[ end trace 1e206a9c64fbd101 ]---

Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000007

Rebooting in 180 seconds..
