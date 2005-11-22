Return-Path: <lagrange@fr.oleane.com>
Received: from relay03s.ntr.oleane.net (relay03s.ntr.oleane.net [194.2.8.84])
	by ozlabs.org (Postfix) with ESMTP id 9F06B687DA
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Nov 2005 06:31:00 +1100 (EST)
Received: from smtp6.clb.oleane.net (smtp6.clb.oleane.net [213.56.31.26])
	by relay03s.ntr.oleane.net with ESMTP id jAMIPmS7014510
	for <linuxppc-embedded@ozlabs.org>; Tue, 22 Nov 2005 19:26:02 +0100
Received: from GEG2400 ([62.160.30.216]) (authenticated)
	by smtp6.clb.oleane.net with ESMTP id jAMIEw6X022153
	for <linuxppc-embedded@ozlabs.org>; Tue, 22 Nov 2005 19:15:01 +0100
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Tue, 22 Nov 2005 19:18:49 +0100
Message-ID: <000a01c5ef91$30772c20$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: linux 2.6.9 on 8xx platform
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello all,

I try to port a linux 2.6.9 from elinos free tool box on a 852T custom board
with a ramdisk filesystem.
I have already run a linux 2.4.18 on it without any problem.
When I have configured my 2.6 kernel, I found some new parameters in
advanced
setup menu.
For example, I don't understand what mean CONFIG_CONSISTENT_START/SIZE
and CONFIG_PIN_TLB values.

When I use the default value for CONFIG_CONSISTENT_START=0xff100000, the
kernel crashes in dma_alloc_init function in arch/ppc/kernel/dma-mapping.c.

I have made a search and seen that someone uses CONFIG_CONSISTENT_START
with 0xa0000000 for another 8xx board.
I tried it and pass the dma_alloc_init
but another problem occurs when the kernel tries to launch the init process.

Is there anyone who has already seen this problem?

Thanks
Laurent

..............

#
# Advanced setup
#
CONFIG_ADVANCED_OPTIONS=y
CONFIG_HIGHMEM_START=0xfe000000
# CONFIG_LOWMEM_SIZE_BOOL is not set
CONFIG_LOWMEM_SIZE=0x30000000
# CONFIG_KERNEL_START_BOOL is not set
CONFIG_KERNEL_START=0xc0000000
# CONFIG_TASK_SIZE_BOOL is not set
CONFIG_TASK_SIZE=0x80000000
CONFIG_CONSISTENT_START_BOOL=y
CONFIG_CONSISTENT_START=0xa0000000
# CONFIG_CONSISTENT_SIZE_BOOL is not set
CONFIG_CONSISTENT_SIZE=0x00200000
# CONFIG_BOOT_LOAD_BOOL is not set
CONFIG_BOOT_LOAD=0x00400000
# CONFIG_PIN_TLB is not set


loaded at:     00400000 0059A150
board data at: 00598114 00598150
relocated to:  00405114 00405150
zimage at:     00405A10 004E6F7F
initrd at:     004E7000 00597805
avail ram:     0059B000 02000000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.6.9-elinos-144 (852board@Linux1701) (version gcc 3.2.3
(ELinOS V3.1 3.2.3-35 2005-06-01)) #2 Tue Nov 22 17:25:58 CET 2005
Built 1 zonelists
Kernel command line: devfs=mount rootfstype=tmpfs root=/dev/ram rw
PID hash table entries: 256 (order: 8, 4096 bytes)
Decrementer Frequency = 187500000/60
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 29504k available (1536k kernel code, 532k data, 68k init, 0k
highmem)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
NET: Registered protocol family 16
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Initializing Cryptographic API
Serial: CPM driver $Revision: 0.01 $
ttyCPM0 at MMIO 0xff000a80 (irq = 20) is a CPM UART
Using deadline io scheduler
physmap flash device: 2000000 at f8000000
phys_mapped_flash: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
phys_mapped_flash: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
6 cmdlinepart partitions found on MTD device phys_mapped_flash
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
VFS: Mounted root (tmpfs filesystem).
UNTAR: Extracting root archive: done.
Mounted devfs on /dev
Freeing unused kernel memory: 68k in
try init
Oops: kernel access of bad area, sig: 11 [#1]
NIP: C0008F18 LR: C000E78C SP: C04CBE00 REGS: c04cbd50 TRAP: 0300    Not
tainted

MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 30013C60, DSISR: C2000000
TASK = c04c4ba0[1] 'init' THREAD: c04ca000Last syscall: 45
GPR00: C01F4CA0 C04CBE00 C04C4BA0 30013000 00000100 000003C2 30013000
C04CBE28
GPR08: C01F0000 C01F4CA0 00000000 00007840 20000002 000637B0 00000001
FF000000
GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 30013000
C01F4CA0
GPR24: 00000000 00000000 C01F3300 00000000 30013C60 003C2889 C022D840
C022D840
NIP [c0008f18] __flush_dcache_icache+0x14/0x40
LR [c000e78c] update_mmu_cache+0x94/0x98
Call trace:
 [c003f0d4] do_no_page+0x1a4/0x364
 [c003f450] handle_mm_fault+0xf8/0x178
 [c000dd3c] do_page_fault+0x1d4/0x398
 [c0006768] handle_page_fault+0xc/0x80
Kernel panic - not syncing: Attempted to kill init!
 <0>Rebooting in 180 seconds..
