Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 09115B7B92
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 19:43:49 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3C001DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 19:43:47 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n7D9hdGC031630
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 04:43:40 -0500
Subject: test branch update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 13 Aug 2009 19:43:30 +1000
Message-Id: <1250156610.24143.3.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I've pushed a few more things to my -test branch (in addition to some
-next updates that I may have forgotten to mention yesterday).

So here's the whole lot of stuff that's in there today vs. upstream.

Please give it a spin, it's really only compile tested here (and I
haven't scrubbed the warnings yet in case they show something bad), so
things will simmer there for a couple of days I think before I'm
confident enough to put them into -next.

Anton Blanchard (3):
      powerpc: Move 64bit VDSO to improve context switch performance
      powerpc: Rearrange SLB preload code
      powerpc: Preload application text segment instead of TASK_UNMAPPED_BASE

Anton Vorontsov (3):
      powerpc/83xx: Add support for MPC8377E-WLAN boards
      powerpc/85xx: Add support for I2C EEPROMs on MPC8548CDS boards
      powerpc/83xx: Add eSDHC support for MPC837xE-RDB/WLAN boards

Benjamin Herrenschmidt (29):
      powerpc: Rename exception.h to exception-64s.h
      powerpc: Use names rather than numbers for SPRGs (v2)
      powerpc: Remove use of a second scratch SPRG in STAB code
      powerpc/mm: Fix definitions of FORCE_MAX_ZONEORDER in Kconfig
      powerpc/pmac: Fix PowerSurge SMP IPI allocation
      powerpc: Change PACA from SPRG3 to SPRG1
      powerpc: Add compat_sys_truncate
      powerpc/mm: Fix misplaced #endif in pgtable-ppc64-64k.h
      powerpc/of: Remove useless register save/restore when calling OF back
      powerpc/mm: Add HW threads support to no_hash TLB management
      powerpc/mm: Add opcode definitions for tlbivax and tlbsrx.
      powerpc/mm: Add more bit definitions for Book3E MMU registers
      powerpc/mm: Add support for early ioremap on non-hash 64-bit processors
      powerpc: Modify some ppc_asm.h macros to accomodate 64-bits Book3E
      powerpc/mm: Make low level TLB flush ops on BookE take additional args
      powerpc/mm: Call mmu_context_init() from ppc64
      powerpc: Clean ifdef usage in copy_thread()
      powerpc: Move definitions of secondary CPU spinloop to header file
      powerpc/mm: Rework & cleanup page table freeing code path
      powerpc: Add SPR definitions for new 64-bit BookE
      powerpc: Add memory management headers for new 64-bit BookE
      powerpc: Add definitions used by exception handling on 64-bit Book3E
      powerpc: Add PACA fields specific to 64-bit Book3E processors
      powerpc/mm: Move around mmu_gathers definition on 64-bit
      powerpc: Add TLB management code for 64-bit Book3E
      powerpc/mm: Add support for SPARSEMEM_VMEMMAP on 64-bit Book3E
      powerpc: Remaining 64-bit Book3E support
      powerpc/mm: Fix encoding of page table cache numbers
      powerpc/mm: Cleanup handling of execute permission

Benjamin Krill (1):
      powerpc/prom_init: Evaluate mem kernel parameter for early allocation

Christoph Hellwig (2):
      powerpc/sputrace: Use the generic event tracer
      powerpc: Switch to asm-generic/hardirq.h

Frans Pop (1):
      powerpc: Makefile simplification through use of cc-ifversion

Geert Uytterhoeven (1):
      powerpc/cell: Move CBE_IOPTE_* to <asm/cell-regs.h>

Geoff Thorpe (1):
      powerpc: expose the multi-bit ops that underlie single-bit ops.

Gerhard Pircher (1):
      powerpc/amigaone: Convert amigaone_init() to a machine_device_initcall()

Heiko Schocher (1):
      powerpc/82xx: mgcoge - updates for 2.6.32

Julia Lawall (5):
      powerpc/fsl_rio: Add kmalloc NULL tests
      powerpc/ipic: introduce missing kfree
      powerpc/qe: introduce missing kfree
      hvc_console: Drop unnecessary NULL test
      powerpc: Use DIV_ROUND_CLOSEST in time init code

Kumar Gala (3):
      powerpc/mm: Fix switch_mmu_context to iterate of the proper list of cpus
      powerpc/85xx: Move mpc8536ds.dts to address-cells/size-cells = <2>
      powerpc/85xx: Added 36-bit physical device tree for mpc8572ds board

Lucian Adrian Grijincu (1):
      powerpc: Update boot wrapper script with the new location of dtc

Martyn Welch (4):
      powerpc/86xx: Correct reading of information presented in cpuinfo
      powerpc/86xx: Enable XMC site on GE Fanuc SBC310
      powerpc/86xx: Update GE Fanuc sbc310 DTS
      powerpc/nvram: Allow byte length reads from mmio NVRAM driver

Michael Ellerman (5):
      powerpc/mpic: Fix MPIC_BROKEN_REGREAD on non broken MPICs
      kmemleak: Allow kmemleak to be built on powerpc
      powerpc: Enable GCOV
      powerpc/vmlinux.lds: Move _edata down
      powerpc: Add kmemleak annotations to lmb.c

Michel Dänzer (2):
      agp/uninorth: Allow larger aperture sizes on pre-U3 bridges.
      agp/uninorth: Simplify cache flushing.

Roel Kluin (2):
      powerpc/fsl-booke: read buffer overflow
      powerpc/hvsi: Avoid calculating possibly-invalid address

Sebastian Andrzej Siewior (1):
      powerpc/ipic: unmask all interrupt sources

Stefan Roese (5):
      powerpc: Add AMCC 460EX/460GT Rev. B support to cputable.c
      powerpc/44x: Add NAND support to Canyonlands dts
      powerpc/40x: Update Kilauea dts to support NAND, RTC and HWMON
      powerpc/44x: Update Canyonlands defconfig to support NOR, NAND and RTC
      powerpc/40x: Update kilauea defconfig to support NAND, RTC and HWMON

Stephen Rothwell (1):
      powerpc: use consistent types in mktree

Stoyan Gaydarov (1):
      powerpc: ARRAY_SIZE changes in pasemi and powermac code

roel kluin (3):
      powerpc/cell: Replace strncpy by strlcpy
      powerpc: Missing tests for NULL after ioremap()
      powerpc/macio: Don't the address of an array element before boundchecking
