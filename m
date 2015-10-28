Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0134.outbound.protection.outlook.com [157.56.111.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A2B301A039F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 08:56:19 +1100 (AEDT)
Date: Wed, 28 Oct 2015 16:56:00 -0500
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>
CC: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: Pull request: scottwood/linux.git next
Message-ID: <20151028215600.GA1600@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Highlights include 64-bit book3e kexec/kdump support, a rework of the
qoriq clock driver, device tree changes including qoriq fman nodes,
support for a new 85xx board, and some fixes.

Note that there is a trivial merge conflict with the clock tree's next
branch, in the clock Makefile.

The following changes since commit 20d09927e669b7e92795c804a3cf82d6c4f3c909:

  selftests/powerpc: Allow the tm-syscall test to build with old headers (2015-10-15 20:32:04 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next

for you to fetch changes up to e1f580e8ced56d7c0a2b096e00e8b8e861d13671:

  powerpc/e6500: hw tablewalk: make sure we invalidate and write to the same tlb entry (2015-10-27 18:14:40 -0500)

----------------------------------------------------------------
Andy Fleming (1):
      powerpc/85xx: Add support for Varisys Cyrus board

Christophe Leroy (1):
      powerpc: handle error case in cpm_muram_alloc()

Hongtao Jia (1):
      powerpc/fsl: Move Freescale device tree files into fsl folder

Hou Zhiqiang (1):
      clk: qoriq: Add ls1043a support.

Igal Liberman (2):
      powerpc/mpc85xx: Create dts components for the FSL QorIQ DPAA FMan
      powerpc/mpc85xx: Add FSL QorIQ DPAA FMan support to the SoC device tree(s)

Kevin Hao (1):
      powerpc/e6500: hw tablewalk: make sure we invalidate and write to the same tlb entry

Scott Wood (19):
      powerpc/fsl_pci: Check for get_user/probe_kernel_address failure
      powerpc/fsl-booke-64: Allow booting from the secondary thread
      powerpc/fsl-corenet: Disable coreint if kexec is enabled
      powerpc/85xx: Don't use generic timebase sync on 64-bit
      powerpc/fsl_pci: Don't set up inbound windows in kdump crash kernel
      powerpc/fsl: Move fsl_guts.h out of arch/powerpc
      clk: qoriq: Move chip-specific knowledge into driver
      clk: qoriq: Add ls2080a support.
      powerpc/85xx: Load all early TLB entries at once
      clk: qoriq: Fix wrong data in p2041_cmux_grp2
      powerpc/fsl-booke-64: Don't limit ppc64_rma_size to one TLB entry
      powerpc/e6500: kexec: Handle hardware threads
      powerpc/book3e/kdump: Enable crash_kexec_wait_realmode
      powerpc/book3e-64: Don't limit paca to 256 MiB
      powerpc/book3e-64/kexec: Enable SMP release
      powerpc/booke: Only use VIRT_PHYS_OFFSET on booke32
      powerpc/book3e-64/kexec: Set "r4 = 0" when entering spinloop
      Merge branch 'clock' into HEAD
      powerpc/fsl: Add #clock-cells and clockgen label to clockgen nodes

Sudeep Holla (1):
      powerpc: mpic: use IRQCHIP_SKIP_SET_WAKE instead of redundant mpic_irq_set_wake

Tiejun Chen (6):
      powerpc/85xx: Implement 64-bit kexec support
      powerpc/book3e-64: rename interrupt_end_book3e with __end_interrupts
      powerpc/booke64: Fix args to copy_and_flush
      powerpc/book3e: support CONFIG_RELOCATABLE
      powerpc/book3e-64/kexec: create an identity TLB mapping
      powerpc/book3e-64: Enable kexec

Uwe Kleine-König (1):
      powerpc/dts: don't fall back to fsl,pq3-gpio for fsl,mpc8572-gpio

Yangbo Lu (1):
      powerpc/dts: Add and fix 1588 timer node for eTSEC

Zhao Qiang (1):
      powerpc/t104xd4rdb: add DS26522 nodes to device tree

chenhui zhao (1):
      powerpc/corenet: use the mixed mode of MPIC when enabling CPU hotplug

poonam aggrwal (2):
      powerpc/b4860: Removed LIODN register from sRIO node
      powerpc/b4860: Renamed the L2 caches

 Documentation/devicetree/bindings/chosen.txt       |    8 +
 .../devicetree/bindings/clock/qoriq-clock.txt      |   61 +-
 .../devicetree/bindings/net/maxim,ds26522.txt      |   13 +
 arch/powerpc/Kconfig                               |    2 +-
 arch/powerpc/boot/Makefile                         |    3 +
 arch/powerpc/boot/dts/{ => fsl}/b4420qds.dts       |    4 +-
 arch/powerpc/boot/dts/fsl/b4420si-post.dtsi        |    4 +-
 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi         |   13 +-
 arch/powerpc/boot/dts/{ => fsl}/b4860qds.dts       |    4 +-
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi        |   26 +-
 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi         |   20 +-
 arch/powerpc/boot/dts/{ => fsl}/b4qds.dtsi         |    2 +-
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi           |   33 +-
 arch/powerpc/boot/dts/{ => fsl}/bsc9131rdb.dts     |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/bsc9131rdb.dtsi    |   12 +
 arch/powerpc/boot/dts/{ => fsl}/bsc9132qds.dts     |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/bsc9132qds.dtsi    |   12 +
 arch/powerpc/boot/dts/{ => fsl}/c293pcie.dts       |    4 +-
 arch/powerpc/boot/dts/fsl/cyrus_p5020.dts          |  155 +++
 arch/powerpc/boot/dts/{ => fsl}/ge_imp3a.dts       |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/kmcoge4.dts        |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/mpc8536ds.dts      |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/mpc8536ds.dtsi     |    0
 arch/powerpc/boot/dts/{ => fsl}/mpc8536ds_36b.dts  |    4 +-
 arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi      |    2 +-
 arch/powerpc/boot/dts/{ => fsl}/mpc8540ads.dts     |    2 +-
 arch/powerpc/boot/dts/{ => fsl}/mpc8541cds.dts     |    2 +-
 arch/powerpc/boot/dts/{ => fsl}/mpc8544ds.dts      |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/mpc8544ds.dtsi     |    0
 arch/powerpc/boot/dts/{ => fsl}/mpc8548cds.dtsi    |    0
 arch/powerpc/boot/dts/{ => fsl}/mpc8548cds_32b.dts |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/mpc8548cds_36b.dts |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/mpc8555cds.dts     |    2 +-
 arch/powerpc/boot/dts/{ => fsl}/mpc8560ads.dts     |    2 +-
 arch/powerpc/boot/dts/{ => fsl}/mpc8568mds.dts     |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/mpc8569mds.dts     |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/mpc8572ds.dts      |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/mpc8572ds.dtsi     |    0
 arch/powerpc/boot/dts/{ => fsl}/mpc8572ds_36b.dts  |    4 +-
 .../boot/dts/{ => fsl}/mpc8572ds_camp_core0.dts    |    0
 .../boot/dts/{ => fsl}/mpc8572ds_camp_core1.dts    |    0
 arch/powerpc/boot/dts/fsl/mpc8572si-post.dtsi      |    2 +-
 arch/powerpc/boot/dts/{ => fsl}/mvme2500.dts       |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/oca4080.dts        |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/p1010rdb-pa.dts    |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/p1010rdb-pa.dtsi   |    0
 .../powerpc/boot/dts/{ => fsl}/p1010rdb-pa_36b.dts |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/p1010rdb-pb.dts    |    4 +-
 .../powerpc/boot/dts/{ => fsl}/p1010rdb-pb_36b.dts |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/p1010rdb.dtsi      |   12 +
 arch/powerpc/boot/dts/{ => fsl}/p1010rdb_32b.dtsi  |    0
 arch/powerpc/boot/dts/{ => fsl}/p1010rdb_36b.dtsi  |    0
 arch/powerpc/boot/dts/{ => fsl}/p1020mbg-pc.dtsi   |    0
 .../powerpc/boot/dts/{ => fsl}/p1020mbg-pc_32b.dts |    4 +-
 .../powerpc/boot/dts/{ => fsl}/p1020mbg-pc_36b.dts |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/p1020rdb-pc.dtsi   |    0
 .../powerpc/boot/dts/{ => fsl}/p1020rdb-pc_32b.dts |    4 +-
 .../powerpc/boot/dts/{ => fsl}/p1020rdb-pc_36b.dts |    4 +-
 .../boot/dts/{ => fsl}/p1020rdb-pc_camp_core0.dts  |    0
 .../boot/dts/{ => fsl}/p1020rdb-pc_camp_core1.dts  |    0
 arch/powerpc/boot/dts/{ => fsl}/p1020rdb-pd.dts    |   16 +-
 arch/powerpc/boot/dts/{ => fsl}/p1020rdb.dts       |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/p1020rdb.dtsi      |    0
 arch/powerpc/boot/dts/{ => fsl}/p1020rdb_36b.dts   |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/p1020utm-pc.dtsi   |    0
 .../powerpc/boot/dts/{ => fsl}/p1020utm-pc_32b.dts |    4 +-
 .../powerpc/boot/dts/{ => fsl}/p1020utm-pc_36b.dts |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/p1021mds.dts       |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/p1021rdb-pc.dtsi   |   12 +
 .../powerpc/boot/dts/{ => fsl}/p1021rdb-pc_32b.dts |    4 +-
 .../powerpc/boot/dts/{ => fsl}/p1021rdb-pc_36b.dts |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/p1022ds.dtsi       |   12 +
 arch/powerpc/boot/dts/{ => fsl}/p1022ds_32b.dts    |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/p1022ds_36b.dts    |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/p1022rdk.dts       |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/p1023rdb.dts       |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/p1024rdb.dtsi      |    0
 arch/powerpc/boot/dts/{ => fsl}/p1024rdb_32b.dts   |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/p1024rdb_36b.dts   |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/p1025rdb.dtsi      |    0
 arch/powerpc/boot/dts/{ => fsl}/p1025rdb_32b.dts   |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/p1025rdb_36b.dts   |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/p1025twr.dts       |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/p1025twr.dtsi      |   12 +
 arch/powerpc/boot/dts/{ => fsl}/p2020ds.dts        |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/p2020ds.dtsi       |    0
 arch/powerpc/boot/dts/{ => fsl}/p2020rdb-pc.dtsi   |   12 +-
 .../powerpc/boot/dts/{ => fsl}/p2020rdb-pc_32b.dts |    4 +-
 .../powerpc/boot/dts/{ => fsl}/p2020rdb-pc_36b.dts |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/p2020rdb.dts       |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/p2041rdb.dts       |    4 +-
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi        |   29 +-
 arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi         |   10 +-
 arch/powerpc/boot/dts/{ => fsl}/p3041ds.dts        |    4 +-
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi        |   29 +-
 arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi         |   10 +-
 arch/powerpc/boot/dts/{ => fsl}/p4080ds.dts        |    4 +-
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi        |   48 +-
 arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi         |   15 +-
 arch/powerpc/boot/dts/{ => fsl}/p5020ds.dts        |    4 +-
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi        |   29 +-
 arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi         |   10 +-
 arch/powerpc/boot/dts/{ => fsl}/p5040ds.dts        |    4 +-
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi        |   56 +-
 arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi         |   17 +-
 arch/powerpc/boot/dts/{ => fsl}/ppa8548.dts        |    4 +-
 arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi     |    3 +-
 arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi     |    3 +-
 arch/powerpc/boot/dts/fsl/qoriq-fman-0-10g-0.dtsi  |   62 +
 arch/powerpc/boot/dts/fsl/qoriq-fman-0-1g-0.dtsi   |   69 +
 arch/powerpc/boot/dts/fsl/qoriq-fman-0-1g-1.dtsi   |   68 +
 arch/powerpc/boot/dts/fsl/qoriq-fman-0-1g-2.dtsi   |   68 +
 arch/powerpc/boot/dts/fsl/qoriq-fman-0-1g-3.dtsi   |   68 +
 arch/powerpc/boot/dts/fsl/qoriq-fman-0-1g-4.dtsi   |   68 +
 arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi        |  101 ++
 arch/powerpc/boot/dts/fsl/qoriq-fman-1-10g-0.dtsi  |   61 +
 arch/powerpc/boot/dts/fsl/qoriq-fman-1-1g-0.dtsi   |   68 +
 arch/powerpc/boot/dts/fsl/qoriq-fman-1-1g-1.dtsi   |   68 +
 arch/powerpc/boot/dts/fsl/qoriq-fman-1-1g-2.dtsi   |   68 +
 arch/powerpc/boot/dts/fsl/qoriq-fman-1-1g-3.dtsi   |   68 +
 arch/powerpc/boot/dts/fsl/qoriq-fman-1-1g-4.dtsi   |   68 +
 arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi        |  101 ++
 .../dts/fsl/qoriq-fman3-0-10g-0-best-effort.dtsi   |   66 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-0.dtsi |   63 +
 .../dts/fsl/qoriq-fman3-0-10g-1-best-effort.dtsi   |   66 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1.dtsi |   63 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-0.dtsi  |   62 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-1.dtsi  |   62 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-2.dtsi  |   62 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-3.dtsi  |   62 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-4.dtsi  |   62 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-5.dtsi  |   62 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi       |  106 ++
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-0.dtsi |   63 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-1.dtsi |   63 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-0.dtsi  |   62 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-1.dtsi  |   62 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-2.dtsi  |   62 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-3.dtsi  |   62 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-4.dtsi  |   62 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-5.dtsi  |   62 +
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi       |  106 ++
 arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi      |   94 ++
 arch/powerpc/boot/dts/{ => fsl}/t1023rdb.dts       |    4 +-
 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi        |   19 +
 arch/powerpc/boot/dts/{ => fsl}/t1024qds.dts       |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/t1024rdb.dts       |    4 +-
 arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi         |    6 +
 arch/powerpc/boot/dts/{ => fsl}/t1040d4rdb.dts     |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/t1040qds.dts       |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/t1040rdb.dts       |    4 +-
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi        |   31 +
 arch/powerpc/boot/dts/{ => fsl}/t1042d4rdb.dts     |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/t1042qds.dts       |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/t1042rdb.dts       |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/t1042rdb_pi.dts    |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/t104xd4rdb.dtsi    |   10 +
 arch/powerpc/boot/dts/{ => fsl}/t104xqds.dtsi      |    0
 arch/powerpc/boot/dts/{ => fsl}/t104xrdb.dtsi      |    0
 arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi         |    9 +-
 arch/powerpc/boot/dts/{ => fsl}/t2080qds.dts       |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/t2080rdb.dts       |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/t2081qds.dts       |    4 +-
 arch/powerpc/boot/dts/fsl/t2081si-post.dtsi        |   43 +
 arch/powerpc/boot/dts/{ => fsl}/t208xqds.dtsi      |    0
 arch/powerpc/boot/dts/{ => fsl}/t208xrdb.dtsi      |    0
 arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi         |   11 +
 arch/powerpc/boot/dts/{ => fsl}/t4240qds.dts       |    4 +-
 arch/powerpc/boot/dts/{ => fsl}/t4240rdb.dts       |    4 +-
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi        |   88 +-
 arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi         |   22 +-
 arch/powerpc/include/asm/exception-64e.h           |   15 +-
 arch/powerpc/include/asm/page.h                    |    7 +-
 arch/powerpc/kernel/crash.c                        |    6 +-
 arch/powerpc/kernel/exceptions-64e.S               |   17 +-
 arch/powerpc/kernel/head_64.S                      |   43 +-
 arch/powerpc/kernel/machine_kexec_64.c             |   18 +
 arch/powerpc/kernel/misc_64.S                      |   60 +-
 arch/powerpc/kernel/paca.c                         |    9 +-
 arch/powerpc/kernel/setup_64.c                     |   25 +-
 arch/powerpc/mm/fsl_booke_mmu.c                    |   26 +-
 arch/powerpc/mm/mmu_decl.h                         |    4 +-
 arch/powerpc/mm/tlb_low_64e.S                      |   25 +-
 arch/powerpc/mm/tlb_nohash.c                       |   41 +-
 arch/powerpc/mm/tlb_nohash_low.S                   |   63 +
 arch/powerpc/platforms/85xx/corenet_generic.c      |   11 +
 arch/powerpc/platforms/85xx/mpc85xx_mds.c          |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c          |    2 +-
 arch/powerpc/platforms/85xx/p1022_ds.c             |    2 +-
 arch/powerpc/platforms/85xx/p1022_rdk.c            |    2 +-
 arch/powerpc/platforms/85xx/smp.c                  |   88 +-
 arch/powerpc/platforms/85xx/twr_p102x.c            |    2 +-
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c         |    2 +-
 arch/powerpc/sysdev/cpm_common.c                   |    3 +-
 arch/powerpc/sysdev/fsl_pci.c                      |   86 +-
 arch/powerpc/sysdev/mpic.c                         |   23 +-
 drivers/clk/Kconfig                                |    2 +-
 drivers/clk/clk-qoriq.c                            | 1354 ++++++++++++++++----
 drivers/iommu/fsl_pamu.c                           |    2 +-
 .../asm/fsl_guts.h => include/linux/fsl/guts.h     |    8 +-
 sound/soc/fsl/mpc8610_hpcd.c                       |    2 +-
 sound/soc/fsl/p1022_ds.c                           |    2 +-
 sound/soc/fsl/p1022_rdk.c                          |    2 +-
 203 files changed, 5078 insertions(+), 534 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/maxim,ds26522.txt
 rename arch/powerpc/boot/dts/{ => fsl}/b4420qds.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/b4860qds.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/b4qds.dtsi (99%)
 rename arch/powerpc/boot/dts/{ => fsl}/bsc9131rdb.dts (91%)
 rename arch/powerpc/boot/dts/{ => fsl}/bsc9131rdb.dtsi (90%)
 rename arch/powerpc/boot/dts/{ => fsl}/bsc9132qds.dts (91%)
 rename arch/powerpc/boot/dts/{ => fsl}/bsc9132qds.dtsi (91%)
 rename arch/powerpc/boot/dts/{ => fsl}/c293pcie.dts (98%)
 create mode 100644 arch/powerpc/boot/dts/fsl/cyrus_p5020.dts
 rename arch/powerpc/boot/dts/{ => fsl}/ge_imp3a.dts (98%)
 rename arch/powerpc/boot/dts/{ => fsl}/kmcoge4.dts (98%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8536ds.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8536ds.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8536ds_36b.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8540ads.dts (99%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8541cds.dts (99%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8544ds.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8544ds.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8548cds.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8548cds_32b.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8548cds_36b.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8555cds.dts (99%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8560ads.dts (99%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8568mds.dts (99%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8569mds.dts (99%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8572ds.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8572ds.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8572ds_36b.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8572ds_camp_core0.dts (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/mpc8572ds_camp_core1.dts (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/mvme2500.dts (98%)
 rename arch/powerpc/boot/dts/{ => fsl}/oca4080.dts (98%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1010rdb-pa.dts (88%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1010rdb-pa.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1010rdb-pa_36b.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1010rdb-pb.dts (89%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1010rdb-pb_36b.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1010rdb.dtsi (94%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1010rdb_32b.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1010rdb_36b.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1020mbg-pc.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1020mbg-pc_32b.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1020mbg-pc_36b.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1020rdb-pc.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1020rdb-pc_32b.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1020rdb-pc_36b.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1020rdb-pc_camp_core0.dts (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1020rdb-pc_camp_core1.dts (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1020rdb-pd.dts (95%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1020rdb.dts (95%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1020rdb.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1020rdb_36b.dts (95%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1020utm-pc.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1020utm-pc_32b.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1020utm-pc_36b.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1021mds.dts (99%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1021rdb-pc.dtsi (95%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1021rdb-pc_32b.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1021rdb-pc_36b.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1022ds.dtsi (94%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1022ds_32b.dts (98%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1022ds_36b.dts (98%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1022rdk.dts (98%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1023rdb.dts (99%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1024rdb.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1024rdb_32b.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1024rdb_36b.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1025rdb.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1025rdb_32b.dts (98%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1025rdb_36b.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1025twr.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/p1025twr.dtsi (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/p2020ds.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/p2020ds.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/p2020rdb-pc.dtsi (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/p2020rdb-pc_32b.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/p2020rdb-pc_36b.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/p2020rdb.dts (98%)
 rename arch/powerpc/boot/dts/{ => fsl}/p2041rdb.dts (98%)
 rename arch/powerpc/boot/dts/{ => fsl}/p3041ds.dts (99%)
 rename arch/powerpc/boot/dts/{ => fsl}/p4080ds.dts (98%)
 rename arch/powerpc/boot/dts/{ => fsl}/p5020ds.dts (99%)
 rename arch/powerpc/boot/dts/{ => fsl}/p5040ds.dts (98%)
 rename arch/powerpc/boot/dts/{ => fsl}/ppa8548.dts (97%)
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman-0-10g-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman-0-1g-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman-0-1g-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman-0-1g-2.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman-0-1g-3.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman-0-1g-4.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman-1-10g-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman-1-1g-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman-1-1g-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman-1-1g-2.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman-1-1g-3.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman-1-1g-4.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-0-best-effort.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1-best-effort.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-2.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-3.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-4.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-5.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-2.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-3.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-4.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-5.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-fman3l-0.dtsi
 rename arch/powerpc/boot/dts/{ => fsl}/t1023rdb.dts (98%)
 rename arch/powerpc/boot/dts/{ => fsl}/t1024qds.dts (98%)
 rename arch/powerpc/boot/dts/{ => fsl}/t1024rdb.dts (98%)
 rename arch/powerpc/boot/dts/{ => fsl}/t1040d4rdb.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/t1040qds.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/t1040rdb.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/t1042d4rdb.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/t1042qds.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/t1042rdb.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/t1042rdb_pi.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/t104xd4rdb.dtsi (95%)
 rename arch/powerpc/boot/dts/{ => fsl}/t104xqds.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/t104xrdb.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/t2080qds.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/t2080rdb.dts (97%)
 rename arch/powerpc/boot/dts/{ => fsl}/t2081qds.dts (96%)
 rename arch/powerpc/boot/dts/{ => fsl}/t208xqds.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/t208xrdb.dtsi (100%)
 rename arch/powerpc/boot/dts/{ => fsl}/t4240qds.dts (99%)
 rename arch/powerpc/boot/dts/{ => fsl}/t4240rdb.dts (98%)
 rename arch/powerpc/include/asm/fsl_guts.h => include/linux/fsl/guts.h (98%)
