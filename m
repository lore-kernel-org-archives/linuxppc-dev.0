Return-Path: <a.gusev1980@mail.ru>
Received: from mx28.mail.ru (mx28.mail.ru [94.100.176.42])
	by ozlabs.org (Postfix) with ESMTP id E84FDDE0D2
	for <linuxppc-dev@ozlabs.org>; Sat, 16 May 2009 06:45:43 +1000 (EST)
Received: from mx38.mail.ru (mx38.mail.ru [94.100.176.52])
	by mx28.mail.ru (mPOP.Fallback_MX) with ESMTP id 6FCEC77690B
	for <linuxppc-dev@ozlabs.org>; Sat, 16 May 2009 00:40:18 +0400 (MSD)
Date: Sat, 16 May 2009 00:40:07 +0400
From: Andrey Gusev <a.gusev1980@mail.ru>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Delay on intialization ide subsystem(most likely)
Message-ID: <20090516004007.3a7b9787@power-debian>
In-Reply-To: <200905132046.33663.bzolnier@gmail.com>
References: <20090425170203.74603b9c@power-debian>
	<200905131528.26940.bzolnier@gmail.com>
	<20090513211123.24825895@power-debian>
	<200905132046.33663.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-ide@vger.kernel.org, petkovbb@gmail.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 13 May 2009 20:46:33 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> On Wednesday 13 May 2009 19:11:23 Andrey Gusev wrote:
> > On Wed, 13 May 2009 15:28:26 +0200
> > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > 
> > > On Tuesday 12 May 2009 21:50:24 Andrey Gusev wrote:
> > > > On Mon, 27 Apr 2009 23:21:48 +0200
> > > > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > > > 
> > > > > On Monday 27 April 2009 22:36:45 Andrey Gusev wrote:
> > > > > > On Sat, 25 Apr 2009 16:48:38 +0200
> > > > > > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > > > > > 
> > > > > > > 
> > > > > > > Hi,
> > > > > > > 
> > > > > > > On Saturday 25 April 2009 15:02:03 Andrey Gusev wrote:
> > > > > > > > Hello!
> > > > > > > > 
> > > > > > > > I have tested linux-2.6.30-rc3 on my system and find
> > > > > > > > some problems. One of them is delaying on
> > > > > > > > initialization IDE subsystem. I don't have this problem
> > > > > > > > on 2.6.29.1. The difference is looked on log of dmesg.
> > > > > > > 
> > > > > > > Unfortunately this doesn't give us any hint about the root
> > > > > > > cause of the bug so please try narrowing the problem down
> > > > > > > to the specific change using git-bisect (sorry, there
> > > > > > > were 212 drivers/ide/ commits during v2.6.29..v2.6.30-rc3
> > > > > > > and much much more non-drivers/ide/ ones).
> > > > > > > 
> > > > > > > Thanks,
> > > > > > > Bart
> > > > > > > 
> > > > > > 
> > > > > > Hello!
> > > > > > 
> > > > > > 
> > > > > > The full result of bisect is:
> > > > > > 
> > > > > > 
> > > > > > git bisect start
> > > > > > # good: [8e0ee43bc2c3e19db56a4adaa9a9b04ce885cd84] Linux
> > > > > > 2.6.29 git bisect good
> > > > > > 8e0ee43bc2c3e19db56a4adaa9a9b04ce885cd84 # bad:
> > > > > > [091069740304c979f957ceacec39c461d0192158] Linux 2.6.30-rc3
> > > > > > git bisect bad 091069740304c979f957ceacec39c461d0192158 #
> > > > > > good: [40f07111be99b71c1e8d40c13cdc38445add787f] V4L/DVB
> > > > > > (11166): pvrusb2: Implement status fetching from
> > > > > > sub-devices git bisect good
> > > > > > 40f07111be99b71c1e8d40c13cdc38445add787f # good:
> > > > > > [ba0e1ebb7ea0616eebc29d2077355bacea62a9d8] Staging: sxg:
> > > > > > slicoss: Specify the license for Sahara SXG and Slicoss
> > > > > > drivers git bisect good
> > > > > > ba0e1ebb7ea0616eebc29d2077355bacea62a9d8
> > > > > > 
> > > > > > 
> > > > > > git bisect start 'drivers/ide/'
> > > > > 
> > > > > Please note that limiting search space to drivers/ide/ may not
> > > > > give reliable results in case problem was introduced by some
> > > > > other kernel area.
> > > > > 
> > > > > > # good: [ba0e1ebb7ea0616eebc29d2077355bacea62a9d8] Staging:
> > > > > > sxg: slicoss: Specify the license for Sahara SXG and
> > > > > > Slicoss drivers git bisect good
> > > > > > ba0e1ebb7ea0616eebc29d2077355bacea62a9d8 # bad:
> > > > > > [091069740304c979f957ceacec39c461d0192158] Linux 2.6.30-rc3
> > > > > > git bisect bad 091069740304c979f957ceacec39c461d0192158 #
> > > > > > good: [e01f251fd09fa7cb3d352eac7de17bb5d5bd1f9d] ide-cd:
> > > > > > convert cdrom_decode_status() to use switch statements git
> > > > > > bisect good e01f251fd09fa7cb3d352eac7de17bb5d5bd1f9d #
> > > > > > good: [3153c26b54230d025c6d536e8d3015def4524906] ide:
> > > > > > refactor tf_read() method git bisect good
> > > > > > 3153c26b54230d025c6d536e8d3015def4524906 # good:
> > > > > > [c018f1ee5cf81e58b93d9e93a2ee39cad13dc1ac] hpt366: fix
> > > > > > HPT370 DMA timeouts git bisect good
> > > > > > c018f1ee5cf81e58b93d9e93a2ee39cad13dc1ac # bad:
> > > > > > [d5f840bf74c09ca5a31e518c9d984999926b5f44] ide: Remove void
> > > > > > casts git bisect bad
> > > > > > d5f840bf74c09ca5a31e518c9d984999926b5f44 # bad:
> > > > > > [59c8d04f5ee97ea46da854e9adbbaa45d988c39d] hpt366: use
> > > > > > ATA_DMA_* constants git bisect bad
> > > > > > 59c8d04f5ee97ea46da854e9adbbaa45d988c39d
> > > > > 
> > > > > Uhh.. something went wrong during bisect.
> > > > > 
> > > > > "hpt366: use ATA_DMA_* constants" cannot be a first bad commit
> > > > > because hpt366 is not even used on this system.
> > > > > 
> > > > > Could it be that the delay doesn't happen on every boot for
> > > > > "bad" kernels?
> > > > > 
> > > > > Also, is 2.6.30-rc1 okay?
> > > > > 
> > > > > Thanks,
> > > > > Bart
> > > > > 
> > > > 
> > > > Hello all!
> > > > 
> > > > I continue to find reason of bug. I made more testing with
> > > > bisect and got result:
> > > > 
> > > > git bisect start
> > > > # bad: [c018f1ee5cf81e58b93d9e93a2ee39cad13dc1ac] hpt366: fix
> > > > HPT370 DMA timeouts git bisect bad
> > > >  # good:
> > > > [fb4252e59452c18b88af014a2c4ee697bbf8cbc6] at91_ide: turn on
> > > > PIO 6 support git bisect good
> > > > fb4252e59452c18b88af014a2c4ee697bbf8cbc6 # good:
> > > > [2e1c63b7ed36532b68f0eddd6a184d7ba1013b89] Merge branch
> > > > 'for-rc1/xen/core' of
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/jeremy/xen git
> > > > bisect good 2e1c63b7ed36532b68f0eddd6a184d7ba1013b89 # bad:
> > > > [cd97824994042b809493807ea644ba26c0c23290] Merge
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6 git
> > > > bisect bad cd97824994042b809493807ea644ba26c0c23290 # bad:
> > > > [a2c252ebdeaab28c9b400570594d576dae295958] Merge
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-2.6-fixes
> > > > git bisect bad a2c252ebdeaab28c9b400570594d576dae295958 # good:
> > > > [b897e6fbc49dd84b2634bca664344d503b907ce9] Merge branch
> > > > 'drm-intel-next' of
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/anholt/drm-intel
> > > > git bisect good b897e6fbc49dd84b2634bca664344d503b907ce9 #
> > > > good: [dfbc4752eab33e66f113f9daa2effbe241cd661d] brd: support
> > > > barriers git bisect good
> > > > dfbc4752eab33e66f113f9daa2effbe241cd661d # good:
> > > > [a23c218bd36e11120daf18e00a91d5dc20e288e6] Merge branch 'merge'
> > > > of git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc
> > > > git bisect good a23c218bd36e11120daf18e00a91d5dc20e288e6 #
> > > > good: [23da64b4714812b66ecf010e7dfb3ed1bf2eda69] Merge branch
> > > > 'for-linus' of git://git.kernel.dk/linux-2.6-block git bisect
> > > > good 23da64b4714812b66ecf010e7dfb3ed1bf2eda69 # good:
> > > > [a228df6339e0d385b8149c860d81b6007f5e9c81] GFS2: Move umount
> > > > flush rwsem git bisect good
> > > > a228df6339e0d385b8149c860d81b6007f5e9c81 # skip:
> > > > [1328df725239804ae30fc7257c1a3185e679b517] GFS2: Use
> > > > DEFINE_SPINLOCK git bisect skip
> > > > 1328df725239804ae30fc7257c1a3185e679b517 # good:
> > > > [10d2198805d7faa2b193485446ff6b1de42c9b78] GFS2: cleanup
> > > > file_operations mess git bisect good
> > > > 10d2198805d7faa2b193485446ff6b1de42c9b78
> > > > 
> > > > As I understand, I found bad commit, but it includes 5 commits.
> > > > I checked them and they are good. So, I did git checkout
> > > > a2c252ebdeaab28c9b400570594d576dae295958 and test one more time
> > > > this commit. I found that bag is unstable. The boot can be bad
> > > > or good on this commit. I compared dmesg of 'bad' and 'good'
> > > > booting, but it is equal till delay. 
> > > 
> > > Thanks for doing it.
> > > 
> > > > Any suggestions?
> > > 
> > > Hard to tell...
> > > 
> > > I went through all commits in-between
> > > 
> > > 	fb4252e59452c18b88af014a2c4ee697bbf8cbc6
> > > 
> > > and
> > > 
> > > 	a2c252ebdeaab28c9b400570594d576dae295958
> > > 
> > > and there are no obvious candidates..
> > > 
> > > Could you please refresh my memory and tell me whether 2.6.30-rc2
> > > was OK?
> > > 
> > 
> > It was ok, but I don't sure now. I tested only one boot, but this
> > problem is not stable. I am rechecking it.
> 
> Ok.
> 
> Please also recheck first 'good' commit if 2.6.30-rc2 turns out to be
> 'bad'.

My last testing is very interesting. I check boot of each kernel at
least 10 times. I checked 2.6.30-rc2, it is good. Rest results:

git bisect start
# good: [0882e8dd3aad33eca41696d463bb896e6c8817eb] Linux 2.6.30-rc2
git bisect good 0882e8dd3aad33eca41696d463bb896e6c8817eb
# bad: [a2c252ebdeaab28c9b400570594d576dae295958] Merge
git://git.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-2.6-fixes git
bisect bad a2c252ebdeaab28c9b400570594d576dae295958 # good:
[c2572f2b4ffc27ba79211aceee3bef53a59bb5cd] brd: fix cacheflushing git
bisect good c2572f2b4ffc27ba79211aceee3bef53a59bb5cd # bad:
[b71a0c296cee4debaf446760fbd29ead1587a7ac] powerpc: pseries/dtl.c
should include asm/firmware.h git bisect bad
b71a0c296cee4debaf446760fbd29ead1587a7ac

Last commit had delay only on 10 time, but it ripped my system, I can't
read any place on my hard drive. I can't mount any other device on it.
Fortunately, I have tmpfs and I mounted second hard disk on it place.
After my computer didn't turn on. It looks like dead drive or
controller, but after on/off and replace disks, it has alived. Below
is log of this bad boot.
[    0.000000] Using PowerMac machine description
[    0.000000] Total memory = 1536MB; using 4096kB for hash table (at cfc00000)
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.29 (andrey@power-debian) (gcc version 4.3.3 (Debian 4.3.3-3) ) #22 SMP PREEMPT Thu May 14 03:38:55 MSD 2009
[    0.000000] Found initrd at 0xc1a00000:0xc1f18000
[    0.000000] Found UniNorth memory controller & host bridge @ 0xf8000000 revision: 0x24
[    0.000000] Mapped at 0xff7c0000
[    0.000000] Found a Keylargo mac-io controller, rev: 3, mapped at 0xff740000
[    0.000000] PowerMac motherboard: PowerMac G4 Windtunnel
[    0.000000] CPU maps initialized for 1 thread per core
[    0.000000]  (thread shift is 0)
[    0.000000] console [udbg0] enabled
[    0.000000] Found UniNorth PCI host bridge at 0x00000000f0000000. Firmware bus number: 0->0
[    0.000000] PCI host bridge /pci@f0000000  ranges:
[    0.000000]  MEM 0x00000000f1000000..0x00000000f1ffffff -> 0x00000000f1000000 
[    0.000000]   IO 0x00000000f0000000..0x00000000f07fffff -> 0x0000000000000000
[    0.000000]  MEM 0x0000000090000000..0x00000000afffffff -> 0x0000000090000000 
[    0.000000] Found UniNorth PCI host bridge at 0x00000000f2000000. Firmware bus number: 0->0
[    0.000000] PCI host bridge /pci@f2000000 (primary) ranges:
[    0.000000]  MEM 0x00000000f3000000..0x00000000f3ffffff -> 0x00000000f3000000 
[    0.000000]   IO 0x00000000f2000000..0x00000000f27fffff -> 0x0000000000000000
[    0.000000]  MEM 0x0000000080000000..0x000000008fffffff -> 0x0000000080000000 
[    0.000000] Found UniNorth PCI host bridge at 0x00000000f4000000. Firmware bus number: 0->0
[    0.000000] PCI host bridge /pci@f4000000  ranges:
[    0.000000]  MEM 0x00000000f5000000..0x00000000f5ffffff -> 0x00000000f5000000 
[    0.000000]   IO 0x00000000f4000000..0x00000000f47fffff -> 0x0000000000000000
[    0.000000] via-pmu: Server Mode is disabled
[    0.000000] PMU driver v2 initialized for Core99, firmware: 0c
[    0.000000] nvram: Checking bank 0...
[    0.000000] nvram: gen0=1392, gen1=1391
[    0.000000] nvram: Active bank is: 0
[    0.000000] nvram: OF partition at 0x410
[    0.000000] nvram: XP partition at 0x1020
[    0.000000] nvram: NR partition at 0x1120
[    0.000000] Top of RAM: 0x60000000, Total RAM: 0x60000000
[    0.000000] Memory hole size: 0MB
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00030000
[    0.000000]   Normal   0x00030000 -> 0x00030000
[    0.000000]   HighMem  0x00030000 -> 0x00060000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00060000
[    0.000000] On node 0 totalpages: 393216
[    0.000000] free_area_init_node: node 0, pgdat c042e0c0, node_mem_map c04a7000
[    0.000000]   DMA zone: 1536 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 195072 pages, LIFO batch:31
[    0.000000]   HighMem zone: 1536 pages used for memmap
[    0.000000]   HighMem zone: 195072 pages, LIFO batch:31
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 390144
[    0.000000] Kernel command line: root=/dev/mapper/power--group-root ro video=ofonly 
[    0.000000] Experimental hierarchical RCU implementation.
[    0.000000] Experimental hierarchical RCU init done.
[    0.000000] NR_IRQS:512
[    0.000000] mpic: Setting up MPIC " MPIC 1   " version 1.2 at 80040000, max 4 CPUs
[    0.000000] mpic: ISU size: 64, shift: 6, mask: 3f
[    0.000000] mpic: Initializing for 64 sources
[    0.000000] irq: irq 55 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 55
[    0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[    0.000000] GMT Delta read from XPRAM: 240 minutes, DST: on
[    0.000000] time_init: decrementer frequency = 33.304615 MHz
[    0.000000] time_init: processor frequency   = 866.666664 MHz
[    0.000000] clocksource: timebase mult[781a7d6] shift[22] registered
[    0.000000] clockevent: decrementer mult[886] shift[16] cpu[0]
[    0.000302] Console: colour dummy device 80x25
[    0.000470] console handover: boot [udbg0] -> real [tty0]
[    0.000705] irq: irq 22 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 22
[    0.000746] irq: irq 23 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 23
[    0.001702] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.002875] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.212638] High memory: 786432k
[    0.212649] Memory: 1544188k/1572864k available (4140k kernel code, 27588k reserved, 152k data, 332k bss, 236k init)
[    0.212804] SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.212833] Calibrating delay loop... 66.56 BogoMIPS (lpj=332800)
[    0.430490] Security Framework initialized
[    0.430558] Mount-cache hash table entries: 512
[    0.431129] device-tree: Duplicate name in /cpus/PowerPC,G4@0/l2-cache, renamed to "l2-cache#1"
[    0.431233] device-tree: Duplicate name in /cpus/PowerPC,G4@0, renamed to "l2-cache#1"
[    0.431373] device-tree: Duplicate name in /cpus/PowerPC,G4@1/l2-cache, renamed to "l2-cache#1"
[    0.431470] device-tree: Duplicate name in /cpus/PowerPC,G4@1, renamed to "l2-cache#1"
[    0.434862] Initializing cgroup subsys ns
[    0.434879] Initializing cgroup subsys cpuacct
[    0.434892] Initializing cgroup subsys devices
[    0.434905] Initializing cgroup subsys freezer
[    0.435275] PowerMac SMP probe found 2 cpus
[    0.435390] irq: irq 42 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 42
[    0.435439] KeyWest i2c @0xf8001003 irq 42 /uni-n@f8000000/i2c@f8001000
[    0.435471]  channel 0 bus <multibus>
[    0.435483]  channel 1 bus <multibus>
[    0.435524] irq: irq 26 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 26
[    0.435540] KeyWest i2c @0x80018000 irq 26 /pci@f2000000/mac-io@17/i2c@18000
[    0.435561]  channel 0 bus <multibus>
[    0.435581] PMU i2c /pci@f2000000/mac-io@17/via-pmu@16000/pmu-i2c
[    0.435599]  channel 1 bus <multibus>
[    0.435612]  channel 2 bus <multibus>
[    0.435639] pmf: no parser for command 17 !
[    0.435701] Processor timebase sync using GPIO 0x73
[    0.435719] mpic: requesting IPIs ... 
[    0.435741] irq: irq 251 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 251
[    0.435759] irq: irq 252 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 252
[    0.435775] irq: irq 253 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 253
[    0.435792] irq: irq 254 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 254
[    0.435803] CPU0: L2CR is 80080000
[    0.435816] CPU0: L3CR is 8f0b0000
[477194871.574718] CPU1: L2CR was 80000
[477194871.574756] CPU1: L2CR set to 80080000
[477194871.574762] CPU1: L3CR was 0
[477194871.574923] CPU1: L3CR set to 8f0b0000
[    0.437467] Processor 1 found.
[    0.437528] clockevent: decrementer mult[886] shift[16] cpu[1]
[    0.437573] Brought up 2 CPUs
[    0.437747] CPU0 attaching sched-domain:
[    0.437757]  domain 0: span 0-1 level CPU
[    0.437766]   groups: 0 1
[    0.437783] CPU1 attaching sched-domain:
[    0.437790]  domain 0: span 0-1 level CPU
[    0.437797]   groups: 1 0
[    0.458104] net_namespace: 568 bytes
[    0.458801] NET: Registered protocol family 16
[    0.459386] irq: irq 25 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 25
[    0.459438] irq: irq 47 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 47
[    0.459775] PCI: Probing PCI hardware
[    0.459993] pci 0000:00:10.0: reg 10 32bit mmio: [0x91000000-0x91ffffff]
[    0.460006] pci 0000:00:10.0: reg 14 32bit mmio: [0x98000000-0x9fffffff]
[    0.460018] pci 0000:00:10.0: reg 18 32bit mmio: [0x000000-0x07ffff]
[    0.460041] pci 0000:00:10.0: reg 30 32bit mmio: [0x90000000-0x9001ffff]
[    0.460141] irq: irq 48 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 48
[    0.460450] pci 0001:10:17.0: reg 10 32bit mmio: [0x80000000-0x8007ffff]
[    0.460514] pci 0001:10:18.0: reg 10 32bit mmio: [0x80081000-0x80081fff]
[    0.460578] pci 0001:10:19.0: reg 10 32bit mmio: [0x80080000-0x80080fff]
[    0.460683] irq: irq 27 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 27
[    0.460727] irq: irq 28 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 28
[    0.461164] pci 0002:20:0d.0: reg 10 32bit mmio: [0xf5004000-0xf5007fff]
[    0.461231] pci 0002:20:0e.0: reg 10 32bit mmio: [0xf5000000-0xf5000fff]
[    0.461278] pci 0002:20:0e.0: supports D1 D2
[    0.461285] pci 0002:20:0e.0: PME# supported from D0 D1 D2 D3hot
[    0.461309] pci 0002:20:0e.0: PME# disabled
[    0.461348] pci 0002:20:0f.0: reg 10 32bit mmio: [0xf5200000-0xf53fffff]
[    0.461378] pci 0002:20:0f.0: reg 30 32bit mmio: [0xf5100000-0xf51fffff]
[    0.461457] irq: irq 39 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 39
[    0.461493] irq: irq 40 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 40
[    0.461533] irq: irq 41 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 41
[    0.461931] pci_bus 0000:00: resource 0 io:  [0x802000-0x1001fff]
[    0.461940] pci_bus 0000:00: resource 1 mem: [0xf1000000-0xf1ffffff]
[    0.461949] pci_bus 0000:00: resource 2 mem: [0x90000000-0xafffffff]
[    0.461958] pci_bus 0001:10: resource 0 io:  [0x00-0x7fffff]
[    0.461966] pci_bus 0001:10: resource 1 mem: [0xf3000000-0xf3ffffff]
[    0.461974] pci_bus 0001:10: resource 2 mem: [0x80000000-0x8fffffff]
[    0.461983] pci_bus 0002:20: resource 0 io:  [0xff7fe000-0xffffdfff]
[    0.461991] pci_bus 0002:20: resource 1 mem: [0xf5000000-0xf5ffffff]
[    0.463373] bio: create slab <bio-0> at 0
[    0.464123] usbcore: registered new interface driver usbfs
[    0.464207] usbcore: registered new interface driver hub
[    0.464422] usbcore: registered new device driver usb
[    0.508335] NET: Registered protocol family 2
[    0.517669] Switched to high resolution mode on CPU 0
[    0.527669] Switched to high resolution mode on CPU 1
[    0.617829] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.618895] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.621231] TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
[    0.622941] TCP: Hash tables configured (established 131072 bind 65536)
[    0.622971] TCP reno registered
[    0.647915] NET: Registered protocol family 1
[    0.648172] checking if image is initramfs...
[    0.987012] rootfs image is initramfs; unpacking...
[    0.987066] Freeing initrd memory: 5216k freed
[    0.988169] Thermal assist unit not available
[    0.988468] setup_kcore: restrict size=3fffffff
[    0.988750] audit: initializing netlink socket (disabled)
[    0.988807] type=2000 audit(1242269633.980:1): initialized
[    0.990677] highmem bounce pool size: 64 pages
[    0.995185] VFS: Disk quotas dquot_6.5.2
[    0.995441] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.996211] msgmni has been set to 1492
[    0.997485] alg: No test for stdrng (krng)
[    1.000150] alg: No test for stdrng (ansi_cprng)
[    1.000238] io scheduler noop registered
[    1.000270] io scheduler anticipatory registered
[    1.000286] io scheduler deadline registered
[    1.000347] io scheduler cfq registered (default)
[    1.000606] Using unsupported 640x480 NVDA,Display-B at 98004000, depth=8, pitch=1024
[    1.005902] Console: switching to colour frame buffer device 80x30
[    1.010427] fb0: Open Firmware frame buffer device on /pci@f0000000/NVDA,Parent@10/NVDA,Display-B@1
[    1.010699] Using unsupported 640x480 NVDA,Display-A at 99000000, depth=8, pitch=640
[    1.010998] fb1: Open Firmware frame buffer device on /pci@f0000000/NVDA,Parent@10/NVDA,Display-A@0
[    1.018282] Generic non-volatile memory driver v1.1
[    1.020794] Linux agpgart interface v0.103
[    1.023223] agpgart-uninorth 0000:00:0b.0: Apple UniNorth 2 chipset
[    1.025864] agpgart-uninorth 0000:00:0b.0: configuring for size idx: 8
[    1.028475] agpgart-uninorth 0000:00:0b.0: AGP aperture is 32M @ 0x0
[    1.030957] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    1.033777] pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
[    1.038780] ttyPZ0 at MMIO 0x80013020 (irq = 22) is a Z85c30 ESCC - Serial port
[    1.043994] ttyPZ1 at MMIO 0x80013000 (irq = 23) is a Z85c30 ESCC - Serial port
[    1.051577] brd: module loaded
[    1.055241] loop: module loaded
[    1.058028] MacIO PCI driver attached to Keylargo chipset
[    1.061160] irq: irq 32 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 32
[    1.061428] irq: irq 19 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 19
[    1.061452] irq: irq 11 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 16
[    1.061561] irq: irq 20 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 20
[    1.061584] irq: irq 12 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 17
[    1.061699] irq: irq 5 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 18
[    1.061723] irq: irq 6 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 21
[    1.061894] irq: irq 7 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 24
[    1.061918] irq: irq 8 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 29
[    1.062392] input: Macintosh mouse button emulation as /class/input/input0
[    1.065414] Uniform Multi-Platform E-IDE driver
[    1.068180] ide-pmac 0002:20:0d.0: enabling device (0000 -> 0002)
[    1.071060] adb: starting probe task...
[    1.073637] adb: finished probe task...
[    2.097662] ide-pmac: Found Apple UniNorth ATA-6 controller (PCI), bus ID 3, irq 39
[    2.102451] Probing IDE interface ide0...
[    2.407838] hda: IBM-IC35L060AVVA07-0, ATA DISK drive
[    2.767650] hdb: QUANTUM FIREBALLP LM20.5, ATA DISK drive
[    2.770169] hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[    2.770346] hda: UDMA/100 mode selected
[    2.772898] hdb: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[    2.773144] hdb: UDMA/66 mode selected
[    2.775837] ide0 at 0xf1012000-0xf1012070,0xf1012160 on irq 39
[   67.637652] ide-pmac: Found Apple KeyLargo ATA-4 controller (macio), bus ID 2, irq 19
[   67.642398] Probing IDE interface ide1...
[   68.247755] ide1 at 0xf100e000-0xf100e070,0xf100e160 on irq 19
[  133.147657] ide-pmac: Found Apple KeyLargo ATA-3 controller (macio), bus ID 0, irq 20
[  133.152394] Probing IDE interface ide2...
[  133.577834] hde: PHILIPS CDD5101, ATAPI CD/DVD-ROM drive
[  133.937729] hde: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[  133.938126] hde: MWDMA2 mode selected
[  133.941426] ide2 at 0xf1016000-0xf1016070,0xf1016160 on irq 20
[  133.944047] ide-gd driver 1.18
[  133.946512] hda: max request size: 128KiB
[  197.687709] hda: 120103200 sectors (61492 MB) w/1863KiB Cache, CHS=65535/16/63
[  197.692702] hda: cache flushes supported
[  197.695404]  hda: [mac] hda1 hda2 hda3 hda4
[  197.717823] hdb: max request size: 128KiB
[  197.750301] hdb: 40132503 sectors (20547 MB) w/1900KiB Cache, CHS=39813/16/63
[  197.752759] hdb: cache flushes not supported
[  197.755223]  hdb:<3>ide-pmac lost interrupt, dma status: 8480
[  217.750084] hdb: lost interrupt
[  217.752469] hdb: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
[  217.757462] ide: failed opcode was: unknown
[  217.762340] hda: DMA disabled
[  217.764699] hdb: DMA disabled
[  217.897615] ide0: reset: success
[  217.945789]  hdb1 hdb2 < hdb5 hdb6 hdb7 hdb8 >
[  218.008239] ide-cd driver 5.00
[  218.012452] ide-cd: hde: ATAPI 32X DVD-ROM CD-R/RW drive, 8192kB Cache
[  218.014675] Uniform CD-ROM driver Revision: 3.20
[  218.041570] sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
[  218.118025] PHY ID: 2060e1, addr: 0
[  218.128186] eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:03:93:ab:d1:a6
[  218.130518] eth0: Found BCM5421 PHY
[  218.132799] I2O subsystem v1.325
[  218.134926] i2o: max drivers = 8
[  218.138279] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[  218.140626] ohci_hcd 0001:10:18.0: enabling device (0000 -> 0002)
[  218.142880] ohci_hcd 0001:10:18.0: OHCI Host Controller
[  218.157628] ohci_hcd 0001:10:18.0: new USB bus registered, assigned bus number 1
[  218.161892] ohci_hcd 0001:10:18.0: irq 27, io mem 0x80081000
[  218.240030] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[  218.242268] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[  218.246509] usb usb1: Product: OHCI Host Controller
[  218.248722] usb usb1: Manufacturer: Linux 2.6.29 ohci_hcd
[  218.251023] usb usb1: SerialNumber: 0001:10:18.0
[  218.255152] usb usb1: configuration #1 chosen from 1 choice
[  218.257615] hub 1-0:1.0: USB hub found
[  218.259953] hub 1-0:1.0: 2 ports detected
[  218.264399] ohci_hcd 0001:10:19.0: enabling device (0000 -> 0002)
[  218.266706] ohci_hcd 0001:10:19.0: OHCI Host Controller
[  218.269059] ohci_hcd 0001:10:19.0: new USB bus registered, assigned bus number 2
[  218.273371] ohci_hcd 0001:10:19.0: irq 28, io mem 0x80080000
[  218.349992] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[  218.352364] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[  218.356914] usb usb2: Product: OHCI Host Controller
[  218.359266] usb usb2: Manufacturer: Linux 2.6.29 ohci_hcd
[  218.361639] usb usb2: SerialNumber: 0001:10:19.0
[  218.364050] usb usb2: configuration #1 chosen from 1 choice
[  218.366407] hub 2-0:1.0: USB hub found
[  218.368610] hub 2-0:1.0: 2 ports detected
[  218.403137] mice: PS/2 mouse device common for all mice
[  218.405426] rtc-generic rtc-generic: rtc core: registered rtc-generic as rtc0
[  218.408136] i2c /dev entries driver
[  218.410538] PowerMac i2c bus pmu 2 registered
[  218.412830] PowerMac i2c bus pmu 1 registered
[  218.415060] PowerMac i2c bus mac-io 0 registered
[  218.417229] PowerMac i2c bus uni-n 1 registered
[  218.419451] PowerMac i2c bus uni-n 0 registered
[  218.422341] usbcore: registered new interface driver hiddev
[  218.425132] usbcore: registered new interface driver usbhid
[  218.427106] usbhid: v2.6:USB HID core driver
[  218.430307] TCP cubic registered
[  218.432145] NET: Registered protocol family 17
[  218.435219] registered taskstats version 1
[  218.437607] input: PMU as /class/input/input1
[  218.450373] rtc-generic rtc-generic: setting system clock to 2009-05-14 06:57:32 UTC (1242284252)
[  218.453954] Freeing unused kernel memory: 236k init
[  218.617681] usb 1-1: new low speed USB device using ohci_hcd and address 2
[  218.816162] usb 1-1: New USB device found, idVendor=0458, idProduct=002e
[  218.821254] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[  218.823404] usb 1-1: Product: NetScroll+ Traveler
[  218.825530] usb 1-1: Manufacturer: KYE
[  218.827942] usb 1-1: configuration #1 chosen from 1 choice
[  218.843184] input: KYE NetScroll+ Traveler as /class/input/input2
[  218.867896] generic-usb 0003:0458:002E.0001: input,hidraw0: USB HID v1.10 Mouse [KYE NetScroll+ Traveler] on usb-0001:10:18.0-1/input0
[  219.017769] usb 2-1: new full speed USB device using ohci_hcd and address 2
[  219.206195] usb 2-1: New USB device found, idVendor=05e3, idProduct=0608
[  219.209052] usb 2-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[  219.211730] usb 2-1: Product: USB2.0 Hub
[  219.214744] usb 2-1: configuration #1 chosen from 1 choice
[  219.218282] hub 2-1:1.0: USB hub found
[  219.222182] hub 2-1:1.0: 4 ports detected
[  219.538191] usb 2-1.1: new full speed USB device using ohci_hcd and address 3
[  219.676147] usb 2-1.1: New USB device found, idVendor=05e3, idProduct=0608
[  219.678837] usb 2-1.1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[  219.683905] usb 2-1.1: Product: USB2.0 Hub
[  219.686618] usb 2-1.1: configuration #1 chosen from 1 choice
[  219.691245] hub 2-1.1:1.0: USB hub found
[  219.694174] hub 2-1.1:1.0: 4 ports detected
[  219.812810] ieee1394: module_layout: kernel tainted.
[  219.857852] ohci1394 0002:20:0e.0: enabling device (0000 -> 0002)
[  219.922300] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[40]  MMIO=[f5000000-f50007ff]  Max Packet=[2048]  IR/IT contexts=[8/8]
[  219.990141] usb 2-1.1.1: new low speed USB device using ohci_hcd and address 4
[  220.120169] usb 2-1.1.1: New USB device found, idVendor=04d9, idProduct=0022
[  220.122656] usb 2-1.1.1: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[  220.127345] usb 2-1.1.1: Product: USB Keyboard
[  220.129973] usb 2-1.1.1: configuration #1 chosen from 1 choice
[  220.144320] input: USB Keyboard as /class/input/input3
[  220.167879] generic-usb 0003:04D9:0022.0002: input,hidraw1: USB HID v1.10 Keyboard [USB Keyboard] on usb-0001:10:19.0-1.1.1/input0
[  220.193383] input: USB Keyboard as /class/input/input4
[  220.217831] generic-usb 0003:04D9:0022.0003: input,hidraw2: USB HID v1.10 Device [USB Keyboard] on usb-0001:10:19.0-1.1.1/input1
[  220.520512] eth0: Link is up at 100 Mbps, full-duplex.
[  220.833728] device-mapper: uevent: version 1.0.3
[  220.839499] device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised: dm-devel@redhat.com
[  221.300357] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000393fffeabd1a6]
[  248.319095] device-mapper: table: 254:0: crypt: Error allocating crypto tfm
[  248.321989] device-mapper: ioctl: error adding target to table
[  248.325455] device-mapper: ioctl: device doesn't appear to be in the dev hash table.
[  305.646186] kjournald starting.  Commit interval 5 seconds
[  305.646214] EXT3-fs: mounted filesystem with ordered data mode.
[  309.608189] udev: starting version 141
[  309.612897] udev: deprecated sysfs layout; update the kernel or disable CONFIG_SYSFS_DEPRECATED; some udev features will not work correctly
[  316.600821] EXT3 FS on dm-1, internal journal
[  317.696928] SCSI subsystem initialized
[  317.776899] DS1775 digital thermometer [@49]
[  317.779409] Temp: 52.2 C  Hyst: 60.0 C  OS: 65.0 C
[  317.782998] ADM1030 fan controller [@2c]
[  322.891056] kjournald starting.  Commit interval 5 seconds
[  322.892158] EXT3 FS on dm-3, internal journal
[  322.892180] EXT3-fs: mounted filesystem with ordered data mode.
[  322.939021] REISERFS (device dm-4): found reiserfs format "3.6" with standard journal
[  322.944332] REISERFS (device dm-4): using ordered data mode
[  322.954313] REISERFS (device dm-4): journal params: device dm-4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[  322.965326] REISERFS (device dm-4): checking transaction log (dm-4)
[  323.031967] REISERFS (device dm-4): Using r5 hash to sort names
[  323.160966] Adding 1048568k swap on /dev/mapper/power--group-swap_1.  Priority:-1 extents:1 across:1048568k 
[  325.461107] eth0: Link is up at 100 Mbps, full-duplex.
[  325.463883] eth0: Pause is enabled (rxfifo: 10240 off: 7168 on: 5632)
[  325.808809] CPU-temp: 52.2 C, Case: 32.0 C,  Fan: 0 (tuned -11)
[  344.162436] Process Xorg (pid:3051) mapped non-existing PCI legacy memory for 00000:00
[  471.307621] hda: irq timeout: status=0xc4 { Busy }
[  471.310558] ide: failed opcode was: unknown
[  471.367611] ide0: reset: master: error (0x08?)
[  476.390116] hda: status timeout: status=0xa0 { Busy }
[  476.393070] ide: failed opcode was: unknown
[  476.395884] hda: drive not ready for command
[  476.440117] ide0: reset: master: error (0x08?)
[  476.450278] end_request: I/O error, dev hda, sector 57379667
[  476.453129] end_request: I/O error, dev hda, sector 57379675
[  476.455901] end_request: I/O error, dev hda, sector 57379683
[  476.458617] end_request: I/O error, dev hda, sector 57379691
[  476.463376] end_request: I/O error, dev hda, sector 57379699
[  476.465985] end_request: I/O error, dev hda, sector 57379707
[  476.468519] end_request: I/O error, dev hda, sector 57379715
[  476.471171] end_request: I/O error, dev hda, sector 57379723
[  476.473607] end_request: I/O error, dev hda, sector 57379731
[  476.476000] end_request: I/O error, dev hda, sector 57379739
[  476.478329] end_request: I/O error, dev hda, sector 57379747
[  476.481274] end_request: I/O error, dev hda, sector 57379755
[  476.483381] end_request: I/O error, dev hda, sector 57379763
[  476.485372] end_request: I/O error, dev hda, sector 57379771
[  476.487239] end_request: I/O error, dev hda, sector 57379779
[  476.488990] end_request: I/O error, dev hda, sector 57379787
[  476.490850] end_request: I/O error, dev hda, sector 57379795
[  476.492433] end_request: I/O error, dev hda, sector 57379803
[  476.493908] end_request: I/O error, dev hda, sector 57379811
[  476.495343] end_request: I/O error, dev hda, sector 57379819
[  476.496686] end_request: I/O error, dev hda, sector 57379827
[  476.497963] end_request: I/O error, dev hda, sector 57379835
[  476.499138] end_request: I/O error, dev hda, sector 57379843
[  476.500468] end_request: I/O error, dev hda, sector 57379851
[  476.501502] end_request: I/O error, dev hda, sector 57379859
[  476.502474] end_request: I/O error, dev hda, sector 57379867
[  476.503382] end_request: I/O error, dev hda, sector 57379875
[  476.504230] end_request: I/O error, dev hda, sector 57379883
[  476.505032] end_request: I/O error, dev hda, sector 57379891
[  476.505776] end_request: I/O error, dev hda, sector 57379899
[  476.506437] end_request: I/O error, dev hda, sector 57379907
[  476.507100] end_request: I/O error, dev hda, sector 57379915
[  476.508251] end_request: I/O error, dev hda, sector 117093907
[  476.509223] end_request: I/O error, dev hda, sector 51253907
[  476.509924] Buffer I/O error on device dm-3, logical block 4259841
[  476.511085] lost page write due to I/O error on dm-3
[  476.511964] end_request: I/O error, dev hda, sector 51253947
[  476.512928] Buffer I/O error on device dm-3, logical block 4259846
[  476.513982] lost page write due to I/O error on dm-3
[  476.515108] end_request: I/O error, dev hda, sector 51455675
[  476.516340] Buffer I/O error on device dm-3, logical block 4285062
[  476.517668] lost page write due to I/O error on dm-3
[  476.519069] end_request: I/O error, dev hda, sector 57379795
[  476.520877] end_request: I/O error, dev hda, sector 5021603
[  476.522399] end_request: I/O error, dev hda, sector 5021611
[  476.523911] end_request: I/O error, dev hda, sector 5021619
[  476.525422] end_request: I/O error, dev hda, sector 5021627
[  476.526930] end_request: I/O error, dev hda, sector 5021635
[  476.528440] end_request: I/O error, dev hda, sector 5021643
[  476.529948] end_request: I/O error, dev hda, sector 5021651
[  476.531695] end_request: I/O error, dev hda, sector 5021659
[  476.533207] end_request: I/O error, dev hda, sector 5021667
[  476.534713] end_request: I/O error, dev hda, sector 5021675
[  476.536217] end_request: I/O error, dev hda, sector 5021683
[  476.537723] end_request: I/O error, dev hda, sector 5021691
[  476.539228] end_request: I/O error, dev hda, sector 5021699
[  476.540943] end_request: I/O error, dev hda, sector 5021707
[  476.540952] end_request: I/O error, dev hda, sector 5021715
[  476.540959] end_request: I/O error, dev hda, sector 5021723
[  476.540967] end_request: I/O error, dev hda, sector 5021731
[  476.540974] end_request: I/O error, dev hda, sector 5021739
[  476.540982] end_request: I/O error, dev hda, sector 5021747
[  476.540989] end_request: I/O error, dev hda, sector 5021755
[  476.540996] end_request: I/O error, dev hda, sector 5021763
[  476.541004] end_request: I/O error, dev hda, sector 5021771
[  476.541011] end_request: I/O error, dev hda, sector 5021779
[  476.541018] end_request: I/O error, dev hda, sector 5021787
[  476.541026] end_request: I/O error, dev hda, sector 5021795
[  476.541033] end_request: I/O error, dev hda, sector 5021803
[  476.541040] end_request: I/O error, dev hda, sector 5021811
[  476.541047] end_request: I/O error, dev hda, sector 5021819
[  476.541055] end_request: I/O error, dev hda, sector 5021827
[  476.541062] end_request: I/O error, dev hda, sector 5021835
[  476.541069] end_request: I/O error, dev hda, sector 5021843
[  476.541076] end_request: I/O error, dev hda, sector 5021851
[  476.541167] end_request: I/O error, dev hda, sector 51254051
[  476.541184] Buffer I/O error on device dm-3, logical block 4259859
[  476.541190] lost page write due to I/O error on dm-3
[  476.541206] end_request: I/O error, dev hda, sector 51319435
[  476.541223] Buffer I/O error on device dm-3, logical block 4268032
[  476.541228] lost page write due to I/O error on dm-3
[  476.541242] end_request: I/O error, dev hda, sector 115925067
[  476.541262] Buffer I/O error on device dm-4, logical block 2488
[  476.541268] lost page write due to I/O error on dm-4
[  476.541286] end_request: I/O error, dev hda, sector 115925075
[  476.541303] Buffer I/O error on device dm-4, logical block 2489
[  476.541309] lost page write due to I/O error on dm-4
[  476.541318] end_request: I/O error, dev hda, sector 115925083
[  476.541335] Buffer I/O error on device dm-4, logical block 2490
[  476.541341] lost page write due to I/O error on dm-4
[  476.541351] end_request: I/O error, dev hda, sector 115925091
[  476.541365] Buffer I/O error on device dm-4, logical block 2491
[  476.541371] lost page write due to I/O error on dm-4
[  476.541380] end_request: I/O error, dev hda, sector 115925099
[  476.541396] Buffer I/O error on device dm-4, logical block 2492
[  476.541402] lost page write due to I/O error on dm-4
[  476.541411] end_request: I/O error, dev hda, sector 115925107
[  476.541430] end_request: I/O error, dev hda, sector 115925115
[  476.541448] end_request: I/O error, dev hda, sector 115925123
[  476.541468] end_request: I/O error, dev hda, sector 115925131
[  476.541486] end_request: I/O error, dev hda, sector 115925139
[  476.541514] end_request: I/O error, dev hda, sector 115925147
[  476.590126] end_request: I/O error, dev hda, sector 5021731
[  476.610176] REISERFS abort (device dm-4): Journal write error in flush_commit_list
[  476.620152] end_request: I/O error, dev hda, sector 117008515
[  476.620198] end_request: I/O error, dev hda, sector 117008523
[  476.620226] end_request: I/O error, dev hda, sector 117064915
[  476.620244] end_request: I/O error, dev hda, sector 117064923
[  476.680674] end_request: I/O error, dev hda, sector 10153627
[  476.685700] EXT3-fs error (device dm-1): ext3_find_entry: reading directory #290582 offset 0
[  476.690971] Aborting journal on device dm-1.
[  476.693632] __journal_remove_journal_head: freeing b_committed_data
[  476.696663] end_request: I/O error, dev hda, sector 7324251
[  476.699372] Remounting filesystem read-only
[  476.702469] end_request: I/O error, dev hda, sector 504459
[  476.705271] end_request: I/O error, dev hda, sector 10153627
[  476.707893] EXT3-fs error (device dm-1): ext3_find_entry: reading directory #290582 offset 0
[  476.713242] end_request: I/O error, dev hda, sector 10153627
[  476.716038] EXT3-fs error (device dm-1): ext3_find_entry: reading directory #290582 offset 0
[  476.721960] end_request: I/O error, dev hda, sector 51253907
[  476.724799] EXT3-fs error (device dm-3): read_inode_bitmap: Cannot read inode bitmap - block_group = 130, inode_bitmap = 4259841
[  476.731245] end_request: I/O error, dev hda, sector 17175179
[  476.734460] EXT3-fs error (device dm-3) in ext3_new_inode: IO failure
[  476.737898] ------------[ cut here ]------------
[  476.741256] Badness at fs/buffer.c:1128
[  476.744648] NIP: c00e2b20 LR: c01500f8 CTR: 00000000
[  476.748028] REGS: c1dadc90 TRAP: 0700   Tainted: GF           (2.6.29)
[  476.751400] MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 24042882  XER: 00000000
[  476.754835] TASK = ef1adb00[3040] 'gdm' THREAD: c1dac000 CPU: 1
[  476.754991] GPR00: 00000001 c1dadd40 ef1adb00 ef588348 00000179 00000000 00000178 00000002 
[  476.762014] GPR08: 00000078 c0490000 00000000 00000000 24042842 10069a6c c1dade70 c2241400 
[  476.769440] GPR16: 00008180 c1dadd98 00008000 00000001 c031f294 ef46f000 ef6d6fc0 00000000 
[  476.776867] GPR24: c1c44000 c1c45800 00000082 ed450720 00000001 ef588348 c2241400 c1c45800 
[  476.787908] NIP [c00e2b20] mark_buffer_dirty+0x1c/0xd0
[  476.791661] LR [c01500f8] ext3_commit_super+0x84/0xb0
[  476.795383] Call Trace:
[  476.799035] [c1dadd40] [c01500dc] ext3_commit_super+0x68/0xb0 (unreliable)
[  476.802837] [c1dadd60] [c0151ddc] ext3_handle_error+0xa4/0xd8
[  476.806649] [c1dadd70] [c0151e78] __ext3_std_error+0x68/0x7c
[  476.810394] [c1dadd90] [c01461a4] ext3_new_inode+0x9e8/0xadc
[  476.814068] [c1daddf0] [c014e044] ext3_create+0xc0/0x130
[  476.817677] [c1dade40] [c00c722c] vfs_create+0xf8/0x180
[  476.821217] [c1dade60] [c00ca364] do_filp_open+0x1ec/0x804
[  476.824688] [c1dadf20] [c00ba944] do_sys_open+0x60/0xf8
[  476.828098] [c1dadf40] [c0014e44] ret_from_syscall+0x0/0x38
[  476.831450] --- Exception: c01 at 0xf222eb8
[  476.831454]     LR = 0xf6a46c4
[  476.837862] Instruction dump:
[  476.840955] 5400d97e 0f000000 2f800000 419eff90 4bffff80 80030000 70090001 40a2002c 
[  476.847307] 3d20c049 8009adf4 7c000034 5400d97e <0f000000> 2f800000 41be0010 38000001 
[  476.855268] end_request: I/O error, dev hda, sector 17175179
[  476.857706] JBD: Detected IO errors while flushing file data on dm-3
[  476.860208] end_request: I/O error, dev hda, sector 68297707
[  476.860250] end_request: I/O error, dev hda, sector 68297715
[  476.860270] end_request: I/O error, dev hda, sector 68297723
[  476.860289] end_request: I/O error, dev hda, sector 68297731
[  476.860308] end_request: I/O error, dev hda, sector 68297739
[  476.865093] Aborting journal on device dm-3.
[  476.870556] end_request: I/O error, dev hda, sector 68297371
[  477.920153] end_request: I/O error, dev hda, sector 6273587
[  477.922915] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=181302, block=721141
[  477.931263] end_request: I/O error, dev hda, sector 9507259
[  477.934081] end_request: I/O error, dev hda, sector 9507267
[  477.936820] end_request: I/O error, dev hda, sector 9507259
[  481.608259] end_request: I/O error, dev hda, sector 117064675
[  481.610980] __ratelimit: 15 callbacks suppressed
[  481.613584] Buffer I/O error on device dm-4, logical block 144939
[  481.616264] lost page write due to I/O error on dm-4
[  481.619986] end_request: I/O error, dev hda, sector 117064923
[  481.622773] Buffer I/O error on device dm-4, logical block 144970
[  481.625550] lost page write due to I/O error on dm-4
[  481.628362] end_request: I/O error, dev hda, sector 117093907
[  481.631198] Buffer I/O error on device dm-4, logical block 148593
[  481.633972] lost page write due to I/O error on dm-4
[  481.636683] end_request: I/O error, dev hda, sector 117008523
[  481.639374] Buffer I/O error on device dm-4, logical block 137920
[  481.643163] lost page write due to I/O error on dm-4
[  481.645925] end_request: I/O error, dev hda, sector 117046539
[  481.648715] Buffer I/O error on device dm-4, logical block 142672
[  481.651531] lost page write due to I/O error on dm-4
[  481.660182] end_request: I/O error, dev hda, sector 116972771
[  481.660203] Buffer I/O error on device dm-4, logical block 133451
[  481.660209] lost page write due to I/O error on dm-4
[  481.660224] end_request: I/O error, dev hda, sector 117035715
[  481.660237] Buffer I/O error on device dm-4, logical block 141319
[  481.660243] lost page write due to I/O error on dm-4
[  536.620138] end_request: I/O error, dev hda, sector 117093907
[  536.626375] Buffer I/O error on device dm-4, logical block 148593
[  536.629512] lost page write due to I/O error on dm-4
[  539.483512] end_request: I/O error, dev hda, sector 57022227
[  539.486973] EXT3-fs error (device dm-3): ext3_get_inode_loc: unable to read inode block - inode=1247483, block=4980881
[  539.494313] end_request: I/O error, dev hda, sector 17175179
[  539.497790] Buffer I/O error on device dm-3, logical block 0
[  539.501265] lost page write due to I/O error on dm-3
[  539.509966] end_request: I/O error, dev hda, sector 63575867
[  539.513515] EXT3-fs error (device dm-3): ext3_get_inode_loc: unable to read inode block - inode=1452367, block=5800086
[  539.521013] end_request: I/O error, dev hda, sector 17175179
[  539.524589] Buffer I/O error on device dm-3, logical block 0
[  539.528136] lost page write due to I/O error on dm-3
[  539.535505] end_request: I/O error, dev hda, sector 35263131
[  539.539100] EXT3-fs error (device dm-3): ext3_get_inode_loc: unable to read inode block - inode=565251, block=2260994
[  539.547379] end_request: I/O error, dev hda, sector 17175179
[  539.551103] Buffer I/O error on device dm-3, logical block 0
[  539.554758] lost page write due to I/O error on dm-3
[  539.562786] end_request: I/O error, dev hda, sector 57022227
[  539.566532] EXT3-fs error (device dm-3): ext3_get_inode_loc: unable to read inode block - inode=1247479, block=4980881
[  539.574431] end_request: I/O error, dev hda, sector 17175179
[  539.578286] Buffer I/O error on device dm-3, logical block 0
[  539.582031] lost page write due to I/O error on dm-3
[  539.589707] end_request: I/O error, dev hda, sector 57022227
[  539.593516] EXT3-fs error (device dm-3): ext3_get_inode_loc: unable to read inode block - inode=1247488, block=4980881
[  539.602873] end_request: I/O error, dev hda, sector 17175179
[  539.606645] Buffer I/O error on device dm-3, logical block 0
[  539.610407] lost page write due to I/O error on dm-3
[  544.914873] end_request: I/O error, dev hda, sector 51319435
[  544.918474] ext3_abort called.
[  544.921915] EXT3-fs error (device dm-3): ext3_journal_start_sb: Detected aborted journal
[  544.928792] Remounting filesystem read-only
[  556.440156] end_request: I/O error, dev hda, sector 116167395
[  556.443581] REISERFS error (device dm-4): vs-13070 reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [2 176 0x0 SD]
[  556.460155] end_request: I/O error, dev hda, sector 116167467
[  556.463584] REISERFS error (device dm-4): vs-13070 reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [2 6986 0x0 SD]
[  566.605558] end_request: I/O error, dev hda, sector 13415147
[  566.608968] end_request: I/O error, dev hda, sector 13415155
[  566.612239] end_request: I/O error, dev hda, sector 13415163
[  566.615399] end_request: I/O error, dev hda, sector 13415171
[  566.618564] end_request: I/O error, dev hda, sector 13415147
[  566.622382] end_request: I/O error, dev hda, sector 13415147
[  595.166714] end_request: I/O error, dev hda, sector 10465947
[  595.172973] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=306433, block=1245186
[  600.147137] end_request: I/O error, dev hda, sector 10465947
[  600.150448] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=306433, block=1245186
[  600.156753] end_request: I/O error, dev hda, sector 10465947
[  600.160832] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=306433, block=1245186
[  600.167958] end_request: I/O error, dev hda, sector 10465947
[  600.171741] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=306433, block=1245186
[  602.571308] end_request: I/O error, dev hda, sector 116167571
[  602.575052] REISERFS error (device dm-4): vs-13070 reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [2 272 0x0 SD]
[  602.588314] end_request: I/O error, dev hda, sector 116167571
[  602.592947] REISERFS error (device dm-4): vs-13070 reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [2 271 0x0 SD]
[  602.604732] end_request: I/O error, dev hda, sector 116167363
[  602.608627] REISERFS error (device dm-4): vs-13070 reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [264 6657 0x0 SD]
[  602.620819] end_request: I/O error, dev hda, sector 116168139
[  602.624796] REISERFS error (device dm-4): vs-13070 reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [2 893 0x0 SD]
[  602.638679] end_request: I/O error, dev hda, sector 9941995
[  602.642773] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=290991, block=1179692
[  602.651031] end_request: I/O error, dev hda, sector 116167363
[  602.655158] REISERFS error (device dm-4): vs-13070 reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [264 5723 0x0 SD]
[  623.870160] end_request: I/O error, dev hda, sector 10465947
[  623.876708] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=306433, block=1245186
[  628.930994] end_request: I/O error, dev hda, sector 10465947
[  628.934267] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=306433, block=1245186
[  628.940986] end_request: I/O error, dev hda, sector 10465947
[  628.944217] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=306433, block=1245186
[  628.950732] end_request: I/O error, dev hda, sector 10465947
[  628.953947] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=306433, block=1245186
[  641.610554] end_request: I/O error, dev hda, sector 117093907
[  641.610748] Buffer I/O error on device dm-4, logical block 148593
[  641.610908] lost page write due to I/O error on dm-4
[  650.480125] end_request: I/O error, dev hda, sector 12300955
[  650.480343] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=362881, block=1474562
[  650.569665] end_request: I/O error, dev hda, sector 12300955
[  650.569897] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=362881, block=1474562
[  656.620130] end_request: I/O error, dev hda, sector 117093907
[  656.620324] Buffer I/O error on device dm-4, logical block 148593
[  656.620484] lost page write due to I/O error on dm-4
[  661.543724] end_request: I/O error, dev hda, sector 12300955
[  661.552197] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=362881, block=1474562
[  663.099138] end_request: I/O error, dev hda, sector 12300955
[  663.103284] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=362881, block=1474562
[  663.110596] end_request: I/O error, dev hda, sector 12300955
[  663.114189] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=362881, block=1474562
[  663.122196] end_request: I/O error, dev hda, sector 12300955
[  663.125832] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=362881, block=1474562
[  664.955009] end_request: I/O error, dev hda, sector 12300955
[  664.958585] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=362881, block=1474562
[  664.966715] end_request: I/O error, dev hda, sector 12300955
[  664.971149] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=362881, block=1474562
[  664.978654] end_request: I/O error, dev hda, sector 12300955
[  664.983255] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=362881, block=1474562
[  668.635161] end_request: I/O error, dev hda, sector 10465947
[  668.638923] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=306433, block=1245186
[  668.646586] end_request: I/O error, dev hda, sector 10465947
[  668.651088] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=306433, block=1245186
[  668.658695] end_request: I/O error, dev hda, sector 10465947
[  668.663075] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=306433, block=1245186
[  682.763155] end_request: I/O error, dev hda, sector 10465947
[  682.766893] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=306433, block=1245186
[  821.638356] usb 2-1.3: new full speed USB device using ohci_hcd and address 5
[  821.860383] usb 2-1.3: New USB device found, idVendor=0930, idProduct=6518
[  821.863775] usb 2-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  821.870335] usb 2-1.3: Product: DataTraveler 2.0
[  821.873611] usb 2-1.3: Manufacturer: Kingston
[  821.876880] usb 2-1.3: SerialNumber: 28C13A40C190A8E6
[  821.880596] usb 2-1.3: configuration #1 chosen from 1 choice
[  821.913822] end_request: I/O error, dev hda, sector 12196299
[  821.917451] end_request: I/O error, dev hda, sector 12196299
[  821.921610] end_request: I/O error, dev hda, sector 12196299
[  924.439207] usb 2-1.3: USB disconnect, address 5
[  927.618165] usb 2-1.3: new full speed USB device using ohci_hcd and address 6
[  927.831162] usb 2-1.3: New USB device found, idVendor=0930, idProduct=6518
[  927.832696] usb 2-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  927.835727] usb 2-1.3: Product: DataTraveler 2.0
[  927.837376] usb 2-1.3: Manufacturer: Kingston
[  927.839060] usb 2-1.3: SerialNumber: 28C13A40C190A8E6
[  927.841380] usb 2-1.3: configuration #1 chosen from 1 choice
[  927.881687] end_request: I/O error, dev hda, sector 12196299
[  927.883709] end_request: I/O error, dev hda, sector 12196299
[  996.803563] end_request: I/O error, dev hda, sector 3036
[  996.805695] Buffer I/O error on device hda3, logical block 509
[  996.807892] end_request: I/O error, dev hda, sector 68572
[  996.810477] Buffer I/O error on device hda3, logical block 33277
[  996.812868] end_request: I/O error, dev hda, sector 3036
[  996.815293] Buffer I/O error on device hda3, logical block 509
[  996.817826] end_request: I/O error, dev hda, sector 68572
[  996.820616] Buffer I/O error on device hda3, logical block 33277
[  996.830381] end_request: I/O error, dev hda, sector 2020
[  996.833150] Buffer I/O error on device hda3, logical block 1
[  996.835982] lost page write due to I/O error on hda3
[  996.838886] EXT2-fs error (device hda3): ext2_readdir: bad page in #2
[ 1001.620115] end_request: I/O error, dev hda, sector 2028
[ 1001.626411] Buffer I/O error on device hda3, logical block 5
[ 1001.629708] lost page write due to I/O error on hda3
[ 1004.548305] end_request: I/O error, dev hda, sector 3036
[ 1004.551585] Buffer I/O error on device hda3, logical block 509
[ 1004.554790] end_request: I/O error, dev hda, sector 68572
[ 1004.558388] Buffer I/O error on device hda3, logical block 33277
[ 1004.577616] end_request: I/O error, dev hda, sector 2020
[ 1004.580805] Buffer I/O error on device hda3, logical block 1
[ 1004.583969] lost page write due to I/O error on hda3
[ 1004.587124] EXT2-fs error (device hda3): ext2_readdir: bad page in #2
[ 1007.188122] end_request: I/O error, dev hda, sector 3036
[ 1007.191640] Buffer I/O error on device hda3, logical block 509
[ 1007.194931] end_request: I/O error, dev hda, sector 68572
[ 1007.198186] Buffer I/O error on device hda3, logical block 33277
[ 1007.210113] end_request: I/O error, dev hda, sector 2020
[ 1007.213374] Buffer I/O error on device hda3, logical block 1
[ 1007.216627] lost page write due to I/O error on hda3
[ 1007.219875] EXT2-fs error (device hda3): ext2_readdir: bad page in #2
[ 1045.964236] ext3_abort called.
[ 1045.967578] EXT3-fs error (device dm-1): ext3_remount: Abort forced by user
[ 1065.046514] ext3_abort called.
[ 1065.049949] EXT3-fs error (device dm-1): ext3_remount: Abort forced by user
[ 1065.059427] ext3_abort called.
[ 1065.062917] EXT3-fs error (device dm-1): ext3_remount: Abort forced by user
[ 1138.870118] end_request: I/O error, dev hda, sector 10465947
[ 1138.873286] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=306433, block=1245186
[ 1147.874122] end_request: I/O error, dev hda, sector 10465947
[ 1147.877365] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=306433, block=1245186
[ 1151.988242] end_request: I/O error, dev hda, sector 10465947
[ 1151.991690] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=306433, block=1245186
[ 1164.719226] end_request: I/O error, dev hda, sector 6273603
[ 1164.724645] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=181334, block=721143
[ 1175.579326] end_request: I/O error, dev hda, sector 13353043
[ 1175.586419] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=395476, block=1606073
[ 1175.596029] end_request: I/O error, dev hda, sector 13353043
[ 1175.599647] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=395476, block=1606073
[ 1182.702517] end_request: I/O error, dev hda, sector 13448387
[ 1182.706045] end_request: I/O error, dev hda, sector 13448395
[ 1182.709469] end_request: I/O error, dev hda, sector 13448403
[ 1182.712860] end_request: I/O error, dev hda, sector 13448411
[ 1182.720115] end_request: I/O error, dev hda, sector 13448387
[ 1182.723533] end_request: I/O error, dev hda, sector 13448387
[ 1219.710328] end_request: I/O error, dev hda, sector 11665483
[ 1219.713738] end_request: I/O error, dev hda, sector 11665491
[ 1219.717028] end_request: I/O error, dev hda, sector 11665499
[ 1219.720252] end_request: I/O error, dev hda, sector 11665507
[ 1219.724041] end_request: I/O error, dev hda, sector 11665483
[ 1219.727243] end_request: I/O error, dev hda, sector 11665483
[ 1224.813634] end_request: I/O error, dev hda, sector 11665483
[ 1224.816829] end_request: I/O error, dev hda, sector 11665483
[ 1226.117609] end_request: I/O error, dev hda, sector 11665483
[ 1226.120982] end_request: I/O error, dev hda, sector 11665483
[ 1226.964969] end_request: I/O error, dev hda, sector 11665483
[ 1226.968035] end_request: I/O error, dev hda, sector 11665483
[ 1236.659700] usb 2-1.3: USB disconnect, address 6
[ 1239.908662] usb 2-1.3: new full speed USB device using ohci_hcd and address 7
[ 1240.121659] usb 2-1.3: New USB device found, idVendor=0930, idProduct=6518
[ 1240.124502] usb 2-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[ 1240.129933] usb 2-1.3: Product: DataTraveler 2.0
[ 1240.132687] usb 2-1.3: Manufacturer: Kingston
[ 1240.135327] usb 2-1.3: SerialNumber: 28C13A40C190A8E6
[ 1240.138159] usb 2-1.3: configuration #1 chosen from 1 choice
[ 1240.179737] end_request: I/O error, dev hda, sector 12196299
[ 1240.182758] end_request: I/O error, dev hda, sector 12196299
[ 1298.289137] end_request: I/O error, dev hda, sector 10465947
[ 1298.291501] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=306433, block=1245186
[ 1308.119975] end_request: I/O error, dev hda, sector 10465947
[ 1308.121977] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=306433, block=1245186
[ 1373.925868] end_request: I/O error, dev hda, sector 10248979
[ 1373.928710] end_request: I/O error, dev hda, sector 10248987
[ 1373.932248] end_request: I/O error, dev hda, sector 10248995
[ 1373.934904] end_request: I/O error, dev hda, sector 10249003
[ 1373.937432] end_request: I/O error, dev hda, sector 10249011
[ 1373.939882] end_request: I/O error, dev hda, sector 10249019
[ 1373.942301] end_request: I/O error, dev hda, sector 10249027
[ 1373.944657] end_request: I/O error, dev hda, sector 10249035
[ 1373.946946] end_request: I/O error, dev hda, sector 10249043
[ 1373.949169] end_request: I/O error, dev hda, sector 10249051
[ 1373.949178] end_request: I/O error, dev hda, sector 10249059
[ 1373.949186] end_request: I/O error, dev hda, sector 10249067
[ 1373.949194] end_request: I/O error, dev hda, sector 10249075
[ 1373.949201] end_request: I/O error, dev hda, sector 10249083
[ 1373.949208] end_request: I/O error, dev hda, sector 10249091
[ 1373.949215] end_request: I/O error, dev hda, sector 10249099
[ 1373.949222] end_request: I/O error, dev hda, sector 10249107
[ 1373.949229] end_request: I/O error, dev hda, sector 10249115
[ 1373.949236] end_request: I/O error, dev hda, sector 10249123
[ 1373.949243] end_request: I/O error, dev hda, sector 10249131
[ 1373.949250] end_request: I/O error, dev hda, sector 10249139
[ 1373.949361] end_request: I/O error, dev hda, sector 10249099
[ 1387.527157] end_request: I/O error, dev hda, sector 9827155
[ 1387.532621] end_request: I/O error, dev hda, sector 9827155
[ 1387.600391] end_request: I/O error, dev hda, sector 12300955
[ 1387.601853] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=362881, block=1474562
[ 1387.613726] end_request: I/O error, dev hda, sector 9827059
[ 1387.615973] end_request: I/O error, dev hda, sector 12300955
[ 1387.617472] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=362881, block=1474562
[ 1387.621430] end_request: I/O error, dev hda, sector 2274867
[ 1387.623238] end_request: I/O error, dev hda, sector 2274875
[ 1387.625032] end_request: I/O error, dev hda, sector 2274883
[ 1387.626822] end_request: I/O error, dev hda, sector 2274891
[ 1387.628744] end_request: I/O error, dev hda, sector 2274867
[ 1391.608036] end_request: I/O error, dev hda, sector 117093907
[ 1391.612215] Buffer I/O error on device dm-4, logical block 148593
[ 1391.614482] lost page write due to I/O error on dm-4
[ 1461.117615] end_request: I/O error, dev hda, sector 10249099
[ 1483.595980] end_request: I/O error, dev hda, sector 11665483
[ 1483.600025] end_request: I/O error, dev hda, sector 11665483
[ 1564.090515] end_request: I/O error, dev hda, sector 12039595
[ 1564.093623] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=356392, block=1441892
[ 1564.100197] end_request: I/O error, dev hda, sector 12039595
[ 1564.103350] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=356392, block=1441892
[ 1564.109744] end_request: I/O error, dev hda, sector 12039595
[ 1564.112987] EXT3-fs error (device dm-1): ext3_get_inode_loc: unable to read inode block - inode=356392, block=1441892
[ 1584.670563] VFS: Can't find ext3 filesystem on dev hdb5.
[ 1591.240781] VFS: Can't find ext3 filesystem on dev hdb6.
[ 1594.474972] kjournald starting.  Commit interval 5 seconds
[ 1594.479356] EXT3 FS on hdb7, internal journal
[ 1594.483906] EXT3-fs: mounted filesystem with ordered data mode.


> 
> [ BTW the above bisection points that the problem was introduced
> outside of drivers/ide or that it was introduced earlier that we'd
> initially thought ]
> 
> > I have added second hard drive and got new issue. May be this log
> > (dmesg) can tell you something. It is on first known 'bad commit'.
> > 2.6.29.2 can't properly
> 
> It tells us that there is some IRQ routing problem... seems like a
> platform or ide-pmac specific problem.  Does some earlier kernel work
> OK with this configuration?

I have Debian's 2.6.26, it has same problem. Don't take attention to time, I 
caught another bug on Aureal Vortex2, this driver kills kernel completely and
system time too. I am lucky on bugs on this machine.

[477194868.371586] Uniform Multi-Platform E-IDE driver
[477194868.371648] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[477194868.371902] adb: starting probe task...
[477194868.371994] adb: finished probe task...
[477194868.372138] ide-pmac 0002:20:0d.0: enabling device (0000 -> 0002)
[477194869.389956] ide0: Found Apple UniNorth ATA-6 controller, bus ID 3, irq 39
[477194869.390045] Probing IDE interface ide0...
[477194869.678137] hda: IBM-IC35L060AVVA07-0, ATA DISK drive
[477194869.958131] hdb: QUANTUM FIREBALLP LM20.5, ATA DISK drive
[477194870.014152] hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[477194870.014325] hda: UDMA/100 mode selected
[477194870.014533] hdb: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[477194870.014792] hdb: UDMA/66 mode selected
[477194870.015158] ide0 at 0xf100a000-0xf100a070,0xf100a160 on irq 39
[477194871.033954] ide1: Found Apple KeyLargo ATA-4 controller, bus ID 2, irq 19
[477194871.034039] Probing IDE interface ide1...
[477194871.602152] ide1 at 0xf1006000-0xf1006070,0xf1006160 on irq 19
[477194872.621954] ide2: Found Apple KeyLargo ATA-3 controller, bus ID 0, irq 20
[477194872.622034] Probing IDE interface ide2...
[477194873.022132] hde: PHILIPS CDD5101, ATAPI CD/DVD-ROM drive
[477194873.358138] hde: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[477194873.358517] hde: MWDMA2 mode selected
[477194873.358986] ide2 at 0xf100e000-0xf100e070,0xf100e160 on irq 20
[477194873.359673] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
[477194873.359976] ohci_hcd 0001:10:18.0: enabling device (0000 -> 0002)
[477194873.360052] ohci_hcd 0001:10:18.0: OHCI Host Controller
[477194873.360474] ohci_hcd 0001:10:18.0: new USB bus registered, assigned bus number 1
[477194873.360581] ohci_hcd 0001:10:18.0: irq 27, io mem 0x80081000
[477194873.434119] usb usb1: configuration #1 chosen from 1 choice
[477194873.434363] hub 1-0:1.0: USB hub found
[477194873.434435] hub 1-0:1.0: 2 ports detected
[477194873.538660] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[477194873.540998] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[477194873.543333] usb usb1: Product: OHCI Host Controller
[477194873.545636] usb usb1: Manufacturer: Linux 2.6.26-2-powerpc-smp ohci_hcd
[477194873.547962] usb usb1: SerialNumber: 0001:10:18.0
[477194873.550313] ohci_hcd 0001:10:19.0: enabling device (0000 -> 0002)
[477194873.552655] ohci_hcd 0001:10:19.0: OHCI Host Controller
[477194873.555333] ohci_hcd 0001:10:19.0: new USB bus registered, assigned bus number 2
[477194873.557692] ohci_hcd 0001:10:19.0: irq 28, io mem 0x80080000
[477194873.634070] usb usb2: configuration #1 chosen from 1 choice
[477194873.636535] hub 2-0:1.0: USB hub found
[477194873.638834] hub 2-0:1.0: 2 ports detected
[477194873.742460] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[477194873.744780] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[477194873.747109] usb usb2: Product: OHCI Host Controller
[477194873.749418] usb usb2: Manufacturer: Linux 2.6.26-2-powerpc-smp ohci_hcd
[477194873.751762] usb usb2: SerialNumber: 0001:10:19.0
[477194873.770248] mice: PS/2 mouse device common for all mice
[477194873.772918] platform ppc-rtc.0: rtc core: registered ppc_md as rtc0
[477194873.776612] TCP cubic registered
[477194873.779036] NET: Registered protocol family 17
[477194873.781981] registered taskstats version 1
[477194873.784847] input: PMU as /class/input/input1
[477194873.793963] usb 1-1: new low speed USB device using ohci_hcd and address 2
[477194873.802198] platform ppc-rtc.0: hctosys: invalid date/time
[477194873.804636] Freeing unused kernel memory: 236k init
[477194873.968070] usb 1-1: configuration #1 chosen from 1 choice
[477194873.976612] usb 1-1: New USB device found, idVendor=0458, idProduct=002e
[477194873.979066] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[477194873.981456] usb 1-1: Product: NetScroll+ Traveler
[477194873.983818] usb 1-1: Manufacturer: KYE
[477194874.218319] PowerMac i2c bus pmu 2 registered
[477194874.220984] PowerMac i2c bus pmu 1 registered
[477194874.223600] PowerMac i2c bus mac-io 0 registered
[477194874.226120] PowerMac i2c bus uni-n 1 registered
[477194874.228603] PowerMac i2c bus uni-n 0 registered
[477194874.242112] usb 2-1: new full speed USB device using ohci_hcd and address 2
[477194874.407190] usb 2-1: configuration #1 chosen from 1 choice
[477194874.411149] hub 2-1:1.0: USB hub found
[477194874.415076] hub 2-1:1.0: 4 ports detected
[477194874.534293] usb 2-1: New USB device found, idVendor=05e3, idProduct=0608
[477194874.537039] usb 2-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[477194874.539724] usb 2-1: Product: USB2.0 Hub
[477194874.771003] usb 2-1.1: new full speed USB device using ohci_hcd and address 3
[477194874.887185] usb 2-1.1: configuration #1 chosen from 1 choice
[477194874.889897] Linux agpgart interface v0.103
[477194874.890109] hub 2-1.1:1.0: USB hub found
[477194874.891983] hub 2-1.1:1.0: 4 ports detected
[477194874.899579] agpgart: Detected Apple UniNorth 2 chipset
[477194874.902002] agpgart: configuring for size idx: 8
[477194874.904312] agpgart: AGP aperture is 32M @ 0x0
[477194874.987211] hde: ATAPI 32X DVD-ROM CD-R/RW drive, 8192kB Cache
[477194874.989566] Uniform CD-ROM driver Revision: 3.20
[477194875.006296] usb 2-1.1: New USB device found, idVendor=05e3, idProduct=0608
[477194875.008637] usb 2-1.1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[477194875.010921] usb 2-1.1: Product: USB2.0 Hub
[477194875.024719] hda: max request size: 128KiB
[477194875.032590] hda: 120103200 sectors (61492 MB) w/1863KiB Cache, CHS=65535/16/63
[477194875.035083] hda: cache flushes supported
[477194875.037456]  hda: [mac] hda1 hda2 hda3 hda4
[477194875.048662] hdb: max request size: 128KiB
[477194875.057687] sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
[477194875.065337] hdb: 40132503 sectors (20547 MB) w/1900KiB Cache, CHS=39813/16/63
[477194875.067826] hdb: cache flushes not supported
[477194875.070216]  hdb:<7>PHY ID: 2060e1, addr: 0
[477194875.130989] eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:03:93:ab:d1:a6
[477194875.133278] eth0: Found BCM5421 PHY
[477194875.135709] ohci1394 0002:20:0e.0: enabling device (0000 -> 0002)
[477194875.189908] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[40]  MMIO=[f5000000-f50007ff]  Max Packet=[2048]  IR/IT contexts=[8/8]
[477194875.243002] usb 2-1.2: new low speed USB device using ohci_hcd and address 4
[477194875.362206] usb 2-1.2: configuration #1 chosen from 1 choice
[477194875.366594] usb 2-1.2: New USB device found, idVendor=04d9, idProduct=0022
[477194875.369010] usb 2-1.2: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[477194875.371387] usb 2-1.2: Product: USB Keyboard
[477194875.387102] usbcore: registered new interface driver hiddev
[477194875.395057] input: KYE NetScroll+ Traveler as /class/input/input2
[477194875.430143] input,hidraw0: USB HID v1.10 Mouse [KYE NetScroll+ Traveler] on usb-0001:10:18.0-1
[477194875.443051] input: USB Keyboard as /class/input/input3
[477194875.462050] input,hidraw1: USB HID v1.10 Keyboard [USB Keyboard] on usb-0001:10:19.0-1.2
[477194875.484936] input: USB Keyboard as /class/input/input4
[477194875.502025] input,hidraw2: USB HID v1.10 Device [USB Keyboard] on usb-0001:10:19.0-1.2
[477194875.504573] usbcore: registered new interface driver usbhid
[477194875.507035] usbhid: v2.6:USB HID core driver
[477194876.470402] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000393fffeabd1a6]
[477194877.526334] eth0: Link is up at 100 Mbps, full-duplex.
[477194895.065957] ide-pmac lost interrupt, dma status: 8480
[477194895.068535] hdb: lost interrupt
[477194895.070952] hdb: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
[477194895.073444] ide: failed opcode was: unknown
[477194895.076053] hda: DMA disabled
[477194895.078504] hdb: DMA disabled
[477194895.209948] ide0: reset: success
[477194895.430619]  hdb1 hdb2 < hdb5 hdb6 hdb7 hdb8 >


> 
> > initialize it too (got lost interrupt and disable dma).
> > 
> > [    1.113901] Uniform Multi-Platform E-IDE driver
> > [    1.120304] ide-pmac 0002:20:0d.0: enabling device (0000 -> 0002)
> > [    1.123139] adb: starting probe task...
> > [    1.125609] adb: finished probe task...
> > [    2.147653] ide-pmac: Found Apple UniNorth ATA-6 controller
> > (PCI), bus ID 3, irq 39 [    2.152331] Probing IDE interface ide0...
> > [    2.457825] hda: IBM-IC35L060AVVA07-0, ATA DISK drive
> > [    2.817641] hdb: QUANTUM FIREBALLP LM20.5, ATA DISK drive
> > [   66.660447] hda: host max PIO4 wanted PIO255(auto-tune) selected
> > PIO4 [   66.660624] hda: UDMA/100 mode selected
> > [   66.663170] hdb: host max PIO4 wanted PIO255(auto-tune) selected
> > PIO4 [   66.663415] hdb: UDMA/66 mode selected
> > [   66.666108] ide0 at 0xf1012000-0xf1012070,0xf1012160 on irq 39
> > [   67.697640] ide-pmac: Found Apple KeyLargo ATA-4 controller
> > (macio), bus ID 2, irq 19 [   67.702368] Probing IDE interface
> > ide1... [  131.867685] ide1 at 0xf100e000-0xf100e070,0xf100e160 on
> > irq 19 [  132.897559] ide-pmac: Found Apple KeyLargo ATA-3
> > controller (macio), bus ID 0, irq 20 [  132.902273] Probing IDE
> > interface ide2... [  196.898053] hde: PHILIPS CDD5101, ATAPI
> > CD/DVD-ROM drive [  260.980668] hde: host max PIO4 wanted
> > PIO255(auto-tune) selected PIO4 [  260.981049] hde: MWDMA2 mode
> > selected [  260.984269] ide2 at 0xf1016000-0xf1016070,0xf1016160 on
> > irq 20 [  260.989418] ide-gd driver 1.18
> > [  260.991880] hda: max request size: 128KiB
> > [  261.039649] hda: 120103200 sectors (61492 MB) w/1863KiB Cache,
> > CHS=65535/16/63 [  261.044690] hda: cache flushes supported
> > [  261.047292]  hda: [mac] hda1 hda2 hda3 hda4
> > [  261.060150] hdb: max request size: 128KiB
> > [  261.089788] hdb: 40132503 sectors (20547 MB) w/1900KiB Cache,
> > CHS=39813/16/63 [  261.092287] hdb: cache flushes not supported
> > [  261.094754]  hdb:<3>ide-pmac lost interrupt, dma status: 8480
> > [  281.089717] hdb: lost interrupt
> > [  281.092085] hdb: dma_intr: status=0x58 { DriveReady SeekComplete
> > DataRequest } [  281.097038] ide: failed opcode was: unknown
> > [  281.101900] hda: DMA disabled
> > [  281.104247] hdb: DMA disabled
> > [  281.187260] ide0: reset: success
> > [  281.230368]  hdb1 hdb2 < hdb5 hdb6 hdb7 hdb8 >
> > [  281.285486] ide-cd driver 5.00
> > [  281.297481] ide-cd: hde: ATAPI 32X DVD-ROM CD-R/RW drive, 8192kB
> > Cache [  281.299687] Uniform CD-ROM driver Revision: 3.20
> 
