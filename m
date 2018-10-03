Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4BBC00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 18:19:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 051052089F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 18:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051052089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42QPRS379mzF39S
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 04:19:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QPPH6QTTzF37w
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 04:17:06 +1000 (AEST)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D60E330BDA0B;
 Wed,  3 Oct 2018 18:17:03 +0000 (UTC)
Received: from t450s.home (ovpn-116-90.phx2.redhat.com [10.3.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05F1C106A780;
 Wed,  3 Oct 2018 18:17:02 +0000 (UTC)
Date: Wed, 3 Oct 2018 12:17:02 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [RFC PATCH kernel] vfio/spapr_tce: Get rid of possible infinite
 loop
Message-ID: <20181003121702.13e66bdd@t450s.home>
In-Reply-To: <20181002032231.7494-1-aik@ozlabs.ru>
References: <20181002032231.7494-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 03 Oct 2018 18:17:04 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue,  2 Oct 2018 13:22:31 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> As a part of cleanup, the SPAPR TCE IOMMU subdriver releases preregistered
> memory. If there is a bug in memory release, the loop in
> tce_iommu_release() becomes infinite; this actually happened to me.
> 
> This makes the loop finite and prints a warning on every failure to make
> the code more bug prone.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

Should this have a stable/fixes tag?  Looks like it's relevant to:

4b6fad7097f8 powerpc/mm/iommu, vfio/spapr: Put pages on VFIO container shutdown

Also, not sure who you're wanting to take this since it was sent to ppc
lists.  If it's me, let me know, otherwise

Acked-by: Alex Williamson <alex.williamson@redhat.com>

Thanks,
Alex

> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
> index b1a8ab3..ece0651 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -371,6 +371,7 @@ static void tce_iommu_release(void *iommu_data)
>  {
>  	struct tce_container *container = iommu_data;
>  	struct tce_iommu_group *tcegrp;
> +	struct tce_iommu_prereg *tcemem, *tmtmp;
>  	long i;
>  
>  	while (tce_groups_attached(container)) {
> @@ -393,13 +394,8 @@ static void tce_iommu_release(void *iommu_data)
>  		tce_iommu_free_table(container, tbl);
>  	}
>  
> -	while (!list_empty(&container->prereg_list)) {
> -		struct tce_iommu_prereg *tcemem;
> -
> -		tcemem = list_first_entry(&container->prereg_list,
> -				struct tce_iommu_prereg, next);
> -		WARN_ON_ONCE(tce_iommu_prereg_free(container, tcemem));
> -	}
> +	list_for_each_entry_safe(tcemem, tmtmp, &container->prereg_list, next)
> +		WARN_ON(tce_iommu_prereg_free(container, tcemem));
>  
>  	tce_iommu_disable(container);
>  	if (container->mm)

