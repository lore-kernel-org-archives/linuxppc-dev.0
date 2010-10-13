Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D1D181007E9
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 09:08:30 +1100 (EST)
Date: Wed, 13 Oct 2010 17:08:09 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git next branch
Message-ID: <Pine.LNX.4.64.1010131706440.4711@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following changes since commit 4108d9ba9091c55cfb968d42dd7dcae9a098b876:

  powerpc/Makefiles: Change to new flag variables (2010-10-13 16:19:22 +1100)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git next

Harninder Rai (1):
      powerpc/fsl: 85xx: add cache-sram support

Ilya Yanok (1):
      powerpc/mpc83xx: Support for MPC8308 P1M board

Kumar Gala (10):
      powerpc/fsl-pci: Fix MSI support on 83xx platforms
      powerpc/mpc8xxx_gpio: Add support for 'qoriq-gpio' controllers
      powerpc/fsl-booke: Add PCI device ids for P2040/P3041/P5010/P5020 QoirQ chips
      powerpc/fsl-booke: Add p3041 DS board support
      powerpc: Fix compile error with paca code on ppc64e
      powerpc/fsl-booke: Add support for FSL 64-bit e5500 core
      powerpc/fsl-booke: Add support for FSL Arch v1.0 MMU in setup_page_sizes
      powerpc/fsl-booke64: Use TLB CAMs to cover linear mapping on FSL 64-bit chips
      powerpc/fsl-booke: Add p5020 DS board support
      powerpc/fsl-booke: Add e55xx (64-bit) smp defconfig

Matthew McClintock (6):
      powerpc/kexec: make masking/disabling interrupts generic
      powerpc/85xx: Remove call to mpic_teardown_this_cpu in kexec
      powerpc/85xx: Minor fixups for kexec on 85xx
      powerpc/85xx: flush dcache before resetting cores
      powerpc/fsl_soc: Search all global-utilities nodes for rstccr
      powerpc/fsl_booke: Add support to boot from core other than 0

Paul Gortmaker (1):
      powerpc: Fix invalid page flags in create TLB CAM path for PTE_64BIT

Scott Wood (1):
      oprofile/fsl emb: Don't set MSR[PMM] until after clearing the interrupt.

Timur Tabi (4):
      powerpc: export ppc_proc_freq and ppc_tb_freq as GPL symbols
      powerpc/watchdog: Allow the Book-E driver to be compiled as a module
      powerpc/p1022: Add probing for individual DMA channels
      powerpc/85xx: add ngPIXIS FPGA device tree node to the P1022DS board

 arch/powerpc/boot/dts/mpc8308_p1m.dts          |  332 ++++++++++++++++++++++++
 arch/powerpc/boot/dts/p1022ds.dts              |   11 +
 arch/powerpc/configs/e55xx_smp_defconfig       |   84 ++++++
 arch/powerpc/configs/ppc64e_defconfig          |    4 +-
 arch/powerpc/include/asm/fsl_85xx_cache_sram.h |   48 ++++
 arch/powerpc/include/asm/kexec.h               |    1 +
 arch/powerpc/include/asm/mmu-book3e.h          |   15 +
 arch/powerpc/include/asm/pte-common.h          |    7 +
 arch/powerpc/kernel/Makefile                   |    4 +-
 arch/powerpc/kernel/asm-offsets.c              |    4 +-
 arch/powerpc/kernel/cpu_setup_fsl_booke.S      |   15 +
 arch/powerpc/kernel/cputable.c                 |   28 ++-
 arch/powerpc/kernel/crash.c                    |   13 +-
 arch/powerpc/kernel/head_fsl_booke.S           |   10 +-
 arch/powerpc/kernel/machine_kexec.c            |   24 ++
 arch/powerpc/kernel/machine_kexec_32.c         |    4 +
 arch/powerpc/kernel/paca.c                     |    2 +-
 arch/powerpc/kernel/setup_32.c                 |    2 +-
 arch/powerpc/kernel/time.c                     |    3 +-
 arch/powerpc/kernel/traps.c                    |    5 +
 arch/powerpc/mm/Makefile                       |    2 +-
 arch/powerpc/mm/fsl_booke_mmu.c                |   15 +-
 arch/powerpc/mm/mmu_decl.h                     |    5 +-
 arch/powerpc/mm/tlb_nohash.c                   |   56 ++++-
 arch/powerpc/mm/tlb_nohash_low.S               |    2 +-
 arch/powerpc/oprofile/op_model_fsl_emb.c       |   15 +-
 arch/powerpc/platforms/83xx/Kconfig            |    4 +-
 arch/powerpc/platforms/83xx/mpc830x_rdb.c      |    3 +-
 arch/powerpc/platforms/85xx/Kconfig            |   28 ++-
 arch/powerpc/platforms/85xx/Makefile           |    2 +
 arch/powerpc/platforms/85xx/p1022_ds.c         |    2 +
 arch/powerpc/platforms/85xx/p3041_ds.c         |   64 +++++
 arch/powerpc/platforms/85xx/p5020_ds.c         |   69 +++++
 arch/powerpc/platforms/85xx/smp.c              |   76 +++++-
 arch/powerpc/platforms/Kconfig.cputype         |    8 +-
 arch/powerpc/sysdev/Makefile                   |    1 +
 arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h      |  101 +++++++
 arch/powerpc/sysdev/fsl_85xx_cache_sram.c      |  159 +++++++++++
 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c          |  231 ++++++++++++++++
 arch/powerpc/sysdev/fsl_msi.c                  |    9 +-
 arch/powerpc/sysdev/fsl_pci.c                  |   51 ++++-
 arch/powerpc/sysdev/fsl_pci.h                  |    1 +
 arch/powerpc/sysdev/fsl_soc.c                  |   20 +-
 arch/powerpc/sysdev/mpc8xxx_gpio.c             |    3 +
 drivers/watchdog/Kconfig                       |    5 +-
 drivers/watchdog/booke_wdt.c                   |   39 +++-
 include/linux/pci_ids.h                        |    8 +
 47 files changed, 1516 insertions(+), 79 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/mpc8308_p1m.dts
 create mode 100644 arch/powerpc/configs/e55xx_smp_defconfig
 create mode 100644 arch/powerpc/include/asm/fsl_85xx_cache_sram.h
 create mode 100644 arch/powerpc/platforms/85xx/p3041_ds.c
 create mode 100644 arch/powerpc/platforms/85xx/p5020_ds.c
 create mode 100644 arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h
 create mode 100644 arch/powerpc/sysdev/fsl_85xx_cache_sram.c
 create mode 100644 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
