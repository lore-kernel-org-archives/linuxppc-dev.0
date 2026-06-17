Return-Path: <linuxppc-dev+bounces-22738-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152EBCD98E2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Jun 2026 09:27:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggJRr41Mmz2yfD;
	Wed, 17 Jun 2026 19:27:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781688472;
	cv=none; b=SHpWQcYXJdO06wcI28Rok9qo6fyXLoXu+3NzkBMlSuFnr0gUkGCDlqkiW3OgvOynh1boe4Q9rDogzDoJgitw3umNbO+rV7IJNw6wvBe7YdeMpzQgpiGyxfEAhLczAz70hQ0MIO4Op3F6DdcXZLTNU2OC4IeC1hE1Z6ifH0u6GQi0h7XD1Jrdqg+Nn8HGkXJw8FfiQUT/oM+kFWGZ5xqsPdKuvIIaWMaZGQ6oUSBa8dFx7ouc9ZKttEyiwOL//q7RsZXZt8og7GR20nXxvD+4R5a+T8BPm9lUvZrsbJW5dUFs29/1fli3zknJP1ps3yKg+XRjuTywXuEucpk4c7WPgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781688472; c=relaxed/relaxed;
	bh=hizaUSOcpmr93CQTlwODwEp3HXH9tbZgpK5ejTYO1a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrJulCMUEE/ajsb7JJD7yNIVpNzWP8SXfVvaBnghR9oK2SCiZiKS/fQJXHmXLsKZ/0hECMu+tZi7514QB/84eQ+N/7e7wDxxyuidlM422MkZc8QqIquCl9WYzMoF6G4gRp/AqgeGPIpO1TNwFVKAsN8ZbE6yaSP4wldmGiRZ2CTVzbZaVDwBGGZ0ibu/VqWqFoMUdHIWUXM3cyaBKk/sIfG9FinIIZvhHFle+zTYC+Ouq7qEy9IcGYYw8fHPF+rfR3c6QUnKGbHmGQQhF4Mq9qkc9OsCEu7ffwjUl8RnkmFygzioA6Kvuc0o8CX9IheAmvLaQgKFH16P7AkcYH69qQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HK9E1YsJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HK9E1YsJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggJRq3XrHz2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2026 19:27:50 +1000 (AEST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2c0c32f6ce1so38716615ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2026 02:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781688469; x=1782293269; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hizaUSOcpmr93CQTlwODwEp3HXH9tbZgpK5ejTYO1a4=;
        b=HK9E1YsJVFckUMzdfsMaD9TCJvtpVK9z7bQItgRXTJYKVS2SnQa5lLl8tWLUZapUFa
         Jw66BembFs05smtIni3WToE+RfgeB7XQf1BJh2PlHd8dM614t36sf5DBbsKwXyAnByVw
         V1Or7r1GC9JVRz7XgYsvldeCUoRYPp5ph9vrYZ40A3/vED5eAztR1Yj/sEPczEnRprfF
         WNUAuXSs9B42bgR7c0eihYlHQBBGHuADQwAjQoQadsQAflEJpE0fm8IBfKxEh1y+0awL
         2YVgO5TblAUcsbmBZWoCM8gCkhFJ3FSAroMlJPDk6Wj153yONYfipH03PC2cV5vn4JaZ
         9xyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781688469; x=1782293269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hizaUSOcpmr93CQTlwODwEp3HXH9tbZgpK5ejTYO1a4=;
        b=aWp/tGjuR6fg8Mie/AjxoUNtgvZchm+l/Ue4C4MfwxlZ3X/3Hr90rIhjQs2deuNvcT
         NntJLemDLs5/CeafmMaUQv/alLjXx/lC69IZuHSqW8L/m5snczM7T10kMuIBwNx0iR08
         6gqDaofb5Nk+LLPHBkPhvFF2zNXIgXHjXHPxpHxMfo5pkJ088+U543Zov74V6Jq72L8K
         uQ7ThVHmShuqV7edDGl1qb/KKneOwz6ONWGIuv26nVCHPniyg6TG+z5QIB3xCwO8D3Ba
         azeWIOkDBTcM2UONyX+E6UFaWrEEUGo1Ylwou0KZsnT/nPGDd0H0BAUBFYSEeKt9U+JB
         Zwmg==
X-Forwarded-Encrypted: i=1; AFNElJ++vZGQ+dyy7LsUv8cJWoGzDB5Mfg6+kFruGhwv7cr9W/Eht7sjej7vwXCIqXoi/WfihwpKxDfY1Qo1lKQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzkL1KBntCFTnc0cDbI0aKInbhFlrAWotLy/qVGUMXWGA79e5Dx
	CtNfwMRtKOABXMFLDxG9UBKoi0c21MMapSw7VqCxL5vxa1AVzafir6F8
X-Gm-Gg: AfdE7ckmWphLPd/U255XXdoBJRx9+/q260BlAS4d4j9CI1dFiK6ILTeCPCuxZjA1yCH
	AodYcRvX95AnI+9X6EdNE9nnywcOjLUM5L5g7eE+YoIYjUB2yrP8EycKTbAum/boX4Kwugedf07
	UY/gJ0G8LQqdSzuuE2dLz3eVpQpSbJvqVeDZKVBTCLrSK4S55MUkA3/LAFdVR++3t816OD4TXst
	7TGGF6xAVvtH2UxXN/ffwG7qEbXdA/3lf7Tf8aJLu1iwGicZdJcJ0JUi008AhuWuHvH2sLL+85S
	iyqXXMIkLfixdTEq5DI2CDkroIdF9590+gHk4Ysw9FflT6s8zBWmnllEnIoI7WovY81VAwh9Tvh
	xILGG53HbB1TZh75xnJiCPNMFvfABAtjkomcACpcylcOFpNybOR/NdmGzu6/iJjLCh4puzbBhFb
	V/c89XBe4el6ywgpaazhgCKuG6RX6ziWz2WUEI7I+dwAY17xqRe6BNSLCF
X-Received: by 2002:a17:903:249:b0:2c0:bcb3:86f with SMTP id d9443c01a7336-2c6bbf57bc4mr28631075ad.6.1781688469091;
        Wed, 17 Jun 2026 02:27:49 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c651dsm157900335ad.26.2026.06.17.02.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 02:27:48 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:57:43 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 3/5] powerpc/fadump: remove unreachable
 memblock_reserve() return value checks
Message-ID: <ajJoV8xggRz05J-x@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260616182959.2429774-1-ekffu200098@gmail.com>
 <20260616182959.2429774-4-ekffu200098@gmail.com>
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
In-Reply-To: <20260616182959.2429774-4-ekffu200098@gmail.com>

On Wed, Jun 17, 2026 at 03:29:54AM +0900, Sang-Heon Jeon wrote:
> fadump_append_bootargs() and fadump_reserve_mem() both run from
> early_init_devtree(), before it calls memblock_allow_resize(). At that
> point memblock_reserve() either succeeds or panics, never returning an
> error.
> 
> Therefore the return value checks are unreachable, so remove them and the
> related logic.
> 
> No functional change.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  arch/powerpc/kernel/fadump.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index a313b1653124..88ca6156b81a 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -154,13 +154,8 @@ void __init fadump_append_bootargs(void)
>  	if (!fw_dump.dump_active || !fw_dump.param_area_supported || !fw_dump.param_area)
>  		return;
>  
> -	if (fw_dump.param_area < fw_dump.boot_mem_top) {
> -		if (memblock_reserve(fw_dump.param_area, COMMAND_LINE_SIZE)) {
> -			pr_warn("WARNING: Can't use additional parameters area!\n");
> -			fw_dump.param_area = 0;
> -			return;
> -		}
> -	}
> +	if (fw_dump.param_area < fw_dump.boot_mem_top)
> +		memblock_reserve(fw_dump.param_area, COMMAND_LINE_SIZE);
>  
>  	append_args = (char *)fw_dump.param_area;
>  	len = strlen(boot_command_line);
> @@ -632,10 +627,7 @@ int __init fadump_reserve_mem(void)
>  		    (fw_dump.ops->fadump_setup_metadata(&fw_dump) < 0))
>  			goto error_out;
>  
> -		if (memblock_reserve(base, size)) {
> -			pr_err("Failed to reserve memory!\n");
> -			goto error_out;
> -		}
> +		memblock_reserve(base, size);
>  
>  		pr_info("Reserved %lldMB of memory at %#016llx (System RAM: %lldMB)\n",
>  			(size >> 20), base, (memblock_phys_mem_size() >> 20));
> -- 
> 2.43.0
> 
Yeah, that's a dead code.

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

