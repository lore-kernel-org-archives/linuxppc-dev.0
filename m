Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x235.google.com (mail-pg0-x235.google.com
 [IPv6:2607:f8b0:400e:c05::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwx8r6pcpzF1WK
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 12:37:32 +1100 (AEDT)
Received: by mail-pg0-x235.google.com with SMTP id g12so293372pgs.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Mar 2018 17:37:32 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 00/10] powerpc/mm/slice: improve slice speed and stack use
Date: Wed,  7 Mar 2018 11:37:08 +1000
Message-Id: <20180307013718.13749-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Overall on POWER8, this series increases vfork+exec+exit
microbenchmark rate by 15.6%, and mmap+munmap rate by 81%. Slice
code/data size is reduced by 1kB, and max stack overhead through
slice_get_unmapped_area call goes rom 992 to 448 bytes. The cost is
288 bytes added to the mm_context_t per mm for the slice masks on
Book3S.

Since v1:
- Fixed a couple of bugs and compile errors on 8xx.
- Accounted for all Christophe's review feedback hopefully.
- Got rid of unrelated "cleanup" hunks, and split one to its own patch.
- Dropped patch to dynamically limit bitmap operations. This may be
  revisited after Aneesh's 4TB patches.

Thanks,
Nick

Nicholas Piggin (10):
  powerpc/mm/slice: Simplify and optimise slice context initialisation
  powerpc/mm/slice: tidy lpsizes and hpsizes update loops
  powerpc/mm/slice: pass pointers to struct slice_mask where possible
  powerpc/mm/slice: implement a slice mask cache
  powerpc/mm/slice: implement slice_check_range_fits
  powerpc/mm/slice: Switch to 3-operand slice bitops helpers
  powerpc/mm/slice: remove dead code
  powerpc/mm/slice: Use const pointers to cached slice masks where
    possible
  powerpc/mm/slice: remove radix calls to the slice code
  powerpc/mm/slice: use the dynamic high slice size to limit bitmap
    operations

 arch/powerpc/include/asm/book3s/64/mmu.h |  18 ++
 arch/powerpc/include/asm/hugetlb.h       |   7 +-
 arch/powerpc/include/asm/mmu-8xx.h       |  10 +
 arch/powerpc/include/asm/slice.h         |   8 +-
 arch/powerpc/mm/hugetlbpage.c            |   6 +-
 arch/powerpc/mm/mmu_context_book3s64.c   |   9 +-
 arch/powerpc/mm/mmu_context_nohash.c     |   5 +-
 arch/powerpc/mm/slice.c                  | 461 ++++++++++++++++---------------
 8 files changed, 277 insertions(+), 247 deletions(-)

-- 
2.16.1
