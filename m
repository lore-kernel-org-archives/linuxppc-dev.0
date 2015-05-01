Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7B9931A0D0F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 15:43:53 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 1 May 2015 11:13:51 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 2B66FE0045
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 11:16:37 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t415hkbU327978
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 May 2015 11:13:48 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t415hjnJ005929
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 May 2015 11:13:46 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: akpm@linux-foundation.org, mpe@ellerman.id.au, paulus@samba.org,
 benh@kernel.crashing.org, kirill.shutemov@linux.intel.com
Subject: [PATCH V2 0/2] Remove _PAGE_SPLITTING from ppc64 
Date: Fri,  1 May 2015 11:13:24 +0530
Message-Id: <1430459006-18142-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The changes are on top of what is posted  at

 http://mid.gmane.org/1429823043-157133-1-git-send-email-kirill.shutemov@linux.intel.com

 git://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git thp/refcounting/v5

Changes from V1:
* Fold part of patch 3 to 1 and 2
* Drop patch 3.
* Make generic version of pmdp_splitting_flush_notify inline.

Aneesh Kumar K.V (2):
  mm/thp: Use new functions to clear pmd on splitting and collapse
  powerpc/thp: Remove _PAGE_SPLITTING and related code

 arch/powerpc/include/asm/kvm_book3s_64.h |   6 --
 arch/powerpc/include/asm/pgtable-ppc64.h |  29 ++------
 arch/powerpc/mm/hugepage-hash64.c        |   3 -
 arch/powerpc/mm/hugetlbpage.c            |   2 +-
 arch/powerpc/mm/pgtable_64.c             | 111 ++++++++++++-------------------
 include/asm-generic/pgtable.h            |  32 +++++++++
 mm/gup.c                                 |   2 +-
 mm/huge_memory.c                         |   9 +--
 8 files changed, 89 insertions(+), 105 deletions(-)

-- 
2.1.4
