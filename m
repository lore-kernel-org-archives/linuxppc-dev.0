Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6623A1A0338
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 22:02:17 +1100 (AEDT)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 15 Feb 2016 04:02:15 -0700
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id B7D8C19D8048
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 03:50:10 -0700 (MST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1FB2CXe30670848
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 11:02:12 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1FB2A8w030500
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 06:02:12 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, akpm@linux-foundation.org,
 Mel Gorman <mgorman@techsingularity.net>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] powerpc/mm: Fix Multi hit ERAT cause by recent THP
 update
In-Reply-To: <1455512997.16012.24.camel@gmail.com>
References: <1454980831-16631-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1455504278.16012.18.camel@gmail.com> <87lh6mfv2j.fsf@linux.vnet.ibm.com>
 <1455512997.16012.24.camel@gmail.com>
Date: Mon, 15 Feb 2016 16:31:59 +0530
Message-ID: <87d1ryfd94.fsf@linux.vnet.ibm.com>
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

Balbir Singh <bsingharora@gmail.com> writes:

>> Now we can't depend for mm_cpumask, a parallel find_linux_pte_hugepte
>> can happen outside that. Now i had a variant for kick_all_cpus_sync that
>> ignored idle cpus. But then that needs more verification.
>>=20
>> http://article.gmane.org/gmane.linux.ports.ppc.embedded/81105
> Can be racy as a CPU moves from non-idle to idle
>
> In
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmd_hugepage_update(vma->vm_mm, address, =
pmdp, ~0UL, 0);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* This ensures that generic code th=
at rely on IRQ disabling
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* to prevent a parallel THP split w=
ork as expected.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kick_all_cpus_sync();
>
> pmdp_invalidate()->pmd_hugepage_update() can still run in parallel with=
=C2=A0
> find_linux_pte_or_hugepte() and race.. Am I missing something?
>

Yes. But then we make sure that the pte_t returned by
find_linux_pte_or_hugepte doesn't change to a regular pmd entry by using
that kick. Now callers of find_lnux_pte_or_hugepte will check for
_PAGE_PRESENT. So if it called before
pmd_hugepage_update(_PAGE_PRESENT), we wait for the caller to finish the
usage (via kick()). Or they bail out after finding _PAGE_PRESENT cleared.

-aneesh
