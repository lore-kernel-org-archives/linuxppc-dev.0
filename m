Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17440.57461.885985.391559@cargo.ozlabs.ibm.com>
Date: Wed, 22 Mar 2006 16:28:21 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: please pull powerpc.git
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

Please do a pull from

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git

to get the PowerPC updates that have been queued up to go into
2.6.17.

Thanks,
Paul.

Adrian Cox:
      ppc: Fix platform_notify functions marked __init

Andy Fleming:
      powerpc: Add PCI support for 8540 ADS to powerpc tree

Becky Bruce:
      powerpc: Updated Initial MPC8540 ADS port with OF Flat Dev
      powerpc: Fix Kernel FP unavail exception for BookE
      powerpc: mpc85xx_ads.c include file cleanup
      powerpc: rename mpc85xx.c to misc.c
      powerpc: lindent 85xx platform code
      powerpc/ppc: Add missing isyncs in head_fsl_booke.S

Christoph Hellwig:
      powerpc: add for_each_node_by_foo helpers
      spidernet: select FW_LOADER

David Gibson:
      powerpc: Fixup for STRICT_MM_TYPECHECKS
      powerpc: Better pmd_bad() and pud_bad() checks

Domen Puncer:
      powerpc: Remove arch/ppc/syslib/ppc4xx_pm.c

Eric Sesterhenn:
      kzalloc() conversion in arch/ppc

Geoff Levand:
      powerpc: Add missing vmlinux.bin target

Grant C. Likely:
      powerpc: Move xparameters.h into xilinx virtex device specific path
      powerpc: Make Virtex-II Pro support generic for all Virtex devices
      powerpc: Migrate Xilinx Vertex support from the OCP bus to the platfom bus.
      powerpc: Migrate ML300 reference design to the platform bus
      powerpc: Add ML300 defconfig
      powerpc: Add Virtex-4 FX to cpu table
      powerpc: Add xparameters file for Xilinx ML403 reference design
      powerpc: Add support for Xilinx ML403 reference design
      powerpc: Add ML403 defconfig

Grant Likely:
      Fix compile error for ML300/403

Horst Kronstorfer:
      ppc32: Fix BCSR_SIZE for MPC834x SYS

Jon Mason:
      powerpc: trivial: modify comments to refer to new location of files

Kumar Gala:
      powerpc: Add CONFIG_DEFAULT_UIMAGE to build a uImage by default for a board
      powerpc: cleaned up fsl_soc.c
      powerpc: Add platform support for MPC834x USB controllers
      powerpc: Cleanup MPC83xx platform support
      powerpc: Lindent platforms/83xx
      powerpc: Fix mpc83xx restart bug

Marcelo Tosatti:
      powerpc: generalize PPC44x_PIN_SIZE

Michael Ellerman:
      powerpc: Always panic if lmb_alloc() fails
      powerpc: Move LMB_ALLOC_ANYWHERE out of lmb.h
      powerpc: Put parameter names in lmb.h prototypes
      powerpc: Clean up pSeries firmware feature initialisation
      powerpc: Move pSeries firmware feature setup into platforms/pseries
      powerpc: Fix bug in bug fix for bug in lmb_alloc()
      powerpc: Unconfuse htab_bolt_mapping() callers
      powerpc: Remove unused iommu_off logic from pSeries_init_early()
      powerpc: trivial: Cleanup whitespace in cputable.h
      powerpc: Replace platform_is_lpar() with a firmware feature
      powerpc: iseries: mf related cleanups
      powerpc: iseries: Remove pointless iSeries_(restart|power_off|halt)
      powerpc: iseries: Make more stuff static in platforms/iseries/mf.c
      powerpc: Add strne2a() to convert a string from EBCDIC to ASCII
      powerpc: iseries: Add /system-id, /model and /compatible
      powerpc: iseries: Add bootargs to /chosen
      powerpc: Remove calculation of io hole

Nathan Lynch:
      powerpc numa: fix boot_cpuid always assigned to node 0
      powerpc numa: Minor debugging code changes
      powerpc numa: Minor cpu hotplug-related cleanups
      powerpc numa: Get rid of "numa domain" terminology
      powerpc numa: Consolidate handling of Power4 special case
      powerpc numa: Support sparse online node map
      powerpc numa: Consolidate assignment of cpus to nodes

Nick Piggin:
      powerpc: newline for ISYNC_ON_SMP
      powerpc: native atomic_add_unless

Olaf Hering:
      powerpc: cleanup pmac_newworld variable usage
      powerpc: remove check for ELF offset in powerpc bootimage
      powerpc: add a raw dump command to xmon

Paul Mackerras:
      powerpc: Implement accurate task and CPU time accounting
      powerpc: Export variables used in conversions to/from cputime_t

Stephen Rothwell:
      powerpc: update mailing list addresses

Vitaly Bordug:
      ppc32 8xx: Added setbitsXX/clrbitsXX macro for read-modify-write operations
      PPC32 8xx: support for the physmapped flash on m8xx
      ppc32: MPC885ADS, MPC866ADS and MPC8272ADS-specific platform stuff for fs_enet
      ppc32: Make platform devices being able to assign functions

 Documentation/powerpc/eeh-pci-error-recovery.txt   |   15 
 Documentation/powerpc/hvcs.txt                     |    4 
 MAINTAINERS                                        |    4 
 arch/powerpc/Kconfig                               |   38 +
 arch/powerpc/Makefile                              |    2 
 arch/powerpc/boot/install.sh                       |    2 
 arch/powerpc/boot/main.c                           |    4 
 arch/powerpc/configs/mpc8540_ads_defconfig         |  721 +++++++++++++++++++
 arch/powerpc/kernel/asm-offsets.c                  |    3 
 arch/powerpc/kernel/cputable.c                     |   12 
 arch/powerpc/kernel/entry_64.S                     |   11 
 arch/powerpc/kernel/firmware.c                     |   25 -
 arch/powerpc/kernel/head_44x.S                     |    2 
 arch/powerpc/kernel/head_64.S                      |   11 
 arch/powerpc/kernel/head_8xx.S                     |    2 
 arch/powerpc/kernel/head_booke.h                   |  363 ++++++++++
 arch/powerpc/kernel/head_fsl_booke.S               |    6 
 arch/powerpc/kernel/iomap.c                        |    2 
 arch/powerpc/kernel/iommu.c                        |    1 
 arch/powerpc/kernel/irq.c                          |   32 +
 arch/powerpc/kernel/kprobes.c                      |    1 
 arch/powerpc/kernel/pci_iommu.c                    |    1 
 arch/powerpc/kernel/ppc_ksyms.c                    |    1 
 arch/powerpc/kernel/process.c                      |    9 
 arch/powerpc/kernel/prom.c                         |    4 
 arch/powerpc/kernel/ptrace-common.h                |    2 
 arch/powerpc/kernel/rtas-proc.c                    |    1 
 arch/powerpc/kernel/rtas_pci.c                     |    2 
 arch/powerpc/kernel/setup_64.c                     |    2 
 arch/powerpc/kernel/signal_64.c                    |    2 
 arch/powerpc/kernel/smp.c                          |    4 
 arch/powerpc/kernel/time.c                         |  241 ++++++-
 arch/powerpc/kernel/vdso.c                         |    2 
 arch/powerpc/lib/copypage_64.S                     |    2 
 arch/powerpc/lib/copyuser_64.S                     |    2 
 arch/powerpc/lib/e2a.c                             |   14 
 arch/powerpc/lib/memcpy_64.S                       |    2 
 arch/powerpc/lib/rheap.c                           |    2 
 arch/powerpc/mm/fault.c                            |    2 
 arch/powerpc/mm/hash_low_32.S                      |    2 
 arch/powerpc/mm/hash_utils_64.c                    |   32 -
 arch/powerpc/mm/init_64.c                          |   48 -
 arch/powerpc/mm/lmb.c                              |   16 
 arch/powerpc/mm/mem.c                              |    1 
 arch/powerpc/mm/mmap.c                             |    2 
 arch/powerpc/mm/numa.c                             |  160 ++--
 arch/powerpc/mm/slb_low.S                          |    2 
 arch/powerpc/mm/stab.c                             |    4 
 arch/powerpc/mm/tlb_64.c                           |    2 
 arch/powerpc/oprofile/op_model_power4.c            |    3 
 arch/powerpc/platforms/83xx/Makefile               |    4 
 arch/powerpc/platforms/83xx/misc.c                 |   55 +
 arch/powerpc/platforms/83xx/mpc834x_sys.c          |   89 --
 arch/powerpc/platforms/83xx/mpc834x_sys.h          |    2 
 arch/powerpc/platforms/83xx/mpc83xx.h              |    5 
 arch/powerpc/platforms/83xx/pci.c                  |   21 -
 arch/powerpc/platforms/85xx/Kconfig                |   74 --
 arch/powerpc/platforms/85xx/Makefile               |    6 
 arch/powerpc/platforms/85xx/misc.c                 |   31 +
 arch/powerpc/platforms/85xx/mpc8540_ads.h          |   36 +
 arch/powerpc/platforms/85xx/mpc85xx.h              |   18 
 arch/powerpc/platforms/85xx/mpc85xx_ads.c          |  244 +++++++
 arch/powerpc/platforms/85xx/pci.c                  |   96 +++
 arch/powerpc/platforms/Makefile                    |    2 
 arch/powerpc/platforms/chrp/pegasos_eth.c          |    2 
 arch/powerpc/platforms/chrp/setup.c                |    2 
 arch/powerpc/platforms/chrp/time.c                 |    2 
 arch/powerpc/platforms/iseries/mf.c                |  112 ++-
 arch/powerpc/platforms/iseries/setup.c             |   72 +-
 arch/powerpc/platforms/maple/time.c                |    2 
 arch/powerpc/platforms/powermac/cpufreq_32.c       |    2 
 arch/powerpc/platforms/powermac/feature.c          |    2 
 arch/powerpc/platforms/powermac/nvram.c            |    2 
 arch/powerpc/platforms/powermac/setup.c            |    8 
 arch/powerpc/platforms/pseries/Makefile            |    3 
 arch/powerpc/platforms/pseries/firmware.c          |  103 +++
 arch/powerpc/platforms/pseries/firmware.h          |   17 
 arch/powerpc/platforms/pseries/hvCall.S            |    2 
 arch/powerpc/platforms/pseries/iommu.c             |    4 
 arch/powerpc/platforms/pseries/pci.c               |    2 
 arch/powerpc/platforms/pseries/setup.c             |   67 --
 arch/powerpc/platforms/pseries/smp.c               |    2 
 arch/powerpc/platforms/pseries/xics.c              |    3 
 arch/powerpc/sysdev/dart_iommu.c                   |    2 
 arch/powerpc/sysdev/dcr.S                          |    2 
 arch/powerpc/sysdev/fsl_soc.c                      |  292 ++++++--
 arch/powerpc/sysdev/ipic.h                         |    2 
 arch/powerpc/xmon/xmon.c                           |   30 +
 arch/ppc/4xx_io/serial_sicc.c                      |    5 
 arch/ppc/8xx_io/commproc.c                         |    6 
 arch/ppc/Kconfig                                   |   47 +
 arch/ppc/Kconfig.debug                             |    2 
 arch/ppc/amiga/amiints.c                           |    2 
 arch/ppc/amiga/bootinfo.c                          |    2 
 arch/ppc/amiga/cia.c                               |    2 
 arch/ppc/amiga/config.c                            |    2 
 arch/ppc/amiga/ints.c                              |    2 
 arch/ppc/boot/Makefile                             |    3 
 arch/ppc/boot/common/Makefile                      |    3 
 arch/ppc/boot/common/bootinfo.c                    |    2 
 arch/ppc/boot/common/misc-common.c                 |    2 
 arch/ppc/boot/common/ns16550.c                     |    3 
 arch/ppc/boot/common/serial_stub.c                 |    2 
 arch/ppc/boot/common/util.S                        |    2 
 arch/ppc/boot/include/mpc10x.h                     |    2 
 arch/ppc/boot/simple/Makefile                      |    1 
 arch/ppc/boot/simple/cpc700_memory.c               |    2 
 arch/ppc/boot/simple/embed_config.c                |    7 
 arch/ppc/boot/simple/head.S                        |    9 
 arch/ppc/boot/simple/misc-chestnut.c               |    2 
 arch/ppc/boot/simple/misc-cpci690.c                |    2 
 arch/ppc/boot/simple/misc-ev64260.c                |    2 
 arch/ppc/boot/simple/misc-ev64360.c                |    1 
 arch/ppc/boot/simple/misc-katana.c                 |    2 
 arch/ppc/boot/simple/misc-mv64x60.c                |    2 
 arch/ppc/boot/simple/misc-prep.c                   |    2 
 arch/ppc/boot/simple/misc-radstone_ppc7d.c         |    2 
 arch/ppc/boot/simple/misc-spruce.c                 |    2 
 arch/ppc/boot/simple/misc.c                        |    2 
 arch/ppc/boot/simple/mpc10x_memory.c               |    2 
 arch/ppc/boot/simple/mpc52xx_tty.c                 |    2 
 arch/ppc/boot/simple/mv64x60_tty.c                 |    2 
 arch/ppc/boot/simple/openbios.c                    |    2 
 arch/ppc/boot/simple/relocate.S                    |    2 
 arch/ppc/boot/utils/mkbugboot.c                    |    2 
 arch/ppc/configs/ml300_defconfig                   |  739 ++++++++++++++++++++
 arch/ppc/configs/ml403_defconfig                   |  740 ++++++++++++++++++++
 arch/ppc/kernel/head_44x.S                         |    2 
 arch/ppc/kernel/head_8xx.S                         |    2 
 arch/ppc/kernel/head_fsl_booke.S                   |    6 
 arch/ppc/kernel/smp-tbsync.c                       |    3 
 arch/ppc/kernel/traps.c                            |    2 
 arch/ppc/lib/rheap.c                               |    2 
 arch/ppc/math-emu/math.c                           |    2 
 arch/ppc/mm/44x_mmu.c                              |    4 
 arch/ppc/mm/fault.c                                |    2 
 arch/ppc/mm/hashtable.S                            |    2 
 arch/ppc/platforms/4xx/Kconfig                     |   23 -
 arch/ppc/platforms/4xx/Makefile                    |    4 
 arch/ppc/platforms/4xx/bamboo.c                    |    2 
 arch/ppc/platforms/4xx/bamboo.h                    |    2 
 arch/ppc/platforms/4xx/bubinga.h                   |    2 
 arch/ppc/platforms/4xx/cpci405.c                   |    2 
 arch/ppc/platforms/4xx/ebony.c                     |    2 
 arch/ppc/platforms/4xx/ebony.h                     |    2 
 arch/ppc/platforms/4xx/ep405.c                     |    2 
 arch/ppc/platforms/4xx/ep405.h                     |    2 
 arch/ppc/platforms/4xx/ibm405ep.c                  |    2 
 arch/ppc/platforms/4xx/ibm405ep.h                  |    2 
 arch/ppc/platforms/4xx/ibm405gp.h                  |    2 
 arch/ppc/platforms/4xx/ibm405gpr.c                 |    2 
 arch/ppc/platforms/4xx/ibm405gpr.h                 |    2 
 arch/ppc/platforms/4xx/ibm440ep.c                  |    2 
 arch/ppc/platforms/4xx/ibm440ep.h                  |    2 
 arch/ppc/platforms/4xx/ibm440gp.c                  |    2 
 arch/ppc/platforms/4xx/ibm440gp.h                  |    2 
 arch/ppc/platforms/4xx/ibm440gx.c                  |    2 
 arch/ppc/platforms/4xx/ibm440gx.h                  |    2 
 arch/ppc/platforms/4xx/ibm440sp.c                  |    2 
 arch/ppc/platforms/4xx/ibm440sp.h                  |    2 
 arch/ppc/platforms/4xx/ibmnp405h.c                 |    2 
 arch/ppc/platforms/4xx/ibmnp405h.h                 |    2 
 arch/ppc/platforms/4xx/ibmstb4.c                   |    2 
 arch/ppc/platforms/4xx/ibmstb4.h                   |    2 
 arch/ppc/platforms/4xx/ibmstbx25.c                 |    2 
 arch/ppc/platforms/4xx/ibmstbx25.h                 |    2 
 arch/ppc/platforms/4xx/luan.c                      |    2 
 arch/ppc/platforms/4xx/luan.h                      |    2 
 arch/ppc/platforms/4xx/ocotea.c                    |    2 
 arch/ppc/platforms/4xx/ocotea.h                    |    2 
 arch/ppc/platforms/4xx/ppc440spe.c                 |    2 
 arch/ppc/platforms/4xx/ppc440spe.h                 |    2 
 arch/ppc/platforms/4xx/redwood5.c                  |    2 
 arch/ppc/platforms/4xx/redwood5.h                  |    2 
 arch/ppc/platforms/4xx/redwood6.c                  |    2 
 arch/ppc/platforms/4xx/redwood6.h                  |    2 
 arch/ppc/platforms/4xx/sycamore.c                  |    2 
 arch/ppc/platforms/4xx/sycamore.h                  |    2 
 arch/ppc/platforms/4xx/virtex-ii_pro.c             |   60 --
 arch/ppc/platforms/4xx/virtex-ii_pro.h             |   99 ---
 arch/ppc/platforms/4xx/virtex.c                    |   56 ++
 arch/ppc/platforms/4xx/virtex.h                    |   35 +
 arch/ppc/platforms/4xx/walnut.c                    |    2 
 arch/ppc/platforms/4xx/walnut.h                    |    2 
 arch/ppc/platforms/4xx/xilinx_ml300.c              |   76 +-
 arch/ppc/platforms/4xx/xilinx_ml300.h              |    6 
 arch/ppc/platforms/4xx/xilinx_ml403.c              |  177 +++++
 arch/ppc/platforms/4xx/xilinx_ml403.h              |   49 +
 arch/ppc/platforms/4xx/xparameters/xparameters.h   |   37 +
 .../platforms/4xx/xparameters/xparameters_ml403.h  |  243 ++++++++
 arch/ppc/platforms/4xx/yucca.c                     |    2 
 arch/ppc/platforms/4xx/yucca.h                     |    2 
 arch/ppc/platforms/83xx/mpc834x_sys.c              |    2 
 arch/ppc/platforms/83xx/mpc834x_sys.h              |    4 
 arch/ppc/platforms/85xx/mpc8540_ads.c              |    2 
 arch/ppc/platforms/85xx/mpc8540_ads.h              |    2 
 arch/ppc/platforms/85xx/mpc8555_cds.h              |    2 
 arch/ppc/platforms/85xx/mpc8560_ads.c              |    2 
 arch/ppc/platforms/85xx/mpc8560_ads.h              |    2 
 arch/ppc/platforms/85xx/mpc85xx_ads_common.c       |    2 
 arch/ppc/platforms/85xx/mpc85xx_ads_common.h       |    2 
 arch/ppc/platforms/85xx/mpc85xx_cds_common.c       |    2 
 arch/ppc/platforms/85xx/mpc85xx_cds_common.h       |    2 
 arch/ppc/platforms/85xx/sbc8560.c                  |    2 
 arch/ppc/platforms/85xx/sbc8560.h                  |    2 
 arch/ppc/platforms/85xx/sbc85xx.c                  |    2 
 arch/ppc/platforms/85xx/sbc85xx.h                  |    2 
 arch/ppc/platforms/85xx/stx_gp3.c                  |    2 
 arch/ppc/platforms/85xx/stx_gp3.h                  |    2 
 arch/ppc/platforms/85xx/tqm85xx.c                  |    2 
 arch/ppc/platforms/85xx/tqm85xx.h                  |    2 
 arch/ppc/platforms/Makefile                        |    3 
 arch/ppc/platforms/apus_setup.c                    |    2 
 arch/ppc/platforms/chestnut.c                      |    2 
 arch/ppc/platforms/chestnut.h                      |    2 
 arch/ppc/platforms/chrp_pegasos_eth.c              |    2 
 arch/ppc/platforms/chrp_setup.c                    |    2 
 arch/ppc/platforms/chrp_time.c                     |    2 
 arch/ppc/platforms/cpci690.c                       |    4 
 arch/ppc/platforms/cpci690.h                       |    2 
 arch/ppc/platforms/ev64260.c                       |    4 
 arch/ppc/platforms/ev64260.h                       |    2 
 arch/ppc/platforms/ev64360.c                       |    4 
 arch/ppc/platforms/ev64360.h                       |    2 
 arch/ppc/platforms/fads.h                          |    2 
 arch/ppc/platforms/gemini.h                        |    3 
 arch/ppc/platforms/gemini_prom.S                   |    2 
 arch/ppc/platforms/gemini_setup.c                  |    2 
 arch/ppc/platforms/hdpu.c                          |    5 
 arch/ppc/platforms/hdpu.h                          |    2 
 arch/ppc/platforms/katana.c                        |    7 
 arch/ppc/platforms/katana.h                        |    2 
 arch/ppc/platforms/lite5200.c                      |    2 
 arch/ppc/platforms/lite5200.h                      |    2 
 arch/ppc/platforms/lopec.c                         |    2 
 arch/ppc/platforms/mpc8272ads_setup.c              |  236 ++++++
 arch/ppc/platforms/mpc866ads_setup.c               |  273 +++++++
 arch/ppc/platforms/mpc885ads_setup.c               |  389 +++++++++++
 arch/ppc/platforms/mvme5100.c                      |    2 
 arch/ppc/platforms/pal4.h                          |    2 
 arch/ppc/platforms/pal4_pci.c                      |    2 
 arch/ppc/platforms/pal4_serial.h                   |    2 
 arch/ppc/platforms/pal4_setup.c                    |    2 
 arch/ppc/platforms/powerpmc250.c                   |    2 
 arch/ppc/platforms/pplus.c                         |    2 
 arch/ppc/platforms/pplus.h                         |    2 
 arch/ppc/platforms/pq2ads.c                        |    2 
 arch/ppc/platforms/pq2ads.h                        |    4 
 arch/ppc/platforms/pq2ads_pd.h                     |  114 +++
 arch/ppc/platforms/prep_setup.c                    |    2 
 arch/ppc/platforms/prpmc750.c                      |    2 
 arch/ppc/platforms/prpmc800.c                      |    2 
 arch/ppc/platforms/radstone_ppc7d.c                |    7 
 arch/ppc/platforms/radstone_ppc7d.h                |    2 
 arch/ppc/platforms/sandpoint.c                     |    2 
 arch/ppc/platforms/sandpoint.h                     |    2 
 arch/ppc/platforms/sbc82xx.c                       |    2 
 arch/ppc/platforms/spruce.c                        |    2 
 arch/ppc/platforms/tqm8260_setup.c                 |    2 
 arch/ppc/syslib/Makefile                           |    4 
 arch/ppc/syslib/cpc700.h                           |    2 
 arch/ppc/syslib/cpc700_pic.c                       |    2 
 arch/ppc/syslib/cpc710.h                           |    2 
 arch/ppc/syslib/gen550.h                           |    2 
 arch/ppc/syslib/gen550_dbg.c                       |    2 
 arch/ppc/syslib/gen550_kgdb.c                      |    2 
 arch/ppc/syslib/gt64260_pic.c                      |    2 
 arch/ppc/syslib/harrier.c                          |    2 
 arch/ppc/syslib/hawk_common.c                      |    2 
 arch/ppc/syslib/ibm440gp_common.c                  |    2 
 arch/ppc/syslib/ibm440gp_common.h                  |    2 
 arch/ppc/syslib/ibm440gx_common.c                  |    2 
 arch/ppc/syslib/ibm440gx_common.h                  |    2 
 arch/ppc/syslib/ibm440sp_common.c                  |    2 
 arch/ppc/syslib/ibm440sp_common.h                  |    2 
 arch/ppc/syslib/ibm44x_common.c                    |    2 
 arch/ppc/syslib/ibm44x_common.h                    |    2 
 arch/ppc/syslib/m8260_pci_erratum9.c               |    2 
 arch/ppc/syslib/m8260_setup.c                      |    2 
 arch/ppc/syslib/m8xx_setup.c                       |   65 ++
 arch/ppc/syslib/m8xx_wdt.c                         |    3 
 arch/ppc/syslib/mpc10x_common.c                    |    2 
 arch/ppc/syslib/mpc52xx_devices.c                  |    2 
 arch/ppc/syslib/mpc52xx_pci.c                      |    2 
 arch/ppc/syslib/mpc52xx_pci.h                      |    2 
 arch/ppc/syslib/mpc52xx_pic.c                      |    2 
 arch/ppc/syslib/mpc52xx_setup.c                    |    2 
 arch/ppc/syslib/mpc52xx_sys.c                      |    2 
 arch/ppc/syslib/mpc83xx_devices.c                  |    2 
 arch/ppc/syslib/mpc83xx_sys.c                      |    2 
 arch/ppc/syslib/mpc85xx_devices.c                  |    2 
 arch/ppc/syslib/mpc85xx_sys.c                      |    2 
 arch/ppc/syslib/mpc8xx_devices.c                   |    2 
 arch/ppc/syslib/mpc8xx_sys.c                       |    2 
 arch/ppc/syslib/mv64360_pic.c                      |    2 
 arch/ppc/syslib/mv64x60.c                          |    2 
 arch/ppc/syslib/mv64x60_dbg.c                      |    2 
 arch/ppc/syslib/mv64x60_win.c                      |    2 
 arch/ppc/syslib/ocp.c                              |    3 
 arch/ppc/syslib/open_pic.c                         |    2 
 arch/ppc/syslib/open_pic2.c                        |    2 
 arch/ppc/syslib/open_pic_defs.h                    |    2 
 arch/ppc/syslib/pci_auto.c                         |    2 
 arch/ppc/syslib/ppc4xx_dma.c                       |    2 
 arch/ppc/syslib/ppc4xx_pic.c                       |    2 
 arch/ppc/syslib/ppc4xx_pm.c                        |   47 -
 arch/ppc/syslib/ppc4xx_sgdma.c                     |    2 
 arch/ppc/syslib/ppc83xx_setup.c                    |    2 
 arch/ppc/syslib/ppc83xx_setup.h                    |    2 
 arch/ppc/syslib/ppc85xx_common.c                   |    2 
 arch/ppc/syslib/ppc85xx_common.h                   |    2 
 arch/ppc/syslib/ppc85xx_setup.c                    |    2 
 arch/ppc/syslib/ppc85xx_setup.h                    |    2 
 arch/ppc/syslib/ppc_sys.c                          |  179 +++++
 arch/ppc/syslib/pq2_devices.c                      |    2 
 arch/ppc/syslib/pq2_sys.c                          |    2 
 arch/ppc/syslib/prep_nvram.c                       |    2 
 arch/ppc/syslib/todc_time.c                        |    2 
 arch/ppc/syslib/xilinx_pic.c                       |    4 
 drivers/char/hvcs.c                                |    9 
 drivers/net/Kconfig                                |    1 
 include/asm-powerpc/atomic.h                       |   38 +
 include/asm-powerpc/cputable.h                     |   38 +
 include/asm-powerpc/cputime.h                      |  202 +++++
 include/asm-powerpc/firmware.h                     |   16 
 include/asm-powerpc/irq.h                          |    6 
 include/asm-powerpc/iseries/mf.h                   |    7 
 include/asm-powerpc/lmb.h                          |   19 -
 include/asm-powerpc/mmu.h                          |    1 
 include/asm-powerpc/paca.h                         |    7 
 include/asm-powerpc/pgtable-4k.h                   |   11 
 include/asm-powerpc/pgtable.h                      |    9 
 include/asm-powerpc/ppc_asm.h                      |   42 +
 include/asm-powerpc/processor.h                    |    1 
 include/asm-powerpc/prom.h                         |    6 
 include/asm-powerpc/rwsem.h                        |    2 
 include/asm-powerpc/synch.h                        |    2 
 include/asm-powerpc/system.h                       |    6 
 include/asm-powerpc/time.h                         |   15 
 include/asm-ppc/harrier.h                          |    2 
 include/asm-ppc/ibm44x.h                           |    2 
 include/asm-ppc/ibm4xx.h                           |    4 
 include/asm-ppc/io.h                               |    7 
 include/asm-ppc/mpc10x.h                           |    3 
 include/asm-ppc/mpc52xx.h                          |    1 
 include/asm-ppc/mpc8260.h                          |    1 
 include/asm-ppc/mpc83xx.h                          |    1 
 include/asm-ppc/mpc85xx.h                          |    1 
 include/asm-ppc/mpc8xx.h                           |    3 
 include/asm-ppc/pgtable.h                          |    6 
 include/asm-ppc/ppc_sys.h                          |   34 +
 include/asm-ppc/time.h                             |    5 
 include/asm-ppc/todc.h                             |    2 
 include/asm-ppc/xparameters.h                      |   18 
 kernel/auditsc.c                                   |    2 
 lib/extable.c                                      |    1 
 356 files changed, 6497 insertions(+), 1452 deletions(-)
 create mode 100644 arch/powerpc/configs/mpc8540_ads_defconfig
 create mode 100644 arch/powerpc/kernel/head_booke.h
 create mode 100644 arch/powerpc/platforms/83xx/misc.c
 create mode 100644 arch/powerpc/platforms/85xx/misc.c
 create mode 100644 arch/powerpc/platforms/85xx/mpc8540_ads.h
 create mode 100644 arch/powerpc/platforms/85xx/mpc85xx.h
 create mode 100644 arch/powerpc/platforms/85xx/mpc85xx_ads.c
 create mode 100644 arch/powerpc/platforms/85xx/pci.c
 create mode 100644 arch/powerpc/platforms/pseries/firmware.c
 create mode 100644 arch/powerpc/platforms/pseries/firmware.h
 create mode 100644 arch/ppc/configs/ml300_defconfig
 create mode 100644 arch/ppc/configs/ml403_defconfig
 delete mode 100644 arch/ppc/platforms/4xx/virtex-ii_pro.c
 delete mode 100644 arch/ppc/platforms/4xx/virtex-ii_pro.h
 create mode 100644 arch/ppc/platforms/4xx/virtex.c
 create mode 100644 arch/ppc/platforms/4xx/virtex.h
 create mode 100644 arch/ppc/platforms/4xx/xilinx_ml403.c
 create mode 100644 arch/ppc/platforms/4xx/xilinx_ml403.h
 create mode 100644 arch/ppc/platforms/4xx/xparameters/xparameters.h
 create mode 100644 arch/ppc/platforms/4xx/xparameters/xparameters_ml403.h
 create mode 100644 arch/ppc/platforms/mpc8272ads_setup.c
 create mode 100644 arch/ppc/platforms/mpc866ads_setup.c
 create mode 100644 arch/ppc/platforms/mpc885ads_setup.c
 create mode 100644 arch/ppc/platforms/pq2ads_pd.h
 delete mode 100644 arch/ppc/syslib/ppc4xx_pm.c
 delete mode 100644 include/asm-ppc/xparameters.h
