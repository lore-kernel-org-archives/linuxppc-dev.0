Return-Path: <linuxppc-dev+bounces-18789-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD05109C059
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2026 20:00:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgySr1msVz2yYJ;
	Thu, 26 Mar 2026 07:00:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=37.157.195.192
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774468844;
	cv=none; b=h43MijiDe+mwGS4S3rNruVUQ936vbEsBK0Q+uagA1F1YliV3IOwNGFte9IiAutFDvnWVqyLnP1EP3EUgf0gTinUFPEHL6F57zLtGM9y8mNUV/l2UE8eaBNv8kOimIteu6QOnje63Mk3rG3tgVSQpT7OY7aTAr6FhfizomLboPSIycLpe9aB19JdruvmuUGuJ2sg53CDte54ngvj53useBTt6N0YxA6usvFwe+MqW2Tr4AuFMKqIFphJ6PMrjVR8r4EU0LCEn3bWX6l7XlHuHqhmMXTlZKnTy7Zs+ReiPtjgvRkP3rdezPdGDN33PSciwgBke0VCy5pnbu7aGCy++LA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774468844; c=relaxed/relaxed;
	bh=yFQsydCIOr74lS0wiVlCraWXMEEN0D0iIRy2COVKBVc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=THWlnGNo39AIqYd4GWjUSNJwyBiIrDvIpF39MMEXPedhXgPhH+DDG06vvGhux1+Z9b2AL5eBtoiL1SEsXO7UVuPBxtxUwQ693HO3D6LzQcMiFUnmhEUJJR7z72mME1V0qjenm4Lfm9LR73g826oiyizggugDt58LMsO711lb0KrXHUmgeSCD+iJGdEaLr2r3AbM3UskPGVonCMO1w5Y6ulyS+SsG+qiGi+7TonYAKuEEvvPxUbfKvtTB5y//FL3bc1yv9DNUKgkGWwFbP3IqPJe+ussoEEHKwhTLjqoxsf5gJLpKDllViPZ/GS8fGqe951mztRE269Vlvquy8opdIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=danny.cz; spf=pass (client-ip=37.157.195.192; helo=redcrew.org; envelope-from=dan@danny.cz; receiver=lists.ozlabs.org) smtp.mailfrom=danny.cz
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=danny.cz
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=danny.cz (client-ip=37.157.195.192; helo=redcrew.org; envelope-from=dan@danny.cz; receiver=lists.ozlabs.org)
Received: from redcrew.org (redcrew.org [37.157.195.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgySq0mT9z2yY0
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 07:00:41 +1100 (AEDT)
Received: from server.danny.cz (85-71-161-19.rce.o2.cz [85.71.161.19])
	by redcrew.org (Postfix) with ESMTP id 595E7D4;
	Wed, 25 Mar 2026 21:00:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 redcrew.org 595E7D4
Received: from talos.danny.cz (talos [IPv6:2001:470:5c11:160:47df:83f6:718e:218])
	by server.danny.cz (Postfix) with SMTP id 2FA9F17A006;
	Wed, 25 Mar 2026 21:00:37 +0100 (CET)
Date: Wed, 25 Mar 2026 21:00:37 +0100
From: Dan =?UTF-8?B?SG9yw6Fr?= <dan@danny.cz>
To: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Gaurav Batra <gbatra@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 amd-gfx@lists.freedesktop.org, Donet Tom <donettom@linux.ibm.com>
Subject: Re: amdgpu driver fails to initialize on ppc64le in 7.0-rc1 and
 newer
Message-Id: <20260325210037.1e5de5f6f99851088ceaf15a@danny.cz>
In-Reply-To: <341nolfr.ritesh.list@gmail.com>
References: <20260313142351.609bc4c3efe1184f64ca5f44@danny.cz>
	<1phlu3bs.ritesh.list@gmail.com>
	<20260315105021.667e52d4a99b154ef1e6aa34@danny.cz>
	<da93575e-92ad-4a7b-83df-1cb956bd2bc2@linux.ibm.com>
	<5x6knm5q.ritesh.list@gmail.com>
	<2d5fd6ec-003f-4d24-aa2e-06ba94d6cba4@linux.ibm.com>
	<341nolfr.ritesh.list@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; powerpc64le-redhat-linux-gnu)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Mar 2026 23:12:16 +0530
Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:

> Gaurav Batra <gbatra@linux.ibm.com> writes:
> 
> > Hello Ritesh
> >
> > I think, what you are proposing to add dev->bus_dma_limit in the check 
> > might work. In the case of PowerNV, this is not set, but 
> > dev->dma_ops_bypass is set. So, for PowerNV, it will fall back to how it 
> > was before.
> >
> > Also, since these both are set in LPAR mode, the current patch as-is 
> > will work.
> >
> > Dan, can you please try Ritesh proposed fix on your PowerNV box? I am 
> > not able to lay my hands on a PowerNV box yet.
> >
> 
> It would be this diff then. Note, I have only compile tested it.
> 
> diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
> index 73e10bd4d56d..8b4de508d2eb 100644
> --- a/arch/powerpc/kernel/dma-iommu.c
> +++ b/arch/powerpc/kernel/dma-iommu.c
> @@ -67,7 +67,7 @@ bool arch_dma_unmap_sg_direct(struct device *dev, struct scatterlist *sg,
>  }
>  bool arch_dma_alloc_direct(struct device *dev)
>  {
> -       if (dev->dma_ops_bypass)
> +       if (dev->dma_ops_bypass && dev->bus_dma_limit)
>                 return true;
> 
>         return false;
> @@ -75,7 +75,7 @@ bool arch_dma_alloc_direct(struct device *dev)
> 
>  bool arch_dma_free_direct(struct device *dev, dma_addr_t dma_handle)
>  {
> -       if (!dev->dma_ops_bypass)
> +       if (!dev->dma_ops_bypass || !dev->bus_dma_limit)
>                 return false;
> 
>         return is_direct_handle(dev, dma_handle);

yup, I will give it a try in the morning and report back


		Dan

