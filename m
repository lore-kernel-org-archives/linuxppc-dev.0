Return-Path: <linuxppc-dev+bounces-18818-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B71106F31B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 10:29:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhKlB4V7yz2xlM;
	Thu, 26 Mar 2026 21:29:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=37.157.195.192
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774520966;
	cv=none; b=CSIq9TmV8NeCVZrPeMQMfCbfMETnUzwX1L1rduMgXTcyCW4PvYH4y/xddvttmmFJTYLFZo8uUApHsEMqmhZEnvfhd9VPqGEQs9uzXvoeSyEgI6i9PbWZAFrndqh7gezERWHn4SF/rNLpBn/UFVFr/gB4HipQTFCFLfjOmUbvuJdgdlpztYNe6AdmwBQmk3mkwdy9b7/GhPt/CaCkoPRAUdf9ITo9NKqYOTBlTJz3TDLHJqiKGbNeE/DHZ0Th8CsiKSjpPzK1pDrzWcC6obRAKA2ylcMMEYmJ9ZGZVSrOC1Et2k3TzjLBoTCkRC254+zFt06NPotCxQ+8YHXugjRISQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774520966; c=relaxed/relaxed;
	bh=DMbomI0K1dBxzSgGXdSenFtHAhLWFml8enUy3EmsNx8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eI+gUghZAl47Hq8oZ/4MZj/BfAXQpupkp+v6yxWj4RYh6fVSnx1xT+4autG3K46hkEScceVUh8JSGNKhfL1t6iNXJ5UeztPRQf/8peDpgqpRvp4fn0suDIWq5bp6BaWWZN0MkHPxGGG8tW3WrWdS7Axjccp3CdE5iTf+GnV38aeVU0qkJF2FnFlQUWHbPYHWOb3dS3at5H7z50UMY7eZh4TTZCjKCGPOckBB2IVuTaCvBFnq3Vsg86MVlWOAeubv9Kt8QRyvRdhCPpcyqG8NXUBih/lfO+YiYRPiR0lzYBSFSMyYsRlaivosF3JZYZ81Xdu9piLd/8LrZbRrqPwAVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=danny.cz; spf=pass (client-ip=37.157.195.192; helo=redcrew.org; envelope-from=dan@danny.cz; receiver=lists.ozlabs.org) smtp.mailfrom=danny.cz
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=danny.cz
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=danny.cz (client-ip=37.157.195.192; helo=redcrew.org; envelope-from=dan@danny.cz; receiver=lists.ozlabs.org)
Received: from redcrew.org (redcrew.org [37.157.195.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhKl90B2Gz2xN8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 21:29:23 +1100 (AEDT)
Received: from server.danny.cz (85-71-161-19.rce.o2.cz [85.71.161.19])
	by redcrew.org (Postfix) with ESMTP id 82805D4;
	Thu, 26 Mar 2026 11:29:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 redcrew.org 82805D4
Received: from talos.danny.cz (talos [IPv6:2001:470:5c11:160:47df:83f6:718e:218])
	by server.danny.cz (Postfix) with SMTP id 421DD17A006;
	Thu, 26 Mar 2026 11:29:20 +0100 (CET)
Date: Thu, 26 Mar 2026 11:29:20 +0100
From: Dan =?UTF-8?B?SG9yw6Fr?= <dan@danny.cz>
To: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Gaurav Batra <gbatra@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 amd-gfx@lists.freedesktop.org, Donet Tom <donettom@linux.ibm.com>
Subject: Re: amdgpu driver fails to initialize on ppc64le in 7.0-rc1 and
 newer
Message-Id: <20260326112920.07eb56ee6d133947d8bcf6f3@danny.cz>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ritesh,

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

this seems to fix the amdgpu initialization, full kernel log available
as https://fedora.danny.cz/tmp/kernel-7.0-rc5.log

Tested-by: Dan Horák <dan@danny.cz>


		Dan

