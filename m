Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17683.34095.750766.585939@cargo.ozlabs.ibm.com>
Date: Fri, 22 Sep 2006 16:39:43 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: Please pull powerpc.git 'master' branch
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

to get a PowerPC update for 2.6.19-rc1.

Thanks,
Paul.

 MAINTAINERS                                       |    7 
 arch/powerpc/Kconfig                              |   14 
 arch/powerpc/Kconfig.debug                        |   16 +
 arch/powerpc/boot/Makefile                        |    7 
 arch/powerpc/boot/dts/mpc8349emds.dts             |   16 -
 arch/powerpc/boot/flatdevtree.h                   |   46 ++
 arch/powerpc/boot/main.c                          |  250 +++++----
 arch/powerpc/boot/of.c                            |  283 ++++++++++
 arch/powerpc/boot/ops.h                           |  100 ++++
 arch/powerpc/boot/prom.c                          |  165 ------
 arch/powerpc/boot/prom.h                          |   41 -
 arch/powerpc/boot/stdio.c                         |    4 
 arch/powerpc/boot/stdio.h                         |    8 
 arch/powerpc/boot/types.h                         |   23 +
 arch/powerpc/configs/maple_defconfig              |    2 
 arch/powerpc/kernel/Makefile                      |    4 
 arch/powerpc/kernel/asm-offsets.c                 |   17 +
 arch/powerpc/kernel/btext.c                       |   24 -
 arch/powerpc/kernel/cpu_setup_ppc970.S            |  103 +---
 arch/powerpc/kernel/cputable.c                    |   21 +
 arch/powerpc/kernel/crash_dump.c                  |    2 
 arch/powerpc/kernel/dma_64.c                      |   65 +-
 arch/powerpc/kernel/entry_64.S                    |    8 
 arch/powerpc/kernel/head_64.S                     |   54 +-
 arch/powerpc/kernel/ibmebus.c                     |    6 
 arch/powerpc/kernel/io.c                          |  131 +++++
 arch/powerpc/kernel/irq.c                         |    5 
 arch/powerpc/kernel/legacy_serial.c               |   35 +
 arch/powerpc/kernel/lparcfg.c                     |   30 +
 arch/powerpc/kernel/machine_kexec_64.c            |   10 
 arch/powerpc/kernel/misc.S                        |  159 ------
 arch/powerpc/kernel/of_device.c                   |   24 -
 arch/powerpc/kernel/paca.c                        |   15 -
 arch/powerpc/kernel/pci_32.c                      |   39 +
 arch/powerpc/kernel/pci_64.c                      |   67 +-
 arch/powerpc/kernel/pci_dn.c                      |   13 
 arch/powerpc/kernel/ppc_ksyms.c                   |   19 -
 arch/powerpc/kernel/prom.c                        |   44 --
 arch/powerpc/kernel/prom_init.c                   |   10 
 arch/powerpc/kernel/prom_parse.c                  |   90 ++-
 arch/powerpc/kernel/rtas-proc.c                   |   25 -
 arch/powerpc/kernel/rtas.c                        |   47 +-
 arch/powerpc/kernel/rtas_pci.c                    |   28 -
 arch/powerpc/kernel/setup-common.c                |   32 +
 arch/powerpc/kernel/setup_64.c                    |   23 -
 arch/powerpc/kernel/sysfs.c                       |    9 
 arch/powerpc/kernel/time.c                        |    8 
 arch/powerpc/kernel/traps.c                       |   25 +
 arch/powerpc/kernel/vio.c                         |   16 -
 arch/powerpc/lib/Makefile                         |    1 
 arch/powerpc/lib/e2a.c                            |  116 ----
 arch/powerpc/lib/locks.c                          |   27 -
 arch/powerpc/mm/numa.c                            |   31 -
 arch/powerpc/mm/slb.c                             |   37 +
 arch/powerpc/mm/tlb_64.c                          |    1 
 arch/powerpc/platforms/83xx/mpc834x_itx.c         |    4 
 arch/powerpc/platforms/83xx/mpc834x_sys.c         |    4 
 arch/powerpc/platforms/83xx/pci.c                 |    4 
 arch/powerpc/platforms/85xx/mpc85xx_ads.c         |    4 
 arch/powerpc/platforms/85xx/mpc85xx_cds.c         |    4 
 arch/powerpc/platforms/85xx/pci.c                 |    4 
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c        |    4 
 arch/powerpc/platforms/86xx/pci.c                 |    4 
 arch/powerpc/platforms/Makefile                   |    1 
 arch/powerpc/platforms/cell/cbe_regs.c            |    8 
 arch/powerpc/platforms/cell/interrupt.c           |   25 -
 arch/powerpc/platforms/cell/iommu.c               |   22 -
 arch/powerpc/platforms/cell/setup.c               |    4 
 arch/powerpc/platforms/cell/smp.c                 |    4 
 arch/powerpc/platforms/cell/spider-pic.c          |   10 
 arch/powerpc/platforms/cell/spu_base.c            |   18 -
 arch/powerpc/platforms/chrp/nvram.c               |    5 
 arch/powerpc/platforms/chrp/pci.c                 |   53 ++
 arch/powerpc/platforms/chrp/setup.c               |   48 +-
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |    8 
 arch/powerpc/platforms/iseries/Kconfig            |    8 
 arch/powerpc/platforms/iseries/dt.c               |   45 +-
 arch/powerpc/platforms/iseries/hvlpconfig.c       |   13 
 arch/powerpc/platforms/iseries/iommu.c            |   19 +
 arch/powerpc/platforms/iseries/it_exp_vpd_panel.h |    6 
 arch/powerpc/platforms/iseries/it_lp_naca.h       |    6 
 arch/powerpc/platforms/iseries/lpardata.c         |    6 
 arch/powerpc/platforms/iseries/lpevents.c         |    2 
 arch/powerpc/platforms/iseries/main_store.h       |  126 ++--
 arch/powerpc/platforms/iseries/pci.c              |  289 ++++++++--
 arch/powerpc/platforms/iseries/setup.c            |    1 
 arch/powerpc/platforms/iseries/viopath.c          |   28 +
 arch/powerpc/platforms/iseries/vpdinfo.c          |   22 -
 arch/powerpc/platforms/maple/pci.c                |   70 +-
 arch/powerpc/platforms/maple/setup.c              |   27 -
 arch/powerpc/platforms/pasemi/Makefile            |    1 
 arch/powerpc/platforms/pasemi/pasemi.h            |    8 
 arch/powerpc/platforms/pasemi/pci.c               |  198 +++++++
 arch/powerpc/platforms/pasemi/setup.c             |  188 +++++++
 arch/powerpc/platforms/pasemi/time.c              |   29 +
 arch/powerpc/platforms/powermac/backlight.c       |    3 
 arch/powerpc/platforms/powermac/cpufreq_32.c      |   23 -
 arch/powerpc/platforms/powermac/cpufreq_64.c      |   27 -
 arch/powerpc/platforms/powermac/feature.c         |   30 +
 arch/powerpc/platforms/powermac/low_i2c.c         |   24 -
 arch/powerpc/platforms/powermac/pci.c             |   37 +
 arch/powerpc/platforms/powermac/pfunc_base.c      |    2 
 arch/powerpc/platforms/powermac/pfunc_core.c      |    5 
 arch/powerpc/platforms/powermac/setup.c           |   18 -
 arch/powerpc/platforms/powermac/smp.c             |    7 
 arch/powerpc/platforms/powermac/udbg_scc.c        |   10 
 arch/powerpc/platforms/pseries/Makefile           |    1 
 arch/powerpc/platforms/pseries/eeh.c              |   96 +++
 arch/powerpc/platforms/pseries/eeh_cache.c        |   17 -
 arch/powerpc/platforms/pseries/eeh_driver.c       |  112 +++-
 arch/powerpc/platforms/pseries/eeh_event.c        |    4 
 arch/powerpc/platforms/pseries/firmware.c         |    2 
 arch/powerpc/platforms/pseries/hvCall.S           |  273 ++++------
 arch/powerpc/platforms/pseries/hvCall_inst.c      |  129 +++++
 arch/powerpc/platforms/pseries/hvconsole.c        |    5 
 arch/powerpc/platforms/pseries/iommu.c            |   13 
 arch/powerpc/platforms/pseries/lpar.c             |   46 +-
 arch/powerpc/platforms/pseries/nvram.c            |    5 
 arch/powerpc/platforms/pseries/pci.c              |    2 
 arch/powerpc/platforms/pseries/plpar_wrappers.h   |  107 +++-
 arch/powerpc/platforms/pseries/ras.c              |    4 
 arch/powerpc/platforms/pseries/rtasd.c            |    4 
 arch/powerpc/platforms/pseries/setup.c            |   42 +
 arch/powerpc/platforms/pseries/smp.c              |   12 
 arch/powerpc/platforms/pseries/xics.c             |   44 --
 arch/powerpc/sysdev/fsl_soc.c                     |   28 -
 arch/powerpc/sysdev/fsl_soc.h                     |    2 
 arch/powerpc/sysdev/i8259.c                       |    2 
 arch/powerpc/sysdev/ipic.c                        |   42 +
 arch/powerpc/sysdev/mmio_nvram.c                  |    4 
 arch/powerpc/sysdev/tsi108_pci.c                  |    4 
 arch/powerpc/xmon/xmon.c                          |   10 
 arch/ppc/Kconfig                                  |    6 
 arch/ppc/kernel/misc.S                            |   88 ---
 arch/ppc/kernel/ppc_ksyms.c                       |    9 
 arch/ppc/kernel/setup.c                           |   17 -
 arch/ppc/platforms/85xx/sbc8560.h                 |    1 
 arch/ppc/platforms/85xx/sbc85xx.h                 |   18 +
 arch/ppc/syslib/m8260_pci_erratum9.c              |   16 -
 arch/ppc/xmon/start.c                             |   28 +
 arch/ppc/xmon/xmon.c                              |   28 +
 drivers/char/Kconfig                              |   22 +
 drivers/char/Makefile                             |    2 
 drivers/char/agp/uninorth-agp.c                   |    4 
 drivers/char/briq_panel.c                         |  268 +++++++++
 drivers/char/hvc_console.c                        |   18 -
 drivers/char/hvc_console.h                        |    2 
 drivers/char/hvc_iseries.c                        |  594 +++++++++++++++++++++
 drivers/char/hvc_rtas.c                           |    2 
 drivers/char/hvc_vio.c                            |    7 
 drivers/char/hvsi.c                               |    7 
 drivers/char/tpm/tpm_atmel.h                      |    4 
 drivers/char/viocons.c                            |   31 -
 drivers/char/viotape.c                            |    6 
 drivers/i2c/busses/i2c-powermac.c                 |    3 
 drivers/ide/ppc/pmac.c                            |    8 
 drivers/macintosh/macio_asic.c                    |   10 
 drivers/macintosh/macio_sysfs.c                   |    8 
 drivers/macintosh/smu.c                           |   19 -
 drivers/macintosh/therm_adt746x.c                 |    8 
 drivers/macintosh/therm_pm72.c                    |   14 
 drivers/macintosh/therm_windtunnel.c              |    4 
 drivers/macintosh/via-cuda.c                      |    4 
 drivers/macintosh/via-pmu-led.c                   |    2 
 drivers/macintosh/via-pmu.c                       |   10 
 drivers/macintosh/windfarm_pm81.c                 |    4 
 drivers/macintosh/windfarm_pm91.c                 |    2 
 drivers/macintosh/windfarm_smu_controls.c         |   13 
 drivers/macintosh/windfarm_smu_sat.c              |    8 
 drivers/macintosh/windfarm_smu_sensors.c          |   12 
 drivers/net/bmac.c                                |   13 
 drivers/net/ibmveth.c                             |    3 
 drivers/net/ibmveth.h                             |   27 +
 drivers/net/mace.c                                |    2 
 drivers/net/spider_net.c                          |   12 
 drivers/net/sungem.c                              |    2 
 drivers/pci/hotplug/rpaphp_core.c                 |   32 +
 drivers/scsi/ibmvscsi/rpa_vscsi.c                 |   11 
 drivers/scsi/mac53c94.c                           |    2 
 drivers/scsi/mesh.c                               |    5 
 drivers/scsi/sata_svw.c                           |    2 
 drivers/serial/pmac_zilog.c                       |    9 
 drivers/video/S3triofb.c                          |   12 
 drivers/video/aty/radeon_base.c                   |    8 
 drivers/video/aty/radeon_monitor.c                |   12 
 drivers/video/aty/radeon_pm.c                     |    4 
 drivers/video/nvidia/nv_of.c                      |   12 
 drivers/video/offb.c                              |   22 -
 drivers/video/riva/fbdev.c                        |    5 
 include/asm-powerpc/cputable.h                    |   27 +
 include/asm-powerpc/hvcall.h                      |  121 +---
 include/asm-powerpc/ibmebus.h                     |    2 
 include/asm-powerpc/ide.h                         |   12 
 include/asm-powerpc/io.h                          |  183 +++---
 include/asm-powerpc/irq.h                         |   24 -
 include/asm-powerpc/iseries/hv_call_xm.h          |   17 -
 include/asm-powerpc/iseries/hv_lp_config.h        |   13 
 include/asm-powerpc/iseries/iseries_io.h          |   60 --
 include/asm-powerpc/iseries/it_lp_queue.h         |    2 
 include/asm-powerpc/iseries/vio.h                 |   28 +
 include/asm-powerpc/lppaca.h                      |   23 +
 include/asm-powerpc/paca.h                        |    3 
 include/asm-powerpc/page.h                        |    6 
 include/asm-powerpc/ppc-pci.h                     |   11 
 include/asm-powerpc/processor.h                   |    1 
 include/asm-powerpc/prom.h                        |   40 +
 include/asm-powerpc/ptrace.h                      |    4 
 include/asm-powerpc/reg.h                         |    1 
 include/asm-powerpc/rtas.h                        |   16 +
 include/asm-powerpc/smu.h                         |    2 
 include/asm-powerpc/spu.h                         |    2 
 include/asm-powerpc/system.h                      |    5 
 include/asm-powerpc/vio.h                         |    4 
 include/asm-ppc/io.h                              |   26 -
 include/asm-ppc/mpc8260_pci9.h                    |    4 
 include/asm-ppc/reg_booke.h                       |   16 -
 scripts/checkstack.pl                             |    2 
 sound/aoa/core/snd-aoa-gpio-feature.c             |    2 
 sound/oss/dmasound/dmasound_awacs.c               |   11 
 sound/ppc/tumbler.c                               |   15 -
 220 files changed, 4503 insertions(+), 2611 deletions(-)
 create mode 100644 arch/powerpc/boot/flatdevtree.h
 create mode 100644 arch/powerpc/boot/of.c
 create mode 100644 arch/powerpc/boot/ops.h
 delete mode 100644 arch/powerpc/boot/prom.c
 delete mode 100644 arch/powerpc/boot/prom.h
 create mode 100644 arch/powerpc/boot/types.h
 rename arch/powerpc/kernel/{cpu_setup_power4.S => cpu_setup_ppc970.S} (74%)
 create mode 100644 arch/powerpc/kernel/io.c
 delete mode 100644 arch/powerpc/lib/e2a.c
 rename include/asm-powerpc/iseries/it_exp_vpd_panel.h => arch/powerpc/platforms/iseries/it_exp_vpd_panel.h (90%)
 rename include/asm-powerpc/iseries/it_lp_naca.h => arch/powerpc/platforms/iseries/it_lp_naca.h (96%)
 create mode 100644 arch/powerpc/platforms/pasemi/Makefile
 create mode 100644 arch/powerpc/platforms/pasemi/pasemi.h
 create mode 100644 arch/powerpc/platforms/pasemi/pci.c
 create mode 100644 arch/powerpc/platforms/pasemi/setup.c
 create mode 100644 arch/powerpc/platforms/pasemi/time.c
 create mode 100644 arch/powerpc/platforms/pseries/hvCall_inst.c
 create mode 100644 drivers/char/briq_panel.c
 create mode 100644 drivers/char/hvc_iseries.c
 delete mode 100644 include/asm-powerpc/iseries/iseries_io.h

Amos Waterland:
      [POWERPC] Turn on tigon3 support in maple_defconfig

Amy Fong:
      [POWERPC] Fix compile error in sbc8560

Andrew Morton:
      [POWERPC] briq_panel Kconfig fix

Anton Blanchard:
      [POWERPC] clean up pseries hcall interfaces

Arnd Bergmann:
      [POWERPC] powerpc: fix building gdb against asm/ptrace.h

Benjamin Herrenschmidt:
      [POWERPC] Workaround Pegasos incorrect ISA "ranges"
      [POWERPC] Fix 32 bits warning in prom_init.c
      [POWERPC] Fix non-MPIC CHRPs with CONFIG_SMP set
      [POWERPC] Fix default clock for udbg_16550
      [POWERPC] Fix legacy_serial.c error handling on 32 bits
      [POWERPC] Add briq support to CHRP
      [POWERPC] Add support for briq front panel
      [POWERPC] More offb/bootx fixes
      [POWERPC] Xserve G5 thermal control fixes
      [POWERPC] Add cpufreq support for Xserve G5
      [POWERPC] Fix ohare IDE irq workaround on old powermacs

Corey Minyard:
      [POWERPC] Make function of pm_power_off consistent with x86

David Howells:
      [POWERPC] Export copy_4K_page()

Geoff Levand:
      [POWERPC] cell: interrupt.c whitespace clean up

Jake Moilanen:
      [POWERPC] Export msi symbols

Jeremy Kerr:
      [POWERPC] Remove linux,device properties
      [POWERPC] Use const qualifiers for prom parsing utilites
      [POWERPC] Remove linux,pci-domain properties
      [POWERPC] Constify & voidify get_property()
      [POWERPC] pseries: Constify & voidify get_property()
      [POWERPC] iseries: Constify & voidify get_property()
      [POWERPC] mpc: Constify & voidify get_property()
      [POWERPC] cell: Constify & voidify get_property()
      [POWERPC] chrp: Constify & voidify get_property()
      [POWERPC] maple: Constify & voidify get_property()
      [POWERPC] powermac: Constify & voidify get_property()
      [POWERPC] video & agp: Constify & voidify get_property()
      [POWERPC] scsi: Constify & voidify get_property()
      [POWERPC] netdevices: Constify & voidify get_property()
      [POWERPC] sound: Constify & voidify get_property()
      [POWERPC] tmp_atmel: Constify & voidify get_property()
      [POWERPC] sata_svw: Constify & voidify get_property()
      [POWERPC] tsi108: Constify & voidify get_property()
      [POWERPC] Make get_property() return a const void *
      [POWERPC] Simplify dma_ops bug conditions

Johannes Berg:
      [POWERPC] fix up front-LED Kconfig
      [POWERPC] make checkstack work with ARCH=powerpc

Jon Loeliger:
      [POWERPC] Rewrite the PPC 86xx IRQ handling to use Flat Device Tree
      [POWERPC] Add MPC8641 HPCN Device Tree Source file.
      [POWERPC] Allow MPC8641 HPCN to build with CONFIG_PCI disabled too.

Josh Boyer:
      [POWERPC] PPC 4xx: Enable XMON on PPC 4xx boards
      [POWERPC] PPC: Fix Kconfig whitespace warnings
      [POWERPC] PPC: Fix xmon stack frame address in backtrace
      [POWERPC] 40x: Fix debug status register defines

Kim Phillips:
      [POWERPC] Fix MPC8349EMDS dts PCI interrupt-map values for IDSEL 0x18

Linas Vepstas:
      [POWERPC] EEH: balance pcidev_get/put calls
      [POWERPC] EEH: code comment cleanup
      [POWERPC] EEH: enable MMIO/DMA on frozen slot
      [POWERPC] EEH: support MMIO enable recovery step
      [POWERPC] EEH: Power4 systems sometimes need multiple resets.

Mark A. Greer:
      [POWERPC] Start arch/powerpc/boot code reorganization

Matt Porter:
      [POWERPC] Remove flush_dcache_all export
      [POWERPC] Fix powerpc 44x_mmu build

Michael Ellerman:
      [POWERPC] Fix mem= handling when the memory limit is > RMO size
      [POWERPC] iseries: Use device tree /system-id in /proc/iSeries/config
      [POWERPC] iseries: Move e2a()/strne2a() into their only caller
      [POWERPC] iseries: Cleanup e2a() and strne2a()
      [POWERPC] iseries: Make ItExtVpdPanel private to iSeries
      [POWERPC] iseries: Make HvLpConfig_get(Primary)LpIndex functions
      [POWERPC] iseries: Move ItLpNaca into platforms/iseries
      [POWERPC] iseries: Fix a compiler warning in platforms/iseries/vpdinfo.c
      [POWERPC] iseries: Fix a compiler warning in platforms/iseries/vpdinfo.c
      [POWERPC] Fix a compiler warning in mm/tlb_64.c
      [POWERPC] iseries: Move iommu_table_cb into platforms/iseries
      [POWERPC] Make doc comments extractable
      [POWERPC] Add a helper for calculating RTAS "config_addr" parameters
      [POWERPC] Split out vpa unregister logic from pseries_kexec_cpu_down_xics()
      [POWERPC] Remove DISCONTIGMEM cruft from page.h

Michael Neuling:
      [POWERPC] Enable PURR sysfs entry correctly
      [POWERPC] Implement SLB shadow buffer
      [POWERPC] Update lppaca offset comments
      [POWERPC] SLB shadow buffer cleanup
      [POWERPC] powerpc: Make RTAS console init generic

Mike Kravetz:
      [POWERPC] Instrument Hypervisor Calls: merge headers
      [POWERPC] powerpc: Instrument Hypervisor Calls

Nathan Lynch:
      [POWERPC] Maple U3 HT - reject inappropriate config space access
      [POWERPC] Demacrofy arch/powerpc/platforms/maple/pci.c

Niels Kristian Bech Jensen:
      [POWERPC] Add -fno-stack-protector to BOOTCFLAGS in arch/powerpc/boot/Makefile.

Olaf Hering:
      [POWERPC] reboot when panic_timout is set
      [POWERPC] print backtrace when entering xmon

Olof Johansson:
      [POWERPC] Rename cpu_setup_power4.S to cpu_setup_ppc970.S
      [POWERPC] Cleanup CPU inits
      [POWERPC] powerpc: Reduce default cacheline size to 64 bytes
      [POWERPC] powerpc: Divorce CPU_FTR_CTRL from CPU_FTR_PPCAS_ARCH_V2_BASE
      [POWERPC] powerpc: PA6T cputable entry, PVR value
      [POWERPC] powerpc: PA Semi PWRficient platform support
      [POWERPC] powerpc: PA Semi PWRficient MAINTAINER entry
      [POWERPC] Quiet hvc_console console output on failed opens
      [POWERPC] Fix non-smp build

Paul Mackerras:
      [POWERPC] Only offer CONFIG_BRIQ_PANEL if CONFIG_PPC_CHRP is enabled
      [POWERPC] Define of_read_ulong helper

Peter Bergner:
      [POWERPC] Add AT_PLATFORM value for Xilinx Virtex-4 FX

Scott Wood:
      [POWERPC] Fix IPIC pending register assignments
      [POWERPC] Include <asm/mmu.h> in arch/powerpc/sysdev/fsl_soc.h for phys_addr_t.

Stephen Rothwell:
      [POWERPC] iseries: A new iSeries console
      [POWERPC] Make the hvc_console output buffer size settable
      [POWERPC] iseries: Small viotape cleanup allowed by devfs removal
      [POWERPC] iseries: Remove unnecessary include of iseries/hv_lp_event.h
      [POWERPC] iseries: remove const warning
      [POWERPC] iseries: remove some gcc 4.1 warnings
      [POWERPC] make spinlocks work in a combined kernel
      [POWERPC] silence a warning
      [POWERPC] remove unused io accessors
      [POWERPC] remove unused asm routines
      [POWERPC] clean up ide io accessors
      [POWERPC] convert string i/o operations to C
      [POWERPC] iseries: eliminate a couple of warnings
      [POWERPC] Merge iSeries i/o operations with the rest

Will Schmidt:
      [POWERPC] Emulate power5 popcntb instruction
