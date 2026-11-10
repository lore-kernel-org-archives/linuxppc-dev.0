Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CFD606A320
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 22:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nq4mDmj+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPM2x4rcsz2y2h;
	Wed, 11 Nov 2026 09:36:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794333279;
	cv=none; b=hW5DjqvgmWQlUBpFPoogD3V8aOOwzRCwxTqKEQBIXljuoPQVkWAYezUCbSTOBLnY8Q0QSg1Dkla7zNOTo6/lgDoowPmQOrHHgPW94vwC8l1VC1XqhRl042vviy4L9m+6W7HhFJH3nH1eS/3LyRtdyCeVt3nILtpVC8Qpgi3btEBVGAQETz14FXjSJ9sIIbakqqBFXf0OPNVe86xOe6lA6uhIqBGtLSvc1mQ0Ctp7poJbmGhhoBSUG8o4TnIWurmhbvz6WQEvgqNDktgGihJCPraiFGmAesfkRRWUkbKnPaJvXc7fxNe/zhgqfgoxu7TYuSuNUx2jxOJRr2zha/4xnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794333279; c=relaxed/relaxed;
	bh=XvblCMGLEMwr6aPTNBYSVtI2iLfab9ugT+R+DDYhUcc=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=XiOAYXXt0GBCkPH7jWSe1f1egMNwFiOwkYVfbgB3yL3q4+dL3/HxRIvlPkW6HTX+gqM9mVwO7G80cXBhLUzLWG6+d8RMHHakToiA7BgMvBZuTO3Qk/aCWsRt37kKvcKOKFD8hejRZgyasHAn8kq3eXtkgFNof+/2c/fI9gFO35cxAAO/vXsxw4GEel53hAc8K/POrt/7zD8jU6vWLgmzuPVqt5dMv+OGrDMMQMzi2CM2C2usV9Cf0eaXEdG3YkqBv7VVCNug/6ke8TsK+rnG2wUuuDg2mxut9B6X6yHX6bt/AY2YbsCtz3VZP4+BEVeNB43jvfE7A/JXTUT3WlXWIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nq4mDmj+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122e; helo=mail-dl1-x122e.google.com; envelope-from=mdshahid03@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nq4mDmj+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122e; helo=mail-dl1-x122e.google.com; envelope-from=mdshahid03@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122e.google.com (mail-dl1-x122e.google.com [IPv6:2607:f8b0:4864:20::122e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPDn94Msbz2xNC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 04:54:36 +1100 (AEDT)
Received: by mail-dl1-x122e.google.com with SMTP id a92af1059eb24-170135e43c7so3634882c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 09:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794333274; x=1794938074; darn=lists.ozlabs.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XvblCMGLEMwr6aPTNBYSVtI2iLfab9ugT+R+DDYhUcc=;
        b=nq4mDmj+nlJ3sypBEeXlch71ZW+sSruDIkVqZsXhqDK5gio4PesyYsckD9jKy7lxd3
         LR8sXcknNU1m/i/ju+DqWEu4w+69x0zhp/0fkOFrl8JqkXJFPuyZhz/FMUOg838k1gOE
         s0A+7oR2D+fB0XiPv3BpiY4lYYTwgf2MlwEVBy0+iRB9N+vcPK6ujm+PArFKFrHz6+8x
         zPeLsoy+sO8Yoe4jNRb13Nw8/r048WYhWhCQ5bSyIPP8fJa+atPlpb5Y84QN23sYoSxe
         MTePaAheBDCTIJsVx0xTpKBqQwhVPffj9JD+laotU+W7w2WJSqAyKzK6TR9xlDwC5aQJ
         GYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794333274; x=1794938074;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XvblCMGLEMwr6aPTNBYSVtI2iLfab9ugT+R+DDYhUcc=;
        b=AfS0B3wJujWMqt8jBUYC0B2BjXTChrj567Id39F0kRDIyggsbasGf/oAA20XI56loU
         OM6/R9dfOV9Gx/k/h7jtPQlsRxjzgdC9rSbg2e6nYDKRZmTYpv+074AZMGO9FBVgyoeW
         jiVj6jbrhiOH+InFUjtuTSeU+BiogqiylaYw6GQ+6qlSivyktehAgeRJMpIfsnsbnCp6
         W7pZLQQbiF7WkyqT/xQ8dpOsdSlgfh1Rs89BohPZ+95qxQZLkcUYGXDYCRLP05O8ZoVS
         z79EZ8PsA+THiBd+MD4bh6MsvX8chQQ9etl0BJU4FL7bu8DjuOc44BWiA0luar6bP62K
         2OUA==
X-Forwarded-Encrypted: i=1; AL+hErEN0Jzzkpf1A3JEOcTNUxeeabWLGmGhvmUYym1pijaJoVxLia4+whOqO8BD2J6yQ/uGqAo3MYJkAKcUSuY=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+HfuPia2mXHonVKB8CvX+gIDy4N/0D62UW3lArboK1F1Hi5XxS
	Tj1psHwy+epVn1wjOP6wHIa7yG+Fys2jGSGRw0pYCCVXDwSL9cNgomJD
X-Gm-Gg: AYBFou3aI+GRkKDz5s0eoYp4Wy2kUaJFF5iJVAdkn26LGL15cxtUNRi56h9Sf9B2vVq
	UH6ql6QhDt4PXKTa6Mh2tGscrwddZZTGjiJB/SG6A7iIFQMDXcXryY7Fz5BsCR/AHVz8B/duSsk
	8f+mJbpeRDmMaKMQQ7we7Sf3w68zr3kfqcmE4SaLq/JOjZsXB3Dxqd1tVxJdSFsIjvmKjMuoemb
	E391yLQWR6RXuoO6MaYrgBIsQGmBwoASd1cuV078MSox7yfchSjTtymfVXHrt3mKrNMnR4TgWqI
	WoEymvG7HYnmI7f3d+OcEzwT85jJ5ItvKxK8nrTL228aBG0YjOxxaVlIZe4gZ9tQj/pVcOuVicf
	FBq51K2KVAMNQ1o6zql/dGE7bs87ol3P4n2O/f1HC6mA5MENpYoQYIDIWHW1ZGMlff+fFqdEz81
	42PTkMoqQoEHEQMSZawwm4hGBll4Z73X+637JWEVq/BTvlu+cpS154+zrSEDmRiNlBrpBXMNLuq
	572IZ9YsRXqpm4OCfyZnZltS5Et3nxxvWrm7DPyrM84Cxm7hM1o6p7OILaNIrZ0DQk5/O4rwW0R
	bvjFclmXZvoZrlOmfjPhQ0diM5dhAaIvpBxd0A==
X-Received: by 2002:a05:701b:2302:b0:1b3:a9c0:6a3e with SMTP id a92af1059eb24-1b3b5fff49bmr4373309c88.29.1794333273602;
        Tue, 10 Nov 2026 09:54:33 -0800 (PST)
Received: from [192.168.29.85] ([2405:201:8026:213e:7392:6aad:f285:27fa])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5890c0esm8649478c88.1.2026.11.10.09.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 09:54:33 -0800 (PST)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] powerpc/perf/vpa-dtl: use GFP_ATOMIC for DTL buffer
 allocation
From: mdshahid03@gmail.com
To: mdshahid03@gmail.com
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
 chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, 
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261102143719.165508-1-mdshahid03@gmail.com>
References: <20261102143719.165508-1-mdshahid03@gmail.com>
Date: Tue, 10 Nov 2026 23:24:14 +0530
Message-Id: <179433325437.153822.17133762919793487046.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Could you please review this patch and give your feedback,when time
permits.

Thanks
Shahid.

On 2026-11-02 20:07 +0530, mdshahid03@gmail.com wrote:
> From: Mohammad Shahid <mdshahid03@gmail.com>
> 
> The DTL buffer is allocated while holding dtl_global_lock, which
> is spinlock.
> 
> GFP_KERNEL allow direct memory reclaim and may sleep. Combining
> GFP_KERNEL with GFP_ATOMIC does not remove the direct reclaim.
> 
> Use GFP_ATOMIC alone to ensure the allocation does not sleep
> while the spinlock is held.
> 
> The issue is reported by script coccinelle call_kern.cocci.
> 
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
> ---
>  arch/powerpc/perf/vpa-dtl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/perf/vpa-dtl.c b/arch/powerpc/perf/vpa-dtl.c
> index 3e3d65b6c796..3d34417e6aae 100644
> --- a/arch/powerpc/perf/vpa-dtl.c
> +++ b/arch/powerpc/perf/vpa-dtl.c
> @@ -338,7 +338,7 @@ static int vpa_dtl_mem_alloc(int cpu)
>  	if (!dtl_cache)
>  		return -ENOMEM;
>  
> -	buf = kmem_cache_alloc_node(dtl_cache, GFP_KERNEL | GFP_ATOMIC, cpu_to_node(cpu));
> +	buf = kmem_cache_alloc_node(dtl_cache, GFP_ATOMIC, cpu_to_node(cpu));
>  	if (!buf) {
>  		pr_warn("buffer allocation failed for cpu %d\n", cpu);
>  		return -ENOMEM;
> -- 
> 2.43.0
> 
> 
> 



