Return-Path: <linuxppc-dev+bounces-28144-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA29C98318
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 18:00:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrM7c0N5Jz30TL;
	Fri, 25 Sep 2026 04:00:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::830"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790272827;
	cv=none; b=ofJYnLwngfPtJk99y3cAP8guoolDpSjLi+vGh1HP2quRknF1y77tLpaNF3RO86EnopmOluvKG230l2ZN8N3666UkEv4e4lgqOttd4H7TZY6sHMuUSqzT7dp5APwYa9GjLlR9gKcZrFHN/rKizFpCLEo33Xb8AF4L8zlBuvrmBKheupV6kcVdZBuOWMUdKRWpUfOqsFLZ3rbJcb5pOjog3uVz52cgjxpl0X3fgSSTpgWd34yY4qDGFt/i4M93vDerskiNjARlOK4iH5DECExEzlX9yWDC8r6oZD9awYPnWWU/uZp55ecypZpzhaK0xbEgSoE+UgJq9ZrGu6JErRWbCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790272827; c=relaxed/relaxed;
	bh=yIrEACM/1hk8RvSSdnwytl7iIy1+VcppA4PP9Tt2BDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arKJSj0sEOCJBjHHMYuPczel9yxXfWteC+oCe1e+JYJmnLP1JGMfJdT2jGLC3dZPBp4jD/YG7Hr4KdpPNlJqfuAYExcrBHD6iDfM4Mjt4+6Gnp4uAt9Ovl8NoCa34r3GqPdBr/a5SMeLqV1+VxHUoiV/6WtcFw5+2H5qI9bAu/NvqtJ6356KCDX/MFlTHaVHT0WBjp9BAUYWsZvQQMtNnNT6SE9/RDFXSs5ulen2Qk9CjTZM0MOjCvrBjUHEqFZuqACeHpnAkxa4HRRWtr07uRuTChzO9qf9CC48EX7TZ27hQXnMp80n8RiARc7QVq0t1oTSY/azo1aKmcnlHlXYlg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gourry.net; dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=MyY+foDe; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::830; helo=mail-qt1-x830.google.com; envelope-from=gourry@gourry.net; receiver=lists.ozlabs.org) smtp.mailfrom=gourry.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=MyY+foDe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gourry.net (client-ip=2607:f8b0:4864:20::830; helo=mail-qt1-x830.google.com; envelope-from=gourry@gourry.net; receiver=lists.ozlabs.org)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrM7Y6N5lz2y7Y
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 04:00:25 +1000 (AEST)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-52f9fc510e1so8275641cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 11:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790272822; x=1790877622; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yIrEACM/1hk8RvSSdnwytl7iIy1+VcppA4PP9Tt2BDk=;
        b=MyY+foDekiJ6hLXWe02/4UQ9qg69oQKxy0jf2dT1n4SFuINQS5/FBDXoSgUovcI2KZ
         T0gON0YDMHF7amudxzXumK6MEw8SmL1is67THdZZT/nikV2kHgyxdDkkW9vbFAqQ4lqV
         lS6XhAzfbMxw2nyt1DNOdq8Xz09YxFnTGOHovNocxbi7YuS4IObe1iI38XfX9l3Mpy82
         EKseM4y57pc2T21hOy/7L+QuA7Owdit+Mtu3LDmMxwEP9SgmY4Hn0CQRndSEQwI/5Seh
         lcQlD6zUq0aSnv/5n3fC6DrT4JiSxm0Cwzw4JVQU5GPF59fO+zeLBas0YsrvCCHYiHt5
         YJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790272822; x=1790877622;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yIrEACM/1hk8RvSSdnwytl7iIy1+VcppA4PP9Tt2BDk=;
        b=L8UsMlpo6j/1CoLKhGxy4ylH8Wlsihx3mSdQcquvPzTvnYBnIZPzh4hJfvdO+ou+LC
         9gH32duW2qBewVNuwhPDJOg3vM8IHxwfrUddTAikXbNb3KfI167YutI3wnBtNRMQ2H9y
         gStkan+zcCIl9KwBvvrsr8XeVH6/4cVHSbhgMMOQSPAUgUPn+pjoKDHfbwoG0g45p0kG
         4eCfaTCUk1tOUyzYVoyRJhk25TEsUwCnBfgjobFaHBP/z6ImEsFYD2jqxxArlkslhrLl
         Mx9kk1VfdEMUjs31oPwskxUMf+LnQ9G4CjiqqEuqHM8CQ6b79/f+5y2GJMBUGqQYvvtH
         BX1g==
X-Forwarded-Encrypted: i=1; AKwUvBwxaHVvWXa/WO9blbYbjorqFxgo7LdncLhUARFwirhpoJUV/SlIa9eJdmJEoLKGhO10RUS0+HtySSvMyao=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mnzAR4WwkBLvgMa2T0hXeblqrA+3X/pG8DNj6YfLk1uEoJOGR4
	dVykfBH/fGW0sqgm3jwAZrT2CSeKusBnB9cg+VPbxxToqotWuGfIPyapb8xCY8cgLmU=
X-Gm-Gg: AYBFou0wJ6N9TX5ePuLPUFaOlxMdu/HHhwvK9mPaiWNjQ1CBoFhNLscYsNtJZ0n1XAg
	x5wPuSyorc/Bitu05jkBd4GKz0jR3vOI2rvLRhfaVqC36lJ50JPqokGBTqhAf8ozuEPvXtBaVwJ
	dW8Tifc0q/4YVlf3VeXnVGYsO8KUbZf7P2jfsl0Ckif/PB08LTvbjjwAO2gnW+9cMjIv3LMMJG1
	42mDoCEoKUon/dzSOWTItqWT33LhIaoqbEZErmUQ+FCJN8vWR3Ur3X7UUR6iPUGHcG5TJ6XXP8R
	pnSyWycNP3ezViIcOZ15899jCPPbKyqUf8c9hs0U9Fknfu7DW3Ce1FRiT0EQ6RMK34gvHEj7EDM
	P95gTTPzwyN+9TUiLMriQMnz6ikAzEgVxaTEVbhm2izwH1GVNB4pMc626WBKX8z2jwbfv6z080+
	gkYtx9XJBKGHrjeWMv6rdq5XEHYjKQooLac9W0Ne+hahie+tg6ZQeFA4J8r/vaukY5O6/LMuR6i
	BNmfgrAheH/3ILmVezSHUR1TybKUjKm124RCO0B4N9bgSsQMrueGzE=
X-Received: by 2002:ac8:5a46:0:b0:530:e682:87c with SMTP id d75a77b69052e-5330b6df434mr78501cf.33.1790272821894;
        Thu, 24 Sep 2026 11:00:21 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532eb38d347sm47450101cf.25.2026.09.24.11.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 11:00:21 -0700 (PDT)
Date: Thu, 24 Sep 2026 14:00:18 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-rdma@vger.kernel.org, selinux@vger.kernel.org, linux-sound@vger.kernel.org, 
	bpf@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH v3 05/40] mm/vma: ensure mmap_prepare doesn't set actions
 on a mergeable vma
Message-ID: <arVkwC_wNoTLjRYf@gourry-fedora-PF4VCD3F>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-5-4583d8a23bca@kernel.org>
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
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-5-4583d8a23bca@kernel.org>

On Thu, Sep 17, 2026 at 05:22:14PM +0100, Lorenzo Stoakes (ARM) wrote:
> When a user requests an mmap_action be performed in mmap_prepare, this
> involves populating the VMA range with data.
> 
> However, if the VMA is mergeable, it might then mistakenly be merged with
> another VMA without having populated the range.
> 
> Every mmap action currently available sets VMA flags such that the VMA
> cannot be merged.
> 
> However, to ensure that no future mmap action falls foul of this, assert
> that this is the case upon mmap_prepare validation.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  mm/vma.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/mm/vma.c b/mm/vma.c
> index d6ed10cefc8f..62f2ce1ad5a1 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -2809,6 +2809,15 @@ static int mmap_validate(unsigned long prev_start, unsigned long prev_end,
>  int mmap_prepare_validate(const struct vm_area_desc *prev_desc,
>  			  const struct vm_area_desc *desc)
>  {
> +	/*
> +	 * It is not valid to execute mmap actions for VMAs which can be merged,
> +	 * as any such merge would leave portions of the mapping incorrectly
> +	 * unmapped.
> +	 */
> +	if (vma_flags_can_merge(&desc->vma_flags) &&
> +	    WARN_ON_ONCE(desc->action.type != MMAP_NOTHING))
> +		return -EINVAL;
> +

If you wanted to make this unit-testable, you could pull it out into a
separate function:

static bool mmap_action_is_valid(const struct vm_area_desc *desc)
{
	return desc->action.type == MMAP_NOTHING ||
		!vma_flags_can_merge(&desc->vma_flags);
}

then write:

if (WARN_ON_ONCE(!mmap_action_is_valid(desc)))
	return -EINVAL;

And you can write a unit test directly against mmap_action_is_valid

otherwise

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

