Return-Path: <linuxppc-dev+bounces-18200-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2A9D58B0A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Mar 2026 09:50:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYYPK4Vj7z2yYy;
	Sun, 15 Mar 2026 20:50:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=37.157.195.192
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773568229;
	cv=none; b=EYXEHXMeVvIDqhVnMVnfhW7NLXCZjXsuqRp5JvzEEyXtvjR7VcnkwXDFBAFW3aUjUIzRgT5YeFvOEXhYNYGu68H+7yFyRxxuLVAQ8+huLHg/YTq51QCdnLTudqutpXCxzainUQ941DHzzLnNzYn5nchu69no6xQSUosk10BXj9kN9DqU54epnsDo4hbC08DPb1MY24ouGMNhI2lyayQM+FKwvwo/y0KGmFGPjrXqWmeboZjXpS4VVkz9E0tS8azS6U9Cqn1codTXVNnN+ure0N7t7Xp2CBC2OxgstAHzvJw3gpjWBrMBqk1n+6fMsyNyh2RBvBI9a4ej0eG/Z60AmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773568229; c=relaxed/relaxed;
	bh=knHsnQpTk7zm1tOL+PSAbcXmbJ9lP60XjW/qddi9q/I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bwKgVtTuLmbtdcTagy6cYptJbw1hHCtFtUcEUFSTLSBYw1y9I2RHtaX4zIV8DP6jl6OGzXdMYu/4wx1eS35M/FTzzKU0lQALjUQEQe9NWeS2NlvN4cn5ltmF/xqXBcnuQn8OMdyxtR9vlv0bIgdIztJixstAwznZpS6LVTnOXP22Akkpe3I+n/GiG8EtcyNY+C2CxKipUiF4Uajj6MiSom7f1/+G2SItAdpJitb8T3ovrD3RcltPPBZuJ9WSnrlqJK79cobp4tEufarqM5gKs0Q4RqT4owzwjthZDb0iVGnUog17JimpXbHAqGmGw21YEXxcz74b53JTzKSmiN/7Hw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=danny.cz; spf=pass (client-ip=37.157.195.192; helo=redcrew.org; envelope-from=dan@danny.cz; receiver=lists.ozlabs.org) smtp.mailfrom=danny.cz
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=danny.cz
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=danny.cz (client-ip=37.157.195.192; helo=redcrew.org; envelope-from=dan@danny.cz; receiver=lists.ozlabs.org)
Received: from redcrew.org (redcrew.org [37.157.195.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYYPH6GHbz2xlM
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Mar 2026 20:50:26 +1100 (AEDT)
Received: from server.danny.cz (85-71-161-19.rce.o2.cz [85.71.161.19])
	by redcrew.org (Postfix) with ESMTP id D3ED5D4;
	Sun, 15 Mar 2026 10:50:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 redcrew.org D3ED5D4
Received: from talos.danny.cz (talos [IPv6:2001:470:5c11:160:47df:83f6:718e:218])
	by server.danny.cz (Postfix) with SMTP id 27BC917A006;
	Sun, 15 Mar 2026 10:50:22 +0100 (CET)
Date: Sun, 15 Mar 2026 10:50:21 +0100
From: Dan =?UTF-8?B?SG9yw6Fr?= <dan@danny.cz>
To: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gaurav Batra <gbatra@linux.ibm.com>,
 amd-gfx@lists.freedesktop.org, Donet Tom <donettom@linux.ibm.com>
Subject: Re: amdgpu driver fails to initialize on ppc64le in 7.0-rc1 and
 newer
Message-Id: <20260315105021.667e52d4a99b154ef1e6aa34@danny.cz>
In-Reply-To: <1phlu3bs.ritesh.list@gmail.com>
References: <20260313142351.609bc4c3efe1184f64ca5f44@danny.cz>
	<1phlu3bs.ritesh.list@gmail.com>
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

On Sun, 15 Mar 2026 09:55:11 +0530
Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:

> Dan Horák <dan@danny.cz> writes:
> 
> +cc Gaurav,
> 
> > Hi,
> >
> > starting with 7.0-rc1 (meaning 6.19 is OK) the amdgpu driver fails to
> > initialize on my Linux/ppc64le Power9 based system (with Radeon Pro WX4100)
> > with the following in the log
> >
> > ...
> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: GART: 256M 0x000000FF00000000 - 0x000000FF0FFFFFFF
> 
>                   ^^^^
> So looks like this is a PowerNV (Power9) machine.

correct :-)
 
> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] Detected VRAM RAM=4096M, BAR=4096M
> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] RAM width 128bits GDDR5
> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: iommu: 64-bit OK but direct DMA is limited by 0
> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: dma_iommu_get_required_mask: returning bypass mask 0xfffffffffffffff
> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  4096M of VRAM memory ready
> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  32570M of GTT memory ready.
> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) failed to allocate kernel bo
> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] Debug VRAM access will use slowpath MM access
> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] GART: num cpu pages 4096, num gpu pages 65536
> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F4FFF80000).
> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) failed to allocate kernel bo
> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) create WB bo failed
> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: amdgpu_device_wb_init failed -12
> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: amdgpu_device_ip_init failed
> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: Fatal error during GPU init
> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: finishing device.
> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: probe with driver amdgpu failed with error -12
> > bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  ttm finalized
> > ...
> >
> > After some hints from Alex and bisecting and other investigation I have
> > found that https://github.com/torvalds/linux/commit/1471c517cf7dae1a6342fb821d8ed501af956dd0
> > is the culprit and reverting it makes amdgpu load (and work) again.
> 
> Thanks for confirming this. Yes, this was recently added [1]
> 
> [1]: https://lore.kernel.org/linuxppc-dev/20251107161105.85999-1-gbatra@linux.ibm.com/ 
> 
> 
> @Gaurav,
> 
> I am not too familiar with the area, however looking at the logs shared
> by Dan, it looks like we might be always going for dma direct allocation
> path and maybe the device doesn't support this address limit. 
> 
>  bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: iommu: 64-bit OK but direct DMA is limited by 0
>  bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: dma_iommu_get_required_mask: returning bypass mask 0xfffffffffffffff

a complete kernel log is at
https://gitlab.freedesktop.org/-/project/4522/uploads/c4935bca6f37bbd06bb4045c07d00b5b/kernel.log

Please let me know if you need more info.


		Dan

 
> Looking at the code..
> 
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index fe7472f13b10..d5743b3c3ab3 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -654,7 +654,7 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
>  	/* let the implementation decide on the zone to allocate from: */
>  	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
>  
> -	if (dma_alloc_direct(dev, ops)) {
> +	if (dma_alloc_direct(dev, ops) || arch_dma_alloc_direct(dev)) {
>  		cpu_addr = dma_direct_alloc(dev, size, dma_handle, flag, attrs);
>  	} else if (use_dma_iommu(dev)) {
>  		cpu_addr = iommu_dma_alloc(dev, size, dma_handle, flag, attrs);
> 
> Now, do we need arch_dma_alloc_direct() here? It always returns true if
> dev->dma_ops_bypass is set to true, w/o checking for checks that
> dma_go_direct() has.
> 
> whereas...
> 
> /*
>  * Check if the devices uses a direct mapping for streaming DMA operations.
>  * This allows IOMMU drivers to set a bypass mode if the DMA mask is large
>  * enough.
>  */
> static inline bool
> dma_alloc_direct(struct device *dev, const struct dma_map_ops *ops)
> ..dma_go_direct(dev, dev->coherent_dma_mask, ops);
> ....  ...
>       #ifdef CONFIG_DMA_OPS_BYPASS
>           if (dev->dma_ops_bypass)
>               return min_not_zero(mask, dev->bus_dma_limit) >=
>                       dma_direct_get_required_mask(dev);
>       #endif
> 
> dma_alloc_direct() already checks for dma_ops_bypass and also if
> dev->coherent_dma_mask >= dma_direct_get_required_mask(). So...
> 
> .... Do we really need the machinary of arch_dma_{alloc|free}_direct()?
> Isn't dma_alloc_direct() checks sufficient?
> 
> Thoughts?
> 
> -ritesh
> 
> 
> >
> > for the record, I have originally opened https://gitlab.freedesktop.org/drm/amd/-/issues/5039
> >
> >
> > 	With regards,
> >
> > 		Dan

