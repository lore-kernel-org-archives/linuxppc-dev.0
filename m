Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17984.1951.790850.131603@cargo.ozlabs.ibm.com>
Date: Tue, 8 May 2007 15:16:15 +1000
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
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git master

to get another powerpc update for 2.6.22.  The diffstat looks rather
large because this includes a couple of patches from Stephen Rothwell
that rename device_is_compatible to of_device_is_compatible and
get_property to of_get_property, and these renames hit a lot of device
drivers.

There are some patches from Ben that are still pending, including the
page table rework.  I'll send you a pull request for those tomorrow.

Thanks,
Paul.

 Documentation/powerpc/booting-without-of.txt      |    4 
 arch/powerpc/Kconfig                              |   19 
 arch/powerpc/Kconfig.debug                        |   22 
 arch/powerpc/Makefile                             |    2 
 arch/powerpc/boot/44x.c                           |   40 +
 arch/powerpc/boot/44x.h                           |   16 
 arch/powerpc/boot/Makefile                        |   49 +
 arch/powerpc/boot/cuboot-ebony.c                  |   42 +
 arch/powerpc/boot/dcr.h                           |   87 ++
 arch/powerpc/boot/dts/ebony.dts                   |  307 ++++++
 arch/powerpc/boot/dts/holly.dts                   |  198 ++++
 arch/powerpc/boot/dts/lite5200.dts                |   11 
 arch/powerpc/boot/dts/lite5200b.dts               |   11 
 arch/powerpc/boot/dts/mpc832x_mds.dts             |    2 
 arch/powerpc/boot/dts/mpc832x_rdb.dts             |    2 
 arch/powerpc/boot/dts/mpc836x_mds.dts             |    4 
 arch/powerpc/boot/dts/mpc8568mds.dts              |    6 
 arch/powerpc/boot/ebony.c                         |  129 +++
 arch/powerpc/boot/holly.c                         |   38 +
 arch/powerpc/boot/mktree.c                        |   10 
 arch/powerpc/boot/treeboot-ebony.c                |   34 +
 arch/powerpc/boot/wrapper                         |   36 -
 arch/powerpc/configs/ebony_defconfig              |  905 ++++++++++++++++++
 arch/powerpc/configs/holly_defconfig              | 1070 +++++++++++++++++++++
 arch/powerpc/configs/mpc832x_mds_defconfig        |   67 +
 arch/powerpc/configs/mpc832x_rdb_defconfig        |   28 -
 arch/powerpc/configs/mpc836x_mds_defconfig        |   42 +
 arch/powerpc/configs/ps3_defconfig                |  329 +++++-
 arch/powerpc/kernel/Makefile                      |    4 
 arch/powerpc/kernel/asm-offsets.c                 |    4 
 arch/powerpc/kernel/head_44x.S                    |   48 -
 arch/powerpc/kernel/idle.c                        |    5 
 arch/powerpc/kernel/idle_power4.S                 |   21 
 arch/powerpc/kernel/irq.c                         |   38 -
 arch/powerpc/kernel/kprobes.c                     |   10 
 arch/powerpc/kernel/legacy_serial.c               |   14 
 arch/powerpc/kernel/msi.c                         |   38 +
 arch/powerpc/kernel/of_device.c                   |    7 
 arch/powerpc/kernel/of_platform.c                 |    1 
 arch/powerpc/kernel/pci_32.c                      |    2 
 arch/powerpc/kernel/pci_64.c                      |    9 
 arch/powerpc/kernel/ppc_ksyms.c                   |    1 
 arch/powerpc/kernel/prom_init.c                   |   12 
 arch/powerpc/kernel/prom_parse.c                  |   25 
 arch/powerpc/kernel/smp.c                         |   73 +
 arch/powerpc/kernel/swsusp.c                      |   43 +
 arch/powerpc/kernel/swsusp_64.c                   |   24 
 arch/powerpc/kernel/swsusp_asm64.S                |  228 ++++
 arch/powerpc/kernel/sysfs.c                       |    2 
 arch/powerpc/kernel/udbg.c                        |    3 
 arch/powerpc/kernel/udbg_16550.c                  |   23 
 arch/powerpc/kernel/vio.c                         |    2 
 arch/powerpc/lib/dma-noncoherent.c                |    4 
 arch/powerpc/mm/44x_mmu.c                         |   82 --
 arch/powerpc/mm/fault.c                           |   42 -
 arch/powerpc/mm/hash_native_64.c                  |   84 +-
 arch/powerpc/mm/hash_utils_64.c                   |    2 
 arch/powerpc/mm/mem.c                             |    1 
 arch/powerpc/mm/mmu_decl.h                        |    3 
 arch/powerpc/mm/pgtable_32.c                      |   28 -
 arch/powerpc/mm/stab.c                            |    2 
 arch/powerpc/platforms/44x/44x.h                  |    8 
 arch/powerpc/platforms/44x/Kconfig                |   56 +
 arch/powerpc/platforms/44x/Makefile               |    2 
 arch/powerpc/platforms/44x/ebony.c                |   73 +
 arch/powerpc/platforms/44x/misc_44x.S             |   57 +
 arch/powerpc/platforms/52xx/Kconfig               |    1 
 arch/powerpc/platforms/52xx/Makefile              |    2 
 arch/powerpc/platforms/52xx/efika.c               |   15 
 arch/powerpc/platforms/52xx/lite5200.c            |   28 +
 arch/powerpc/platforms/52xx/mpc52xx_pm.c          |  191 ++++
 arch/powerpc/platforms/52xx/mpc52xx_sleep.S       |  154 +++
 arch/powerpc/platforms/83xx/mpc832x_mds.c         |    1 
 arch/powerpc/platforms/83xx/mpc832x_rdb.c         |    1 
 arch/powerpc/platforms/83xx/mpc836x_mds.c         |    1 
 arch/powerpc/platforms/85xx/mpc8544_ds.c          |    2 
 arch/powerpc/platforms/85xx/mpc85xx_cds.c         |    2 
 arch/powerpc/platforms/85xx/mpc85xx_mds.c         |    1 
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c        |    2 
 arch/powerpc/platforms/Kconfig                    |    1 
 arch/powerpc/platforms/Makefile                   |    3 
 arch/powerpc/platforms/cell/interrupt.c           |    6 
 arch/powerpc/platforms/cell/setup.c               |    2 
 arch/powerpc/platforms/cell/spider-pic.c          |    4 
 arch/powerpc/platforms/chrp/pci.c                 |    2 
 arch/powerpc/platforms/chrp/setup.c               |    2 
 arch/powerpc/platforms/embedded6xx/Kconfig        |   14 
 arch/powerpc/platforms/embedded6xx/Makefile       |    1 
 arch/powerpc/platforms/embedded6xx/holly.c        |  317 ++++++
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |   21 
 arch/powerpc/platforms/maple/pci.c                |   12 
 arch/powerpc/platforms/maple/setup.c              |    2 
 arch/powerpc/platforms/pasemi/cpufreq.c           |    4 
 arch/powerpc/platforms/pasemi/setup.c             |    7 
 arch/powerpc/platforms/powermac/cpufreq_64.c      |    8 
 arch/powerpc/platforms/powermac/feature.c         |   26 -
 arch/powerpc/platforms/powermac/low_i2c.c         |    2 
 arch/powerpc/platforms/powermac/nvram.c           |    4 
 arch/powerpc/platforms/powermac/pci.c             |   30 -
 arch/powerpc/platforms/powermac/pic.c             |    2 
 arch/powerpc/platforms/powermac/setup.c           |  121 +-
 arch/powerpc/platforms/powermac/smp.c             |   18 
 arch/powerpc/platforms/ps3/htab.c                 |    3 
 arch/powerpc/platforms/ps3/interrupt.c            |  234 +++--
 arch/powerpc/platforms/ps3/mm.c                   |    1 
 arch/powerpc/platforms/ps3/setup.c                |    7 
 arch/powerpc/platforms/ps3/smp.c                  |    6 
 arch/powerpc/platforms/ps3/spu.c                  |   18 
 arch/powerpc/platforms/pseries/Makefile           |    1 
 arch/powerpc/platforms/pseries/eeh.c              |   30 +
 arch/powerpc/platforms/pseries/iommu.c            |    6 
 arch/powerpc/platforms/pseries/lpar.c             |    4 
 arch/powerpc/platforms/pseries/msi.c              |  270 +++++
 arch/powerpc/platforms/pseries/pci_dlpar.c        |    1 
 arch/powerpc/platforms/pseries/setup.c            |    2 
 arch/powerpc/platforms/pseries/xics.c             |    4 
 arch/powerpc/sysdev/Makefile                      |    5 
 arch/powerpc/sysdev/dart_iommu.c                  |   46 +
 arch/powerpc/sysdev/mpic.c                        |  162 +++
 arch/powerpc/sysdev/mpic.h                        |   38 +
 arch/powerpc/sysdev/mpic_msi.c                    |  183 ++++
 arch/powerpc/sysdev/mpic_u3msi.c                  |  186 ++++
 arch/powerpc/sysdev/rom.c                         |   32 -
 arch/powerpc/sysdev/tsi108_dev.c                  |    7 
 arch/powerpc/sysdev/tsi108_pci.c                  |   12 
 arch/powerpc/sysdev/uic.c                         |    2 
 arch/ppc/syslib/ppc4xx_sgdma.c                    |    2 
 drivers/ata/sata_svw.c                            |    2 
 drivers/char/agp/uninorth-agp.c                   |    2 
 drivers/char/briq_panel.c                         |    2 
 drivers/char/hvc_iseries.c                        |    2 
 drivers/char/hvc_vio.c                            |    2 
 drivers/char/tpm/tpm_atmel.h                      |    4 
 drivers/hwmon/ams/ams-core.c                      |    6 
 drivers/hwmon/ams/ams-i2c.c                       |    2 
 drivers/hwmon/ams/ams-pmu.c                       |    2 
 drivers/ide/pci/pdc202xx_new.c                    |    2 
 drivers/ide/ppc/pmac.c                            |   18 
 drivers/infiniband/hw/ehca/ehca_main.c            |    2 
 drivers/macintosh/Kconfig                         |   12 
 drivers/macintosh/apm_emu.c                       |  521 +---------
 drivers/macintosh/mac_hid.c                       |    8 
 drivers/macintosh/macio_sysfs.c                   |   27 -
 drivers/macintosh/smu.c                           |    2 
 drivers/macintosh/therm_adt746x.c                 |    4 
 drivers/macintosh/via-pmu-led.c                   |   35 -
 drivers/macintosh/via-pmu.c                       |   12 
 drivers/macintosh/windfarm_lm75_sensor.c          |    4 
 drivers/macintosh/windfarm_max6690_sensor.c       |    2 
 drivers/macintosh/windfarm_smu_controls.c         |    2 
 drivers/macintosh/windfarm_smu_sat.c              |    2 
 drivers/mtd/maps/physmap_of.c                     |    8 
 drivers/net/bmac.c                                |    5 
 drivers/net/ehea/ehea_main.c                      |   13 
 drivers/net/mace.c                                |    4 
 drivers/net/pasemi_mac.c                          |    2 
 drivers/net/spider_net.c                          |    4 
 drivers/net/sungem.c                              |    2 
 drivers/net/sungem_phy.c                          |    2 
 drivers/net/tsi108_eth.c                          |   12 
 drivers/net/tsi108_eth.h                          |    9 
 drivers/net/ucc_geth.c                            |   18 
 drivers/net/ucc_geth_mii.c                        |    4 
 drivers/pci/hotplug/rpaphp_core.c                 |   10 
 drivers/ps3/vuart.c                               |    8 
 drivers/scsi/ibmvscsi/ibmvstgt.c                  |    8 
 drivers/scsi/ibmvscsi/rpa_vscsi.c                 |    4 
 drivers/scsi/mac53c94.c                           |    2 
 drivers/scsi/mesh.c                               |    2 
 drivers/serial/mpc52xx_uart.c                     |    7 
 drivers/serial/of_serial.c                        |    4 
 drivers/serial/pmac_zilog.c                       |    8 
 drivers/usb/host/ehci-ps3.c                       |    4 
 drivers/usb/host/ohci-ppc-of.c                    |    4 
 drivers/usb/host/ohci-ps3.c                       |    4 
 drivers/video/aty/radeon_base.c                   |    6 
 drivers/video/aty/radeon_monitor.c                |   11 
 drivers/video/aty/radeon_pm.c                     |    2 
 drivers/video/nvidia/nv_of.c                      |    8 
 drivers/video/offb.c                              |   32 -
 drivers/video/ps3fb.c                             |   12 
 drivers/video/riva/fbdev.c                        |    4 
 include/asm-powerpc/iommu.h                       |   14 
 include/asm-powerpc/kdebug.h                      |   17 
 include/asm-powerpc/kprobes.h                     |    7 
 include/asm-powerpc/machdep.h                     |   19 
 include/asm-powerpc/mmu-44x.h                     |   78 ++
 include/asm-powerpc/mmu.h                         |    7 
 include/asm-powerpc/mpc52xx.h                     |   11 
 include/asm-powerpc/mpic.h                        |   20 
 include/asm-powerpc/of_device.h                   |    2 
 include/asm-powerpc/page.h                        |   10 
 include/asm-powerpc/page_32.h                     |    2 
 include/asm-powerpc/pgalloc-32.h                  |   41 +
 include/asm-powerpc/pgalloc-64.h                  |  152 +++
 include/asm-powerpc/pgalloc.h                     |  154 ---
 include/asm-powerpc/pgtable-4k.h                  |    3 
 include/asm-powerpc/pgtable-64k.h                 |    5 
 include/asm-powerpc/pgtable-ppc32.h               |  813 ++++++++++++++++
 include/asm-powerpc/pgtable-ppc64.h               |  492 ++++++++++
 include/asm-powerpc/pgtable.h                     |  493 ----------
 include/asm-powerpc/pmac_feature.h                |    2 
 include/asm-powerpc/prom.h                        |   34 -
 include/asm-powerpc/ps3.h                         |   33 -
 include/asm-powerpc/suspend.h                     |    9 
 include/asm-powerpc/tsi108.h                      |   12 
 include/asm-powerpc/tsi108_pci.h                  |   45 +
 include/asm-powerpc/udbg.h                        |    1 
 include/linux/pmu.h                               |    8 
 include/linux/suspend.h                           |    2 
 kernel/power/Kconfig                              |    4 
 sound/aoa/codecs/snd-aoa-codec-onyx.c             |    4 
 sound/aoa/codecs/snd-aoa-codec-tas.c              |    2 
 sound/aoa/soundbus/i2sbus/i2sbus-core.c           |    4 
 sound/oss/dmasound/dmasound_awacs.c               |   16 
 sound/ppc/pmac.c                                  |   14 
 sound/ppc/tumbler.c                               |    2 
 217 files changed, 8176 insertions(+), 2119 deletions(-)
 create mode 100644 arch/powerpc/boot/44x.c
 create mode 100644 arch/powerpc/boot/44x.h
 create mode 100644 arch/powerpc/boot/cuboot-ebony.c
 create mode 100644 arch/powerpc/boot/dcr.h
 create mode 100644 arch/powerpc/boot/dts/ebony.dts
 create mode 100644 arch/powerpc/boot/dts/holly.dts
 create mode 100644 arch/powerpc/boot/ebony.c
 create mode 100644 arch/powerpc/boot/holly.c
 create mode 100644 arch/powerpc/boot/treeboot-ebony.c
 create mode 100644 arch/powerpc/configs/ebony_defconfig
 create mode 100644 arch/powerpc/configs/holly_defconfig
 create mode 100644 arch/powerpc/kernel/msi.c
 create mode 100644 arch/powerpc/kernel/swsusp.c
 create mode 100644 arch/powerpc/kernel/swsusp_64.c
 create mode 100644 arch/powerpc/kernel/swsusp_asm64.S
 create mode 100644 arch/powerpc/platforms/44x/44x.h
 create mode 100644 arch/powerpc/platforms/44x/Kconfig
 create mode 100644 arch/powerpc/platforms/44x/Makefile
 create mode 100644 arch/powerpc/platforms/44x/ebony.c
 create mode 100644 arch/powerpc/platforms/44x/misc_44x.S
 create mode 100644 arch/powerpc/platforms/52xx/mpc52xx_pm.c
 create mode 100644 arch/powerpc/platforms/52xx/mpc52xx_sleep.S
 create mode 100644 arch/powerpc/platforms/embedded6xx/holly.c
 create mode 100644 arch/powerpc/platforms/pseries/msi.c
 create mode 100644 arch/powerpc/sysdev/mpic.h
 create mode 100644 arch/powerpc/sysdev/mpic_msi.c
 create mode 100644 arch/powerpc/sysdev/mpic_u3msi.c
 delete mode 100644 arch/powerpc/sysdev/rom.c
 create mode 100644 include/asm-powerpc/mmu-44x.h
 create mode 100644 include/asm-powerpc/pgalloc-32.h
 create mode 100644 include/asm-powerpc/pgalloc-64.h
 create mode 100644 include/asm-powerpc/pgtable-ppc32.h
 create mode 100644 include/asm-powerpc/pgtable-ppc64.h
 create mode 100644 include/asm-powerpc/suspend.h
 create mode 100644 include/asm-powerpc/tsi108_pci.h

Adrian Bunk (1):
      [POWERPC] drivers/macintosh/mac_hid.c: Make code static

Benjamin Herrenschmidt (1):
      [POWERPC] pmac_feature_call checks platform

Brian King (1):
      [POWERPC] Add powerpc PCI-E reset API implementation

Christian Krafft (1):
      [POWERPC] Uninline of_iomap function

Christoph Hellwig (1):
      [POWERPC] Minor fault path optimization

David Gibson (13):
      [POWERPC] Revise PPC44x MMU code for arch/powerpc
      [POWERPC] Fix STRICT_MM_TYPECHECKS
      [POWERPC] Remove arch/powerpc's dependence on asm-ppc/pg{alloc,table}.h
      [POWERPC] Small cleanups to the cuboot bootwrapper code
      [POWERPC] Kill off the PTE_FMT macro
      [POWERPC] Fix some missing build dependencies in arch/powerpc/boot
      [POWERPC] Fix build problem in ppc4xx_sgdma.c
      [POWERPC] Remove use of 4level-fixup.h for ppc32
      [POWERPC] Add powerpc/platforms/44x, disable platforms/4xx for now
      [POWERPC] Add device tree for Ebony
      [POWERPC] Support for the Ebony 440GP reference board in arch/powerpc
      [POWERPC] Early serial debug support for PPC44x
      [POWERPC] Abolish powerpc_flash_init()

Domen Puncer (4):
      [POWERPC] lite5200(b) DTS fixes
      [POWERPC] lite5200(b) support for i2c
      [POWERPC] Set efika's device_type to "soc"
      [POWERPC] mpc52xx suspend to deep-sleep

Geoff Levand (4):
      [POWERPC] PS3: Add DABR support
      [POWERPC] PS3: Remove duplicate variable assignement
      [POWERPC] PS3: Interrupt routine fixups.
      [POWERPC] PS3: Defconfig updates

Grant Likely (1):
      [POWERPC] Don't shutdown TX on mpc5200 serial port if it is a console

Jan Engelhardt (1):
      [POWERPC] Use menuconfig objects II - Macintosh

Johannes Berg (9):
      [POWERPC] Remove unneeded page_is_ram export
      [POWERPC] apm_emu: Use generic apm-emulation
      [POWERPC] powermac: Fix G5-cpufreq for cpu on/offline
      [POWERPC] Fix suspend states again
      [POWERPC] MPIC sys_device & suspend/resume
      [POWERPC] powermac: Support G5 CPU hotplug
      [POWERPC] DART iommu suspend
      [POWERPC] powermac: Suspend to disk on G5
      [POWERPC] via-pmu: remove LED sleep notifier

Josh Boyer (8):
      [POWERPC] Fix spurious vectors on weird MPIC
      [POWERPC] Add tsi108_pci.h for common PCI functions
      [POWERPC] Generalize tsi108 PHY types
      [POWERPC] Generalize tsi108 PCI setup
      [POWERPC] Add support for 750CL Holly board
      [POWERPC] Holly defconfig
      [POWERPC] Holly DTS
      [POWERPC] Holly bootwrapper

Kevin Corry (1):
      [POWERPC] Change topology_init() to a subsys_initcall

Kim Phillips (4):
      [POWERPC] Document phy-connection-type property
      [POWERPC] Replace undocumented interface properties in dts files
      [POWERPC] Add 'mdio' to bus scan id list for platforms with QE UEC
      [POWERPC] Turn on corresponding PHY drivers in QE UEC platforms defconfigs

Linas Vepstas (2):
      [POWERPC] pseries: Handle null iommu dma-window property correctly
      [POWERPC] Export pcibios_remove_pci_devices

Luke Browning (1):
      [POWERPC] 64K page support for kexec

Mathieu Desnoyers (1):
      [POWERPC] Move of_irq_to_resource from prom.h to prom_parse.c

Michael Ellerman (9):
      [POWERPC] Initialise spinlock in the DEBUG_PAGEALLOC code
      [POWERPC] Add __init annotations to reserve_mem() and stabs_alloc()
      [POWERPC] Rip out the existing powerpc msi stubs
      [POWERPC] PowerPC MSI infrastructure
      [POWERPC] RTAS MSI implementation
      [POWERPC] Tell Phyp we support MSI
      [POWERPC] Enable MSI mappings for MPIC
      [POWERPC] MPIC MSI allocator
      [POWERPC] MPIC U3/U4 MSI backend

Olof Johansson (2):
      [POWERPC] pasemi: Only call of_platform_bus_probe() on relevant platforms
      [POWERPC] pasemi: Update ppc_proc_freq from cpufreq driver

Paul Mackerras (1):
      [POWERPC] Cope with PCI host bridge I/O window not starting at 0

Scott Wood (2):
      [POWERPC] Remove duplicate export of __div64_32.
      [POWERPC] bootwrapper: Only build cuImage if CONFIG_DEVICE_TREE is non-empty

Srinivasa Ds (1):
      [POWERPC] Transparently handle <.symbol> lookup for kprobes

Stephen Rothwell (3):
      [POWERPC] get_property returns const
      [POWERPC] Rename get_property to of_get_property: drivers
      [POWERPC] Rename device_is_compatible to of_device_is_compatible

Sylvain Munaut (2):
      [POWERPC] Export of_device_get_modalias
      [POWERPC] macintosh: Use common modalias generation for macio_sysfs

Takao Shinohara (1):
      [POWERPC] PS3: Fix system slowdown

Zang Roy-r61911 (1):
      [POWERPC] kernel: Remove loops_per_jiffy code for 7448HPC2 platforms

will schmidt (1):
      [POWERPC] Add smp_call_function_map and smp_call_function_single
