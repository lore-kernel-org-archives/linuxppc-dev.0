Return-Path: <linuxppc-dev+bounces-18785-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8EF109C04A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2026 17:48:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgvX04Wjsz2yY0;
	Thu, 26 Mar 2026 04:48:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774460896;
	cv=none; b=K6uCTvfk9JihL1DKvY+GLzZdZZXPi3v9KsNQb0VnZg4fMQ4ftBa3vB1EE2jH5dnMnq9N2HhK5cTWF+PZgpI3dVSHCUA12xHKZYhrN8gORQktAZqGeJr/Q3ZCC1jZJwdvkTm5B8VtWbDYWgPPJuSBfsHEVTqxtr4v3CKo9Y/8sB0C/+wPWNoCO6sz1livFbOZqcCq2OuXR4W8LwikJxtS7aE+K71FOK/hFItttz54hEwL4PcEu2xHsREMklWTj6j9ex80/YJCVWWa2vBwE1i15U087olwlHG7lwKCbKhVuoZ6R2dgZHWoMSY0UosMKgvIKZDHW+gLWK+uRKOkgwRdLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774460896; c=relaxed/relaxed;
	bh=i+6XwSK5H5qgv00vvEDadVF3Hm2TplkNoSLsjeJsXPE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=HpjPiLup52cVJJbdDhttlE7T1xgG52Q8QWPBxYdyx9ihJCWYJTGZtyAxMPgcT81fph3uVJKXQ+mvPamsQCKI7xZ2xPhtZPSXzbNQnwqMtg4aQBZ+1KokQvbY1y3pSzQykTMe6J/0u3UiU7CVISMYqe9+mI4If3242U7cbYXJUWj+JhsPvgZ2Hcf3n/Zhf5dbIotZuA2+y9ob+UJeb9I7NjJf7jRRuyONqmUzByrKWofho3GLGpA0jUroH4KSIdlP9tX6/BGSFCieUzh0vD8qlamR1cH5dMeUHUo8f7Xwm5CMEvbOSMX4ZNTf8PfzXGTfFR/4qLop4/uvDyw0fX9xXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XoQtOvkm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XoQtOvkm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgvWy6nYJz2yVL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 04:48:13 +1100 (AEDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-823c56765fdso57392b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 10:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774460892; x=1775065692; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i+6XwSK5H5qgv00vvEDadVF3Hm2TplkNoSLsjeJsXPE=;
        b=XoQtOvkm2Z7XualUCsU8RJUD6ERQXwQY3BcG3D9r6D0mKi8v31eOz0ONBGHQJATACI
         Ghf/lAhZ+LPzaSRh1ypKxXYqmoAYJhujuump19HZTuRdJFYJxThKv7ejT1r9Lgr/lRgb
         hIjS/HIo5FXoEN7VnNwwX6DAdtJVt7k3Z2ntJhPTiL83eARYkI+l7+yslLB+ACRwLQtk
         fkDcz3bwwMqL085gqlsNd4ZfcC29YuYpU0uwN/YgXBYWdVaM2IGKo/h/bv3GWwDttuZo
         rHbXThUJQW3ex5sRDNZb+gXXdGLATMsQ4Jupdz7DlSsXE8eUNimlg1r3HTWcqJ89o/m6
         cmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774460892; x=1775065692;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i+6XwSK5H5qgv00vvEDadVF3Hm2TplkNoSLsjeJsXPE=;
        b=iF2VVCqvv1Qh+QhTf3bIXXndoiVaUgS7aRlhhD033op7WBi4SO/So/YIspUDAwvS3S
         Y/rfstzjD9WUg4xsmGka7hhDtAzqhn16Q9k1NLKOVNrM4YqMTuPBzO5/baz/o6i1D8PQ
         qsJWTTJwSNfu2mg6Wan1l0nReA8on0iyjCnxmgVIXr8Xv8j7h2HUB1KFsjxAEOuO1USQ
         j8rvYpAJVKWhpo2d7BZhyOY/6sZCpj/XzzbCuexpEgdNW7L2g4MnEhE4CIFTpYaTc0zK
         BsjvfV+8JgjbNeeqX6o8RwbzPd4agMipabbKJLzViJwbouHKL94a8+fZBM5DJf6W5pPY
         sW7w==
X-Gm-Message-State: AOJu0Yz7UEn/TjXxcH3yCmJCL5zn2N4zJHCpb0c7VbLdW8qhufHW55WQ
	MfwrUyuatevELUV8BTrJsm9ZWn5tSL7/KnUR9q9ZlfwysZSNU57La6S7
X-Gm-Gg: ATEYQzxOTxp9X3Pg7nwwgzE7zSc6mu6eadkWE7bRdii/rinyw6anw1zLBwDld8bNLLp
	LTtD/W6v5QN/cUjqFF4o9tbywCZu85Hl33PaSfdBbBshtLy4mZBGSPM2KNq4SSbuQkruL8Ub1SR
	1F4QoWKPbrt4aTGS5HJzuvUDvjptItFaf6X96R2ZdK47SIMC5YWVv6mEbntPlmsUq+0cY6h3O0b
	uDBfV9iW94ch31K0f+GJwA3jk28qc1QQTjputBN9Fg876yV9XsMkS8ZG7ELHzHrIk0ibNRcMYWP
	BQIteeXYocIgvAYWjgAuMLVDjxc4zA/GD2E39TqTOG9kLsm5jF9JRRC7LtZdGd4EQXLb5gG2oyL
	WbWZA09D0t7qyJjx30CNDdBbDadsfjhGE2zfI5hTnAS8CD1rpgfFc5xmKqhvYaoRbHLIKfkZ4q9
	pfeGJ0hBGJQTvPpHe6USnFGg==
X-Received: by 2002:a05:6a00:c95:b0:81f:17b:c70f with SMTP id d2e1a72fcca58-82c6df62c67mr4543895b3a.29.1774460891508;
        Wed, 25 Mar 2026 10:48:11 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d1e63c7sm388961b3a.2.2026.03.25.10.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 10:48:10 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gaurav Batra <gbatra@linux.ibm.com>, Dan =?utf-8?Q?Hor=C3=A1k?=
 <dan@danny.cz>
Cc: linuxppc-dev@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, Donet Tom <donettom@linux.ibm.com>
Subject: Re: amdgpu driver fails to initialize on ppc64le in 7.0-rc1 and newer
In-Reply-To: <2d5fd6ec-003f-4d24-aa2e-06ba94d6cba4@linux.ibm.com>
Date: Wed, 25 Mar 2026 23:12:16 +0530
Message-ID: <341nolfr.ritesh.list@gmail.com>
References: <20260313142351.609bc4c3efe1184f64ca5f44@danny.cz> <1phlu3bs.ritesh.list@gmail.com> <20260315105021.667e52d4a99b154ef1e6aa34@danny.cz> <da93575e-92ad-4a7b-83df-1cb956bd2bc2@linux.ibm.com> <5x6knm5q.ritesh.list@gmail.com> <2d5fd6ec-003f-4d24-aa2e-06ba94d6cba4@linux.ibm.com>
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

Gaurav Batra <gbatra@linux.ibm.com> writes:

> Hello Ritesh
>
> I think, what you are proposing to add dev->bus_dma_limit in the check 
> might work. In the case of PowerNV, this is not set, but 
> dev->dma_ops_bypass is set. So, for PowerNV, it will fall back to how it 
> was before.
>
> Also, since these both are set in LPAR mode, the current patch as-is 
> will work.
>
> Dan, can you please try Ritesh proposed fix on your PowerNV box? I am 
> not able to lay my hands on a PowerNV box yet.
>

It would be this diff then. Note, I have only compile tested it.

diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index 73e10bd4d56d..8b4de508d2eb 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -67,7 +67,7 @@ bool arch_dma_unmap_sg_direct(struct device *dev, struct scatterlist *sg,
 }
 bool arch_dma_alloc_direct(struct device *dev)
 {
-       if (dev->dma_ops_bypass)
+       if (dev->dma_ops_bypass && dev->bus_dma_limit)
                return true;

        return false;
@@ -75,7 +75,7 @@ bool arch_dma_alloc_direct(struct device *dev)

 bool arch_dma_free_direct(struct device *dev, dma_addr_t dma_handle)
 {
-       if (!dev->dma_ops_bypass)
+       if (!dev->dma_ops_bypass || !dev->bus_dma_limit)
                return false;

        return is_direct_handle(dev, dma_handle);

