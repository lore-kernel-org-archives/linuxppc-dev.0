Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 053F41A0707
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 09:36:42 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 14 May 2015 09:36:40 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A7A502BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 09:36:36 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4DNaSt021692420
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 09:36:36 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4DNa3sN024291
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 09:36:04 +1000
Date: Thu, 14 May 2015 09:35:39 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v10 12/34] vfio: powerpc/spapr: Rework groups
 attaching
Message-ID: <20150513233539.GA9937@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>
 <1431358763-24371-13-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431358763-24371-13-git-send-email-aik@ozlabs.ru>
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

On Tue, May 12, 2015 at 01:39:01AM +1000, Alexey Kardashevskiy wrote:
>This is to make extended ownership and multiple groups support patches
>simpler for review.
>
>This should cause no behavioural change.
>
>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>[aw: for the vfio related changes]
>Acked-by: Alex Williamson <alex.williamson@redhat.com>
>Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Thanks,
Gavin

>---
> drivers/vfio/vfio_iommu_spapr_tce.c | 40 ++++++++++++++++++++++---------------
> 1 file changed, 24 insertions(+), 16 deletions(-)
>
>diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
>index 115d5e6..0fbe03e 100644
>--- a/drivers/vfio/vfio_iommu_spapr_tce.c
>+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>@@ -460,16 +460,21 @@ static int tce_iommu_attach_group(void *iommu_data,
> 				iommu_group_id(container->tbl->it_group),
> 				iommu_group_id(iommu_group));
> 		ret = -EBUSY;
>-	} else if (container->enabled) {
>+		goto unlock_exit;
>+	}
>+
>+	if (container->enabled) {
> 		pr_err("tce_vfio: attaching group #%u to enabled container\n",
> 				iommu_group_id(iommu_group));
> 		ret = -EBUSY;
>-	} else {
>-		ret = iommu_take_ownership(tbl);
>-		if (!ret)
>-			container->tbl = tbl;
>+		goto unlock_exit;
> 	}
>
>+	ret = iommu_take_ownership(tbl);
>+	if (!ret)
>+		container->tbl = tbl;
>+
>+unlock_exit:
> 	mutex_unlock(&container->lock);
>
> 	return ret;
>@@ -487,19 +492,22 @@ static void tce_iommu_detach_group(void *iommu_data,
> 		pr_warn("tce_vfio: detaching group #%u, expected group is #%u\n",
> 				iommu_group_id(iommu_group),
> 				iommu_group_id(tbl->it_group));
>-	} else {
>-		if (container->enabled) {
>-			pr_warn("tce_vfio: detaching group #%u from enabled container, forcing disable\n",
>-					iommu_group_id(tbl->it_group));
>-			tce_iommu_disable(container);
>-		}
>+		goto unlock_exit;
>+	}
>
>-		/* pr_debug("tce_vfio: detaching group #%u from iommu %p\n",
>-				iommu_group_id(iommu_group), iommu_group); */
>-		container->tbl = NULL;
>-		tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
>-		iommu_release_ownership(tbl);
>+	if (container->enabled) {
>+		pr_warn("tce_vfio: detaching group #%u from enabled container, forcing disable\n",
>+				iommu_group_id(tbl->it_group));
>+		tce_iommu_disable(container);
> 	}
>+
>+	/* pr_debug("tce_vfio: detaching group #%u from iommu %p\n",
>+	   iommu_group_id(iommu_group), iommu_group); */
>+	container->tbl = NULL;
>+	tce_iommu_clear(container, tbl, tbl->it_offset, tbl->it_size);
>+	iommu_release_ownership(tbl);
>+
>+unlock_exit:
> 	mutex_unlock(&container->lock);
> }
>
>-- 
>2.4.0.rc3.8.gfb3e7d5
>
