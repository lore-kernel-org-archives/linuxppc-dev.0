Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A244C1A0631
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 11:00:26 +1100 (AEDT)
Message-ID: <1426032017.25026.92.camel@redhat.com>
Subject: Re: [PATCH v5 26/29] vfio: powerpc/spapr: Define v2 IOMMU
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Tue, 10 Mar 2015 18:00:17 -0600
In-Reply-To: <1425910045-26167-27-git-send-email-aik@ozlabs.ru>
References: <1425910045-26167-1-git-send-email-aik@ozlabs.ru>
 <1425910045-26167-27-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-03-10 at 01:07 +1100, Alexey Kardashevskiy wrote:
> The existing IOMMU code takes/releases ownership over the existing IOMMU
> tables created by the platform code, i.e. the tables remain in memory
> all the time. Also, the existing IOMMU requires VFIO_IOMMU_ENABLE call to
> start working as that's where we check the rlimit for locked pages.
> 
> New IOMMU will take over the IOMMU group completely which means the IOMMU
> tables created by the platform code are going to be disposed and VFIO
> will create its own tables. Also, with the DMA memory pre-registration
> feature, the userspace will not need to call VFIO_IOMMU_ENABLE as
> the locked pages accounting will be done by
> VFIO_IOMMU_SPAPR_REGISTER_MEMORY.
> 
> In order to inform the userspace that VFIO supports new capabilities,
> this adds a new SPAPR TCE IOMMU v2 type.

Shouldn't we block some of these new features on v1?  Otherwise v1 now
supports them too and by the property of "we don't break userspace" v1
and v2 are now one-in-the-same.  You'd need to support everything
through both versions.  If that's what you intend to do, maybe this
should be a capability rather than an IOMMU type.

> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 3 ++-
>  include/uapi/linux/vfio.h           | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
> index e572c28..d665ddc 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -404,7 +404,7 @@ static void *tce_iommu_open(unsigned long arg)
>  {
>  	struct tce_container *container;
>  
> -	if (arg != VFIO_SPAPR_TCE_IOMMU) {
> +	if ((arg != VFIO_SPAPR_TCE_IOMMU) && (arg != VFIO_SPAPR_TCE_v2_IOMMU)) {
>  		pr_err("tce_vfio: Wrong IOMMU type\n");
>  		return ERR_PTR(-EINVAL);
>  	}
> @@ -588,6 +588,7 @@ static long tce_iommu_ioctl(void *iommu_data,
>  	case VFIO_CHECK_EXTENSION:
>  		switch (arg) {
>  		case VFIO_SPAPR_TCE_IOMMU:
> +		case VFIO_SPAPR_TCE_v2_IOMMU:
>  			ret = 1;
>  			break;
>  		default:
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index b17e120..fbc5286 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -36,6 +36,8 @@
>  /* Two-stage IOMMU */
>  #define VFIO_TYPE1_NESTING_IOMMU	6	/* Implies v2 */
>  
> +#define VFIO_SPAPR_TCE_v2_IOMMU		7
> +
>  /*
>   * The IOCTL interface is designed for extensibility by embedding the
>   * structure length (argsz) and flags into structures passed between
