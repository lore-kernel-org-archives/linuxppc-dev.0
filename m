Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EC9441A01DB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Nov 2014 21:59:45 +1100 (AEDT)
Message-ID: <1415185185.9474.1.camel@concordia>
Subject: powerpc test branch for 3.19
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Date: Wed, 05 Nov 2014 21:59:45 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kyle@redhat.com, agraf@suse.de, Julia.Lawall@lip6.fr, anton@samba.org,
 simon.kagstrom@netinsight.net, cl@linux.com, jslaby@suse.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi folks,

Here's the current contents of my test branch. This will become the powerpc
next branch for 3.19 in the next day or two.

If there's a patch in here you object to please let me know asap.

The tree is at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux.git test


Also if you have stuff you are targetting for 3.19, now is a good time to start
thinking about posting it. I will try to do things properly this cycle and
close my next branch prior to the 3.18 release. You have been warned! :)

cheers

----------------------------------------------------------------
Alexander Graf (1):
      powerpc: Convert power off logic to pm_power_off

Anton Blanchard (17):
      powerpc: Use probe_kernel_address in show_instructions
      powerpc/pci: Quieten unset I/O resource warning
      powerpc: Remove ppc64_boot_msg
      powerpc: Remove ppc_md.remove_memory
      powerpc: Remove bootmem allocator
      powerpc: Remove some old bootmem related comments
      powerpc: Remove superfluous bootmem includes
      powerpc: Move sparse_init() into initmem_init
      powerpc: make __ffs return unsigned long
      powerpc/ftrace: Remove mod_return_to_handler
      powerpc/ftrace: simplify prepare_ftrace_return
      powerpc/jump_label: Use HAVE_JUMP_LABEL
      powerpc: Don't use local named register variable in current_thread_info
      powerpc: Remove double braces in alignment code.
      powerpc: LLVM complains about forward declaration of struct rtas_sensors
      powerpc/pseries: Quieten ibm,pcie-link-speed-stats warning
      powerpc/pseries: Quieten relocation on exceptions warning

Christoph Lameter (1):
      powerpc: Replace __get_cpu_var uses

Jiri Slaby (1):
      powerpc/ftrace: Fix obsolete comment

Julia Lawall (5):
      powerpc/4xx/cpm: delete unneeded test before of_node_put
      powerpc/fsl: fsl_soc: delete unneeded test before of_node_put
      powerpc/mpc5xxx: delete unneeded test before of_node_put
      powerpc/pseries: delete unneeded test before of_node_put
      powerpc/gamecube/wii: delete unneeded test before of_node_put

Kyle McMartin (1):
      powerpc: Remove unused devm_ioremap_prot()

Michael Ellerman (5):
      Merge branch 'topic/pm-power-off' into next
      Merge branch 'topic/get-cpu-var' into next
      powerpc: Remove CPU_FTR_HVMODE from CPU_FTRS_ALWAYS
      powerpc: Remove unused CPU_FTRS_A2
      powerpc: Remove unused vgacon_remap_base & fix build break

Simon Kagstrom (1):
      powerpc/boot: Parse chosen/cmdline-timeout parameter

 arch/powerpc/Kconfig                               |   1 +
 arch/powerpc/boot/main.c                           |  15 +-
 arch/powerpc/boot/ops.h                            |   2 +-
 arch/powerpc/boot/serial.c                         |   6 +-
 arch/powerpc/include/asm/bitops.h                  |   2 +-
 arch/powerpc/include/asm/cputable.h                |  10 +-
 arch/powerpc/include/asm/hardirq.h                 |   7 +-
 arch/powerpc/include/asm/io.h                      |   3 -
 arch/powerpc/include/asm/machdep.h                 |  15 --
 arch/powerpc/include/asm/setup.h                   |   3 +-
 arch/powerpc/include/asm/thread_info.h             |   5 +-
 arch/powerpc/include/asm/tlbflush.h                |   4 +-
 arch/powerpc/include/asm/vga.h                     |   4 +-
 arch/powerpc/include/asm/xics.h                    |   8 +-
 arch/powerpc/kernel/align.c                        |   2 +-
 arch/powerpc/kernel/crash_dump.c                   |   1 -
 arch/powerpc/kernel/dbell.c                        |   2 +-
 arch/powerpc/kernel/entry_32.S                     |  12 +-
 arch/powerpc/kernel/entry_64.S                     |  35 +---
 arch/powerpc/kernel/ftrace.c                       |  73 ++-----
 arch/powerpc/kernel/hw_breakpoint.c                |   6 +-
 arch/powerpc/kernel/iommu.c                        |   2 +-
 arch/powerpc/kernel/irq.c                          |   5 +-
 arch/powerpc/kernel/kgdb.c                         |   2 +-
 arch/powerpc/kernel/kprobes.c                      |   6 +-
 arch/powerpc/kernel/mce.c                          |  24 +--
 arch/powerpc/kernel/pci-common.c                   |   2 +-
 arch/powerpc/kernel/pci_64.c                       |   1 -
 arch/powerpc/kernel/process.c                      |  27 +--
 arch/powerpc/kernel/prom.c                         |   5 +-
 arch/powerpc/kernel/rtas-proc.c                    |  20 +-
 arch/powerpc/kernel/rtas.c                         |   4 +-
 arch/powerpc/kernel/rtas_pci.c                     |   1 -
 arch/powerpc/kernel/setup-common.c                 |   6 +-
 arch/powerpc/kernel/setup_32.c                     |  11 +-
 arch/powerpc/kernel/setup_64.c                     |  33 +--
 arch/powerpc/kernel/smp.c                          |   6 +-
 arch/powerpc/kernel/sysfs.c                        |   4 +-
 arch/powerpc/kernel/time.c                         |  22 +-
 arch/powerpc/kernel/traps.c                        |   8 +-
 arch/powerpc/kernel/vdso.c                         |   1 -
 arch/powerpc/kvm/book3s_hv_builtin.c               |   3 +-
 arch/powerpc/kvm/e500.c                            |  14 +-
 arch/powerpc/kvm/e500mc.c                          |   4 +-
 arch/powerpc/lib/Makefile                          |   1 -
 arch/powerpc/lib/devres.c                          |  43 ----
 arch/powerpc/mm/hash_native_64.c                   |   2 +-
 arch/powerpc/mm/hash_utils_64.c                    |   2 +-
 arch/powerpc/mm/hugetlbpage-book3e.c               |   6 +-
 arch/powerpc/mm/hugetlbpage.c                      |   6 +-
 arch/powerpc/mm/init_32.c                          |  10 -
 arch/powerpc/mm/init_64.c                          |   1 -
 arch/powerpc/mm/mem.c                              |  77 ++-----
 arch/powerpc/mm/numa.c                             | 224 ++++-----------------
 arch/powerpc/mm/pgtable_32.c                       |   3 +-
 arch/powerpc/mm/pgtable_64.c                       |  12 +-
 arch/powerpc/perf/core-book3s.c                    |  22 +-
 arch/powerpc/perf/core-fsl-emb.c                   |   6 +-
 arch/powerpc/platforms/44x/ppc476.c                |   2 +-
 arch/powerpc/platforms/512x/mpc512x_shared.c       |   7 +-
 arch/powerpc/platforms/52xx/efika.c                |   3 +-
 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c     |   8 +-
 arch/powerpc/platforms/85xx/corenet_generic.c      |   2 +-
 arch/powerpc/platforms/85xx/sgy_cts1000.c          |   4 +-
 arch/powerpc/platforms/cell/celleb_scc_epci.c      |   1 -
 arch/powerpc/platforms/cell/celleb_scc_pciex.c     |   1 -
 arch/powerpc/platforms/cell/celleb_setup.c         |   4 +-
 arch/powerpc/platforms/cell/interrupt.c            |   6 +-
 arch/powerpc/platforms/cell/qpace_setup.c          |   2 +-
 arch/powerpc/platforms/cell/setup.c                |   2 +-
 arch/powerpc/platforms/chrp/setup.c                |   3 +-
 arch/powerpc/platforms/embedded6xx/gamecube.c      |   3 +-
 arch/powerpc/platforms/embedded6xx/linkstation.c   |   4 +-
 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c |   6 +-
 arch/powerpc/platforms/embedded6xx/wii.c           |   3 +-
 arch/powerpc/platforms/maple/pci.c                 |   1 -
 arch/powerpc/platforms/maple/setup.c               |   4 +-
 arch/powerpc/platforms/powermac/pci.c              |   1 -
 arch/powerpc/platforms/powermac/setup.c            |   3 +-
 arch/powerpc/platforms/powernv/eeh-ioda.c          |   1 -
 arch/powerpc/platforms/powernv/opal-tracepoints.c  |   4 +-
 arch/powerpc/platforms/powernv/opal-wrappers.S     |   2 +-
 arch/powerpc/platforms/powernv/pci.c               |   1 -
 arch/powerpc/platforms/powernv/setup.c             |   4 +-
 arch/powerpc/platforms/ps3/interrupt.c             |   2 +-
 arch/powerpc/platforms/ps3/setup.c                 |   2 +-
 arch/powerpc/platforms/pseries/dtl.c               |   2 +-
 arch/powerpc/platforms/pseries/hotplug-memory.c    |  21 --
 arch/powerpc/platforms/pseries/hvCall.S            |   4 +-
 arch/powerpc/platforms/pseries/hvCall_inst.c       |   4 +-
 arch/powerpc/platforms/pseries/iommu.c             |  11 +-
 arch/powerpc/platforms/pseries/lpar.c              |   6 +-
 arch/powerpc/platforms/pseries/pci.c               |   2 +-
 arch/powerpc/platforms/pseries/ras.c               |   4 +-
 arch/powerpc/platforms/pseries/setup.c             |  65 +++---
 arch/powerpc/sysdev/fsl_msi.c                      |   1 -
 arch/powerpc/sysdev/fsl_pci.c                      |   2 +-
 arch/powerpc/sysdev/fsl_soc.c                      |   5 +-
 arch/powerpc/sysdev/ipic.c                         |   1 -
 arch/powerpc/sysdev/mpc5xxx_clocks.c               |   3 +-
 arch/powerpc/sysdev/mpic.c                         |   1 -
 arch/powerpc/sysdev/mpic_pasemi_msi.c              |   1 -
 arch/powerpc/sysdev/mpic_u3msi.c                   |   1 -
 arch/powerpc/sysdev/ppc4xx_cpm.c                   |   8 +-
 arch/powerpc/sysdev/ppc4xx_msi.c                   |   1 -
 arch/powerpc/sysdev/ppc4xx_pci.c                   |   1 -
 arch/powerpc/sysdev/qe_lib/qe.c                    |   1 -
 arch/powerpc/sysdev/qe_lib/qe_ic.c                 |   1 -
 arch/powerpc/sysdev/uic.c                          |   1 -
 arch/powerpc/sysdev/xics/xics-common.c             |   2 +-
 arch/powerpc/xmon/xmon.c                           |   3 +-
 111 files changed, 333 insertions(+), 747 deletions(-)
 delete mode 100644 arch/powerpc/lib/devres.c
