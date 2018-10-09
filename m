Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB183C64EAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 07:02:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3583E2075C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 07:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3583E2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Tp7V5JFMzF39C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 18:01:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Tp5Q0bkhzDrGp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 18:00:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42Tp5P1wtPz9s47;
 Tue,  9 Oct 2018 18:00:08 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: YueHaibing <yuehaibing@huawei.com>, benh@kernel.crashing.org,
 paulus@samba.org, nfont@linux.vnet.ibm.com
Subject: Re: [PATCH v2 -next] powerpc/pseries/memory-hotplug: Fix return value
 type of find_aa_index
In-Reply-To: <20181004094113.5492-1-yuehaibing@huawei.com>
References: <20181004094113.5492-1-yuehaibing@huawei.com>
Date: Tue, 09 Oct 2018 18:00:08 +1100
Message-ID: <871s8z38qv.fsf@concordia.ellerman.id.au>
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
Cc: YueHaibing <yuehaibing@huawei.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

YueHaibing <yuehaibing@huawei.com> writes:
> 'aa_index' is defined as an unsigned value, but find_aa_index
> may return -1 when dlpar_clone_property fails. So we use an rc
> value to track the validation of finding the aa_index instead
> of the 'aa_index' value itself
>
> Fixes: c05a5a40969e ("powerpc/pseries: Dynamic add entires to associativity lookup array")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v2: use 'rc' track the validation of aa_index

Thanks for sending a v2, some more comments ...

> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index 9a15d39..796e68b 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -101,13 +101,12 @@ static struct property *dlpar_clone_property(struct property *prop,
>  	return new_prop;
>  }
>  
> -static u32 find_aa_index(struct device_node *dr_node,
> -			 struct property *ala_prop, const u32 *lmb_assoc)
> +static int find_aa_index(struct device_node *dr_node, struct property *ala_prop,
> +			 const u32 *lmb_assoc, u32 *aa_index)
>  {
>  	u32 *assoc_arrays;
> -	u32 aa_index;
>  	int aa_arrays, aa_array_entries, aa_array_sz;
> -	int i, index;
> +	int i, index, rc = -1;

It's preferable to leave rc uninitialised until we actually need to
initialise it, that gives the compiler the chance to warn us if we use
it inadvertently before that.

>  
>  	/*
>  	 * The ibm,associativity-lookup-arrays property is defined to be
> @@ -121,18 +120,18 @@ static u32 find_aa_index(struct device_node *dr_node,
>  	aa_array_entries = be32_to_cpu(assoc_arrays[1]);
>  	aa_array_sz = aa_array_entries * sizeof(u32);
>  
> -	aa_index = -1;

So that would be here:
	rc = -1;

But ..

>  	for (i = 0; i < aa_arrays; i++) {
>  		index = (i * aa_array_entries) + 2;
>  
>  		if (memcmp(&assoc_arrays[index], &lmb_assoc[1], aa_array_sz))
>  			continue;
>  
> -		aa_index = i;
> +		*aa_index = i;
> +		rc = 0;
>  		break;
>  	}

The 'rc' variable is basically a boolean now, it means "we found something".

And all we do with it in the found case (rc = 0) is test it below and return.

So can't we just return directly in the for loop above, rather than breaking?

In which case we don't need the rc variable at all.

And the whole function may as well return bool, rather than int.

Does that make sense?

cheers

> -	if (aa_index == -1) {
> +	if (rc == -1) {
>  		struct property *new_prop;
>  		u32 new_prop_size;
>  
> @@ -157,10 +156,11 @@ static u32 find_aa_index(struct device_node *dr_node,
>  		 * number of entries - 1 since we added its associativity
>  		 * to the end of the lookup array.
>  		 */
> -		aa_index = be32_to_cpu(assoc_arrays[0]) - 1;
> +		*aa_index = be32_to_cpu(assoc_arrays[0]) - 1;
> +		rc = 0;
>  	}
>  
> -	return aa_index;
> +	return rc;
>  }
>  
>  static int update_lmb_associativity_index(struct drmem_lmb *lmb)
