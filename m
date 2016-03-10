Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D7A291A02DE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 19:44:03 +1100 (AEDT)
Date: Thu, 10 Mar 2016 19:43:57 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel 4/9] powerpc/powernv/iommu: Add real mode version
 of xchg()
Message-ID: <20160310084357.GC1230@fergus.ozlabs.ibm.com>
References: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
 <1457322077-26640-5-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457322077-26640-5-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 07, 2016 at 02:41:12PM +1100, Alexey Kardashevskiy wrote:
> In real mode, TCE tables are invalidated using different
> cache-inhibited store instructions which is different from
> the virtual mode.
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

[snip]

> @@ -1062,6 +1062,21 @@ void iommu_release_ownership(struct iommu_table *tbl)
>  }
>  EXPORT_SYMBOL_GPL(iommu_release_ownership);
>  
> +long iommu_tce_xchg_rm(struct iommu_table *tbl, unsigned long entry,
> +		unsigned long *hpa, enum dma_data_direction *direction)
> +{
> +	long ret;
> +
> +	ret = tbl->it_ops->exchange_rm(tbl, entry, hpa, direction);
> +
> +	if (!ret && ((*direction == DMA_FROM_DEVICE) ||
> +			(*direction == DMA_BIDIRECTIONAL)))
> +		SetPageDirty(realmode_pfn_to_page(*hpa >> PAGE_SHIFT));

realmode_pfn_to_page can fail and return NULL, can't it?  You need to
handle that situation somehow.

Paul.
