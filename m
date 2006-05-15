Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id EEB01679F6
	for <linuxppc-dev@ozlabs.org>; Tue, 16 May 2006 08:25:16 +1000 (EST)
Date: Tue, 16 May 2006 00:25:14 +0200 (MEST)
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
References: <3746.1147538916@www086.gmx.net>
Subject: =?ISO-8859-1?Q?NOT=5FCOHERENT=5FCACHE:_1._kernel_oops_in_page=5Fadd=5Ffil?=
	=?ISO-8859-1?Q?e=5Frmap()_and_2._crash_with_HIGHMEM_support?=
Message-ID: <12262.1147731914@www050.gmx.net>
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I applied the CONFIG_NOT_COHERENT_CACHE option for the AmigaOne, which has a
northbridge with cache coherence problems. Unfortunately the kernel now
crashes when viewing DVD (for example with totem) and when support for
HIGHMEM is compiled in. Kernel version is 2.6.8-16 (debian).

First some infos:
To get NOT_COHERENT_CACHE working on the AmigaOne, I had to limit the PCI
memory and ISA IO/MEM space of the northbridge first and then changed the
CONFIG_CONSISTENT_BASE parameter from 0xFF100000 to 0xF8100000
(CONSISTENT_SIZE is still set to 0x00200000 = 2MB).

The IO/MEM space was previously mapped like this in the platform setup:
io_block_mapping(0xF0000000, 0xF0000000, 0x10000000, _PAGE_IO)

I changed this line to:
io_block_mapping(0xFD000000, 0xFD000000, 0x01000000, _PAGE_IO) -> ISA MEM
and
io_block_mapping(0xFE000000, 0xFE000000, 0x02000000, _PAGE_IO) -> ISA IO/PCI
config space.
These address ranges are mapped by BATs.

The PCI memory normally goes from 0x80000000 to 0xFCFFFFFF, but is limited
to 0xEFFFFFFF in the PCI host controller resource initialization:

amigaone_init_resource(&hose->mem_resources[0], 0x80000000, 0x0xEFFFFFFF,
IORESOURCE_MEM);

With this setup DMA (and UDMA for IDE devices) works without any data
corruption. I tested this with around 500 MD5 checksum tests of three
different files with a file size of at least 100 MB. But when I view a DVD
for example (without HIGHMEM support), the system crashes with the following
kernel oops:

May 12 00:04:17 localhost kernel: kernel BUG in page_add_file_rmap at
mm/rmap.c:387!
May 12 00:04:17 localhost kernel: Oops: Exception in kernel mode, sig: 5
[#1]
May 12 00:04:17 localhost kernel: NIP: C004968C LR: C0044CB8 SP: D2C77E20
REGS: d2c77d70 TRAP: 0700    Not tainted
May 12 00:04:17 localhost kernel: MSR: 00029032 EE: 1 PR: 0 FP: 0 ME: 1
IR/DR: 11
May 12 00:04:17 localhost kernel: TASK = d4918000[2900] 'totem' THREAD:
d2c76000Last syscall: 246
May 12 00:04:17 localhost kernel: GPR00: 00000001 D2C77E20 D4918000 C0D02720
00000000 D27B02A0 02000000 D4FE4400
May 12 00:04:17 localhost kernel: GPR08: C03D0000 38139785 00000000 38139785
24048444 10054698 00000000 10171158
May 12 00:04:17 localhost kernel: GPR16: 00000000 00000000 0EADDD7C 00015F90
000001F6 315B1970 33CA8000 D4D6BBA0
May 12 00:04:17 localhost kernel: GPR24: 00000000 00000000 02000000 D4B7D33C
33CA8000 C0D02720 38139785 D2888220
May 12 00:04:17 localhost kernel: NIP [c004968c] page_add_file_rmap+0x8/0x78
May 12 00:04:17 localhost kernel: LR [c0044cb8] do_no_page+0x1cc/0x37c
May 12 00:04:17 localhost kernel: Call trace:
May 12 00:04:17 localhost kernel:  [c004503c] handle_mm_fault+0xf4/0x174
May 12 00:04:17 localhost kernel:  [c0012100] do_page_fault+0x140/0x398
May 12 00:04:17 localhost kernel:  [c0008178] handle_page_fault+0xc/0x80

Does anybody know how I can debug this crash, or what's happening here? I
don't think that the PCI memory is the cause for this crash, because the
CONSISTENT_BASE address is a virtual address, which is not mapped phyiscally
to the same address (phys = virt)!?

The second problem is HIGHMEM support in combination with
NOT_COHERENT_CACHE. When both options are enabled, the kernel crashes within
kmap_atomic() early in the boot process. kmap_atomic() is called by
__dma_sync_page_highmem(). I guess it should work even, if I have only 512MB
RAM. I moved the PKMAP_BASE to 0xF0000000, because the default address is
again within the ISA MEM space.

Did anyone else experience this problem?

Thanks in advance!

regards,

Gerhard

-- 
Mobile Internet - E-Mail und Internet immer und überall!
GMX zum Mitnehmen: http://www.gmx.net/de/go/pocketweb
