Return-Path: <linuxppc-dev+bounces-25129-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A1DBC55162
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 17:15:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9wnc1tG1z2yMy;
	Fri, 31 Jul 2026 03:15:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785431732;
	cv=none; b=jH84oo7gm3LFptQuO5QLT5jUazDuw32IOLPDtySqUe4+hFzwwteghzgXMnHT7MxovnLGR9vwdxhgBGMBeJXMlcfMNAnZJiRufJVejRgG0ACqOkyWsYABM4szDiiF2RGyooN9NBomKAn5i1aER2kCdzSV0VKY8XwTLGC+3HoVacQwcOldhpSgNGIoN4MREF181Z+uYPVpR27pzAKBnyNtxgumyCxf2/tU1CgAOPcVE8Sdi/2lJcTh4HmU64uB81oNbR9++IdM8UcgxZcNTwolXOllxUcrmyGvo3vxv3RTCfv+0I3ln658U/9GnSex7kTgbAo8JsqkuF7X6avnrIlIkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785431732; c=relaxed/relaxed;
	bh=gRGnK+iUnrbz5PmsriDb1UHKhrv1oytdd6qDpXUq5Wo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=gToiCa0vBIYFjYAAL2WCIINOmia8ev4ZHLB82SI0bo3ygkn/XLULyzbpEAOPWK8jo2+gX6utSeHeH+WgIh33OgXtsbUwWaKHCXIIXyfpiGgBb7o5lcSEZ4mXezAuxDa+egMZpZ1AQLnYUt2jFcI3scjEV5W5zYgsB+ZnwPq8qD6y9iIIwyVa/zoDyhZac+CdipqZGZzivD4C2C7m7Rsc2M0GDG/Z57ZVgZHechsSIvpK4hDpj3z5Xg7gm6yrkrsHsX+W/Y8WXeOq1fZS76ZGcRyfih1+Lpu2VuDAU7iA9H24YLt4v238qjG38Sd2KvMyh8Yd+INosB2dEh7VuE1XGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e/MD1cCc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e/MD1cCc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9wnb4G2nz2y8c
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 03:15:31 +1000 (AEST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-caf45fc5202so15873a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 10:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785431729; x=1786036529; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gRGnK+iUnrbz5PmsriDb1UHKhrv1oytdd6qDpXUq5Wo=;
        b=e/MD1cCcdLDTHpyS28v0NpirDEUCIauxE85PLSXN7ZgbEYOEQRYs76s7T9p2MkcKh+
         +UeNszu+ajQY1klkrgdovZzRCksN76Ts8R57vPdkwfflW66sufXjAcFyUXQxJrDIwJK3
         mnlSR/W+BH7oZFNyGK9Tn40YCCFA6SmD5MAb974xxB+q7QHllCDWyNts0fK6qh2Wld5k
         3HJwuzLx7kqbJ+wjvQsxfnQZ54GTk/TMSke4T8opEOXd4Jx69HRA1watZaHYkzjtOIca
         o8mf4OYsG0y0W/gqWn14hVUS28fUYK3AzctxbTUddWZ7E1+6+/c5cn5Mtb1uRvTK7xw9
         SfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785431729; x=1786036529;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gRGnK+iUnrbz5PmsriDb1UHKhrv1oytdd6qDpXUq5Wo=;
        b=JjHgwifPOfzscd4lDPXLTL58wi9hUOXGob0k5Qbzv6vNGjC/nDbzuNSCckwFYzPZhu
         BjwPC9FkTdqbXU/Cv1KutBCHrauGBlS5F9pYAW/2vp23bokt/vy40/2rq7Xf3qgRynbV
         X8K8mFspstNw8VzmsmmTjuHpR2I+FNgLXaDhiYUGwNDzz85lNQK//RstJ4n92BKfrL/P
         34eSuCEOF3iyAOuu3GP+3UtKVZPeqzlas4g1hDTB8tBb413UnVFQNGqO70rlxT3HEtjA
         wjVScFtgYvT1NjPbib1ky64ZtoOpAL7wDdDIEsNgcpUdiYO0ohdNdk+lzzK6QkgPC8m+
         81TQ==
X-Forwarded-Encrypted: i=1; AHgh+RqIkQZsklkPkwUlrcOf77WgrwlfUMUNpCjIHsHBe4DJ5aKF8+aoGApc/oOPueJI9mgtihqUgnjj5mGpAhk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyGwICOQn4+D+HuU6Sg4pkeROSjwtvQ43/AnQbsskUmzZYLRDP1
	S+BIT+Bxg7lTqAEj9lWW1f0RItFxArLLdD0oxfh8BgqDRH2XVJVVEvnA
X-Gm-Gg: AR+sD10FufMbh9kTBBKSS92kIln8YFRBm3bOLlSBNWNLGayT69saLOaSMeTpDIMfKrL
	jXof4cO9eWz8OvRl7e+HGou9duzqXux0i5AfVCB5RBA9KikGIxTvR82hFsvNw4JIYU5KDKjQYj7
	KCTDlarTVb2Bjxl1Y8WxVQayYvslbptINcq5ZqETYQmKUkANJp1RH8S1Mu10k78oD9YnY6Qp8Hi
	vSvLO+yGcfvh/5Kd2lTkU7PgECV6Xvfj/bUbUYQh5n1+TmfgH9sXPK3rDsFsW0uuEtIWxZLGTvw
	WxBQ6MP5myVGu/Gns0bsOUYeHk908eSaqrE46f6xQ97aJ31ZERhMSO5erXCTA4PY3ceLpSyUo9j
	OHSoasTArjhmW+JFCsWL+UrTcEUvh1kx0Ny28hSvluJ4W2WvMmGipliwawaRD/ezx1Hd8rSlvGx
	o+UHaiVIO0BP0ueylWNRI5nRuVpKA3M26WMkVjqoumegdPS5UK04MLbGXh7VU=
X-Received: by 2002:a05:6a20:93a1:b0:3b4:870e:6f44 with SMTP id adf61e73a8af0-3c9007f3948mr3486211637.35.1785431729039;
        Thu, 30 Jul 2026 10:15:29 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b670cfsm21514270eec.8.2026.07.30.10.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 10:15:27 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gaurav Batra <gbatra@linux.ibm.com>, maddy@linux.ibm.com
Cc: npiggin@gmail.com, ltc-dev@lists.linux.ibm.com, linuxppc-dev@lists.ozlabs.org, sbhat@linux.ibm.com, harshpb@linux.ibm.com, vaibhav@linux.ibm.com, Gaurav Batra <gbatra@linux.ibm.com>
Subject: Re: [PATCH] powerpc/pseries/iommu: switch to Default DMA window during kdump
In-Reply-To: <20260720203034.95244-1-gbatra@linux.ibm.com>
Date: Thu, 30 Jul 2026 20:39:03 +0530
Message-ID: <8q6sms4w.ritesh.list@gmail.com>
References: <20260720203034.95244-1-gbatra@linux.ibm.com>
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


Hi Gaurav,

Thanks for the patch. Few observation, inputs and queries -

Gaurav Batra <gbatra@linux.ibm.com> writes:

> In PowerPC (pseries) a non-virtualized adapter will have 2 DMA windows -
> 2GB default and a larger Dynamic DMA Window (DDW). DDW is large enough to
> map total RAM to a device.
>
> During normal functioning of OS, since RAM is pre-mapped, 2GB default
> window is not used. The only scenario it might get used is when buffers in
> pmemory are mapped to the device for DMA.
>
> As of today, during kdump, during early device discovery, pci_dma_find()
> finds that the device has 2 DMA windows. It selects to use DDW. This is a
> kdump path and DMA window is needed for IO to the device.
>
> Since, in the previous life of the LPAR (before panic), RAM was pre-mapped
> via DDW, the DDW is completely full. So, in the iommu table initialization
> code, iommu_table_clear() frees KDUMP_MIN_TCE_ENTRIES (2K) number of
> TCEs.
>
> But, it seems these are not enough for NVMe over Fibre-channel. When kdump
> is trying to save vmcore on storage device, which is NVMe-FC, the
> TCE usage is much more than 2K number of entries. The driver is mapping
> a lot more buffers for DMA. After all the TCEs are consumed, iommu returns
> iommu_alloc failures and the driver is not able to further map buffers for
> IO. kdump fails to copy vmcore to NVMe-FC storage device.

Some context I collected while reviewing this patch - 

1. kdump environment generally prefers configurations so that we could
   avoid issues like memory allocation failures. I guess, we don't want to
   be running the system with max configurations - that is also the reason
   why distros keep nr_cpus to a lower value during kdump case.
   For e.g. see this [1]:
        scsi: lpfc: Limit xri count for kdump environment

        scsi-mq operation inherently performs pre-allocation of resources for
        blk-mq request queues. Even though the kdump environment reduces the
        configuration to a single CPU, thus 1 hardware queue, which helps
        significantly, the resources are still rather large due to the per request
        allocations.
        <...>
   [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=31f06d2e73726160645f8d9976a0b3f42e136da7

2. While looking more into this call stack path I also saw -
            /*
            * If a crashdump is active, then we are potentially in a very
        -	 * memory constrained environment. Limit us to 1 queue and
        -	 * 64 tags to prevent using too much memory.
        +	 * memory constrained environment. Limit us to  64 tags to prevent
        +	 * using too much memory.
            */
        -	if (is_kdump_kernel()) {
        -		set->nr_hw_queues = 1;
        -		set->nr_maps = 1;
        +	if (is_kdump_kernel())
                set->queue_depth = min(64U, set->queue_depth);
        -	}
        +
        @@ -4515,7 +4513,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
                                GFP_KERNEL, set->numa_node);
                if (!set->map[i].mq_map)
                    goto out_free_mq_map;
        -		set->map[i].nr_queues = is_kdump_kernel() ? 1 : set->nr_hw_queues;
        +		set->map[i].nr_queues = set->nr_hw_queues;
            }

            blk_mq_update_queue_map(set); 

   So looks like we already reduce blk-mq queue_depth to 64 in
   blk_mq_alloc_tag_set(), no matter what the queue_depth is passed to
   us by the driver.

3. Also with above patch from v6.9 onwards, we made nr_queues as
   set->nr_hw_queues, whereas earlier it was clamped to 1. Because the
   code assumes that in kdump kernel we boot with nr_cpus=1..
        blk-mq: don't change nr_hw_queues and nr_maps for kdump kernel

        For most of ARCHs, 'nr_cpus=1' is passed for kdump kernel, so
        nr_hw_queues for each mapping is supposed to be 1 already.

        More importantly, this way may cause trouble for driver, because blk-mq and
        driver see different queue mapping since driver should setup hardware
        queue setting before calling into allocating blk-mq tagset.

        So not overriding nr_hw_queues and nr_maps for kdump kernel.

   [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ec30b461f3d067bd322a6c3a6c5105746ed9bf14


So looking at above, I had few questions -
1. In your kdump kernel how many nr_cpus you are booting up with?
   Recently what I heard rhel/sles might be using nr_cpus=16/32. @Sourabh?
   So the calculation in nvme-fc driver then becomes:
     32(nr_cpus) * 64(queue_depth) * 2(cmd+resp) = 4096

  If you are able to reproduce this issue 100% of the time - then can
  you try kdump with nr_cpus=1 and see whether it fixes your iommu alloc
  failure?
2. Also were there more than 1 controller attached? Which can change the
  above calculation then.

Looking at the lpfc and nvme-fc driver - a lot of the calculation are
based on nr_online_cpus. I somehow think if we clamp that value of
nr_online_cpus, we should stop seeing these alloc failures.
Thoughts?

Hopefully, if you can work on some above points further, it will also
explain why are we seeing this failures only now. Is this something that
has caused an issue after RHEL/SLES moved to nr_cpus=16/32?
Or was it after this commit from v6.9?
   ec30b461f3d: ("blk-mq: don't change nr_hw_queues and nr_maps for kdump kernel")

>
> Here are the driver logs and stack
>
> lpfc 0153:70:00.0: iommu_alloc failed,
> tbl 0000000034ebcf5e vaddr 00000000d814df0b npages 1
> lpfc 0153:70:00.0: FCP Op failed - cmdiu dma mapping failed.
> lpfc 0153:70:00.0: iommu_alloc failed,
> tbl 0000000034ebcf5e vaddr 000000009779e4d2 npages 1
> lpfc 0153:70:00.0: FCP Op failed - cmdiu dma mapping failed.
>
> iommu_map_phys+0x1c4/0x1f0 (unreliable)
> dma_iommu_map_phys+0x54/0xa0
> dma_map_phys+0x3f8/0x590
> __nvme_fc_init_request+0x110/0x300 [nvme_fc]
> nvme_fc_init_request+0x60/0xb8 [nvme_fc]
> blk_mq_alloc_map_and_rqs+0x388/0x510
> blk_mq_alloc_tag_set+0x2a4/0x5f0
> nvme_alloc_io_tag_set+0xe0/0x1e0 [nvme_core]
> nvme_fc_connect_ctrl_work+0x85c/0xdac [nvme_fc]
> process_one_work+0x1e4/0x5a0
> worker_thread+0x1ec/0x3e0
>
> Increasing the number of free TCE entries in iommu_table_clear() will
> increase the probability of hitting EEH since there could still be some
> active IOs from the previous life of the kernel.
>
> Instead, during kdump, we can switch to default 2GB DMA window. This window
> will mostly be empty. Or, could be slightly used if buffers in pmemory
> were mapped for IO.
>

This will still remain a problem when we have SR-IOV adapter attached
correct? Because in that case we only get 1 window, so we anyway can't
use default window in kdump case. Correct?

-ritesh


