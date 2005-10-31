Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17253.39993.502458.390760@cargo.ozlabs.ibm.com>
Date: Mon, 31 Oct 2005 15:23:21 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: please pull the powerpc-merge.git tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please do a pull from:

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc-merge.git

to get a ppc/ppc64/powerpc update.

We are now a considerable way through the ppc/ppc64 -> powerpc merge.
It is now possible to build kernels for powermac, pSeries, iSeries and
maple with ARCH=powerpc, and for powermac, both 32-bit and 64-bit
build and run.  I have not yet put in the patch that makes it default
to ARCH=powerpc if uname -m gives ppc or ppc64, though.

Andrew sent me all of the patches he had queued that affected ppc and
ppc64, and I have merged in most of them (the rest I am discussing
with their authors).

Diffstat and shortlog follow.

Thanks,
Paul.

 arch/powerpc/Kconfig                           |  900 +++++++
 arch/powerpc/Kconfig.debug                     |  128 +
 arch/powerpc/Makefile                          |  222 ++
 arch/powerpc/kernel/Makefile                   |   56 
 arch/powerpc/kernel/asm-offsets.c              |  273 ++
 arch/powerpc/kernel/binfmt_elf32.c             |    3 
 arch/powerpc/kernel/btext.c                    |  853 +++++++
 arch/powerpc/kernel/cputable.c                 |  797 +++---
 arch/powerpc/kernel/entry_32.S                 | 1000 ++++++++
 arch/powerpc/kernel/entry_64.S                 |   47 
 arch/powerpc/kernel/fpu.S                      |  144 +
 arch/powerpc/kernel/head_32.S                  | 1381 +++++++++++
 arch/powerpc/kernel/head_44x.S                 |  782 ++++++
 arch/powerpc/kernel/head_4xx.S                 | 1022 ++++++++
 arch/powerpc/kernel/head_64.S                  | 1957 +++++++++++++++
 arch/powerpc/kernel/head_8xx.S                 |  860 +++++++
 arch/powerpc/kernel/head_fsl_booke.S           | 1063 ++++++++
 arch/powerpc/kernel/idle_6xx.S                 |  233 ++
 arch/powerpc/kernel/idle_power4.S              |    9 
 arch/powerpc/kernel/init_task.c                |    0 
 arch/powerpc/kernel/lparmap.c                  |    0 
 arch/powerpc/kernel/misc_32.S                  | 1037 ++++++++
 arch/powerpc/kernel/misc_64.S                  |  880 +++++++
 arch/powerpc/kernel/of_device.c                |    4 
 arch/powerpc/kernel/pmc.c                      |   30 
 arch/powerpc/kernel/ppc_ksyms.c                |  273 ++
 arch/powerpc/kernel/process.c                  |  486 +++-
 arch/powerpc/kernel/prom.c                     | 2170 +++++++++++++++++
 arch/powerpc/kernel/prom_init.c                | 2109 +++++++++++++++++
 arch/powerpc/kernel/ptrace.c                   |  170 +
 arch/powerpc/kernel/ptrace32.c                 |    9 
 arch/powerpc/kernel/rtas.c                     |  254 +-
 arch/powerpc/kernel/semaphore.c                |  135 +
 arch/powerpc/kernel/setup-common.c             |  410 +++
 arch/powerpc/kernel/setup_32.c                 |  372 +++
 arch/powerpc/kernel/setup_64.c                 |  352 ---
 arch/powerpc/kernel/signal_32.c                |  993 +++++---
 arch/powerpc/kernel/sys_ppc32.c                |  320 ---
 arch/powerpc/kernel/syscalls.c                 |  358 +++
 arch/powerpc/kernel/systbl.S                   |  321 +++
 arch/powerpc/kernel/time.c                     |  570 +++-
 arch/powerpc/kernel/traps.c                    | 1101 +++++++++
 arch/powerpc/kernel/vecemu.c                   |    0 
 arch/powerpc/kernel/vector.S                   |   71 -
 arch/powerpc/kernel/vio.c                      |   14 
 arch/powerpc/kernel/vmlinux.lds.S              |  279 ++
 arch/powerpc/lib/Makefile                      |   19 
 arch/powerpc/lib/checksum_32.S                 |  225 ++
 arch/powerpc/lib/checksum_64.S                 |    0 
 arch/powerpc/lib/copy_32.S                     |  543 ++++
 arch/powerpc/lib/copypage_64.S                 |    0 
 arch/powerpc/lib/copyuser_64.S                 |    0 
 arch/powerpc/lib/div64.S                       |   59 
 arch/powerpc/lib/e2a.c                         |    0 
 arch/powerpc/lib/locks.c                       |    5 
 arch/powerpc/lib/mem_64.S                      |  119 +
 arch/powerpc/lib/memcpy_64.S                   |    0 
 arch/powerpc/lib/rheap.c                       |  693 +++++
 arch/powerpc/lib/sstep.c                       |   17 
 arch/powerpc/lib/strcase.c                     |   23 
 arch/powerpc/lib/string.S                      |  198 ++
 arch/powerpc/lib/usercopy_64.c                 |    0 
 arch/powerpc/mm/44x_mmu.c                      |  120 +
 arch/powerpc/mm/4xx_mmu.c                      |  141 +
 arch/powerpc/mm/Makefile                       |   21 
 arch/powerpc/mm/fault.c                        |  104 +
 arch/powerpc/mm/fsl_booke_mmu.c                |  237 ++
 arch/powerpc/mm/hash_low_32.S                  |  618 +++++
 arch/powerpc/mm/hash_low_64.S                  |    2 
 arch/powerpc/mm/hash_native_64.c               |   13 
 arch/powerpc/mm/hash_utils_64.c                |   61 
 arch/powerpc/mm/hugetlbpage.c                  |    0 
 arch/powerpc/mm/imalloc.c                      |    0 
 arch/powerpc/mm/init_32.c                      |  254 ++
 arch/powerpc/mm/init_64.c                      |  223 ++
 arch/powerpc/mm/lmb.c                          |  105 -
 arch/powerpc/mm/mem.c                          |  564 ++++
 arch/powerpc/mm/mmap.c                         |    0 
 arch/powerpc/mm/mmu_context_32.c               |   86 +
 arch/powerpc/mm/mmu_context_64.c               |   63 
 arch/powerpc/mm/mmu_decl.h                     |   87 +
 arch/powerpc/mm/numa.c                         |    2 
 arch/powerpc/mm/pgtable_32.c                   |  467 ++++
 arch/powerpc/mm/pgtable_64.c                   |  347 +++
 arch/powerpc/mm/ppc_mmu_32.c                   |  285 ++
 arch/powerpc/mm/slb.c                          |    0 
 arch/powerpc/mm/slb_low.S                      |    0 
 arch/powerpc/mm/stab.c                         |    0 
 arch/powerpc/mm/tlb_32.c                       |  183 +
 arch/powerpc/mm/tlb_64.c                       |   23 
 arch/powerpc/oprofile/Kconfig                  |    0 
 arch/powerpc/oprofile/Makefile                 |    4 
 arch/powerpc/oprofile/common.c                 |   84 +
 arch/powerpc/oprofile/op_model_fsl_booke.c     |    7 
 arch/powerpc/oprofile/op_model_power4.c        |    2 
 arch/powerpc/oprofile/op_model_rs64.c          |    2 
 arch/powerpc/platforms/4xx/Kconfig             |  280 ++
 arch/powerpc/platforms/4xx/Makefile            |    1 
 arch/powerpc/platforms/85xx/Kconfig            |   86 +
 arch/powerpc/platforms/85xx/Makefile           |    1 
 arch/powerpc/platforms/8xx/Kconfig             |  352 +++
 arch/powerpc/platforms/Makefile                |   13 
 arch/powerpc/platforms/apus/Kconfig            |  130 +
 arch/powerpc/platforms/chrp/Makefile           |    4 
 arch/powerpc/platforms/chrp/chrp.h             |   12 
 arch/powerpc/platforms/chrp/nvram.c            |   84 +
 arch/powerpc/platforms/chrp/pci.c              |  310 ++
 arch/powerpc/platforms/chrp/pegasos_eth.c      |  213 ++
 arch/powerpc/platforms/chrp/setup.c            |  522 ++++
 arch/powerpc/platforms/chrp/smp.c              |  122 +
 arch/powerpc/platforms/chrp/time.c             |  188 +
 arch/powerpc/platforms/embedded6xx/Kconfig     |  318 ++
 arch/powerpc/platforms/iseries/Kconfig         |   31 
 arch/powerpc/platforms/iseries/Makefile        |    9 
 arch/powerpc/platforms/iseries/call_hpt.h      |    7 
 arch/powerpc/platforms/iseries/call_pci.h      |  290 ++
 arch/powerpc/platforms/iseries/call_sm.h       |    7 
 arch/powerpc/platforms/iseries/htab.c          |   47 
 arch/powerpc/platforms/iseries/hvcall.S        |   22 
 arch/powerpc/platforms/iseries/hvlog.c         |    1 
 arch/powerpc/platforms/iseries/hvlpconfig.c    |    1 
 arch/powerpc/platforms/iseries/iommu.c         |   42 
 arch/powerpc/platforms/iseries/ipl_parms.h     |    7 
 arch/powerpc/platforms/iseries/irq.c           |   17 
 arch/powerpc/platforms/iseries/irq.h           |    8 
 arch/powerpc/platforms/iseries/ksyms.c         |   27 
 arch/powerpc/platforms/iseries/lpardata.c      |   28 
 arch/powerpc/platforms/iseries/lpevents.c      |   77 +
 arch/powerpc/platforms/iseries/main_store.h    |    7 
 arch/powerpc/platforms/iseries/mf.c            |   98 +
 arch/powerpc/platforms/iseries/misc.S          |   55 
 arch/powerpc/platforms/iseries/pci.c           |  173 +
 arch/powerpc/platforms/iseries/pci.h           |   63 
 arch/powerpc/platforms/iseries/proc.c          |   15 
 arch/powerpc/platforms/iseries/processor_vpd.h |    7 
 arch/powerpc/platforms/iseries/release_data.h  |    7 
 arch/powerpc/platforms/iseries/setup.c         |  501 ++--
 arch/powerpc/platforms/iseries/setup.h         |    4 
 arch/powerpc/platforms/iseries/smp.c           |   46 
 arch/powerpc/platforms/iseries/spcomm_area.h   |    7 
 arch/powerpc/platforms/iseries/vio.c           |    1 
 arch/powerpc/platforms/iseries/viopath.c       |    3 
 arch/powerpc/platforms/iseries/vpd_areas.h     |    7 
 arch/powerpc/platforms/iseries/vpdinfo.c       |   21 
 arch/powerpc/platforms/maple/Makefile          |    1 
 arch/powerpc/platforms/maple/maple.h           |   12 
 arch/powerpc/platforms/maple/pci.c             |    7 
 arch/powerpc/platforms/maple/setup.c           |   13 
 arch/powerpc/platforms/maple/time.c            |    9 
 arch/powerpc/platforms/powermac/Makefile       |    8 
 arch/powerpc/platforms/powermac/backlight.c    |  202 ++
 arch/powerpc/platforms/powermac/cache.S        |  359 +++
 arch/powerpc/platforms/powermac/cpufreq.c      |  726 ++++++
 arch/powerpc/platforms/powermac/feature.c      | 3063 ++++++++++++++++++++++++
 arch/powerpc/platforms/powermac/low_i2c.c      |    0 
 arch/powerpc/platforms/powermac/nvram.c        |  282 ++
 arch/powerpc/platforms/powermac/pci.c          | 1170 +++++++++
 arch/powerpc/platforms/powermac/pic.c          |  678 +++++
 arch/powerpc/platforms/powermac/pic.h          |   11 
 arch/powerpc/platforms/powermac/pmac.h         |   51 
 arch/powerpc/platforms/powermac/setup.c        |  794 ++++++
 arch/powerpc/platforms/powermac/sleep.S        |  396 +++
 arch/powerpc/platforms/powermac/smp.c          |  865 +++++++
 arch/powerpc/platforms/powermac/time.c         |  360 +++
 arch/powerpc/platforms/prep/Kconfig            |   22 
 arch/powerpc/platforms/pseries/Kconfig         |   42 
 arch/powerpc/platforms/pseries/Makefile        |    5 
 arch/powerpc/platforms/pseries/hvCall.S        |    0 
 arch/powerpc/platforms/pseries/iommu.c         |   28 
 arch/powerpc/platforms/pseries/lpar.c          |    5 
 arch/powerpc/platforms/pseries/nvram.c         |    0 
 arch/powerpc/platforms/pseries/pci.c           |    3 
 arch/powerpc/platforms/pseries/ras.c           |   11 
 arch/powerpc/platforms/pseries/reconfig.c      |    0 
 arch/powerpc/platforms/pseries/rtas-fw.c       |  138 +
 arch/powerpc/platforms/pseries/rtas-fw.h       |    3 
 arch/powerpc/platforms/pseries/setup.c         |   57 
 arch/powerpc/platforms/pseries/smp.c           |   52 
 arch/powerpc/platforms/pseries/vio.c           |    1 
 arch/powerpc/platforms/pseries/xics.c          |   30 
 arch/powerpc/platforms/pseries/xics.h          |   10 
 arch/powerpc/sysdev/Makefile                   |    7 
 arch/powerpc/sysdev/dcr.S                      |    0 
 arch/powerpc/sysdev/grackle.c                  |   64 +
 arch/powerpc/sysdev/i8259.c                    |   65 -
 arch/powerpc/sysdev/indirect_pci.c             |    0 
 arch/powerpc/sysdev/mpic.c                     |   53 
 arch/powerpc/sysdev/u3_iommu.c                 |   50 
 arch/powerpc/xmon/Makefile                     |   11 
 arch/powerpc/xmon/ansidecl.h                   |    0 
 arch/powerpc/xmon/nonstdio.h                   |    0 
 arch/powerpc/xmon/ppc-dis.c                    |    0 
 arch/powerpc/xmon/ppc-opc.c                    |    0 
 arch/powerpc/xmon/ppc.h                        |    0 
 arch/powerpc/xmon/setjmp.S                     |  135 +
 arch/powerpc/xmon/start_32.c                   |  624 +++++
 arch/powerpc/xmon/start_64.c                   |    0 
 arch/powerpc/xmon/start_8xx.c                  |  287 ++
 arch/powerpc/xmon/subr_prf.c                   |   11 
 arch/powerpc/xmon/xmon.c                       |  395 ++-
 arch/ppc/8xx_io/commproc.c                     |   20 
 arch/ppc/Kconfig                               |   40 
 arch/ppc/Makefile                              |   14 
 arch/ppc/boot/of1275/claim.c                   |    1 
 arch/ppc/boot/openfirmware/chrpmain.c          |    2 
 arch/ppc/boot/openfirmware/coffmain.c          |    2 
 arch/ppc/kernel/Makefile                       |   27 
 arch/ppc/kernel/align.c                        |    4 
 arch/ppc/kernel/asm-offsets.c                  |    3 
 arch/ppc/kernel/cpu_setup_6xx.S                |    6 
 arch/ppc/kernel/cpu_setup_power4.S             |    6 
 arch/ppc/kernel/entry.S                        |   12 
 arch/ppc/kernel/fpu.S                          |  133 -
 arch/ppc/kernel/head.S                         |  100 -
 arch/ppc/kernel/head_44x.S                     |   32 
 arch/ppc/kernel/head_4xx.S                     |   68 -
 arch/ppc/kernel/head_8xx.S                     |   42 
 arch/ppc/kernel/head_booke.h                   |    4 
 arch/ppc/kernel/head_fsl_booke.S               |   47 
 arch/ppc/kernel/idle.c                         |    3 
 arch/ppc/kernel/irq.c                          |    1 
 arch/ppc/kernel/l2cr.S                         |    2 
 arch/ppc/kernel/misc.S                         |  235 --
 arch/ppc/kernel/pci.c                          |   33 
 arch/ppc/kernel/perfmon.c                      |   96 -
 arch/ppc/kernel/perfmon_fsl_booke.c            |    2 
 arch/ppc/kernel/ppc_ksyms.c                    |   34 
 arch/ppc/kernel/process.c                      |  142 +
 arch/ppc/kernel/setup.c                        |   39 
 arch/ppc/kernel/signal.c                       |  771 ------
 arch/ppc/kernel/smp.c                          |   22 
 arch/ppc/kernel/syscalls.c                     |  268 --
 arch/ppc/kernel/time.c                         |    9 
 arch/ppc/kernel/traps.c                        |   42 
 arch/ppc/kernel/vector.S                       |  217 --
 arch/ppc/kernel/vmlinux.lds.S                  |   26 
 arch/ppc/lib/string.S                          |   24 
 arch/ppc/math-emu/sfp-machine.h                |    2 
 arch/ppc/mm/init.c                             |   23 
 arch/ppc/oprofile/Makefile                     |   14 
 arch/ppc/oprofile/common.c                     |  161 -
 arch/ppc/oprofile/op_impl.h                    |   45 
 arch/ppc/platforms/4xx/bamboo.c                |   14 
 arch/ppc/platforms/4xx/ebony.c                 |   15 
 arch/ppc/platforms/4xx/luan.c                  |   13 
 arch/ppc/platforms/4xx/ocotea.c                |   31 
 arch/ppc/platforms/83xx/mpc834x_sys.h          |    1 
 arch/ppc/platforms/85xx/mpc8540_ads.c          |   30 
 arch/ppc/platforms/85xx/mpc8560_ads.c          |   25 
 arch/ppc/platforms/85xx/mpc85xx_ads_common.h   |    1 
 arch/ppc/platforms/85xx/mpc85xx_cds_common.c   |   39 
 arch/ppc/platforms/85xx/sbc8560.c              |   22 
 arch/ppc/platforms/85xx/stx_gp3.c              |   21 
 arch/ppc/platforms/85xx/stx_gp3.h              |    1 
 arch/ppc/platforms/Makefile                    |    3 
 arch/ppc/platforms/chestnut.c                  |    1 
 arch/ppc/platforms/chrp_nvram.c                |   83 +
 arch/ppc/platforms/chrp_pci.c                  |   10 
 arch/ppc/platforms/chrp_pegasos_eth.c          |  124 +
 arch/ppc/platforms/chrp_setup.c                |   33 
 arch/ppc/platforms/chrp_smp.c                  |    3 
 arch/ppc/platforms/chrp_time.c                 |    8 
 arch/ppc/platforms/ev64360.c                   |    1 
 arch/ppc/platforms/fads.h                      |    2 
 arch/ppc/platforms/gemini_setup.c              |    4 
 arch/ppc/platforms/hdpu.c                      |    4 
 arch/ppc/platforms/katana.c                    |    3 
 arch/ppc/platforms/lite5200.c                  |    1 
 arch/ppc/platforms/lopec.c                     |   17 
 arch/ppc/platforms/mpc885ads.h                 |    2 
 arch/ppc/platforms/mvme5100.c                  |    6 
 arch/ppc/platforms/pal4_setup.c                |    1 
 arch/ppc/platforms/pmac_backlight.c            |   16 
 arch/ppc/platforms/pmac_cpufreq.c              |   36 
 arch/ppc/platforms/pmac_feature.c              |  176 +
 arch/ppc/platforms/pmac_nvram.c                |   42 
 arch/ppc/platforms/pmac_pci.c                  |   28 
 arch/ppc/platforms/pmac_pic.c                  |   27 
 arch/ppc/platforms/pmac_setup.c                |   19 
 arch/ppc/platforms/pmac_sleep.S                |    4 
 arch/ppc/platforms/pmac_smp.c                  |   11 
 arch/ppc/platforms/pmac_time.c                 |    8 
 arch/ppc/platforms/pplus.c                     |   17 
 arch/ppc/platforms/prep_pci.c                  |   64 -
 arch/ppc/platforms/prep_setup.c                |   70 -
 arch/ppc/platforms/radstone_ppc7d.c            |   15 
 arch/ppc/platforms/residual.c                  |    2 
 arch/ppc/platforms/sandpoint.c                 |   21 
 arch/ppc/syslib/Makefile                       |   57 
 arch/ppc/syslib/btext.c                        |    6 
 arch/ppc/syslib/gt64260_pic.c                  |    1 
 arch/ppc/syslib/ibm440gx_common.c              |    6 
 arch/ppc/syslib/ibm44x_common.c                |   37 
 arch/ppc/syslib/ibm44x_common.h                |    3 
 arch/ppc/syslib/m8260_setup.c                  |    4 
 arch/ppc/syslib/m82xx_pci.c                    |    4 
 arch/ppc/syslib/m8xx_setup.c                   |   48 
 arch/ppc/syslib/m8xx_wdt.c                     |   14 
 arch/ppc/syslib/mpc52xx_pci.c                  |    3 
 arch/ppc/syslib/mpc83xx_devices.c              |    1 
 arch/ppc/syslib/mpc85xx_devices.c              |   17 
 arch/ppc/syslib/mpc85xx_sys.c                  |   44 
 arch/ppc/syslib/mpc8xx_sys.c                   |    4 
 arch/ppc/syslib/mv64360_pic.c                  |    1 
 arch/ppc/syslib/mv64x60.c                      |    2 
 arch/ppc/syslib/mv64x60_dbg.c                  |    1 
 arch/ppc/syslib/of_device.c                    |  278 --
 arch/ppc/syslib/open_pic.c                     |    3 
 arch/ppc/syslib/open_pic2.c                    |    1 
 arch/ppc/syslib/ppc403_pic.c                   |    1 
 arch/ppc/syslib/ppc4xx_pic.c                   |    1 
 arch/ppc/syslib/ppc4xx_setup.c                 |    2 
 arch/ppc/syslib/ppc83xx_setup.c                |    1 
 arch/ppc/syslib/ppc85xx_setup.c                |    1 
 arch/ppc/syslib/ppc8xx_pic.c                   |   17 
 arch/ppc/syslib/ppc_sys.c                      |    3 
 arch/ppc/syslib/pq2_devices.c                  |    1 
 arch/ppc/syslib/prep_nvram.c                   |   13 
 arch/ppc/syslib/prom.c                         |   18 
 arch/ppc/syslib/xilinx_pic.c                   |    1 
 arch/ppc/xmon/start.c                          |    3 
 arch/ppc/xmon/xmon.c                           |    9 
 arch/ppc64/Kconfig                             |   33 
 arch/ppc64/Makefile                            |   18 
 arch/ppc64/boot/Makefile                       |   67 -
 arch/ppc64/boot/crt0.S                         |   53 
 arch/ppc64/boot/install.sh                     |    2 
 arch/ppc64/boot/main.c                         |  268 +-
 arch/ppc64/boot/string.S                       |    4 
 arch/ppc64/boot/string.h                       |    1 
 arch/ppc64/boot/zImage.lds                     |   64 -
 arch/ppc64/boot/zlib.c                         | 2195 -----------------
 arch/ppc64/boot/zlib.h                         |  432 ---
 arch/ppc64/defconfig                           |    4 
 arch/ppc64/kernel/HvLpEvent.c                  |   88 -
 arch/ppc64/kernel/Makefile                     |   77 -
 arch/ppc64/kernel/align.c                      |    4 
 arch/ppc64/kernel/asm-offsets.c                |    3 
 arch/ppc64/kernel/bpa_iommu.c                  |    2 
 arch/ppc64/kernel/bpa_setup.c                  |    7 
 arch/ppc64/kernel/btext.c                      |   42 
 arch/ppc64/kernel/cputable.c                   |  308 --
 arch/ppc64/kernel/eeh.c                        |    2 
 arch/ppc64/kernel/head.S                       |  290 +-
 arch/ppc64/kernel/i8259.c                      |  177 -
 arch/ppc64/kernel/i8259.h                      |   17 
 arch/ppc64/kernel/idle.c                       |    8 
 arch/ppc64/kernel/kprobes.c                    |    1 
 arch/ppc64/kernel/misc.S                       |  662 -----
 arch/ppc64/kernel/pci.c                        |   46 
 arch/ppc64/kernel/pci_direct_iommu.c           |    3 
 arch/ppc64/kernel/pci_dn.c                     |    3 
 arch/ppc64/kernel/pci_iommu.c                  |   21 
 arch/ppc64/kernel/pmac.h                       |   31 
 arch/ppc64/kernel/pmac_feature.c               |  767 ------
 arch/ppc64/kernel/pmac_pci.c                   |  793 ------
 arch/ppc64/kernel/pmac_setup.c                 |  525 ----
 arch/ppc64/kernel/pmac_smp.c                   |  330 ---
 arch/ppc64/kernel/pmac_time.c                  |  195 --
 arch/ppc64/kernel/ppc_ksyms.c                  |   20 
 arch/ppc64/kernel/prom.c                       |    7 
 arch/ppc64/kernel/prom_init.c                  |    1 
 arch/ppc64/kernel/ptrace.c                     |  363 ---
 arch/ppc64/kernel/rtas-proc.c                  |    1 
 arch/ppc64/kernel/rtas_pci.c                   |    9 
 arch/ppc64/kernel/rtc.c                        |   48 
 arch/ppc64/kernel/signal.c                     |    2 
 arch/ppc64/kernel/smp.c                        |   40 
 arch/ppc64/kernel/syscalls.c                   |  263 --
 arch/ppc64/kernel/traps.c                      |  568 ----
 arch/ppc64/kernel/vdso64/sigtramp.S            |    1 
 arch/ppc64/kernel/vecemu.c                     |  346 ---
 arch/ppc64/kernel/vmlinux.lds.S                |   17 
 arch/ppc64/lib/Makefile                        |   15 
 arch/ppc64/lib/strcase.c                       |   31 
 arch/ppc64/lib/string.S                        |  106 -
 arch/ppc64/mm/Makefile                         |   11 
 arch/ppc64/mm/init.c                           |  950 -------
 arch/ppc64/oprofile/Kconfig                    |   23 
 arch/ppc64/xmon/Makefile                       |    5 
 arch/ppc64/xmon/setjmp.S                       |   73 -
 drivers/block/viodasd.c                        |    9 
 drivers/cdrom/viocd.c                          |    9 
 drivers/char/hvc_vio.c                         |    2 
 drivers/char/hvcs.c                            |    5 
 drivers/char/mem.c                             |    4 
 drivers/char/viotape.c                         |    9 
 drivers/ide/ppc/pmac.c                         |   80 -
 drivers/macintosh/ans-lcd.c                    |   10 
 drivers/macintosh/apm_emu.c                    |    8 
 drivers/macintosh/macio_sysfs.c                |   26 
 drivers/macintosh/mediabay.c                   |   56 
 drivers/macintosh/smu.c                        |    4 
 drivers/macintosh/via-cuda.c                   |    1 
 drivers/macintosh/via-pmu.c                    |  142 +
 drivers/macintosh/via-pmu68k.c                 |   15 
 drivers/net/bmac.c                             |    1 
 drivers/net/ibmveth.c                          |   14 
 drivers/net/iseries_veth.c                     |   18 
 drivers/net/mace.c                             |    1 
 drivers/net/mv643xx_eth.c                      |    3 
 drivers/pcmcia/Kconfig                         |   10 
 drivers/pcmcia/Makefile                        |    1 
 drivers/pcmcia/m8xx_pcmcia.c                   | 1290 ++++++++++
 drivers/scsi/ibmvscsi/ibmvscsi.c               |    9 
 drivers/video/fbmem.c                          |    2 
 fs/proc/proc_misc.c                            |    8 
 include/asm-powerpc/a.out.h                    |   36 
 include/asm-powerpc/atomic.h                   |   45 
 include/asm-powerpc/auxvec.h                   |    8 
 include/asm-powerpc/backlight.h                |    9 
 include/asm-powerpc/bug.h                      |   81 +
 include/asm-powerpc/byteorder.h                |   11 
 include/asm-powerpc/checksum.h                 |   47 
 include/asm-powerpc/cputable.h                 |  427 +++
 include/asm-powerpc/dbdma.h                    |    0 
 include/asm-powerpc/dma.h                      |   91 -
 include/asm-powerpc/elf.h                      |   96 -
 include/asm-powerpc/firmware.h                 |   10 
 include/asm-powerpc/grackle.h                  |    7 
 include/asm-powerpc/hardirq.h                  |   16 
 include/asm-powerpc/heathrow.h                 |    0 
 include/asm-powerpc/hw_irq.h                   |  114 +
 include/asm-powerpc/i8259.h                    |   12 
 include/asm-powerpc/iommu.h                    |   41 
 include/asm-powerpc/irq.h                      |  168 +
 include/asm-powerpc/kdebug.h                   |   11 
 include/asm-powerpc/keylargo.h                 |    0 
 include/asm-powerpc/kmap_types.h               |   33 
 include/asm-powerpc/kprobes.h                  |    7 
 include/asm-powerpc/lmb.h                      |    2 
 include/asm-powerpc/machdep.h                  |  284 ++
 include/asm-powerpc/macio.h                    |    0 
 include/asm-powerpc/mediabay.h                 |    0 
 include/asm-powerpc/mpic.h                     |   14 
 include/asm-powerpc/of_device.h                |    7 
 include/asm-powerpc/ohare.h                    |    0 
 include/asm-powerpc/oprofile_impl.h            |   24 
 include/asm-powerpc/pSeries_reconfig.h         |    0 
 include/asm-powerpc/parport.h                  |    6 
 include/asm-powerpc/pmac_feature.h             |    0 
 include/asm-powerpc/pmac_low_i2c.h             |    0 
 include/asm-powerpc/pmc.h                      |   46 
 include/asm-powerpc/posix_types.h              |   40 
 include/asm-powerpc/ppc-pci.h                  |    6 
 include/asm-powerpc/ppc_asm.h                  |  511 ++++
 include/asm-powerpc/processor.h                |  281 ++
 include/asm-powerpc/prom.h                     |  219 ++
 include/asm-powerpc/reg.h                      |  297 ++
 include/asm-powerpc/rtas.h                     |    8 
 include/asm-powerpc/rtc.h                      |   78 +
 include/asm-powerpc/rwsem.h                    |   18 
 include/asm-powerpc/scatterlist.h              |   45 
 include/asm-powerpc/seccomp.h                  |   11 
 include/asm-powerpc/sections.h                 |   20 
 include/asm-powerpc/semaphore.h                |    6 
 include/asm-powerpc/smu.h                      |    0 
 include/asm-powerpc/spinlock_types.h           |    4 
 include/asm-powerpc/sstep.h                    |    4 
 include/asm-powerpc/statfs.h                   |   60 
 include/asm-powerpc/synch.h                    |   51 
 include/asm-powerpc/system.h                   |  363 +++
 include/asm-powerpc/thread_info.h              |   59 
 include/asm-powerpc/time.h                     |  226 ++
 include/asm-powerpc/types.h                    |   37 
 include/asm-powerpc/uninorth.h                 |    0 
 include/asm-powerpc/unistd.h                   |   91 -
 include/asm-powerpc/vga.h                      |   22 
 include/asm-powerpc/vio.h                      |   22 
 include/asm-powerpc/xmon.h                     |   12 
 include/asm-ppc/a.out.h                        |   26 
 include/asm-ppc/auxvec.h                       |   14 
 include/asm-ppc/bug.h                          |   58 
 include/asm-ppc/byteorder.h                    |   76 -
 include/asm-ppc/cache.h                        |   13 
 include/asm-ppc/checksum.h                     |  107 -
 include/asm-ppc/cpm2.h                         |    3 
 include/asm-ppc/cputable.h                     |  129 -
 include/asm-ppc/elf.h                          |  151 -
 include/asm-ppc/hw_irq.h                       |   74 -
 include/asm-ppc/i8259.h                        |   11 
 include/asm-ppc/io.h                           |   11 
 include/asm-ppc/kmap_types.h                   |   25 
 include/asm-ppc/machdep.h                      |    4 
 include/asm-ppc/mmu_context.h                  |    6 
 include/asm-ppc/mpc8260.h                      |    4 
 include/asm-ppc/mpc85xx.h                      |    3 
 include/asm-ppc/mpc8xx.h                       |    4 
 include/asm-ppc/open_pic.h                     |    3 
 include/asm-ppc/page.h                         |   18 
 include/asm-ppc/parport.h                      |   18 
 include/asm-ppc/pci-bridge.h                   |    5 
 include/asm-ppc/pci.h                          |    6 
 include/asm-ppc/perfmon.h                      |   22 
 include/asm-ppc/pgtable.h                      |    2 
 include/asm-ppc/posix_types.h                  |  111 -
 include/asm-ppc/ppc_asm.h                      |  350 ---
 include/asm-ppc/processor.h                    |  201 --
 include/asm-ppc/ptrace.h                       |    2 
 include/asm-ppc/rwsem.h                        |  177 -
 include/asm-ppc/scatterlist.h                  |   25 
 include/asm-ppc/seccomp.h                      |   10 
 include/asm-ppc/sections.h                     |   33 
 include/asm-ppc/semaphore.h                    |  108 -
 include/asm-ppc/smp.h                          |   28 
 include/asm-ppc/spinlock.h                     |    8 
 include/asm-ppc/spinlock_types.h               |   20 
 include/asm-ppc/statfs.h                       |    8 
 include/asm-ppc/system.h                       |   28 
 include/asm-ppc/thread_info.h                  |  107 -
 include/asm-ppc/types.h                        |   69 -
 include/asm-ppc/xmon.h                         |   17 
 include/asm-ppc64/a.out.h                      |   39 
 include/asm-ppc64/abs_addr.h                   |    7 
 include/asm-ppc64/atomic.h                     |  197 --
 include/asm-ppc64/bitops.h                     |    2 
 include/asm-ppc64/bootinfo.h                   |   70 -
 include/asm-ppc64/btext.h                      |    1 
 include/asm-ppc64/bug.h                        |   69 -
 include/asm-ppc64/cputable.h                   |  167 -
 include/asm-ppc64/dart.h                       |   59 
 include/asm-ppc64/dbdma.h                      |    2 
 include/asm-ppc64/dma.h                        |  329 ---
 include/asm-ppc64/futex.h                      |    2 
 include/asm-ppc64/hardirq.h                    |   27 
 include/asm-ppc64/hw_irq.h                     |  104 -
 include/asm-ppc64/iSeries/HvCallPci.h          |  533 ----
 include/asm-ppc64/iSeries/iSeries_irq.h        |    8 
 include/asm-ppc64/iSeries/iSeries_pci.h        |   88 -
 include/asm-ppc64/io.h                         |    2 
 include/asm-ppc64/irq.h                        |  120 -
 include/asm-ppc64/keylargo.h                   |    2 
 include/asm-ppc64/kmap_types.h                 |   23 
 include/asm-ppc64/machdep.h                    |  185 -
 include/asm-ppc64/macio.h                      |    2 
 include/asm-ppc64/memory.h                     |   61 
 include/asm-ppc64/mmu.h                        |    7 
 include/asm-ppc64/of_device.h                  |    2 
 include/asm-ppc64/page.h                       |    8 
 include/asm-ppc64/pci-bridge.h                 |   22 
 include/asm-ppc64/pci.h                        |    2 
 include/asm-ppc64/pgtable.h                    |    2 
 include/asm-ppc64/pmac_feature.h               |    2 
 include/asm-ppc64/pmac_low_i2c.h               |    2 
 include/asm-ppc64/pmc.h                        |   31 
 include/asm-ppc64/ppc32.h                      |   14 
 include/asm-ppc64/ppc_asm.h                    |  242 --
 include/asm-ppc64/processor.h                  |  558 ----
 include/asm-ppc64/prom.h                       |    4 
 include/asm-ppc64/scatterlist.h                |   31 
 include/asm-ppc64/sections.h                   |   29 
 include/asm-ppc64/smp.h                        |    1 
 include/asm-ppc64/statfs.h                     |   61 
 include/asm-ppc64/system.h                     |   20 
 include/asm-ppc64/tce.h                        |   64 +
 include/asm-ppc64/time.h                       |  124 -
 include/asm-ppc64/tlbflush.h                   |    7 
 include/asm-ppc64/udbg.h                       |    3 
 include/asm-ppc64/uninorth.h                   |    2 
 include/asm-ppc64/unistd.h                     |  486 ----
 include/asm-ppc64/vga.h                        |   50 
 include/linux/fsl_devices.h                    |   13 
 include/linux/zutil.h                          |    1 
 kernel/irq/handle.c                            |    6 
 lib/zlib_inflate/inflate.c                     |    1 
 565 files changed, 50073 insertions(+), 22537 deletions(-)
 create mode 100644 arch/powerpc/Kconfig
 create mode 100644 arch/powerpc/Kconfig.debug
 create mode 100644 arch/powerpc/Makefile
 create mode 100644 arch/powerpc/kernel/Makefile
 create mode 100644 arch/powerpc/kernel/asm-offsets.c
 rename arch/{ppc64/kernel/binfmt_elf32.c => powerpc/kernel/binfmt_elf32.c} (93%)
 create mode 100644 arch/powerpc/kernel/btext.c
 rename arch/{ppc/kernel/cputable.c => powerpc/kernel/cputable.c} (55%)
 create mode 100644 arch/powerpc/kernel/entry_32.S
 rename arch/{ppc64/kernel/entry.S => powerpc/kernel/entry_64.S} (96%)
 create mode 100644 arch/powerpc/kernel/fpu.S
 create mode 100644 arch/powerpc/kernel/head_32.S
 create mode 100644 arch/powerpc/kernel/head_44x.S
 create mode 100644 arch/powerpc/kernel/head_4xx.S
 create mode 100644 arch/powerpc/kernel/head_64.S
 create mode 100644 arch/powerpc/kernel/head_8xx.S
 create mode 100644 arch/powerpc/kernel/head_fsl_booke.S
 create mode 100644 arch/powerpc/kernel/idle_6xx.S
 rename arch/{ppc64/kernel/idle_power4.S => powerpc/kernel/idle_power4.S} (92%)
 rename arch/{ppc64/kernel/init_task.c => powerpc/kernel/init_task.c} (100%)
 rename arch/{ppc64/kernel/lparmap.c => powerpc/kernel/lparmap.c} (100%)
 create mode 100644 arch/powerpc/kernel/misc_32.S
 create mode 100644 arch/powerpc/kernel/misc_64.S
 rename arch/{ppc64/kernel/of_device.c => powerpc/kernel/of_device.c} (98%)
 rename arch/{ppc64/kernel/pmc.c => powerpc/kernel/pmc.c} (76%)
 create mode 100644 arch/powerpc/kernel/ppc_ksyms.c
 rename arch/{ppc64/kernel/process.c => powerpc/kernel/process.c} (58%)
 create mode 100644 arch/powerpc/kernel/prom.c
 create mode 100644 arch/powerpc/kernel/prom_init.c
 rename arch/{ppc/kernel/ptrace.c => powerpc/kernel/ptrace.c} (82%)
 rename arch/{ppc64/kernel/ptrace32.c => powerpc/kernel/ptrace32.c} (97%)
 rename arch/{ppc64/kernel/rtas.c => powerpc/kernel/rtas.c} (64%)
 create mode 100644 arch/powerpc/kernel/semaphore.c
 create mode 100644 arch/powerpc/kernel/setup-common.c
 create mode 100644 arch/powerpc/kernel/setup_32.c
 rename arch/{ppc64/kernel/setup.c => powerpc/kernel/setup_64.c} (70%)
 rename arch/{ppc64/kernel/signal32.c => powerpc/kernel/signal_32.c} (59%)
 rename arch/{ppc64/kernel/sys_ppc32.c => powerpc/kernel/sys_ppc32.c} (77%)
 create mode 100644 arch/powerpc/kernel/syscalls.c
 create mode 100644 arch/powerpc/kernel/systbl.S
 rename arch/{ppc64/kernel/time.c => powerpc/kernel/time.c} (61%)
 create mode 100644 arch/powerpc/kernel/traps.c
 rename arch/{ppc/kernel/vecemu.c => powerpc/kernel/vecemu.c} (100%)
 rename arch/{ppc64/kernel/vector.S => powerpc/kernel/vector.S} (63%)
 rename arch/{ppc64/kernel/vio.c => powerpc/kernel/vio.c} (100%)
 create mode 100644 arch/powerpc/kernel/vmlinux.lds.S
 create mode 100644 arch/powerpc/lib/Makefile
 create mode 100644 arch/powerpc/lib/checksum_32.S
 rename arch/{ppc64/lib/checksum.S => powerpc/lib/checksum_64.S} (100%)
 create mode 100644 arch/powerpc/lib/copy_32.S
 rename arch/{ppc64/lib/copypage.S => powerpc/lib/copypage_64.S} (100%)
 rename arch/{ppc64/lib/copyuser.S => powerpc/lib/copyuser_64.S} (100%)
 create mode 100644 arch/powerpc/lib/div64.S
 rename arch/{ppc64/lib/e2a.c => powerpc/lib/e2a.c} (100%)
 rename arch/{ppc64/lib/locks.c => powerpc/lib/locks.c} (98%)
 create mode 100644 arch/powerpc/lib/mem_64.S
 rename arch/{ppc64/lib/memcpy.S => powerpc/lib/memcpy_64.S} (100%)
 create mode 100644 arch/powerpc/lib/rheap.c
 rename arch/{ppc64/lib/sstep.c => powerpc/lib/sstep.c} (96%)
 create mode 100644 arch/powerpc/lib/strcase.c
 create mode 100644 arch/powerpc/lib/string.S
 rename arch/{ppc64/lib/usercopy.c => powerpc/lib/usercopy_64.c} (100%)
 create mode 100644 arch/powerpc/mm/44x_mmu.c
 create mode 100644 arch/powerpc/mm/4xx_mmu.c
 create mode 100644 arch/powerpc/mm/Makefile
 rename arch/{ppc64/mm/fault.c => powerpc/mm/fault.c} (68%)
 create mode 100644 arch/powerpc/mm/fsl_booke_mmu.c
 create mode 100644 arch/powerpc/mm/hash_low_32.S
 rename arch/{ppc64/mm/hash_low.S => powerpc/mm/hash_low_64.S} (100%)
 rename arch/{ppc64/mm/hash_native.c => powerpc/mm/hash_native_64.c} (97%)
 rename arch/{ppc64/mm/hash_utils.c => powerpc/mm/hash_utils_64.c} (90%)
 rename arch/{ppc64/mm/hugetlbpage.c => powerpc/mm/hugetlbpage.c} (100%)
 rename arch/{ppc64/mm/imalloc.c => powerpc/mm/imalloc.c} (100%)
 create mode 100644 arch/powerpc/mm/init_32.c
 create mode 100644 arch/powerpc/mm/init_64.c
 rename arch/{ppc64/kernel/lmb.c => powerpc/mm/lmb.c} (77%)
 create mode 100644 arch/powerpc/mm/mem.c
 rename arch/{ppc64/mm/mmap.c => powerpc/mm/mmap.c} (100%)
 create mode 100644 arch/powerpc/mm/mmu_context_32.c
 create mode 100644 arch/powerpc/mm/mmu_context_64.c
 create mode 100644 arch/powerpc/mm/mmu_decl.h
 rename arch/{ppc64/mm/numa.c => powerpc/mm/numa.c} (100%)
 create mode 100644 arch/powerpc/mm/pgtable_32.c
 create mode 100644 arch/powerpc/mm/pgtable_64.c
 create mode 100644 arch/powerpc/mm/ppc_mmu_32.c
 rename arch/{ppc64/mm/slb.c => powerpc/mm/slb.c} (100%)
 rename arch/{ppc64/mm/slb_low.S => powerpc/mm/slb_low.S} (100%)
 rename arch/{ppc64/mm/stab.c => powerpc/mm/stab.c} (100%)
 create mode 100644 arch/powerpc/mm/tlb_32.c
 rename arch/{ppc64/mm/tlb.c => powerpc/mm/tlb_64.c} (88%)
 rename arch/{ppc/oprofile/Kconfig => powerpc/oprofile/Kconfig} (100%)
 rename arch/{ppc64/oprofile/Makefile => powerpc/oprofile/Makefile} (63%)
 rename arch/{ppc64/oprofile/common.c => powerpc/oprofile/common.c} (54%)
 rename arch/{ppc/oprofile/op_model_fsl_booke.c => powerpc/oprofile/op_model_fsl_booke.c} (99%)
 rename arch/{ppc64/oprofile/op_model_power4.c => powerpc/oprofile/op_model_power4.c} (100%)
 rename arch/{ppc64/oprofile/op_model_rs64.c => powerpc/oprofile/op_model_rs64.c} (99%)
 create mode 100644 arch/powerpc/platforms/4xx/Kconfig
 create mode 100644 arch/powerpc/platforms/4xx/Makefile
 create mode 100644 arch/powerpc/platforms/85xx/Kconfig
 create mode 100644 arch/powerpc/platforms/85xx/Makefile
 create mode 100644 arch/powerpc/platforms/8xx/Kconfig
 create mode 100644 arch/powerpc/platforms/Makefile
 create mode 100644 arch/powerpc/platforms/apus/Kconfig
 create mode 100644 arch/powerpc/platforms/chrp/Makefile
 create mode 100644 arch/powerpc/platforms/chrp/chrp.h
 create mode 100644 arch/powerpc/platforms/chrp/nvram.c
 create mode 100644 arch/powerpc/platforms/chrp/pci.c
 create mode 100644 arch/powerpc/platforms/chrp/pegasos_eth.c
 create mode 100644 arch/powerpc/platforms/chrp/setup.c
 create mode 100644 arch/powerpc/platforms/chrp/smp.c
 create mode 100644 arch/powerpc/platforms/chrp/time.c
 create mode 100644 arch/powerpc/platforms/embedded6xx/Kconfig
 create mode 100644 arch/powerpc/platforms/iseries/Kconfig
 create mode 100644 arch/powerpc/platforms/iseries/Makefile
 rename include/asm-ppc64/iSeries/HvCallHpt.h => arch/powerpc/platforms/iseries/call_hpt.h (94%)
 create mode 100644 arch/powerpc/platforms/iseries/call_pci.h
 rename include/asm-ppc64/iSeries/HvCallSm.h => arch/powerpc/platforms/iseries/call_sm.h (89%)
 rename arch/{ppc64/kernel/iSeries_htab.c => powerpc/platforms/iseries/htab.c} (96%)
 rename arch/{ppc64/kernel/hvCall.S => powerpc/platforms/iseries/hvcall.S} (82%)
 rename arch/{ppc64/kernel/HvCall.c => powerpc/platforms/iseries/hvlog.c} (98%)
 rename arch/{ppc64/kernel/HvLpConfig.c => powerpc/platforms/iseries/hvlpconfig.c} (95%)
 rename arch/{ppc64/kernel/iSeries_iommu.c => powerpc/platforms/iseries/iommu.c} (86%)
 rename include/asm-ppc64/iSeries/ItIplParmsReal.h => arch/powerpc/platforms/iseries/ipl_parms.h (93%)
 rename arch/{ppc64/kernel/iSeries_irq.c => powerpc/platforms/iseries/irq.c} (97%)
 create mode 100644 arch/powerpc/platforms/iseries/irq.h
 create mode 100644 arch/powerpc/platforms/iseries/ksyms.c
 rename arch/{ppc64/kernel/LparData.c => powerpc/platforms/iseries/lpardata.c} (94%)
 rename arch/{ppc64/kernel/ItLpQueue.c => powerpc/platforms/iseries/lpevents.c} (74%)
 rename include/asm-ppc64/iSeries/IoHriMainStore.h => arch/powerpc/platforms/iseries/main_store.h (97%)
 rename arch/{ppc64/kernel/mf.c => powerpc/platforms/iseries/mf.c} (97%)
 create mode 100644 arch/powerpc/platforms/iseries/misc.S
 rename arch/{ppc64/kernel/iSeries_pci.c => powerpc/platforms/iseries/pci.c} (86%)
 create mode 100644 arch/powerpc/platforms/iseries/pci.h
 rename arch/{ppc64/kernel/iSeries_proc.c => powerpc/platforms/iseries/proc.c} (94%)
 rename include/asm-ppc64/iSeries/IoHriProcessorVpd.h => arch/powerpc/platforms/iseries/processor_vpd.h (94%)
 rename include/asm-ppc64/iSeries/HvReleaseData.h => arch/powerpc/platforms/iseries/release_data.h (92%)
 rename arch/{ppc64/kernel/iSeries_setup.c => powerpc/platforms/iseries/setup.c} (53%)
 rename arch/{ppc64/kernel/iSeries_setup.h => powerpc/platforms/iseries/setup.h} (86%)
 rename arch/{ppc64/kernel/iSeries_smp.c => powerpc/platforms/iseries/smp.c} (63%)
 rename include/asm-ppc64/iSeries/ItSpCommArea.h => arch/powerpc/platforms/iseries/spcomm_area.h (87%)
 rename arch/{ppc64/kernel/iSeries_vio.c => powerpc/platforms/iseries/vio.c} (100%)
 rename arch/{ppc64/kernel/viopath.c => powerpc/platforms/iseries/viopath.c} (100%)
 rename include/asm-ppc64/iSeries/ItVpdAreas.h => arch/powerpc/platforms/iseries/vpd_areas.h (95%)
 rename arch/{ppc64/kernel/iSeries_VpdInfo.c => powerpc/platforms/iseries/vpdinfo.c} (92%)
 create mode 100644 arch/powerpc/platforms/maple/Makefile
 create mode 100644 arch/powerpc/platforms/maple/maple.h
 rename arch/{ppc64/kernel/maple_pci.c => powerpc/platforms/maple/pci.c} (99%)
 rename arch/{ppc64/kernel/maple_setup.c => powerpc/platforms/maple/setup.c} (93%)
 rename arch/{ppc64/kernel/maple_time.c => powerpc/platforms/maple/time.c} (95%)
 create mode 100644 arch/powerpc/platforms/powermac/Makefile
 create mode 100644 arch/powerpc/platforms/powermac/backlight.c
 create mode 100644 arch/powerpc/platforms/powermac/cache.S
 create mode 100644 arch/powerpc/platforms/powermac/cpufreq.c
 create mode 100644 arch/powerpc/platforms/powermac/feature.c
 rename arch/{ppc64/kernel/pmac_low_i2c.c => powerpc/platforms/powermac/low_i2c.c} (100%)
 rename arch/{ppc64/kernel/pmac_nvram.c => powerpc/platforms/powermac/nvram.c} (51%)
 create mode 100644 arch/powerpc/platforms/powermac/pci.c
 create mode 100644 arch/powerpc/platforms/powermac/pic.c
 create mode 100644 arch/powerpc/platforms/powermac/pic.h
 create mode 100644 arch/powerpc/platforms/powermac/pmac.h
 create mode 100644 arch/powerpc/platforms/powermac/setup.c
 create mode 100644 arch/powerpc/platforms/powermac/sleep.S
 create mode 100644 arch/powerpc/platforms/powermac/smp.c
 create mode 100644 arch/powerpc/platforms/powermac/time.c
 create mode 100644 arch/powerpc/platforms/prep/Kconfig
 create mode 100644 arch/powerpc/platforms/pseries/Kconfig
 create mode 100644 arch/powerpc/platforms/pseries/Makefile
 rename arch/{ppc64/kernel/pSeries_hvCall.S => powerpc/platforms/pseries/hvCall.S} (100%)
 rename arch/{ppc64/kernel/pSeries_iommu.c => powerpc/platforms/pseries/iommu.c} (97%)
 rename arch/{ppc64/kernel/pSeries_lpar.c => powerpc/platforms/pseries/lpar.c} (99%)
 rename arch/{ppc64/kernel/pSeries_nvram.c => powerpc/platforms/pseries/nvram.c} (100%)
 rename arch/{ppc64/kernel/pSeries_pci.c => powerpc/platforms/pseries/pci.c} (99%)
 rename arch/{ppc64/kernel/ras.c => powerpc/platforms/pseries/ras.c} (99%)
 rename arch/{ppc64/kernel/pSeries_reconfig.c => powerpc/platforms/pseries/reconfig.c} (100%)
 create mode 100644 arch/powerpc/platforms/pseries/rtas-fw.c
 create mode 100644 arch/powerpc/platforms/pseries/rtas-fw.h
 rename arch/{ppc64/kernel/pSeries_setup.c => powerpc/platforms/pseries/setup.c} (93%)
 rename arch/{ppc64/kernel/pSeries_smp.c => powerpc/platforms/pseries/smp.c} (91%)
 rename arch/{ppc64/kernel/pSeries_vio.c => powerpc/platforms/pseries/vio.c} (100%)
 rename arch/{ppc64/kernel/xics.c => powerpc/platforms/pseries/xics.c} (98%)
 rename include/asm-ppc64/xics.h => arch/powerpc/platforms/pseries/xics.h (85%)
 create mode 100644 arch/powerpc/sysdev/Makefile
 rename arch/{ppc/syslib/dcr.S => powerpc/sysdev/dcr.S} (100%)
 create mode 100644 arch/powerpc/sysdev/grackle.c
 rename arch/{ppc/syslib/i8259.c => powerpc/sysdev/i8259.c} (78%)
 rename arch/{ppc/syslib/indirect_pci.c => powerpc/sysdev/indirect_pci.c} (100%)
 rename arch/{ppc64/kernel/mpic.c => powerpc/sysdev/mpic.c} (97%)
 rename arch/{ppc64/kernel/u3_iommu.c => powerpc/sysdev/u3_iommu.c} (89%)
 create mode 100644 arch/powerpc/xmon/Makefile
 rename arch/{ppc64/xmon/ansidecl.h => powerpc/xmon/ansidecl.h} (100%)
 rename arch/{ppc64/xmon/nonstdio.h => powerpc/xmon/nonstdio.h} (100%)
 rename arch/{ppc64/xmon/ppc-dis.c => powerpc/xmon/ppc-dis.c} (100%)
 rename arch/{ppc64/xmon/ppc-opc.c => powerpc/xmon/ppc-opc.c} (100%)
 rename arch/{ppc64/xmon/ppc.h => powerpc/xmon/ppc.h} (100%)
 create mode 100644 arch/powerpc/xmon/setjmp.S
 create mode 100644 arch/powerpc/xmon/start_32.c
 rename arch/{ppc64/xmon/start.c => powerpc/xmon/start_64.c} (100%)
 create mode 100644 arch/powerpc/xmon/start_8xx.c
 rename arch/{ppc64/xmon/subr_prf.c => powerpc/xmon/subr_prf.c} (92%)
 rename arch/{ppc64/xmon/xmon.c => powerpc/xmon/xmon.c} (87%)
 delete mode 100644 arch/ppc/kernel/fpu.S
 delete mode 100644 arch/ppc/kernel/perfmon.c
 delete mode 100644 arch/ppc/kernel/signal.c
 delete mode 100644 arch/ppc/kernel/syscalls.c
 delete mode 100644 arch/ppc/kernel/vector.S
 delete mode 100644 arch/ppc/oprofile/Makefile
 delete mode 100644 arch/ppc/oprofile/common.c
 delete mode 100644 arch/ppc/oprofile/op_impl.h
 create mode 100644 arch/ppc/platforms/chrp_nvram.c
 delete mode 100644 arch/ppc/syslib/of_device.c
 delete mode 100644 arch/ppc64/boot/zlib.c
 delete mode 100644 arch/ppc64/boot/zlib.h
 delete mode 100644 arch/ppc64/kernel/HvLpEvent.c
 delete mode 100644 arch/ppc64/kernel/cputable.c
 delete mode 100644 arch/ppc64/kernel/i8259.c
 delete mode 100644 arch/ppc64/kernel/i8259.h
 delete mode 100644 arch/ppc64/kernel/pmac.h
 delete mode 100644 arch/ppc64/kernel/pmac_feature.c
 delete mode 100644 arch/ppc64/kernel/pmac_pci.c
 delete mode 100644 arch/ppc64/kernel/pmac_setup.c
 delete mode 100644 arch/ppc64/kernel/pmac_smp.c
 delete mode 100644 arch/ppc64/kernel/pmac_time.c
 delete mode 100644 arch/ppc64/kernel/ptrace.c
 delete mode 100644 arch/ppc64/kernel/syscalls.c
 delete mode 100644 arch/ppc64/kernel/traps.c
 delete mode 100644 arch/ppc64/kernel/vecemu.c
 delete mode 100644 arch/ppc64/lib/strcase.c
 delete mode 100644 arch/ppc64/mm/Makefile
 delete mode 100644 arch/ppc64/mm/init.c
 delete mode 100644 arch/ppc64/oprofile/Kconfig
 delete mode 100644 arch/ppc64/xmon/Makefile
 delete mode 100644 arch/ppc64/xmon/setjmp.S
 create mode 100644 drivers/pcmcia/m8xx_pcmcia.c
 create mode 100644 include/asm-powerpc/a.out.h
 rename include/{asm-ppc/atomic.h => asm-powerpc/atomic.h} (76%)
 rename include/{asm-ppc64/auxvec.h => asm-powerpc/auxvec.h} (73%)
 rename include/{asm-ppc/backlight.h => asm-powerpc/backlight.h} (68%)
 create mode 100644 include/asm-powerpc/bug.h
 rename include/{asm-ppc64/byteorder.h => asm-powerpc/byteorder.h} (90%)
 rename include/{asm-ppc64/checksum.h => asm-powerpc/checksum.h} (78%)
 create mode 100644 include/asm-powerpc/cputable.h
 rename include/{asm-ppc/dbdma.h => asm-powerpc/dbdma.h} (100%)
 rename include/{asm-ppc/dma.h => asm-powerpc/dma.h} (90%)
 rename include/{asm-ppc64/elf.h => asm-powerpc/elf.h} (88%)
 rename include/{asm-ppc64/firmware.h => asm-powerpc/firmware.h} (94%)
 create mode 100644 include/asm-powerpc/grackle.h
 rename include/{asm-ppc/hardirq.h => asm-powerpc/hardirq.h} (61%)
 rename include/{asm-ppc/heathrow.h => asm-powerpc/heathrow.h} (100%)
 create mode 100644 include/asm-powerpc/hw_irq.h
 create mode 100644 include/asm-powerpc/i8259.h
 rename include/{asm-ppc64/iommu.h => asm-powerpc/iommu.h} (69%)
 rename include/{asm-ppc/irq.h => asm-powerpc/irq.h} (76%)
 rename include/{asm-ppc64/kdebug.h => asm-powerpc/kdebug.h} (80%)
 rename include/{asm-ppc/keylargo.h => asm-powerpc/keylargo.h} (100%)
 create mode 100644 include/asm-powerpc/kmap_types.h
 rename include/{asm-ppc64/kprobes.h => asm-powerpc/kprobes.h} (93%)
 rename include/{asm-ppc64/lmb.h => asm-powerpc/lmb.h} (100%)
 create mode 100644 include/asm-powerpc/machdep.h
 rename include/{asm-ppc/macio.h => asm-powerpc/macio.h} (100%)
 rename include/{asm-ppc/mediabay.h => asm-powerpc/mediabay.h} (100%)
 rename arch/ppc64/kernel/mpic.h => include/asm-powerpc/mpic.h (96%)
 rename include/{asm-ppc/of_device.h => asm-powerpc/of_device.h} (92%)
 rename include/{asm-ppc/ohare.h => asm-powerpc/ohare.h} (100%)
 rename include/{asm-ppc64/oprofile_impl.h => asm-powerpc/oprofile_impl.h} (73%)
 rename include/{asm-ppc64/pSeries_reconfig.h => asm-powerpc/pSeries_reconfig.h} (100%)
 rename include/{asm-ppc64/parport.h => asm-powerpc/parport.h} (84%)
 rename include/{asm-ppc/pmac_feature.h => asm-powerpc/pmac_feature.h} (100%)
 rename include/{asm-ppc/pmac_low_i2c.h => asm-powerpc/pmac_low_i2c.h} (100%)
 create mode 100644 include/asm-powerpc/pmc.h
 rename include/{asm-ppc64/posix_types.h => asm-powerpc/posix_types.h} (84%)
 rename arch/ppc64/kernel/pci.h => include/asm-powerpc/ppc-pci.h (90%)
 create mode 100644 include/asm-powerpc/ppc_asm.h
 create mode 100644 include/asm-powerpc/processor.h
 create mode 100644 include/asm-powerpc/prom.h
 rename include/{asm-ppc/reg.h => asm-powerpc/reg.h} (70%)
 rename include/{asm-ppc64/rtas.h => asm-powerpc/rtas.h} (98%)
 create mode 100644 include/asm-powerpc/rtc.h
 rename include/{asm-ppc64/rwsem.h => asm-powerpc/rwsem.h} (89%)
 create mode 100644 include/asm-powerpc/scatterlist.h
 rename include/{asm-ppc64/seccomp.h => asm-powerpc/seccomp.h} (59%)
 create mode 100644 include/asm-powerpc/sections.h
 rename include/{asm-ppc64/semaphore.h => asm-powerpc/semaphore.h} (94%)
 rename include/{asm-ppc64/smu.h => asm-powerpc/smu.h} (100%)
 rename include/{asm-ppc64/spinlock_types.h => asm-powerpc/spinlock_types.h} (79%)
 rename include/{asm-ppc64/sstep.h => asm-powerpc/sstep.h} (85%)
 create mode 100644 include/asm-powerpc/statfs.h
 create mode 100644 include/asm-powerpc/synch.h
 create mode 100644 include/asm-powerpc/system.h
 rename include/{asm-ppc64/thread_info.h => asm-powerpc/thread_info.h} (69%)
 create mode 100644 include/asm-powerpc/time.h
 rename include/{asm-ppc64/types.h => asm-powerpc/types.h} (63%)
 rename include/{asm-ppc/uninorth.h => asm-powerpc/uninorth.h} (100%)
 rename include/{asm-ppc/unistd.h => asm-powerpc/unistd.h} (89%)
 rename include/{asm-ppc/vga.h => asm-powerpc/vga.h} (60%)
 rename include/{asm-ppc64/vio.h => asm-powerpc/vio.h} (92%)
 create mode 100644 include/asm-powerpc/xmon.h
 delete mode 100644 include/asm-ppc/a.out.h
 delete mode 100644 include/asm-ppc/auxvec.h
 delete mode 100644 include/asm-ppc/bug.h
 delete mode 100644 include/asm-ppc/byteorder.h
 delete mode 100644 include/asm-ppc/checksum.h
 delete mode 100644 include/asm-ppc/cputable.h
 delete mode 100644 include/asm-ppc/elf.h
 delete mode 100644 include/asm-ppc/hw_irq.h
 delete mode 100644 include/asm-ppc/i8259.h
 delete mode 100644 include/asm-ppc/kmap_types.h
 delete mode 100644 include/asm-ppc/parport.h
 delete mode 100644 include/asm-ppc/perfmon.h
 delete mode 100644 include/asm-ppc/posix_types.h
 delete mode 100644 include/asm-ppc/ppc_asm.h
 delete mode 100644 include/asm-ppc/processor.h
 delete mode 100644 include/asm-ppc/rwsem.h
 delete mode 100644 include/asm-ppc/scatterlist.h
 delete mode 100644 include/asm-ppc/seccomp.h
 delete mode 100644 include/asm-ppc/sections.h
 delete mode 100644 include/asm-ppc/semaphore.h
 delete mode 100644 include/asm-ppc/spinlock_types.h
 delete mode 100644 include/asm-ppc/statfs.h
 delete mode 100644 include/asm-ppc/thread_info.h
 delete mode 100644 include/asm-ppc/types.h
 delete mode 100644 include/asm-ppc/xmon.h
 delete mode 100644 include/asm-ppc64/a.out.h
 delete mode 100644 include/asm-ppc64/atomic.h
 delete mode 100644 include/asm-ppc64/bootinfo.h
 delete mode 100644 include/asm-ppc64/bug.h
 delete mode 100644 include/asm-ppc64/cputable.h
 create mode 100644 include/asm-ppc64/dart.h
 delete mode 100644 include/asm-ppc64/dbdma.h
 delete mode 100644 include/asm-ppc64/dma.h
 delete mode 100644 include/asm-ppc64/hardirq.h
 delete mode 100644 include/asm-ppc64/hw_irq.h
 delete mode 100644 include/asm-ppc64/iSeries/HvCallPci.h
 delete mode 100644 include/asm-ppc64/iSeries/iSeries_irq.h
 delete mode 100644 include/asm-ppc64/iSeries/iSeries_pci.h
 delete mode 100644 include/asm-ppc64/irq.h
 delete mode 100644 include/asm-ppc64/keylargo.h
 delete mode 100644 include/asm-ppc64/kmap_types.h
 delete mode 100644 include/asm-ppc64/machdep.h
 delete mode 100644 include/asm-ppc64/macio.h
 delete mode 100644 include/asm-ppc64/memory.h
 delete mode 100644 include/asm-ppc64/of_device.h
 delete mode 100644 include/asm-ppc64/pmac_feature.h
 delete mode 100644 include/asm-ppc64/pmac_low_i2c.h
 delete mode 100644 include/asm-ppc64/pmc.h
 delete mode 100644 include/asm-ppc64/ppc_asm.h
 delete mode 100644 include/asm-ppc64/processor.h
 delete mode 100644 include/asm-ppc64/scatterlist.h
 delete mode 100644 include/asm-ppc64/sections.h
 delete mode 100644 include/asm-ppc64/statfs.h
 create mode 100644 include/asm-ppc64/tce.h
 delete mode 100644 include/asm-ppc64/time.h
 delete mode 100644 include/asm-ppc64/uninorth.h
 delete mode 100644 include/asm-ppc64/unistd.h
 delete mode 100644 include/asm-ppc64/vga.h

Andy Fleming:
      ppc32: 85xx PHY Platform Update

Andy Whitcroft:
      ppc64 memory model depends on NUMA

Becky Bruce:
      powerpc: Merge bug.h
      powerpc: Merge elf.h
      powerpc: merge atomic.h, memory.h
      powerpc: merge semaphore.h
      powerpc: merge byteorder.h
      powerpc: Merge types.h
      powerpc: Fix types.h
      ppc: Fix m82xx_pci build

Benjamin Herrenschmidt:
      ppc64: Store virtual address in TLB flush batches

David Gibson:
      powerpc: Fix use of LOADBASE in merge tree
      powerpc: Another maple merge tree fix
      powerpc: Merge ppc64 pmc.[ch] with ppc32 perfmon.[ch]
      Fix broken initialization of conswitchp for ARCH=ppc64
      powerpc: Merge thread_info.h
      powerpc: Fix handling of fpscr on 64-bit
      powerpc: Purge bootinfo.h
      powerpc: Merge parport.h
      powerpc: Don't use kmalloc() for kernel stacks
      powerpc: Remove dregs of bootinfo.h
      powerpc: Move xics.[ch] into platforms/pseries

jdl@freescale.com:
      powerpc: Merge asm-ppc*/posix_types.h

Jon Loeliger:
      powerpc: Merge kmap_types.h
      powerpc: Remove sections use from ppc
      powerpc: Remove sections use from ppc64 and drivers
      powerpc: Remove section free() and linker script bits
      powerpc: Merge simplified sections.h into asm-powerpc
      powerpc: Merge asm-ppc*/dma.h
      powerpc: Merge asm-ppc*/seccomp.h, drop TIF_32BIT check
      powerpc: Merge asm-ppc*/rwsem.h

Kumar Gala:
      powerpc: Merged ppc_asm.h
      ppc32: Removed non-inlined versions of local_irq* functions
      ppc32: Allow user to individual select CHRP/PMAC/PREP config
      ppc32: Allow user to individual select CHRP/PMAC/PREP config
      powerpc: unified signature of timer_interrupt() between ppc32/ppc64
      powerpc: merge include/asm-ppc*/auxvec.h into include/asm-powerpc/auxvec.h
      powerpc: merge include/asm-ppc*/spinlock_types.h into include/asm-powerpc/spinlock_types.h
      powerpc: merge include/asm-ppc*/statfs.h into include/asm-powerpc/statfs.h
      powerpc: Fix compiling of ppc32
      powerpc: merged hw_irq.h
      powerpc: Fix building of power3 config on ppc32
      powerpc: merged asm/cputable.h
      ppc32: make cur_cpu_spec a single pointer instead of an array
      powerpc: replace use of _GLOBAL with .globl
      powerpc: Some more fixes to allow building for a Book-E processor
      ppc32: replace use of _GLOBAL with .globl for ppc32
      powerpc: Make sure we have an RTC before trying to adjust it
      powerpc: some prom.c cleanups
      powerpc: merge include/asm-ppc*/checksum.h into include/asm-powerpc/checksum.h
      powerpc: Add support for Book-E timer config to generic_calibrate_decr
      powerpc: Some minor cleanups to setup_32.c
      powerpc: Fix warning related to do_dabr
      powerpc: Moved dcr support to arch/powerpc
      powerpc: only build idle_6xx for 6xx

Lee Nicks:
      ppc: prevent GCC 4 from generating AltiVec instructions in kernel

linuxppc@jdl.com:
      powerpc: Revised merge asm-ppc*/hardirq.h
      powerpc: Merge asm-ppc*/vga.h

Marcelo Tosatti:
      ppc32 8xx: use io accessor macros instead of direct memory reference
      MPC8xx PCMCIA driver
      ppc32: #ifdef out ALTIVEC specific code in __switch_to

Matt Porter:
      ppc32: Cleanup AMCC PPC44x eval board U-Boot support

Michael Ellerman:
      ppc64 iSeries: Move iSeries ppc_md functions into a machdep_calls struct
      ppc46 iSeries: Make some generic irq code compile for iSeries
      ppc64 iSeries: Update create_pte_mapping to replace iSeries_bolt_kernel()
      ppc64 iSeries: Make stab_initialize() work on iSeries
      ppc64 iSeries: Make smp_release_cpus() callable on iSeries
      ppc64 iSeries: Create a fake flat device tree on iSeries
      ppc64 iSeries: Call early_setup() on iSeries
      ppc64 iSeries: Move memory setup into iSeries device tree
      ppc64 iSeries: Move setup of systemcfg->platform into iSeries device tree
      ppc64 iSeries: Define /cpus in iSeries device tree
      powerpc: Don't blow away load_addr in start_thread
      powerpc: Fix mmap returning 64 bit addresses
      powerpc: Remove duplicate definition of set_tb()
      powerpc: Remove trailing \n" in HMT macros
      powerpc: Move firmware.h into include/asm-powerpc
      powerpc: Move ras.c into arch/powerpc/platforms/pseries

Nicolas DET:
      chrp_pegasos_eth: Added Marvell Discovery II SRAM support
      mv643xx_eth_showsram: Added information message when using the SRAM

Olaf Hering:
      ppc32: update xmon help text
      ppc32: nvram driver for chrp
      Add modalias for pmac network drivers
      ppc64 boot: remove include from lib/zlib_inflate/inflate.c
      ppc64 boot: remove include from include/linux/zutil.h
      ppc64 boot: missing include for size_t
      ppc64 boot: remove zlib
      ppc64 boot: remove need for imagesize.c
      ppc64 boot: move gunzip function before use
      ppc64 boot: bootfiles depend on linker script
      ppc64 boot: cleanup linker script
      ppc64 boot: use memset to clear bss
      ppc64 boot: fix typo in asm comments
      ppc64 boot: remove global initializers
      ppc64 boot: make the zImage relocateable
      ppc64 boot: proof that reloc works
      ppc64 boot: print firmware provided stackpointer
      ppc64: AC Power handling broken for desktops
      ppc64: compile nls_cp437 and nls_iso8859_1 into the kernel in defconfig
      ppc64: reenable make install with defconfig
      ppc64: change name of target file during make install
      ppc64: remove duplicate local variable in set_preferred_console

Olof Johansson:
      ppc64: Updated Olof iommu updates 1/3
      ppc64: Updated Olof iommu updates 2/3
      ppc64: Updated Olof misc updates 3/3

Paul Mackerras:
      Revert "ppc32: Allow user to individual select CHRP/PMAC/PREP config"
      Merge from Linus' tree.
      powerpc: Merge enough to start building in arch/powerpc.
      Merge refs/heads/devtree from rsync://oak/kernels/iseries/work/.git 
      ppc64: Fix typo in iommu cleanups that broke pmac build.
      powerpc: Fix building in the old arch's boot directory for now
      powerpc: Fixes to get the merged kernel to boot on powermac.
      Don't call a NULL ack function in the generic IRQ code.
      Merge Stephen Rothwell's patches
      Merge by hand from Linus' tree.
      powerpc: Get merged kernel to compile and run on 32-bit SMP powermac.
      Merge rsync://ozlabs.org/sfr-git/for-paulus/
      ppc32: export a few more things where they are defined
      ppc32: remove obsolete klock_info definition
      powerpc: Define 32/64 bit asm macros and use them in fpu.S
      powerpc: Merge in the ppc64 version of the prom code.
      powerpc: Merge lmb.c and make MM initialization use it.
      powerpc: Remove 64-bit cpu support from ppc32.
      powerpc: Merge of_device.c and of_device.h
      powerpc: Use the merged of_device.c with ARCH=powerpc
      powerpc: Merge traps.c a bit more
      powerpc: Define a _sdata symbol
      powerpc: Fix idle.c compile warning
      powerpc: Use SPRN_xxx rather than xxx for SPR numbers
      powerpc: Make some #includes explicit.
      powerpc: Merged processor.h.
      ppc64: Use the merged lmb routines
      powerpc: Rename files to have consistent _32/_64 suffixes
      powerpc: Merge arch/ppc64/mm to arch/powerpc/mm
      powerpc: move pSeries files to arch/powerpc/platforms/pseries
      ppc64: Use SPRN_ prefix for special purpose register names
      powerpc: rename powermac files to remove pmac_ prefix
      powerpc: Merge Kconfig.debug
      powerpc: Use reg.h instead of processor.h when we just want reg names
      powerpc: Use arch/powerpc/mm and arch/powerpc/lib for 64-bit
      powerpc: make process.c suitable for both 32-bit and 64-bit
      powerpc: Introduce entry_{32,64}.S, misc_{32,64}.S, systbl.S
      powerpc: Make prom_init.c suitable for both 32-bit and 64-bit
      powerpc: Reduce the 32/64-bit differences in traps.c
      powerpc: Reduce the 32/64-bit diffs in vmlinux.lds.S
      powerpc: Fix bug caused by negation of 64-bit reloc_offset value
      powerpc: move lparmap.c to arch/powerpc/kernel
      powerpc: Get 64-bit configs to compile with ARCH=powerpc
      powerpc: Get iseries to compile with ARCH=powerpc
      powerpc: Merge asm/irq.h
      powerpc: Merge asm/unistd.h
      powerpc: Fix off-by-one error in prom_init.c
      powerpc: Fix compilation for 32-bit configs
      powerpc: Start merging 64-bit support into powermac files
      powerpc: Make building the boot image work for both 32-bit and 64-bit
      powerpc: Merged asm/backlight.h
      powerpc: Merged asm/i8259.h
      powerpc: Remove 83xx from arch/powerpc/platforms/Makefile for now
      powerpc: Merged asm/xmon.h
      powerpc: Remove xmon.h include from arch/powerpc/platforms/powermac/pic.c
      powerpc: Remove debug messages from setup_64.c
      ppc: Adapt to asm-powerpc/irq.h irq_canonicalize changes
      ppc: Various minor compile fixes
      ppc64: Use merged versions of init_task.c and process.c.
      ppc64: compile fix - define execve in misc.S
      Merge from Linus' tree
      powerpc: Move default hash table size calculation to hash_utils_64.c
      powerpc: Bring in some changes made to arch/ppc and include/asm-ppc64
      ppc64: Remove duplicate versions of some headers
      powerpc: Initialize btext subsystem later, after prom_init
      powerpc: Merge syscalls.c and sys_ppc32.c.
      ppc: Use the merged of_device.c from arch/powerpc/kernel
      ppc: Fix various compile errors resulting from ptrace.c merge
      powerpc: Clear the BSS at the start of early_init with ARCH=ppc
      powerpc: Make CONFIG_PROC_DEVICETREE independent of CONFIG_PPC_OF
      powerpc: Fix various compile errors with ARCH=ppc, ppc64 and powerpc
      Merge rsync://oak/kernels/iseries/work/
      ppc: Minor smp changes for consistency with ppc64
      powerpc: Merge machdep.h
      ppc: declare smp_ops in asm/smp.h, since platform setup code needs it
      powerpc: Eliminate a compile warning in signal_32.c
      powerpc: Move ptrace32.c from arch/ppc64 to arch/powerpc
      ppc64: Minor compilation fixes
      powerpc: Merge time.c and asm/time.h.
      powerpc: Fix a branch-too-far link error for 32-bit targets
      powerpc: Fix a corner case in __div64_32
      ppc64: Change ppc_md.get_cpuinfo to ppc_md.show_cpuinfo
      powerpc: Move smp_mpic_message_pass into mpic.c
      powerpc: Fix places where ppc_md.show_[per]cpuinfo was treated as int
      powerpc: Merge various powermac-related header files.
      ppc: rename pci_assign_all_busses to pci_assign_all_buses
      ppc64: Move init_boot_text call and conswitchp init into setup_arch
      powerpc: Move some calculations from xxx_calibrate_decr to time_init
      ppc64: Use the merged mpic.c
      powerpc/ppc/ppc64: Various compile fixes.
      powerpc: Fix some bugs in the new merged time code
      powerpc: Move agp_special_page export to where it is defined
      ppc64: Fix delivery of RT signals to 32-bit processes.
      ppc64/powerpc: Fix time initialization on SMP systems
      ppc64: Add a `primary' argument to pci_process_bridge_OF_ranges
      ppc64: Rearrange btext initialization for consistency with ppc32
      ppc64: Simplify secondary CPU startup on powermacs
      powerpc: Make set_rtc_time() return error code from lower-level function
      powerpc: Merge in 64-bit powermac support.
      ppc64: Use arch/powerpc/platforms/powermac for powermac build.
      Merge changes from linux-2.6 by hand
      powerpc: Fix time code for 601 processors
      powerpc: Run on old powermacs.
      powerpc: Make coff boot wrapper load the kernel at 8M
      ppc: Use the indirect_pci.c from arch/powerpc/sysdev
      powerpc: Merge i8259.c into arch/powerpc/sysdev
      powerpc: Merge rtas.c into arch/powerpc/kernel
      powerpc: Pull common bits of setup_{32,64}.c into setup-common.c
      powerpc: Pull out MPC106 (grackle) initialization code into its own file
      powerpc: Fix interrupt-tree parsing
      powerpc: Don't limit pmac_get_rtc_time to return only positive values
      powerpc: Merge 32-bit CHRP support.
      powerpc: Fixes to get the Longtrail CHRP a bit further
      power: Update the multiple inclusion protection symbol on machdep.h
      powerpc32: Limit memory to lowmem if !CONFIG_HIGHMEM.
      powerpc: Fix incorrect timer register addresses in mpic.c
      powerpc: 32-bit powermac needs the mpc106 code
      powerpc: Remove common stuff from setup_64.c
      powerpc: undeprecate the old OF device tree accessors for now
      ppc64: remove arch/ppc64/kernel/setup.c
      powerpc: remove duplicate screen_info from setup_32.c
      powerpc: 32-bit CHRP SMP fixes
      powerpc: Introduce toreal/fromreal assembly macros
      powerpc: Fix new-world powermac detection
      powerpc: Move U3 IOMMU driver to arch/powerpc/sysdev
      ppc64: Include arch/powerpc/kernel/setup-common.o
      ppc64: Use the correct prototypes for i8259 functions
      Merge in v2.6.14 by hand
      Merge git://oak/home/sfr/kernels/iseries/work/
      powerpc: Rename asm offset TRAP to _TRAP for 32-bit
      powerpc: Make single-stepping emulation (mostly) usable on 32-bit
      powerpc: Merge xmon
      powerpc: Add -mno-altivec for ARCH=powerpc builds
      powerpc: Merge maple support code to arch/powerpc/platforms/maple
      powerpc: 32-bit needs cur_cpu_spec exported too
      powerpc: import a gfp_t fix to arch/powerpc/mm/pgtable_32.c
      powerpc: Remove T command from xmon help text since it no longer exists
      powerpc: Fix time setting bug on 32-bit
      powerpc: Fix bug arising from having multiple memory_limit variables
      ppc: remove duplicate export of cur_cpu_spec
      Merge ../linux-2.6 by hand
      powerpc: apply recent changes to merged code
      powerpc: import a fix from arch/ppc/mm/pgtable.c

Roland Dreier:
      ppc: make phys_mem_access_prot() work with pfns instead of addresses

scwhab@suse.de:
      Add modalias to macio sysfs attributes

Stephen Rothwell:
      powerpc: Move arch/ppc*/kernel/vecemu.c to arch/powerpc
      powerpc: Merge include/asm-ppc*/a.out.h into include/asm-powerpc
      powerpc: Move arch/ppc*/oprofile/Kconfig to arch/powerpc
      Merge arch/ppc*/oprofile/Makefile into arch/powerpc/oprofile
      powerpc: rename op_ppc{32,64}_model to op_powerpc_model
      powerpc: merge oprofile headers
      powerpc: merge the rest of arch/ppc*/oprofile
      powerpc: reduce oprofile/common.c differences
      ppc64 iSeries: Don't create linux,boot-cpu
      powerpc: clean up after powermac build merge
      ppc64 g5: merge tree build fix
      powerpc: Create arch/powerpc/platforms/iseries
      powerpc: Move HvLpConfig.c to powerpc arch
      powerpc: Move LparData.c to powerpc platforms
      powerpc: move iSeries_setup.[ch] and mf.c into platforms/iseries
      powerpc: move ItLpQueue.c to powerpc/platforms/iseries
      powerpc: move hvCall.s to powerpc/platforms/iseries
      powerpc: Merge HvLpEvent.c into lpevents.c
      powerpc: move iSeries_proc.c to powerpc/platforms/iseries
      powerpc: Move iSeries_htab.c to powerpc/platforms/iseries
      powerpc: Move iSeries_iommu.c to powerpc/platforms/iseries
      powerpc: Move iSeries_pci.c to powerpc/platform/iseries
      powerpc: Move iSeries_irq.c to powerpc/platorms/iseries
      powerpc: Move iSeries_VpdInfo.c to powerpc/platforms/iseries
      powerpc: Move iSeries_vio.c to powerpc/platforms/iseries
      powerpc: Move iSeries_smp.c to powerpc/platforms/iseries
      powerpc: Move viopath.c to powerpc/platforms/iseries
      powerpc: Make powerpc pmac 32 bit build again
      powerpc: move more iSeries code
      ppc64 iSeries: use device_node instead of iSeries_Device_node
      ppc64 iseries: move some iSeries include files
      powerpc: merge asm-offsets.c
      powerpc: remove old vector.S files
      powerpc: more cleanup of powerpc/kernel
      powerpc: Move lparmap.c to powerpc/platforms
      powerpc: merge idle_power4.S and trapc.s
      ppc64: simplify the build a little
      powerpc: make iSeries build
      powerpc: make iSeries boot
      powerpc: pci_dn's should point to their device_node's
      powerpc: make iSeries boot again
      powerpc: consolidate cputable.c
      powerpc: create 32 bit LOADADDR macro
      powerpc: make 64 bit binaries work
      ppc64: merge binfmt_elf32.c
      ppc64: fix arch/ppc64/kernel/Makefile
      ppc64: use powerpc of_device.c
      powerpc: merge ptrace.c
      powerpc: fix uname -m
      powerpc: move iSeries/iSeries_pci.h to platforms/iseries
      powerpc: remove ISERIES_[SUB]BUS macros
      powerpc: eliminate DsaAddr from pci_dn
      powerpc: move iSeries/HvCallHpt.h to platforms/iseries/call_hpt.h
      powerpc: move iSeries/HvCallPci.h to platforms/iseries/call_pci.h
      powerpc: fix 32bit LOADADDR macro
      ppc32: use L1_CACHE_SHIFT/L1_CACHE_BYTES
      powerpc: merge ppc signal.c and ppc64 signal32.c
      powerpc: change sys32_ to compat_sys_
      powerpc: Merge arch/ppc64/kernel/vio.c into arch/powerpc/kernel/vio.c
      powerpc: Move include/asm-ppc64/vio.h to include/asm-powerpc/vio.h
      powerpc: don't duplicate name between vio_driver and device_driver
      powerpc: iseries: Fix a bogus comment
      powerpc: set the driver.owner field for all vio drivers
      powerpc: Add a shutdown member to vio_driver
      ppc64: make dma_addr_t 64 bits
      powerpc: merge scatterlist.h
      ppc64: use the merged syscall table
      ppc64: use checksum_64.S from powerpc
      ppc64: use e2a.c from powerpc/lib
      ppc64: use copypage_64.S from powerpc/lib
      ppc64: use copyuser_64.S from powerpc/lib
      ppc64: use lockc.c from powerpc/lib
      ppc64: use memcpy_64.S from powerpc/lib
      ppc64: use sstep.c from powerpc/lib
      ppc64: user strcase.c from powerpc/lib
      ppc64: use usercopy_64.c from powerpc/lib
      ppc64: use mem_64.S from powerpc/lib

Vitaly Bordug:
      ppc32: ppc_sys fixes for 8xx and 82xx
