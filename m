Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C605D1A001B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 16:21:26 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 13 May 2015 16:21:26 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4D97E357804F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 16:21:23 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4D6LFJq32768092
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 16:21:23 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4D6Kohg031136
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 16:20:50 +1000
Date: Wed, 13 May 2015 16:20:25 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v10 10/34] vfio: powerpc/spapr: Disable DMA
 mappings on disabled container
Message-ID: <20150513062025.GA8256@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>
 <1431358763-24371-11-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431358763-24371-11-git-send-email-aik@ozlabs.ru>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 12, 2015 at 01:38:59AM +1000, Alexey Kardashevskiy wrote:
>At the moment DMA map/unmap requests are handled irrespective to
>the container's state. This allows the user space to pin memory which
>it might not be allowed to pin.
>
>This adds checks to MAP/UNMAP that the container is enabled, otherwise
>-EPERM is returned.
>
>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>[aw: for the vfio related changes]
>Acked-by: Alex Williamson <alex.williamson@redhat.com>
>Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Thanks,
Gavin

>---
> drivers/vfio/vfio_iommu_spapr_tce.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
>index 40583f9..e21479c 100644
>--- a/drivers/vfio/vfio_iommu_spapr_tce.c
>+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>@@ -318,6 +318,9 @@ static long tce_iommu_ioctl(void *iommu_data,
> 		struct iommu_table *tbl = container->tbl;
> 		unsigned long tce;
>
>+		if (!container->enabled)
>+			return -EPERM;
>+
> 		if (!tbl)
> 			return -ENXIO;
>
>@@ -362,6 +365,9 @@ static long tce_iommu_ioctl(void *iommu_data,
> 		struct vfio_iommu_type1_dma_unmap param;
> 		struct iommu_table *tbl = container->tbl;
>
>+		if (!container->enabled)
>+			return -EPERM;
>+
> 		if (WARN_ON(!tbl))
> 			return -ENXIO;
>
>-- 
>2.4.0.rc3.8.gfb3e7d5
>
