Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gn8h6FTrzF2D3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 16:52:04 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id e6-v6so3727326plt.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 May 2018 23:52:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Alistair Popple <alistair@popple.id.au>
Subject: [PATCH 0/2] powerpc/64s/radix: avoid unnecessary TLB flushes on fault
Date: Wed,  9 May 2018 16:51:50 +1000
Message-Id: <20180509065152.14213-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These two patches make radix match hash and not flush the TLB after
fixing up faults unnecessarily.

There was some concern that accelerators need to have this flush, but
nothing is documented or commented, so it should just be removed. We
have a coprocessor count in the mm context now, and that can easily
be special cased if neccesary.

This and a few other changes reduce our broadcast tlbie rates by 10x
on a kernel compile benchmark, so it would be good to get it in.

Thanks,
Nick

Nicholas Piggin (2):
  powerpc/64s/radix: do not flush TLB when relaxing access
  powerpc/64s/radix: do not flush TLB on spurious fault

 arch/powerpc/include/asm/book3s/64/tlbflush.h | 7 +++++++
 arch/powerpc/mm/pgtable-book3s64.c            | 1 -
 arch/powerpc/mm/pgtable.c                     | 3 ++-
 3 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.17.0
