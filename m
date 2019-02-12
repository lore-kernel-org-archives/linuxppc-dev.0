Return-Path: <SRS0=0iBm=QT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5ADC282C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 20:54:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A6E520842
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 20:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6E520842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zZdk4rY5zDqRS
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:54:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zZby2dqrzDqLP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 07:52:46 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 59282C074110;
 Tue, 12 Feb 2019 20:52:44 +0000 (UTC)
Received: from w520.home (ovpn-116-24.phx2.redhat.com [10.3.116.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D6B35C21A;
 Tue, 12 Feb 2019 20:52:43 +0000 (UTC)
Date: Tue, 12 Feb 2019 13:52:42 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel] vfio/spapr_tce: Skip unsetting already unset table
Message-ID: <20190212135242.78b988d0@w520.home>
In-Reply-To: <20190211074917.125723-1-aik@ozlabs.ru>
References: <20190211074917.125723-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Tue, 12 Feb 2019 20:52:44 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 11 Feb 2019 18:49:17 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> VFIO TCE IOMMU v2 owns IOMMU tables so when detach a IOMMU group from
> a container, we need to unset those from a group so we call unset_window()
> so do we unconditionally. We also unset tables when removing a DMA window

Patch looks ok, but this first sentence trails off into a bit of a word
salad.  Care to refine a bit?  Thanks,

Alex

> via the VFIO_IOMMU_SPAPR_TCE_REMOVE ioctl.
> 
> The window removal checks if the table actually exists (hidden inside
> tce_iommu_find_table()) but the group detaching does not so the user
> may see duplicating messages:
> pci 0009:03     : [PE# fd] Removing DMA window #0
> pci 0009:03     : [PE# fd] Removing DMA window #1
> pci 0009:03     : [PE# fd] Removing DMA window #0
> pci 0009:03     : [PE# fd] Removing DMA window #1
> 
> At the moment this is not a problem as the second invocation
> of unset_window() writes zeroes to the HW registers again and exits early
> as there is no table.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> 
> When doing VFIO PCI hot unplug, first we remove the DMA window and
> set container->tables[num] - this is a first couple of messages.
> Then we detach the group and then we see another couple of the same
> messages which confused myself.
> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
> index c424913..8dbb270 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -1235,7 +1235,8 @@ static void tce_iommu_release_ownership_ddw(struct tce_container *container,
>  	}
>  
>  	for (i = 0; i < IOMMU_TABLE_GROUP_MAX_TABLES; ++i)
> -		table_group->ops->unset_window(table_group, i);
> +		if (container->tables[i])
> +			table_group->ops->unset_window(table_group, i);
>  
>  	table_group->ops->release_ownership(table_group);
>  }

