Return-Path: <SRS0=e0K3=L2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC7EC11F68
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Jul 2021 13:49:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2535613F4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Jul 2021 13:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2535613F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GGbzd18jfz3bXX
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Jul 2021 23:49:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=UEjOTwG3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::336;
 helo=mail-ot1-x336.google.com; envelope-from=groeck7@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=UEjOTwG3; dkim-atps=neutral
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GGbz56BDCz301N
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jul 2021 23:49:05 +1000 (AEST)
Received: by mail-ot1-x336.google.com with SMTP id
 n99-20020a9d206c0000b029045d4f996e62so10106370ota.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Jul 2021 06:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9x+juvDeOlaCtKmozneQfrCt9yo0Whbh1MNkOy7JJZU=;
 b=UEjOTwG3dEw4BMs9zskTAlB/qyEqwJyHyp2F3uc3IEyjANLR6uP1/H9KR/MbGUoN+q
 uXXp5fn/iI8ZGaLxshXE1VQxeK5/3UWORkO2pNxSV6JX6TB55C98dgtqR+ifQCzwR/+E
 tWXw5g4HJNLzPOLmN5ZESxRdKK1SlSI9vIjSxu/oxrzoNqDVDJAp6devlE/I9vjje1jl
 UriRs+KKNlto9yhu5Cc6j3zBlDtCEQbiH6DoyRIcLxwtvRuZjbkzbi0yal/mv3qJLt2a
 3fiDvGnsl5Hudqdx9BEktUwL9MS3wAY6jCzLNb0Q5Ly1c+F45rGX3brSqu3cPed6aviv
 JOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9x+juvDeOlaCtKmozneQfrCt9yo0Whbh1MNkOy7JJZU=;
 b=kDmt/r+f4LYwfGxrwhfQNAwBP1aKT+OjuOyMdHk5tGGev2x25uFos9EwHVxlXCmfgK
 wtrgGIrFeidwzkRNU4WpSBgljGDwV6ERw9HRsedq1kc8dqvhSF00k7xPP9Y82IF/IZ4z
 QGAYWZ962flO1vetZSqQF82erMQnr3eBkbhfJi/pCBcRtH4v8Gglt/HizBSKDrnOr/k/
 zopLXU6vEn+wvmgxjePhH0fp3mnGfqFRp+TKPL/XTApD/8AGptidcYxlf8Lr4tJp0IYB
 DoLS/xRfkb3VWlWV7CcdtMyNXgFc+BXJbmJttmYJJsRGSUq52XKynGCXNoGgfY5iuMaT
 729A==
X-Gm-Message-State: AOAM531ehAriV21+b6it4Yo95ZHhhWkc5X7QX8VYluvbrR+FRlmZ44Fh
 N27VeIhZY8elN/OS6BjbHnY=
X-Google-Smtp-Source: ABdhPJzlnGPxxKYZSXkVHHmfsdkLH9E7ecEfVsvBHCQZR82klKUBGGO/PYD4fEoEphoBmS1gKABKng==
X-Received: by 2002:a05:6830:823:: with SMTP id
 t3mr4518459ots.334.1625233740480; 
 Fri, 02 Jul 2021 06:49:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 n26sm599488oos.14.2021.07.02.06.48.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jul 2021 06:48:59 -0700 (PDT)
Subject: Re: [PATCH v15 12/12] of: Add plumbing for restricted DMA pool
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20210624155526.2775863-1-tientzu@chromium.org>
 <20210624155526.2775863-13-tientzu@chromium.org>
 <20210702030807.GA2685166@roeck-us.net>
 <87ca3ada-22ed-f40c-0089-ca6fffc04f24@arm.com>
 <20210702131829.GA11132@willie-the-truck>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <2f2d6633-2457-f7eb-81c1-355f56dc34ce@roeck-us.net>
Date: Fri, 2 Jul 2021 06:48:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210702131829.GA11132@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: heikki.krogerus@linux.intel.com,
 linux-devicetree <devicetree@vger.kernel.org>, peterz@infradead.org,
 linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
 Frank Rowand <frowand.list@gmail.com>, mingo@kernel.org, jxgao@google.com,
 sstabellini@kernel.org, Saravana Kannan <saravanak@google.com>,
 Joerg Roedel <joro@8bytes.org>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 xen-devel@lists.xenproject.org, Marek Szyprowski <m.szyprowski@samsung.com>,
 matthew.auld@intel.com, Nicolas Boichat <drinkcat@chromium.org>,
 thomas.hellstrom@linux.intel.com,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 intel-gfx@lists.freedesktop.org, Dan Williams <dan.j.williams@intel.com>,
 Rob Herring <robh+dt@kernel.org>, rodrigo.vivi@intel.com, bhelgaas@google.com,
 Claire Chang <tientzu@chromium.org>, boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 airlied@linux.ie, Thierry Reding <treding@nvidia.com>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 quic_qiancai@quicinc.com, lkml <linux-kernel@vger.kernel.org>,
 tfiga@chromium.org,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, xypron.glpk@gmx.de,
 thomas.lendacky@amd.com, linuxppc-dev@lists.ozlabs.org, bauerman@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 7/2/21 6:18 AM, Will Deacon wrote:
> On Fri, Jul 02, 2021 at 12:39:41PM +0100, Robin Murphy wrote:
>> On 2021-07-02 04:08, Guenter Roeck wrote:
>>> On Thu, Jun 24, 2021 at 11:55:26PM +0800, Claire Chang wrote:
>>>> If a device is not behind an IOMMU, we look up the device node and set
>>>> up the restricted DMA when the restricted-dma-pool is presented.
>>>>
>>>> Signed-off-by: Claire Chang <tientzu@chromium.org>
>>>> Tested-by: Stefano Stabellini <sstabellini@kernel.org>
>>>> Tested-by: Will Deacon <will@kernel.org>
>>>
>>> With this patch in place, all sparc and sparc64 qemu emulations
>>> fail to boot. Symptom is that the root file system is not found.
>>> Reverting this patch fixes the problem. Bisect log is attached.
>>
>> Ah, OF_ADDRESS depends on !SPARC, so of_dma_configure_id() is presumably
>> returning an unexpected -ENODEV from the of_dma_set_restricted_buffer()
>> stub. That should probably be returning 0 instead, since either way it's not
>> an error condition for it to simply do nothing.
> 
> Something like below?
> 

Yes, that does the trick.

> Will
> 
> --->8
> 
>>From 4d9dcb9210c1f37435b6088284e04b6b36ee8c4d Mon Sep 17 00:00:00 2001
> From: Will Deacon <will@kernel.org>
> Date: Fri, 2 Jul 2021 14:13:28 +0100
> Subject: [PATCH] of: Return success from of_dma_set_restricted_buffer() when
>   !OF_ADDRESS
> 
> When CONFIG_OF_ADDRESS=n, of_dma_set_restricted_buffer() returns -ENODEV
> and breaks the boot for sparc[64] machines. Return 0 instead, since the
> function is essentially a glorified NOP in this configuration.
> 
> Cc: Claire Chang <tientzu@chromium.org>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Link: https://lore.kernel.org/r/20210702030807.GA2685166@roeck-us.net
> Signed-off-by: Will Deacon <will@kernel.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/of/of_private.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index 8fde97565d11..34dd548c5eac 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -173,7 +173,8 @@ static inline int of_dma_get_range(struct device_node *np,
>   static inline int of_dma_set_restricted_buffer(struct device *dev,
>   					       struct device_node *np)
>   {
> -	return -ENODEV;
> +	/* Do nothing, successfully. */
> +	return 0;
>   }
>   #endif
>   
> 

