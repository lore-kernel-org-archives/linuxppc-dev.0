Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHvhf4rMPzDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 06:36:02 +1100 (AEDT)
Date: Tue, 7 Feb 2017 12:35:59 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel] vfio/spapr_tce: Set window when adding
 additional groups to container
Message-ID: <20170207123559.2b878948@t450s.home>
In-Reply-To: <20170207062657.21606-1-aik@ozlabs.ru>
References: <20170207062657.21606-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue,  7 Feb 2017 17:26:57 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> If a container already has a group attached, attaching a new group
> should just program already created IOMMU tables to the hardware via
> the iommu_table_group_ops::set_window() callback.
> 
> However 6f01cc692 "vfio/spapr: Add a helper to create default DMA window"
> did not just simplify the code but also removed the set_window() calls
> in the case of attaching groups to a container which already has tables
> so it broke VFIO PCI hotplug.
> 
> This reverts set_window() bits in tce_iommu_take_ownership_ddw().
> 
> Fixes: 6f01cc692

See Documentation/process/submitting-patches.rst for the expected
format here, 12 char SHA-1 + --oneline summary.

> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
> index 7690e5bf3cf1..14c62a8495a2 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -1245,6 +1245,8 @@ static void tce_iommu_release_ownership_ddw(struct tce_container *container,
>  static long tce_iommu_take_ownership_ddw(struct tce_container *container,
>  		struct iommu_table_group *table_group)
>  {
> +	long i, ret = 0;
> +
>  	if (!table_group->ops->create_table || !table_group->ops->set_window ||
>  			!table_group->ops->release_ownership) {
>  		WARN_ON_ONCE(1);
> @@ -1253,7 +1255,26 @@ static long tce_iommu_take_ownership_ddw(struct tce_container *container,
>  
>  	table_group->ops->take_ownership(table_group);
>  
> +	/* Set all windows to the new group */
> +	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
> +		struct iommu_table *tbl = container->tables[i];

checkpatch wants a blank line here.

> +		if (!tbl)
> +			continue;
> +
> +		ret = table_group->ops->set_window(table_group, i, tbl);
> +		if (ret)
> +			goto release_exit;
> +	}
> +
>  	return 0;
> +
> +release_exit:
> +	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i)
> +		table_group->ops->unset_window(table_group, i);
> +
> +	table_group->ops->release_ownership(table_group);
> +
> +	return ret;
>  }
>  
>  static int tce_iommu_attach_group(void *iommu_data,


I've fixed these as shown below.  David, please review/ack as well and
I'll send a pull for v4.10.  Thanks,

Alex


commit c019167838156a2efcc60a15fa4207710bac6e82
Author: Alexey Kardashevskiy <aik@ozlabs.ru>
Date:   Tue Feb 7 17:26:57 2017 +1100

    vfio/spapr_tce: Set window when adding additional groups to container
    
    If a container already has a group attached, attaching a new group
    should just program already created IOMMU tables to the hardware via
    the iommu_table_group_ops::set_window() callback.
    
    However commit 6f01cc692a16 ("vfio/spapr: Add a helper to create
    default DMA window") did not just simplify the code but also removed
    the set_window() calls in the case of attaching groups to a container
    which already has tables so it broke VFIO PCI hotplug.
    
    This reverts set_window() bits in tce_iommu_take_ownership_ddw().
    
    Fixes: 6f01cc692a16 ("vfio/spapr: Add a helper to create default DMA window")
    Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
    Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 7690e5bf3cf1..59b3f62a2d64 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -1245,6 +1245,8 @@ static void tce_iommu_release_ownership_ddw(struct tce_container *container,
 static long tce_iommu_take_ownership_ddw(struct tce_container *container,
 		struct iommu_table_group *table_group)
 {
+	long i, ret = 0;
+
 	if (!table_group->ops->create_table || !table_group->ops->set_window ||
 			!table_group->ops->release_ownership) {
 		WARN_ON_ONCE(1);
@@ -1253,7 +1255,27 @@ static long tce_iommu_take_ownership_ddw(struct tce_container *container,
 
 	table_group->ops->take_ownership(table_group);
 
+	/* Set all windows to the new group */
+	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i) {
+		struct iommu_table *tbl = container->tables[i];
+
+		if (!tbl)
+			continue;
+
+		ret = table_group->ops->set_window(table_group, i, tbl);
+		if (ret)
+			goto release_exit;
+	}
+
 	return 0;
+
+release_exit:
+	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i)
+		table_group->ops->unset_window(table_group, i);
+
+	table_group->ops->release_ownership(table_group);
+
+	return ret;
 }
 
 static int tce_iommu_attach_group(void *iommu_data,
