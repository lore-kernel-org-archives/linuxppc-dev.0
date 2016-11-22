Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tN8qK3185zDvNS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 13:41:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 4/6] powerpc/mm/hugetlb: Switch hugetlb update to use
 huge_pte_update
In-Reply-To: <20161121183322.14585-4-aneesh.kumar@linux.vnet.ibm.com>
References: <20161121183322.14585-1-aneesh.kumar@linux.vnet.ibm.com>
 <20161121183322.14585-4-aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 22 Nov 2016 13:41:09 +1100
Message-ID: <8760ngw81m.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> We want to switch pte_update to use va based tlb flush. In order to do th=
at we
> need to track the page size. With hugetlb we currently don't have page si=
ze
> available in these functions. Hence switch hugetlb to use seperate functi=
ons
> for update. In later patch we will update hugetlb functions to take
> vm_area_struct from which we can derive the page size. After that we will=
 switch
> this back to use pte_update

This breaks corenet64_smp_defconfig:

In file included from ../arch/powerpc/include/asm/page.h:294:0,
                 from ../arch/powerpc/include/asm/thread_info.h:34,
                 from ../include/linux/thread_info.h:58,
                 from ../include/asm-generic/preempt.h:4,
                 from ./arch/powerpc/include/generated/asm/preempt.h:1,
                 from ../include/linux/preempt.h:59,
                 from ../include/linux/spinlock.h:50,
                 from ../include/linux/mmzone.h:7,
                 from ../include/linux/gfp.h:5,
                 from ../arch/powerpc/mm/pgtable.c:25:
../arch/powerpc/include/asm/hugetlb.h: In function =E2=80=98huge_ptep_get_a=
nd_clear=E2=80=99:
../arch/powerpc/include/asm/hugetlb.h:139:15: error: implicit declaration o=
f function =E2=80=98huge_pte_update=E2=80=99 [-Werror=3Dimplicit-function-d=
eclaration]
  return __pte(huge_pte_update(mm, addr, ptep, ~0UL, 0));
               ^
../arch/powerpc/include/asm/pgtable-types.h:6:30: note: in definition of ma=
cro =E2=80=98__pte=E2=80=99
 #define __pte(x) ((pte_t) { (x) })


And many more.

cheers
