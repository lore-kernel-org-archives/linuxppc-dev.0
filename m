Return-Path: <linuxppc-dev+bounces-18530-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFCC1093174
	for <linuxppc-dev@archiver.kernel.org>; Sat, 21 Mar 2026 05:20:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fd76R14sJz2yYq;
	Sat, 21 Mar 2026 16:19:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774070399;
	cv=none; b=DnLFDRaeE+DOzfsFczs4RwaKv1qKdzeaW6kCp6cC1D1h51TrWt4yzuEomP9qT4wwgqGNT8OiTRCipBMnStnkRofXySy3nWGbL5t44RcUki872OOICnBwGNnxjYP9zV+8M255p0G1UeCh+sCDekQvuz/C8k8efJ+hrq2OeGTUkD0Oltum9b3FKjYz45YxLgZd79SfE+poyEZctMagUT8PLUjAy3/EPWI213WnBhZ33lt0yFkf0+zJIuKs07C+CyO0Lmmua1qBjSFV6TkgGGXhMN55pSZNRvExiDVMLJIdQ8tTGBITpDUVrihqVk/FMrf1HgMPedTKSqyK/U6V7Ee8Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774070399; c=relaxed/relaxed;
	bh=N5slH90cGMNQaJ/nUAO66vR2HM7xhu3omBUy3YIB1Mo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=N9Me9fNd0TNyc/+XvTveXHky7YchfAMucH7E6Gl14TDGJQpYrFcRXa4GEQ/cEF7WV0G2ZU7HRcCdJkjIFIog/yKV3vvlJoMoXMzOaRJIDi/F3BO4dNuH5F6a/Tk9YnFBs5sf4t9h9pmj+dcnm/CeEU8SqoJSg3ipK3HPd2sVfCc4bM6JK1HcrquHjbB7DrLsqsN1BTLJSWzkcBpQsKVHXEO7Lt5n8wn/6JU4EdZyrgPpZBbaJWqcUkTgPY5j+pAoOj7f7ikmDVqVUzp6M+78SUafTQSzBXOE6igyFZmDM6Y9Df8/njPErBhJin8EK1qJELCWO1MTTUExUV164mUZrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hi088gZ/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hi088gZ/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fd76P5wJGz2xP9
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2026 16:19:57 +1100 (AEDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2aae146b604so15715225ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 22:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774070395; x=1774675195; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N5slH90cGMNQaJ/nUAO66vR2HM7xhu3omBUy3YIB1Mo=;
        b=hi088gZ/xPWz6irw2rlpEiLPKNPA6GFM3KsLE24538fECfEIXOQgJALicYNVjMGtV1
         EHMv9vEnzFpW1NjUvmK215WtCwHlp1Mi8J49IX+xOfGe+EdjTeIZnLYXgJwrjsesgnwc
         Hr+6qxWXI2gju+mFktErn4l2JS2CepB45+v9eXuOTWuEQTEz96VopR+289X+BjGl5+nF
         pFMwRXvy3Z+xsmEhnG/PtA//WuCTiTu51gOWCZSgR7BWpNtwhi96bd9prJD5VkSIiT3s
         qUl9Fq7FRgxYDOF1drw85oIVWCHgen13ijf6n963lDW9iq8/vqzVlNI9/EawVdfRpUwM
         zntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774070395; x=1774675195;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N5slH90cGMNQaJ/nUAO66vR2HM7xhu3omBUy3YIB1Mo=;
        b=DitoVVsMzqcZA2TbTNDVawSpiXf9ywy87rJ2p0gc96zaMVhs0RSAgWkttQOvNCVAYz
         7ok0OVv1Hhajrc8tIJ+ztAM5STMcZzlv1bbGcRNxtEfDFIglayfw9OVpRR1pQx2n7m1H
         w0Ahm0tcbbhZHqWq0NAkyUYRL0f85nv678qwEpcKDUvGia/YoCoGlIeuGeUHwx0EAAFN
         Y1Zbj72k4jELSuJnOH0kwYGpDsl2Ax8BKQ6deSiEjlqvQjQGWY2ZLmZ5NbHZFCg4b0Sa
         dz4aLIVz8kU1HwUTiZFELuln8sphXHvDCNij8m/mbN4pKJMeDhatl/0P1dK1clkGYMA9
         +zUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLkKVLr4IdiEffPu8lS/cLXmOeoH8sBvdGAACXqEu6k/8v3PxeL6JBtw5o35MO7CZIcFBcMOhoBtZ6pqg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw+fQH1GGQi2htbH/REQKaQ20UH3II22KQxKcDQQ/NI+pjhKsdu
	A3A0Cgjxxa4DYCqOh0nSoI1t9VRcx3Rf1dgx6r/I9ivHx/gX8yHEoEeg
X-Gm-Gg: ATEYQzyyv/UJAsBjv8qhdF3ohZyiOXYNilrdLV0zwS2zehRhtPLIStaFjUJAOJAZA3f
	iiY8cKkROtOJxtgWTHIIlt2+gk0N9WVUMOZST65jspC9gdunWFqOVZQtAiMomyX/NbZ1KdE4Pt5
	dIx6QjpmM+RESn5DQqf/oh3qLmT2XBA6pI4rSYPIpMx0mZxEOmzDA7OPI9CWt1w+xGHbguu4IVI
	BdfA/f0wivD9nmmQvgCyW8h8NYqyrusuHCGiUK3X62F+3jP1pGD0K3EzX55vbAuCzlgKn2BVti6
	mnrBrxZuxV38f3DBqVSGrlLWFWP3hBtZb3tXwRS61EDdDzGhl75+jHe4yZYkCUsl9K1Dr4mH2XJ
	ZU9t39C29uAh5NwTTe7uB3NJth8w+5/LSgeft7W6Zl5qpjtW2Kf08AST9vUKDeOhDDKvSjRfLRf
	Q1TC9vjZhZoUWPGrNersQ99Q==
X-Received: by 2002:a17:903:191:b0:2ae:c984:6d72 with SMTP id d9443c01a7336-2b08271e23fmr57382855ad.22.1774070395090;
        Fri, 20 Mar 2026 22:19:55 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836955dbsm52944385ad.72.2026.03.20.22.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 22:19:54 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org, david@kernel.org
Cc: ljs@kernel.org, Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, baolin.wang@linux.alibaba.com, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] mm: change to return bool for ptep_clear_flush_young()/clear_flush_young_ptes()
In-Reply-To: <5d24b34d8b7860dc2188408b3fa530193bcc5caa.1773890510.git.baolin.wang@linux.alibaba.com>
Date: Sat, 21 Mar 2026 10:48:41 +0530
Message-ID: <fr5tyd3i.ritesh.list@gmail.com>
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com> <5d24b34d8b7860dc2188408b3fa530193bcc5caa.1773890510.git.baolin.wang@linux.alibaba.com>
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

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> The ptep_clear_flush_young() and clear_flush_young_ptes() are used to clear
> the young flag and flush the TLB, returning whether the young flag was set.
> Change the return type to bool to make the intention clearer.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  arch/arm64/include/asm/pgtable.h             | 15 +++++++--------
>  arch/arm64/mm/contpte.c                      |  4 ++--
>  arch/parisc/include/asm/pgtable.h            |  2 +-
>  arch/parisc/kernel/cache.c                   |  8 ++++----
>  arch/powerpc/include/asm/nohash/64/pgtable.h |  2 +-
>  arch/riscv/include/asm/pgtable.h             |  4 ++--
>  arch/s390/include/asm/pgtable.h              |  4 ++--
>  arch/x86/include/asm/pgtable.h               |  4 ++--
>  arch/x86/mm/pgtable.c                        |  4 ++--
>  include/linux/pgtable.h                      |  8 ++++----
>  mm/pgtable-generic.c                         |  7 ++++---
>  11 files changed, 31 insertions(+), 31 deletions(-)

LGTM. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


