Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTW1W20rszDqkX
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 02:39:27 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id 83so3495358pgb.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 09:39:27 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 00/14] idle and soft-irq improvements and POWER9 idle
 optimisation
Date: Sat, 12 Aug 2017 02:38:58 +1000
Message-Id: <20170811163912.28783-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since last time:

- Split out KVM parts. Technically they don't actually have
  dependencies with the Linux patches I suppose, so they could be
  merged via different trees. Logically I think they are better to
  stay together.

- Fix and simplify the KVM secondary thread management patch, thanks
  Gautham.

- Fixed a bug in the ESL=0 avoid overhead patch.

- Retested on P8 and P9 with qemu.

- Mambo simulator still doesn't handle EC=0 wakeups properly, but I
  have reported that, and managed to write a patch here to fix the
  simulator bug and test there too.

Nicholas Piggin (14):
  powerpc/64s: masked interrupt avoid branch
  powerpc/64s: masked interrupt avoid instruction
  powerpc/64s: masked interrupt returns to kernel so avoid r13 restore
  powerpc/64: cleanup __check_irq_replay
  powerpc/64s: irq replay merge HV and non-HV paths for doorbell replay
  powerpc/64s: irq replay external use the HV handler in HV mode on
    POWER9
  powerpc/64: remove redundant instruction in interrupt replay
  powerpc/64s: irq replay remove spurious irq reason
  powerpc/64: runlatch CTRL[RUN] set optimisation
  KVM: PPC: Book3S HV: POWER9 does not require secondary thread
    management
  powerpc/64s: idle POWER9 can execute stop without a sync sequence
  KVM: PPC: Book3S HV: POWER9 can execute stop without a sync sequence
  powerpc/64s: idle POWER9 can execute stop in virtual mode
  powerpc/64s: idle ESL=0 stop can avoid MSR and save/restore overhead

 arch/powerpc/include/asm/cpuidle.h        |  16 -----
 arch/powerpc/include/asm/kvm_book3s_asm.h |   4 ++
 arch/powerpc/kernel/entry_64.S            |   7 +-
 arch/powerpc/kernel/exceptions-64s.S      |  19 +++---
 arch/powerpc/kernel/idle_book3s.S         | 103 +++++++++++++++++-------------
 arch/powerpc/kernel/irq.c                 |  47 +++++++-------
 arch/powerpc/kernel/process.c             |  35 +++++++---
 arch/powerpc/kvm/book3s_hv.c              |  14 +++-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   |  32 ++++++----
 9 files changed, 154 insertions(+), 123 deletions(-)

-- 
2.13.3
