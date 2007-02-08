Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17866.46398.200395.71006@cargo.ozlabs.ibm.com>
Date: Thu, 8 Feb 2007 16:29:34 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Please pull powerpc.git master branch
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please do:

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git

or, if the mirroring hasn't caught up:

git pull \
master.kernel.org:/pub/scm/linux/kernel/git/paulus/powerpc.git

There are lots of Cell changes in there, including PS3 updates and
support for Toshiba's 'Celleb' platform, plus the beginnings of
support for PA Semi's new PA6T processor, and a variety of other
updates and fixes for powerpc machines.

Thanks,
Paul.

 arch/powerpc/Kconfig                         |   49 +
 arch/powerpc/Kconfig.debug                   |   18 
 arch/powerpc/boot/Makefile                   |    1 
 arch/powerpc/boot/dts/mpc8272ads.dts         |   55 -
 arch/powerpc/boot/dts/mpc8323emds.dts        |  345 +++++
 arch/powerpc/boot/dts/mpc8560ads.dts         |   10 
 arch/powerpc/boot/dts/mpc866ads.dts          |  162 ++
 arch/powerpc/boot/dts/mpc885ads.dts          |  185 +++
 arch/powerpc/configs/celleb_defconfig        | 1408 +++++++++++++++++++++
 arch/powerpc/configs/mpc8272_ads_defconfig   |  848 +++++++++++++
 arch/powerpc/configs/mpc832xemds_defconfig   | 1083 ++++++++++++++++
 arch/powerpc/configs/mpc834x_itx_defconfig   |    7 
 arch/powerpc/configs/mpc834x_mds_defconfig   |    3 
 arch/powerpc/configs/mpc8360emds_defconfig   |    3 
 arch/powerpc/configs/mpc866_ads_defconfig    |  829 +++++++++++++
 arch/powerpc/configs/mpc885_ads_defconfig    |  827 ++++++++++++
 arch/powerpc/configs/pasemi_defconfig        | 1722 ++++++++++++++++++++++++++
 arch/powerpc/configs/ps3_defconfig           |  240 +++-
 arch/powerpc/kernel/Makefile                 |    1 
 arch/powerpc/kernel/cpu_setup_pa6t.S         |   44 +
 arch/powerpc/kernel/cputable.c               |   21 
 arch/powerpc/kernel/entry_64.S               |   59 -
 arch/powerpc/kernel/head_32.S                |    5 
 arch/powerpc/kernel/head_64.S                |    2 
 arch/powerpc/kernel/iomap.c                  |   20 
 arch/powerpc/kernel/irq.c                    |    8 
 arch/powerpc/kernel/kprobes.c                |    8 
 arch/powerpc/kernel/lparcfg.c                |   11 
 arch/powerpc/kernel/misc_64.S                |   40 +
 arch/powerpc/kernel/module_32.c              |    7 
 arch/powerpc/kernel/pci_32.c                 |    1 
 arch/powerpc/kernel/pci_64.c                 |    1 
 arch/powerpc/kernel/pmc.c                    |   37 -
 arch/powerpc/kernel/ppc_ksyms.c              |    1 
 arch/powerpc/kernel/prom.c                   |   18 
 arch/powerpc/kernel/ptrace.c                 |   24 
 arch/powerpc/kernel/setup_32.c               |    1 
 arch/powerpc/kernel/sysfs.c                  |  141 +-
 arch/powerpc/kernel/traps.c                  |  111 +-
 arch/powerpc/kernel/udbg.c                   |    4 
 arch/powerpc/kernel/udbg_16550.c             |   24 
 arch/powerpc/kernel/vio.c                    |    6 
 arch/powerpc/lib/Makefile                    |    4 
 arch/powerpc/lib/dma-noncoherent.c           |   24 
 arch/powerpc/lib/rheap.c                     |    6 
 arch/powerpc/mm/hugetlbpage.c                |    3 
 arch/powerpc/mm/mem.c                        |   24 
 arch/powerpc/mm/pgtable_32.c                 |    5 
 arch/powerpc/oprofile/common.c               |    2 
 arch/powerpc/oprofile/op_model_7450.c        |   10 
 arch/powerpc/oprofile/op_model_fsl_booke.c   |   81 +
 arch/powerpc/oprofile/op_model_power4.c      |   10 
 arch/powerpc/oprofile/op_model_rs64.c        |   10 
 arch/powerpc/platforms/52xx/Makefile         |    1 
 arch/powerpc/platforms/52xx/lite5200.c       |    6 
 arch/powerpc/platforms/52xx/mpc52xx_pci.c    |  412 ++++++
 arch/powerpc/platforms/82xx/mpc82xx.c        |    2 
 arch/powerpc/platforms/82xx/mpc82xx_ads.c    |    2 
 arch/powerpc/platforms/82xx/pq2ads.h         |    5 
 arch/powerpc/platforms/83xx/misc.c           |   29 
 arch/powerpc/platforms/83xx/mpc832x_mds.c    |    3 
 arch/powerpc/platforms/83xx/mpc834x_itx.c    |    2 
 arch/powerpc/platforms/83xx/mpc834x_sys.c    |    2 
 arch/powerpc/platforms/83xx/mpc8360e_pb.c    |    3 
 arch/powerpc/platforms/86xx/Kconfig          |    1 
 arch/powerpc/platforms/86xx/mpc86xx_smp.c    |    1 
 arch/powerpc/platforms/8xx/Kconfig           |  300 +----
 arch/powerpc/platforms/8xx/Makefile          |    6 
 arch/powerpc/platforms/8xx/m8xx_setup.c      |  303 +++++
 arch/powerpc/platforms/8xx/mpc86xads.h       |   95 +
 arch/powerpc/platforms/8xx/mpc86xads_setup.c |  301 +++++
 arch/powerpc/platforms/8xx/mpc885ads.h       |   95 +
 arch/powerpc/platforms/8xx/mpc885ads_setup.c |  387 ++++++
 arch/powerpc/platforms/Makefile              |    3 
 arch/powerpc/platforms/cell/Makefile         |    7 
 arch/powerpc/platforms/cell/spu_base.c       |    3 
 arch/powerpc/platforms/cell/spu_manage.c     |  420 ++++++
 arch/powerpc/platforms/cell/spu_priv1_mmio.c |  422 ------
 arch/powerpc/platforms/celleb/Makefile       |    9 
 arch/powerpc/platforms/celleb/beat.c         |  163 ++
 arch/powerpc/platforms/celleb/beat.h         |   40 +
 arch/powerpc/platforms/celleb/beat_syscall.h |  160 ++
 arch/powerpc/platforms/celleb/beat_wrapper.h |  220 +++
 arch/powerpc/platforms/celleb/htab.c         |  311 +++++
 arch/powerpc/platforms/celleb/hvCall.S       |  287 ++++
 arch/powerpc/platforms/celleb/interrupt.c    |  274 ++++
 arch/powerpc/platforms/celleb/interrupt.h    |   33 
 arch/powerpc/platforms/celleb/iommu.c        |  104 ++
 arch/powerpc/platforms/celleb/pci.c          |  481 +++++++
 arch/powerpc/platforms/celleb/pci.h          |   35 +
 arch/powerpc/platforms/celleb/scc.h          |  145 ++
 arch/powerpc/platforms/celleb/scc_epci.c     |  409 ++++++
 arch/powerpc/platforms/celleb/scc_sio.c      |  101 ++
 arch/powerpc/platforms/celleb/scc_uhc.c      |   94 +
 arch/powerpc/platforms/celleb/setup.c        |  191 +++
 arch/powerpc/platforms/celleb/smp.c          |  124 ++
 arch/powerpc/platforms/celleb/spu_priv1.c    |  208 +++
 arch/powerpc/platforms/celleb/udbg_beat.c    |   97 +
 arch/powerpc/platforms/embedded6xx/Kconfig   |    9 
 arch/powerpc/platforms/maple/pci.c           |   23 
 arch/powerpc/platforms/maple/setup.c         |    3 
 arch/powerpc/platforms/pasemi/Kconfig        |   10 
 arch/powerpc/platforms/pasemi/Makefile       |    3 
 arch/powerpc/platforms/pasemi/idle.c         |   88 +
 arch/powerpc/platforms/pasemi/iommu.c        |  281 ++++
 arch/powerpc/platforms/pasemi/pasemi.h       |   12 
 arch/powerpc/platforms/pasemi/pci.c          |   13 
 arch/powerpc/platforms/pasemi/powersave.S    |   80 +
 arch/powerpc/platforms/pasemi/setup.c        |  105 +-
 arch/powerpc/platforms/powermac/smp.c        |    1 
 arch/powerpc/platforms/ps3/Makefile          |    1 
 arch/powerpc/platforms/ps3/htab.c            |    1 
 arch/powerpc/platforms/ps3/interrupt.c       |  442 ++++---
 arch/powerpc/platforms/ps3/mm.c              |    1 
 arch/powerpc/platforms/ps3/os-area.c         |   22 
 arch/powerpc/platforms/ps3/platform.h        |  151 ++
 arch/powerpc/platforms/ps3/repository.c      |  220 +++
 arch/powerpc/platforms/ps3/setup.c           |   19 
 arch/powerpc/platforms/ps3/smp.c             |    3 
 arch/powerpc/platforms/ps3/spu.c             |   20 
 arch/powerpc/platforms/ps3/system-bus.c      |   34 -
 arch/powerpc/platforms/pseries/eeh.c         |   19 
 arch/powerpc/platforms/pseries/eeh_driver.c  |    3 
 arch/powerpc/platforms/pseries/firmware.c    |    1 
 arch/powerpc/platforms/pseries/lpar.c        |   55 +
 arch/powerpc/platforms/pseries/pci.c         |    2 
 arch/powerpc/sysdev/Makefile                 |    2 
 arch/powerpc/sysdev/commproc.c               |  398 ++++++
 arch/powerpc/sysdev/cpm2_pic.c               |  154 +-
 arch/powerpc/sysdev/cpm2_pic.h               |    2 
 arch/powerpc/sysdev/fsl_soc.c                |  274 ++++
 arch/powerpc/sysdev/grackle.c                |    2 
 arch/powerpc/sysdev/ipic.c                   |   17 
 arch/powerpc/sysdev/micropatch.c             |  743 +++++++++++
 arch/powerpc/sysdev/mpc8xx_pic.c             |  197 +++
 arch/powerpc/sysdev/mpc8xx_pic.h             |   12 
 arch/powerpc/sysdev/mpic.c                   |   66 +
 arch/powerpc/sysdev/qe_lib/qe_ic.c           |    6 
 arch/powerpc/xmon/ppc-opc.c                  |    7 
 arch/powerpc/xmon/spu-opc.c                  |    4 
 arch/ppc/8xx_io/cs4218_tdm.c                 |    1 
 arch/ppc/Kconfig                             |    9 
 arch/ppc/boot/simple/Makefile                |    4 
 arch/ppc/boot/simple/misc.c                  |   15 
 arch/ppc/configs/gemini_defconfig            |  618 ---------
 arch/ppc/kernel/Makefile                     |    1 
 arch/ppc/kernel/head.S                       |   18 
 arch/ppc/kernel/ppc_ksyms.c                  |    1 
 arch/ppc/lib/rheap.c                         |    3 
 arch/ppc/mm/pgtable.c                        |    5 
 arch/ppc/platforms/Makefile                  |    1 
 arch/ppc/platforms/gemini.h                  |  165 --
 arch/ppc/platforms/gemini_pci.c              |   41 -
 arch/ppc/platforms/gemini_prom.S             |   90 -
 arch/ppc/platforms/gemini_serial.h           |   40 -
 arch/ppc/platforms/gemini_setup.c            |  577 ---------
 arch/ppc/platforms/mpc866ads_setup.c         |    2 
 arch/ppc/syslib/Makefile                     |    1 
 arch/ppc/syslib/m8260_pci_erratum9.c         |    3 
 arch/ppc/syslib/m8xx_setup.c                 |    2 
 arch/ppc/syslib/ppc85xx_rio.c                |    2 
 arch/ppc/xmon/ppc-opc.c                      |    7 
 arch/ppc/xmon/start.c                        |    5 
 drivers/char/Kconfig                         |    7 
 drivers/char/Makefile                        |    1 
 drivers/char/hvc_beat.c                      |  134 ++
 drivers/char/watchdog/booke_wdt.c            |   20 
 drivers/macintosh/windfarm_core.c            |    6 
 drivers/net/fs_enet/fs_enet.h                |    1 
 drivers/net/gianfar_ethtool.c                |    2 
 drivers/ps3/Makefile                         |    1 
 drivers/ps3/vuart.c                          |    4 
 drivers/ps3/vuart.h                          |   38 -
 drivers/serial/cpm_uart/cpm_uart_cpm1.c      |   15 
 drivers/serial/cpm_uart/cpm_uart_cpm1.h      |    3 
 drivers/serial/cpm_uart/cpm_uart_cpm2.h      |    3 
 include/asm-powerpc/cputable.h               |   13 
 include/asm-powerpc/dcr.h                    |    1 
 include/asm-powerpc/elf.h                    |    2 
 include/asm-powerpc/firmware.h               |   10 
 include/asm-powerpc/fs_pd.h                  |   49 +
 include/asm-powerpc/hvcall.h                 |    1 
 include/asm-powerpc/io.h                     |    6 
 include/asm-powerpc/iommu.h                  |    1 
 include/asm-powerpc/ipic.h                   |    2 
 include/asm-powerpc/irq.h                    |    3 
 include/asm-powerpc/kprobes.h                |    7 
 include/asm-powerpc/mmu.h                    |    1 
 include/asm-powerpc/mpc52xx.h                |    2 
 include/asm-powerpc/mpc8260.h                |   24 
 include/asm-powerpc/mpc8xx.h                 |   28 
 include/asm-powerpc/mpic.h                   |   24 
 include/asm-powerpc/oprofile_impl.h          |   89 -
 include/asm-powerpc/pci-bridge.h             |    2 
 include/asm-powerpc/ps3.h                    |  225 +--
 include/asm-powerpc/reg.h                    |   14 
 include/asm-powerpc/smp.h                    |    1 
 include/asm-powerpc/spu.h                    |   13 
 include/asm-powerpc/spu_priv1.h              |    2 
 include/asm-powerpc/sstep.h                  |    1 
 include/asm-powerpc/time.h                   |    2 
 include/asm-powerpc/udbg.h                   |    2 
 include/asm-ppc/commproc.h                   |    1 
 include/asm-ppc/ibm4xx.h                     |    1 
 include/asm-ppc/m48t35.h                     |   77 -
 include/asm-ppc/reg_booke.h                  |    2 
 include/asm-ppc/serial.h                     |    2 
 include/linux/log2.h                         |   11 
 include/linux/sysdev.h                       |   12 
 209 files changed, 17427 insertions(+), 3422 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/mpc8323emds.dts
 create mode 100644 arch/powerpc/boot/dts/mpc866ads.dts
 create mode 100644 arch/powerpc/boot/dts/mpc885ads.dts
 create mode 100644 arch/powerpc/configs/celleb_defconfig
 create mode 100644 arch/powerpc/configs/mpc8272_ads_defconfig
 create mode 100644 arch/powerpc/configs/mpc832xemds_defconfig
 create mode 100644 arch/powerpc/configs/mpc866_ads_defconfig
 create mode 100644 arch/powerpc/configs/mpc885_ads_defconfig
 create mode 100644 arch/powerpc/configs/pasemi_defconfig
 create mode 100644 arch/powerpc/kernel/cpu_setup_pa6t.S
 rename arch/{ppc/kernel/dma-mapping.c => powerpc/lib/dma-noncoherent.c} (95%)
 create mode 100644 arch/powerpc/platforms/52xx/mpc52xx_pci.c
 create mode 100644 arch/powerpc/platforms/8xx/Makefile
 create mode 100644 arch/powerpc/platforms/8xx/m8xx_setup.c
 create mode 100644 arch/powerpc/platforms/8xx/mpc86xads.h
 create mode 100644 arch/powerpc/platforms/8xx/mpc86xads_setup.c
 create mode 100644 arch/powerpc/platforms/8xx/mpc885ads.h
 create mode 100644 arch/powerpc/platforms/8xx/mpc885ads_setup.c
 create mode 100644 arch/powerpc/platforms/cell/spu_manage.c
 create mode 100644 arch/powerpc/platforms/celleb/Makefile
 create mode 100644 arch/powerpc/platforms/celleb/beat.c
 create mode 100644 arch/powerpc/platforms/celleb/beat.h
 create mode 100644 arch/powerpc/platforms/celleb/beat_syscall.h
 create mode 100644 arch/powerpc/platforms/celleb/beat_wrapper.h
 create mode 100644 arch/powerpc/platforms/celleb/htab.c
 create mode 100644 arch/powerpc/platforms/celleb/hvCall.S
 create mode 100644 arch/powerpc/platforms/celleb/interrupt.c
 create mode 100644 arch/powerpc/platforms/celleb/interrupt.h
 create mode 100644 arch/powerpc/platforms/celleb/iommu.c
 create mode 100644 arch/powerpc/platforms/celleb/pci.c
 create mode 100644 arch/powerpc/platforms/celleb/pci.h
 create mode 100644 arch/powerpc/platforms/celleb/scc.h
 create mode 100644 arch/powerpc/platforms/celleb/scc_epci.c
 create mode 100644 arch/powerpc/platforms/celleb/scc_sio.c
 create mode 100644 arch/powerpc/platforms/celleb/scc_uhc.c
 create mode 100644 arch/powerpc/platforms/celleb/setup.c
 create mode 100644 arch/powerpc/platforms/celleb/smp.c
 create mode 100644 arch/powerpc/platforms/celleb/spu_priv1.c
 create mode 100644 arch/powerpc/platforms/celleb/udbg_beat.c
 create mode 100644 arch/powerpc/platforms/pasemi/Kconfig
 create mode 100644 arch/powerpc/platforms/pasemi/idle.c
 create mode 100644 arch/powerpc/platforms/pasemi/iommu.c
 create mode 100644 arch/powerpc/platforms/pasemi/powersave.S
 rename drivers/ps3/system-bus.c => arch/powerpc/platforms/ps3/system-bus.c (94%)
 create mode 100644 arch/powerpc/sysdev/commproc.c
 create mode 100644 arch/powerpc/sysdev/micropatch.c
 create mode 100644 arch/powerpc/sysdev/mpc8xx_pic.c
 create mode 100644 arch/powerpc/sysdev/mpc8xx_pic.h
 delete mode 100644 arch/ppc/configs/gemini_defconfig
 delete mode 100644 arch/ppc/platforms/gemini.h
 delete mode 100644 arch/ppc/platforms/gemini_pci.c
 delete mode 100644 arch/ppc/platforms/gemini_prom.S
 delete mode 100644 arch/ppc/platforms/gemini_serial.h
 delete mode 100644 arch/ppc/platforms/gemini_setup.c
 create mode 100644 drivers/char/hvc_beat.c
 create mode 100644 include/asm-powerpc/mpc8260.h
 create mode 100644 include/asm-powerpc/mpc8xx.h
 delete mode 100644 include/asm-ppc/m48t35.h

Adrian Bunk:
      [POWERPC] Remove the broken Gemini support

Ahmed S. Darwish:
      [POWERPC] Use ARRAY_SIZE macro when appropriate
      [POWERPC] PPC: Use ARRAY_SIZE macro when appropriate

Akinobu Mita:
      [POWERPC] Use is_init() instead of pid==1

Anton Blanchard:
      [POWERPC] Move ELF_ET_DYN_BASE up to 512MB point

Benjamin Herrenschmidt:
      [POWERPC] ps3: system bus minor mmio fix
      [POWERPC] ps3: cleanup interrupt bmp routines

David Gibson:
      [POWERPC] Compile fixes for arch/powerpc dcr code

David Woodhouse:
      [POWERPC] Mask 32-bit system call arguments to 32 bits on PPC64 in audit code

Geert Uytterhoeven:
      [POWERPC] ps3: repository storage support
      [POWERPC] ps3: add interrupt alloc for outlets
      [POWERPC] ps3: get av_multi_out params

Geoff Levand:
      [POWERPC] ps3: repository misc fixes
      [POWERPC] ps3: fix struct alignment attributes
      [POWERPC] ps3: rename interrupt symbols
      [POWERPC] ps3: smp interrupt fixes
      [POWERPC] ps3: bind interrupt to cpu
      [POWERPC] ps3: fix interrupt bmp
      [POWERPC] ps3: remove cpuinfo
      [POWERPC] ps3: get firmware version
      [POWERPC] ps3: remove unneeded header include
      [POWERPC] ps3: ps3_defconfig updates
      [POWERPC] PS3: Move system bus to platform directory
      [POWERPC] PS3: Move vuart declarations to ps3.h
      [POWERPC] PS3: Fix DMA scatter-gather
      [POWERPC] PS3: Enable USB mass storage

Grant Likely:
      [POWERPC] Add mpc52xx/lite5200 PCI support

Ishizaki Kou:
      [POWERPC] spufs: Add SPU register lock
      [POWERPC] TLB insertion cleanup
      [POWERPC] Fix oprofile support on Cell LPAR
      [POWERPC] Add a field for each specific bus to struct pci_controller
      [POWERPC] Add IRQ remapping hook
      [POWERPC] Celleb: hypervisor call numbers
      [POWERPC] Celleb: Cell SCC definitions
      [POWERPC] Celleb: Support PCI bus and base of I/O
      [POWERPC] Celleb: setup sio in SCC
      [POWERPC] Celleb: interfaces to the hypervisor
      [POWERPC] Celleb: support interrupts
      [POWERPC] Celleb: setup usb host controller in SCC
      [POWERPC] Celleb: support iommu
      [POWERPC] Celleb: htab routines
      [POWERPC] Celleb: support udbg
      [POWERPC] Celleb: hypervisor console driver
      [POWERPC] Celleb: consolidate spu management ops
      [POWERPC] Celleb: support spu priv1 ops
      [POWERPC] Celleb: basic support
      [POWERPC] Celleb: add celleb_defconfig

Jiri Kosina:
      [POWERPC] 86xx: local_irq_disable() is redundant after local_irq_save()
      [POWERPC] powermac: local_irq_disable() is redundant after local_irq_save()

Johannes Berg:
      [POWERPC] Fix comment in kernel/irq.c
      [POWERPC] windfarm: don't die on suspend thread signal
      [POWERPC] Remove bogus comment about page_is_ram

Kim Phillips:
      [POWERPC] 83xx: Add the mpc832xemds defconfig
      [POWERPC] 83xx: Add the mpc8323emds.dts

Kumar Gala:
      [POWERPC] 83xx: Fix Kconfig to only enable FP math emulation for the MPC832x
      [POWERPC] 83xx: Don't call ioremap in the reset function
      [POWERPC] 83xx:  Make platform *_init_IRQ() static
      [POWERPC] 83xx: Return a point to the struct ipic from ipic_init()
      [POWERPC] Remove fastcall function attribute
      [POWERPC] Enable stack debug features on ppc32
      [POWERPC] Added kprobes support to ppc32
      [POWERPC] Enable interrupts if we are doing fp math emulation
      [POWERPC] Fixup error handling when emulating a floating point instruction

Li Yang:
      [POWERPC] 83xx: Fix compiler warnings on 836x and 832x

Linas Vepstas:
      [POWERPC] Clarify EEH error message
      [POWERPC] pSeries: EEH improperly enabled for some Power4 systems

Livio Soares:
      [POWERPC] Fix performance monitor exception

Mariusz Kozlowski:
      [POWERPC] arch/ppc/kernel/prom.c of_node_(get|put) cleanup
      [POWERPC] arch/powerpc/kernel/vio.c of_node_put cleanup
      [POWERPC] arch/powerpc/sysdev/ipic.c of_node_get cleanup
      [POWERPC] arch/powerpc/sysdev/mpic.c of_node_get cleanup
      [POWERPC] arch/powerpc/sysdev/qe_lib of_node_get cleanup
      [POWERPC] arch/powerpc/sysdev/cpm2_pic.c of_node_get cleanup
      [POWERPC] ppc: cs4218_tdm remove extra brace

Mathieu Desnoyers:
      [POWERPC] Add export of vgacon_remap_base

Michael Neuling:
      [POWERPC] remove unused CPU_FTRS_POWER6X

Michal Ostrowski:
      [POWERPC] Do not write virq back to PCI config space

Nathan Lynch:
      [POWERPC] maple: improve CPC9x5 host bridge detection
      [POWERPC] Maple: don't override bus-range supplied by firmware
      [POWERPC] Maple: use mmio nvram

Olaf Hering:
      [POWERPC] Update fixup_winbond_82c105 comment

Olof Johansson:
      [POWERPC] Oprofile cleanup
      [POWERPC] Add PMC type to cputable
      [POWERPC] Introduce _SYSDEV_ATTR
      [POWERPC] PA6T PMC support
      [POWERPC] MPIC: support more than 256 sources
      [POWERPC] pasemi: UART udbg support
      [POWERPC] pasemi: Machine check handler
      [POWERPC] pasemi: Idle loops
      [POWERPC] pasemi: Implement restart
      [POWERPC] pasemi: SMP timebase sync
      [POWERPC] pasemi: Configure DMA controller interrupts
      [POWERPC] pasemi: iommu support
      [POWERPC] pasemi: defconfig

Paul Gortmaker:
      [POWERPC] Select DEFAULT_UIMAGE for HPC-NET/8641

Paul Mackerras:
      [POWERPC] Clear RI bit in MSR before restoring r13 when returning to userspace
      [POWERPC] Make pSeries use the H_BULK_REMOVE hypervisor call
      [POWERPC] Only use H_BULK_REMOVE if the firmware supports it

Pavel Roskin:
      [POWERPC] Assign all PCI busses on G3 Blue & White

Robert P. J. Day:
      [POWERPC] Fix apparent typo "CONFIG_SERIAL_CPM_SMC".
      [POWERPC] Add "is_power_of_2" checking to log2.h.
      [POWERPC] ppc: use syslog macro for the printk log level

Simon Vallet:
      [POWERPC] Add support for R_PPC_ADDR16_HI relocations

Stefan Roese:
      [POWERPC] ppc: Fix booke watchdog initialization

Stephen Rothwell:
      [POWERPC] Fix ppc64's writing to struct file_operations

Timur Tabi:
      [POWERPC] Fix array indexing error in rheap grow()

Vitaly Bordug:
      [POWERPC] cpm_uart: OF-related fix for CPM1
      [POWERPC] 8xx: platform specific mmu updates
      [POWERPC] 8xx: generic 8xx code arch/powerpc port
      [POWERPC] 8xx: platform related changes to the fsl_soc
      [POWERPC] 8xx: powerpc port of core CPM PIC
      [POWERPC] 8xx: Add mpc885ads support and common mpc8xx files
      [POWERPC] Add mpc866ads board-specific bits to arch/powerpc
      [POWERPC] cpm2: CPM2 interrupt controller fix
      [POWERPC] Fix kernel build errors for mpc8272ads and mpc8560ads
      [POWERPC] mpc8272ads: defconfig
