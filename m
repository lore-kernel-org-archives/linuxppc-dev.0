Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40DPYd0Vb3zF20w
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2018 15:49:08 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id o16so2385345pfk.9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2018 22:49:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH v3 0/3] idle improvements again
Date: Sun,  1 Apr 2018 15:48:52 +1000
Message-Id: <20180401054855.17864-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since last time, this has been rebased on top of the KVM / SMT4
forcing changes. It has also been updated so as to not disable
EC=ESL=0 idle states for CPU unplug.

That case (and powersave=off) continues to be broken for KVM with
unplugged dependent secondaries, but that's another issue.

This also has EC=ESL=0 states to skip the new hwsync added for the
KVM workaround, which should increase their performance advantage a
little further.

Thanks,
Nick

Nicholas Piggin (3):
  powerpc/64s/idle: POWER9 implement a separate idle stop function for
    hotplug
  powerpc/64s/idle: avoid sync for KVM state when waking from idle
  powerpc/64s/idle: POWER9 ESL=0 stop avoid save/restore overhead

 arch/powerpc/include/asm/processor.h  |  1 +
 arch/powerpc/kernel/idle_book3s.S     | 69 +++++++++++++++++------------------
 arch/powerpc/platforms/powernv/idle.c |  2 +-
 3 files changed, 36 insertions(+), 36 deletions(-)

-- 
2.16.3
