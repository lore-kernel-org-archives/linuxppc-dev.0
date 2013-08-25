Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4DB0E2C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Aug 2013 17:16:39 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/5] powerpc: use jump label for cpu/mmu_has_feature
Date: Sun, 25 Aug 2013 15:15:47 +0800
Message-ID: <1377414952-15995-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Inspired by Benjamin Herrenschmidt, this patch series try to reduce the
cpu/mmu feature checking overhead by using jump label. The following is
the difference of the run path of cpu_has_feature between before and after
applying these patches:

   before                             after
  addis   r10,r2,1                   b xxx
  addi    r9,r10,-2280               b xxx (This will also be omitted if the
  ld      r9,0(r9)                          feature is not set)
  ld      r9,16(r9)
  rldicl. r8,r9,55,63
  beq     c000000000037c94

This patch series passed the build test for almost all the defconfig of ppc.
There does have some broken for some configs. But they are not related to this
change. This also passed allyesconfig for x86. Boot test on p2020rdb and
p5020ds boards.

Kevin Hao (5):
  jump_label: factor out the base part of jump_label.h to a separate    
    file
  jump_label: also include linux/atomic.h when jump label is enabled
  powerpc: move the cpu_has_feature to a separate file
  powerpc: use the jump label for cpu_has_feature
  powerpc: use jump label for mmu_has_feature

 arch/powerpc/include/asm/cacheflush.h   |   1 +
 arch/powerpc/include/asm/cpufeatures.h  |  42 ++++++++++
 arch/powerpc/include/asm/cputable.h     |   8 --
 arch/powerpc/include/asm/cputime.h      |   1 +
 arch/powerpc/include/asm/dbell.h        |   1 +
 arch/powerpc/include/asm/dcr-native.h   |   1 +
 arch/powerpc/include/asm/mman.h         |   1 +
 arch/powerpc/include/asm/mmu.h          |  19 +++++
 arch/powerpc/include/asm/time.h         |   1 +
 arch/powerpc/kernel/align.c             |   1 +
 arch/powerpc/kernel/cputable.c          |  43 ++++++++++
 arch/powerpc/kernel/irq.c               |   1 +
 arch/powerpc/kernel/process.c           |   1 +
 arch/powerpc/kernel/setup-common.c      |   1 +
 arch/powerpc/kernel/setup_32.c          |   1 +
 arch/powerpc/kernel/smp.c               |   1 +
 arch/powerpc/oprofile/op_model_rs64.c   |   1 +
 arch/powerpc/platforms/cell/pervasive.c |   1 +
 arch/powerpc/xmon/ppc-dis.c             |   1 +
 include/linux/jump_label.h              | 132 +----------------------------
 include/linux/jump_label_base.h         | 142 ++++++++++++++++++++++++++++++++
 21 files changed, 263 insertions(+), 138 deletions(-)
 create mode 100644 arch/powerpc/include/asm/cpufeatures.h
 create mode 100644 include/linux/jump_label_base.h

-- 
1.8.3.1
