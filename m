Return-Path: <stefani@seibold.net>
Received: from www84.your-server.de (www84.your-server.de [213.133.104.84])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 381802C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 01:59:24 +1000 (EST)
Received: from [37.5.209.66] (helo=[192.168.0.4])
 by www84.your-server.de with esmtpsa (SSLv3:AES256-SHA:256)
 (Exim 4.74) (envelope-from <stefani@seibold.net>) id 1UrVDL-0003i7-QL
 for linuxppc-dev@lists.ozlabs.org; Tue, 25 Jun 2013 17:31:27 +0200
Message-ID: <1372174299.7466.1.camel@wall-e>
Subject: kexec hangs on P2020
From: Stefani Seibold <stefani@seibold.net>
To: linuxppc-dev@lists.ozlabs.org
Date: Tue, 25 Jun 2013 17:31:39 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

i have tried to kexec a 32 bit kernel on a Freescale P2020 dual core CPU
(e500v2, revison 5.1 - pvr 8021 1051), but Kexec will hang.

The host and the kexec kernel are 3.9.4, but i have cross checked with
the current 3.10 kernel, there is no notable change in this code path. 

Invoking kexec with

kexec --command-line "$(cat /proc/cmdline)" -t elf-ppc --dtb=rs2020.dtb \
--reuse-node="/cpus/PowerPC,P2020@0/timebase-frequency" \
--reuse-node="/cpus/PowerPC,P2020@0/bus-frequency" \
--reuse-node="/cpus/PowerPC,P2020@0/clock-frequency" \
--reuse-node="/cpus/PowerPC,P2020@0/next-level-cache" \
--reuse-node="/cpus/PowerPC,P2020@1/timebase-frequency" \
--reuse-node="/cpus/PowerPC,P2020@1/bus-frequency" \
--reuse-node="/cpus/PowerPC,P2020@1/clock-frequency" \
--reuse-node="/cpus/PowerPC,P2020@1/next-level-cache" \
--reuse-node="/cpus/PowerPC,P2020@1/cpu-release-addr" \
--reuse-node="/cpus/PowerPC,P2020@1/enable-method" \
--reuse-node="/soc@ffe00000/bus-frequency" \
--reuse-node="/soc@ffe00000/serial@4500/clock-frequency" \
--reuse-node="/soc@ffe00000/ethernet@24000/local-mac-address" \
-d -l -x vmlinux
kexec -e

This will be the result output of the run:

kernel: 0x48032008 kernel_size: 4fde98
0000000000000000-0000000080000000 : 0
get base memory ranges:1
nr_segments = 0
nr_segments = 0
nr_segments = 1
segment[0].buf   = 0x48042008
segment[0].bufsz = 4ed620
segment[0].mem   = (nil)
segment[0].memsz = 518000
sym:      .data info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .data value: 51dda8 addr: 518012
sym:      .data info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .data value: 51dda8 addr: 51801a
sym: sha256_starts info: 12 other: 00 shndx: 1 value: 99c size: e0
sym: sha256_starts value: 51899c addr: 518024
sym: sha256_update info: 12 other: 00 shndx: 1 value: 565c size: 1b0
sym: sha256_update value: 51d65c addr: 518038
sym: sha256_finish info: 12 other: 00 shndx: 1 value: 580c size: 528
sym: sha256_finish value: 51d80c addr: 518050
sym:      .data info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .data value: 51dda8 addr: 518056
sym:      .data info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .data value: 51dda8 addr: 51805a
sym:     memcmp info: 12 other: 00 shndx: 1 value: 664 size: 40
sym: memcmp value: 518664 addr: 518068
sym: .rodata.str1.4 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.4 value: 51dd34 addr: 51807a
sym: .rodata.str1.4 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.4 value: 51dd64 addr: 51807e
sym: .rodata.str1.4 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.4 value: 51dd34 addr: 518082
sym:     printf info: 12 other: 00 shndx: 1 value: 55c size: 68
sym: printf value: 51855c addr: 51808c
sym: .rodata.str1.4 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.4 value: 51dd54 addr: 518092
sym: .rodata.str1.4 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.4 value: 51dd54 addr: 518096
sym:     printf info: 12 other: 00 shndx: 1 value: 55c size: 68
sym: printf value: 51855c addr: 51809c
sym: .rodata.str1.4 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.4 value: 51dd64 addr: 5180a6
sym:     printf info: 12 other: 00 shndx: 1 value: 55c size: 68
sym: printf value: 51855c addr: 5180b4
sym: .rodata.str1.4 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.4 value: 51dd6c addr: 5180c2
sym:      .data info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .data value: 51dda8 addr: 5180c6
sym: .rodata.str1.4 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.4 value: 51dd6c addr: 5180ca
sym:      .data info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .data value: 51dda8 addr: 5180ce
sym:     printf info: 12 other: 00 shndx: 1 value: 55c size: 68
sym: printf value: 51855c addr: 5180d4
sym: .rodata.str1.4 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.4 value: 51dd70 addr: 5180da
sym: .rodata.str1.4 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.4 value: 51dd70 addr: 5180de
sym:     printf info: 12 other: 00 shndx: 1 value: 55c size: 68
sym: printf value: 51855c addr: 5180e8
sym:     printf info: 12 other: 00 shndx: 1 value: 55c size: 68
sym: printf value: 51855c addr: 5180fc
sym: .rodata.str1.4 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.4 value: 51dd6c addr: 51810a
sym: .rodata.str1.4 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.4 value: 51dd6c addr: 51810e
sym:     printf info: 12 other: 00 shndx: 1 value: 55c size: 68
sym: printf value: 51855c addr: 518114
sym: _rest32gpr_29_x info: 12 other: 00 shndx: 1 value: 8fc size: 0
sym: _rest32gpr_29_x value: 5188fc addr: 518124
sym: .rodata.str1.4 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.4 value: 51dd80 addr: 51812e
sym: .rodata.str1.4 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.4 value: 51dd80 addr: 518136
sym:     printf info: 12 other: 00 shndx: 1 value: 55c size: 68
sym: printf value: 51855c addr: 518140
sym: setup_arch info: 12 other: 00 shndx: 1 value: 98c size: 4
sym: setup_arch value: 51898c addr: 518144
sym: verify_sha256_digest info: 12 other: 00 shndx: 1 value: 0 size: 128
sym: verify_sha256_digest value: 518000 addr: 518148
sym: post_verification_setup_arch info: 12 other: 00 shndx: 1 value: 990 size: 4
sym: post_verification_setup_arch value: 518990 addr: 518158
sym: .rodata.str1.4 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.4 value: 51dd94 addr: 51817a
sym: .rodata.str1.4 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.4 value: 51dd94 addr: 518196
sym:    putchar info: 12 other: 00 shndx: 1 value: 998 size: 4
sym: putchar value: 518998 addr: 5181b8
sym:    putchar info: 12 other: 00 shndx: 1 value: 998 size: 4
sym: putchar value: 518998 addr: 51821c
sym:  __lshrdi3 info: 10 other: 00 shndx: 1 value: 968 size: 0
sym: __lshrdi3 value: 518968 addr: 51833c
sym:    putchar info: 12 other: 00 shndx: 1 value: 998 size: 4
sym: putchar value: 518998 addr: 5184cc
sym: _rest32gpr_21_x info: 12 other: 00 shndx: 1 value: 8dc size: 0
sym: _rest32gpr_21_x value: 5188dc addr: 5184fc
sym:   vsprintf info: 12 other: 00 shndx: 1 value: 16c size: 394
sym: vsprintf value: 51816c addr: 518548
sym:   vsprintf info: 12 other: 00 shndx: 1 value: 16c size: 394
sym: vsprintf value: 51816c addr: 5185b0
sym: my_thread_ptr info: 11 other: 00 shndx: 5 value: 10 size: 4
sym: my_thread_ptr value: 51df18 addr: 5187b6
sym: my_thread_ptr info: 11 other: 00 shndx: 5 value: 10 size: 4
sym: my_thread_ptr value: 51df18 addr: 5187ba
sym:      stack info: 11 other: 00 shndx: 5 value: 8 size: 4
sym: stack value: 51df10 addr: 5187c2
sym:      stack info: 11 other: 00 shndx: 5 value: 8 size: 4
sym: stack value: 51df10 addr: 5187c6
sym:  purgatory info: 12 other: 00 shndx: 1 value: 128 size: 44
sym: purgatory value: 518128 addr: 5187d0
sym:  dt_offset info: 11 other: 00 shndx: 5 value: c size: 4
sym: dt_offset value: 51df14 addr: 5187ea
sym:  dt_offset info: 11 other: 00 shndx: 5 value: c size: 4
sym: dt_offset value: 51df14 addr: 5187ee
sym:     kernel info: 11 other: 00 shndx: 5 value: 14 size: 4
sym: kernel value: 51df1c addr: 518806
sym:     kernel info: 11 other: 00 shndx: 5 value: 14 size: 4
sym: kernel value: 51df1c addr: 51880a
sym:     memcpy info: 12 other: 00 shndx: 1 value: 630 size: 34
sym: memcpy value: 518630 addr: 51d74c
sym: sha256_process info: 12 other: 00 shndx: 1 value: a7c size: 4be0
sym: sha256_process value: 518a7c addr: 51d760
sym: sha256_process info: 12 other: 00 shndx: 1 value: a7c size: 4be0
sym: sha256_process value: 518a7c addr: 51d798
sym:     memcpy info: 12 other: 00 shndx: 1 value: 630 size: 34
sym: memcpy value: 518630 addr: 51d7e8
sym:      .data info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .data value: 51dec8 addr: 51d91a
sym:      .data info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .data value: 51dec8 addr: 51d91e
sym: sha256_update info: 12 other: 00 shndx: 1 value: 565c size: 1b0
sym: sha256_update value: 51d65c addr: 51d924
sym: sha256_update info: 12 other: 00 shndx: 1 value: 565c size: 1b0
sym: sha256_update value: 51d65c addr: 51d938
reserve regions: 1
0: offset: 17fd000, size: 3000
debug.dtb written
kexec_load: entry = 0x5186a4 flags = 0
nr_segments = 3
segment[0].buf   = 0x48042008
segment[0].bufsz = 4ed620
segment[0].mem   = (nil)
segment[0].memsz = 518000
segment[1].buf   = 0x1007b2e0
segment[1].bufsz = 5f20
segment[1].mem   = 0x518000
segment[1].memsz = 6000
segment[2].buf   = 0x10081268
segment[2].bufsz = 25da
segment[2].mem   = 0x17fd000
segment[2].memsz = 3000
[  273.189790] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  273.266505] xhci_hcd 0001:03:00.0: Host not halted after 16000 microseconds.
[  273.273681] Starting new kernel
[  273.280271] Bye!

The same is still working on a Freescale 834x PowerPC CPU and the output
of kexec looks similary.

This is a extract of my kernel .config

#
# Processor support
#
# CONFIG_PPC_BOOK3S_32 is not set
CONFIG_PPC_85xx=y
# CONFIG_PPC_8xx is not set
# CONFIG_40x is not set
# CONFIG_44x is not set
# CONFIG_E200 is not set
CONFIG_E500=y
# CONFIG_PPC_E500MC is not set
CONFIG_FSL_EMB_PERFMON=y
CONFIG_BOOKE=y
CONFIG_FSL_BOOKE=y
CONFIG_PPC_FSL_BOOK3E=y
# CONFIG_PHYS_64BIT is not set
CONFIG_SPE=y
CONFIG_PPC_MMU_NOHASH=y
CONFIG_PPC_BOOK3E_MMU=y
# CONFIG_PPC_MM_SLICES is not set
CONFIG_SMP=y
CONFIG_NR_CPUS=2
CONFIG_PPC32=y
CONFIG_32BIT=y
CONFIG_WORD_SIZE=32
# CONFIG_ARCH_PHYS_ADDR_T_64BIT is not set
# CONFIG_ARCH_DMA_ADDR_T_64BIT is not set
CONFIG_MMU=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
# CONFIG_HAVE_SETUP_PER_CPU_AREA is not set
# CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK is not set
CONFIG_NR_IRQS=512
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_HAVE_LATENCYTOP_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_LOCKBREAK=y
CONFIG_ARCH_HAS_ILOG2_U32=y
CONFIG_ARCH_HAS_CPU_IDLE_WAIT=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_GPIO=y
# CONFIG_ARCH_NO_VIRT_TO_BUS is not set
CONFIG_PPC=y
CONFIG_EARLY_PRINTK=y
CONFIG_GENERIC_NVRAM=y
CONFIG_SCHED_OMIT_FRAME_POINTER=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_PPC_OF=y
CONFIG_PPC_UDBG_16550=y
CONFIG_GENERIC_TBSYNC=y
CONFIG_AUDIT_ARCH=y
CONFIG_GENERIC_BUG=y
# CONFIG_EPAPR_BOOT is not set
CONFIG_DEFAULT_UIMAGE=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
# CONFIG_PPC_DCR_NATIVE is not set
# CONFIG_PPC_DCR_MMIO is not set
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_PPC_ADV_DEBUG_REGS=y
CONFIG_PPC_ADV_DEBUG_IACS=2
CONFIG_PPC_ADV_DEBUG_DACS=2
CONFIG_PPC_ADV_DEBUG_DVCS=0
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_HAVE_IRQ_WORK=y

CONFIG_KEXEC=y
# CONFIG_CRASH_DUMP is not set

CONFIG_PPC_4K_PAGES=y

#
# Advanced setup
#
CONFIG_ADVANCED_OPTIONS=y
# CONFIG_LOWMEM_SIZE_BOOL is not set
CONFIG_LOWMEM_SIZE=0x30000000
# CONFIG_LOWMEM_CAM_NUM_BOOL is not set
CONFIG_LOWMEM_CAM_NUM=3
CONFIG_DYNAMIC_MEMSTART=y
# CONFIG_PAGE_OFFSET_BOOL is not set
CONFIG_PAGE_OFFSET=0xc0000000
# CONFIG_KERNEL_START_BOOL is not set
CONFIG_KERNEL_START=0xc0000000
# CONFIG_PHYSICAL_START_BOOL is not set
CONFIG_PHYSICAL_START=0x00000000
CONFIG_PHYSICAL_ALIGN=0x04000000
# CONFIG_TASK_SIZE_BOOL is not set
CONFIG_TASK_SIZE=0xc0000000

The version of the kexec tool is 2.04.

Any ideas?

- Stefani
