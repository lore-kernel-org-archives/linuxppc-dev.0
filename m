Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTpY071KWzDvyM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 18:18:28 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id 144so11449786pfv.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 23:18:28 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Alexander Graf <agraf@suse.com>,
 kvm-ppc@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/3] KVM: PPC: Book3S: 64-bit CONFIG_RELOCATABLE fixes
Date: Thu,  1 Dec 2016 18:18:09 +1100
Message-Id: <20161201071812.23258-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I didn't get any objections to the approach proposed in my
earlier RFC, so I've gone ahead with R12 = (CR | trap #) approach.
It avoided an extra register save with HV and the PR handler ended
up not being too bad.

This passed KVM boot testing with 64-bit HV and PR, with the (host)
kernel running at non-0. Without these patches, the same configuration
crashes immediately.

Thanks,
Nick

Nicholas Piggin (3):
  KVM: PPC: Book3S: Change interrupt call to reduce scratch space use on
    HV
  KVM: PPC: Book3S: Move 64-bit KVM interrupt handler out from alt
    section
  KVM: PPC: Book3S: 64-bit CONFIG_RELOCATABLE support for interrupts

 arch/powerpc/include/asm/exception-64s.h | 67 +++++++++++++++++++++++++-------
 arch/powerpc/include/asm/head-64.h       |  2 +-
 arch/powerpc/kernel/exceptions-64s.S     | 10 ++---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  | 19 +++++----
 arch/powerpc/kvm/book3s_segment.S        | 32 +++++++++++----
 5 files changed, 94 insertions(+), 36 deletions(-)

-- 
2.10.2
