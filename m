Return-Path: <linuxppc-dev+bounces-18199-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8801D58B0B
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Mar 2026 05:03:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYR2G5qhWz2xlM;
	Sun, 15 Mar 2026 16:03:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773551014;
	cv=none; b=P8rt9Vyf2HZJUPdZcsqKMokE0JR0u37aCg/u7/5O5/V7FNigcrnml0yU8aj6IUEBqkk6yZzHd18g3jWo9Qu4lCMKQ00d5MSIXQvtvBD1yLUn3AJph61VnbDKENKqR65A7Oc/03PdzdggHYPN9GB4Fd2UiqDK/vAOGOIXIya1N+IBled1ebFe++2ENmmgT0vM5zjKU9QlT2tb7xrU2oH/el2tnQtdn4mWs1yH4YB2+Q0o4CJoWQ0OTg0jxRxdqWaVbllPbAe/tEr+DsVzuxKItDTcmI5vzJpAB12oY8v+Wib5eN894GVPh2EVap4hbnXoWG5Wlkz6tgyClkohSbU5pw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773551014; c=relaxed/relaxed;
	bh=k/FxsTE4U3c+f1UME/XsJwTGOpHZKh8kTk9la6YsYPk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=kUI+SaTxHqW6ks+4Q2n4lGG8WTjTgw/8IYeOj8klfcoB347RGr04lLA/fCcXWKfdcm1AV4Q2tyTLQ3UBnc39V+/mb96VKv04Q+FS/t9M2XuvsE35/WtMY9PdU+fxeP6A1ki9GSg1cEPu4xsB3AKpZ2d2/9eSdV9CbxRdXWi0r495/C5nUE7zj4HakcvRrYO5NINQS7KJPPM5uRTvo7JMyzr5yw1Pe88R640KQT91O2jyKNe0w8ke8ukt4kJ1cAGuHKg1pWJTLOMOKduoIVC5FIMewvkDMW3yPxsLmNZHUIDKkhxcMSEvXU+mupmREDf3z6XJj9IznKHcZWhuqFcLug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Q1Mcv3Zq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Q1Mcv3Zq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYR2D2NF7z2xVT
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Mar 2026 16:03:32 +1100 (AEDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2aea41d4fbcso14275205ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2026 22:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773551010; x=1774155810; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/FxsTE4U3c+f1UME/XsJwTGOpHZKh8kTk9la6YsYPk=;
        b=Q1Mcv3ZqfGPRLFtnLMMH/jmCxtLpxYte0Nq0i+Lricctp3wNx8rK0tE4GxC7MNoZmq
         krmo1EHYIoCpX3sn9cHYKgGc4VWUqQ/+my1bD+77g+A7zEnZ/Q2Ahgvu+gvDf5qebd6W
         n4wVxB5jwj9U/I7B10C65MR3N91WngxuSGu6eEaVsIaQqwpI+TgwCtk8HYjUaCmcZJ3A
         11B3Z3wiiXFnduuNOL/eNGMXHZxEHRYGl125fo6QlAcoKHUZXxHswZSpjRVZ+R2uGhMW
         OXxlm40PIKukehvvq/e5czWg38XAt4aQ24d4l/5TGdibH/wOh1SwzM44gXh8fISMFSKY
         R+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773551010; x=1774155810;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k/FxsTE4U3c+f1UME/XsJwTGOpHZKh8kTk9la6YsYPk=;
        b=hcrIQHXFAfA6bN03d1VIErMUn9qBlODzTdLjFh10yE8fisq+ihQhzZcok6n4g98lJ0
         F0OW9qg8KImlCE4C6GYWeLyjh5/eO9Bro4/aYzkqgMuOgKTvRKDkpRiqtZLvtk3PV7HQ
         rzMXdh6QiJeARw8Wo4EHlXprbR9IiAYX591gnnyX21H2AyAOFriYnM/3XJeVF3RaLRgi
         USJNU1x0jw/8ym6CLr6UZjV/+okHFxVuw6uMBtyTev9q6jYM3R4FbPsBesq2KFczQXEB
         b2Lm1HeGUH/lGTDnCIttUKcSi/Lz6CXEJ4X9D3+vPazr7BK8VpqR+hMeZiDIvGpqE4/T
         FCEw==
X-Forwarded-Encrypted: i=1; AJvYcCVxjr23l8PNwaTMG8mDR5f6BWXt9cb9EfioRYIeGeQhpEr9+WSEf5bZogr6YTQlspEsVkt94TkCxE6q1jc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzssoq3YFexNLu3nDOyyOBBEEOpN4Kutpy4gcl3i75XOGvyvEeF
	OguZYMt/80HT0wJ07hkHHv81H3iut4navEbzWcms8q6UoEtGnFvOrdBs
X-Gm-Gg: ATEYQzzX/dz8KonoVkgMrWjCAggzGGY6N0CfJRIIT4gZTEw91DKJeJ4l1dOl8YQJJSB
	luW9hhIdxGXL/qsYyrJtAoTp6TRSwCAumQWMo14VAEX359I8Y28R45EkN8OAM0NuIB4/yKfYmPE
	ubg4ek9++MV348ncDit5Tpnv6vlRcWlVxUxYoIZd2+hEkbzs06f5kBtSUOCZxn2kMaZT1SGq8Jx
	Cd63ktuqLI1WJgW6+fpNtNhVSEmNZ71OHjo2cjfgjWE/ganfTSvQfK1fa8AF2BbuvBs6z6Qj50c
	V76AtVzoO18gLv6LJBwvT9dT7gmlf0VCpe6jw34MxNSRDSTKlg+pmlMMUAfhwj7AD2z09Mnpova
	Mho+3vZUPiYa99RtSy3XTjcqtI7G5VseihtPSfNn7H4obCzxQVLSw1AMmawR0Vr1AiSMuDGF8bD
	0M9SuhKVCmfCaeyQ1uHp77IQ==
X-Received: by 2002:a17:902:f683:b0:2ae:467f:11d8 with SMTP id d9443c01a7336-2aecaa52b09mr93743015ad.30.1773551009493;
        Sat, 14 Mar 2026 22:03:29 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece7ee4a1sm87297215ad.54.2026.03.14.22.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 22:03:28 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Dan =?utf-8?Q?Hor=C3=A1k?= <dan@danny.cz>,
 linuxppc-dev@lists.ozlabs.org, Gaurav Batra <gbatra@linux.ibm.com>
Cc: amd-gfx@lists.freedesktop.org, Donet Tom <donettom@linux.ibm.com>
Subject: Re: amdgpu driver fails to initialize on ppc64le in 7.0-rc1 and newer
In-Reply-To: <20260313142351.609bc4c3efe1184f64ca5f44@danny.cz>
Date: Sun, 15 Mar 2026 09:55:11 +0530
Message-ID: <1phlu3bs.ritesh.list@gmail.com>
References: <20260313142351.609bc4c3efe1184f64ca5f44@danny.cz>
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
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Dan Horák <dan@danny.cz> writes:

+cc Gaurav,

> Hi,
>
> starting with 7.0-rc1 (meaning 6.19 is OK) the amdgpu driver fails to
> initialize on my Linux/ppc64le Power9 based system (with Radeon Pro WX4100)
> with the following in the log
>
> ...
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: GART: 256M 0x000000FF00000000 - 0x000000FF0FFFFFFF

                  ^^^^
So looks like this is a PowerNV (Power9) machine.

> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] Detected VRAM RAM=4096M, BAR=4096M
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] RAM width 128bits GDDR5
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: iommu: 64-bit OK but direct DMA is limited by 0
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: dma_iommu_get_required_mask: returning bypass mask 0xfffffffffffffff
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  4096M of VRAM memory ready
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  32570M of GTT memory ready.
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) failed to allocate kernel bo
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] Debug VRAM access will use slowpath MM access
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] GART: num cpu pages 4096, num gpu pages 65536
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F4FFF80000).
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) failed to allocate kernel bo
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) create WB bo failed
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: amdgpu_device_wb_init failed -12
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: amdgpu_device_ip_init failed
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: Fatal error during GPU init
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: finishing device.
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: probe with driver amdgpu failed with error -12
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  ttm finalized
> ...
>
> After some hints from Alex and bisecting and other investigation I have
> found that https://github.com/torvalds/linux/commit/1471c517cf7dae1a6342fb821d8ed501af956dd0
> is the culprit and reverting it makes amdgpu load (and work) again.

Thanks for confirming this. Yes, this was recently added [1]

[1]: https://lore.kernel.org/linuxppc-dev/20251107161105.85999-1-gbatra@linux.ibm.com/ 


@Gaurav,

I am not too familiar with the area, however looking at the logs shared
by Dan, it looks like we might be always going for dma direct allocation
path and maybe the device doesn't support this address limit. 

 bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: iommu: 64-bit OK but direct DMA is limited by 0
 bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: dma_iommu_get_required_mask: returning bypass mask 0xfffffffffffffff

Looking at the code..

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index fe7472f13b10..d5743b3c3ab3 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -654,7 +654,7 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	/* let the implementation decide on the zone to allocate from: */
 	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
 
-	if (dma_alloc_direct(dev, ops)) {
+	if (dma_alloc_direct(dev, ops) || arch_dma_alloc_direct(dev)) {
 		cpu_addr = dma_direct_alloc(dev, size, dma_handle, flag, attrs);
 	} else if (use_dma_iommu(dev)) {
 		cpu_addr = iommu_dma_alloc(dev, size, dma_handle, flag, attrs);

Now, do we need arch_dma_alloc_direct() here? It always returns true if
dev->dma_ops_bypass is set to true, w/o checking for checks that
dma_go_direct() has.

whereas...

/*
 * Check if the devices uses a direct mapping for streaming DMA operations.
 * This allows IOMMU drivers to set a bypass mode if the DMA mask is large
 * enough.
 */
static inline bool
dma_alloc_direct(struct device *dev, const struct dma_map_ops *ops)
..dma_go_direct(dev, dev->coherent_dma_mask, ops);
....  ...
      #ifdef CONFIG_DMA_OPS_BYPASS
          if (dev->dma_ops_bypass)
              return min_not_zero(mask, dev->bus_dma_limit) >=
                      dma_direct_get_required_mask(dev);
      #endif

dma_alloc_direct() already checks for dma_ops_bypass and also if
dev->coherent_dma_mask >= dma_direct_get_required_mask(). So...

.... Do we really need the machinary of arch_dma_{alloc|free}_direct()?
Isn't dma_alloc_direct() checks sufficient?

Thoughts?

-ritesh


>
> for the record, I have originally opened https://gitlab.freedesktop.org/drm/amd/-/issues/5039
>
>
> 	With regards,
>
> 		Dan

