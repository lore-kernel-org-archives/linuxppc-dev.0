Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1yRQ4WSKzDrd1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2017 01:52:18 +1100 (AEDT)
Received: by mail-pl0-x241.google.com with SMTP id b12so9124419plm.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 06:52:18 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 0/8] use r14 for a per-cpu kernel register
Date: Thu, 21 Dec 2017 00:51:58 +1000
Message-Id: <20171220145206.12234-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This makes r14 a fixed register and used to store per-cpu stuff in
the kernel, including read-write fields that are retained over
interrupts. It ends up being most useful for speeding up per-cpu
pointer dereferencing and soft-irq masking and testing. But it can
also reduce the number of loads and stores in the interrupt entry
paths by moving several bits of interest into r14 (another bit I'm
looking at is adding a bit for HSTATE_IN_GUEST to speed up kvmtest).

The series goes on top of Maddy's softi-irq patches, it works on 64s,
but KVM and 64e are probably broken at the moment. So it's not
intended to merge yet, but if people like the result then maybe the
first patch can be merged to stop using r14 in preparation.

Nicholas Piggin (8):
  powerpc/64s: stop using r14 register
  powerpc/64s: poison r14 register while in kernel
  powerpc/64s: put the per-cpu data_offset in r14
  powerpc/64s: put io_sync bit into r14
  powerpc/64s: put work_pending bit into r14
  powerpc/64s: put irq_soft_mask bits into r14
  powerpc/64s: put irq_soft_mask and irq_happened bits into r14
  powerpc/64s: inline local_irq_enable/restore

 arch/powerpc/Makefile                          |   1 +
 arch/powerpc/crypto/md5-asm.S                  |  40 +++----
 arch/powerpc/crypto/sha1-powerpc-asm.S         |  10 +-
 arch/powerpc/include/asm/exception-64s.h       | 127 +++++++++++----------
 arch/powerpc/include/asm/hw_irq.h              | 130 ++++++++++-----------
 arch/powerpc/include/asm/io.h                  |  11 +-
 arch/powerpc/include/asm/irqflags.h            |  24 ++--
 arch/powerpc/include/asm/kvm_book3s_asm.h      |   2 +-
 arch/powerpc/include/asm/kvm_ppc.h             |   6 +-
 arch/powerpc/include/asm/paca.h                |  73 +++++++++++-
 arch/powerpc/include/asm/percpu.h              |   2 +-
 arch/powerpc/include/asm/ppc_asm.h             |  21 +++-
 arch/powerpc/include/asm/spinlock.h            |  21 ++--
 arch/powerpc/kernel/asm-offsets.c              |  23 +++-
 arch/powerpc/kernel/entry_32.S                 |   4 +-
 arch/powerpc/kernel/entry_64.S                 |  95 ++++++++++------
 arch/powerpc/kernel/exceptions-64s.S           |  52 ++++-----
 arch/powerpc/kernel/head_64.S                  |  25 ++--
 arch/powerpc/kernel/idle_book3s.S              |  86 +++++++-------
 arch/powerpc/kernel/irq.c                      |  92 ++++++---------
 arch/powerpc/kernel/kgdb.c                     |   8 +-
 arch/powerpc/kernel/optprobes_head.S           |   3 +-
 arch/powerpc/kernel/paca.c                     |   1 -
 arch/powerpc/kernel/process.c                  |   6 +-
 arch/powerpc/kernel/setup_64.c                 |  19 +++-
 arch/powerpc/kernel/time.c                     |  15 +--
 arch/powerpc/kernel/tm.S                       |  40 ++++---
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S |  10 +-
 arch/powerpc/kvm/book3s_hv.c                   |   6 +-
 arch/powerpc/kvm/book3s_hv_interrupts.S        |   5 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S        |   3 +-
 arch/powerpc/kvm/book3s_interrupts.S           |  93 +++++++++++----
 arch/powerpc/kvm/book3s_pr.c                   |   6 +
 arch/powerpc/lib/checksum_64.S                 |  66 +++++------
 arch/powerpc/lib/copypage_power7.S             |  32 +++---
 arch/powerpc/lib/copyuser_power7.S             | 152 ++++++++++++-------------
 arch/powerpc/lib/crtsavres.S                   |   3 +
 arch/powerpc/lib/memcpy_power7.S               |  80 ++++++-------
 arch/powerpc/lib/sstep.c                       |   1 +
 arch/powerpc/xmon/xmon.c                       |   7 +-
 40 files changed, 764 insertions(+), 637 deletions(-)

-- 
2.15.0
