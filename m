Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v9Ghx0RwHzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jan 2017 11:28:16 +1100 (AEDT)
Date: Fri, 27 Jan 2017 17:53:48 -0600
From: Scott Wood <oss@buserror.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, galak@kernel.crashing.org
Message-ID: <20170127235348.GA21260@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Pull request: scottwood/linux.git next
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Highlights include 8xx breakpoints and perf, t1042rdb display support,
and board updates.

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next

for you to fetch changes up to 75b824727680a9d12c34d78096a5ac642e53f5d0:

  powerpc/8xx: Perf events on PPC 8xx (2017-01-26 17:49:34 -0600)

----------------------------------------------------------------
Christophe Leroy (4):
      powerpc/32: Enable HW_BREAKPOINT on BOOK3S
      powerpc/8xx: Implement hw_breakpoint
      powerpc/32: Remove FIX_SRR1
      powerpc/8xx: Perf events on PPC 8xx

Jason Jin (1):
      powerpc/85xx: Enable display support for t1042rdb

Valentin Longchamp (3):
      powerpc/corenet: explicitly disable the SDHC controller on kmcoge4
      powerpc/85xx: remove the kmp204x_defconfig
      powerpc/corenet: add support for the kmcent2 board

 arch/powerpc/Kconfig                          |   2 +-
 arch/powerpc/boot/dts/fsl/kmcent2.dts         | 303 ++++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/kmcoge4.dts         |   4 +
 arch/powerpc/configs/85xx/kmp204x_defconfig   | 220 -------------------
 arch/powerpc/include/asm/ppc_asm.h            |   1 -
 arch/powerpc/include/asm/processor.h          |   2 +-
 arch/powerpc/include/asm/reg.h                |   2 +
 arch/powerpc/include/asm/reg_8xx.h            |  11 +
 arch/powerpc/kernel/entry_32.S                |  19 +-
 arch/powerpc/kernel/head_32.S                 |   3 -
 arch/powerpc/kernel/head_8xx.S                |  72 +++++-
 arch/powerpc/kernel/hw_breakpoint.c           |   6 +-
 arch/powerpc/kernel/process.c                 |  22 ++
 arch/powerpc/perf/8xx-pmu.c                   | 173 +++++++++++++++
 arch/powerpc/perf/Makefile                    |   2 +
 arch/powerpc/platforms/85xx/Makefile          |   1 +
 arch/powerpc/platforms/85xx/corenet_generic.c |   1 +
 arch/powerpc/platforms/85xx/t1042rdb_diu.c    | 152 +++++++++++++
 arch/powerpc/platforms/Kconfig.cputype        |   7 +
 19 files changed, 771 insertions(+), 232 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/kmcent2.dts
 delete mode 100644 arch/powerpc/configs/85xx/kmp204x_defconfig
 create mode 100644 arch/powerpc/perf/8xx-pmu.c
 create mode 100644 arch/powerpc/platforms/85xx/t1042rdb_diu.c
