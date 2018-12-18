Return-Path: <SRS0=nim+=O3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB10C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 23:36:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAFA321873
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 23:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAFA321873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43KDtc48cFzDqWs
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 10:36:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43KDqr6Y89zDqZR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 10:34:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43KDqq5fXbz9s3Z;
 Wed, 19 Dec 2018 10:33:59 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH kernel v5 03/20] powerpc/vfio/iommu/kvm: Do not pin device
 memory
In-Reply-To: <20181213061734.16651-4-aik@ozlabs.ru>
References: <20181213061734.16651-1-aik@ozlabs.ru>
 <20181213061734.16651-4-aik@ozlabs.ru>
Date: Wed, 19 Dec 2018 10:33:57 +1100
Message-ID: <87va3qs93u.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alistair Popple <alistair@popple.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>, kvm-ppc@vger.kernel.org,
 Sam Bobroff <sbobroff@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Leonardo Augusto =?utf-8?Q?Guimar=C3=A3es?= Garcia <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index f0dc680..cbcc615 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -993,15 +994,19 @@ int iommu_tce_check_gpa(unsigned long page_shift, unsigned long gpa)
>  }
>  EXPORT_SYMBOL_GPL(iommu_tce_check_gpa);
>  
> -long iommu_tce_xchg(struct iommu_table *tbl, unsigned long entry,
> -		unsigned long *hpa, enum dma_data_direction *direction)
> +long iommu_tce_xchg(struct mm_struct *mm, struct iommu_table *tbl,
> +		unsigned long entry, unsigned long *hpa,
> +		enum dma_data_direction *direction)
>  {
>  	long ret;
> +	unsigned long size = 0;
>  
>  	ret = tbl->it_ops->exchange(tbl, entry, hpa, direction);
>  
>  	if (!ret && ((*direction == DMA_FROM_DEVICE) ||
> -			(*direction == DMA_BIDIRECTIONAL)))
> +			(*direction == DMA_BIDIRECTIONAL)) &&
> +			!mm_iommu_is_devmem(mm, *hpa, tbl->it_page_shift,
> +					&size))

This is breaking a bunch of configs with:

  arch/powerpc/kernel/iommu.c:1008:5: error: implicit declaration of function 'mm_iommu_is_devmem'; did you mean 'iommu_del_device'? [-Werror=implicit-function-declaration]

eg: http://kisskb.ellerman.id.au/kisskb/buildresult/13623063/

> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
> index 25a4b7f7..06fdbd3 100644
> --- a/arch/powerpc/mm/mmu_context_iommu.c
> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> @@ -384,6 +432,33 @@ extern void mm_iommu_ua_mark_dirty_rm(struct mm_struct *mm, unsigned long ua)
>  	*pa |= MM_IOMMU_TABLE_GROUP_PAGE_DIRTY;
>  }
>  
> +extern bool mm_iommu_is_devmem(struct mm_struct *mm, unsigned long hpa,
> +		unsigned int pageshift, unsigned long *size)
> +{

You shouldn't need extern in a C file.

cheers
