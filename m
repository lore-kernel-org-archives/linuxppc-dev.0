Return-Path: <linuxppc-dev+bounces-28969-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6A2CA5FFC
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 14:43:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzfBz2PkQz30St;
	Wed, 07 Oct 2026 01:43:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::530"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791297819;
	cv=none; b=b3zlueEMtU5jl+E9drE9xH26FcRhFeDbiqWIroSL6hlvY+O/JtJ1d3EYGkbSQwpunLlmMyizyRKrYdsqM5hRwe9CbqsqMT+F2ZUb8iEBaZNun6c/v1fzFvvc5VJqBGGeSrd0ATL9S0PAcd7KBk3HyfqlKHHo8pSTYBFRyXLbilqATXsSaJfIZLKjITx89pelpqRjGyIgpO1yzhKFmDZRjJah1uxT7mUR6Q7V+P74lHbShTQHluG8gVy6kNRJENDhiU2pVilBtaZgz0IwgwTsIoCx9sj1JZFzdrSg42KEXRQlNuGPV9U/2FN+sfNs/Npg3LHuQ1+hF1BwUTRj0VsHQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791297819; c=relaxed/relaxed;
	bh=HvIOeflQ4PBMQ3b4EoTGtarANIPxgpboZRE7irIkx6w=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=HpYxbDc/jmK7DpEX6gZB/PhdJ21sSSmIu1Oac4ZeXAAoKw9P0ZtUHursp01DHGIdQngSFygVx6tUIRAGcfdUKoSzvg/+SNRKgodILhKkLUlHpIBUA/dpfAHs+AgE1/SrGcslpZXPP8u8yKAm/79Pda9aZRYWvWPlHFxL+MW6TbMVLjncMfXZx7Wxx6ujthlQs+u+EFXBhUDg+miKb2dL11afxLgHBUQw79R64/sHt9QqKnCeh3I8iZU+PZ8jhIDZ/8F+mJJ72ZlD9kFNZraoXRacWjC1nquniXqeZQQL4nAWVQUewCztEhZjaghBe+tW+Uzm3fM8bVv7Edo9pcHRtw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H/ipg6+s; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H/ipg6+s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzfBy0q23z2yfD
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Oct 2026 01:43:36 +1100 (AEDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-cc4dbcf2b85so1411288a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 07:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791297815; x=1791902615; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HvIOeflQ4PBMQ3b4EoTGtarANIPxgpboZRE7irIkx6w=;
        b=H/ipg6+sITnMOnsWNqPEwTBte2doluY/oVCicNODOf0cQV+ON1Y7Yf63wTV4GzKFsw
         N9AQQx7e2yiyy2FlSHmW32evwJNASynaVg6y7u0ZgELyM+/mvjdxQQDThcaExnZS/tTs
         hJWBVoy//9fzZ4XPPlBJJgrtVfATWeX8uV1V2XJRA8x5FWm8fyqThYfg8za09Auq2em2
         sByQBVIbrfx4CGGXMLTSQcBt2Ihp6HY+YeVac1+45F+QmeXvTKOhhGXb2OSwck6dG0cf
         FU60Jp9GPd+T/31phOW3ipXpzEVTnJ93fnLJdKUZA/PvQUHrmsALQPnKPEdY+44Me3Co
         6Sfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791297815; x=1791902615;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HvIOeflQ4PBMQ3b4EoTGtarANIPxgpboZRE7irIkx6w=;
        b=x6ltJjlFIJ6KSY5hNRi1Apitikuxmtl6pux1eWuPhsMWK+AFTavnM/TvisKEr77U93
         UI+60713VjMElyF9w4H7vJ0rvStFcTHQrMt14chAkE47J2Bq1KD4JE+I2uHUA5qmsidG
         RR2QpHjhffc9nO3XTjtUZ0V8XgU5PE8N25EcKXvyegrbJQxV+4j4M1QH9HpUbyTXLtoo
         oXSdfRkh5RtmgBgAfARMsh8ugiia+3l5b+alhziTPbSFQFsGSDdY0ByeYMCxkjjqMs3C
         ZB4/xe71/ndIbm9MiZz5yo0f2vSldb4aQbvYkZx+xK9GziIVHnK/iUKGGvb5y6loWE+7
         Wb3Q==
X-Forwarded-Encrypted: i=1; AKwUvBy3phZxzoDzJy4/YIwl8uy5kduc2rT5UtWE0OZohhy/JU1vlpfFe/QW7cnKe9nTbIK9jBdkQDeb47MzxaU=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIIqhMzv2p2ivgQz7+qnMP3t0rJ555B0edrDoezC4V5dKzUGtn+
	ADXlgGros2K5jD+ZVbC4OlANQs0NISeRSQtwpu+uNQ20CuE8ZYkQfFKI
X-Gm-Gg: AYBFou3JkIVs/msooBLG+0ZsHqWWVH8oLjc3PI5C/vJvV76PfZtI14HYwAhpPeohYIX
	83qBWuTEbMi/0kE12MlEbN8JiPseQyrKd29DpFnFkwymQwr5JjFIQIF+/pvI4KXNQFMeUvInQJ6
	NvTwng5zQoPKq8hINZ7zkPx1qsjOZ/NBK618Wkcq6O9uaQ+cpCfljLA8h2ZrawCeFNESQWHxlEq
	wQbg7ASqlMwUUbR61bE6VEyOUQ5KZVdl10MMdZGzU083q5CzTSf7jkYIAuC+a4gg8G00ihcnoRo
	DOGp2Aryh7G59yvaGB3B9KFOgVzcqBAOTcgzFtFffMimKEFxgKpzWrXIN1vjJgIHCTyDjJnZxki
	YaCQAbsradaz8y4OYbQ4aIt+m3MR7DSvAyLtxCgWu6y2SQT0DrjIy0MGzaH6Xl+WqBNQ+/aunBN
	yOcfCrmDgqh3UfvMFdZOuIYCQ+0IyDAnUkn+/7AvoOM0yQhhrEzCd9SSgtxjX+kCgEelDM4K/JT
	6emwZw3tUOlE+8HidtVs5MPQeCO2d4KBZJkHICKG8H/7uGGWaTsiw==
X-Received: by 2002:a17:90a:64f:b0:3a4:c895:562 with SMTP id 98e67ed59e1d1-3a893fdc3e7mr59252a91.62.1791297814580;
        Tue, 06 Oct 2026 07:43:34 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a7ad87874esm8986502a91.0.2026.10.06.07.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 07:43:33 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jyoti Gupta <jyoti@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, Amit Machhiwal <amachhiw@linux.ibm.com>, Sourabh Jain <sourabhjain@linux.ibm.com>, Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Subject: Re: [PATCH v3] powerpc/mpic: Fix memory leak of mpic on error paths
In-Reply-To: <20261006065945.391637-1-jyoti@linux.ibm.com>
Date: Tue, 06 Oct 2026 19:59:31 +0530
Message-ID: <4ieysy0k.ritesh.list@gmail.com>
References: <20261006065945.391637-1-jyoti@linux.ibm.com>
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

Jyoti Gupta <jyoti@linux.ibm.com> writes:

> mpic_alloc() allocates struct mpic (and optionally the protected
> sources bitmap) but does not free them when mpic_setup_error_int() or
> irq_domain_create_linear() fails, leaking the memory.
>
> Free the bitmap and the mpic in the common error path before
> dropping the device node reference.
>
> Fixes: 996983b75ceb ("powerpc/mpic: Search for open-pic device-tree node if NULL")
> Signed-off-by: Jyoti Gupta <jyoti@linux.ibm.com>
> ---
>
> Changelog
> ===========
> v2->v3:
>  + Introduce 'err_free_mpic' unwind label to cleanly free mpic and mpic->protected
>  + Link to v2: https://lore.kernel.org/all/20260930180919.335930-1-jyoti@linux.ibm.com/ 
>  
> ---
> ---
> arch/powerpc/sysdev/mpic.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 257886ec3f70..d799cf4da7bd 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -1389,7 +1389,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
>  		if (fsl_version >= 0x401) {
>  			ret = mpic_setup_error_int(mpic, intvec_top - 13);
>  			if (ret)
> -				return NULL;
> +				goto err_free_mpic;
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

I don't think the current change fixes leaked mappings for
!CONFIG_PPC_DCR or !MPIC_USES_DCR. So removing this comment completely
doesn't look correct.
And maybe unless we have the HW or a way to really validate this - not
sure whether it is worth working on a full error handling routine to
unmap all the mappings from ioremap().

In that case, in this patch at-least, I think we should still keep this
comment i.e.:

/*
 * FIXME: The code leaks the MPIC mappings here; this is very unlikely
 * to fail but it ought to be fixed anyways.
 */

With that comment fixed - the change looks good to me, as it still fixes
the memory leak in error handling path. So feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


>  	if (mpic->irqhost == NULL)
> -		return NULL;
> +		goto err_free_mpic;
>  
>  	/* Display version */
>  	switch (greg_feature & MPIC_GREG_FEATURE_VERSION_MASK) {
> @@ -1526,6 +1522,9 @@ struct mpic * __init mpic_alloc(struct device_node *node,
>  
>  	return mpic;
>  
> +err_free_mpic:
> +	bitmap_free(mpic->protected);
> +	kfree(mpic);
>  err_of_node_put:
>  	of_node_put(node);
>  	return NULL;
> -- 
> 2.55.0

