Return-Path: <linuxppc-dev+bounces-23297-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C450C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 09:42:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqw5m6NRYz2xKh;
	Wed, 01 Jul 2026 19:42:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782898924;
	cv=none; b=U/JysF2Dnjpjs3h0k3HMJAdRTRmqPng1YCsZhR9lhxZb8oVKgkiqEaJzcH9iR/5oifDO8xC5PzOWJaeOKWf3EVXpxoVXhwvqnXE79k2XLBGrHHiF5J13wPedz8d2OGocAosrBZAKSy1KEv3muN1w88Eyx+MCSd+CswBWGoFJG4yClFWEoiJST4lOeRfInrTOX5lsNpgDRMu3S1oqkEvYwKcoU0L/H4Aq61GWq4nM5sk4VKMjCBX7T0zvwCrJvoO5Owe1ZDszYEM2+Ev2Q7PCLwj1iOfiaNSdUfQZcUrjmvXhpon52XpN12F0aNYGkrFsapwMdPud2+ekgQe7Ek3Y0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782898924; c=relaxed/relaxed;
	bh=3kyt08cDWSnOZr9J/cUulW1xc1hWpS96Fm4liJzYEto=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhucAxBj3FrjneAuHcoymb7mjKixUv1W5R02UcDnjLHNVHlzzirzDX1FPGowAS720ei3ZHfSoV6OcjS21dR8ebe1Uh4FbVFDeFveYmzGS6t5Kl6Tv9gH4NLRrGGb9QXXrqRsXR4X2R2RN+7FLEfn2N39jwlc1iZMLdkXci3SV4sxY3jruHn59RJ1isWtpvlc6n+tmMlNwao/+YFPLB8190FLPf8F3BlrkQTUMa0bqbDGDF0rPK2ErpgT7vz3/QmPw4bj9fWDvWedqC0VHF5QfeDZE9LOk5h3/LZlLD73fglVfq7MlaMErMgKDJW0tHU5h4thYeS5bVTNKSIrgwsNSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lSMI5HXz; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lSMI5HXz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqw5k5vlFz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 19:42:01 +1000 (AEST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-493b779003fso2011935e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 02:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782898917; x=1783503717; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kyt08cDWSnOZr9J/cUulW1xc1hWpS96Fm4liJzYEto=;
        b=lSMI5HXzXUueVydWva4o55R/GGFZ4THgPlwZYTfexYxn9VZ+nUMUGphLHv2Y9owXIp
         Oc37D4/EVNH8V012yT5Z9UfwrRFSOoVPgGM5Nr/ZkvTdoYvbr/JuGHtO0kUjOc7Pidy5
         YtgZ7eeNnTuLG1hVKEVWtvM9SyVWd8ObCwB4BpFt2DzGWNVR9zw42yV1jN31SyzM9OO1
         t9miyw17XxLGKPUeIoQithav/Yqqpqq8pc2GRbyHsxfv0lDed27BhHSKfK81mLQanbEA
         dlxbfbP9+0WJwur0E7LJyKTrVLG+tj8dtayARkW6Ogz8wp1l6Yo9hOVcDQO9Q90/lRCP
         X22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782898917; x=1783503717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3kyt08cDWSnOZr9J/cUulW1xc1hWpS96Fm4liJzYEto=;
        b=Ty45uijMjZzeNTyOaciDq+ls/RhTDTba5KcfcRYHGEbWoFP4ydrQCvsDpm+knDt8H7
         qDQ2xgaxQ55PpxWWHup/8/MREk4P4QorfcYKG9luN+0VuuUr6QW+nHQBODb9x2o6TaRx
         JlboirhVRrB60a/grC3gFzccb5AtSYF8XKGiO/NeqPOfYIm06SFV3WJBmSYnFRIrJTWm
         BM0lO693X+lZQybqa35O6Co0zr9+zIYHJmip4PGCDv7CbNpmdRGi+ixRhnWCtT6vYmPX
         Vo10wd+BSFzqqXJNTlf5frux6PYcDaMbAtWPmRCxSXBQFsrfcHN0FzC21uwLxbiuJS9B
         AgSg==
X-Forwarded-Encrypted: i=1; AFNElJ+50u+IAEO+ysu0HFkM1rLH+nwGxk+bq94h0uP7W25Wj0m1d1R0gvQuwiBJIGsypftMQE7WPbojAAWF4c8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw4DDtEmOyiDQySyKqbQCj0p1m6HD5Jct+VpK+mYoQMM6KqbvzA
	ypMkJmkCHc/ybDsmnbbo+lX/GmTZQhHZxxLg+POpX5fYk7V8b5zgciIB
X-Gm-Gg: AfdE7cnkjpL9Lt6TjdIzeFTwWiHIVYCtd0IPe2AuGudw+3Ehhy3deOTv8TCprKgtURZ
	HHwR7RMmToU5KY4BemrHsVimmlnuIYp5R0xqMDt6wvOsAhqmfoaHwZnZYCVwciT0+DEiw+u0Qng
	0tbSEaYx9wIabEFXbD9cpy07xZ9ycDlC6cYJ409jBksaCw/QdQw1FeBZ+vk1FnoAVYhyWM4OQZj
	2dCg2lDlV2vMSw9e1mKu87mkXYIyJjX8YUCv/FVFiPEV+p+/JVdjgFTlgeQ8SYSZy5s+nbHiasK
	TN2QedxRgO8X1a7g0gQNo4eoIcIn9VoIymklAvoy57evfpZFoE8NQc++F4lR/jbIgyIxN2Bxew/
	cnwv9AA+grtClDXdorPQW1Tlp79pW1fYstdwcfzB33+gE02B9apbJFvsT+iMoveky6cDWmYOXyf
	1umLnKHhClp4e4UGul7YbmSwc1wBk3XY2eTsas/b2l5LebsAXuY/mAGm8t
X-Received: by 2002:a05:600c:310f:b0:493:b6e2:1b10 with SMTP id 5b1f17b1804b1-493c2ba0bc7mr12358435e9.31.1782898916544;
        Wed, 01 Jul 2026 02:41:56 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4540aesm63473575e9.0.2026.07.01.02.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 02:41:55 -0700 (PDT)
Date: Tue, 30 Jun 2026 18:38:10 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Christophe
 Leroy (CS GROUP)" <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/dt_cpu_ftrs: Avoid separate strlen() in
 scan_callback()
Message-ID: <20260630183810.3287d10d@pumpkin>
In-Reply-To: <20260630154657.693088-2-thorsten.blum@linux.dev>
References: <20260630154657.693088-2-thorsten.blum@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jun 2026 17:46:56 +0200
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> Use the return value of strscpy() when copying the display name instead
> of checking the source string length with strlen() first.
> 
> Keep dt_cpu_name static but move it into dt_cpu_ftrs_scan_callback(),
> where it is assigned.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/powerpc/kernel/dt_cpu_ftrs.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
> index 3af6c06af02f..8d8e94e4d2bc 100644
> --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
> +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
> @@ -90,8 +90,6 @@ static void __restore_cpu_cpufeatures(void)
>  		init_pmu_registers();
>  }
>  
> -static char dt_cpu_name[64];
> -
>  static struct cpu_spec __initdata base_cpu_spec = {
>  	.cpu_name		= NULL,
>  	.cpu_features		= CPU_FTRS_DT_CPU_BASE,
> @@ -1069,6 +1067,7 @@ static int __init count_cpufeatures_subnodes(unsigned long node,
>  static int __init dt_cpu_ftrs_scan_callback(unsigned long node, const char
>  					    *uname, int depth, void *data)
>  {
> +	static char dt_cpu_name[64];
>  	const __be32 *prop;
>  	int count, i;
>  	u32 isa;
> @@ -1106,10 +1105,8 @@ static int __init dt_cpu_ftrs_scan_callback(unsigned long node, const char
>  	}
>  
>  	prop = of_get_flat_dt_prop(node, "display-name", NULL);
> -	if (prop && strlen((char *)prop) != 0) {
> -		strscpy(dt_cpu_name, (char *)prop, sizeof(dt_cpu_name));
> +	if (prop && strscpy(dt_cpu_name, (char *)prop) != 0)

That is different code.
The old code only did the copy if the new string was non-empty.
So you want to replace the strlen() with *(char *)prop != 0.
Checks for strlen() == 0 are silly (but surprisingly common).
A search might show up this gem:
	str[strlen(str)] = 0;

-- David


>  		cur_cpu_spec->cpu_name = dt_cpu_name;
> -	}
>  
>  	cpufeatures_setup_finished();
>  
> 


