Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdpBQ2Wn7zDrK0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Aug 2017 14:30:54 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id t3so2161362pgt.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 21:30:54 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH v3 0/4] powerpc/64s: idle POWER9 stop improvements
Date: Fri, 25 Aug 2017 14:30:32 +1000
Message-Id: <20170825043036.18236-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These are rebased patches leftover from the unmerged bit of
the idle series.

Based on feedback, I dropped one of the KVM patches, and reworked
the code a bit so it is easier to restore the ability for KVM to
grab secondaries into real mode.

I did a bit more benchmarking, and all up these patches improve 2
CPU ping-pong context switch benchmark on a POWER9 by around 4-6%
(depending on what CPUs and idle states are used).

Nicholas Piggin (4):
  KVM: PPC: Book3S HV: POWER9 does not require secondary thread
    management
  powerpc/64s: idle POWER9 can execute stop without a sync sequence
  powerpc/64s: idle POWER9 can execute stop in virtual mode
  powerpc/64s: idle ESL=0 stop can avoid MSR and save/restore overhead

 arch/powerpc/include/asm/cpuidle.h        |  16 -----
 arch/powerpc/include/asm/kvm_book3s_asm.h |   4 ++
 arch/powerpc/kernel/idle_book3s.S         | 103 ++++++++++++++++++++++--------
 arch/powerpc/kvm/book3s_hv.c              |  14 +++-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   |   8 +++
 5 files changed, 101 insertions(+), 44 deletions(-)

-- 
2.13.3
