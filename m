Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17973.24674.73695.298023@cargo.ozlabs.ibm.com>
Date: Mon, 30 Apr 2007 13:20:02 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Please pull powerpc.git for-2.6.22 branch
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
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git for-2.6.22

to get a powerpc update for 2.6.22.

Thanks,
Paul.

 Documentation/powerpc/booting-without-of.txt      |  256 +-
 arch/powerpc/Kconfig                              |  472 ---
 arch/powerpc/Kconfig.debug                        |   12 
 arch/powerpc/Makefile                             |   11 
 arch/powerpc/boot/.gitignore                      |    3 
 arch/powerpc/boot/Makefile                        |  122 -
 arch/powerpc/boot/crt0.S                          |   37 
 arch/powerpc/boot/cuboot-83xx.c                   |   68 +
 arch/powerpc/boot/cuboot-85xx.c                   |   69 +
 arch/powerpc/boot/devtree.c                       |  307 ++
 arch/powerpc/boot/dts/kuroboxHD.dts               |    7 
 arch/powerpc/boot/dts/kuroboxHG.dts               |    7 
 arch/powerpc/boot/dts/lite5200.dts                |    1 
 arch/powerpc/boot/dts/lite5200b.dts               |    1 
 arch/powerpc/boot/dts/mpc7448hpc2.dts             |    1 
 arch/powerpc/boot/dts/mpc8272ads.dts              |    1 
 arch/powerpc/boot/dts/mpc8313erdb.dts             |    1 
 arch/powerpc/boot/dts/mpc832x_mds.dts             |    1 
 arch/powerpc/boot/dts/mpc832x_rdb.dts             |  291 ++
 arch/powerpc/boot/dts/mpc8349emitx.dts            |    1 
 arch/powerpc/boot/dts/mpc8349emitxgp.dts          |    1 
 arch/powerpc/boot/dts/mpc834x_mds.dts             |    1 
 arch/powerpc/boot/dts/mpc836x_mds.dts             |    1 
 arch/powerpc/boot/dts/mpc8540ads.dts              |    1 
 arch/powerpc/boot/dts/mpc8541cds.dts              |    1 
 arch/powerpc/boot/dts/mpc8544ds.dts               |  136 +
 arch/powerpc/boot/dts/mpc8548cds.dts              |    1 
 arch/powerpc/boot/dts/mpc8555cds.dts              |    1 
 arch/powerpc/boot/dts/mpc8560ads.dts              |    1 
 arch/powerpc/boot/dts/mpc8568mds.dts              |    1 
 arch/powerpc/boot/dts/mpc8641_hpcn.dts            |   25 
 arch/powerpc/boot/dts/mpc866ads.dts               |    1 
 arch/powerpc/boot/dts/mpc885ads.dts               |    1 
 arch/powerpc/boot/elf.h                           |    8 
 arch/powerpc/boot/elf_util.c                      |   76 +
 arch/powerpc/boot/flatdevtree.c                   |  199 +
 arch/powerpc/boot/flatdevtree.h                   |    7 
 arch/powerpc/boot/flatdevtree_misc.c              |   42 
 arch/powerpc/boot/gunzip_util.c                   |  206 ++
 arch/powerpc/boot/gunzip_util.h                   |   45 
 arch/powerpc/boot/main.c                          |  369 +--
 arch/powerpc/boot/ns16550.c                       |    9 
 arch/powerpc/boot/of.c                            |   21 
 arch/powerpc/boot/ops.h                           |  103 +
 arch/powerpc/boot/ppcboot.h                       |  108 +
 arch/powerpc/boot/reg.h                           |   22 
 arch/powerpc/boot/simple_alloc.c                  |   31 
 arch/powerpc/boot/stdio.h                         |    5 
 arch/powerpc/boot/wrapper                         |   53 
 arch/powerpc/boot/zImage.coff.lds.S               |    3 
 arch/powerpc/boot/zImage.lds.S                    |    1 
 arch/powerpc/configs/cell_defconfig               |   57 
 arch/powerpc/configs/g5_defconfig                 |    2 
 arch/powerpc/configs/maple_defconfig              |    2 
 arch/powerpc/configs/mpc832x_rdb_defconfig        | 1292 ++++++++++
 arch/powerpc/configs/mpc8544_ds_defconfig         | 1077 ++++++++
 arch/powerpc/configs/ppc64_defconfig              |    2 
 arch/powerpc/kernel/Makefile                      |    4 
 arch/powerpc/kernel/align.c                       |   56 
 arch/powerpc/kernel/asm-offsets.c                 |    2 
 arch/powerpc/kernel/btext.c                       |   22 
 arch/powerpc/kernel/cpu_setup_pa6t.S              |    2 
 arch/powerpc/kernel/cputable.c                    |   14 
 arch/powerpc/kernel/entry_32.S                    |    1 
 arch/powerpc/kernel/head_64.S                     |   16 
 arch/powerpc/kernel/ibmebus.c                     |  288 +-
 arch/powerpc/kernel/iommu.c                       |   35 
 arch/powerpc/kernel/irq.c                         |    2 
 arch/powerpc/kernel/kprobes.c                     |   36 
 arch/powerpc/kernel/legacy_serial.c               |   24 
 arch/powerpc/kernel/lparcfg.c                     |   58 
 arch/powerpc/kernel/machine_kexec_64.c            |   14 
 arch/powerpc/kernel/misc_32.S                     |    4 
 arch/powerpc/kernel/of_device.c                   |  112 +
 arch/powerpc/kernel/of_platform.c                 |    5 
 arch/powerpc/kernel/pci_32.c                      |   42 
 arch/powerpc/kernel/pci_64.c                      |   32 
 arch/powerpc/kernel/pci_dn.c                      |    9 
 arch/powerpc/kernel/ppc_ksyms.c                   |    1 
 arch/powerpc/kernel/process.c                     |   54 
 arch/powerpc/kernel/prom.c                        |  167 -
 arch/powerpc/kernel/prom_init.c                   |   55 
 arch/powerpc/kernel/prom_parse.c                  |   51 
 arch/powerpc/kernel/rtas-proc.c                   |    4 
 arch/powerpc/kernel/rtas.c                        |   19 
 arch/powerpc/kernel/rtas_pci.c                    |   14 
 arch/powerpc/kernel/setup-common.c                |   68 -
 arch/powerpc/kernel/setup_32.c                    |   17 
 arch/powerpc/kernel/setup_64.c                    |   11 
 arch/powerpc/kernel/smp.c                         |    4 
 arch/powerpc/kernel/sys_ppc32.c                   |    4 
 arch/powerpc/kernel/sysfs.c                       |   17 
 arch/powerpc/kernel/time.c                        |    2 
 arch/powerpc/kernel/traps.c                       |   76 -
 arch/powerpc/kernel/vio.c                         |   17 
 arch/powerpc/lib/copyuser_64.S                    |    6 
 arch/powerpc/lib/locks.c                          |    4 
 arch/powerpc/lib/mem_64.S                         |    6 
 arch/powerpc/lib/memcpy_64.S                      |    6 
 arch/powerpc/lib/sstep.c                          |   45 
 arch/powerpc/mm/hash_low_32.S                     |   22 
 arch/powerpc/mm/hash_low_64.S                     |    5 
 arch/powerpc/mm/hash_native_64.c                  |    2 
 arch/powerpc/mm/hash_utils_64.c                   |  127 +
 arch/powerpc/mm/hugetlbpage.c                     |   16 
 arch/powerpc/mm/init_32.c                         |    4 
 arch/powerpc/mm/lmb.c                             |    4 
 arch/powerpc/mm/mem.c                             |    3 
 arch/powerpc/mm/mmu_decl.h                        |    5 
 arch/powerpc/mm/numa.c                            |   24 
 arch/powerpc/mm/pgtable_32.c                      |   76 -
 arch/powerpc/mm/ppc_mmu_32.c                      |    4 
 arch/powerpc/mm/tlb_64.c                          |   68 -
 arch/powerpc/oprofile/Makefile                    |    2 
 arch/powerpc/oprofile/common.c                    |    3 
 arch/powerpc/oprofile/op_model_cell.c             |    3 
 arch/powerpc/oprofile/op_model_pa6t.c             |  234 ++
 arch/powerpc/platforms/4xx/Kconfig                |  372 +--
 arch/powerpc/platforms/52xx/Kconfig               |   35 
 arch/powerpc/platforms/52xx/efika.c               |   15 
 arch/powerpc/platforms/52xx/lite5200.c            |   12 
 arch/powerpc/platforms/52xx/mpc52xx_common.c      |    2 
 arch/powerpc/platforms/52xx/mpc52xx_pci.c         |    2 
 arch/powerpc/platforms/82xx/Kconfig               |   45 
 arch/powerpc/platforms/82xx/mpc82xx.c             |    6 
 arch/powerpc/platforms/82xx/mpc82xx_ads.c         |   12 
 arch/powerpc/platforms/83xx/Kconfig               |   15 
 arch/powerpc/platforms/83xx/Makefile              |    1 
 arch/powerpc/platforms/83xx/mpc832x_mds.c         |    1 
 arch/powerpc/platforms/83xx/mpc832x_mds.h         |   19 
 arch/powerpc/platforms/83xx/mpc832x_rdb.c         |  138 +
 arch/powerpc/platforms/83xx/mpc834x_itx.h         |   23 
 arch/powerpc/platforms/83xx/pci.c                 |    2 
 arch/powerpc/platforms/85xx/Kconfig               |   38 
 arch/powerpc/platforms/85xx/Makefile              |    1 
 arch/powerpc/platforms/85xx/mpc8544_ds.c          |  144 +
 arch/powerpc/platforms/85xx/mpc85xx_ads.c         |    2 
 arch/powerpc/platforms/85xx/mpc85xx_cds.c         |    2 
 arch/powerpc/platforms/85xx/mpc85xx_mds.c         |    2 
 arch/powerpc/platforms/85xx/pci.c                 |    2 
 arch/powerpc/platforms/86xx/Kconfig               |   18 
 arch/powerpc/platforms/86xx/Makefile              |    2 
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c        |    4 
 arch/powerpc/platforms/86xx/pci.c                 |    4 
 arch/powerpc/platforms/8xx/Kconfig                |   67 
 arch/powerpc/platforms/8xx/m8xx_setup.c           |    8 
 arch/powerpc/platforms/8xx/mpc86xads.h            |    2 
 arch/powerpc/platforms/8xx/mpc86xads_setup.c      |    4 
 arch/powerpc/platforms/8xx/mpc885ads.h            |    2 
 arch/powerpc/platforms/8xx/mpc885ads_setup.c      |    4 
 arch/powerpc/platforms/Kconfig                    |  259 ++
 arch/powerpc/platforms/cell/Kconfig               |   24 
 arch/powerpc/platforms/cell/cbe_cpufreq.c         |  112 +
 arch/powerpc/platforms/cell/cbe_regs.c            |  168 +
 arch/powerpc/platforms/cell/cbe_regs.h            |    5 
 arch/powerpc/platforms/cell/cbe_thermal.c         |  181 +
 arch/powerpc/platforms/cell/interrupt.c           |    4 
 arch/powerpc/platforms/cell/io-workarounds.c      |    2 
 arch/powerpc/platforms/cell/iommu.c               |   16 
 arch/powerpc/platforms/cell/ras.c                 |  160 +
 arch/powerpc/platforms/cell/setup.c               |   12 
 arch/powerpc/platforms/cell/spider-pic.c          |    8 
 arch/powerpc/platforms/cell/spu_base.c            |  163 -
 arch/powerpc/platforms/cell/spu_coredump.c        |   34 
 arch/powerpc/platforms/cell/spu_manage.c          |   18 
 arch/powerpc/platforms/cell/spufs/Makefile        |    2 
 arch/powerpc/platforms/cell/spufs/backing_ops.c   |    6 
 arch/powerpc/platforms/cell/spufs/context.c       |   45 
 arch/powerpc/platforms/cell/spufs/coredump.c      |   19 
 arch/powerpc/platforms/cell/spufs/fault.c         |  211 ++
 arch/powerpc/platforms/cell/spufs/file.c          |  152 +
 arch/powerpc/platforms/cell/spufs/hw_ops.c        |    9 
 arch/powerpc/platforms/cell/spufs/inode.c         |   44 
 arch/powerpc/platforms/cell/spufs/run.c           |  123 -
 arch/powerpc/platforms/cell/spufs/sched.c         |  113 -
 arch/powerpc/platforms/cell/spufs/spufs.h         |   34 
 arch/powerpc/platforms/cell/spufs/switch.c        |    8 
 arch/powerpc/platforms/celleb/Kconfig             |    9 
 arch/powerpc/platforms/celleb/iommu.c             |    6 
 arch/powerpc/platforms/celleb/pci.c               |   18 
 arch/powerpc/platforms/celleb/setup.c             |   12 
 arch/powerpc/platforms/chrp/Kconfig               |   11 
 arch/powerpc/platforms/chrp/nvram.c               |    2 
 arch/powerpc/platforms/chrp/pci.c                 |   25 
 arch/powerpc/platforms/chrp/setup.c               |   52 
 arch/powerpc/platforms/chrp/time.c                |   13 
 arch/powerpc/platforms/embedded6xx/Kconfig        |  264 --
 arch/powerpc/platforms/embedded6xx/linkstation.c  |    8 
 arch/powerpc/platforms/embedded6xx/ls_uart.c      |    4 
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |   15 
 arch/powerpc/platforms/iseries/Kconfig            |    4 
 arch/powerpc/platforms/iseries/iommu.c            |    4 
 arch/powerpc/platforms/iseries/irq.c              |    4 
 arch/powerpc/platforms/iseries/pci.c              |    5 
 arch/powerpc/platforms/iseries/setup.c            |   10 
 arch/powerpc/platforms/iseries/viopath.c          |    2 
 arch/powerpc/platforms/maple/Kconfig              |   17 
 arch/powerpc/platforms/maple/pci.c                |    8 
 arch/powerpc/platforms/maple/setup.c              |   17 
 arch/powerpc/platforms/pasemi/Kconfig             |   19 
 arch/powerpc/platforms/pasemi/Makefile            |    3 
 arch/powerpc/platforms/pasemi/cpufreq.c           |  308 ++
 arch/powerpc/platforms/pasemi/gpio_mdio.c         |  339 +++
 arch/powerpc/platforms/pasemi/idle.c              |    9 
 arch/powerpc/platforms/pasemi/iommu.c             |    6 
 arch/powerpc/platforms/pasemi/pasemi.h            |    8 
 arch/powerpc/platforms/pasemi/pci.c               |   16 
 arch/powerpc/platforms/pasemi/setup.c             |   28 
 arch/powerpc/platforms/powermac/Kconfig           |   20 
 arch/powerpc/platforms/powermac/backlight.c       |    9 
 arch/powerpc/platforms/powermac/cpufreq_32.c      |   24 
 arch/powerpc/platforms/powermac/cpufreq_64.c      |   16 
 arch/powerpc/platforms/powermac/feature.c         |  101 -
 arch/powerpc/platforms/powermac/low_i2c.c         |   15 
 arch/powerpc/platforms/powermac/pci.c             |   41 
 arch/powerpc/platforms/powermac/pfunc_base.c      |    2 
 arch/powerpc/platforms/powermac/pfunc_core.c      |    5 
 arch/powerpc/platforms/powermac/pic.c             |    8 
 arch/powerpc/platforms/powermac/setup.c           |   61 
 arch/powerpc/platforms/powermac/smp.c             |   11 
 arch/powerpc/platforms/powermac/time.c            |   38 
 arch/powerpc/platforms/powermac/udbg_scc.c        |    6 
 arch/powerpc/platforms/prep/Kconfig               |    9 
 arch/powerpc/platforms/ps3/Kconfig                |   16 
 arch/powerpc/platforms/ps3/htab.c                 |    2 
 arch/powerpc/platforms/pseries/Kconfig            |   10 
 arch/powerpc/platforms/pseries/Makefile           |    5 
 arch/powerpc/platforms/pseries/eeh.c              |  204 +-
 arch/powerpc/platforms/pseries/eeh_driver.c       |   78 -
 arch/powerpc/platforms/pseries/eeh_event.c        |    8 
 arch/powerpc/platforms/pseries/firmware.c         |    2 
 arch/powerpc/platforms/pseries/hotplug-cpu.c      |    4 
 arch/powerpc/platforms/pseries/iommu.c            |   67 
 arch/powerpc/platforms/pseries/lpar.c             |    6 
 arch/powerpc/platforms/pseries/nvram.c            |    2 
 arch/powerpc/platforms/pseries/pci.c              |    3 
 arch/powerpc/platforms/pseries/pci_dlpar.c        |    1 
 arch/powerpc/platforms/pseries/ras.c              |    2 
 arch/powerpc/platforms/pseries/rtasd.c            |    2 
 arch/powerpc/platforms/pseries/setup.c            |   44 
 arch/powerpc/platforms/pseries/xics.c             |   17 
 arch/powerpc/sysdev/Makefile                      |    5 
 arch/powerpc/sysdev/dart_iommu.c                  |    4 
 arch/powerpc/sysdev/dcr.c                         |   14 
 arch/powerpc/sysdev/fsl_pcie.c                    |    2 
 arch/powerpc/sysdev/fsl_pcie.h                    |   94 +
 arch/powerpc/sysdev/fsl_soc.c                     |   90 -
 arch/powerpc/sysdev/mpic.c                        |   32 
 arch/powerpc/sysdev/pmi.c                         |   29 
 arch/powerpc/sysdev/qe_lib/Kconfig                |   10 
 arch/powerpc/sysdev/qe_lib/qe.c                   |    4 
 arch/powerpc/sysdev/qe_lib/qe_io.c                |    6 
 arch/powerpc/sysdev/qe_lib/ucc_slow.c             |    4 
 arch/powerpc/sysdev/timer.c                       |   71 +
 arch/powerpc/sysdev/tsi108_dev.c                  |   16 
 arch/powerpc/sysdev/tsi108_pci.c                  |    2 
 arch/powerpc/sysdev/uic.c                         |  342 +++
 arch/powerpc/xmon/xmon.c                          |   11 
 arch/ppc/8xx_io/Kconfig                           |    4 
 arch/ppc/8xx_io/Makefile                          |    1 
 arch/ppc/8xx_io/cs4218.h                          |  166 -
 arch/ppc/8xx_io/cs4218_tdm.c                      | 2833 ---------------------
 arch/ppc/boot/common/misc-common.c                |   15 
 arch/ppc/boot/simple/Makefile                     |    1 
 arch/ppc/boot/simple/uartlite_tty.c               |   37 
 arch/ppc/kernel/asm-offsets.c                     |    1 
 arch/ppc/kernel/entry.S                           |    1 
 arch/ppc/platforms/4xx/Kconfig                    |   15 
 arch/ppc/platforms/4xx/Makefile                   |    1 
 arch/ppc/platforms/4xx/ocotea.c                   |    4 
 arch/ppc/platforms/4xx/taishan.c                  |    2 
 arch/ppc/platforms/4xx/virtex.c                   |   56 
 arch/ppc/platforms/4xx/virtex.h                   |   34 
 arch/ppc/platforms/4xx/xilinx_ml300.c             |   65 
 arch/ppc/platforms/4xx/xilinx_ml300.h             |   45 
 arch/ppc/platforms/4xx/xilinx_ml403.c             |   66 
 arch/ppc/platforms/4xx/xilinx_ml403.h             |   49 
 arch/ppc/platforms/4xx/xparameters/xparameters.h  |   60 
 arch/ppc/platforms/rpxclassic.h                   |    4 
 arch/ppc/platforms/rpxhiox.h                      |   41 
 arch/ppc/platforms/rpxlite.h                      |    4 
 arch/ppc/syslib/Makefile                          |    3 
 arch/ppc/syslib/cpc710.h                          |   81 -
 arch/ppc/syslib/m8xx_setup.c                      |    2 
 arch/ppc/syslib/ppc4xx_sgdma.c                    |    1 
 arch/ppc/syslib/virtex_devices.c                  |  233 ++
 arch/ppc/syslib/virtex_devices.h                  |   27 
 drivers/char/briq_panel.c                         |    7 
 drivers/char/hvc_console.c                        |   49 
 drivers/char/hvc_iseries.c                        |    2 
 drivers/char/hvc_vio.c                            |    2 
 drivers/char/hvsi.c                               |    4 
 drivers/char/tpm/tpm_atmel.h                      |    4 
 drivers/char/watchdog/Kconfig                     |    2 
 drivers/hwmon/ams/ams-core.c                      |    4 
 drivers/hwmon/ams/ams-i2c.c                       |    4 
 drivers/hwmon/ams/ams-pmu.c                       |    4 
 drivers/infiniband/hw/ehca/ehca_main.c            |    4 
 drivers/macintosh/adb.c                           |   42 
 drivers/macintosh/ans-lcd.c                       |    9 
 drivers/macintosh/apm_emu.c                       |   13 
 drivers/macintosh/mac_hid.c                       |    2 
 drivers/macintosh/macio-adb.c                     |   16 
 drivers/macintosh/macio_asic.c                    |  100 -
 drivers/macintosh/macio_sysfs.c                   |   10 
 drivers/macintosh/rack-meter.c                    |    2 
 drivers/macintosh/smu.c                           |    8 
 drivers/macintosh/therm_adt746x.c                 |    8 
 drivers/macintosh/therm_pm72.c                    |    8 
 drivers/macintosh/therm_windtunnel.c              |    2 
 drivers/macintosh/via-cuda.c                      |    2 
 drivers/macintosh/via-pmu-led.c                   |   10 
 drivers/macintosh/via-pmu.c                       |   55 
 drivers/macintosh/windfarm_lm75_sensor.c          |    2 
 drivers/macintosh/windfarm_max6690_sensor.c       |    2 
 drivers/macintosh/windfarm_smu_controls.c         |    8 
 drivers/macintosh/windfarm_smu_sat.c              |    8 
 drivers/macintosh/windfarm_smu_sensors.c          |    6 
 drivers/media/video/planb.c                       |    5 
 drivers/net/Kconfig                               |    9 
 drivers/ps3/vuart.c                               |    8 
 drivers/scsi/ibmvscsi/ibmvstgt.c                  |    7 
 drivers/scsi/ibmvscsi/rpa_vscsi.c                 |    3 
 drivers/serial/pmac_zilog.c                       |    4 
 drivers/video/Kconfig                             |    2 
 drivers/video/aty/radeon_pm.c                     |    2 
 drivers/video/controlfb.c                         |   16 
 fs/proc/proc_devtree.c                            |    2 
 include/asm-powerpc/asm-compat.h                  |   10 
 include/asm-powerpc/cacheflush.h                  |    6 
 include/asm-powerpc/cell-pmu.h                    |    5 
 include/asm-powerpc/cputable.h                    |   11 
 include/asm-powerpc/current.h                     |    1 
 include/asm-powerpc/edac.h                        |   40 
 include/asm-powerpc/eeh_event.h                   |    6 
 include/asm-powerpc/ibmebus.h                     |   44 
 include/asm-powerpc/immap_86xx.h                  |   75 -
 include/asm-powerpc/io.h                          |    7 
 include/asm-powerpc/kprobes.h                     |    5 
 include/asm-powerpc/machdep.h                     |    3 
 include/asm-powerpc/mmu-hash64.h                  |  400 +++
 include/asm-powerpc/mmu.h                         |  405 ---
 include/asm-powerpc/mpic.h                        |   12 
 include/asm-powerpc/of_device.h                   |    3 
 include/asm-powerpc/oprofile_impl.h               |    2 
 include/asm-powerpc/paca.h                        |    4 
 include/asm-powerpc/parport.h                     |    6 
 include/asm-powerpc/pci.h                         |   14 
 include/asm-powerpc/pgtable-4k.h                  |    3 
 include/asm-powerpc/pgtable-64k.h                 |    5 
 include/asm-powerpc/pgtable.h                     |   60 
 include/asm-powerpc/pmc.h                         |    1 
 include/asm-powerpc/ppc-pci.h                     |   12 
 include/asm-powerpc/processor.h                   |    1 
 include/asm-powerpc/prom.h                        |   34 
 include/asm-powerpc/reg.h                         |   68 -
 include/asm-powerpc/spu_csa.h                     |    1 
 include/asm-powerpc/system.h                      |    1 
 include/asm-powerpc/tlb.h                         |    1 
 include/asm-powerpc/tlbflush.h                    |  172 +
 include/asm-powerpc/uaccess.h                     |   28 
 include/asm-powerpc/uic.h                         |   23 
 include/asm-ppc/ibm4xx.h                          |    8 
 include/asm-ppc/ppc_sys.h                         |    2 
 include/asm-ppc/prom.h                            |    3 
 include/linux/pmu.h                               |   12 
 sound/aoa/codecs/snd-aoa-codec-onyx.c             |    4 
 sound/aoa/codecs/snd-aoa-codec-tas.c              |    9 
 sound/aoa/core/snd-aoa-gpio-feature.c             |    8 
 sound/aoa/fabrics/snd-aoa-fabric-layout.c         |    8 
 sound/aoa/soundbus/core.c                         |    4 
 sound/aoa/soundbus/i2sbus/i2sbus-core.c           |    8 
 sound/oss/dmasound/dmasound_awacs.c               |  121 +
 sound/oss/dmasound/tas_common.c                   |    9 
 sound/ppc/pmac.c                                  |   41 
 sound/ppc/tumbler.c                               |   55 
 376 files changed, 11546 insertions(+), 7892 deletions(-)
 create mode 100644 arch/powerpc/boot/cuboot-83xx.c
 create mode 100644 arch/powerpc/boot/cuboot-85xx.c
 create mode 100644 arch/powerpc/boot/devtree.c
 create mode 100644 arch/powerpc/boot/dts/mpc832x_rdb.dts
 create mode 100644 arch/powerpc/boot/dts/mpc8544ds.dts
 create mode 100644 arch/powerpc/boot/elf_util.c
 create mode 100644 arch/powerpc/boot/gunzip_util.c
 create mode 100644 arch/powerpc/boot/gunzip_util.h
 create mode 100644 arch/powerpc/boot/ppcboot.h
 create mode 100644 arch/powerpc/boot/reg.h
 create mode 100644 arch/powerpc/configs/mpc832x_rdb_defconfig
 create mode 100644 arch/powerpc/configs/mpc8544_ds_defconfig
 create mode 100644 arch/powerpc/oprofile/op_model_pa6t.c
 create mode 100644 arch/powerpc/platforms/52xx/Kconfig
 delete mode 100644 arch/powerpc/platforms/83xx/mpc832x_mds.h
 create mode 100644 arch/powerpc/platforms/83xx/mpc832x_rdb.c
 delete mode 100644 arch/powerpc/platforms/83xx/mpc834x_itx.h
 create mode 100644 arch/powerpc/platforms/85xx/mpc8544_ds.c
 create mode 100644 arch/powerpc/platforms/Kconfig
 create mode 100644 arch/powerpc/platforms/cell/spufs/fault.c
 create mode 100644 arch/powerpc/platforms/celleb/Kconfig
 create mode 100644 arch/powerpc/platforms/chrp/Kconfig
 create mode 100644 arch/powerpc/platforms/maple/Kconfig
 create mode 100644 arch/powerpc/platforms/pasemi/cpufreq.c
 create mode 100644 arch/powerpc/platforms/pasemi/gpio_mdio.c
 create mode 100644 arch/powerpc/platforms/powermac/Kconfig
 rename arch/powerpc/{platforms/86xx/mpc86xx_pcie.c => sysdev/fsl_pcie.c} (100%)
 create mode 100644 arch/powerpc/sysdev/fsl_pcie.h
 create mode 100644 arch/powerpc/sysdev/timer.c
 create mode 100644 arch/powerpc/sysdev/uic.c
 delete mode 100644 arch/ppc/8xx_io/cs4218.h
 delete mode 100644 arch/ppc/8xx_io/cs4218_tdm.c
 create mode 100644 arch/ppc/boot/simple/uartlite_tty.c
 delete mode 100644 arch/ppc/platforms/4xx/virtex.c
 delete mode 100644 arch/ppc/platforms/4xx/xilinx_ml300.h
 delete mode 100644 arch/ppc/platforms/4xx/xilinx_ml403.h
 delete mode 100644 arch/ppc/platforms/rpxhiox.h
 delete mode 100644 arch/ppc/syslib/cpc710.h
 create mode 100644 arch/ppc/syslib/virtex_devices.c
 create mode 100644 arch/ppc/syslib/virtex_devices.h
 create mode 100644 include/asm-powerpc/edac.h
 create mode 100644 include/asm-powerpc/mmu-hash64.h
 create mode 100644 include/asm-powerpc/uic.h

Adrian Bunk (2):
      [POWERPC] Unexport mac_hid_mouse_emulate_buttons
      [POWERPC] Remove the unused HTDMSOUND driver

Akinobu Mita (6):
      [POWERPC] spufs: check spu_acquire_runnable() return value
      [POWERPC] spufs: fix missing error handling in module_init()
      [POWERPC] spufs: fix memory leak on spufs reloading
      [POWERPC] spufs: use memcpy_fromio() to copy from local store
      [POWERPC] spufs: enable SPU coredump for kernel-builtin spufs
      [POWERPC] Enable make install

Alan Cox (2):
      [POWERPC] pci_32.c: Switch to ref counting PCI API
      [POWERPC] via-pmu: Switch to ref counting PCI API

Ananth N Mavinakayanahalli (2):
      [POWERPC] Emulate more instructions in software
      [POWERPC] kprobes: Eliminate sstep exception if instruction can be emulated

Andrew Morton (2):
      [POWERPC] Fix compile error in prom.h
      [POWERPC] ppc4xx_sgdma needs dma-mapping.h

Anton Blanchard (3):
      [POWERPC] Remove _get_SP
      [POWERPC] Remove last_syscall
      [POWERPC] Fix WARN_ON when entering xmon

Arnd Bergmann (4):
      [POWERPC] spufs: add memory barriers after set_bit
      [POWERPC] spufs: make spu page faults not block scheduling
      [POWERPC] spufs: fix memory leak on coredump
      [POWERPC] update cell_defconfig

Bart Van Assche (1):
      [POWERPC] Ocotea board: ntpd complains that the frequency error exceeds the tolerance

Benjamin Herrenschmidt (8):
      [POWERPC] Add inatomic versions of __get_user and __put_user
      [POWERPC] Alignment exception uses __get/put_user_inatomic
      [POWERPC] Make tlb flush batch use lazy MMU mode
      [POWERPC] Cleanup 32-bit map_page
      [POWERPC] Fix 32-bit mm operations when not using BATs
      [POWERPC] DEBUG_PAGEALLOC for 32-bit
      [POWERPC] DEBUG_PAGEALLOC for 64-bit
      [POWERPC] Always use -mno-string

Christian Krafft (8):
      [POWERPC] cell: add cbe_node_to_cpu function
      [POWERPC] cbe_thermal: clean up computation of temperature
      [POWERPC] cbe_thermal: add throttling attributes to cpu and spu nodes
      [POWERPC] cell: use pmi in cpufreq driver
      [POWERPC] add check for initialized driver data to pmi driver
      [POWERPC] pmi probe device by device-type
      [POWERPC] add of_iomap function
      [POWERPC] cell: add support for proper device-tree

Christoph Hellwig (12):
      [POWERPC] spufs: don't yield CPU in spu_yield
      [POWERPC] spufs: use cancel_rearming_delayed_workqueue when stopping spu contexts
      [POWERPC] spufs: clear mapping pointers after last close
      [POWERPC] spu sched: ensure preempted threads are put back on the runqueue
      [POWERPC] spu sched: ensure preempted threads are put back on the runqueue, part2
      [POWERPC] spufs: remove woken threads from the runqueue early
      [POWERPC] spufs: streamline locking for isolated spu setup
      [POWERPC] spu_base: move spu_init_channels out of spu_mutex
      [POWERPC] spufs: turn run_sema into run_mutex
      [POWERPC] spufs: avoid spurious memory barriers
      [POWERPC] spufs: various run.c cleanups
      [POWERPC] spu_base: remove cleanup_spu_base

Dave Jiang (2):
      [POWERPC] EDAC ECC software scrubber
      [POWERPC] remove kernel module option for booke wdt

David Gibson (16):
      [POWERPC] Allow duplicate lmb_reserve() calls
      [POWERPC] Automatically lmb_reserve() initrd
      [POWERPC] zImage: Add more flexible gunzip convenience functions
      [POWERPC] zImage: Cleanup and improve prep_kernel()
      [POWERPC] zImage: Cleanup and improve zImage entry point
      [POWERPC] Update documentation for flat device tree format v17
      [POWERPC] Add documentation for the zImage's gunzip convenience functions
      [POWERPC] Add gcc format warnings to zImage printf()
      [POWERPC] New reg.h for the zImage
      [POWERPC] Add device tree utility functions to zImage
      [POWERPC] Clean up zImage handling of the command line
      [POWERPC] Re-organize Kconfig code for 4xx in arch/powerpc
      [POWERPC] Add arch/powerpc driver for UIC, PPC4xx interrupt controller
      [POWERPC] Cleanup and fix breakage in tlbflush.h
      [POWERPC] Abolish PHYS_FMT macro from arch/powerpc
      [POWERPC] Prepare for splitting up mmu.h by MMU type

Domen Puncer (1):
      [POWERPC] Fix typos in booting-without-of.txt

Geert Uytterhoeven (3):
      [POWERPC] ps3: always make sure we're running on a PS3
      [POWERPC] CBE thermal support on PS3
      [POWERPC] bootwrapper: Use `unsigned long' for malloc sizes

Giuliano Pochini (1):
      [POWERPC] Fix breakage caused by 72486f1f8f0a2bc828b9d30cf4690cf2dd6807fc

Grant Likely (8):
      [POWERPC] Fix comment typo in Kurobox device tree
      [POWERPC] Rework Kconfig dependancies for Xilinx Virtex ppc405 platform
      [POWERPC] Merge common virtex header files
      [POWERPC] New registration for common Xilinx Virtex ppc405 platform devices
      [POWERPC] Stop using ppc_sys for Xilinx Virtex boards
      [POWERPC] Add uartlite boot console driver for the zImage wrapper
      [POWERPC] Add sane defaults for Xilinx EDK generated xparameters files
      [POWERPC] Don't define a custom bd_t for Xilixn Virtex based boards.

Jake Moilanen (3):
      [POWERPC] DMA 4GB boundary protection
      [POWERPC] 750CL cputable entry
      [POWERPC] DMA 4GB boundary protection

Jeremy Kerr (5):
      [POWERPC] spufs: provide siginfo for SPE faults
      [POWERPC] spufs: add mode= mount option
      [POWERPC] spufs: Minor cleanup of spu_wait
      [POWERPC] spu_base: fix initialisation on systems with no SPEs
      [POWERPC] cell: enable RTAS-based PTCAL for Cell XDR memory

Joachim Fenkes (3):
      [POWERPC] ibmebus: whitespace fixes
      [POWERPC] ibmebus: dynamic addition/removal of adapters, some code cleanup
      [POWERPC] ibmebus: change probe/remove interface from using loc-code to DT path

Johannes Berg (3):
      [POWERPC] Generic time suspend/resume code
      [POWERPC] powermac: disallow pmu sleep notifiers from aborting sleep
      [POWERPC] Declare enable_kernel_spe in a header

John Rigby (1):
      [POWERPC] Avoid putting cpu node twice

Jon Loeliger (3):
      [POWERPC] 86xx/85xx: Move 8641 PCI-Express to arch/powerpc/sysdev/fsl_pcie.c.
      [POWERPC] 85xx: Add initial MPC8544 DS platform files.
      [POWERPC] 85xx: Add initial MPC8544DS basic port defconfig.

Josh Boyer (1):
      [POWERPC] Fix PowerPC 750CL and 750GX CPU features

Kumar Gala (14):
      [POWERPC] Split 52xx platforms into their own Kconfig file
      [POWERPC] Split powermac platforms into their own Kconfig file
      [POWERPC] Split cell platforms into their respective Kconfig file
      [POWERPC] Removed config options that we don't support in embedded6xx
      [POWERPC] Split several platforms into their respective Kconfig file
      [POWERPC] Created arch/powerpc/platforms/Kconfig for "Platform support"
      [POWERPC] 83xx: Removed dead header
      [POWERPC] Ensure platform CONFIG options have correct dependencies
      [POWERPC] Convert 86xx platform to unified platform Kconfig
      [POWERPC] Convert 83xx platform to unified platform Kconfig
      [POWERPC] Convert 82xx platform to unified platform Kconfig
      [POWERPC] Convert 8xx platform to unified platform Kconfig
      [POWERPC] Convert 85xx platform to unified platform Kconfig
      [POWERPC] Miscellaneous arch/powerpc Kconfig and platform/Kconfig cleanup

Linas Vepstas (11):
      [POWERPC] EEH: modify order of EEH state checking
      [POWERPC] EEH: Add clarifying messages.
      [POWERPC] EEH: Tolerate high mmio
      [POWERPC] EEH: support ibm,get-config-addr-info2 RTAS call
      [POWERPC] EEH: hotplug recovery bugfix
      [POWERPC] EEH: multifunction recovery bugfix
      [POWERPC] EEH: handle reset state high
      [POWERPC] EEH: wait for slot status
      [POWERPC] EEH: rm un-needed data
      [POWERPC] EEH: verify state change
      [POWERPC] EEH: restructure multi-function support

Luke Browning (1):
      [POWERPC] spu sched: make addition to stop_wq and runque atomic vs wakeup

MOKUNO Masakazu (1):
      [POWERPC] Remove some redundant isync instructions

Mariusz Kozlowski (1):
      [POWERPC] 8xx parenthesis balance

Mark A. Greer (4):
      [POWERPC] 32-bit early_init() should zero from __bss_start to __bss_stop only
      [POWERPC] Move bootwrapper ELF parsing routines to a file
      [POWERPC] Routine to find the devtree node of a linux,phandle
      [POWERPC] Add dt_xlate_addr() to bootwrapper

Michael Barkowski (1):
      [POWERPC] 83xx: Add MPC832x RDB board support.

Michael Ellerman (1):
      [POWERPC] Rename MPIC_BROKEN_U3 to MPIC_U3_HT_IRQS

Milind Arun Choudhary (1):
      [POWERPC] Clean up unused ROUND_UP, NAME_OFFSET macros in arch/powerpc

Milton Miller (11):
      [POWERPC] boot: rebuild when wrapper changes
      [POWERPC] boot: export flush_cache
      [POWERPC] bootwrapper: Add a fatal error helper
      [POWERPC] bootwrapper: Allow platforms to call library zImage_start
      [POWERPC] boot: Use FORCE
      [POWERPC] boot: clean rule fixes
      [POWERPC] boot: Use a common zImage rule
      [POWERPC] bootwrapper: missing relocation in crt0.S
      [POWERPC] bootwrapper: no-gzip fixes
      [POWERPC] bootwrapper: Decompress less, check more
      [POWERPC] boot: More verbose gunzip error message

Olaf Hering (7):
      [POWERPC] Include stddef.h in asm-powerpc/current.h to get offsetof
      [POWERPC] Fix link errors when EEH is disabled
      [POWERPC] Remove unused inclusion of linux/ide.h
      [POWERPC] Autodetect serial console on efika
      [POWERPC] Fix modalias content in sysfs for macio devices
      [POWERPC] Add correct interrupt property for pegasos ide
      [POWERPC] Generic check_legacy_ioport

Olof Johansson (12):
      [POWERPC] Use mtocrf instruction in asm when CONFIG_POWER4_ONLY=y
      [POWERPC] pasemi: Allow 8KB config space for I/O bridge
      [POWERPC] pasemi: Enable one more hid bit
      [POWERPC] pasemi: Reset mpic on boot
      [POWERPC] pasemi: PA6T oprofile support
      [POWERPC] pasemi: GPIO MDIO of_platform driver
      [POWERPC] Save trap number in bad_stack
      [POWERPC] pasemi: Remove build warning
      [POWERPC] pasemi: Kconfig for gpio_mdio
      [POWERPC] pasemi: Cpufreq driver
      [POWERPC] Clean up cpufreq Kconfig dependencies
      [POWERPC] cell: cbe_cpufreq cleanup and crash fix

Paul Mackerras (8):
      [POWERPC] Harden validate_sp against stack corruption
      [POWERPC] Allow drivers to map individual 4k pages to userspace
      [POWERPC] Fix detection of loader-supplied initrd on OF platforms
      [POWERPC] Partially revert "Add correct interrupt property for pegasos ide"
      Revert "[POWERPC] DMA 4GB boundary protection"
      Revert "[POWERPC] Rename get_property to of_get_property: drivers"
      Revert "[POWERPC] Autodetect serial console on efika"
      [POWERPC] Remove dev_dbg redefinition in drivers/ps3/vuart.c

Robert P. J. Day (3):
      [POWERPC] Correct apparently misspelled "XMON" preprocessor symbol.
      [POWERPC] 83xx: Delete unused header file.
      [POWERPC] Remove unused header file: arch/ppc/syslib/cpc710.h.

Scott Wood (25):
      [POWERPC] bootwrapper: Add stddef.h to ops.h
      [POWERPC] bootwrapper: Add ft_root_node().
      [POWERPC] bootwrapper: Rename ft_node_add() to ft_get_phandle().
      [POWERPC] bootwrapper: Make ft_get_phandle() accept and return NULL.
      [POWERPC] bootwrapper: Preserve the pp pointer in ft_make_space() when calling ft_reorder().
      [POWERPC] bootwrapper: Modify *pp, not *p, in ft_shuffle().
      [POWERPC] bootwrapper: Use map_string() instead of lookup_string() in ft_prop().
      [POWERPC] bootwrapper: Add ft_find_device_rel().
      [POWERPC] bootwrapper: Refactor ft_get_prop() into internal and external functions.
      [POWERPC] bootwrapper: Make ft_get_parent() return a phandle, and NULL if already top-level.
      [POWERPC] bootwrapper: Add ft_find_node_by_prop_value().
      [POWERPC] bootwrapper: Make ft_create_node() pay attention to the parent parameter.
      [POWERPC] bootwrapper: Add dt_ops methods.
      [POWERPC] bootwrapper: Make compression of the kernel image optional.
      [POWERPC] Document the linux,network-index property.
      [POWERPC] bootwrapper: Make setprop accept a const buffer.
      [POWERPC] bootwrapper: Add dt_xlate_reg(), and use it to find serial registers.
      [POWERPC] bootwrapper: Add CONFIG_DEVICE_TREE
      [POWERPC] bootwrapper: Add a cuboot platform and a cuImage target
      [POWERPC] bootwrapper: Add ppcboot.h
      [POWERPC] bootwrapper: cuboot for 83xx
      [POWERPC] bootwrapper: Fix array handling in dt_xlate_reg().
      [POWERPC] bootwrapper: cuImage for 85xx
      [POWERPC] bootwrapper: cuboot-83xx: Exclude upper 1MB from heap.
      [POWERPC] bootwrapper: CONFIG_ -> CONFIG_DEVICE_TREE

Segher Boessenkool (1):
      [POWERPC] PowerPC: select default image for Linkstation

Sonny Rao (1):
      [POWERPC] Remove stale comment from head_64.S

Srinivasa Ds (1):
      [POWERPC] arch/powerpc/sysdev/timer.c build fix

Stefan Roese (1):
      [POWERPC] ppc: Fix PCIX configuration of Ocotea & Taishan for > 512MB DDR

Stephen Rothwell (29):
      [POWERPC] Allocate syscall number for sys_getcpu
      [POWERPC] Make ppc64_defconfig without CONFIG_PPC_PSERIES build
      [POWERPC] Create and use set_pci_dma_ops
      [POWERPC] Create and use get_pci_dma_ops()
      [POWERPC] Make iSeries build without CONFIG_PCI
      [POWERPC] Allow pSeries to build without CONFIG_PCI
      [POWERPC] Allow xmon to build without CONFIG_DEBUG_BUGVERBOSE
      [POWERPC] Make find_and_init_pbs() a void function
      [POWERPC] Minor paca optimisation
      [POWERPC] get_property returns const
      [POWERPC] Rename get_property to of_get_property
      [POWERPC] Rename device_is_compatible to of_device_is_compatible
      [POWERPC] Rename prom_n_addr_cells to of_n_addr_cells
      [POWERPC] Rename prom_n_size_cells to of_n_size_cells
      [POWERPC] Make struct property's value a void *
      [POWERPC] Rename get_property to of_get_property: include
      [POWERPC] Rename get_property to of_get_property: arch/powerpc
      [POWERPC] Rename get_property to of_get_property: sound
      [POWERPC] Rename get_property to of_get_property: drivers
      [POWERPC] Rename get_property to of_get_property: the last one
      [POWERPC] Rename last get_property calls
      [POWERPC] Remove find_compatible_devices
      [POWERPC] Remove find_all_nodes
      [POWERPC] Remove old interface find_path_device
      [POWERPC] Remove old interface find_type_devices
      [POWERPC] Remove old interface find_devices
      [POWERPC] Rename get_property to of_get_property: partial drivers
      [POWERPC] Partially revert a7edd0e676d51145ae634a2acf7a447e319200fa
      [POWERPC] get_property cleanups

Stuart Yoder (3):
      [POWERPC] Remove interrupt-controller as a property under /chosen
      [POWERPC] Remove unused, undocumented #cpus property from cpus node
      [POWERPC] Update interrupt info in booting-without-of.txt

Sylvain Munaut (3):
      [POWERPC] Add a unified uevent handler for bus based on of_device
      [POWERPC] powermac: Use the new of_device common uevent handler
      [POWERPC] Add uevent handler for of_platform_bus

Thomas Gleixner (1):
      [POWERPC] Spinlock initializer cleanup

Timur Tabi (2):
      [POWERPC] QE: automatically select QE options
      [POWERPC] QE: fix invalid pointer usage in ucc_slow_init()

Tony Vroon (1):
      [POWERPC] PMU LED whitelisting of PowerMac 7,2 and 7,3

Will Schmidt (2):
      [POWERPC] hvc_console: Polling mode timer backoff
      [POWERPC] Replace if-then-else with a switch statement

Zang Roy-r61911 (2):
      [POWERPC] Remove fixed setting of ROOT_DEV for 7448HPC2 platforms
      [POWERPC] 86xx/85xx: Unify Freescale PCI Express memory map registers structure

Zhang Wei (1):
      [POWERPC] 86xx: Added 2nd PCI-Ex controller support for MPC8641 HPCN to DTS.

anton@samba.org (5):
      [POWERPC] Add missing oops_enter/oops_exit
      [POWERPC] Clean up pmac_backlight_unblank in oops path
      [POWERPC] Handle recursive oopses
      [POWERPC] Fix backwards ? : when printing machine type
      [POWERPC] Use lowercase for hex printouts in oops messages.

will schmidt (1):
      [POWERPC] hvc_console: Typo fixes
