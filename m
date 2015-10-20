Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 88FB31A02AC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 07:12:51 +1100 (AEDT)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 21 Oct 2015 01:42:49 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 9B3A83940019
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 01:42:45 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9KKCjOs11403750
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 01:42:45 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9KKCiDN006370
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 01:42:44 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 0/7] Remove 4k subpage tracking with hash 64K config
Date: Wed, 21 Oct 2015 01:42:26 +0530
Message-Id: <1445371953-9627-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This patch series is on top of the series posted at 

https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-October/135299.html
"[PATCH V4 00/31] powerpc/mm: Update page table format for book3s 64". In this
series we remove 4k subpage tracking with 64K config. Instead we do a hash
table lookup to get the slot information of 4k hash ptes. This also allow us
to remove real_pte_t. Side effect of the change is that a specific 4k slot
lookup can result in multiple H_READ hcalls. But that should only impact
when we are using 4K subpages which should be rare.

NOTE: I only tested this on systemsim. Wanted to get this out to get early
feedback.

Aneesh Kumar K.V (7):
  powerpc/mm: Don't hardcode page table size
  powerpc/mm: Don't hardcode the hash pte slot shift
  powerpc/nohash: Update 64K nohash config to have 32 pte fragement
  powerpc/mm: Don't track 4k subpage information with 64k linux page
    size
  powerpc/mm: update frag size
  powerpc/mm: Update pte_iterate_hashed_subpaes args
  powerpc/mm: getrid of real_pte_t

 arch/powerpc/include/asm/book3s/64/hash-64k.h    | 75 +++++++++---------------
 arch/powerpc/include/asm/book3s/64/pgtable.h     | 25 +++-----
 arch/powerpc/include/asm/machdep.h               |  2 +
 arch/powerpc/include/asm/nohash/64/pgtable-64k.h | 21 +++++--
 arch/powerpc/include/asm/nohash/64/pgtable.h     | 24 +++-----
 arch/powerpc/include/asm/page.h                  | 15 -----
 arch/powerpc/include/asm/pgalloc-64.h            | 10 ----
 arch/powerpc/include/asm/tlbflush.h              |  4 +-
 arch/powerpc/mm/hash64_64k.c                     | 67 +++++++++++++--------
 arch/powerpc/mm/hash_native_64.c                 | 35 ++++++++---
 arch/powerpc/mm/hash_utils_64.c                  | 13 ++--
 arch/powerpc/mm/init_64.c                        |  7 +--
 arch/powerpc/mm/pgtable_64.c                     |  6 +-
 arch/powerpc/mm/tlb_hash64.c                     | 15 +++--
 arch/powerpc/platforms/pseries/lpar.c            | 23 ++++++--
 15 files changed, 175 insertions(+), 167 deletions(-)

-- 
2.5.0
