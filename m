Return-Path: <npiggin@gmail.com>
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bH8t1HBYzDrHF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 00:06:53 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id p23-v6so5390979pgv.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 07:06:53 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-mm@kvack.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 0/4] mm: mmu_gather changes to support explicit paging
Date: Thu, 26 Jul 2018 00:06:37 +1000
Message-Id: <20180725140641.30372-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The first 3 patches in this series are some generic mm changes I
would like to make, including a possible fix which may(?) be needed
for ARM64. Other than the bugfix, these first 3 patches should not
change anything so hopefully they aren't too controversial.

The powerpc patch is also there for reference. 

Thanks,
Nick

Nicholas Piggin (4):
  mm: move tlb_table_flush to tlb_flush_mmu_free
  mm: mmu_notifier fix for tlb_end_vma
  mm: allow arch to have tlb_flush caled on an empty TLB range
  powerpc/64s/radix: optimise TLB flush with precise TLB ranges in
    mmu_gather

 arch/powerpc/include/asm/tlb.h | 34 +++++++++++++++++++++++++++++++++
 arch/powerpc/mm/tlb-radix.c    | 10 ++++++++++
 include/asm-generic/tlb.h      | 35 ++++++++++++++++++++++++++++++----
 mm/memory.c                    | 14 ++------------
 4 files changed, 77 insertions(+), 16 deletions(-)

-- 
2.17.0
