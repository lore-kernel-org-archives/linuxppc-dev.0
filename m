Return-Path: <linuxppc-dev+bounces-28105-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0D8C98311
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 09:28:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hr7n94Gq1z2yD3;
	Thu, 24 Sep 2026 19:28:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:38::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790242125;
	cv=none; b=Y8al1xrl0I6ePmNzmFwDQyfrSkM2sfwEVOC1UW3LVD7kWeWAVwR5+XfiVtgm17iCVrVPqTMeRKiqs5S0lNmDjijGua/+ePmexs9fTYciIezergT8Z42yHl78BrH8cAOUpbx5RSqq9ve08Q5V9/tas3Mocts5iu2Ftj8+2UOzLzfk9fOC6eS8xGKWeB1gv3UN6NtBdRbipJzhzzfLeRXtH99EqatnlQdSTCJrRsw5IdI3D7Cdd2Ac1pGQp4QU0Wq5F8VLhx6SQbvGgkrxKlRtuBpbzlMgI0OqDobdi1hC7hNvwwRpvXL0+hliJItdsXGD2YZT8RJFRqjP2L0QlZG3Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790242125; c=relaxed/relaxed;
	bh=RsbsZ44qFDIcXSfMC1wvUtMXb1+773bJ3OZ91uLoUHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0r1sELreWj7d3t0lu8NBzIyf15vjeBLQqehUs1t0mUrmsfELFawohyI29Ufrs+0vdN9EiDkuSV9YLWFsX7W+Pt/vtVbC/55ZIuL41/Hq1YUxcSPYHw21Nx1FhboXjqohCC6IVIpxw4riKQN3j1BQ7tlXa4to15K+wNtvz8Y4k9jOpky2NrljtUVVnYEmMwbLk37JR74aMbFYzyMt4GrAOR2vTLNGnOk/HmxKRdBFdWHSMGY4Jysnl7rXxAWIOSuqO1t5l3/YphCqTV2m5l1LWAKY88CGLeikHhe2POesB5+/j1Xy0f+MK9bqEiiRBbTMhMU3MdBc12NkZ6Vt7v7hg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XGCEVoP0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:38::f; helo=mail-dl2-x0f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XGCEVoP0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:38::f; helo=mail-dl2-x0f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl2-x0f.google.com (mail-dl2-x0f.google.com [IPv6:2607:f8b0:4864:38::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hr7n76hhQz2y24
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 19:28:43 +1000 (AEST)
Received: by mail-dl2-x0f.google.com with SMTP id a92af1059eb24-1438f55921fso706764c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 02:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790242120; x=1790846920; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RsbsZ44qFDIcXSfMC1wvUtMXb1+773bJ3OZ91uLoUHc=;
        b=XGCEVoP0fTbgf2m2hjC0v0ZY+l17HXaGbMwrXz774SYDsJqExRtrcTJaxFgMs7EKmd
         9J/MnKYlijxUO+1re4TryahsvX0SdAhyuouvY7VJITWZV1XoBFYUIXOAlRBt0LRwJoOv
         7g/c7LgT/E0LWMPetZKw0yVrrIUbhGsXPYD48hwG0jf0o6PkcKx1Ded2tNL6iOiA0oJZ
         ztB1t8CjfcJjEcpI0TgBPQf3eTCr4n5wjOSxt3KddDs7DSiZgqFDVdirQJ5bHdQbFPI8
         VuJfKkF8ZbYTi7ePXoMmRFmYUFd8WnA3IPgIbuxFsAaP4kFqsCYlnvvQ2qzk1BZ51tD0
         U26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790242120; x=1790846920;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RsbsZ44qFDIcXSfMC1wvUtMXb1+773bJ3OZ91uLoUHc=;
        b=D4PlnEEmAAaaIzes4/xqOBeiNm90dxk13EXicmwhlakFCtCjrj0TYK4kV+fV+PhwPe
         WIAhH4hRne0EnZKuB2KcUMzJp4ni/Q+BkwKDoIvR9KktsYBb2IePoyhOTYfLNb1nRT2m
         P5tX6qFbqk1bdgrCbxf5W/eVNzxBbQShR2ryTMl5u5gwgR+pGzZwQp3+HI6L5k/DmuBa
         3D/LbmeTfwN6JuwGdBN+gx92d6VAT1ZiWgE+iN7k6gmX244Cf8v2wjTQtk2tcFIIw6gD
         5bzJXy6sIKSM2O+m5g3MmWW9fd/WSewwo+/PrzAfoI17FfH9/wrMmtVFtEuhFmelgR0B
         omkQ==
X-Gm-Message-State: AFuF++nW+tuGuZG3aC4uHcjBuTfQ2pXCvjBssxbBNLSiF8PTrVmufksU
	GaKkDs+0/Xyk748a9/R8U6MJTS4dGlyTnNNuQrf/3pxCSouBO0gS0n/y
X-Gm-Gg: AYBFou2XwfbUmHa4TXqFZSLouTBfapBqHKzjzNzcCKGANffqR92Kw6rRPhcMBdLt3P2
	Fa0j7bAgQp/ZdOeX9Pm97MHfqZdgIhIaEv9QEqTuJKdmBlnS2seJJUiTI+JNB9A3zK6YMCfCsNN
	ADa87OiKJAkViH7WVy+7dW+ejMxrXAC5cEaaCylLD+e454oOrcslw48DtDFmReXWUHurUfA1fgB
	FSYBSZBmwytjzIzpjh+Ou21vchrCkRSn10p2njNc9uWFX6v0G+rRijhfK1bjilP7Utg4MVSv8z3
	jBsEHCpnEJdWlX3evV/8eToUywUcS8LIn+uPtFBJSDqWlCHe0W4NHXwthDDAe3KOUE3hd3J4Ujn
	j2la2rmRs+ljUAkXXcUCZzAghLrP2S5Z5A7hcVLU0HXVj4AntwsK7pzhyLJZwlYdc6w45aWD7MG
	Ayqc644Aa0tBgDH7oyi6EUYmLS72g4UHTpFWKi8OGCLXV7PxeIleKSoQmuhh44mP2GBE0zaaUPZ
	De3Zx6ncaP8VXiJke8QWta7u3NCMEX2C2E9tXdHlbaP
X-Received: by 2002:a05:7301:f21:b0:33c:e95:2eb2 with SMTP id 5a478bee46e88-3400171d8f9mr1621229eec.41.1790242120185;
        Thu, 24 Sep 2026 02:28:40 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96258351sm12706541eec.12.2026.09.24.02.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 02:28:39 -0700 (PDT)
Date: Thu, 24 Sep 2026 14:58:33 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Jyoti Gupta <jyoti@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, 
	sourabhjain@linux.ibm.com
Subject: Re: [PATCH] powerpc/mpic: Fix memory leak of mpic on error paths
Message-ID: <arTs9bM5sOz0CDch@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260924063010.188642-1-jyoti@linux.ibm.com>
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
In-Reply-To: <20260924063010.188642-1-jyoti@linux.ibm.com>

On Thu, Sep 24, 2026 at 12:00:10PM +0530, Jyoti Gupta wrote:
> mpic_alloc() allocates struct mpic (and optionally the protected
> sources bitmap) but does not free them when mpic_setup_error_int() or
> irq_domain_create_linear() fails, leaking the memory.
> 
> Initialise mpic to NULL and free the bitmap and the mpic in the common
> error path before dropping the device node reference. The register
> mappings are not released here.
> 
> Signed-off-by: Jyoti Gupta <jyoti@linux.ibm.com>
> ---
>  arch/powerpc/sysdev/mpic.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 6e8fa94985f3..e777b33f170d 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -1221,7 +1221,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
>  				const char *name)
>  {
>  	int i, psize, intvec_top;
> -	struct mpic *mpic;
> +	struct mpic *mpic = NULL;
We don't need this initialization. We initialize it later again.
>  	u32 greg_feature;
>  	const char *vers;
>  	const u32 *psrc;
> @@ -1488,10 +1488,6 @@ struct mpic * __init mpic_alloc(struct device_node *node,
>  						 intvec_top,
>  						 &mpic_host_ops, mpic);
>  
> -	/*
> -	 * FIXME: The code leaks the MPIC object and mappings here; this
> -	 * is very unlikely to fail but it ought to be fixed anyways.
> -	 */
>  	if (mpic->irqhost == NULL)
>  		goto err_of_node_put;
>  
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
Do we need a fixes tag for this?

Regards,
Mukesh

