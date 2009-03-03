Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D28CDDDF00
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Mar 2009 15:55:40 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n234tZlH007892
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Mar 2009 22:55:36 -0600
Subject: next branch status
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 03 Mar 2009 15:55:34 +1100
Message-Id: <1236056134.20465.18.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hoy hoy !

So I somewhat lost track of what I announced and what not already so
here's a full shortlog of what's in today vs. Linus, followed by a
diffstat.

Heads up as the merge window is opening soon.

I still have to scrub patchwork for new stuff that got posted since the
last "test" update last week, don't go bonkers if you don't see your
patch in if you posted it last week, only if it's older than that.

Note: Test is empty right now (ie. == next)

Note: Kumar and Grant, pls be a bit more careful with files outside of
arch/powerpc ... like the 5200 fec driver change, even if it's really
powerpc only stuff and quite clearly so, it's in drivers/net, it
wouldn't have hurt to seek davem ack for it... No big deal, it's only 2
or 3 files that I might need to give Linus an explanation about tho :-)

Cheers,
Ben.

Anton Blanchard (11):
      powerpc/mm: Move 64-bit unmapped_area to top of address space
      powerpc/mm: Reduce hashtable size when using 64kB pages
      powerpc: Move is_32bit_task
      powerpc: Rearrange mmap.c
      powerpc: Randomise mmap start address
      powerpc: More stack randomisation for 64bit binaries
      powerpc: Randomise lower bits of stack address
      powerpc: Randomise the brk region
      powerpc: Ensure random space between stack and mmaps
      powerpc: Increase stack gap on 64bit binaries
      powerpc: Randomise PIEs

Anton Vorontsov (5):
      powerpc/fsl_pci: Add MPC83xx PCI-E controller RC mode support
      powerpc/83xx: Add PCI-E support for all MPC83xx boards with PCI-E
      powerpc: Document FSL eSDHC bindings
      powerpc/83xx: Convert existing sdhc nodes to new bindings
      powerpc/83xx: Add FSL eSDHC support for MPC837x-RDB boards

Arnd Bergmann (1):
      powerpc/cell: Fix dependency in cpufreq

Benjamin Herrenschmidt (3):
      powerpc/mm: Rework I$/D$ coherency (v3)
      powerpc/4xx: Add missing USB and i2c devices to Canyonlands
      powerpc/4xx: Enable PCI domains on 4xx

Benjamin Krill (1):
      powerpc/cell: Add rtas rtc calls for the QPACE platform

Brian King (1):
      powerpc/pseries: Fix partition migration hang under load

Gabriel Paubert (1):
      powerpc: Disable mv643xx Ethernet port 0 on Pegasos

Gerhard Pircher (4):
      powerpc/amigaone: Add platform support for AmigaOne
      powerpc/amigaone: Generic device tree for all AmigaOne boards
      powerpc/amigaone: Bootwrapper and serial console support for AmigaOne
      powerpc/amigaone: Default config for AmigaOne boards

Giuliano Pochini (1):
      powerpc/powermac: Hotplug /sys entries are missing

Grant Likely (7):
      powerpc/5200: Stop using device_type and port-number properties
      powerpc/5200: Trim cruft from device trees
      powerpc/5200: Don't specify IRQF_SHARED in PSC UART driver
      powerpc/5200: Remove pr_debug() from hot paths in irq driver
      powerpc/5200: Refactor mpc5200 interrupt controller driver
      powerpc/5200: Rework GPT driver to also be an IRQ controller
      powerpc/5200: Add support for the Media5200 board from Freescale

Grzegorz Bernacki (1):
      powerpc/5200: Add support for the digsy MTC board.

Ilya Yanok (1):
      powerpc: Rework dma-noncoherent to use generic vmalloc layer

Jeremy Kerr (3):
      powerpc/spufs: Use correct return value for spu_handle_mm_fault
      powerpc/spufs: Clear purge status before setting up isolated mode
      powerpc/spufs: Constify context contents and coredump callback constants

Kumar Gala (10):
      powerpc/fsl-booke: Cleanup init/exception setup to be runtime
      powerpc/fsl: Ensure PCI_QUIRKS are enabled for FSL_PCI
      powerpc/85xx: Fixed PCI IO region sizes in mpc8572ds*.dts
      powerpc/85xx: Added 36-bit physical device tree for mpc8572ds board
      powerpc/fsl-booke: Add new ISA 2.06 page sizes and MAS defines
      powerpc/book-3e: Introduce concept of Book-3e MMU
      powerpc/fsl-booke: Fix compile warning
      powerpc: Unify opcode definitions and support
      powerpc: Fix warnings from make headers_check
      powerpc: Add support for using doorbells for SMP IPI

Laurent Pinchart (1):
      cpm2: Round the baud-rate clock divider to the nearest integer.

Madhulika Madishetty (1):
      AMCC PPC 460SX redwood SoC platform initial framework

Martyn Welch (3):
      powerpc/86xx: Board support for GE Fanuc SBC310
      powerpc/86xx: Default configutation for GE Fanuc's SBC310
      powerpc/86xx: Extend GE Fanuc GPIO driver for the SBC310

Michael Ellerman (9):
      powerpc: Remove unused ppc64_terminate_msg()
      powerpc: Allow debugging of LMBs with lmb=debug
      lmb: Rework lmb_dump_all() output
      powerpc/pseries: Fix MSI-X interrupt querying
      powerpc/pseries: Add support for ibm,req#msi-x
      powerpc/pseries: Check for MSI-X also in rtas_msi_pci_irq_fixup()
      powerpc/pseries: Return the number of MSIs we could allocate
      powerpc/pseries: Return req#msi(-x) if request is larger
      powerpc/pseries: Implement a quota system for MSIs

Michael Neuling (2):
      powerpc: Add alignment handler for new lfiwzx instruction
      powerpc: Fix load/store float double alignment handler

Mike Mason (1):
      powerpc/eeh: Only disable/enable LSI interrupts in EEH

Milton Miller (4):
      powerpc/numa: Avoid possible reference beyond prop. length in find_min_common_depth()
      powerpc/numa: Remove redundant find_cpu_node()
      powerpc/pseries: Remove write only variable in PCI DLPAR
      powerpc/pci: Move hose_list and pci_address_to_pio to pci-common

Nathan Fontenot (1):
      powerpc/numa: Cleanup hot_add_scn_to_nid

Peter Korsgaard (1):
      powerpc: convert dts-bindings/fsl/dma.txt to dts-v1 syntax

Reynes Philippe (3):
      powerpc/83xx: Add i2c eeprom to dts for MPC837x RDB
      powerpc/83xx: Add gpio to MPC837x RDB
      powerpc/83xx: Add lm75 to MPC837x RDB dts

Steven Rostedt (11):
      tracing/function-graph-tracer: make arch generic push pop functions
      ftrace, powerpc: replace debug macro with proper pr_deug
      powerpc, ftrace: fix compile error when modules not configured
      powerpc64: port of the function graph tracer
      powerpc64, tracing: add function graph tracer with dynamic tracing
      powerpc64, ftrace: save toc only on modules for function graph
      powerpc32, ftrace: save and restore mcount regs with macro
      powerpc32, ftrace: port function graph tracer to ppc32, static only
      powerpc32, ftrace: dynamic function graph tracer
      powerpc, ftrace: use unsigned int for instruction manipulation
      powerpc, ftrace: use create_branch lib function

Tom Arbuckle (1):
      powerpc/pci: Fix PCI<->OF matching of old style multifunc devices

Trent Piepho (3):
      powerpc/fsl-booke: Remove code duplication in lowmem mapping
      powerpc/fsl-booke: Allow larger CAM sizes than 256 MB
      powerpc/fsl-booke: Make CAM entries used for lowmem configurable

Wolfgang Grandegger (2):
      powerpc/85xx: TQM85xx - fix sensitivity of CAN interrupts
      powerpc/85xx: TQM85xx - add i2c device nodes for LM75

Yuri Tikhonov (1):
      powerpc/44x: Support for 256KB PAGE_SIZE

roel kluin (1):
      therm_adt746x: Fix signed/unsigned confusion


 Documentation/powerpc/dts-bindings/fsl/dma.txt   |   34 
 Documentation/powerpc/dts-bindings/fsl/esdhc.txt |   24 
 arch/powerpc/Kconfig                             |   72 +
 arch/powerpc/boot/Makefile                       |    9 
 arch/powerpc/boot/cuboot-amigaone.c              |   35 
 arch/powerpc/boot/dts/amigaone.dts               |  173 ++
 arch/powerpc/boot/dts/canyonlands.dts            |   28 
 arch/powerpc/boot/dts/cm5200.dts                 |   49 -
 arch/powerpc/boot/dts/digsy_mtc.dts              |  254 +++
 arch/powerpc/boot/dts/gef_sbc310.dts             |  364 +++++
 arch/powerpc/boot/dts/lite5200.dts               |   52 -
 arch/powerpc/boot/dts/lite5200b.dts              |   63 -
 arch/powerpc/boot/dts/media5200.dts              |  318 ++++
 arch/powerpc/boot/dts/motionpro.dts              |   42 -
 arch/powerpc/boot/dts/mpc8315erdb.dts            |   64 +
 arch/powerpc/boot/dts/mpc8377_mds.dts            |   71 +
 arch/powerpc/boot/dts/mpc8377_rdb.dts            |  102 +
 arch/powerpc/boot/dts/mpc8378_mds.dts            |   71 +
 arch/powerpc/boot/dts/mpc8378_rdb.dts            |  102 +
 arch/powerpc/boot/dts/mpc8379_mds.dts            |    7 
 arch/powerpc/boot/dts/mpc8379_rdb.dts            |   38 +
 arch/powerpc/boot/dts/mpc8572ds.dts              |   10 
 arch/powerpc/boot/dts/mpc8572ds_36b.dts          |  787 +++++++++++
 arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts   |    8 
 arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts   |    4 
 arch/powerpc/boot/dts/pcm030.dts                 |  182 +-
 arch/powerpc/boot/dts/redwood.dts                |  244 +++
 arch/powerpc/boot/dts/tqm5200.dts                |   32 
 arch/powerpc/boot/dts/tqm8540.dts                |    5 
 arch/powerpc/boot/dts/tqm8541.dts                |    5 
 arch/powerpc/boot/dts/tqm8548-bigflash.dts       |    9 
 arch/powerpc/boot/dts/tqm8548.dts                |    9 
 arch/powerpc/boot/dts/tqm8555.dts                |    5 
 arch/powerpc/boot/dts/tqm8560.dts                |    9 
 arch/powerpc/boot/serial.c                       |    3 
 arch/powerpc/boot/wrapper                        |    3 
 arch/powerpc/configs/44x/canyonlands_defconfig   |  266 +++-
 arch/powerpc/configs/44x/redwood_defconfig       | 1176 ++++++++++++++++
 arch/powerpc/configs/86xx/gef_sbc310_defconfig   | 1613 ++++++++++++++++++++++
 arch/powerpc/configs/amigaone_defconfig          | 1636 ++++++++++++++++++++++
 arch/powerpc/include/asm/bootx.h                 |    2 
 arch/powerpc/include/asm/code-patching.h         |    4 
 arch/powerpc/include/asm/cputable.h              |    4 
 arch/powerpc/include/asm/dbell.h                 |   43 +
 arch/powerpc/include/asm/elf.h                   |   14 
 arch/powerpc/include/asm/ftrace.h                |   39 +
 arch/powerpc/include/asm/highmem.h               |   12 
 arch/powerpc/include/asm/kvm.h                   |    2 
 arch/powerpc/include/asm/machdep.h               |    2 
 arch/powerpc/include/asm/mmu-44x.h               |    2 
 arch/powerpc/include/asm/mmu-book3e.h            |   66 +
 arch/powerpc/include/asm/mmu.h                   |    6 
 arch/powerpc/include/asm/page.h                  |    6 
 arch/powerpc/include/asm/page_32.h               |    4 
 arch/powerpc/include/asm/pgtable-ppc32.h         |   57 -
 arch/powerpc/include/asm/pgtable-ppc64.h         |   29 
 arch/powerpc/include/asm/pgtable.h               |   84 +
 arch/powerpc/include/asm/ppc-opcode.h            |   73 +
 arch/powerpc/include/asm/ppc_asm.h               |    6 
 arch/powerpc/include/asm/ps3fb.h                 |    1 
 arch/powerpc/include/asm/reg_booke.h             |    1 
 arch/powerpc/include/asm/spu_info.h              |    3 
 arch/powerpc/include/asm/swab.h                  |    2 
 arch/powerpc/include/asm/system.h                |    2 
 arch/powerpc/include/asm/thread_info.h           |   11 
 arch/powerpc/kernel/Makefile                     |   10 
 arch/powerpc/kernel/align.c                      |    2 
 arch/powerpc/kernel/cpu_setup_44x.S              |    1 
 arch/powerpc/kernel/cpu_setup_fsl_booke.S        |   31 
 arch/powerpc/kernel/cputable.c                   |   22 
 arch/powerpc/kernel/crash_dump.c                 |    2 
 arch/powerpc/kernel/dbell.c                      |   44 +
 arch/powerpc/kernel/entry_32.S                   |  129 +-
 arch/powerpc/kernel/entry_64.S                   |   89 +
 arch/powerpc/kernel/ftrace.c                     |  222 ++-
 arch/powerpc/kernel/head_booke.h                 |   19 
 arch/powerpc/kernel/head_fsl_booke.S             |  101 +
 arch/powerpc/kernel/module_64.c                  |    2 
 arch/powerpc/kernel/pci-common.c                 |   41 -
 arch/powerpc/kernel/pci_32.c                     |   36 
 arch/powerpc/kernel/pci_64.c                     |   19 
 arch/powerpc/kernel/process.c                    |   58 +
 arch/powerpc/kernel/prom.c                       |    6 
 arch/powerpc/kernel/rtas.c                       |   10 
 arch/powerpc/kernel/setup_64.c                   |    7 
 arch/powerpc/kernel/signal.h                     |   10 
 arch/powerpc/kernel/traps.c                      |   79 +
 arch/powerpc/kernel/vmlinux.lds.S                |    1 
 arch/powerpc/lib/dma-noncoherent.c               |  303 +---
 arch/powerpc/lib/feature-fixups.c                |    4 
 arch/powerpc/mm/fault.c                          |   46 -
 arch/powerpc/mm/fsl_booke_mmu.c                  |   95 +
 arch/powerpc/mm/hash_utils_64.c                  |    5 
 arch/powerpc/mm/mem.c                            |   33 
 arch/powerpc/mm/mmap.c                           |   64 +
 arch/powerpc/mm/numa.c                           |  174 +-
 arch/powerpc/mm/pgtable.c                        |  131 ++
 arch/powerpc/platforms/44x/Kconfig               |   19 
 arch/powerpc/platforms/44x/ppc44x_simple.c       |    1 
 arch/powerpc/platforms/52xx/Kconfig              |   12 
 arch/powerpc/platforms/52xx/Makefile             |    3 
 arch/powerpc/platforms/52xx/media5200.c          |  273 ++++
 arch/powerpc/platforms/52xx/mpc5200_simple.c     |    1 
 arch/powerpc/platforms/52xx/mpc52xx_gpio.c       |   85 -
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c        |  435 ++++++
 arch/powerpc/platforms/52xx/mpc52xx_pic.c        |  170 +-
 arch/powerpc/platforms/83xx/mpc831x_rdb.c        |    2 
 arch/powerpc/platforms/83xx/mpc837x_mds.c        |   10 
 arch/powerpc/platforms/83xx/mpc837x_rdb.c        |    2 
 arch/powerpc/platforms/86xx/Kconfig              |   10 
 arch/powerpc/platforms/86xx/Makefile             |    1 
 arch/powerpc/platforms/86xx/gef_gpio.c           |   36 
 arch/powerpc/platforms/86xx/gef_sbc310.c         |  230 +++
 arch/powerpc/platforms/Kconfig                   |   10 
 arch/powerpc/platforms/Kconfig.cputype           |    4 
 arch/powerpc/platforms/Makefile                  |    1 
 arch/powerpc/platforms/amigaone/Kconfig          |   18 
 arch/powerpc/platforms/amigaone/Makefile         |    1 
 arch/powerpc/platforms/amigaone/setup.c          |  170 ++
 arch/powerpc/platforms/cell/Kconfig              |   22 
 arch/powerpc/platforms/cell/qpace_setup.c        |    2 
 arch/powerpc/platforms/cell/spu_fault.c          |   48 -
 arch/powerpc/platforms/cell/spufs/file.c         |    8 
 arch/powerpc/platforms/cell/spufs/inode.c        |    5 
 arch/powerpc/platforms/cell/spufs/run.c          |    3 
 arch/powerpc/platforms/cell/spufs/spufs.h        |    8 
 arch/powerpc/platforms/chrp/pegasos_eth.c        |   72 -
 arch/powerpc/platforms/powermac/setup.c          |    3 
 arch/powerpc/platforms/pseries/eeh_driver.c      |   68 +
 arch/powerpc/platforms/pseries/msi.c             |  224 +++
 arch/powerpc/platforms/pseries/pci_dlpar.c       |    2 
 arch/powerpc/sysdev/cpm2.c                       |    3 
 arch/powerpc/sysdev/fsl_pci.c                    |  244 +++
 arch/powerpc/sysdev/ppc4xx_pci.c                 |    2 
 arch/x86/include/asm/ftrace.h                    |   25 
 arch/x86/kernel/dumpstack.c                      |    1 
 arch/x86/kernel/ftrace.c                         |   75 -
 drivers/macintosh/therm_adt746x.c                |    4 
 drivers/net/fec_mpc52xx.c                        |    6 
 drivers/serial/mpc52xx_uart.c                    |   40 -
 drivers/watchdog/Kconfig                         |    2 
 include/linux/ftrace.h                           |   24 
 include/linux/pci_ids.h                          |    8 
 kernel/trace/trace_functions_graph.c             |   75 +
 lib/lmb.c                                        |   42 -
 145 files changed, 10930 insertions(+), 1829 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/esdhc.txt
 create mode 100644 arch/powerpc/boot/cuboot-amigaone.c
 create mode 100644 arch/powerpc/boot/dts/amigaone.dts
 create mode 100644 arch/powerpc/boot/dts/digsy_mtc.dts
 create mode 100644 arch/powerpc/boot/dts/gef_sbc310.dts
 create mode 100644 arch/powerpc/boot/dts/media5200.dts
 create mode 100644 arch/powerpc/boot/dts/mpc8572ds_36b.dts
 create mode 100644 arch/powerpc/boot/dts/redwood.dts
 create mode 100644 arch/powerpc/configs/44x/redwood_defconfig
 create mode 100644 arch/powerpc/configs/86xx/gef_sbc310_defconfig
 create mode 100644 arch/powerpc/configs/amigaone_defconfig
 create mode 100644 arch/powerpc/include/asm/dbell.h
 rename arch/powerpc/include/asm/{mmu-fsl-booke.h => mmu-book3e.h} (52%)
 create mode 100644 arch/powerpc/include/asm/ppc-opcode.h
 create mode 100644 arch/powerpc/kernel/cpu_setup_fsl_booke.S
 create mode 100644 arch/powerpc/kernel/dbell.c
 create mode 100644 arch/powerpc/platforms/52xx/media5200.c
 create mode 100644 arch/powerpc/platforms/52xx/mpc52xx_gpt.c
 create mode 100644 arch/powerpc/platforms/86xx/gef_sbc310.c
 create mode 100644 arch/powerpc/platforms/amigaone/Kconfig
 create mode 100644 arch/powerpc/platforms/amigaone/Makefile
 create mode 100644 arch/powerpc/platforms/amigaone/setup.c
