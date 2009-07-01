Return-Path: <iws@ovro.caltech.edu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A2915B70DE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 05:48:23 +1000 (EST)
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 0EE36DDD04
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2009 05:48:22 +1000 (EST)
Date: Wed, 1 Jul 2009 12:48:19 -0700
From: Ira Snyder <iws@ovro.caltech.edu>
To: Andrey Gusev <a.gusev1980@mail.ru>
Subject: Re: bug in  2.6.31-rc1
Message-ID: <20090701194819.GB20522@ovro.caltech.edu>
References: <20090701230831.3828e0bf@power-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090701230831.3828e0bf@power-debian>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 01, 2009 at 11:08:31PM +0400, Andrey Gusev wrote:
> Hello!
> 
> I tried 2.6.31-rc1 and found trace in dmesg.
> 
> [    0.000000] NR_IRQS:512
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] Badness at mm/bootmem.c:535
> [    0.000000] NIP: c043d2d0 LR: c043d29c CTR: c0024e6c
> [    0.000000] REGS: c0489da0 TRAP: 0700   Not tainted  (2.6.31-rc1)
> [    0.000000] MSR: 00021032 <ME,CE,IR,DR>  CR: 24024044  XER: 00000000
> [    0.000000] TASK = c0463400[0] 'swapper' THREAD: c0488000 CPU: 0
> [    0.000000] <6>GPR00: 00000001 c0489e50 c0463400 00000000 00000210 00000020 3fffffff 00000000
> [    0.000000] <6>GPR08: c03bc970 c04ff260 c0024e6c c0488000 24024042 00000000 017bb53c 017bb534
> [    0.000000] <6>GPR16: 017e9da0 017bb2b8 00240e60 c0453dc0 c04a14a4 c0453fc8 c04566e8 c03bc970
> [    0.000000] <6>GPR24: c0456704 00000000 00000011 00000210 00000020 00000000 3fffffff 00000210
> [    0.000000] NIP [c043d2d0] alloc_arch_preferred_bootmem+0x4c/0x78
> [    0.000000] LR [c043d29c] alloc_arch_preferred_bootmem+0x18/0x78
> [    0.000000] Call Trace:
> [    0.000000] [c0489e50] [00000001] 0x1 (unreliable)
> [    0.000000] [c0489e60] [c043db98] ___alloc_bootmem_nopanic+0x54/0x108
> [    0.000000] [c0489ea0] [c043de9c] ___alloc_bootmem+0x18/0x50
> [    0.000000] [c0489eb0] [c0432a74] mpic_alloc+0x44/0x6d0
> [    0.000000] [c0489f00] [c04333d4] pmac_setup_one_mpic+0xf4/0x124
> [    0.000000] [c0489f40] [c04334e8] pmac_pic_init+0xe4/0x55c
> [    0.000000] [c0489f90] [c042a618] init_IRQ+0x24/0x34
> [    0.000000] [c0489fa0] [c04278e0] start_kernel+0x254/0x3a0
> [    0.000000] [c0489ff0] [000034f4] 0x34f4
> [    0.000000] Instruction dump:
> [    0.000000] 38600000 409e0018 80010014 83e1000c 38210010 7c0803a6 4e800020 3d20c050
> [    0.000000] 3929f260 80090004 7c000034 5400d97e <0f000000> 2f800000 409e0018 38800000
> [    0.000000] mpic: Setting up MPIC " MPIC 1   " version 1.2 at 80040000, max 4 CPUs
> [    0.000000] mpic: ISU size: 64, shift: 6, mask: 3f
> [    0.000000] mpic: Initializing for 64 sources
> [    0.000000] irq: irq 55 on host /pci@f2000000/mac-io@17/interrupt-controller@40000 mapped to virtual irq 55
> 

I've been seeing a similar warning on my 83xx system. Here's the
relevant output:

[    0.000000] Using MPC834x MDS machine description
[    0.000000] Linux version 2.6.31-rc1-00275-g9ea6fce (iws@desk1) (gcc version 4.2.2) #185 Tue Jun 30 13:58:52 PDT 2009
[    0.000000] Found initrd at 0xcfee9000:0xcff7d792
[    0.000000] Found legacy serial port 0 for /soc8349@e0000000/serial@4500
[    0.000000]   mem=e0004500, taddr=e0004500, irq=0, clk=266666664, speed=0
[    0.000000] console [udbg0] enabled
[    0.000000] Top of RAM: 0x10000000, Total RAM: 0x10000000
[    0.000000] Memory hole size: 0MB
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00010000
[    0.000000]   Normal   0x00010000 -> 0x00010000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00010000
[    0.000000] On node 0 totalpages: 65536
[    0.000000] free_area_init_node: node 0, pgdat c03018c4, node_mem_map c034c000
[    0.000000]   DMA zone: 512 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 65024 pages, LIFO batch:15
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
[    0.000000] Kernel command line: root=/dev/nfs nfsroot=192.168.17.57:/srv/ppc ip=none persistent=none console=ttyS0,115200 ro
[    0.000000] PID hash table entries: 1024 (order: 10, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 255616k/262144k available (2892k kernel code, 6248k reserved, 192k data, 258k bss, 132k init)
[    0.000000] Kernel virtual memory layout:
[    0.000000]   * 0xffffe000..0xfffff000  : fixmap
[    0.000000]   * 0xfdffd000..0xfe000000  : early ioremap
[    0.000000]   * 0xd1000000..0xfdffd000  : vmalloc & ioremap
[    0.000000] SLUB: Genslabs=13, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS:512
[    0.000000] ------------[ cut here ]------------
[    0.000000] Badness at /home/iws/devel/linux-2.6/mm/bootmem.c:535
[    0.000000] NIP: c02baa68 LR: c02baa4c CTR: 00000000
[    0.000000] REGS: c0305e50 TRAP: 0700   Not tainted  (2.6.31-rc1-00275-g9ea6fce)
[    0.000000] MSR: 00021032 <ME,CE,IR,DR>  CR: 22022024  XER: 00000000
[    0.000000] TASK = c02d5428[0] 'swapper' THREAD: c0304000
[    0.000000] GPR00: 00000001 c0305f00 c02d5428 00000000 00000008 00000020 3fffffff 00000000 
[    0.000000] GPR08: c0305ec0 c0340000 e0000700 00000000 22042024 00000000 0fffd000 00000000 
[    0.000000] GPR16: 0fff2d28 0fff6d48 00000000 00000000 00000000 00000000 c02ce22c c02ce210 
[    0.000000] GPR24: 00000000 00000008 00000020 cfffff28 c0310000 00000000 3fffffff 00000008 
[    0.000000] NIP [c02baa68] alloc_arch_preferred_bootmem+0x34/0x70
[    0.000000] LR [c02baa4c] alloc_arch_preferred_bootmem+0x18/0x70
[    0.000000] Call Trace:
[    0.000000] [c0305f00] [cfffff28] 0xcfffff28 (unreliable)
[    0.000000] [c0305f10] [c02bb2b4] ___alloc_bootmem_nopanic+0x54/0x104
[    0.000000] [c0305f50] [c02bb4d0] ___alloc_bootmem+0x18/0x50
[    0.000000] [c0305f60] [c02b84c4] ipic_init+0x40/0x180
[    0.000000] [c0305fa0] [c02b8704] mpc834x_mds_init_IRQ+0x2c/0x40
[    0.000000] [c0305fb0] [c02b4110] init_IRQ+0x24/0x34
[    0.000000] [c0305fc0] [c02b274c] start_kernel+0x184/0x2ac
[    0.000000] [c0305ff0] [00003438] 0x3438
[    0.000000] Instruction dump:
[    0.000000] 7c0802a6 93e1000c 7c9f2378 90010014 4bdb6355 2f830000 38600000 41be003c 
[    0.000000] 3d20c034 8009e1f4 7c000034 5400d97e <0f000000> 2f800000 41be0010 38000001 
[    0.000000] IPIC (128 IRQ sources) at d1000700
[    0.000000] time_init: decrementer frequency = 66.666666 MHz
[    0.000000] time_init: processor frequency   = 533.333328 MHz
[    0.000000] clocksource: timebase mult[3c00001] shift[22] registered
[    0.000000] clockevent: decrementer mult[1111110e] shift[32] cpu[0]
[  901.949547] Console: colour dummy device 80x25
[  901.954036] Mount-cache hash table entries: 512
[  901.962467] NET: Registered protocol family 16
[  901.972751] Registering ipic with sysfs...
[  901.985068] bio: create slab <bio-0> at 0

The warning is caused by the slab allocator being available much earlier
in the boot process. The following (untested!) patch should fix it for
my board. A similar patch to arch/powerpc/sysdev/mpic.c would fix the
error as well.

Ira

diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index a86d3ce..69e2630 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -728,12 +728,10 @@ struct ipic * __init ipic_init(struct device_node *node, unsigned int flags)
        if (ret)
                return NULL;
 
-       ipic = alloc_bootmem(sizeof(struct ipic));
+       ipic = kzalloc(sizeof(*ipic), GFP_KERNEL);
        if (ipic == NULL)
                return NULL;
 
-       memset(ipic, 0, sizeof(struct ipic));
-
        ipic->irqhost = irq_alloc_host(node, IRQ_HOST_MAP_LINEAR,
                                       NR_IPIC_INTS,
                                       &ipic_host_ops, 0);
