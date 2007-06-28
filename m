Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18051.44968.28667.678931@cargo.ozlabs.ibm.com>
Date: Thu, 28 Jun 2007 22:55:04 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: patches pushed to powerpc.git for-2.6.23 branch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have just pushed some more patches to the for-2.6.23 branch of
powerpc.git.  There are still more to go, of course. :)

If anyone has a patch that was posted more than a couple of weeks ago
that they want to go in and that isn't in, it would be a good idea to
remind me (or Kumar for 8xxx stuff, or Arnd for cell stuff) of it.

Paul.

David Gibson (3):
      [POWERPC] Make more OF-related bootwrapper functions available to non-OF platforms
      [POWERPC] Abolish unused ucBoardRev variables
      [POWERPC] In booting-without-of.txt, clarify that properties must precede subnodes

David Woodhouse (2):
      [POWERPC] PS3: System-bus uevent
      [POWERPC] PS3: System-bus modinfo attribute

Geert Uytterhoeven (7):
      [POWERPC] PS3: Fix sparse warnings
      [POWERPC] PS3: Simplify definition of DBG
      [POWERPC] PS3: Frame buffer system-bus rework
      [POWERPC] PS3: Fix more sparse warnings
      [POWERPC] PS3: Preallocate bootmem memory for the PS3 FLASH ROM storage driver
      [POWERPC] PS3: Storage Driver Core
      [POWERPC] PS3: Storage device registration routines

Geoff Levand (23):
      [POWERPC] cell: Add spu shutdown method
      [POWERPC] PS3: Rename IPI symbols
      [POWERPC] PS3: Use __maybe_unused
      [POWERPC] PS3: Map SPU regions as non-guarded
      [POWERPC] PS3: Move chip mask defs up
      [POWERPC] PS3: Kexec support
      [POWERPC] PS3: System-bus rework
      [POWERPC] PS3: Repository probe cleanups
      [POWERPC] PS3: Vuart rework
      [POWERPC] PS3: System manager re-work
      [POWERPC] PS3: Rework AV settings driver
      [POWERPC] PS3: Device registration routines.
      [POWERPC] PS3: Rename processor id symbols
      [POWERPC] PS3: Use clear_bit
      [POWERPC] Output params value in early_init_devtree
      [POWERPC] Correct __secondary_hold comment
      [POWERPC] Add signed types to bootwrapper
      [POWERPC] Add u64 printf to bootwrapper
      [POWERPC] Fix constantness of bootwrapper arg
      [POWERPC] Make kernel_entry_t have global scope in bootwrapper
      [POWERPC] PS3: Device tree source
      [POWERPC] PS3: Select MEMORY_HOTPLUG
      [POWERPC] PS3: Update ps3_defconfig

Guennadi Liakhovetski (1):
      [POWERPC] Don't link timer.o for powerpc systems using generic rtc

Johannes Berg (1):
      [POWERPC] Use mktime in timer sysdev

Mark A. Greer (5):
      [POWERPC] Remove 'make zImage.dts' feature
      [POWERPC] When appropriate, wrap device tree with zImage
      [POWERPC] Update holly to use new dts wrapping feature
      [POWERPC] Call add_preferred_console when MPSC is console
      [POWERPC] Remove 'console=' from cmdline on prpmc2800

Masakazu Mokuno (1):
      [POWERPC] PS3: Compare firmware version

Masashi Kimoto (1):
      [POWERPC] PS3: Add support for HDMI RGB Full Range mode

Michael Ellerman (4):
      [POWERPC] Split virq setup logic out into irq_setup_virq()
      [POWERPC] Add irq_create_direct_mapping()
      [POWERPC] Add for_each_compatible_node()
      [POWERPC] Turn off debugging in arch/powerpc/kernel/pci_64.c

Michael Neuling (2):
      [POWERPC] Fix stolen time for SMT without LPAR
      [POWERPC] Do firmware feature fixups after features are initialised

Milton Miller (1):
      [POWERPC] kexec: Send slaves to new kernel earlier

Mohan Kumar M (1):
      [POWERPC] Fix interrupt distribution in ppc970

Nathan Lynch (1):
      [POWERPC] Remove spinlock from struct cpu_purr_data

Olof Johansson (2):
      [POWERPC] pasemi: Electra IDE/pata_platform glue
      [POWERPC] Uninline and export virq_to_hw()

Sachin P. Sant (1):
      [POWERPC] Fix Kexec/Kdump for power6

Tony Breeds (1):
      [POWERPC] Move iSeries_tb_recal into its own late_initcall.

 Documentation/powerpc/booting-without-of.txt    |    8 
 arch/powerpc/Kconfig                            |    5 
 arch/powerpc/Makefile                           |    2 
 arch/powerpc/boot/Makefile                      |   50 -
 arch/powerpc/boot/dts/prpmc2800.dts             |    2 
 arch/powerpc/boot/dts/ps3.dts                   |   68 ++
 arch/powerpc/boot/main.c                        |    2 
 arch/powerpc/boot/of.c                          |   30 -
 arch/powerpc/boot/of.h                          |    6 
 arch/powerpc/boot/ofconsole.c                   |   10 
 arch/powerpc/boot/oflib.c                       |   40 +
 arch/powerpc/boot/ops.h                         |    4 
 arch/powerpc/boot/serial.c                      |    2 
 arch/powerpc/boot/stdio.c                       |   10 
 arch/powerpc/boot/types.h                       |    4 
 arch/powerpc/configs/holly_defconfig            |  104 +--
 arch/powerpc/configs/ps3_defconfig              |  131 ++--
 arch/powerpc/kernel/head_64.S                   |    4 
 arch/powerpc/kernel/irq.c                       |   62 +-
 arch/powerpc/kernel/misc_64.S                   |   26 -
 arch/powerpc/kernel/pci_64.c                    |    2 
 arch/powerpc/kernel/prom.c                      |    2 
 arch/powerpc/kernel/setup_64.c                  |   12 
 arch/powerpc/kernel/time.c                      |   56 +-
 arch/powerpc/platforms/cell/spu_base.c          |   12 
 arch/powerpc/platforms/embedded6xx/Kconfig      |    1 
 arch/powerpc/platforms/iseries/setup.c          |    6 
 arch/powerpc/platforms/pasemi/Kconfig           |   10 
 arch/powerpc/platforms/pasemi/Makefile          |    1 
 arch/powerpc/platforms/pasemi/electra_ide.c     |   96 +++
 arch/powerpc/platforms/ps3/Kconfig              |   26 -
 arch/powerpc/platforms/ps3/Makefile             |    1 
 arch/powerpc/platforms/ps3/device-init.c        |  785 ++++++++++++++++++++++
 arch/powerpc/platforms/ps3/htab.c               |   19 -
 arch/powerpc/platforms/ps3/interrupt.c          |  272 ++++----
 arch/powerpc/platforms/ps3/mm.c                 |  630 +++++++++++++++---
 arch/powerpc/platforms/ps3/os-area.c            |    4 
 arch/powerpc/platforms/ps3/platform.h           |   43 +
 arch/powerpc/platforms/ps3/repository.c         |  586 +++++++++-------
 arch/powerpc/platforms/ps3/setup.c              |  105 ++-
 arch/powerpc/platforms/ps3/smp.c                |   18 -
 arch/powerpc/platforms/ps3/spu.c                |   13 
 arch/powerpc/platforms/ps3/system-bus.c         |  562 ++++++++++++++--
 arch/powerpc/platforms/ps3/time.c               |    2 
 arch/powerpc/platforms/pseries/lpar.c           |   17 
 arch/powerpc/platforms/pseries/plpar_wrappers.h |   15 
 arch/powerpc/platforms/pseries/xics.c           |   53 +
 arch/powerpc/sysdev/Makefile                    |    2 
 arch/powerpc/sysdev/mv64x60_dev.c               |   28 +
 arch/powerpc/sysdev/timer.c                     |   14 
 arch/ppc/platforms/prep_setup.c                 |    3 
 drivers/ps3/Makefile                            |    5 
 drivers/ps3/ps3av.c                             |  372 ++++++----
 drivers/ps3/ps3av_cmd.c                         |   51 +
 drivers/ps3/ps3stor_lib.c                       |  302 +++++++++
 drivers/ps3/sys-manager-core.c                  |   68 ++
 drivers/ps3/sys-manager.c                       |  290 +++++---
 drivers/ps3/vuart.c                             |  817 ++++++++++++++---------
 drivers/ps3/vuart.h                             |   71 +-
 drivers/video/Kconfig                           |    4 
 drivers/video/ps3fb.c                           |  290 ++++----
 include/asm-powerpc/irq.h                       |   14 
 include/asm-powerpc/lv1call.h                   |    3 
 include/asm-powerpc/mmu-hash64.h                |    3 
 include/asm-powerpc/processor.h                 |    8 
 include/asm-powerpc/prom.h                      |    3 
 include/asm-powerpc/ps3.h                       |  182 +++--
 include/asm-powerpc/ps3av.h                     |   48 +
 include/asm-powerpc/ps3fb.h                     |   12 
 include/asm-powerpc/ps3stor.h                   |   71 ++
 include/asm-powerpc/time.h                      |    4 
 71 files changed, 4635 insertions(+), 1949 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/ps3.dts
 create mode 100644 arch/powerpc/platforms/pasemi/electra_ide.c
 create mode 100644 arch/powerpc/platforms/ps3/device-init.c
 create mode 100644 drivers/ps3/ps3stor_lib.c
 create mode 100644 drivers/ps3/sys-manager-core.c
 create mode 100644 include/asm-powerpc/ps3stor.h
