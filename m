Return-Path: <linuxppc-dev+bounces-18479-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D311093179
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2026 05:57:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcX0K120Nz2yY1;
	Fri, 20 Mar 2026 16:57:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773986257;
	cv=none; b=Ge3E8qz2oaxiAcxgchWqKZeBg79nODn1oHKDed0wZ1zkECU1KOdPlliUiFA2Jn2+rUV8/KAzeqq3XBmwSRaeZcZcqqc6OQtcL9q903bziezHFxWVClEDdAlbQ81nij9Xp0SsgwWXxZrUH54q5fUTZnToyAtuZA/oHYxKypf1bk8CcwJFKY7Xp3ChgubTJ65ABo8hq5bA8n0v7WLsts6BtyNuV+nt07eQoe8klg+3QPe1K+8tZK6lU3war9poilOI0LbkMU8V3dDd/zDNaYdTibO2CPxDSY7987Js57zbgTeID6H0YcEOeDxMI1T7jPFssdieW8PT/kZVbyNTOTQ8Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773986257; c=relaxed/relaxed;
	bh=zw3A+XW+0Hb7h3b98qb+9tmvwKpgjc7Ok93j+XXxU0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjaxlDPLEg3UmI/faw+SyPfv5qRLERyN2/d+ng3vjrMNEDZNOh8ypP/tejJKLtTn/2kS0GNuFgCEOApfkP1v/NzZpD6RBgAIXf5FOBlW7IFTT+O2SqDxjDlmEA9u7k8jqLOjY1kCOxhCkA3cIU2wzlhW50YZuT9b8bo3Q1/j2e1X88Q0fFrcKm4psOxUZN4BZo1EKXcOfgqHXbolfKqpbmMBzdMyp2QykG2Fg9ZOMhboyFOKi4pMrPvxLwAvDjnXlzfFstp98+YPCpbHvrKFVOI8tmGj1RQfe8kmCS2kH+urEE4YaC/pnH5xlKWNE7ohpSXUW8gu5SQK3GzIbRjTjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OiRYdPiy; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OiRYdPiy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcX0J1d7fz2yWK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 16:57:35 +1100 (AEDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-c741db5d610so95243a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 22:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773986254; x=1774591054; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zw3A+XW+0Hb7h3b98qb+9tmvwKpgjc7Ok93j+XXxU0M=;
        b=OiRYdPiyNLyBgWvabD+fT+n9qssQ2thf295z4u+4UZpk6qFw9hj9RNVBP6I3uDDDOR
         z+wHn4UK1bZKHyTcV7Ez+gFm+twP9CCj+QbzmIc7TpmpR16y16K2EOQ4dfN8BZpImE0L
         +fLLskDMgOgHnq6M/gLuLHaJO4UkD2Dbx5c0sgywQaEEZGat+ZBmS6CrE7RFr1JUW43B
         bI8Ft+3Rs2I2LcsFnv7lvuBsPzoT06m+i30zThbe3AZEuoZ2MHqbbYi0BrMKkEdsQQjL
         Pc8t27KkGPLG4KDYjGk2XHOvEQz3Kcb02iOpr48IQrBDSf7K2VyW8bI+sfGxqZ4iptJ2
         T/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773986254; x=1774591054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zw3A+XW+0Hb7h3b98qb+9tmvwKpgjc7Ok93j+XXxU0M=;
        b=EwjhMHpfCuTURFJk/dd6QT/bWLvxmeB2ntuy44rJ44WLFUIQGvJEAaZcZqlMpPUHSL
         deHHzkOSyWdS1RubT5Xeuhshg+PYJU/TNTOUjp3gBzj9ktDqZflY2RORDXSUjkKNiS2S
         FxUM3RaK9iQtYODvATm/L4f6k655/rlMlxt5u0hm7BI6LxxAxDPn/sZn+tBTdsPVc3PO
         075CiKNvM1CVU5CriiP1Q2td7ablyi9PVTaBT12MtRQn0cucQNnoREmzy2BVUPJOeN7G
         a1/Dcd2ZF1QFkcOV9Dbm1ENwpZa8Ddenb/Xo5M4wiyd4rllv4wUEoKuaKPpIygwcCFqC
         ZtCg==
X-Forwarded-Encrypted: i=1; AJvYcCV8JO/qZt9dh77Ya9gN/MOClcvPy8SsxiZISFWta4ferAa03aX2MICRXF/h/8b41cnMiKyZQzrReKQaUOw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw2j8ENB1Q2cGp1rGuK7PwENxeBAWIWkHnqCunjH3anPqwzYGb6
	W3E/eciXxr4gPkMlsmYyL/+fJ4fU+RVVxk6QDEor8KiZaByGo/5bJOOf
X-Gm-Gg: ATEYQzyQm8hS4lG70EMa6v7CJSZf1jhPwmHZEyA6CD8PrKXflW3bEQs3qBlTInlM1O3
	j+4kIv6nZ4lWYsooH4ERi1otiXZaO/x9iVZkiLx4QdBa8MS9F304wFuoyKqEX9FwH++HTr8o10K
	a4H0CnaCLlJEw7JgSu8cA/oyUMyjCDbJb47P4jSTfYpD30j6momjuixX2ESVqvbpHWMTTuzOWUK
	B6jfPIP6z3FrHBcHOMY3mLCXN6qGuJYCxtxQ7AIsrqc1IMXZ3yz8NqFU7A5O4j7WhZQySp7gkwo
	SirZO405Ha7WYIYQyvQIpxSr49wGkzs9Gq8FBszElJkF70Yzy35NyY7qkho+o9pQcPIlPFsTXhq
	JN5e6hfLhC2Syin+/ZSv8sb15e/1Tu7jCm2lZJis8x9Y6b8fAJ3VAZsIMxkYRycu78L5AW1cV3B
	eNoseRy9BH6Z+kPvAQwhGVAGduPO57HKGd2v8Q6U4LA2jDhxEZuGVmGBIsndbWrYDIMNMHqGs=
X-Received: by 2002:a17:902:e850:b0:2b0:6885:f1d4 with SMTP id d9443c01a7336-2b0827dda86mr17181685ad.39.1773986253598;
        Thu, 19 Mar 2026 22:57:33 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([49.207.193.112])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c74443ccbf0sm864411a12.26.2026.03.19.22.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 22:57:33 -0700 (PDT)
Date: Fri, 20 Mar 2026 11:27:26 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Nam Cao <namcao@linutronix.de>, "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, 
	Kees Cook <kees@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] Revert "powerpc/xive: Fix the size of the cpumask
 used in xive_find_target_in_mask()"
Message-ID: <abzhjYdhiD9Y6qVt@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260319033647.881246-1-ynorov@nvidia.com>
 <20260319033647.881246-2-ynorov@nvidia.com>
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
In-Reply-To: <20260319033647.881246-2-ynorov@nvidia.com>

On Wed, Mar 18, 2026 at 11:36:45PM -0400, Yury Norov wrote:
> This reverts commit a9dadc1c512807f955f0799e85830b420da47932.
> 
> The commit message states: 
> 
>     When called from xive_irq_startup(), the size of the cpumask can be
>     larger than nr_cpu_ids. This can result in a WARN_ON.
>     [...]
>     This happens because we're being called with our affinity mask set to
>     irq_default_affinity. That in turn was populated using
>     cpumask_setall(), which sets NR_CPUs worth of bits, not nr_cpu_ids
>     worth. Finally cpumask_weight() will return > nr_cpu_ids when passed a
>     mask which has > nr_cpu_ids bits set.
> 
> In modern kernel, cpumask_weight() can't return > nr_cpu_ids.
> 
> In inline case, cpumask_setall() explicitly clears all bits above
> nr_cpu_ids, see commit 63355b9884b3 ("cpumask: be more careful with
> 'cpumask_setall()'"). So, despite that cpumask_weight() is passed
> with small_cpumask_bits, which is NR_CPUS in this case, it can't
> count over the nr_cpu_ids.
> 
> In outline case, cpumask_setall() may set bits beyond the limit up to
> the next byte alignment, but in this case small_cpumask_bits is wired
> to nr_cpu_ids, thus making overcounting impossible.
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
> 
> I've added some explicit tests for cpumask_weight() to make sure:
> https://lore.kernel.org/all/20260319004349.849281-1-ynorov@nvidia.com/
> 
>  arch/powerpc/sysdev/xive/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
> index e1a4f8a97393..e91ec9036ad8 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -551,7 +551,7 @@ static int xive_find_target_in_mask(const struct cpumask *mask,
>  	int cpu, first, num, i;
>  
>  	/* Pick up a starting point CPU in the mask based on  fuzz */
> -	num = min_t(int, cpumask_weight(mask), nr_cpu_ids);
> +	num = cpumask_weight(mask);
>  	first = fuzz % num;
>  
>  	/* Locate it */
> -- 
> 2.43.0
> 
LGTM

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

