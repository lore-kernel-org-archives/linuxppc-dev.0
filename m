Return-Path: <a.gusev1980@mail.ru>
Received: from mx27.mail.ru (mx27.mail.ru [94.100.176.41])
	by ozlabs.org (Postfix) with ESMTP id BDE72DDDF4
	for <linuxppc-dev@ozlabs.org>; Sat, 30 May 2009 20:46:48 +1000 (EST)
Date: Sat, 30 May 2009 14:46:43 +0400
From: Andrey Gusev <a.gusev1980@mail.ru>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Delay on intialization ide subsystem(most likely)
Message-ID: <20090530144643.76cb456e@power-debian>
In-Reply-To: <200905201756.14769.bzolnier@gmail.com>
References: <20090425170203.74603b9c@power-debian>
	<200905132046.33663.bzolnier@gmail.com>
	<20090516004007.3a7b9787@power-debian>
	<200905201756.14769.bzolnier@gmail.com>
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

On Wed, 20 May 2009 17:56:14 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> On Friday 15 May 2009 22:40:07 Andrey Gusev wrote:
> > On Wed, 13 May 2009 20:46:33 +0200
> > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > 
> > > On Wednesday 13 May 2009 19:11:23 Andrey Gusev wrote:
> > > > On Wed, 13 May 2009 15:28:26 +0200
> > > > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > > > 
> > > > > On Tuesday 12 May 2009 21:50:24 Andrey Gusev wrote:
> > > > > > On Mon, 27 Apr 2009 23:21:48 +0200
> > > > > > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > > > > > 
> > > > > > > On Monday 27 April 2009 22:36:45 Andrey Gusev wrote:
> > > > > > > > On Sat, 25 Apr 2009 16:48:38 +0200
> > > > > > > > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Hi,
> > > > > > > > > 
> > > > > > > > > On Saturday 25 April 2009 15:02:03 Andrey Gusev wrote:
> > > > > > > > > > Hello!
> > > > > > > > > > 
> > > > > > > > > > I have tested linux-2.6.30-rc3 on my system and find
> > > > > > > > > > some problems. One of them is delaying on
> > > > > > > > > > initialization IDE subsystem. I don't have this
> > > > > > > > > > problem on 2.6.29.1. The difference is looked on
> > > > > > > > > > log of dmesg.
> > > > > > > > > 
> > > > > > > > > Unfortunately this doesn't give us any hint about the
> > > > > > > > > root cause of the bug so please try narrowing the
> > > > > > > > > problem down to the specific change using git-bisect
> > > > > > > > > (sorry, there were 212 drivers/ide/ commits during
> > > > > > > > > v2.6.29..v2.6.30-rc3 and much much more
> > > > > > > > > non-drivers/ide/ ones).
> > > > > > > > > 
> > > > > > > > > Thanks,
> > > > > > > > > Bart
> > > > > > > > > 
> > > > > > > > 
> > > > > > > > Hello!
> > > > > > > > 
> > > > > > > > 
> > > > > > > > The full result of bisect is:
> > > > > > > > 
> > > > > > > > 
> > > > > > > > git bisect start
> > > > > > > > # good: [8e0ee43bc2c3e19db56a4adaa9a9b04ce885cd84] Linux
> > > > > > > > 2.6.29 git bisect good
> > > > > > > > 8e0ee43bc2c3e19db56a4adaa9a9b04ce885cd84 # bad:
> > > > > > > > [091069740304c979f957ceacec39c461d0192158] Linux
> > > > > > > > 2.6.30-rc3 git bisect bad
> > > > > > > > 091069740304c979f957ceacec39c461d0192158 # good:
> > > > > > > > [40f07111be99b71c1e8d40c13cdc38445add787f] V4L/DVB
> > > > > > > > (11166): pvrusb2: Implement status fetching from
> > > > > > > > sub-devices git bisect good
> > > > > > > > 40f07111be99b71c1e8d40c13cdc38445add787f # good:
> > > > > > > > [ba0e1ebb7ea0616eebc29d2077355bacea62a9d8] Staging:
> > > > > > > > sxg: slicoss: Specify the license for Sahara SXG and
> > > > > > > > Slicoss drivers git bisect good
> > > > > > > > ba0e1ebb7ea0616eebc29d2077355bacea62a9d8
> > > > > > > > 
> > > > > > > > 
> > > > > > > > git bisect start 'drivers/ide/'
> > > > > > > 
> > > > > > > Please note that limiting search space to drivers/ide/
> > > > > > > may not give reliable results in case problem was
> > > > > > > introduced by some other kernel area.
> > > > > > > 
> > > > > > > > # good: [ba0e1ebb7ea0616eebc29d2077355bacea62a9d8]
> > > > > > > > Staging: sxg: slicoss: Specify the license for Sahara
> > > > > > > > SXG and Slicoss drivers git bisect good
> > > > > > > > ba0e1ebb7ea0616eebc29d2077355bacea62a9d8 # bad:
> > > > > > > > [091069740304c979f957ceacec39c461d0192158] Linux
> > > > > > > > 2.6.30-rc3 git bisect bad
> > > > > > > > 091069740304c979f957ceacec39c461d0192158 # good:
> > > > > > > > [e01f251fd09fa7cb3d352eac7de17bb5d5bd1f9d] ide-cd:
> > > > > > > > convert cdrom_decode_status() to use switch statements
> > > > > > > > git bisect good
> > > > > > > > e01f251fd09fa7cb3d352eac7de17bb5d5bd1f9d # good:
> > > > > > > > [3153c26b54230d025c6d536e8d3015def4524906] ide:
> > > > > > > > refactor tf_read() method git bisect good
> > > > > > > > 3153c26b54230d025c6d536e8d3015def4524906 # good:
> > > > > > > > [c018f1ee5cf81e58b93d9e93a2ee39cad13dc1ac] hpt366: fix
> > > > > > > > HPT370 DMA timeouts git bisect good
> > > > > > > > c018f1ee5cf81e58b93d9e93a2ee39cad13dc1ac # bad:
> > > > > > > > [d5f840bf74c09ca5a31e518c9d984999926b5f44] ide: Remove
> > > > > > > > void casts git bisect bad
> > > > > > > > d5f840bf74c09ca5a31e518c9d984999926b5f44 # bad:
> > > > > > > > [59c8d04f5ee97ea46da854e9adbbaa45d988c39d] hpt366: use
> > > > > > > > ATA_DMA_* constants git bisect bad
> > > > > > > > 59c8d04f5ee97ea46da854e9adbbaa45d988c39d
> > > > > > > 
> > > > > > > Uhh.. something went wrong during bisect.
> > > > > > > 
> > > > > > > "hpt366: use ATA_DMA_* constants" cannot be a first bad
> > > > > > > commit because hpt366 is not even used on this system.
> > > > > > > 
> > > > > > > Could it be that the delay doesn't happen on every boot
> > > > > > > for "bad" kernels?
> > > > > > > 
> > > > > > > Also, is 2.6.30-rc1 okay?
> > > > > > > 
> > > > > > > Thanks,
> > > > > > > Bart
> > > > > > > 
> > > > > > 
> > > > > > Hello all!
> > > > > > 
> > > > > > I continue to find reason of bug. I made more testing with
> > > > > > bisect and got result:
> > > > > > 
> > > > > > git bisect start
> > > > > > # bad: [c018f1ee5cf81e58b93d9e93a2ee39cad13dc1ac] hpt366:
> > > > > > fix HPT370 DMA timeouts git bisect bad
> > > > > >  # good:
> > > > > > [fb4252e59452c18b88af014a2c4ee697bbf8cbc6] at91_ide: turn on
> > > > > > PIO 6 support git bisect good
> > > > > > fb4252e59452c18b88af014a2c4ee697bbf8cbc6 # good:
> > > > > > [2e1c63b7ed36532b68f0eddd6a184d7ba1013b89] Merge branch
> > > > > > 'for-rc1/xen/core' of
> > > > > > git://git.kernel.org/pub/scm/linux/kernel/git/jeremy/xen git
> > > > > > bisect good 2e1c63b7ed36532b68f0eddd6a184d7ba1013b89 # bad:
> > > > > > [cd97824994042b809493807ea644ba26c0c23290] Merge
> > > > > > git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6
> > > > > > git bisect bad cd97824994042b809493807ea644ba26c0c23290 #
> > > > > > bad: [a2c252ebdeaab28c9b400570594d576dae295958] Merge
> > > > > > git://git.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-2.6-fixes
> > > > > > git bisect bad a2c252ebdeaab28c9b400570594d576dae295958 #
> > > > > > good: [b897e6fbc49dd84b2634bca664344d503b907ce9] Merge
> > > > > > branch 'drm-intel-next' of
> > > > > > git://git.kernel.org/pub/scm/linux/kernel/git/anholt/drm-intel
> > > > > > git bisect good b897e6fbc49dd84b2634bca664344d503b907ce9 #
> > > > > > good: [dfbc4752eab33e66f113f9daa2effbe241cd661d] brd:
> > > > > > support barriers git bisect good
> > > > > > dfbc4752eab33e66f113f9daa2effbe241cd661d # good:
> > > > > > [a23c218bd36e11120daf18e00a91d5dc20e288e6] Merge branch
> > > > > > 'merge' of
> > > > > > git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc
> > > > > > git bisect good a23c218bd36e11120daf18e00a91d5dc20e288e6 #
> > > > > > good: [23da64b4714812b66ecf010e7dfb3ed1bf2eda69] Merge
> > > > > > branch 'for-linus' of git://git.kernel.dk/linux-2.6-block
> > > > > > git bisect good 23da64b4714812b66ecf010e7dfb3ed1bf2eda69 #
> > > > > > good: [a228df6339e0d385b8149c860d81b6007f5e9c81] GFS2: Move
> > > > > > umount flush rwsem git bisect good
> > > > > > a228df6339e0d385b8149c860d81b6007f5e9c81 # skip:
> > > > > > [1328df725239804ae30fc7257c1a3185e679b517] GFS2: Use
> > > > > > DEFINE_SPINLOCK git bisect skip
> > > > > > 1328df725239804ae30fc7257c1a3185e679b517 # good:
> > > > > > [10d2198805d7faa2b193485446ff6b1de42c9b78] GFS2: cleanup
> > > > > > file_operations mess git bisect good
> > > > > > 10d2198805d7faa2b193485446ff6b1de42c9b78
> > > > > > 
> > > > > > As I understand, I found bad commit, but it includes 5
> > > > > > commits. I checked them and they are good. So, I did git
> > > > > > checkout a2c252ebdeaab28c9b400570594d576dae295958 and test
> > > > > > one more time this commit. I found that bag is unstable.
> > > > > > The boot can be bad or good on this commit. I compared
> > > > > > dmesg of 'bad' and 'good' booting, but it is equal till
> > > > > > delay. 
> > > > > 
> > > > > Thanks for doing it.
> > > > > 
> > > > > > Any suggestions?
> > > > > 
> > > > > Hard to tell...
> > > > > 
> > > > > I went through all commits in-between
> > > > > 
> > > > > 	fb4252e59452c18b88af014a2c4ee697bbf8cbc6
> > > > > 
> > > > > and
> > > > > 
> > > > > 	a2c252ebdeaab28c9b400570594d576dae295958
> > > > > 
> > > > > and there are no obvious candidates..
> > > > > 
> > > > > Could you please refresh my memory and tell me whether
> > > > > 2.6.30-rc2 was OK?
> > > > > 
> > > > 
> > > > It was ok, but I don't sure now. I tested only one boot, but
> > > > this problem is not stable. I am rechecking it.
> > > 
> > > Ok.
> > > 
> > > Please also recheck first 'good' commit if 2.6.30-rc2 turns out
> > > to be 'bad'.
> > 
> > My last testing is very interesting. I check boot of each kernel at
> > least 10 times. I checked 2.6.30-rc2, it is good. Rest results:
> > 
> > git bisect start
> > # good: [0882e8dd3aad33eca41696d463bb896e6c8817eb] Linux 2.6.30-rc2
> > git bisect good 0882e8dd3aad33eca41696d463bb896e6c8817eb
> > # bad: [a2c252ebdeaab28c9b400570594d576dae295958] Merge
> > git://git.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-2.6-fixes
> > git bisect bad a2c252ebdeaab28c9b400570594d576dae295958 # good:
> > [c2572f2b4ffc27ba79211aceee3bef53a59bb5cd] brd: fix cacheflushing
> > git bisect good c2572f2b4ffc27ba79211aceee3bef53a59bb5cd # bad:
> > [b71a0c296cee4debaf446760fbd29ead1587a7ac] powerpc: pseries/dtl.c
> > should include asm/firmware.h git bisect bad
> > b71a0c296cee4debaf446760fbd29ead1587a7ac
> > 
> > Last commit had delay only on 10 time, but it ripped my system, I
> > can't read any place on my hard drive. I can't mount any other
> > device on it. Fortunately, I have tmpfs and I mounted second hard
> > disk on it place. After my computer didn't turn on. It looks like
> > dead drive or controller, but after on/off and replace disks, it
> > has alived. Below is log of this bad boot.
> 
> I think that is an old problem which for some reasons gets triggered
> more easily in newer kernels or a hardware issue (or just combination
> of both).

Could it be RCU (it is experimental implementation in this configuratin)
related? I have booted 2.6.30-rc6, sometimes it has long delay (about 66
seconds) after: "[    0.000000] Experimental hierarchical RCU implementation."
Currently I have it enabled on 2.6.29.4 and don't have any problems. 
I made photos of boots and some faults:
http://img17.imageshack.us/img17/149/dscn4403b.jpg
http://img21.imageshack.us/img21/254/dscn4407v.jpg
http://img21.imageshack.us/img21/4919/dscn4413.jpg
http://img14.imageshack.us/img14/1230/dscn4414y.jpg
http://img13.imageshack.us/img13/878/dscn4419c.jpg
It is not very good photo, but it is difficult to shoot monitor.
It looks like same delay.

> 
> [...]
> 
> > > [ BTW the above bisection points that the problem was introduced
> > > outside of drivers/ide or that it was introduced earlier that we'd
> > > initially thought ]
> > > 
> > > > I have added second hard drive and got new issue. May be this
> > > > log (dmesg) can tell you something. It is on first known 'bad
> > > > commit'. 2.6.29.2 can't properly
> > > 
> > > It tells us that there is some IRQ routing problem... seems like a
> > > platform or ide-pmac specific problem.  Does some earlier kernel
> > > work OK with this configuration?
> > 
> > I have Debian's 2.6.26, it has same problem. Don't take attention
> > to time, I caught another bug on Aureal Vortex2, this driver kills
> > kernel completely and system time too. I am lucky on bugs on this
> > machine.
> 
> [...]
> 
> > [477194869.958131] hdb: QUANTUM FIREBALLP LM20.5, ATA DISK drive
> 
> [...]
> 
> > [477194895.065957] ide-pmac lost interrupt, dma status: 8480
> > [477194895.068535] hdb: lost interrupt
> > [477194895.070952] hdb: dma_intr: status=0x58 { DriveReady
> > SeekComplete DataRequest } [477194895.073444] ide: failed opcode
> > was: unknown [477194895.076053] hda: DMA disabled
> > [477194895.078504] hdb: DMA disabled
> > [477194895.209948] ide0: reset: success
> > [477194895.430619]  hdb1 hdb2 < hdb5 hdb6 hdb7 hdb8 >
> 
> This drive is one of the "quirky" drives which has special
> workarounds in some host drivers...
> 
> OK, lets try something else.  I went through IDE code and fixed
> outstanding issues which may be related to these problems + mixed-in
> pending bugfixes.

There is dmesg of 2.6.30-rc6 with patch, I could logged in only once, 
2 boots couldn't give me such ability.
[    0.000000] Using PowerMac machine description
[    0.000000] Total memory = 1536MB; using 4096kB for hash table (at cfc00000)
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.30-rc6 (andrey@power-debian) (gcc version 4.3.3 (Debian 4.3.3-10) ) #23 SMP PREEMPT Sat May 30 12:24:28 MSD 2009
[    0.000000] Found initrd at 0xc1a00000:0xc1f15800
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
[    0.000000] free_area_init_node: node 0, pgdat c042c4a0, node_mem_map c04a9000
[    0.000000]   DMA zone: 1536 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 195072 pages, LIFO batch:31
[    0.000000]   HighMem zone: 1536 pages used for memmap
[    0.000000]   HighMem zone: 195072 pages, LIFO batch:31
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 390144
[    0.000000] Kernel command line: root=/dev/mapper/power--group-root ro 
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
[    0.000299] Console: colour dummy device 80x25
[    0.000467] console handover: boot [udbg0] -> real [tty0]
[    0.000703] irq: irq 22 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 22
[    0.000743] irq: irq 23 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 23
[    0.001698] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.002871] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.217079] High memory: 786432k
[    0.217091] Memory: 1544188k/1572864k available (4132k kernel code, 27588k reserved, 152k data, 332k bss, 224k init)
[    0.217248] SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.217278] Calibrating delay loop... 66.56 BogoMIPS (lpj=332800)
[    0.430489] Security Framework initialized
[    0.430535] Mount-cache hash table entries: 512
[    0.431106] device-tree: Duplicate name in /cpus/PowerPC,G4@0/l2-cache, renamed to "l2-cache#1"
[    0.431211] device-tree: Duplicate name in /cpus/PowerPC,G4@0, renamed to "l2-cache#1"
[    0.431349] device-tree: Duplicate name in /cpus/PowerPC,G4@1/l2-cache, renamed to "l2-cache#1"
[    0.431447] device-tree: Duplicate name in /cpus/PowerPC,G4@1, renamed to "l2-cache#1"
[    0.434910] Initializing cgroup subsys ns
[    0.434928] Initializing cgroup subsys cpuacct
[    0.434955] Initializing cgroup subsys devices
[    0.434968] Initializing cgroup subsys freezer
[    0.435346] PowerMac SMP probe found 2 cpus
[    0.435461] irq: irq 42 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 42
[    0.435511] KeyWest i2c @0xf8001003 irq 42 /uni-n@f8000000/i2c@f8001000
[    0.435529]  channel 0 bus <multibus>
[    0.435540]  channel 1 bus <multibus>
[    0.435580] irq: irq 26 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 26
[    0.435595] KeyWest i2c @0x80018000 irq 26 /pci@f2000000/mac-io@17/i2c@18000
[    0.435616]  channel 0 bus <multibus>
[    0.435636] PMU i2c /pci@f2000000/mac-io@17/via-pmu@16000/pmu-i2c
[    0.435654]  channel 1 bus <multibus>
[    0.435668]  channel 2 bus <multibus>
[    0.435694] pmf: no parser for command 17 !
[    0.435755] Processor timebase sync using GPIO 0x73
[    0.435773] mpic: requesting IPIs ... 
[    0.435794] irq: irq 251 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 251
[    0.435812] irq: irq 252 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 252
[    0.435828] irq: irq 253 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 253
[    0.435845] irq: irq 254 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 254
[    0.435855] CPU0: L2CR is 80080000
[    0.435869] CPU0: L3CR is 8f0b0000
[477194875.410567] CPU1: L2CR was 80000
[477194875.410605] CPU1: L2CR set to 80080000
[477194875.410611] CPU1: L3CR was 0
[477194875.410772] CPU1: L3CR set to 8f0b0000
[    0.437521] Processor 1 found.
[    0.437581] clockevent: decrementer mult[886] shift[16] cpu[1]
[    0.437626] Brought up 2 CPUs
[    0.437800] CPU0 attaching sched-domain:
[    0.437810]  domain 0: span 0-1 level CPU
[    0.437819]   groups: 0 1
[    0.437836] CPU1 attaching sched-domain:
[    0.437843]  domain 0: span 0-1 level CPU
[    0.437850]   groups: 1 0
[    0.448443] net_namespace: 568 bytes
[    0.448942] NET: Registered protocol family 16
[    0.450512] irq: irq 25 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 25
[    0.450568] irq: irq 47 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 47
[    0.451112] PCI: Probing PCI hardware
[    0.451419] pci 0000:00:10.0: reg 10 32bit mmio: [0x91000000-0x91ffffff]
[    0.451432] pci 0000:00:10.0: reg 14 32bit mmio: [0x98000000-0x9fffffff]
[    0.451444] pci 0000:00:10.0: reg 18 32bit mmio: [0x000000-0x07ffff]
[    0.451467] pci 0000:00:10.0: reg 30 32bit mmio: [0x90000000-0x9001ffff]
[    0.451571] irq: irq 48 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 48
[    0.452134] pci 0001:10:15.0: reg 10 32bit mmio: [0x800c0000-0x800fffff]
[    0.452147] pci 0001:10:15.0: reg 14 io port: [0x410-0x417]
[    0.452159] pci 0001:10:15.0: reg 18 io port: [0x400-0x407]
[    0.452203] pci 0001:10:15.0: supports D2
[    0.452236] pci 0001:10:17.0: reg 10 32bit mmio: [0x80000000-0x8007ffff]
[    0.452299] pci 0001:10:18.0: reg 10 32bit mmio: [0x80081000-0x80081fff]
[    0.452365] pci 0001:10:19.0: reg 10 32bit mmio: [0x80080000-0x80080fff]
[    0.452466] irq: irq 58 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 58
[    0.452514] irq: irq 27 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 27
[    0.452560] irq: irq 28 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 28
[    0.453522] pci 0002:20:0d.0: reg 10 32bit mmio: [0xf5004000-0xf5007fff]
[    0.453589] pci 0002:20:0e.0: reg 10 32bit mmio: [0xf5000000-0xf5000fff]
[    0.453636] pci 0002:20:0e.0: supports D1 D2
[    0.453643] pci 0002:20:0e.0: PME# supported from D0 D1 D2 D3hot
[    0.453670] pci 0002:20:0e.0: PME# disabled
[    0.453709] pci 0002:20:0f.0: reg 10 32bit mmio: [0xf5200000-0xf53fffff]
[    0.453739] pci 0002:20:0f.0: reg 30 32bit mmio: [0xf5100000-0xf51fffff]
[    0.453820] irq: irq 39 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 39
[    0.453856] irq: irq 40 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 40
[    0.453896] irq: irq 41 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 41
[    0.454602] PCI 0001:10 Cannot reserve Legacy IO [0x00-0xfff]
[    0.454630] pci_bus 0000:00: resource 0 io:  [0x802000-0x1001fff]
[    0.454638] pci_bus 0000:00: resource 1 mem: [0xf1000000-0xf1ffffff]
[    0.454647] pci_bus 0000:00: resource 2 mem: [0x90000000-0xafffffff]
[    0.454655] pci_bus 0001:10: resource 0 io:  [0x00-0x7fffff]
[    0.454663] pci_bus 0001:10: resource 1 mem: [0xf3000000-0xf3ffffff]
[    0.454672] pci_bus 0001:10: resource 2 mem: [0x80000000-0x8fffffff]
[    0.454681] pci_bus 0002:20: resource 0 io:  [0xff7fe000-0xffffdfff]
[    0.454689] pci_bus 0002:20: resource 1 mem: [0xf5000000-0xf5ffffff]
[    0.509190] bio: create slab <bio-0> at 0
[    0.510100] usbcore: registered new interface driver usbfs
[    0.510328] usbcore: registered new interface driver hub
[    0.510530] usbcore: registered new device driver usb
[    0.557749] Switched to high resolution mode on CPU 0
[    0.558830] NET: Registered protocol family 2
[    0.567707] Switched to high resolution mode on CPU 1
[    0.657889] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.658894] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.661220] TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
[    0.662927] TCP: Hash tables configured (established 131072 bind 65536)
[    0.662957] TCP reno registered
[    0.687989] NET: Registered protocol family 1
[    0.688239] Trying to unpack rootfs image as initramfs...
[    1.026390] Freeing initrd memory: 5206k freed
[    1.027461] Thermal assist unit not available
[    1.028036] setup_kcore: restrict size=3fffffff
[    1.040922] audit: initializing netlink socket (disabled)
[    1.040982] type=2000 audit(1243661004.030:1): initialized
[    1.041564] highmem bounce pool size: 64 pages
[    1.050059] VFS: Disk quotas dquot_6.5.2
[    1.050438] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.068976] msgmni has been set to 1492
[    1.069868] alg: No test for stdrng (krng)
[    1.069953] alg: No test for stdrng (ansi_cprng)
[    1.069996] io scheduler noop registered
[    1.070012] io scheduler anticipatory registered
[    1.070028] io scheduler deadline registered
[    1.070275] io scheduler cfq registered (default)
[    1.080864] nvidiafb: Device ID: 10de0172 
[    1.117762] nvidiafb: CRTC0 analog not found
[    1.157725] nvidiafb: CRTC1 analog found
[    1.301505] i2c-adapter i2c-0: unable to read EDID block.
[    1.521499] i2c-adapter i2c-0: unable to read EDID block.
[    1.741499] i2c-adapter i2c-0: unable to read EDID block.
[    2.127735] nvidiafb: EDID found from BUS2
[    2.127783] nvidiafb: CRTC 1appears to have a CRT attached
[    2.127803] nvidiafb: Using CRT on CRTC 1
[    2.151593] Console: switching to colour frame buffer device 160x64
[    2.155252] nvidiafb: PCI nVidia NV17 framebuffer (32MB @ 0x98000000)
[    2.194786] Generic non-volatile memory driver v1.1
[    2.194964] Linux agpgart interface v0.103
[    2.195037] agpgart-uninorth 0000:00:0b.0: Apple UniNorth 2 chipset
[    2.195274] agpgart-uninorth 0000:00:0b.0: configuring for size idx: 8
[    2.195489] agpgart-uninorth 0000:00:0b.0: AGP aperture is 32M @ 0x0
[    2.195720] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    2.196765] pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
[    2.196843] ttyPZ0 at MMIO 0x80013020 (irq = 22) is a Z85c30 ESCC - Serial port
[    2.197041] ttyPZ1 at MMIO 0x80013000 (irq = 23) is a Z85c30 ESCC - Serial port
[    2.211980] brd: module loaded
[    2.214174] loop: module loaded
[    2.214293] MacIO PCI driver attached to Keylargo chipset
[    2.215251] irq: irq 32 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 32
[    2.215767] irq: irq 19 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 19
[    2.215791] irq: irq 11 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 16
[    2.215974] irq: irq 20 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 20
[    2.215997] irq: irq 12 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 17
[    2.216189] irq: irq 5 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 18
[    2.216212] irq: irq 6 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 21
[    2.216460] irq: irq 7 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 24
[    2.216483] irq: irq 8 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 29
[    2.217261] input: Macintosh mouse button emulation as /class/input/input0
[    2.218084] Uniform Multi-Platform E-IDE driver
[    2.220358] adb: starting probe task...
[    2.220432] adb: finished probe task...
[    2.220622] ide-pmac 0002:20:0d.0: enabling device (0000 -> 0002)
[    3.247734] ide-pmac: Found Apple UniNorth ATA-6 controller (PCI), bus ID 3, irq 39
[    3.247823] Probing IDE interface ide0...
[    3.547915] hda: IBM-IC35L060AVVA07-0, ATA DISK drive
[    3.907729] hdb: QUANTUM FIREBALLP LM20.5, ATA DISK drive
[   66.830570] hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[   66.830747] hda: UDMA/100 mode selected
[   66.830945] hdb: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[   66.831191] hdb: UDMA/66 mode selected
[   66.831568] ide0 at 0xf1012000-0xf1012070,0xf1012160 on irq 39
[   67.867729] ide-pmac: Found Apple KeyLargo ATA-4 controller (macio), bus ID 2, irq 19
[   67.867805] Probing IDE interface ide1...
[   68.477787] ide1 at 0xf100e000-0xf100e070,0xf100e160 on irq 19
[   68.477882] ide-pmac: probe of 0.0001f000:ata-4 failed with error -1
[   69.507728] ide-pmac: Found Apple KeyLargo ATA-3 controller (macio), bus ID 0, irq 20
[   69.507797] Probing IDE interface ide1...
[   69.927909] hdc: PHILIPS CDD5101, ATAPI CD/DVD-ROM drive
[   70.287747] sysfs: cannot create duplicate filename '/class/ide_port/ide1'
[   70.287841] ------------[ cut here ]------------
[   70.287879] Badness at fs/sysfs/dir.c:487
[   70.287914] NIP: c01119f0 LR: c01119f0 CTR: 00000000
[   70.287956] REGS: ef84db20 TRAP: 0700   Not tainted  (2.6.30-rc6)
[   70.289743] MSR: 00029032 <EE,ME,CE,IR,DR>  CR: 22000082  XER: 00000000
[   70.291580] TASK = ef850000[1] 'swapper' THREAD: ef84c000 CPU: 0
[   70.291632] GPR00: c01119f0 ef84dbd0 ef850000 00000051 00001032 ffffffff ffffffff 00000000 
[   70.293489] GPR08: f40e0000 00000001 00000000 00000000 42000044 00000000 0176c0fc 0176c120 
[   70.295353] GPR16: 0180ca40 0176c128 01795c40 0176bd24 c0221fa4 c044845c c039a164 ef99e0f8 
[   70.297238] GPR24: c1849b40 ef84dd08 c1846a88 ef84dc28 ffffffef ef84dbf8 c18442a0 ef823000 
[   70.300954] NIP [c01119f0] sysfs_add_one+0x7c/0xa0
[   70.302789] LR [c01119f0] sysfs_add_one+0x7c/0xa0
[   70.304606] Call Trace:
[   70.306415] [ef84dbd0] [c01119f0] sysfs_add_one+0x7c/0xa0 (unreliable)
[   70.308283] [ef84dbf0] [c01120f4] create_dir+0x58/0xb4
[   70.310140] [ef84dc20] [c011219c] sysfs_create_dir+0x4c/0x70
[   70.312019] [ef84dc40] [c01a498c] kobject_add_internal+0xdc/0x1b8
[   70.313895] [ef84dc60] [c01a4cac] kobject_add+0x80/0x98
[   70.315768] [ef84dc90] [c020b4b0] device_add+0xe0/0x5dc
[   70.317639] [ef84dcd0] [c020ba74] device_create_vargs+0x98/0xd0
[   70.319517] [ef84dd00] [c020baec] device_create+0x40/0x50
[   70.321402] [ef84dd30] [c02237d4] ide_host_register+0x370/0x690
[   70.323288] [ef84dd80] [c0301418] pmac_ide_setup_device+0x444/0x46c
[   70.325192] [ef84de00] [c03015f8] pmac_ide_macio_attach+0x1b8/0x218
[   70.327117] [ef84de60] [c02169cc] macio_device_probe+0x64/0x8c
[   70.329042] [ef84de80] [c020de1c] driver_probe_device+0xb8/0x180
[   70.330965] [ef84dea0] [c020df54] __driver_attach+0x70/0xa4
[   70.332885] [ef84dec0] [c020d5d0] bus_for_each_dev+0x5c/0xac
[   70.334797] [ef84def0] [c020dc48] driver_attach+0x24/0x34
[   70.336699] [ef84df00] [c020ce1c] bus_add_driver+0xb4/0x218
[   70.338596] [ef84df20] [c020e2f8] driver_register+0xd0/0x170
[   70.340493] [ef84df40] [c0216894] macio_register_driver+0x28/0x38
[   70.342385] [ef84df50] [c03f6f10] pmac_ide_probe+0x58/0x80
[   70.344284] [ef84df60] [c0003b50] do_one_initcall+0x58/0x1ac
[   70.346184] [ef84dfd0] [c03d1304] kernel_init+0x164/0x1d4
[   70.348074] [ef84dff0] [c0014d08] kernel_thread+0x4c/0x68
[   70.349948] Instruction dump:
[   70.351800] 807d0000 7fe4fb78 4bffff51 3c80c037 38848ff0 4bf0965d 809e0010 4bf09655 
[   70.353775] 7c641b78 3c60c038 38632db8 481e9f7d <0fe00000> 7fe3fb78 4bfa8629 80010024 
[   70.355775] kobject_add_internal failed for ide1 with -EEXIST, don't try to register things with the same name in the same directory.
[   70.357743] Call Trace:
[   70.359703] [ef84dc00] [c00089b8] show_stack+0x4c/0x14c (unreliable)
[   70.361695] [ef84dc40] [c01a4a38] kobject_add_internal+0x188/0x1b8
[   70.363670] [ef84dc60] [c01a4cac] kobject_add+0x80/0x98
[   70.365641] [ef84dc90] [c020b4b0] device_add+0xe0/0x5dc
[   70.367627] [ef84dcd0] [c020ba74] device_create_vargs+0x98/0xd0
[   70.369617] [ef84dd00] [c020baec] device_create+0x40/0x50
[   70.371573] [ef84dd30] [c02237d4] ide_host_register+0x370/0x690
[   70.373510] [ef84dd80] [c0301418] pmac_ide_setup_device+0x444/0x46c
[   70.375455] [ef84de00] [c03015f8] pmac_ide_macio_attach+0x1b8/0x218
[   70.377391] [ef84de60] [c02169cc] macio_device_probe+0x64/0x8c
[   70.379351] [ef84de80] [c020de1c] driver_probe_device+0xb8/0x180
[   70.381295] [ef84dea0] [c020df54] __driver_attach+0x70/0xa4
[   70.383215] [ef84dec0] [c020d5d0] bus_for_each_dev+0x5c/0xac
[   70.385116] [ef84def0] [c020dc48] driver_attach+0x24/0x34
[   70.386999] [ef84df00] [c020ce1c] bus_add_driver+0xb4/0x218
[   70.388870] [ef84df20] [c020e2f8] driver_register+0xd0/0x170
[   70.390709] [ef84df40] [c0216894] macio_register_driver+0x28/0x38
[   70.392540] [ef84df50] [c03f6f10] pmac_ide_probe+0x58/0x80
[   70.394362] [ef84df60] [c0003b50] do_one_initcall+0x58/0x1ac
[   70.396190] [ef84dfd0] [c03d1304] kernel_init+0x164/0x1d4
[   70.398026] [ef84dff0] [c0014d08] kernel_thread+0x4c/0x68
[   70.399861] ide1: disabling port
[   70.401669] ide-pmac: probe of 0.00020000:ata-3 failed with error -1
[   70.427747] ide-gd driver 1.18
[   70.429609] hda: max request size: 128KiB
[   70.460436] hda: 120103200 sectors (61492 MB) w/1863KiB Cache, CHS=65535/16/63
[   70.462627] hda: cache flushes supported
[   70.464632]  hda: [mac] hda1 hda2 hda3 hda4
[   70.547879] hdb: max request size: 128KiB
[   70.580518] hdb: 40132503 sectors (20547 MB) w/1900KiB Cache, CHS=39813/16/63
[   70.582303] hdb: cache flushes not supported
[   70.584122]  hdb:<3>ide-pmac lost interrupt, dma status: 8480
[   90.579564] hdb: lost interrupt
[   90.581310] hdb: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
[   90.583132] ide: failed opcode was: unknown
[   90.587331] hda: DMA disabled
[   90.589112] hdb: DMA disabled
[   90.627724] ide0: reset: success
[   90.672825]  hdb1 hdb2 < hdb5 hdb6 hdb7 hdb8 >
[   90.917748] ide-cd driver 5.00
[   90.937884] sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
[   91.010625] PHY ID: 2060e1, addr: 0
[   91.028338] eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:03:93:ab:d1:a6
[   91.030163] eth0: Found BCM5421 PHY
[   91.040347] I2O subsystem v1.325
[   91.042144] i2o: max drivers = 8
[   91.087762] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   91.100344] ohci_hcd 0001:10:18.0: enabling device (0000 -> 0002)
[   91.102179] ohci_hcd 0001:10:18.0: OHCI Host Controller
[   91.110255] ohci_hcd 0001:10:18.0: new USB bus registered, assigned bus number 1
[   91.112135] ohci_hcd 0001:10:18.0: irq 27, io mem 0x80081000
[   91.190134] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[   91.191972] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   91.193788] usb usb1: Product: OHCI Host Controller
[   91.195595] usb usb1: Manufacturer: Linux 2.6.30-rc6 ohci_hcd
[   91.197404] usb usb1: SerialNumber: 0001:10:18.0
[   91.200246] usb usb1: configuration #1 chosen from 1 choice
[   91.205363] hub 1-0:1.0: USB hub found
[   91.207145] hub 1-0:1.0: 2 ports detected
[   91.218319] ohci_hcd 0001:10:19.0: enabling device (0000 -> 0002)
[   91.220048] ohci_hcd 0001:10:19.0: OHCI Host Controller
[   91.228334] ohci_hcd 0001:10:19.0: new USB bus registered, assigned bus number 2
[   91.230096] ohci_hcd 0001:10:19.0: irq 28, io mem 0x80080000
[   91.310106] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[   91.311850] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   91.313572] usb usb2: Product: OHCI Host Controller
[   91.315280] usb usb2: Manufacturer: Linux 2.6.30-rc6 ohci_hcd
[   91.316980] usb usb2: SerialNumber: 0001:10:19.0
[   91.320360] usb usb2: configuration #1 chosen from 1 choice
[   91.322333] hub 2-0:1.0: USB hub found
[   91.324056] hub 2-0:1.0: 2 ports detected
[   91.329247] mice: PS/2 mouse device common for all mice
[   91.333296] rtc-generic rtc-generic: rtc core: registered rtc-generic as rtc0
[   91.335374] i2c /dev entries driver
[   91.347271] PowerMac i2c bus pmu 2 registered
[   91.350237] PowerMac i2c bus pmu 1 registered
[   91.352265] PowerMac i2c bus mac-io 0 registered
[   91.355253] PowerMac i2c bus uni-n 1 registered
[   91.357915] PowerMac i2c bus uni-n 0 registered
[   91.392391] usbcore: registered new interface driver hiddev
[   91.394300] usbcore: registered new interface driver usbhid
[   91.395993] usbhid: v2.6:USB HID core driver
[   91.399438] TCP cubic registered
[   91.401174] NET: Registered protocol family 17
[   91.406259] registered taskstats version 1
[   91.409248] input: PMU as /class/input/input1
[   91.411233] rtc-generic rtc-generic: setting system clock to 2009-05-30 09:24:55 UTC (1243675495)
[   91.412954] Freeing unused kernel memory: 224k init
[   91.567767] usb 1-1: new low speed USB device using ohci_hcd and address 2
[   91.771262] usb 1-1: New USB device found, idVendor=0458, idProduct=002e
[   91.773100] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   91.774854] usb 1-1: Product: NetScroll+ Traveler
[   91.776591] usb 1-1: Manufacturer: KYE
[   91.778545] usb 1-1: configuration #1 chosen from 1 choice
[   91.795245] input: KYE NetScroll+ Traveler as /class/input/input2
[   91.797245] generic-usb 0003:0458:002E.0001: input,hidraw0: USB HID v1.10 Mouse [KYE NetScroll+ Traveler] on usb-0001:10:18.0-1/input0
[   91.930350] usb 2-1: new full speed USB device using ohci_hcd and address 2
[   92.099280] usb 2-1: New USB device found, idVendor=05e3, idProduct=0608
[   92.101244] usb 2-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[   92.103076] usb 2-1: Product: USB2.0 Hub
[   92.105116] usb 2-1: configuration #1 chosen from 1 choice
[   92.107366] hub 2-1:1.0: USB hub found
[   92.110314] hub 2-1:1.0: 4 ports detected
[   92.421274] usb 2-1.1: new full speed USB device using ohci_hcd and address 3
[   92.539288] usb 2-1.1: New USB device found, idVendor=05e3, idProduct=0608
[   92.541329] usb 2-1.1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[   92.543199] usb 2-1.1: Product: USB2.0 Hub
[   92.545262] usb 2-1.1: configuration #1 chosen from 1 choice
[   92.548385] hub 2-1.1:1.0: USB hub found
[   92.551287] hub 2-1.1:1.0: 4 ports detected
[   92.671280] usb 2-1.2: new low speed USB device using ohci_hcd and address 4
[   92.840319] usb 2-1.2: New USB device found, idVendor=04d9, idProduct=0022
[   92.842323] usb 2-1.2: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[   92.844186] usb 2-1.2: Product: USB Keyboard
[   92.846274] usb 2-1.2: configuration #1 chosen from 1 choice
[   92.861967] input: USB Keyboard as /class/input/input3
[   92.864123] generic-usb 0003:04D9:0022.0002: input,hidraw1: USB HID v1.10 Keyboard [USB Keyboard] on usb-0001:10:19.0-1.2/input0
[   92.885524] input: USB Keyboard as /class/input/input4
[   92.896565] generic-usb 0003:04D9:0022.0003: input,hidraw2: USB HID v1.10 Device [USB Keyboard] on usb-0001:10:19.0-1.2/input1
[   93.027997] ohci1394 0002:20:0e.0: enabling device (0000 -> 0002)
[   93.092286] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[40]  MMIO=[f5000000-f50007ff]  Max Packet=[2048]  IR/IT contexts=[8/8]
[   93.410741] eth0: Link is up at 100 Mbps, full-duplex.
[   93.476753] device-mapper: uevent: version 1.0.3
[   93.479265] device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised: dm-devel@redhat.com
[   94.428052] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000393fffeabd1a6]
[  144.839059] kjournald starting.  Commit interval 5 seconds
[  144.839087] EXT3-fs: mounted filesystem with ordered data mode.
[  149.327322] udev: starting version 141
[  149.327519] udev: deprecated sysfs layout; update the kernel or disable CONFIG_SYSFS_DEPRECATED; some udev features will not work correctly
[  282.139537] EXT3 FS on dm-1, internal journal
[  282.944448] SCSI subsystem initialized
[  283.019220] DS1775 digital thermometer [@49]
[  283.019391] Temp: 53.0 C  Hyst: 75.0 C  OS: 80.0 C
[  283.023309] ADM1030 fan controller [@2c]
[  283.027522] Reducing overheating limit to 65.0 C (Hyst: 60.0 C)
[  287.594082] kjournald starting.  Commit interval 5 seconds
[  287.607496] EXT3 FS on dm-3, internal journal
[  287.612410] EXT3-fs: mounted filesystem with ordered data mode.
[  287.669137] REISERFS (device dm-4): found reiserfs format "3.6" with standard journal
[  287.669362] REISERFS (device dm-4): using ordered data mode
[  287.682997] REISERFS (device dm-4): journal params: device dm-4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[  287.686423] REISERFS (device dm-4): checking transaction log (dm-4)
[  287.735102] REISERFS (device dm-4): Using r5 hash to sort names
[  287.861075] Adding 1048568k swap on /dev/mapper/power--group-swap_1.  Priority:-1 extents:1 across:1048568k 
[  289.571657] eth0: Link is up at 100 Mbps, full-duplex.
[  289.571732] eth0: Pause is enabled (rxfifo: 10240 off: 7168 on: 5632)
[  291.038766] CPU-temp: 53.1 C, Case: 32.2 C,  Fan: 0 (tuned -11)
[  305.202444] Process Xorg (pid:2982) mapped non-existing PCI legacy memory for 00000:00


> 
> The end result is a patch for 2.6.30-rc6 below, please try it.
> 
> diff --git a/drivers/ide/hpt366.c b/drivers/ide/hpt366.c
> index 0feb66c..7ce68ef 100644
> --- a/drivers/ide/hpt366.c
> +++ b/drivers/ide/hpt366.c
> @@ -138,14 +138,6 @@
>  #undef	HPT_RESET_STATE_ENGINE
>  #undef	HPT_DELAY_INTERRUPT
>  
> -static const char *quirk_drives[] = {
> -	"QUANTUM FIREBALLlct08 08",
> -	"QUANTUM FIREBALLP KA6.4",
> -	"QUANTUM FIREBALLP LM20.4",
> -	"QUANTUM FIREBALLP LM20.5",
> -	NULL
> -};
> -
>  static const char *bad_ata100_5[] = {
>  	"IBM-DTLA-307075",
>  	"IBM-DTLA-307060",
> @@ -729,27 +721,13 @@ static void hpt3xx_set_pio_mode(ide_drive_t
> *drive, const u8 pio) hpt3xx_set_mode(drive, XFER_PIO_0 + pio);
>  }
>  
> -static void hpt3xx_quirkproc(ide_drive_t *drive)
> -{
> -	char *m			= (char
> *)&drive->id[ATA_ID_PROD];
> -	const  char **list	= quirk_drives;
> -
> -	while (*list)
> -		if (strstr(m, *list++)) {
> -			drive->quirk_list = 1;
> -			return;
> -		}
> -
> -	drive->quirk_list = 0;
> -}
> -
>  static void hpt3xx_maskproc(ide_drive_t *drive, int mask)
>  {
>  	ide_hwif_t *hwif	= drive->hwif;
>  	struct pci_dev	*dev	= to_pci_dev(hwif->dev);
>  	struct hpt_info *info	= hpt3xx_get_info(hwif->dev);
>  
> -	if (drive->quirk_list == 0)
> +	if ((drive->dev_flags & IDE_DFLAG_NIEN_QUIRK) == 0)
>  		return;
>  
>  	if (info->chip_type >= HPT370) {
> @@ -1404,7 +1382,6 @@ static int __devinit hpt36x_init(struct pci_dev
> *dev, struct pci_dev *dev2) static const struct ide_port_ops
> hpt3xx_port_ops = { .set_pio_mode		=
> hpt3xx_set_pio_mode, .set_dma_mode		= hpt3xx_set_mode,
> -	.quirkproc		= hpt3xx_quirkproc,
>  	.maskproc		= hpt3xx_maskproc,
>  	.mdma_filter		= hpt3xx_mdma_filter,
>  	.udma_filter		= hpt3xx_udma_filter,
> diff --git a/drivers/ide/ide-eh.c b/drivers/ide/ide-eh.c
> index 5d5fb96..fab7e89 100644
> --- a/drivers/ide/ide-eh.c
> +++ b/drivers/ide/ide-eh.c
> @@ -408,8 +408,9 @@ static ide_startstop_t do_reset1(ide_drive_t
> *drive, int do_not_try_atapi) /* more than enough time */
>  	udelay(10);
>  	/* clear SRST, leave nIEN (unless device is on the quirk
> list) */
> -	tp_ops->write_devctl(hwif, (drive->quirk_list == 2 ? 0 :
> ATA_NIEN) |
> -			     ATA_DEVCTL_OBS);
> +	tp_ops->write_devctl(hwif,
> +		((drive->dev_flags & IDE_DFLAG_NIEN_QUIRK) ? 0 :
> ATA_NIEN) |
> +		 ATA_DEVCTL_OBS);
>  	/* more than enough time */
>  	udelay(10);
>  	hwif->poll_timeout = jiffies + WAIT_WORSTCASE;
> diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
> index 35dc38d..a4622b8 100644
> --- a/drivers/ide/ide-io.c
> +++ b/drivers/ide/ide-io.c
> @@ -503,11 +503,15 @@ repeat:
>  
>  		if ((hwif->host->host_flags & IDE_HFLAG_SERIALIZE) &&
>  		    hwif != prev_port) {
> +			ide_drive_t *cur_dev =
> +				prev_port ? prev_port->cur_dev :
> NULL; +
>  			/*
>  			 * set nIEN for previous port, drives in the
> -			 * quirk_list may not like intr
> setups/cleanups
> +			 * quirk list may not like intr
> setups/cleanups */
> -			if (prev_port &&
> prev_port->cur_dev->quirk_list == 0)
> +			if (cur_dev &&
> +			    (cur_dev->dev_flags &
> IDE_DFLAG_NIEN_QUIRK) == 0) prev_port->tp_ops->write_devctl(prev_port,
>  								ATA_NIEN
> | ATA_DEVCTL_OBS);
> @@ -696,7 +700,7 @@ void ide_timer_expiry (unsigned long data)
>  		}
>  		spin_lock_irq(&hwif->lock);
>  		enable_irq(hwif->irq);
> -		if (startstop == ide_stopped) {
> +		if (startstop == ide_stopped && hwif->polling == 0) {
>  			ide_unlock_port(hwif);
>  			plug_device = 1;
>  		}
> @@ -868,7 +872,7 @@ irqreturn_t ide_intr (int irq, void *dev_id)
>  	 * same irq as is currently being serviced here, and Linux
>  	 * won't allow another of the same (on any CPU) until we
> return. */
> -	if (startstop == ide_stopped) {
> +	if (startstop == ide_stopped && hwif->polling == 0) {
>  		BUG_ON(hwif->handler);
>  		ide_unlock_port(hwif);
>  		plug_device = 1;
> diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
> index c19a221..c1b5e86 100644
> --- a/drivers/ide/ide-iops.c
> +++ b/drivers/ide/ide-iops.c
> @@ -269,6 +269,29 @@ no_80w:
>  	return 0;
>  }
>  
> +static const char *nien_quirk_list[] = {
> +	"QUANTUM FIREBALLlct08 08",
> +	"QUANTUM FIREBALLP KA6.4",
> +	"QUANTUM FIREBALLP KA9.1",
> +	"QUANTUM FIREBALLP KX13.6",
> +	"QUANTUM FIREBALLP KX20.5",
> +	"QUANTUM FIREBALLP KX27.3",
> +	"QUANTUM FIREBALLP LM20.4",
> +	"QUANTUM FIREBALLP LM20.5",
> +	NULL
> +};
> +
> +void ide_check_nien_quirk_list(ide_drive_t *drive)
> +{
> +	const char **list, *m = (char *)&drive->id[ATA_ID_PROD];
> +
> +	for (list = nien_quirk_list; *list != NULL; list++)
> +		if (strstr(m, *list) != NULL) {
> +			drive->dev_flags |= IDE_DFLAG_NIEN_QUIRK;
> +			return;
> +		}
> +}
> +
>  int ide_driveid_update(ide_drive_t *drive)
>  {
>  	u16 *id;
> @@ -352,7 +375,7 @@ int ide_config_drive_speed(ide_drive_t *drive, u8
> speed) 
>  	tp_ops->exec_command(hwif, ATA_CMD_SET_FEATURES);
>  
> -	if (drive->quirk_list == 2)
> +	if (drive->dev_flags & IDE_DFLAG_NIEN_QUIRK)
>  		tp_ops->write_devctl(hwif, ATA_DEVCTL_OBS);
>  
>  	error = __ide_wait_stat(drive, drive->ready_stat,
> diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
> index 7f264ed..2399bc0 100644
> --- a/drivers/ide/ide-probe.c
> +++ b/drivers/ide/ide-probe.c
> @@ -295,7 +295,7 @@ int ide_dev_read_id(ide_drive_t *drive, u8 cmd,
> u16 *id) 
>  	timeout = ((cmd == ATA_CMD_ID_ATA) ? WAIT_WORSTCASE :
> WAIT_PIDENTIFY) / 2; 
> -	if (ide_busy_sleep(hwif, timeout, use_altstatus))
> +	if (ide_busy_sleep(drive, timeout, use_altstatus))
>  		return 1;
>  
>  	/* wait for IRQ and ATA_DRQ */
> @@ -316,8 +316,9 @@ int ide_dev_read_id(ide_drive_t *drive, u8 cmd,
> u16 *id) return rc;
>  }
>  
> -int ide_busy_sleep(ide_hwif_t *hwif, unsigned long timeout, int
> altstatus) +int ide_busy_sleep(ide_drive_t *drive, unsigned long
> timeout, int altstatus) {
> +	ide_hwif_t *hwif = drive->hwif;
>  	u8 stat;
>  
>  	timeout += jiffies;
> @@ -330,6 +331,8 @@ int ide_busy_sleep(ide_hwif_t *hwif, unsigned
> long timeout, int altstatus) return 0;
>  	} while (time_before(jiffies, timeout));
>  
> +	printk(KERN_ERR "%s: timeout in %s\n", drive->name,
> __func__); +
>  	return 1;	/* drive timed-out */
>  }
>  
> @@ -420,7 +423,7 @@ static int do_probe (ide_drive_t *drive, u8 cmd)
>  			tp_ops->dev_select(drive);
>  			msleep(50);
>  			tp_ops->exec_command(hwif,
> ATA_CMD_DEV_RESET);
> -			(void)ide_busy_sleep(hwif, WAIT_WORSTCASE,
> 0);
> +			(void)ide_busy_sleep(drive, WAIT_WORSTCASE,
> 0); rc = ide_dev_read_id(drive, cmd, id);
>  		}
>  
> @@ -699,8 +702,12 @@ static int ide_probe_port(ide_hwif_t *hwif)
>  	if (irqd)
>  		disable_irq(hwif->irq);
>  
> -	if (ide_port_wait_ready(hwif) == -EBUSY)
> -		printk(KERN_DEBUG "%s: Wait for ready failed before
> probe !\n", hwif->name);
> +	rc = ide_port_wait_ready(hwif);
> +	if (rc == -ENODEV) {
> +		printk(KERN_INFO "%s: no devices on the port\n",
> hwif->name);
> +		goto out;
> +	} else if (rc == -EBUSY)
> +		printk(KERN_ERR "%s: not ready before the probe\n",
> hwif->name); 
>  	/*
>  	 * Second drive should only exist if first drive was found,
> @@ -711,7 +718,7 @@ static int ide_probe_port(ide_hwif_t *hwif)
>  		if (drive->dev_flags & IDE_DFLAG_PRESENT)
>  			rc = 0;
>  	}
> -
> +out:
>  	/*
>  	 * Use cached IRQ number. It might be (and is...) changed by
> probe
>  	 * code above
> @@ -729,6 +736,8 @@ static void ide_port_tune_devices(ide_hwif_t
> *hwif) int i;
>  
>  	ide_port_for_each_present_dev(i, drive, hwif) {
> +		ide_check_nien_quirk_list(drive);
> +
>  		if (port_ops && port_ops->quirkproc)
>  			port_ops->quirkproc(drive);
>  	}
> diff --git a/drivers/ide/pdc202xx_new.c b/drivers/ide/pdc202xx_new.c
> index b68906c..65ba823 100644
> --- a/drivers/ide/pdc202xx_new.c
> +++ b/drivers/ide/pdc202xx_new.c
> @@ -40,18 +40,6 @@
>  #define DBG(fmt, args...)
>  #endif
>  
> -static const char *pdc_quirk_drives[] = {
> -	"QUANTUM FIREBALLlct08 08",
> -	"QUANTUM FIREBALLP KA6.4",
> -	"QUANTUM FIREBALLP KA9.1",
> -	"QUANTUM FIREBALLP LM20.4",
> -	"QUANTUM FIREBALLP KX13.6",
> -	"QUANTUM FIREBALLP KX20.5",
> -	"QUANTUM FIREBALLP KX27.3",
> -	"QUANTUM FIREBALLP LM20.5",
> -	NULL
> -};
> -
>  static u8 max_dma_rate(struct pci_dev *pdev)
>  {
>  	u8 mode;
> @@ -200,19 +188,6 @@ static u8 pdcnew_cable_detect(ide_hwif_t *hwif)
>  		return ATA_CBL_PATA80;
>  }
>  
> -static void pdcnew_quirkproc(ide_drive_t *drive)
> -{
> -	const char **list, *m = (char *)&drive->id[ATA_ID_PROD];
> -
> -	for (list = pdc_quirk_drives; *list != NULL; list++)
> -		if (strstr(m, *list) != NULL) {
> -			drive->quirk_list = 2;
> -			return;
> -		}
> -
> -	drive->quirk_list = 0;
> -}
> -
>  static void pdcnew_reset(ide_drive_t *drive)
>  {
>  	/*
> @@ -473,7 +448,6 @@ static struct pci_dev * __devinit
> pdc20270_get_dev2(struct pci_dev *dev) static const struct
> ide_port_ops pdcnew_port_ops = { .set_pio_mode		=
> pdcnew_set_pio_mode, .set_dma_mode		=
> pdcnew_set_dma_mode,
> -	.quirkproc		= pdcnew_quirkproc,
>  	.resetproc		= pdcnew_reset,
>  	.cable_detect		= pdcnew_cable_detect,
>  };
> diff --git a/drivers/ide/pdc202xx_old.c b/drivers/ide/pdc202xx_old.c
> index 248a54b..ed5df32 100644
> --- a/drivers/ide/pdc202xx_old.c
> +++ b/drivers/ide/pdc202xx_old.c
> @@ -23,18 +23,6 @@
>  
>  #define PDC202XX_DEBUG_DRIVE_INFO	0
>  
> -static const char *pdc_quirk_drives[] = {
> -	"QUANTUM FIREBALLlct08 08",
> -	"QUANTUM FIREBALLP KA6.4",
> -	"QUANTUM FIREBALLP KA9.1",
> -	"QUANTUM FIREBALLP LM20.4",
> -	"QUANTUM FIREBALLP KX13.6",
> -	"QUANTUM FIREBALLP KX20.5",
> -	"QUANTUM FIREBALLP KX27.3",
> -	"QUANTUM FIREBALLP LM20.5",
> -	NULL
> -};
> -
>  static void pdc_old_disable_66MHz_clock(ide_hwif_t *);
>  
>  static void pdc202xx_set_mode(ide_drive_t *drive, const u8 speed)
> @@ -151,19 +139,6 @@ static void
> pdc_old_disable_66MHz_clock(ide_hwif_t *hwif) outb(clock &
> ~(hwif->channel ? 0x08 : 0x02), clock_reg); }
>  
> -static void pdc202xx_quirkproc(ide_drive_t *drive)
> -{
> -	const char **list, *m = (char *)&drive->id[ATA_ID_PROD];
> -
> -	for (list = pdc_quirk_drives; *list != NULL; list++)
> -		if (strstr(m, *list) != NULL) {
> -			drive->quirk_list = 2;
> -			return;
> -		}
> -
> -	drive->quirk_list = 0;
> -}
> -
>  static void pdc202xx_dma_start(ide_drive_t *drive)
>  {
>  	if (drive->current_speed > XFER_UDMA_2)
> @@ -311,13 +286,11 @@ static void __devinit
> pdc202ata4_fixup_irq(struct pci_dev *dev, static const struct
> ide_port_ops pdc20246_port_ops = { .set_pio_mode		=
> pdc202xx_set_pio_mode, .set_dma_mode		=
> pdc202xx_set_mode,
> -	.quirkproc		= pdc202xx_quirkproc,
>  };
>  
>  static const struct ide_port_ops pdc2026x_port_ops = {
>  	.set_pio_mode		= pdc202xx_set_pio_mode,
>  	.set_dma_mode		= pdc202xx_set_mode,
> -	.quirkproc		= pdc202xx_quirkproc,
>  	.resetproc		= pdc202xx_reset,
>  	.cable_detect		= pdc2026x_cable_detect,
>  };
> diff --git a/include/linux/ide.h b/include/linux/ide.h
> index ff65fff..fa8ffe0 100644
> --- a/include/linux/ide.h
> +++ b/include/linux/ide.h
> @@ -474,6 +474,7 @@ enum {
>  	IDE_DFLAG_NICE1			= (1 << 5),
>  	/* device is physically present */
>  	IDE_DFLAG_PRESENT		= (1 << 6),
> +	IDE_DFLAG_NIEN_QUIRK		= (1 << 7),
>  	/* id read from device (synthetic if not set) */
>  	IDE_DFLAG_ID_READ		= (1 << 8),
>  	IDE_DFLAG_NOPROBE		= (1 << 9),
> @@ -543,7 +544,6 @@ struct ide_drive_s {
>  	u8	waiting_for_dma;	/* dma currently in
> progress */ u8	dma;			/* atapi dma flag */
>  
> -        u8	quirk_list;	/* considered quirky, set for a
> specific host */ u8	init_speed;	/* transfer rate set at
> boot */ u8	current_speed;	/* current transfer rate set
> */ u8	desired_speed;	/* desired transfer rate set */
> @@ -1109,7 +1109,7 @@ void ide_fix_driveid(u16 *);
>  
>  extern void ide_fixstring(u8 *, const int, const int);
>  
> -int ide_busy_sleep(ide_hwif_t *, unsigned long, int);
> +int ide_busy_sleep(ide_drive_t *, unsigned long, int);
>  
>  int ide_wait_stat(ide_startstop_t *, ide_drive_t *, u8, u8, unsigned
> long); 
> @@ -1464,6 +1464,7 @@ static inline void
> ide_acpi_set_state(ide_hwif_t *hwif, int on) {} void
> ide_register_region(struct gendisk *); void
> ide_unregister_region(struct gendisk *); 
> +void ide_check_nien_quirk_list(ide_drive_t *);
>  void ide_undecoded_slave(ide_drive_t *);
>  
>  void ide_port_apply_params(ide_hwif_t *);
> 
> 
