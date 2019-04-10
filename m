Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B9BC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 09:22:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0598B2077C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 09:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0598B2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fJb96z8xzDqP0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 19:22:29 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fJYM2v05zDqDq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 19:20:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44fJYL5j39z9s0W;
 Wed, 10 Apr 2019 19:20:54 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bharata B Rao <bharata@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/pseries: Provide verbose info about HPT resizing
 attempt
In-Reply-To: <20190410075555.9357-1-bharata@linux.ibm.com>
References: <20190410075555.9357-1-bharata@linux.ibm.com>
Date: Wed, 10 Apr 2019 20:20:53 +1000
Message-ID: <87h8b66u0q.fsf@concordia.ellerman.id.au>
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
Cc: Laurent Vivier <lvivier@redhat.com>, david@gibson.dropbear.id.au,
 aneesh.kumar@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Bharata B Rao <bharata@linux.ibm.com> writes:

> When HPT resizing is attempted in response to memory hotplug, we see
> the following messages from the kernel:
>
> lpar: Attempting to resize HPT to shift 23
> Unable to resize hash page table to target order 23: -28
>
> This gives a feeling as though we are trying to grow HPT but failed and
> hence bad things might happen in future. Improve the message a bit
> by explicitly printing the existing HPT shift value in addtion to
> the newly targeted value so that it is clear that we haven't failed
> to grow HPT. After this commit, the same message will appear like this:
>
> lpar: Attempting to resize HPT from shift 25 to 23
> Unable to resize hash page table to target order 23: -28
>
> Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>

I'd be inclined to just remove the "Attempting .." message.

But I have this patch from Laurent queued, which already reworks things:

  https://patchwork.ozlabs.org/patch/1055996/


Does that address your problem?

cheers

> diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
> index f2a9f0adc2d3..ecc7fa1876a9 100644
> --- a/arch/powerpc/platforms/pseries/lpar.c
> +++ b/arch/powerpc/platforms/pseries/lpar.c
> @@ -875,7 +875,8 @@ static int pseries_lpar_resize_hpt(unsigned long shift)
>  	if (!firmware_has_feature(FW_FEATURE_HPT_RESIZE))
>  		return -ENODEV;
>  
> -	pr_info("Attempting to resize HPT to shift %lu\n", shift);
> +	pr_info("Attempting to resize HPT from shift %llu to %lu\n", ppc64_pft_size,
> +		shift);
>  
>  	t0 = ktime_get();
>  
> -- 
> 2.17.1
