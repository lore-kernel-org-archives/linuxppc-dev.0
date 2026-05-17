Return-Path: <linuxppc-dev+bounces-21002-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B22CD37AC
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 May 2026 06:19:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJ9l95X0fz2xfB;
	Sun, 17 May 2026 16:19:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778998789;
	cv=none; b=KAglg5q3nr3ZZ7weSZ0dwf5ciCw0UcyP3YUFopHfUDFukUBUMg2p+WHdvsWBLFDrcegWT4/06AQ5WPcyFXnbYhRWmzK7343zIa6747I+4NcYiVAVNWvllCaJTL3ytYOfb+LE4GpVkv2EG566oOLl4Fs0kwoGmL3cyIJl35tY3Muqg6bsWOMbHOSPjDb+Thuf0654udQf4F68fQLwoULcVM3o2msWcJNXPrWTqK2oFOGEj9HAMnZu8s32bFc9zkgpQ0G51oCqKa0EIV6VQTYcV4MqKF8BgGRDmyrot0tcy6wSdwq0zte5ZaGCo9SV6jMU9rxZb9GS7f+KFehZhOECsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778998789; c=relaxed/relaxed;
	bh=qUI1Kvy8G4UZN8XVWU9+FHDr0P4yKt9TWkL45QXTVdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAN2oFewHE+l4XvI6wd9J9ggny/rsxzFF6Cvbv9Plt86EhI40bSBbTC7q2EtIm/rxu81tMWv+xkqHBHIZHwxBh35c4kgrzRvPF6bSJ3nR2PzYL6r0MH6wcG/6t8LF9FZueE15AZp34atO+9Iq4IMJNKU0lV3KxTEthl795Tnw0Dc0AtP2/W3qMKxso91cAWmP5ucFDW2dYm68f4ST9rP1e4XjCncRRCN5KkAHccfxPgsSKBHEcpRsoXd1IeJEk/Jr5RXxEa7HVlzkFBo0wo27cXrw1NIgM62miMWM79XPHhrwf6r1XLEdsETJUqAjfCEDH9UIpLwQbKx1S8moWMOxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=resnulli.us; dkim=pass (2048-bit key; unprotected) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=xGXZZhZW; dkim-atps=neutral; spf=none (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=jiri@resnulli.us; receiver=lists.ozlabs.org) smtp.mailfrom=resnulli.us
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=xGXZZhZW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=resnulli.us (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=jiri@resnulli.us; receiver=lists.ozlabs.org)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJ9l6111Gz2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 May 2026 16:19:44 +1000 (AEST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-43d7e23defbso530074f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 May 2026 23:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778998781; x=1779603581; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qUI1Kvy8G4UZN8XVWU9+FHDr0P4yKt9TWkL45QXTVdc=;
        b=xGXZZhZWQeUUY8zUSbkhaCnTtTD9MN/0TTaGu7ztFE2LEVCKxf6Kpy2J2gJOkq3b7S
         ddYPXLjumhcYwlBKo6p6asx3kgZgUb9itZYHuDGH5Ek6j1x+1zl3qyDwjubYfXooYA9P
         RrUwZ9kQkAdATUisdKfYVHskxgT+Gc56uYC88W2TcWPtbgl103u32yDtWmo/0xdwVd/H
         oFa8Ffj0Ap4IlKVaAlC5xU84+aWLAC5fXwOQmKAluHmawj1IWQ6aEr3mnBuZP9Z81PjF
         w4zU/+3Ox2Y59GTFcILHqSfWdw2AjaaYm6lrWCAsBxr+5oAjO1etE9ytRhBFZTMZ2KmF
         tMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778998781; x=1779603581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUI1Kvy8G4UZN8XVWU9+FHDr0P4yKt9TWkL45QXTVdc=;
        b=gQWLSZjKcsah1aRSQ0t5QAn+lT0LaRT4rUWBLeegXbI4Ja3Yq2LwwEY4MF18QX61hg
         V7EUsBqJQgHrElwoyhpABDiEBu2tAjDvGy0K64h0XRktJZ81CR6W2jzA/Vn587HDbFyq
         bGvxfAgR1cC06YLa/uMgBV4X2Vi90neF50HQsyJpCNb0xxk58zrgt7WdY6JbK8MHnLZs
         20JJU+4Lj/WFxzHSslHRFIkZn6gqeEMyzwp532zqDOtztmV+QCU6MB5XLMn1Tn25ZDbN
         zbyxF8OwVikdMnO94fxqywK4yby+2WMuU105ugBKu2On8dQE14xymkNWVxc4O9xyl/rE
         cnqA==
X-Forwarded-Encrypted: i=1; AFNElJ/WPOzdaDkVu+sDWjcq2wgE7jz5XpTl5QGKOz5byTk0vWW0EHQinfIYp2w4rYPFoW289lScLnZs5GW/dGw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwMY7ZtmucvlQ0vVMU85/Iuouz2GDFrCOjtc7/2BceBcsMAJ7Hf
	O/LjhAv76yB5+jI/I73CuFfzh6wsPmg9TGxPHLB87xsfYJ/wPLHfSOn8piJ9ZZkuBHs=
X-Gm-Gg: Acq92OHu/RZbmGvwCydyCO3Kk48As7gohfEU7nKARcY8OLe+m25AtzDeq93PozNpVLA
	Q++ZvMPBfWM8zMgkvsyU+Jx3V6J2wMSE1mrRYUOiCpzlXxtSI4lhz+aQlvsIGLQdeh9ZUVf4A9O
	iSYcFwkMS7wtrxzX8xmGmPQrvSX0PGU762/CL3chkSX4DMcXsWzruhnc6JEVmnivdS9AdCN8yKA
	SZ2Gu4wJ5i2LaaoD2p6XXklKAnu4M1YBb69u/v+m31CVNruwYi/3bZ8C2ePfqu9yJWS2a04iskt
	IYW7mc1ow9KOUj0W1qxloa2vCP3oqziixZ43s97eBjxbwuX0tlHzF4nbOux7o2CISoomD+EPhMt
	SltjqgRlWALuyifXgVYuXS15doREwnF8fZvAG/GjZd2JsQcnZUbf4TQ9ic2pBL/PSzgH65B5772
	Ul5RpwuHZ4qBYVwG1L99NInISI1KNfHpqDowXpwsFZMDUD7Q==
X-Received: by 2002:a05:600c:a30a:b0:48a:568f:ae8a with SMTP id 5b1f17b1804b1-48fe5fda35fmr111967805e9.8.1778998781051;
        Sat, 16 May 2026 23:19:41 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537c788sm163535945e9.12.2026.05.16.23.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 23:19:39 -0700 (PDT)
Date: Sun, 17 May 2026 08:19:34 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Steven Price <steven.price@arm.com>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Mostafa Saleh <smostafa@google.com>, Petr Tesarik <ptesarik@suse.com>, 
	Alexey Kardashevskiy <aik@amd.com>, Dan Williams <dan.j.williams@intel.com>, 
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 00/13] dma-mapping: Use DMA_ATTR_CC_SHARED through
 direct, pool and swiotlb paths
Message-ID: <agldl4XQLKAtyLty@FV6GYCPJ69>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512090408.794195-1-aneesh.kumar@kernel.org>

Tue, May 12, 2026 at 11:03:55AM +0200, aneesh.kumar@kernel.org wrote:
>This series propagates DMA_ATTR_CC_SHARED through the dma-direct,
>dma-pool, and swiotlb paths so that encrypted and decrypted DMA buffers
>are handled consistently.
>
>Today, the direct DMA path mostly relies on force_dma_unencrypted() for
>shared/decrypted buffer handling. This series consolidates the
>force_dma_unencrypted() checks in the top-level functions and ensures
>that the remaining DMA interfaces use DMA attributes to make the correct
>decisions.

FWIW, the patchset in general looks good to me. I tested this with my
system_cc_shared dmabuf flow, works flawlessly.

Thanks!

