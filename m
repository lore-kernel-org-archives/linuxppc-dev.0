Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xPqqS5PdFzDqjm
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Aug 2017 03:03:00 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id c65so4851719pfl.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Aug 2017 10:03:00 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 00/13] idle and soft-irq improvements and POWER9 idle
 optimisation
Date: Sun,  6 Aug 2017 03:02:28 +1000
Message-Id: <20170805170241.22966-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The first 9 patches are a bunch of independent small cleanups
and improvements I've collected. The next 4 are improvements to
POWER9 idle state entry and exit. They significantly change how
we enter idle, now in virtual mode and without ptesync. EC=0 idle
is significantly simplified from there, and does not save anything.

This runs fine on a DD1 test machine, but the hardware has some
problem with performance all over the place, so I'm not able to get
anything meaningful there yet.

Thanks,
Nick

Nicholas Piggin (13):
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
  powerpc/64s: idle simplify KVM idle on POWER9
  powerpc/64s: idle POWER9 can execute stop without ptesync
  powerpc/64s: idle POWER9 can execute stop in virtual mode
  powerpc/64s: idle ESL=0 stop can avoid all save/restore overhead

 arch/powerpc/include/asm/kvm_book3s_asm.h |  4 +++
 arch/powerpc/kernel/entry_64.S            |  7 +---
 arch/powerpc/kernel/exceptions-64s.S      | 19 +++++-----
 arch/powerpc/kernel/idle_book3s.S         | 60 ++++++++++++++-----------------
 arch/powerpc/kernel/irq.c                 | 47 ++++++++++++------------
 arch/powerpc/kernel/process.c             | 35 +++++++++++++-----
 arch/powerpc/kvm/book3s_hv.c              | 37 ++++++++++++++++---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   | 32 ++++++++++-------
 8 files changed, 143 insertions(+), 98 deletions(-)

-- 
2.11.0
