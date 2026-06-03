Return-Path: <linuxppc-dev+bounces-21986-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7658ACD6E69
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 17:52:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVwHz5pLmz2ySJ;
	Thu, 04 Jun 2026 03:51:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780509119;
	cv=none; b=RM13nrPjuxHD2qPWh5l7XAJX48Jb2Vnh3/u5AsGtyGNuS08OVbnbypIAE4bAMa7vNkYVwgUO0CenhKd2X28vDXV09Pkb/IsiaDZK9dcgENIkaXB1LX2Y4a3v0YH5JHVyS8gP+RZCwxTEHp3p4C49GJh3URcOxCKSQlHToQd6c+WOxSdU3HaJgsCS1gcmJea89oU/j9tIeqFJZylOep7fa+OxGckPze468Heimp9glCbOYq0p+Mo0gJSWYpG3ywJXEoKG+e+obdH2T6Nv3HKlJ+quADN6/GS2dFa3cy+cB1etcLIH1inAtzB+LVyNhcxsTlD1B7Za5YN9Hug/UMBUzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780509119; c=relaxed/relaxed;
	bh=gpfG46WGWaa82hjGYd3X7v43g4yOeFprfWIIfOFd2DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSPlkPEmjGYdlK2xlc8w7ZPmuh871/mqVliTYCLBhoZknQMcOLTkj8/Nz7BITezgYst3lfH7T3suLBdFd83CWdUGvDoVYLQzlAG5B8ZGUJoOoap99AhcCN6ArgQhF+hk0LXvbBSJpTuCnQxgLMqRTdPd/+UqzcQCWF/gGbaXFZiSWdC/As++J/PFObh/6u50z92pGKHDBDkDvvZ6yXwNQaQ5ZsRTon7YC2zUi+cGJ/6avdIHvUnmWfXw0di2oq3TrTlkIeiXyfAoIxYy4u1SlXs9kBnL4FH80AtjPknRcrlL2/oxhoQpAm0zu1hazOAUGy93xMmD6Aj+THZg7NPY4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=njVx5r3r; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=njVx5r3r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVwHx5XW9z2yN8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 03:51:56 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2bf3781ca51so48390595ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 10:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780509114; x=1781113914; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gpfG46WGWaa82hjGYd3X7v43g4yOeFprfWIIfOFd2DA=;
        b=njVx5r3rMKn2PcOwMQSd83/7GjDzKzb6rQHAFYU5+1W48jRmVSkS877+vcb79yqpyX
         l4CgRCOTr8akM3ayYpWwDXaIPyETlj/bH8eIwPWvKDXy4beuYO7PO5wWCO8J2uMNjOlz
         1m8h/kqF9VRFA7bOk0MORkMmv0Xnn5ZEKrN6DLBpZepElccirdbKdmJdlMMryoO8yPtr
         8g7wzHmaO19gfT2J9NiBuoZ144x4S00t5/OkBC+NgTsjOFGPbJPpSKdkO6VBPzw7n5bg
         pEIBeMo48SFyVTMZ4CulyCr/9N2ptbXxwFEhsiUm0vLghctnM7M1nKaGstmuWd9DXg27
         XqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780509114; x=1781113914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpfG46WGWaa82hjGYd3X7v43g4yOeFprfWIIfOFd2DA=;
        b=eAHIR7ZFjGOfYTII6lePOeGc/i22GyP1CuMbrsH8KcBN6nmf+CB80p9UZ5jZ37IPnp
         O++GbocfPwURCBaqPWFLEieCbC4jlHf2iSpaLoxjiw/FpItfJSBMvG4gUB/NENQYvkC+
         p2nf+EOJvPxLpWpnlpUlGt81gcOiZ4EWYs3V4Yk0rSl+TKUXf8gaVdK17j05l54hCZOb
         hqmTZyuwrOWI6c3vrhveaxmLChEavDck5PakRIuvzGwUbOFqu10MC8wrikh/lR/RZ6xz
         UuFTpMx9ohfjI+rzYSX6Ldz+vsjWcaQUWLdGRX55upI0bAXxT+DBJf/Ch2DWYXeKfqz/
         oRFg==
X-Forwarded-Encrypted: i=1; AFNElJ98JXH3otzdXqPKBpxrNwTewudph7tDCU42aCpOZz5p+0yuh5s2KExXLChp02PeWDqY34aVxOY5jomKGFs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyexxTZ0hHLXkFW3PleXTkB7/VFJwE3ZNdxWtoPy0mpsF4Lade2
	uyIINt0EelS5jF7V6gr48fUfoFa0UvGSe/LOFiajIIpRh9SowFD7ZYRQ
X-Gm-Gg: Acq92OGjJsv9AjbV/hO3cve8rvyA4ep5XUzxh1j/B1gEpiUQA7O02rM+Cdc06oPQ5id
	f3b1oGrVGTTKIiZ/z6lrMQ9mSJeypwjlq2IYbEe4LtovE5z79xL029SFDpfR3nEhYAzsmKVKePK
	C7doNwSfFCMrK3iwXc/Q/bLR+fjRo0f9tOq90OszNnV8iaHXtibCuv5Z+3DLfWVrdBz6eHtvBT3
	dniK874vPSEmLhG2IczVaXM5zxr14EnUYeWeMUcqEQ26tSbMuckOxL8kBX3dWokIaQnYgUiv5UW
	/lcQskGS4Q5ml568EtdivQJRyzA5zTo6TtZHLiHB6AVE0KQnFq7uSgb43NyFSIIAHw9kPlgds71
	Erw8rZfACu5k80Zpua+NGYezreZ+6c7cSbw7NnO/xD9k8cOooMKfy0YtKXfMHznmpjayab01A2W
	EPMPPUeqIcmBr2DohLA3RRH0daMJl+U+lIUG39rGPKiPoV0z65KdisGaCh4SmMpnD8WhN7xWPQg
	G3WVPWEhHKTIffHKhj2
X-Received: by 2002:a17:902:e30e:b0:2c1:69cb:443c with SMTP id d9443c01a7336-2c169cb456cmr32598935ad.3.1780509113752;
        Wed, 03 Jun 2026 10:51:53 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d395sm45293415ad.17.2026.06.03.10.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 10:51:53 -0700 (PDT)
Date: Wed, 3 Jun 2026 23:21:48 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	peterz@infradead.org, tglx@kernel.org, christophe.leroy@csgroup.eu, 
	linux-kernel@vger.kernel.org, venkat88@linux.ibm.com
Subject: Re: [PATCH v2] powerpc/entry: Disable interrupts before irqentry_exit
Message-ID: <aiBpf2XgVdKY7Ied@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260603131054.216235-1-sshegde@linux.ibm.com>
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
In-Reply-To: <20260603131054.216235-1-sshegde@linux.ibm.com>

On Wed, Jun 03, 2026 at 06:40:54PM +0530, Shrikanth Hegde wrote:
> Venkat reported a panic on powerpc-next tree where GENERIC_ENTRY has
> been enabled.
> 
> kernel BUG at kernel/sched/core.c:7512!
> NIP  preempt_schedule_irq+0x44/0x118
> LR   dynamic_irqentry_exit_cond_resched+0x40/0x1a4
> Call Trace:
>  dynamic_irqentry_exit_cond_resched+0x40/0x1a4
>  do_page_fault+0xc0/0x104
>  data_access_common_virt+0x210/0x220
> 
> This happens since __do_page_fault ends up enabling the interrupts and
> it could take significant time such that need_resched could be set. This
> leads to schedule call in irqentry_exit leading to the bug.
> 
> There are many such irq handlers which enables the interrupts.
> Fix it by disabling the irq before calling irqentry_exit. The same
> pattern exists today in interrupt_exit_kernel_prepare.
> 
> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/7904105b-9dfa-4efd-a5ef-bc0276ed255d@linux.ibm.com/
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
> This applies on top on powerpc/next tree.
> base: 6ed60999d33d '("powerpc: Remove unused functions")'
> 
> v1->v2:
> Leave those BUG_ON alone since they are tracking the register
> state of userspace (Peter Zijlstra)
> v1: https://lore.kernel.org/all/20260603095521.198267-1-sshegde@linux.ibm.com/
> 
>  arch/powerpc/include/asm/entry-common.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
> index de5601282755..fc636c42e89a 100644
> --- a/arch/powerpc/include/asm/entry-common.h
> +++ b/arch/powerpc/include/asm/entry-common.h
> @@ -260,9 +260,10 @@ static inline void arch_interrupt_exit_prepare(struct pt_regs *regs)
>  		 * AMR can only have been unlocked if we interrupted the kernel.
>  		 */
>  		kuap_assert_locked();
> -
> -		local_irq_disable();
>  	}
> +
> +	/* irqentry_exit expects to be called with interrupts disabled */
> +	local_irq_disable();
>  }
>  
>  static inline void arch_interrupt_async_enter_prepare(struct pt_regs *regs)
> -- 
> 2.47.3
> 
LGTM

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

