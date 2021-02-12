Return-Path: <SRS0=Xeze=HO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8469EC433E6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Feb 2021 16:53:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D529A64E8C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Feb 2021 16:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D529A64E8C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dcfhc1cVyzDwnd
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Feb 2021 03:53:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=lvivier@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=LcaYne+p; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LcaYne+p; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dcffx6q4czDwmS
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Feb 2021 03:52:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613148723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HwuucntKVy9+H2UoHo2+dgorK0b8KRqhqcCY+C9nrig=;
 b=LcaYne+p9S+xcJYynlqwkoYc2GuvTHr1nOHLMRGrwiJbc1HapDwNSChkV0DvaSBAo9AMhs
 YK9BmhRnOfoOMiUatquMh3VV5Z3y7cyzVCuHa5Us85lyKs8X7gFdqLt0kNxUVmhkVjTV5n
 bEmdBJdCBrnFBmsfvTTWwvA73Ls9BuI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613148723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HwuucntKVy9+H2UoHo2+dgorK0b8KRqhqcCY+C9nrig=;
 b=LcaYne+p9S+xcJYynlqwkoYc2GuvTHr1nOHLMRGrwiJbc1HapDwNSChkV0DvaSBAo9AMhs
 YK9BmhRnOfoOMiUatquMh3VV5Z3y7cyzVCuHa5Us85lyKs8X7gFdqLt0kNxUVmhkVjTV5n
 bEmdBJdCBrnFBmsfvTTWwvA73Ls9BuI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-iSWoKwKQMOK8cc1ChY21Lg-1; Fri, 12 Feb 2021 11:52:01 -0500
X-MC-Unique: iSWoKwKQMOK8cc1ChY21Lg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AC8479EC2;
 Fri, 12 Feb 2021 16:52:00 +0000 (UTC)
Received: from [10.36.112.23] (ovpn-112-23.ams2.redhat.com [10.36.112.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4DF45D9FC;
 Fri, 12 Feb 2021 16:51:58 +0000 (UTC)
Subject: Re: [PATCH] powerpc/pseries: Don't enforce MSI affinity with kdump
To: Greg Kurz <groug@kaod.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <20210212164132.821332-1-groug@kaod.org>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <81b4e767-289f-8fb6-9e05-c3fe60beb740@redhat.com>
Date: Fri, 12 Feb 2021 17:51:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210212164132.821332-1-groug@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 12/02/2021 17:41, Greg Kurz wrote:
> Depending on the number of online CPUs in the original kernel, it is
> likely for CPU #0 to be offline in a kdump kernel. The associated IRQs
> in the affinity mappings provided by irq_create_affinity_masks() are
> thus not started by irq_startup(), as per-design with managed IRQs.
> 
> This can be a problem with multi-queue block devices driven by blk-mq :
> such a non-started IRQ is very likely paired with the single queue
> enforced by blk-mq during kdump (see blk_mq_alloc_tag_set()). This
> causes the device to remain silent and likely hangs the guest at
> some point.
> 
> This is a regression caused by commit 9ea69a55b3b9 ("powerpc/pseries:
> Pass MSI affinity to irq_create_mapping()"). Note that this only happens
> with the XIVE interrupt controller because XICS has a workaround to bypass
> affinity, which is activated during kdump with the "noirqdistrib" kernel
> parameter.
> 
> The issue comes from a combination of factors:
> - discrepancy between the number of queues detected by the multi-queue
>   block driver, that was used to create the MSI vectors, and the single
>   queue mode enforced later on by blk-mq because of kdump (i.e. keeping
>   all queues fixes the issue)
> - CPU#0 offline (i.e. kdump always succeed with CPU#0)
> 
> Given that I couldn't reproduce on x86, which seems to always have CPU#0
> online even during kdump, I'm not sure where this should be fixed. Hence
> going for another approach : fine-grained affinity is for performance
> and we don't really care about that during kdump. Simply revert to the
> previous working behavior of ignoring affinity masks in this case only.
> 
> Fixes: 9ea69a55b3b9 ("powerpc/pseries: Pass MSI affinity to irq_create_mapping()")
> Cc: lvivier@redhat.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  arch/powerpc/platforms/pseries/msi.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
> index b3ac2455faad..29d04b83288d 100644
> --- a/arch/powerpc/platforms/pseries/msi.c
> +++ b/arch/powerpc/platforms/pseries/msi.c
> @@ -458,8 +458,28 @@ static int rtas_setup_msi_irqs(struct pci_dev *pdev, int nvec_in, int type)
>  			return hwirq;
>  		}
>  
> -		virq = irq_create_mapping_affinity(NULL, hwirq,
> -						   entry->affinity);
> +		/*
> +		 * Depending on the number of online CPUs in the original
> +		 * kernel, it is likely for CPU #0 to be offline in a kdump
> +		 * kernel. The associated IRQs in the affinity mappings
> +		 * provided by irq_create_affinity_masks() are thus not
> +		 * started by irq_startup(), as per-design for managed IRQs.
> +		 * This can be a problem with multi-queue block devices driven
> +		 * by blk-mq : such a non-started IRQ is very likely paired
> +		 * with the single queue enforced by blk-mq during kdump (see
> +		 * blk_mq_alloc_tag_set()). This causes the device to remain
> +		 * silent and likely hangs the guest at some point.
> +		 *
> +		 * We don't really care for fine-grained affinity when doing
> +		 * kdump actually : simply ignore the pre-computed affinity
> +		 * masks in this case and let the default mask with all CPUs
> +		 * be used when creating the IRQ mappings.
> +		 */
> +		if (is_kdump_kernel())
> +			virq = irq_create_mapping(NULL, hwirq);
> +		else
> +			virq = irq_create_mapping_affinity(NULL, hwirq,
> +							   entry->affinity);
>  
>  		if (!virq) {
>  			pr_debug("rtas_msi: Failed mapping hwirq %d\n", hwirq);
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

