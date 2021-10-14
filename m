Return-Path: <SRS0=Ntje=PC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F64C433F5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Oct 2021 17:33:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13938610F8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Oct 2021 17:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 13938610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HVc270llNz3c6m
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Oct 2021 04:33:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=b4Nc5rxC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::931;
 helo=mail-ua1-x931.google.com; envelope-from=leobras.c@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=b4Nc5rxC; dkim-atps=neutral
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com
 [IPv6:2607:f8b0:4864:20::931])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HVc1N1S14z2yPF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Oct 2021 04:32:54 +1100 (AEDT)
Received: by mail-ua1-x931.google.com with SMTP id f4so12832251uad.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Oct 2021 10:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=NNLIU855d3FWPmYu6pUhg7wLsuUsKX7VYiKpRPPe7Bk=;
 b=b4Nc5rxCC1om0hpdesQnbN8+7Hnc5yD378P5ZIuX8gCQBGWHyYQZI7eEbE0Ml3qbOO
 pJ4L0I6vHDW6efOTv4gwn77szHRZ6cxCkJQUahE/0OELaDdLTAD2rVnBxrnhxgC6AXtU
 nOc/kgio9SDYCrj9ynQ53MGYPkBSVObJyE1Ow60Kkr7EGImxAerBJY2WnxCuMH2GkVl9
 k1e5n528ToVyZGb5gwJj3A++cabKLWRCRM0DFdOaKZIKXO/vOCDDrBTmK+B6SdwkS8bN
 TAiXGcqwvWK8bbjC55ZqD812en8Z5rGCZE1jj1CPTwPJM9sdVBSOrxYarPJq88lX/AAs
 /qqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=NNLIU855d3FWPmYu6pUhg7wLsuUsKX7VYiKpRPPe7Bk=;
 b=Fll+n/mGDHIOLv5fU6H1nACk6VZdvxbtcsPvH43NjhlbRpDsov++Z+M6Amf37QhRsO
 tfSUEQkFc+VjtHMWBq96KlZJSd62RSxvPOj1pgLA6fAKk7Wo8stCYYjHCBCyn+yTHImS
 lQ0Fv/I1v5+gqS/eFKOwUeCDdBTPXYI0NMOhqWFXtwTEBJpkDjxsAUkbCHgewpIy/jjN
 LHWoSjh3fy0D4dBhxzt53X5jQtm6WuslNdC9yyr8zCN3XL975KzXzwQWVIe7pXl3ZEsy
 CKxOVrcVoD1/sAh2XX/QnErgcQcDjMrfYrDkyJv+H/6jQV2IaEcuuO4yLmb1M+gHLjef
 x6Ug==
X-Gm-Message-State: AOAM533Xr/dYmxaHGdf7xKSBoPuzj6aJDZp21KQa+FNqxAXXZPt6uri7
 x1fYSyTxLzT4SWATaEjSPsw=
X-Google-Smtp-Source: ABdhPJwEO+fPpwYjQ94fUfOQc9qKYHLagRSqUkrs3ttA+88eYNhX+twHOdUKwk2KJNogZRIXsrztNg==
X-Received: by 2002:ab0:6d8d:: with SMTP id m13mr7661022uah.113.1634232768841; 
 Thu, 14 Oct 2021 10:32:48 -0700 (PDT)
Received: from ?IPv6:2804:14c:b382:8c61:6dfb:957c:fd41:44ce?
 ([2804:14c:b382:8c61:6dfb:957c:fd41:44ce])
 by smtp.gmail.com with ESMTPSA id q62sm2090340vkg.22.2021.10.14.10.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Oct 2021 10:32:48 -0700 (PDT)
Message-ID: <52f1cec812e81b45dbbc28eef3cd90cc9c0a90ae.camel@gmail.com>
Subject: Re: [PATCH] powerpc/pseries/iommu: Add of_node_put() before break
From: Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To: Wan Jiabing <wanjiabing@vivo.com>, Michael Ellerman
 <mpe@ellerman.id.au>,  Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, 
 Frederic Barrat <fbarrat@linux.ibm.com>, David Gibson
 <david@gibson.dropbear.id.au>,  linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Thu, 14 Oct 2021 14:32:43 -0300
In-Reply-To: <20211014075624.16344-1-wanjiabing@vivo.com>
References: <20211014075624.16344-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: kael_w@yeah.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello Wan, thank you for this patch.


On Thu, 2021-10-14 at 03:56 -0400, Wan Jiabing wrote:
> Fix following coccicheck warning:
> 
> ./arch/powerpc/platforms/pseries/iommu.c:924:1-28: WARNING: Function
> for_each_node_with_property should have of_node_put() before break
> 
> Early exits from for_each_node_with_property should decrement the
> node reference counter.

Yeah, it makes sense to me. 

for_each_node_with_property calls of_find_node_with_property() at each
step, which ends up calling of_node_put() after using each node.

Introducing this break caused this of_node_put not to happen to the
last node, so IIUC this patch fixes a possible issue if kzalloc() fails
in ddw_list_new_entry().

Another option would be s/break/continue here, but it does not make
sense to keep trying next nodes if there is no memory to allocate for a
struct dma_win (4 pointers).

On the other hard, failing on allocating such small space should not
happen often (if it will ever happen), so a 'continue' here makes code
simpler.  
 
Anyway, FWIW:
Reviewed-by: Leonardo Bras <leobras.c@gmail.com>


Best regards,
Leo

> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  arch/powerpc/platforms/pseries/iommu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/iommu.c
> b/arch/powerpc/platforms/pseries/iommu.c
> index 269f61d519c2..c140aa683f66 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -929,8 +929,10 @@ static void find_existing_ddw_windows_named(const
> char *name)
>                 }
>  
>                 window = ddw_list_new_entry(pdn, dma64);
> -               if (!window)
> +               if (!window) {
> +                       of_node_put(pdn);
>                         break;
> +               }
>  
>                 spin_lock(&dma_win_list_lock);
>                 list_add(&window->list, &dma_win_list);


