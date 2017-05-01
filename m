Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wGTdm2Zx6zDqBP
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 May 2017 12:58:52 +1000 (AEST)
In-Reply-To: <20170322042156.11756-5-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 kvm-ppc@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [kernel, v11,
 04/10] powerpc/vfio_spapr_tce: Add reference counting to iommu_table
Message-Id: <3wGTdm1fsXz9sNF@ozlabs.org>
Date: Mon,  1 May 2017 12:58:52 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-03-22 at 04:21:50 UTC, Alexey Kardashevskiy wrote:
> So far iommu_table obejcts were only used in virtual mode and had
> a single owner. We are going to change this by implementing in-kernel
> acceleration of DMA mapping requests. The proposed acceleration
> will handle requests in real mode and KVM will keep references to tables.
> 
> This adds a kref to iommu_table and defines new helpers to update it.
> This replaces iommu_free_table() with iommu_tce_table_put() and makes
> iommu_free_table() static. iommu_tce_table_get() is not used in this patch
> but it will be in the following patch.
> 
> Since this touches prototypes, this also removes @node_name parameter as
> it has never been really useful on powernv and carrying it for
> the pseries platform code to iommu_free_table() seems to be quite
> useless as well.
> 
> This should cause no behavioral change.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Acked-by: Alex Williamson <alex.williamson@redhat.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e5afdf9dd515a9446c009f44f99f9b

cheers
