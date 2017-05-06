Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wKZMf6LqVzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 May 2017 13:42:22 +1000 (AEST)
Date: Fri, 5 May 2017 22:42:11 -0500
From: Scott Wood <oss@buserror.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, galak@kernel.crashing.org
Message-ID: <20170506034211.uxrpzi73mx6c7new@home.buserror.net>
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

Includes a fix for a powerpc/next mm regression on 64e, a fix for a
kernel hang on 64e when using a debugger inside a relocated kernel, a
qman fix, and misc qe improvements.

The following changes since commit 096ff2ddba83bf022d593a3096d683e57c4befb0:

  powerpc/ftrace/64: Split further based on -mprofile-kernel (2017-04-27 22:20:29 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next

for you to fetch changes up to 61baf15555129f69720334f232b153890895ef71:

  powerpc/64e: Don't place the stack beyond TASK_SIZE (2017-05-05 01:22:06 -0500)

----------------------------------------------------------------
Christophe Leroy (3):
      net: ethernet: ucc_geth: fix MEM_PART_MURAM mode
      soc/fsl/qe: get rid of immrbar_virt_to_phys()
      powerpc/8xx: Adding support of IRQ in MPC8xx GPIO

LiuHailong (1):
      powerpc/64e: Fix hang when debugging programs with relocated kernel

Roy Pledge (1):
      soc/fsl/qbman: Disable IRQs for deferred QBMan work

Scott Wood (1):
      powerpc/64e: Don't place the stack beyond TASK_SIZE

Valentin Longchamp (3):
      soc/fsl/qe: round brg_freq to 1kHz granularity
      soc/fsl/qe: only apply QE_General4 workaround on affected SoCs
      soc/fsl/qe: add EXPORT_SYMBOL for the 2 qe_tdm functions

 .../devicetree/bindings/soc/fsl/cpm_qe/gpio.txt    | 21 +++++++++++++++++-
 arch/powerpc/include/asm/cpm1.h                    |  2 ++
 arch/powerpc/include/asm/processor.h               |  5 +++++
 arch/powerpc/kernel/exceptions-64e.S               | 12 +++++++++++
 arch/powerpc/sysdev/cpm1.c                         | 25 ++++++++++++++++++++++
 drivers/net/ethernet/freescale/ucc_geth.c          |  8 +++----
 drivers/soc/fsl/qbman/qman.c                       |  5 +++++
 drivers/soc/fsl/qe/qe.c                            | 25 +++++++++++++++++-----
 drivers/soc/fsl/qe/qe_tdm.c                        |  2 ++
 include/soc/fsl/qe/immap_qe.h                      | 19 ----------------
 include/soc/fsl/qe/qe.h                            |  1 +
 11 files changed, 95 insertions(+), 30 deletions(-)
