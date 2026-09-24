Return-Path: <linuxppc-dev+bounces-28106-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF927C9830E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 09:36:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hr7yN1mgnz2yPG;
	Thu, 24 Sep 2026 19:36:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:38::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790242604;
	cv=none; b=XBTRbQD++hcSDt/oA5rPIm/6SOiNuA9MBijaJJjp2TEJwA70A8A1ZQ5A7WTpN8BEqDMsPFuk/LBId7L20HUEPOl1+XMHtx+p7G2/AeLpOSEl8t2jXpGyUJtM5mjTT9IE2cMGI7CV6P04zGK0iz/tyYpE61pWKtR3JiM66pclTIOGI3X8A60MYJjGS7/Bc3j26jjv6Vd0f5GMkn8UZWXZqhra+69zjLL/a0UUDiDYa7RI2UWJT944GctqBANwoZ7LIct3uBI9NkSQ0tUq/BxCXd8+UDxuaVLTPHm09OpnLP3CsINZl5zIKDbypHVSHvhMtsmNV6K9r4xU4LzBsV/3KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790242604; c=relaxed/relaxed;
	bh=P+Uqaf3F/kOj+FRl3+deg6igqCD9HSk1elxNctF4Vb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUxknnF6m/40CvM0+nvtHH5rdpev47p8HS5AZ8gk1HreryRxOpQC1UM9+APV/I41tygOEmZgLViY1Y74dxJYDzuIsjZH4nQWLgl9FRg1LSJNENblK1mDIriuc5OJONuidVGLCmVwx5dtFam75kWqQmxakN0eA4QVvzvAfMOYN0CenOjju3hifF4j0hTduES5xJARiwjt88Hf2fUZVtEJ9Iwqbm+eCbmJjRpeH12CD5jiAmsU4nxFSDIzOAD+DHoB9ZWzMSP9B88g4AYIKQd14p5ogJbZ6Wcz70Gknz4qAcSEY24mqUaMsEW5GlB/DGZeBatrN5solv7rZpraOedoTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FVGRDR6b; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:38::10; helo=mail-dl2-x10.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FVGRDR6b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:38::10; helo=mail-dl2-x10.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl2-x10.google.com (mail-dl2-x10.google.com [IPv6:2607:f8b0:4864:38::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hr7yM2SFCz2yD3
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 19:36:42 +1000 (AEST)
Received: by mail-dl2-x10.google.com with SMTP id a92af1059eb24-142dd04edb5so3220294c88.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 02:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790242599; x=1790847399; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P+Uqaf3F/kOj+FRl3+deg6igqCD9HSk1elxNctF4Vb0=;
        b=FVGRDR6bx9aHX3AuvkTWv3pwQkt8MndqGixTPccU5gASGTPlyRNG0+mLxFELUcFiW2
         BG24pCgmCXaWWYIC+OjtoLal3Xhxqgwi2MclJuroJW/3+HcdL+1mhqKoNFv0fVGIbsIe
         uqBNsQkiwRynDcOnLjcTXidzG3VJtHnpyokmsVzQwgoypbBhtbN/ur7ApfKI8vG0xm/J
         0LBaU5xV8GKjo/EZCAIxy78Xl81sFHLnOZasEk43SIv2YJk1AopqE8Jrfe49yHvvbF69
         yCdNm+R6NPLs6sV3FFt1APbD4VRO3cvNMQrxGo+r/4ZD24oVflr+5C3iV7kWnbZM1Ylm
         TYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790242599; x=1790847399;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P+Uqaf3F/kOj+FRl3+deg6igqCD9HSk1elxNctF4Vb0=;
        b=BjU1HamlLNQ3z5Dld8fScDtHbkPFWUzYlJqaWxr2MJvxI+UIrHYf1b5n639n3DRvQe
         6SIi1d/6pZAOeaNKv43nPFl4j8y/LzyorT4SZBSSiZ6+zB1VHtDs/SB1xZnBfJPfk9Hd
         o2fWAGmQXT3fTKmRa3Lg08cXzUuIu2toNeuYOgtSuf/RhdN+JBz3AaN0MfhcxMrVrK7N
         iT48ne/p7vZEUXGg+35zMPfGBhWq0+788kubq8sMvarQffpnf9/r6Gwy+e6guFBJl9ok
         0u/uk4ROR9eYDNmdFTYqVXOkEYzYrPO65DojdzYlK4b9fXDvtZvAzOSc4/TnNm/YGtzx
         ZiEg==
X-Forwarded-Encrypted: i=1; AKwUvBx+ILJPILQH5dcZMe35zaba8fHgCIbEhBMQvqDhymGn8XlIErLPwraXxkwxCqMZf1Z/40tpgyh4BIZXn/I=@lists.ozlabs.org
X-Gm-Message-State: AFuF++n02biTLHndlQcryDtIBCTstE9Bk+GmZG/MgAYyVa3q6vb7wyie
	uRji0Hx+13Eeqy5ScZzgLwoOx3sFRBnKb37norzJF9O9+wP4AtpqcL/o
X-Gm-Gg: AYBFou3zpHecsh2hHM9byDPwHgXew79ua5QsdKdi8SJaKr44QO/+GeyvgUjWn/Do9Wh
	YbFZFc1Xb12H7D3D8uLOHzMeeNJwA15/gMpICKFgGE+vdZ+q73AvGR6HLa5ZF2kfgs/dP7Wc2Xm
	+uLr7aSFTb57brxcT4NxWTv6Bb5ircFOeVCDwGl4GSSw1pOH2WWipOPbTglybzgCdP11EsL/iN3
	u6EZRbFOze3UFjnCoHyhnlXx4lgo9gBPISORgPmSW00Ef+hX004iFGpA37dQbIPJv7ipMqjS1ET
	2esCBg2aH6+YCrU38p5BVhKnG+ha2htPZhEtF4BlIRWS1mWaHfWVMJDmg+hEnZxMifGIYAy1K1E
	SvaqpvOS/QV76zZvXjhQxG40S//BD1SGl3QBPWxWj87rNW4k+DoVQK7dzNdnxZ9scv8LWerdU3e
	PR3J64jcwBXHe73RvstYwQsG+SVy+rMprKj3sSnJTR4OmkKUNKW9onSTZaizr2+unsqZ8O7ohQl
	vzCGIYEw0Jq3IuBFHXVoV8OdtNn4PK2MYSZJuio8OZ/
X-Received: by 2002:a05:693c:66d6:20b0:331:89d6:80e7 with SMTP id 5a478bee46e88-34004c897a8mr1482623eec.13.1790242599390;
        Thu, 24 Sep 2026 02:36:39 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e9bea11b8sm13745859eec.7.2026.09.24.02.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 02:36:39 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:06:32 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	sourabhjain@linux.ibm.com, adityag@linux.ibm.com, adri.vero.dev@gmail.com, 
	anushree.mathur@linux.vnet.ibm.com, chleroy@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com
Subject: Re: [PATCH v4] ppc/fadump: collect dump when CPU_STATE_DATA is less
 than reserved
Message-ID: <arTuiz2iOQkPdHwT@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260828094942.2439404-1-shivangu@linux.ibm.com>
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
In-Reply-To: <20260828094942.2439404-1-shivangu@linux.ibm.com>

On Fri, Aug 28, 2026 at 03:19:42PM +0530, Shivang Upadhyay wrote:
> During Fadump in Qemu VM, when maxcpus value is set to more than current
> cpus, following failure is observed.
> 
>     [    0.045806] [      T1] rtas fadump: Dump taken by platform is
>         incomplete (0)
> 
> This is because the CPU_STATE_DATA is allocated for maxcpus, while the
> data is only filled for current cpus. As per current implementation
> of Fadump, dumped_bytes and source_len for a region have to match,
> Which is failing for qemu's case, Even tough the dumped bytes are
> reported correctly for only the current cpus. After this /proc/vmcore
> generatition also fails.
> 
> Allowing dumped_bytes to be lesser than or equal to allocated length, for
> CPU_STATE_DATA Fadump region.
> 
> Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
> Closes: https://lore.kernel.org/all/5e66daf4-3f55-4044-94a5-4f50bb040849@linux.ibm.com/T/#u
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
> 
> Changelog:
> v4:
>     removed extra blank line.
> 
> v3: https://lore.kernel.org/all/20260827075803.2240934-1-shivangu@linux.ibm.com/
>     removed extra variable.
> 
> v2: https://lore.kernel.org/all/20260826125626.2108771-1-shivangu@linux.ibm.com/
>     Only allowing lesser size for CPU_STATE_DATE Fadump region.
> 
> v1: https://lore.kernel.org/qemu-devel/20260429065127.366813-1-shivangu@linux.ibm.com/
> 
> ---
>  arch/powerpc/platforms/pseries/rtas-fadump.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/rtas-fadump.c b/arch/powerpc/platforms/pseries/rtas-fadump.c
> index 3bb4ac2ab6cc..838e97c24308 100644
> --- a/arch/powerpc/platforms/pseries/rtas-fadump.c
> +++ b/arch/powerpc/platforms/pseries/rtas-fadump.c
> @@ -459,6 +459,8 @@ static int __init rtas_fadump_process(struct fw_dump *fadump_conf)
>  	/* Check if the dump data is valid. */
>  	for (int i = 0; i < be16_to_cpu(fdm_active->header.dump_num_sections); i++) {
>  		int type = be16_to_cpu(fdm_active->rgn[i].source_data_type);
> +		uint64_t bytes_dumped = be64_to_cpu(fdm_active->rgn[i].bytes_dumped);
> +		uint64_t source_len = be64_to_cpu(fdm_active->rgn[i].source_len);
>  		int rc = 0;
>  
>  		switch (type) {
> @@ -469,10 +471,20 @@ static int __init rtas_fadump_process(struct fw_dump *fadump_conf)
>  				pr_err("Dump taken by platform is not valid (%d)\n", i);
>  				rc = -EINVAL;
>  			}
> -			if (fdm_active->rgn[i].bytes_dumped != fdm_active->rgn[i].source_len) {
> +
> +			/*
> +			 * Make sure that dump is collected for entire region.
> +			 * CPU_STATE_DATA region is allowed to dump less than allocated space.
> +			 */
> +			if (!(bytes_dumped == source_len ||
> +			(type == RTAS_FADUMP_CPU_STATE_DATA && bytes_dumped <= source_len))) {
> +
Extra line here.
>  				pr_err("Dump taken by platform is incomplete (%d)\n", i);
> +				pr_debug("type -> %d, bytes_dumped -> %llx, source_len -> %llx\n",
> +					 type, bytes_dumped, source_len);
>  				rc = -EINVAL;
>  			}
Can bytes_dumped be greater than source_len? 
If yes then the error is misinformed that it's incomplete instead it's corrupted.
If No then shouldn't the internal check bytes_dumped <= source_len should handle it?

Regards,
Mukesh
> +
>  			if (rc) {
>  				pr_warn("Region type: %u src addr: 0x%llx dest addr: 0x%llx\n",
>  					be16_to_cpu(fdm_active->rgn[i].source_data_type),
> @@ -482,7 +494,7 @@ static int __init rtas_fadump_process(struct fw_dump *fadump_conf)
>  			}
>  			break;
>  		case RTAS_FADUMP_PARAM_AREA:
> -			if (fdm_active->rgn[i].bytes_dumped != fdm_active->rgn[i].source_len ||
> +			if (bytes_dumped != source_len ||
>  			    fdm_active->rgn[i].error_flags != 0) {
>  				pr_warn("Failed to process additional parameters! Proceeding anyway..\n");
>  				fadump_conf->param_area = 0;
> -- 
> 2.54.0
> 

