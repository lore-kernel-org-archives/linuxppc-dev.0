Return-Path: <linuxppc-dev+bounces-28820-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E803FCA5FE3
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 09:32:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxgRZ3fnRz2y2B;
	Sat, 03 Oct 2026 19:32:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:41::e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791019962;
	cv=none; b=USNg4Fupww7fa1Mqb+kkq1bsbrVYZtwF72g70+9s6a0eqY1dvufzaQT24vqQCtgLm5zUDusnOHzMTlxhlZCWAPGUWtkgb9G1G02G4Jz7LlpMRFAmF3PIXyvH3ce9bFeFqedFfM3zwgy5vhdKlzdmdxBKrenoJNJw/VjVnhv92Es/kTZFNV9mgw0gl9rNZnMoyrkccOlLRYp+vOMNrDshlf62/uGTaE4nGoB4k1MMAjL2bsO5hNveAHDHjScwLJBmsle4nXTRmsFU5OYnTAnwNMVK7IPtvuaKljfXX6Q5043Akk8c0pKARliUNYcd9YQp+7SRAzPgAG0OCRzikcJIdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791019962; c=relaxed/relaxed;
	bh=kpYzvKfXKphzBuWoOuKueufcgVgpIk4c2e0VF5HeZm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMJmxsVfIAit39cBT0sv/pCh5itvzzRXvikVSnzrCLRBj0x9gwg6WGvh8emmDCtBkEB7ZEPXwSRRa9ElXKm3+B/4LSrdVw3qFleX8ri4pGdHs9MZQaPDgfzvZo8boesBqChFmGmjAXxpC62GQ2frJUEkhgO01K/m0m0Yes2wppFz+366SYjOz/kqUYvr1aBvPJ7iywlCtiiiHKI12moqxgx1KRihpHMVa2/F/w9ZUJxft4HSCoSMHMLzftB8GYfAiIYKNpYwiewXIbKzQK2tdF5HCkWo3Bz70aNO4GxpiO09BdvoZOMVm/ODJgdyHTbR6TiUXDfDX2sgvQ340Hu2DQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JQkDi04A; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:41::e; helo=mail-yx2-x0e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JQkDi04A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:41::e; helo=mail-yx2-x0e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx2-x0e.google.com (mail-yx2-x0e.google.com [IPv6:2607:f8b0:4864:41::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxgRY4Hz3z2xr2
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 19:32:41 +1000 (AEST)
Received: by mail-yx2-x0e.google.com with SMTP id 956f58d0204a3-67375a844dfso132023d50.2
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 02:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791019959; x=1791624759; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kpYzvKfXKphzBuWoOuKueufcgVgpIk4c2e0VF5HeZm0=;
        b=JQkDi04A00HMwHSCuuBuayn2uliDKbR0KDvVqucp/kan57eIQvBJCv/0wSzP9vyODJ
         DFEcz2+NkoJh2XZWC3I/i1iQ81NM9JE/j/BU5fULNDxwQuFrtSUBSHsir1na05EHjQX4
         4AhATPgBley1JrX1+jOOkeeeaE3/hLKa4pjH5oxuKXypdcrsTFUKOcLLV/yqT4ls6N+Q
         PX3RhgTlp6UzuuRduAF5DjmzgMqqAd6uuV3ETGBw30IxEA5JKJ8uKNq9G4luBaEZXBmh
         GUT5fhZ6loT5S8HdcSW4VW+AY42cTO4o+4/ZVHCWXZ0zSm7qC2s8AXxo6r0b9iB+1m4P
         RFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791019959; x=1791624759;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kpYzvKfXKphzBuWoOuKueufcgVgpIk4c2e0VF5HeZm0=;
        b=guHu6Y6yh4eHM9qRtMmURAURQQ+BnfF2n9YSCdS2PvRiqwRbuIg1+n1WlDkv+XYm/s
         nYABkhmGQKKKmqrQ81Hbuw9546WHK4Od5DrbYu3Gc+4smXJ8VtIctq51ATkIeuvfQeOP
         6/T64SP8i10eyzWM3b9q3ymQihkWs1KB/MxoxvNjQlOSF7Re8nRhHoz8LnATajqXI93M
         EtvSK1dgCf+KjMark9E0F9smo1c4jFxPo5eSYZV84F8g5nNDjroJMdoqYzkJqnYMVP26
         ucFujo3saBxsFs7WCnWbQNGCpuHoB952lO23awd8W/mhf0C8hEI55noKVyvtcpMMYab2
         PdEg==
X-Gm-Message-State: AFq9FYK/U6OXfCnwUlYxEMvSk1WWQJE980CS/k5xctujIF4xkRXBTa9C
	BpVNnc22Kg1GBYwxrHXW8xKus8x3faB78fWldm09aZ9gKtgNenLML3Td
X-Gm-Gg: AYBFou2vG/b4/+4N86DnfH1yXDWHcKEFniMOEXH6CHrytlFPTLvAq+NbcFo02p1Jnxy
	uffPaMPRpnXt/rbBDJ6U6C0Th0NSh9/rpmasr365LJY5CgQH4KmP6eZebrwNzF2eAXMUytzvRlM
	xOxrJpWmBlw815TJ8u6lVeVHMVXrZSMCga4SqpolbV9R+1QGvIqvc5xas7QggGkf9sYBnVacL2i
	+0hV167EADQCL1Xmn0rcef1E3bXOFgXGLgRitmxi38aMZUzwVp5oGzOBtNhD79gcipgbQztRrNA
	kROQJwSPhJWr7gPNTlHlS3UMCfZlvY9Q6bAdg0G6/noIQcZtfptp46Sk0LenHa9ejMg5zxL1e3B
	Ae9ifDJX07LHdFV0NstVyVc8pXNbRAs4b3S6W+BjNI7HSjQJGsu5OjGeahvoIyTK9qMN11c4GlZ
	aX+Nl6IJNN4Ep1t5yo/t63uyGMW8T/yCGkpC8xg+MA5Vpa1ysoSMVSg1ZJNEQJjvWBNvHq6B+nY
	7dvvH4iXGI6Uss1Fjt7dbgFEu3Axhii0oRWdrBdoiDZ
X-Received: by 2002:a05:690e:1616:b0:672:be40:5eaf with SMTP id 956f58d0204a3-677ac079547mr2230329d50.54.1791019959174;
        Sat, 03 Oct 2026 02:32:39 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae2ed25172sm19476327b3.0.2026.10.03.02.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 02:32:38 -0700 (PDT)
Date: Sat, 3 Oct 2026 15:02:30 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Jyoti Gupta <jyoti@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, 
	sourabhjain@linux.ibm.com, amachhiw@linux.ibm.com
Subject: Re: [PATCH v2] powerpc/mpic: Fix memory leak of mpic on error paths
Message-ID: <asDLncGKOCTdQzq-@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260930180919.335930-1-jyoti@linux.ibm.com>
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
In-Reply-To: <20260930180919.335930-1-jyoti@linux.ibm.com>

On Wed, Sep 30, 2026 at 11:39:19PM +0530, Jyoti Gupta wrote:
> mpic_alloc() allocates struct mpic (and optionally the protected
> sources bitmap) but does not free them when mpic_setup_error_int() or
> irq_domain_create_linear() fails, leaking the memory.
> 
> Free the bitmap and the mpic in the common error path before dropping the
> device node reference.
> 
> Fixes: 996983b75ceb ("powerpc/mpic: Search for open-pic device-tree node if NULL")
> Signed-off-by: Jyoti Gupta <jyoti@linux.ibm.com>
> ---
>  arch/powerpc/sysdev/mpic.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 257886ec3f70..b21a880777cc 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -1389,7 +1389,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
>  		if (fsl_version >= 0x401) {
>  			ret = mpic_setup_error_int(mpic, intvec_top - 13);
>  			if (ret)
> -				return NULL;
> +				goto err_of_node_put;
>  		}
>  
>  	}
> @@ -1488,12 +1488,8 @@ struct mpic * __init mpic_alloc(struct device_node *node,
>  						 intvec_top,
>  						 &mpic_host_ops, mpic);
>  
> -	/*
> -	 * FIXME: The code leaks the MPIC object and mappings here; this
> -	 * is very unlikely to fail but it ought to be fixed anyways.
> -	 */
>  	if (mpic->irqhost == NULL)
> -		return NULL;
> +		goto err_of_node_put;
>  
>  	/* Display version */
>  	switch (greg_feature & MPIC_GREG_FEATURE_VERSION_MASK) {
> @@ -1527,6 +1523,9 @@ struct mpic * __init mpic_alloc(struct device_node *node,
>  	return mpic;
>  
>  err_of_node_put:
> +	if (mpic)
> +		bitmap_free(mpic->protected);
> +	kfree(mpic);
>  	of_node_put(node);
>  	return NULL;
>  }
> -- 
> 2.55.0
> 
> 
LGTM
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

