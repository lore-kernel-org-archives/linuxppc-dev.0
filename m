Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wGTdm0x3PzDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 May 2017 12:58:52 +1000 (AEST)
In-Reply-To: <20170322042156.11756-4-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 kvm-ppc@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [kernel, v11,
 03/10] powerpc/iommu/vfio_spapr_tce: Cleanup iommu_table disposal
Message-Id: <3wGTdm05J0z9sND@ozlabs.org>
Date: Mon,  1 May 2017 12:58:51 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-03-22 at 04:21:49 UTC, Alexey Kardashevskiy wrote:
> At the moment iommu_table can be disposed by either calling
> iommu_table_free() directly or it_ops::free(); the only implementation
> of free() is in IODA2 - pnv_ioda2_table_free() - and it calls
> iommu_table_free() anyway.
> 
> As we are going to have reference counting on tables, we need an unified
> way of disposing tables.
> 
> This moves it_ops::free() call into iommu_free_table() and makes use
> of the latter. The free() callback now handles only platform-specific
> data.
> 
> As from now on the iommu_free_table() calls it_ops->free(), we need
> to have it_ops initialized before calling iommu_free_table() so this
> moves this initialization in pnv_pci_ioda2_create_table().
> 
> This should cause no behavioral change.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Acked-by: Alex Williamson <alex.williamson@redhat.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/11edf116e3a6352cfee6b1437d4160

cheers
