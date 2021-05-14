Return-Path: <SRS0=oOud=KJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2437C433ED
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 May 2021 20:55:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30C6360FE7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 May 2021 20:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C6360FE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FhglM65v8z3bsG
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 May 2021 06:55:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=moE/5udN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::834;
 helo=mail-qt1-x834.google.com; envelope-from=danielhb413@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=moE/5udN; dkim-atps=neutral
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fhgkq1gdKz2xZ3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 May 2021 06:54:40 +1000 (AEST)
Received: by mail-qt1-x834.google.com with SMTP id k10so572011qtp.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 May 2021 13:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5KscWBwPnT2I+Bz9swryA6HUOI5XdNSqc+A8vVOU/M0=;
 b=moE/5udNpZjJ9TIPJu03PileNO5lh4YMDpEBjdmCvFlornPU0jRdN2OpKQ8fRHTSav
 VdEmn8KwY5DJvcYlKaYMW9NYvyALNqZrt/m+zU9pBjTfTXjJ2fF6CTiT6ba9M1VkJVb9
 SelsMjgS4cfF9m71kZDaQRCZPsTusDIDsuhHh/oLtzqNxkSS29gAi4z3VTn1ZRav09IJ
 a6218PhFHgzzuWw17ahn5vIynRrSRPD14LFUVqg5zFx7nhXih8zKwTBeRvK/rJRXmhiU
 OE6JN+xWACor42TFkKc26r/Rh7xVD6rVYroSo81CzLvGjaXFh3DcSKpgA4siyO1lnlhx
 sf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5KscWBwPnT2I+Bz9swryA6HUOI5XdNSqc+A8vVOU/M0=;
 b=nEnxoqZnQGRQHMKr8U+HtymjvmgjWjniE35aGd7NkvxyqZMbLKSzUn+cisgfslW1TD
 PgYXfJxUNsMoHgcCVfUIv8RGXpdBYU0dwXvnZDQp9xdaWLqKDCUY+AsSvoeVT/3ai0Gv
 BZ0gLzkx/UddAoI+drtLaHD2sTVUmhU2tQdi2JNFsqnP4F+8lCWWYCktmehI8nO3RtAV
 YAhckstyfR6XfhFiRAPMz4Tg4ys9PpIMuKdQ/pAY9IEPKwORWRERfs3N8SjLcX/nE/1I
 4xDGGMx27uR+zAqGilB8hVwZNzPVVCbCGqp1pBw0QEI75KTk4ovpGEGGlRCr5+huugVH
 mEfQ==
X-Gm-Message-State: AOAM531QBhIVPtR/qQtUKrtmSXLBBNG+8N9ELolFUAefGj7+EWtAFuaP
 OPcMbKx4AG80CZ+m0Z+tODY=
X-Google-Smtp-Source: ABdhPJxN7ctrnthMX1N4LHOUfQNkbKsW5myGJbp1pPiGpCa/oPnIT2TYxVm85Uec69F/+KavCEQi6w==
X-Received: by 2002:a05:622a:170b:: with SMTP id
 h11mr30439575qtk.330.1621025676107; 
 Fri, 14 May 2021 13:54:36 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c6:a510:72d6:4f88:14ef:1040?
 ([2804:431:c7c6:a510:72d6:4f88:14ef:1040])
 by smtp.gmail.com with ESMTPSA id p190sm5825860qke.13.2021.05.14.13.54.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 May 2021 13:54:35 -0700 (PDT)
Subject: Re: [PATCH -next] powerpc/pseries/memhotplug: Remove unused inline
 function dlpar_memory_remove()
To: YueHaibing <yuehaibing@huawei.com>, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org
References: <20210514071041.17432-1-yuehaibing@huawei.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <958eec4b-995b-e281-58d5-9f758e575b4e@gmail.com>
Date: Fri, 14 May 2021 17:54:30 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210514071041.17432-1-yuehaibing@huawei.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 5/14/21 4:10 AM, YueHaibing wrote:
> dlpar_memory_remove() is never used, so can be removed.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>

>   arch/powerpc/platforms/pseries/hotplug-memory.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index 8377f1f7c78e..3d93f1c48e23 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -585,10 +585,6 @@ static inline int pseries_remove_mem_node(struct device_node *np)
>   {
>   	return 0;
>   }
> -static inline int dlpar_memory_remove(struct pseries_hp_errorlog *hp_elog)
> -{
> -	return -EOPNOTSUPP;
> -}
>   static int dlpar_remove_lmb(struct drmem_lmb *lmb)
>   {
>   	return -EOPNOTSUPP;
> 
