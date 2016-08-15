Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sCVmS2FfVzDr0d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 19:38:32 +1000 (AEST)
Date: Mon, 15 Aug 2016 14:58:57 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH kernel 01/15] Revert "iommu: Add a function to find an
 iommu group by id"
Message-ID: <20160815045857.GA8997@oak.ozlabs.ibm.com>
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
 <1470213656-1042-2-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470213656-1042-2-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 03, 2016 at 06:40:42PM +1000, Alexey Kardashevskiy wrote:
> This reverts commit aa16bea929ae
> ("iommu: Add a function to find an iommu group by id")
> as the iommu_group_get_by_id() helper has never been used
> and it is unlikely it will in foreseeable future. Dead code
> is broken code.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
[...]
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index a35fb8b..93c69fa 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -215,7 +215,6 @@ extern int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops);
>  extern bool iommu_present(struct bus_type *bus);
>  extern bool iommu_capable(struct bus_type *bus, enum iommu_cap cap);
>  extern struct iommu_domain *iommu_domain_alloc(struct bus_type *bus);
> -extern struct iommu_group *iommu_group_get_by_id(int id);
>  extern void iommu_domain_free(struct iommu_domain *domain);
>  extern int iommu_attach_device(struct iommu_domain *domain,
>  			       struct device *dev);

There's another definition of iommu_group_get_by_id() further down in
iommu.h (static inline after the #else on CONFIG_IOMMU_API) which also
needs to be removed.

Paul.
