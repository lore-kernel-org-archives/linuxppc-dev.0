Return-Path: <SRS0=OFQA=UG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DF9C2BCA1
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Jun 2019 13:11:10 +0000 (UTC)
Received: from lists.ozlabs.org (unknown [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C876B208E3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Jun 2019 13:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C876B208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45L2wB4gt9zDqD0
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Jun 2019 23:11:06 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45L2rm2k5XzDqwC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jun 2019 23:08:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45L2rl70tlz9sNR;
 Fri,  7 Jun 2019 23:08:07 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Lynch <nathanl@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/pseries: fix oops in hotplug memory notifier
In-Reply-To: <20190607050407.25444-1-nathanl@linux.ibm.com>
References: <20190607050407.25444-1-nathanl@linux.ibm.com>
Date: Fri, 07 Jun 2019 23:08:01 +1000
Message-ID: <87tvd1h7bi.fsf@concordia.ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nathan Lynch <nathanl@linux.ibm.com> writes:

> During post-migration device tree updates, we can oops in
> pseries_update_drconf_memory if the source device tree has an
> ibm,dynamic-memory-v2 property and the destination has a
> ibm,dynamic_memory (v1) property. The notifier processes an "update"
> for the ibm,dynamic-memory property but it's really an add in this
> scenario. So make sure the old property object is there before
> dereferencing it.
>
> Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>

Can you pinpoint a commit that introduced the bug? Should we backport
this to stable?

Perhaps?
  Fixes: 2b31e3aec1db ("powerpc/drmem: Add support for ibm, dynamic-memory-v2 property")

cheers

> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index 47087832f8b2..e6bd172bcf30 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -980,6 +980,9 @@ static int pseries_update_drconf_memory(struct of_reconfig_data *pr)
>  	if (!memblock_size)
>  		return -EINVAL;
>  
> +	if (!pr->old_prop)
> +		return 0;
> +
>  	p = (__be32 *) pr->old_prop->value;
>  	if (!p)
>  		return -EINVAL;
> -- 
> 2.20.1
