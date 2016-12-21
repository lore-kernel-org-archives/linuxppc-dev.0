Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tkNVH1Z7dzDt0L
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2016 05:29:43 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id i88so11221780pfk.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 10:29:43 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Alexander Graf <agraf@suse.com>,
 kvm-ppc@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/3] KVM: PPC: Book3S: 64-bit CONFIG_RELOCATABLE fixes
Date: Thu, 22 Dec 2016 04:29:24 +1000
Message-Id: <20161221182927.24562-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I took into account the feedback from last time. I was sceptical at
first about moving the store to save r9 from the KVM test to the
KVM handler. After implementing it, it actually worked well.

Thanks,
Nick

Nicholas Piggin (3):
  KVM: PPC: Book3S: Change interrupt call to reduce scratch space use on HV
  KVM: PPC: Book3S: Move 64-bit KVM interrupt handler out from alt section
  KVM: PPC: Book3S: 64-bit CONFIG_RELOCATABLE support for interrupts

 arch/powerpc/include/asm/exception-64s.h | 63 ++++++++++++++++++++++++--------
 arch/powerpc/include/asm/head-64.h       |  2 +-
 arch/powerpc/kernel/exceptions-64s.S     | 10 ++---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  | 15 ++++++--
 arch/powerpc/kvm/book3s_segment.S        | 32 ++++++++++++----
 5 files changed, 89 insertions(+), 33 deletions(-)

-- 
2.11.0
