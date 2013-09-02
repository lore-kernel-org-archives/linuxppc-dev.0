Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 614652C0085
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Sep 2013 15:46:23 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 0/3] powerpc: use jump label for cpu/mmu_has_feature
Date: Mon, 2 Sep 2013 13:45:23 +0800
Message-ID: <1378100726-32545-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v2:
  - Rebase on git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
    since these patches have a dependence on patch 851cf6e7 (jump_label:
    Split jumplabel ratelimit)

  - Drop the first two patches in v1 since they are not needed due to
    the patch 851cf6e7.

v1:
Inspired by Benjamin Herrenschmidt, this patch series try to reduce the
cpu/mmu feature checking overhead by using jump label. The following is
the difference of the run path of cpu_has_feature between before and after
applying these patches:

   before                             after
  addis   r10,r2,1                   b xxx
  addi    r9,r10,-2280               b xxx (This will also be omitted if the
  ld	  r9,0(r9)                          feature is not set)
  ld	  r9,16(r9)
  rldicl. r8,r9,55,63
  beq     c000000000037c94

This patch series passed the build test for almost all the defconfig of ppc.
There does have some broken for some configs. But they are not related to this
change. This also passed allyesconfig for x86. Boot test on p2020rdb and
p5020ds boards.

Kevin Hao (3):
  powerpc: move the cpu_has_feature to a separate file
  powerpc: use the jump label for cpu_has_feature
  powerpc: use jump label for mmu_has_feature

 arch/powerpc/include/asm/cacheflush.h   |  1 +
 arch/powerpc/include/asm/cpufeatures.h  | 41 +++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/cputable.h     |  8 ------
 arch/powerpc/include/asm/cputime.h      |  1 +
 arch/powerpc/include/asm/dbell.h        |  1 +
 arch/powerpc/include/asm/dcr-native.h   |  1 +
 arch/powerpc/include/asm/mman.h         |  1 +
 arch/powerpc/include/asm/mmu.h          | 19 +++++++++++++++
 arch/powerpc/include/asm/time.h         |  1 +
 arch/powerpc/kernel/align.c             |  1 +
 arch/powerpc/kernel/cputable.c          | 43 +++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/irq.c               |  1 +
 arch/powerpc/kernel/process.c           |  1 +
 arch/powerpc/kernel/setup-common.c      |  1 +
 arch/powerpc/kernel/setup_32.c          |  1 +
 arch/powerpc/kernel/smp.c               |  1 +
 arch/powerpc/oprofile/op_model_rs64.c   |  1 +
 arch/powerpc/platforms/cell/pervasive.c |  1 +
 arch/powerpc/xmon/ppc-dis.c             |  1 +
 19 files changed, 118 insertions(+), 8 deletions(-)
 create mode 100644 arch/powerpc/include/asm/cpufeatures.h

-- 
1.8.3.1
