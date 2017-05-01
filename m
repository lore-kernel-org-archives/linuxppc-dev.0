Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wGTdl66SXzDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 May 2017 12:58:51 +1000 (AEST)
In-Reply-To: <20170322042156.11756-3-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 kvm-ppc@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [kernel, v11,
 02/10] powerpc/powernv/iommu: Add real mode version of
 iommu_table_ops::exchange()
Message-Id: <3wGTdl4qlgz9sNC@ozlabs.org>
Date: Mon,  1 May 2017 12:58:51 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-03-22 at 04:21:48 UTC, Alexey Kardashevskiy wrote:
> In real mode, TCE tables are invalidated using special
> cache-inhibited store instructions which are not available in
> virtual mode
> 
> This defines and implements exchange_rm() callback. This does not
> define set_rm/clear_rm/flush_rm callbacks as there is no user for those -
> exchange/exchange_rm are only to be used by KVM for VFIO.
> 
> The exchange_rm callback is defined for IODA1/IODA2 powernv platforms.
> 
> This replaces list_for_each_entry_rcu with its lockless version as
> from now on pnv_pci_ioda2_tce_invalidate() can be called in
> the real mode too.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a540aa56ba3d29084f28710c8b93cc

cheers
