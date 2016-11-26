Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tQvLr4zBhzDvsj
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Nov 2016 00:44:36 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAQDiEP3038263
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Nov 2016 08:44:33 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26y4w24prw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Nov 2016 08:44:33 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 26 Nov 2016 06:44:32 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 0/7] Radix pte update tlbflush optimizations.
In-Reply-To: <20161125160257.9158-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20161125160257.9158-1-aneesh.kumar@linux.vnet.ibm.com>
Date: Sat, 26 Nov 2016 19:14:26 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <877f7qjqyt.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> Changes from V5:
> Switch to use pte bits to track page size.

I am now testing a new version that will limit this new pte bit usage
only on DD1.

>
> Aneesh Kumar K.V (7):
>   powerpc/mm: Rename hugetlb-radix.h to hugetlb.h
>   powerpc/mm/hugetlb: Handle hugepage size supported by hash config
>   powerpc/mm: Introduce _PAGE_GIGANTIC and _PAGE_LARGE software pte bits
>   powerpc/mm: Add radix__tlb_flush_pte
>   powerpc/mm: update radix__ptep_set_access_flag to not do full mm tlb
>     flush
>   powerpc/mm: update radix__pte_update to not do full mm tlb flush
>   powerpc/mm: Batch tlb flush when invalidating pte entries
>
>  arch/powerpc/include/asm/book3s/32/pgtable.h       |  3 ++-
>  .../asm/book3s/64/{hugetlb-radix.h => hugetlb.h}   | 21 ++++++++++++++--
>  arch/powerpc/include/asm/book3s/64/pgtable.h       | 15 ++++++++++--
>  arch/powerpc/include/asm/book3s/64/radix.h         | 28 ++++++++++------------
>  .../powerpc/include/asm/book3s/64/tlbflush-radix.h |  2 ++
>  arch/powerpc/include/asm/hugetlb.h                 |  2 +-
>  arch/powerpc/include/asm/nohash/32/pgtable.h       |  3 ++-
>  arch/powerpc/include/asm/nohash/64/pgtable.h       |  3 ++-
>  arch/powerpc/mm/pgtable-book3s64.c                 |  3 ++-
>  arch/powerpc/mm/pgtable.c                          |  2 +-
>  arch/powerpc/mm/tlb-radix.c                        | 11 +++++++++
>  11 files changed, 67 insertions(+), 26 deletions(-)
>  rename arch/powerpc/include/asm/book3s/64/{hugetlb-radix.h => hugetlb.h} (55%)
>
> -- 
> 2.10.2
