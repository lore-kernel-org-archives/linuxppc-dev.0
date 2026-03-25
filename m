Return-Path: <linuxppc-dev+bounces-18778-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59341106B535
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2026 13:17:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgnWH36Pcz2xmX;
	Thu, 26 Mar 2026 00:17:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774444635;
	cv=none; b=HgGUMVhWOVWYSpq6DOs88aTdYmNjhAVnB+dbjf3CX78ZN4Agcb7vd67zjhZ8C4F+/GOJHPPMt9mUn6rnBbCJARka+ZuJPq9UfLYjQTmg4EwW2r8IqRaLb9l/JI2sLR4e8nqlNhD6jz7pJhAFyU6ZBDkoTsfsgEmgZ6MEau2n+8kFYvuUpQr3enzkr9pgyp66RSIWyc13pxaIeHaUsJbIweeqFjp9iODCrHq7sLlVQJHy/B2KMaPyN6IzW+DM1cjxYTOFRF//lTHHYYMawNm8EYF6flnRbBWcl8HZnn9MECkpJr1fLydxj6roWDJUZFvvUPt/GlcBt9gnhn0CGuMFhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774444635; c=relaxed/relaxed;
	bh=ydE77GFQVM2//1TEIJxuqD6vop6Nou0E99kEw1kEoLs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=dN2Fi3ZzYLvKMftrXCpgivPb6FppsTk2XpV0yu6NLZ+PU54de2C6CBIg0Ktg+jaKmLy/YQAOst+HKVF69V5DGBvO49iKn/h24S0JeXOja/n3sk9JJfLukfYlGx4nO0+vbPwoyOhXkrHdCuw6PdebBrU5idvS80lzI36JBCGNtz5oJUtrbBAzUuxXjcr0GWk6qgdsEuzbspW3d5RL/RuhgjDsb8LzTvbuAdT5Oi8RICkUVfAOzZfyQ10VyeBKurBKxrx57liZwO2dXIFCdHLy9G1teyfSXUDflooEutjlfYYjXXxnH8aQsnGvmWr2v7LWH0QgklDfZPpYmvcvxhfQNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CRYtCQ76; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CRYtCQ76;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgnWF6gFbz2xcB
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 00:17:13 +1100 (AEDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2ad4d639db3so23322295ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 06:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774444630; x=1775049430; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ydE77GFQVM2//1TEIJxuqD6vop6Nou0E99kEw1kEoLs=;
        b=CRYtCQ76+rE2xfmwMnAZNk3UeAN02ywsESKjoFW6ujXtCyxaqi1O8I1M6seT/zjH8p
         6X8/VLt0DyMxxPrhCs+phx7EGbfxf1slV9oxgDdEsZcTe4G9qlP7xHeuVzZXU38O7EjE
         kn2f3l6dXZu4XqL6UHz6/R6pw07kPP0fWooIS35KJnT7vZ+uC30q4qRIfTMw3PT8gsMr
         jNHg1ig3DhKTBZ4cIHW15Su57WxOsyrEpfhjsZsJVoTlsztJ+bQpeVvhs4iDAxysL7mi
         q7e0NyoIa53vgxeSaK2Uev5gvADOPdVw1n6G+yS3vv3bo35psK9yNkHkbaMVkvK+tBAv
         SxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774444630; x=1775049430;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ydE77GFQVM2//1TEIJxuqD6vop6Nou0E99kEw1kEoLs=;
        b=br/IfB1ukdWqyzXdTlIDJaZ/GhxbmqtTKwCW1Kj1aPub6oCbPp3knVKM3KWRx3o4J0
         v/mB/FCW3PPDctGArAERrKsi9yM7CRaQrpQHIs0XaJV5GhB7gS7ZMVWCmEcOKnAyceY7
         qHkwz8jfDzT4J7joRzlnYat6vfSCJLjm36YpZjpiPin7nOOtj4ZWHNa1Z0PYYOLl4vLY
         z/GubEZzDFvnTnLE8rqLNyM+Hs36/oygLjfXFt/M8gKe5XjzXqTM+eyMrAvbVR9rDbyE
         gw4C7QThtqWSmKaSoK9p9zGFkPilozU4sGNX7eC7GXhMo1K7h77xKu5IMSZXnHxLR7a9
         9Faw==
X-Gm-Message-State: AOJu0Yz1rBgQuM7GNKZm8cFjLPGKQr6rREvox62DY2bJ1cHVrJWxWF0e
	pp5i4J/yFdttJZdxma4ejBtcw4RaGPYdmno5jxLO4LeA/K/kErTaqGGP6tcD/RPA
X-Gm-Gg: ATEYQzzT1tfINWwhpTAc2LHcN+UjHlkzIfTOrf3PFVr8tgF68thfTJ3Db9uOPrVRdkP
	y5Rmzbq6c3l7486WeMdAqLamw8dfZXi0Yd9IGbStQ06z76xkigGIH/7JE4q1xYMbNMDBPksHhlR
	Fp1lmkA4Kbo6JK/QuJcSKc1TIuNWB79GjSO9BOJv1DeWqoQ0MhzCK4FUDmcPZlK12HGJvhWW+aL
	w+EwiFw3tD37ahofZytHmVUAbTSMgCSWHXJ2l7XYd8s35YMnOdg9zy8NNHuDROXVaOKff0L0Pza
	vERRrG02huVaeLo9nIrtkYQhzbOhjEEgFfNLnr3LaMUo1k75uA7+eeu3/SgWq/dbwaQO16ivXnj
	LDW4jYhTWULB7zycRmtTWDzC8QDVBEqumO8bMN8gbbbtL0hC58rnQEIX71PZ8SbvxE2DzRuGsmO
	DaGjCo3ZhyufGq5NQtj6+YAw==
X-Received: by 2002:a17:903:3c2b:b0:2ae:c816:ec5d with SMTP id d9443c01a7336-2b0b0a8d27cmr38475585ad.32.1774444629628;
        Wed, 25 Mar 2026 06:17:09 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083655b45sm250598065ad.42.2026.03.25.06.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 06:17:08 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gaurav Batra <gbatra@linux.ibm.com>, Dan =?utf-8?Q?Hor=C3=A1k?=
 <dan@danny.cz>
Cc: linuxppc-dev@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, Donet Tom <donettom@linux.ibm.com>
Subject: Re: amdgpu driver fails to initialize on ppc64le in 7.0-rc1 and newer
In-Reply-To: <da93575e-92ad-4a7b-83df-1cb956bd2bc2@linux.ibm.com>
Date: Wed, 25 Mar 2026 17:42:01 +0530
Message-ID: <5x6knm5q.ritesh.list@gmail.com>
References: <20260313142351.609bc4c3efe1184f64ca5f44@danny.cz> <1phlu3bs.ritesh.list@gmail.com> <20260315105021.667e52d4a99b154ef1e6aa34@danny.cz> <da93575e-92ad-4a7b-83df-1cb956bd2bc2@linux.ibm.com>
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

Hi Gaurav,

> Hello Ritesh/Dan,
>
>
> Here is the motivation for my patch and thoughts on the issue.
>
>
> Before my patch, there were 2 scenarios to consider where, even when the 
> memory
> was pre-mapped for DMA, coherent allocations were getting mapped from 2GB
> default DMA Window. In case of pre-mapped memory, the allocations should 
> not be
> directed towards 2GB default DMA window.
>
> 1. AMD GPU which has device DMA mask > 32 bits but less then 64 bits. In 
> this
> case the PHB is put into Limited Addressability mode.
>
>     This scenario doesn't have vPMEM
>
> 2. Device that supports 64-bit DMA mask. The LPAR has vPMEM assigned.
>
>
> In both the above scenarios, IOMMU has pre-mapped RAM from DDW (64-bit 
> PPC DMA
> window).
>
>
> Lets consider code paths for both the case, before my patch
>
> 1. AMD GPU
>
> dev->dma_ops_bypass = true
>
> dev->bus_dma_limit = 0
>
> - Here the AMD controller shows 3 functions on the PHB.
>
> - After the first function is probed, it sees that the memory is pre-mapped
>    and doesn't direct DMA allocations towards 2GB default window.
>    So, dma_go_direct() worked as expected.
>
> - AMD GPU driver, adds device memory to system pages. The stack is as below
>
> add_pages+0x118/0x130 (unreliable)
> pagemap_range+0x404/0x5e0
> memremap_pages+0x15c/0x3d0
> devm_memremap_pages+0x38/0xa0
> kgd2kfd_init_zone_device+0x110/0x210 [amdgpu]
> amdgpu_device_ip_init+0x648/0x6d8 [amdgpu]
> amdgpu_device_init+0xb10/0x10c0 [amdgpu]
> amdgpu_driver_load_kms+0x2c/0xb0 [amdgpu]
> amdgpu_pci_probe+0x2e4/0x790 [amdgpu]
>
> - This changed max_pfn to some high value beyond max RAM.
>
> - Subsequently, for each other functions on the PHB, the call to
>    dma_go_direct() will return false which will then direct DMA 
> allocations towards
>    2GB Default DMA window even if the memory is pre-mapped.
>
>     dev->dma_ops_bypass is true, dma_direct_get_required_mask() resulted 
> in large
>     value for the mask (due to changed max_pfn) which is beyond AMD GPU 
> device DMA mask
>
>
> 2. Device supports 64-bit DMA mask. The LPAR has vPMEM assigned
>
> dev->dma_ops_bypass = false
> dev->bus_dma_limit = has some value depending on size of RAM (eg.  
> 0x0800001000000000)
>
> - Here the call to dma_go_direct() returns false since 
> dev->dma_ops_bypass = false.
>
>
>
> I crafted the solution to cover both the case. I tested today on an LPAR
> with 7.0-rc4 and it works with AMDGPU.
>
> With my patch, allocations will go towards direct only when 
> dev->dma_ops_bypass = true,
> which will be the case for "pre-mapped" RAM.
>
> Ritesh mentioned that this is PowerNV. I need to revisit this patch and 
> see why it is failing on PowerNV.
> ...
> From the logs, I do see some issue. The log indicates
> dev->bus_dma_limit is set to 0. This is incorrect. For pre-mapped RAM, 
> with my
> patch, bus_dma_limit should always be set to some value.
>

In that case, do you think adding an extra check for dev->bus_dma_limit
would help? I am sure you already would have thought of this and
probably are still working to find the correct fix?

+bool arch_dma_alloc_direct(struct device *dev)
+{
+	if (dev->dma_ops_bypass && dev->bus_dma_limit)
+		return true;
+
+	return false;
+}
+
+bool arch_dma_free_direct(struct device *dev, dma_addr_t dma_handle)
+{
+	if (!dev->dma_ops_bypass || !dev->bus_dma_limit)
+		return false;
+
+	return is_direct_handle(dev, dma_handle);
+}

<snip from Timothy>

> introduced a serious regression into the kernel for a large number of
> active users of the PowerNV platform, I would kindly ask that it be
> reverted until it can be reworked not to break PowerNV support.  Bear
> in mind there are other devices that are 40 bit DMA limited, and they
> are also likely to break on Linux 7.0.

Looks like more people are facing an issue with this now.

-ritesh

