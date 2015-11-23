Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 392BF1A2CBC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:34:51 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 23 Nov 2015 20:34:51 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id F227B2CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:34:47 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tANAYNC837421226
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:34:31 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tANAYF1s027899
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:34:15 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 00/10] Reduce the pte framgment size.
Date: Mon, 23 Nov 2015 16:03:35 +0530
Message-Id: <1448274825-30289-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This patch series update 4k subpage tracking in pte page, thereby reducing
the ptefragment size. This results in us allocating less number of
pgtable_t for an application. One of the side effect is that we now make
and hcall to find out whether a 4k subpage is present in the hash page table or not.
We try to optmize that in patch "powerpc/mm: Optmize the hashed subpage iteration"

Changes from V1:
* rebased on top of 4.3 + change pte format series
* Use H_READ_4 so that we read 4 hpte slot information in single hcall.

Aneesh Kumar K.V (10):
  powerpc/mm: Don't hardcode page table size
  powerpc/mm: Don't hardcode the hash pte slot shift
  powerpc/nohash: Update 64K nohash config to have 32 pte fragement
  powerpc/nohash: we don't use real_pte_t for nohash
  powerpc/mm: Use H_READ with H_READ_4
  powerpc/mm: Don't track 4k subpage information with 64k linux page
    size
  powerpc/mm: update PTE frag size
  powerpc/mm: Update pte_iterate_hashed_subpages args
  powerpc/mm: Drop real_pte_t usage
  powerpc/mm: Optmize the hashed subpage iteration

 arch/powerpc/include/asm/book3s/64/hash-64k.h    |  82 ++++++++-----------
 arch/powerpc/include/asm/book3s/64/pgtable.h     |  35 ++++----
 arch/powerpc/include/asm/machdep.h               |   1 +
 arch/powerpc/include/asm/nohash/64/pgtable-64k.h |  21 ++++-
 arch/powerpc/include/asm/nohash/64/pgtable.h     |  33 --------
 arch/powerpc/include/asm/page.h                  |  15 ----
 arch/powerpc/include/asm/pgalloc-64.h            |  10 ---
 arch/powerpc/include/asm/plpar_wrappers.h        |  17 ++++
 arch/powerpc/include/asm/tlbflush.h              |   4 +-
 arch/powerpc/mm/hash64_64k.c                     | 100 ++++++++++++++---------
 arch/powerpc/mm/hash_native_64.c                 |  55 +++++++++++--
 arch/powerpc/mm/hash_utils_64.c                  |  13 +--
 arch/powerpc/mm/init_64.c                        |   7 +-
 arch/powerpc/mm/pgtable_64.c                     |   6 +-
 arch/powerpc/mm/tlb_hash64.c                     |  15 ++--
 arch/powerpc/platforms/pseries/lpar.c            |  90 +++++++++++++-------
 16 files changed, 279 insertions(+), 225 deletions(-)

-- 
2.5.0
