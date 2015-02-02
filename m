Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 84D981A0C14
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 08:45:58 +1100 (AEDT)
Message-ID: <1422913542.22865.425.camel@redhat.com>
Subject: Re: [PATCH v3 02/24] vfio: powerpc/iommu: Check that TCE page size
 is equal to it_page_size
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Mon, 02 Feb 2015 14:45:42 -0700
In-Reply-To: <1422523325-1389-3-git-send-email-aik@ozlabs.ru>
References: <1422523325-1389-1-git-send-email-aik@ozlabs.ru>
 <1422523325-1389-3-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Alexander Graf <agraf@suse.de>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Alexander Gordeev <agordeev@redhat.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-01-29 at 20:21 +1100, Alexey Kardashevskiy wrote:
> This checks that the TCE table page size is not bigger that the size of
> a page we just pinned and going to put its physical address to the table.
> 
> Otherwise the hardware gets unwanted access to physical memory between
> the end of the actual page and the end of the aligned up TCE page.
> 
> Since compound_order() and compound_head() work correctly on non-huge
> pages, there is no need for additional check whether the page is huge.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v5:
> * check is done for all page sizes now, not just for huge pages
> * failed check returns EFAULT now (was EINVAL)
> * moved the check to VFIO SPAPR IOMMU driver
> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
> index dc4a886..99b98fa 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -47,6 +47,22 @@ struct tce_container {
>  	bool enabled;
>  };
>  
> +static bool tce_check_page_size(struct page *page, unsigned page_shift)

What does true/false mean for a "check page size" operation?  Does true
mean good?  Bad?  How about naming it page-is-contained or something
along those lines?

> +{
> +	unsigned shift;
> +
> +	/*
> +	 * Check that the TCE table granularity is not bigger than the size of
> +	 * a page we just found. Otherwise the hardware can get access to
> +	 * a bigger memory chunk that it should.
> +	 */
> +	shift = PAGE_SHIFT + compound_order(compound_head(page));
> +	if (shift >= page_shift)
> +		return true;
> +
> +	return false;
> +}
> +
>  static int tce_iommu_enable(struct tce_container *container)
>  {
>  	int ret = 0;
> @@ -199,6 +215,12 @@ static long tce_iommu_build(struct tce_container *container,
>  			ret = -EFAULT;
>  			break;
>  		}
> +
> +		if (!tce_check_page_size(page, tbl->it_page_shift)) {
> +			ret = -EFAULT;
> +			break;
> +		}
> +
>  		hva = (unsigned long) page_address(page) +
>  			(tce & IOMMU_PAGE_MASK(tbl) & ~PAGE_MASK);
>  
