Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wH8g56WrBzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 May 2017 15:17:21 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id s62so7540770pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 May 2017 22:17:21 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: vdavydov.dev@gmail.com,
	mpe@ellerman.id.au,
	oss@buserror.net
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v3 0/3] Implement page table accounting for powerpc
Date: Tue,  2 May 2017 15:17:03 +1000
Message-Id: <20170502051706.19043-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(3e79ec7 arch: x86: charge page tables to kmemcg) added support for page
table accounting). This patch is the second iteration to add
support, in the earlier iteration only book3s 64 bit was supported.
This iteration adds support for booke/3s/32 and 64 bit.

There is some ugliness in this patchset, pgalloc.h is included
from book3s_64_mmu_radix.c to reuse the pte/pmd/pud and pgd
management routines. We use #ifdef MODULE to provide a version
that provides full accounting. The alternatives are discussed
in patch 1 below

Changelog v3:
 - Fixed a build failure with 32 bit powerpc
 - Optimizations for pte_alloc_one()
Changelog v2:
 - Added support for 32 bit and booke
 - Added hugepte alloc accounting

Balbir Singh (3):
  powerpc/mm/book(e)(3s)/64: Add page table accounting
  powerpc/mm/book(e)(3s)/32: Add page table accounting
  powerpc/mm/hugetlb: Add support for page accounting

 arch/powerpc/include/asm/book3s/32/pgalloc.h |  3 ++-
 arch/powerpc/include/asm/book3s/64/pgalloc.h | 16 ++++++++++------
 arch/powerpc/include/asm/nohash/32/pgalloc.h |  3 ++-
 arch/powerpc/include/asm/nohash/64/pgalloc.h | 12 ++++++++----
 arch/powerpc/include/asm/pgalloc.h           | 14 ++++++++++++++
 arch/powerpc/mm/hugetlbpage.c                |  2 +-
 arch/powerpc/mm/pgtable_32.c                 |  2 +-
 arch/powerpc/mm/pgtable_64.c                 | 20 ++++++++++++++------
 8 files changed, 52 insertions(+), 20 deletions(-)

-- 
2.9.3
