Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 0FED92C0096
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 13:33:37 +1000 (EST)
Message-ID: <1377228807.25163.33.camel@ul30vt.home>
Subject: Re: [PATCH] iommu: WARN_ON when removing a device with no
 iommu_group associated
From: Alex Williamson <alex.williamson@redhat.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Date: Thu, 22 Aug 2013 21:33:27 -0600
In-Reply-To: <1377222911-12144-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1377222911-12144-1-git-send-email-weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: benh@au1.ibm.com, aik@ozlabs.ru, linux-kernel@vger.kernel.org,
 iommu <iommu@lists.linux-foundation.org>, paulus@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[+cc iommu]

On Fri, 2013-08-23 at 09:55 +0800, Wei Yang wrote:
> When removing a device from the system, iommu_group driver will try to
> disconnect it from its group. While in some cases, one device may not
> associated with any iommu_group. For example, not enough DMA address space.
> 
> In the generic bus notification, it will check dev->iommu_group before calling
> iommu_group_remove_device(). While in some cases, developers may call
> iommu_group_remove_device() in a different code path and without check. For
> those devices with dev->iommu_group set to NULL, kernel will crash.
> 
> This patch gives a warning and return when trying to remove a device from an
> iommu_group with dev->iommu_group set to NULL. This helps to indicate some bad
> behavior and also guard the kernel.
> 
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>

Acked-by: Alex Williamson <alex.williamson@redhat.com>

> ---
>  drivers/iommu/iommu.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index fbe9ca7..43396f0 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -379,6 +379,9 @@ void iommu_group_remove_device(struct device *dev)
>  	struct iommu_group *group = dev->iommu_group;
>  	struct iommu_device *tmp_device, *device = NULL;
>  
> +	if (WARN_ON(!group))
> +		return;
> +
>  	/* Pre-notify listeners that a device is being removed. */
>  	blocking_notifier_call_chain(&group->notifier,
>  				     IOMMU_GROUP_NOTIFY_DEL_DEVICE, dev);
