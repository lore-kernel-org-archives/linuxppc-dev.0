Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zdl5R0M2TzF0dt
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 19:11:51 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id u15so2235935pfa.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 00:11:51 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH 0/5] powerpc/mm/slice: improve slice speed and stack use
Date: Sat, 10 Feb 2018 18:11:34 +1000
Message-Id: <20180210081139.27236-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series intends to improve performance and reduce stack
consumption in the slice allocation code. It does it by keeping slice
masks in the mm_context rather than compute them for each allocation,
and by reducing bitmaps and slice_masks from stacks, using pointers
instead where possible.

checkstack.pl gives, before:
0x00000de4 slice_get_unmapped_area [slice.o]:           656
0x00001b4c is_hugepage_only_range [slice.o]:            512
0x0000075c slice_find_area_topdown [slice.o]:           416
0x000004c8 slice_find_area_bottomup.isra.1 [slice.o]:   272
0x00001aa0 slice_set_range_psize [slice.o]:             240
0x00000a64 slice_find_area [slice.o]:                   176
0x00000174 slice_check_fit [slice.o]:                   112

after:
0x00000d70 slice_get_unmapped_area [slice.o]:           320
0x000008f8 slice_find_area [slice.o]:                   144
0x00001860 slice_set_range_psize [slice.o]:             144
0x000018ec is_hugepage_only_range [slice.o]:            144
0x00000750 slice_find_area_bottomup.isra.4 [slice.o]:   128

The benchmark in https://github.com/linuxppc/linux/issues/49 gives, before:
$ time ./slicemask 
real	0m20.712s
user	0m5.830s
sys	0m15.105s

after:
$ time ./slicemask 
real	0m13.197s
user	0m5.409s
sys	0m7.779s

Thanks,
Nick

Nicholas Piggin (5):
  powerpc/mm/slice: pass pointers to struct slice_mask where possible
  powerpc/mm/slice: implement a slice mask cache
  powerpc/mm/slice: implement slice_check_range_fits
  powerpc/mm/slice: Use const pointers to cached slice masks where
    possible
  powerpc/mm/slice: use the dynamic high slice size to limit bitmap
    operations

 arch/powerpc/include/asm/book3s/64/mmu.h |  20 +-
 arch/powerpc/mm/slice.c                  | 302 +++++++++++++++++++------------
 2 files changed, 204 insertions(+), 118 deletions(-)

-- 
2.15.1
