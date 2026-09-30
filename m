Return-Path: <linuxppc-dev+bounces-28576-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5D6CA5FC5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2026 14:46:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvyXd6T5tz2y24;
	Thu, 01 Oct 2026 00:46:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790779569;
	cv=none; b=IGm25MQWek/3OGAvuAJzXMlJWonN1H1kFaM6+Vkom6H4rbDZdHbMk7dZo5OkyyjXL4VMK8p/WgWwXceM1jfZgfGaY0ysGl/W+ZE+y7oidDqdDGzwMeg+zFa9Po13ZyxWsF59hLKZOhTlzXtUW7rm94qSEtFMxKuyTvc5wOJ2l9AGtbBDSb4m3AoppkdXk1/r0+Hdc4sbG/9ujJeFTjqE5n2JzYurXgMDo1GYajx/KVQ/PuwPmitG8w+hfC7Lro4sZHrTcTKcTClXCPC4ja1wcbn9pp5ZYmRL8WJeHwCmqyF0C0VpkkbOyFylC2ooFlUGOPWNmcEjwhHABrC/PPL/9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790779569; c=relaxed/relaxed;
	bh=/F5K+TNyy2UgzuNElF3z3QNQRpGUcw1ZJkuRwiOyvlk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkgQCbtcXjZyYn7duH2B1kC9SHjLYg9DWgAAe+iHjpiU291XCNrOUf3m8fZ4fm+BAaTiJrxikjmYIPdGlCzFa2mAVdvsIIYcWCXwFks4QFjdKh8gMinYqhoBdJwCsZVehuiBVxH6yso3DaYtkJcBqeYdI4zMzMzNm1jMpxLksIX0o3+vpEemu2KDC5doyej2IA3BO58iTp36d6/1A1NcvNAWb/JGUwLZk/KqhPfG9MT+skBKkl3Wv48t755ZNw2IYpy90XQHNQ3+bsiP1JqZHPf81t4ws+0uyBMrBMswnEbC4vR8TyxRSHnlihvRjynmWBpDS6jz8zkQtsx1f9+DVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eooFEucG; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eooFEucG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com; envelope-from=urezki@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com [IPv6:2a00:1450:4864:33::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvyXc6yB0z2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 00:46:08 +1000 (AEST)
Received: by mail-ed2-x10.google.com with SMTP id 4fb4d7f45d1cf-6a60591ae54so8700192a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 07:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790779566; x=1791384366; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/F5K+TNyy2UgzuNElF3z3QNQRpGUcw1ZJkuRwiOyvlk=;
        b=eooFEucG80m0obrQ9E4Mb0MaFMJsfrjAMAtk6PEBQC0EOYyMz9kmjg/Y90Ukz9Cq9k
         mrBClGPzRfSJnmTSqRqrolQkzX8OtJjNG1qwhd62hFAGTO8B+bnxClfmEVvYRiUteweS
         MirODa5DLrfE4BewxqQESY3Ios5GLeuP54iOmuXccvyFJd3RoR7xijh1TOokOpXZENBl
         YDChZGQaFjDuv3F7DiT7+4LzVrcCVQosBw3Ef6O+jXNX30xZc+f/MFN6yHBnrUxKRx4G
         nkYCPnoPy5Wk4tTfN66a0NUsaI3EXMuboQ6jcyQJK3TU0CJ0ZgXxdXv7ujalqtZXvvVP
         +nUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790779566; x=1791384366;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/F5K+TNyy2UgzuNElF3z3QNQRpGUcw1ZJkuRwiOyvlk=;
        b=HKEyatbWBj0u2WFjHDr8oNITB92CuhnOV8T2Brl63lrb2RPKwkZlFntuGkHPhn6Jc6
         wGDwXKsP2pWlHkpYBGdAgbDQcQcm+CqYGm3bIJoC282B66Ec+f03m3j2NISYR0A+N2X1
         9N2RXuKAIe1Dnmy6d5sOaQ8wfN4QpIH1t6r6dgUa/k+wges8JZTz4OYSdgxi5+dFnlZh
         H3b0hXP/4/Xgb0zISwyF5wquImURAwtiWLJKzxDms1JbDOYsbFLBE7Srqfliqdh9DFFf
         HKTONTv6pBjorlxCwBU6zW8CG3FjVwSHuEXVVwZ98/gudJkLlg/gUUF+RCl4lXh4v5y6
         Hm1Q==
X-Forwarded-Encrypted: i=1; AKwUvBxGHMbQ6bvk7VRDgYPuTN2IwICkdAmJhFAmt8jLsKHmtLLlqbt2jRybvX9dz0quY0LGv3rMqca/SxYu7eM=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYL4qDHZ7koyO9m5b2fyTusiFcaSwR1jP2Omdjwf1i23Tb5VqI3k
	cCNA7E3wTFmNDrzTp0TTy2kAuwZ2Aa3V5E+uiBqeYZ07+lvI6mvL7fRu
X-Gm-Gg: AYBFou3ApegB+cATD0dlf+u55y6htjBsx1gAy+Cn1XH5RRXY62lcASv+z1het8BI1Qf
	POMkeMjYmM5G5PZH9rUs28+Ex9elGWZZ0T91tGeXS47yJG1vbuU+RHoJacKZa7f5IBl23uf1rop
	DsIy5eMM486BvifsFkQh79sPOg4Mo8uBHmbp4y/qYzrXyH+Sq9h/zCFBWxMo4+1c3KBDwL+k42K
	mlCjfx1Gk66W2ghR97oBZaf0PvgUeQJG5nqZzHtv3QjhmWWWNG6tBueiqhTFxo6AmiVocQYvtZa
	rdFBrh5myMQvyPdy2EG73/8Ota7xLOrxnlkwcx6A2ccCZJ2KAvHPL1J1q5U+7qXxv/l3+AisYCg
	b3nOzzcQsKVMDBC0M7o0sessmXADet0hWntG0i3ltxIyYWhYqftQLGDqFwtMtTEYRRWGCYExBvb
	ujwlxdk9sXnRXqbinbkzXk4CMTgjLKXgtu4ydVPoUmBx/0jA==
X-Received: by 2002:a05:6402:1d54:b0:6aa:734a:a084 with SMTP id 4fb4d7f45d1cf-6ae198f00d8mr1300841a12.27.1790779565320;
        Wed, 30 Sep 2026 07:46:05 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ae1569b42csm924295a12.24.2026.09.30.07.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 07:46:04 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Wed, 30 Sep 2026 16:46:01 +0200
To: Wen Jiang <jiangwenxiaomi@gmail.com>
Cc: akpm@linux-foundation.org, catalin.marinas@arm.com, linux-mm@kvack.org,
	urezki@gmail.com, will@kernel.org, Xueyuan.chen21@gmail.com,
	ajd@linux.ibm.com, anshuman.khandual@arm.com, baohua@kernel.org,
	chleroy@kernel.org, david@kernel.org, dev.jain@arm.com,
	jiangwen6@xiaomi.com, leo.yan@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, rppt@kernel.org,
	ryan.roberts@arm.com
Subject: Re: [PATCH v9 08/10] mm/vmalloc: extract vm_shift() to consolidate
 mapping shift selection
Message-ID: <ar0gqTEf2flG1TQd@milan>
References: <20260923062832.479455-1-jiangwen6@xiaomi.com>
 <20260923062832.479455-9-jiangwen6@xiaomi.com>
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
In-Reply-To: <20260923062832.479455-9-jiangwen6@xiaomi.com>

On Wed, Sep 23, 2026 at 02:28:30PM +0800, Wen Jiang wrote:
> Extract the vmalloc mapping shift selection from
> __vmalloc_node_range_noprof() into vm_shift(), preparing for reuse by the
> vmap batching path.
> 
> No functional change.
> 
> Suggested-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
> Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> ---
>  mm/vmalloc.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 6e0dec73107a7..a43965016eb4d 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3568,6 +3568,14 @@ void vunmap(const void *addr)
>  }
>  EXPORT_SYMBOL(vunmap);
>  
> +static inline unsigned int vm_shift(pgprot_t prot, unsigned long size)
> +{
> +	if (arch_vmap_pmd_supported(prot) && size >= PMD_SIZE)
> +		return PMD_SHIFT;
> +
> +	return arch_vmap_pte_supported_shift(size);
> +}
> +
>  /**
>   * vmap - map an array of pages into virtually contiguous space
>   * @pages: array of page pointers
> @@ -4079,11 +4087,7 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
>  		 * supporting them.
>  		 */
>  
> -		if (arch_vmap_pmd_supported(prot) && size >= PMD_SIZE)
> -			shift = PMD_SHIFT;
> -		else
> -			shift = arch_vmap_pte_supported_shift(size);
> -
> +		shift = vm_shift(prot, size);
>  		align = max(original_align, 1UL << shift);
>  	}
>  
> -- 
> 2.34.1
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

