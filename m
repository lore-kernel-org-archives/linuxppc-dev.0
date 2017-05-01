Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wGTdl40tPzDqBP
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 May 2017 12:58:51 +1000 (AEST)
In-Reply-To: <20170322042156.11756-2-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 kvm-ppc@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [kernel, v11,
 01/10] powerpc/mmu: Add real mode support for IOMMU preregistered
 memory
Message-Id: <3wGTdl2zlQz9sN9@ozlabs.org>
Date: Mon,  1 May 2017 12:58:51 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-03-22 at 04:21:47 UTC, Alexey Kardashevskiy wrote:
> This makes mm_iommu_lookup() able to work in realmode by replacing
> list_for_each_entry_rcu() (which can do debug stuff which can fail in
> real mode) with list_for_each_entry_lockless().
> 
> This adds realmode version of mm_iommu_ua_to_hpa() which adds
> explicit vmalloc'd-to-linear address conversion.
> Unlike mm_iommu_ua_to_hpa(), mm_iommu_ua_to_hpa_rm() can fail.
> 
> This changes mm_iommu_preregistered() to receive @mm as in real mode
> @current does not always have a correct pointer.
> 
> This adds realmode version of mm_iommu_lookup() which receives @mm
> (for the same reason as for mm_iommu_preregistered()) and uses
> lockless version of list_for_each_entry_rcu().
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6b5c19c55266f6efd10ffac0e9f9f2

cheers
