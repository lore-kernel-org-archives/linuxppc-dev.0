Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x230.google.com (mail-pg0-x230.google.com
 [IPv6:2607:f8b0:400e:c05::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wW2Nt2d07zDqLb
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 May 2017 23:16:13 +1000 (AEST)
Received: by mail-pg0-x230.google.com with SMTP id q125so56264418pgq.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 May 2017 06:16:13 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/9] Reduce PACA save areas
Date: Sun, 21 May 2017 23:15:41 +1000
Message-Id: <20170521131550.25813-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I want to save another register in the PACA, so I had a look at
what we might cut from it first. 3-4 fields are reasonably easy
to remove.

Nicholas Piggin (9):
  powerpc/64s: slb_allocate_realmode() preserve r3
  powerpc/64s: SLB miss handler avoid saving faulting address into
    EX_DAR
  powerpc/64s: SLB miss already has CTR saved for relocatable kernel
  powerpc/64s: SLB miss handler avoid r3 save/restore
  powerpc/64s: paca add EX_SIZE definition for exception save areas
  powerpc/64s: paca EX_SRR0 is unused, remove it
  powerpc/64s: paca EX_LR can be merged with EX_DAR
  powerpc/64s: paca EX_R3 can be merged with EX_DAR
  powerpc/64s: paca EX_CTR is not used with !RELOCATABLE, remove it

 arch/powerpc/include/asm/exception-64s.h | 53 ++++++++++++++++++++++---------
 arch/powerpc/include/asm/paca.h          | 12 ++++---
 arch/powerpc/kernel/exceptions-64s.S     | 54 +++++++++++++++++---------------
 arch/powerpc/mm/slb_low.S                | 24 ++++++++------
 4 files changed, 88 insertions(+), 55 deletions(-)

-- 
2.11.0
