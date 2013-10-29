Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 022872C00DC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 13:44:23 +1100 (EST)
Date: Mon, 28 Oct 2013 21:44:12 -0500
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>
Subject: Pull request: scottwood/linux.git next
Message-ID: <20131029024412.GA25844@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sorry again for the lateness.  I tried to get this done before the
conferences last week, but it just didn't happen.

Highlights include corenet board file consolidation, the ability to run
userspaces with lwsync on e500v1/v2, some cleanup patches that other KVM
patches will build on, support for stripped-down e6500 emulation targets,
and some fixes of minor longstanding issues.

Some of the more complicated and/or more recently posted patches didn't
make it this time around; this doesn't mean I've forgotten them (as long
as they're in patchwork in an action required state), just that I've run
out of time for 3.13.

The following changes since commit 3ad26e5c4459d3793ad65bc8929037c70515df83:

  Merge branch 'for-kvm' into next (2013-10-11 18:23:53 +1100)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next

for you to fetch changes up to b60c5a7a82cdfec2221263ce259faa4a36696163:

  powerpc/6xx: CONFIG_MCU_MPC8349EMITX cannot be a module (2013-10-28 21:11:24 -0500)

----------------------------------------------------------------
Bharat Bhushan (3):
      powerpc: remove unnecessary line continuations
      powerpc: move debug registers in a structure
      powerpc: export debug registers save function for KVM

Christian Kujau (1):
      powerpc/6xx: CONFIG_MCU_MPC8349EMITX cannot be a module

Chunhe Lan (1):
      powerpc/pci: Change the DECLARE_PCI_FIXUP_{HEADER => EARLY} macro of pci quirk

Haijun.Zhang (2):
      powerpc/eSDCH: Specify voltage for T4240QDS
      powerpc/dts: Correct sdhci quirk for bsc9131

Hongtao Jia (1):
      powerpc: Add I2C bus multiplexer node for B4 and T4240QDS

James Yang (2):
      powerpc: Emulate sync instruction variants
      powerpc/booke: clear DBCR0_BT in user_disable_single_step()

Kevin Hao (3):
      powerpc/85xx: introduce corenet_generic machine
      powerpc/85xx: rename the corenet_ds.c to corenet_generic.c
      powerpc/85xx: use one kernel option for all the CoreNet_Generic boards

LEROY Christophe (4):
      powerpc/mpc8xx: Clearer Oops message for Software Emulation Exception
      powerpc/8xx: Revert commit e0908085fc2391c85b85fb814ae1df377c8e0dcb
      powerpc/8xx: Fixing issue with CONFIG_PIN_TLB
      powerpc/8xx: Fixing memory init issue with CONFIG_PIN_TLB

Lijun Pan (2):
      powerpc/e6500: Include Power ISA properties
      powerpc/e500v2: Include Power ISA properties

Mihai Caraman (2):
      powerpc/booke64: Use common defines for AltiVec interrupts numbers
      powerpc/fsl-booke: Use common defines for SPE/FP interrupts numbers

Minghuan Lian (1):
      powerpc/dts: fix sRIO error interrupt for b4860

Paul Bolle (1):
      powerpc: remove dependency on MV64360

Prabhakar Kushwaha (1):
      powerpc/dts/c293pcie: Add range field for IFC NAND

Scott Wood (1):
      powerpc/b4qds: enable coreint

Shengzhou Liu (1):
      powerpc/fsl/defconfig: enable CONFIG_AT803X_PHY

Suzuki Poulose (1):
      powerpc: Set the NOTE type for SPE regset

Tiejun Chen (1):
      powerpc/kgdb: use DEFINE_PER_CPU to allocate kgdb's thread_info

Wei Yongjun (2):
      powerpc/6xx: add missing iounmap() on error in hlwd_pic_init()
      powerpc/mv643xx_eth: fix return check in mv64x60_eth_register_shared_pdev()

Wolfram Sang (1):
      arch/powerpc/platforms/83xx: Remove obsolete cleanup for clientdata

York Sun (2):
      powerpc/t4240emu: Add device tree file for t4240emu
      powerpc/b4860emu: Add device tree file for b4860emu

Zhao Qiang (1):
      powerpc/p1010rdb: add P1010RDB-PB platform support

 arch/powerpc/Kconfig                           |   2 +-
 arch/powerpc/boot/dts/b4860emu.dts             | 218 ++++++++++++++++++++
 arch/powerpc/boot/dts/b4qds.dtsi               |  51 +++--
 arch/powerpc/boot/dts/c293pcie.dts             |   1 +
 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi     |   2 +
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi    |   2 +-
 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi     |   2 +
 arch/powerpc/boot/dts/fsl/bsc9131si-post.dtsi  |   2 +-
 arch/powerpc/boot/dts/fsl/bsc9131si-pre.dtsi   |   3 +
 arch/powerpc/boot/dts/t4240emu.dts             | 268 +++++++++++++++++++++++++
 arch/powerpc/boot/dts/t4240qds.dts             |  73 ++++---
 arch/powerpc/configs/corenet32_smp_defconfig   |   7 +-
 arch/powerpc/configs/corenet64_smp_defconfig   |   5 +-
 arch/powerpc/configs/mpc85xx_defconfig         |   1 +
 arch/powerpc/configs/mpc85xx_smp_defconfig     |   1 +
 arch/powerpc/configs/ppc64e_defconfig          |   2 +-
 arch/powerpc/configs/ppc6xx_defconfig          |   2 +-
 arch/powerpc/include/asm/ppc-opcode.h          |   2 +
 arch/powerpc/include/asm/processor.h           |  34 ++--
 arch/powerpc/include/asm/reg_booke.h           |   8 +-
 arch/powerpc/include/asm/switch_to.h           |   1 +
 arch/powerpc/kernel/asm-offsets.c              |   2 +-
 arch/powerpc/kernel/exceptions-64e.S           |   5 +-
 arch/powerpc/kernel/head_8xx.S                 |   3 +
 arch/powerpc/kernel/head_fsl_booke.S           |  10 +-
 arch/powerpc/kernel/kgdb.c                     |   6 +-
 arch/powerpc/kernel/process.c                  |  45 +++--
 arch/powerpc/kernel/ptrace.c                   | 156 +++++++-------
 arch/powerpc/kernel/ptrace32.c                 |   2 +-
 arch/powerpc/kernel/signal_32.c                |   6 +-
 arch/powerpc/kernel/traps.c                    |  45 +++--
 arch/powerpc/mm/init_32.c                      |   5 +
 arch/powerpc/mm/pgtable.c                      |  19 +-
 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c |   1 -
 arch/powerpc/platforms/85xx/Kconfig            | 101 +---------
 arch/powerpc/platforms/85xx/Makefile           |   8 +-
 arch/powerpc/platforms/85xx/b4_qds.c           | 102 ----------
 arch/powerpc/platforms/85xx/corenet_ds.c       |  96 ---------
 arch/powerpc/platforms/85xx/corenet_ds.h       |  19 --
 arch/powerpc/platforms/85xx/corenet_generic.c  | 182 +++++++++++++++++
 arch/powerpc/platforms/85xx/p1010rdb.c         |   2 +
 arch/powerpc/platforms/85xx/p2041_rdb.c        |  87 --------
 arch/powerpc/platforms/85xx/p3041_ds.c         |  89 --------
 arch/powerpc/platforms/85xx/p4080_ds.c         |  87 --------
 arch/powerpc/platforms/85xx/p5020_ds.c         |  93 ---------
 arch/powerpc/platforms/85xx/p5040_ds.c         |  84 --------
 arch/powerpc/platforms/85xx/t4240_qds.c        |  93 ---------
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c  |   1 +
 arch/powerpc/sysdev/fsl_pci.c                  |   5 +-
 arch/powerpc/sysdev/mv64x60_dev.c              |   2 +-
 50 files changed, 962 insertions(+), 1081 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/b4860emu.dts
 create mode 100644 arch/powerpc/boot/dts/t4240emu.dts
 delete mode 100644 arch/powerpc/platforms/85xx/b4_qds.c
 delete mode 100644 arch/powerpc/platforms/85xx/corenet_ds.c
 delete mode 100644 arch/powerpc/platforms/85xx/corenet_ds.h
 create mode 100644 arch/powerpc/platforms/85xx/corenet_generic.c
 delete mode 100644 arch/powerpc/platforms/85xx/p2041_rdb.c
 delete mode 100644 arch/powerpc/platforms/85xx/p3041_ds.c
 delete mode 100644 arch/powerpc/platforms/85xx/p4080_ds.c
 delete mode 100644 arch/powerpc/platforms/85xx/p5020_ds.c
 delete mode 100644 arch/powerpc/platforms/85xx/p5040_ds.c
 delete mode 100644 arch/powerpc/platforms/85xx/t4240_qds.c
