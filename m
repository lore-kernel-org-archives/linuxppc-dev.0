Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x22a.google.com (mail-yk0-x22a.google.com
 [IPv6:2607:f8b0:4002:c07::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DEBD81A0175
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 22:14:53 +1000 (AEST)
Received: by ykbi184 with SMTP id i184so34944098ykb.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 05:14:51 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/8] powerpc: use jump label for {cpu,mmu}_has_feature()
Date: Thu, 20 Aug 2015 20:14:28 +0800
Message-Id: <1440072876-8321-1-git-send-email-haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I have tried to change the {cpu,mmu}_has_feature() to use jump label two yeas
ago [1]. But that codes seem a bit ugly. This is a reimplementation by moving the
jump_label_init() much earlier so the jump label can be used in a very earlier
stage. Boot test on p4080ds, t2080rdb and powermac (qemu). This patch series
is against linux-next.

[1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2013-September/111026.html

Kevin Hao (8):
  jump_label: no need to acquire the jump_label_mutex in
    jump_lable_init()
  jump_label: make it possible for the archs to invoke jump_label_init()
    much earlier
  jump_label: introduce DEFINE_STATIC_KEY_{TRUE,FALSE}_ARRAY macros
  powerpc: invoke jump_label_init() in a much earlier stage
  powerpc: kill mfvtb()
  powerpc: move the cpu_has_feature to a separate file
  powerpc: use the jump label for cpu_has_feature
  powerpc: use jump label for mmu_has_feature

 arch/powerpc/include/asm/cacheflush.h   |  1 +
 arch/powerpc/include/asm/cpufeatures.h  | 34 +++++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/cputable.h     | 16 ++++++++--------
 arch/powerpc/include/asm/cputime.h      |  1 +
 arch/powerpc/include/asm/dbell.h        |  1 +
 arch/powerpc/include/asm/dcr-native.h   |  1 +
 arch/powerpc/include/asm/mman.h         |  1 +
 arch/powerpc/include/asm/mmu.h          | 29 ++++++++++++++++++++++++++++
 arch/powerpc/include/asm/reg.h          |  9 ---------
 arch/powerpc/include/asm/time.h         |  3 ++-
 arch/powerpc/include/asm/xor.h          |  1 +
 arch/powerpc/kernel/align.c             |  1 +
 arch/powerpc/kernel/cputable.c          | 33 ++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/irq.c               |  1 +
 arch/powerpc/kernel/process.c           |  1 +
 arch/powerpc/kernel/setup-common.c      |  1 +
 arch/powerpc/kernel/setup_32.c          |  5 +++++
 arch/powerpc/kernel/setup_64.c          |  4 ++++
 arch/powerpc/kernel/smp.c               |  1 +
 arch/powerpc/platforms/cell/pervasive.c |  1 +
 arch/powerpc/xmon/ppc-dis.c             |  1 +
 include/linux/jump_label.h              |  6 ++++++
 kernel/jump_label.c                     |  5 +++--
 23 files changed, 137 insertions(+), 20 deletions(-)
 create mode 100644 arch/powerpc/include/asm/cpufeatures.h

-- 
2.1.0
