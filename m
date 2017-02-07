Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHVhG1LZQzDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 14:49:17 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v173mmaC058716
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Feb 2017 22:49:15 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28f68rrnum-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Feb 2017 22:49:15 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 6 Feb 2017 20:49:14 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 0/5] Add support for larger address space for ppc64
Date: Tue,  7 Feb 2017 09:18:48 +0530
Message-Id: <1486439333-22162-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series update ppc64 to use a 68 bit virtual address. The goal here
is to help us increase the effective address range to 512TB. I still haven't
comeup with a mechanism to enable application to selectively use address about
the 64TB (the current limit). The last patch in this series is just to check
whether the 68 bit va limit is working as expected.

On p4 and p5 which can do only 65 bit va, we do use mmu feature to fixup the max 
va bits. We do that by limiting the max context on these platforms. The context
bits for these platforms get reduced from 19 bits to 16 bits with these patches.

W.r.t limitting max effective address for application, we have discussion happening
on lkml w.r.t different approaches that can be used. Once we reach concensus on that,
the same approach can be used on ppc64 too. 
https://lkml.kernel.org/r/20161227015413.187403-30-kirill.shutemov@linux.intel.com

TODO:
* PR kvm need to be looked at to study the impact
* Limit max address to 64TB by default and selectively enable range above.
* Fixup context switch to copy only required slice array.


Aneesh Kumar K.V (5):
  powerpc/mm/slice: Convert slice_mask high slice to a bitmap
  powerpc/mm/slice: Update the function prototype
  powerpc/mm/hash: Move kernel context to the starting of context range
  powerpc/mm/hash: Support 68 bit VA
  powerpc/mm/hash: Increase VA range to 256TB

 arch/powerpc/include/asm/book3s/64/hash-4k.h  |   2 +-
 arch/powerpc/include/asm/book3s/64/hash-64k.h |   2 +-
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 162 +++++++++++++++-----------
 arch/powerpc/include/asm/mmu.h                |  19 ++-
 arch/powerpc/include/asm/mmu_context.h        |   2 -
 arch/powerpc/include/asm/page_64.h            |  15 +--
 arch/powerpc/include/asm/processor.h          |  12 +-
 arch/powerpc/kvm/book3s_64_mmu_host.c         |   2 +-
 arch/powerpc/mm/hash_utils_64.c               |   5 -
 arch/powerpc/mm/mmu_context_book3s64.c        |  87 +++++++++-----
 arch/powerpc/mm/slb_low.S                     |  71 +++++++----
 arch/powerpc/mm/slice.c                       | 147 ++++++++++++++---------
 12 files changed, 318 insertions(+), 208 deletions(-)

-- 
2.7.4
