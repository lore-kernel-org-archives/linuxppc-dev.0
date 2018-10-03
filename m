Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73EBC00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 03:51:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 168A120878
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 03:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bc5NjcJi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 168A120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Q29y5c6fzF397
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 13:51:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bc5NjcJi";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="bc5NjcJi"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Q27M5zygzF38l
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 13:48:47 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id j23-v6so988885pfi.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Oct 2018 20:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4u2wlK4FTK14LlP8kQiJ4Lh7UZlA5Lx6PefT4tEMbYU=;
 b=bc5NjcJi3ZYLQEPVnjQYNnYVfOnuvlbM9x5XbBfa21QtCyYohfg+EAK3L8yu1QXItT
 sncsD8968PU0cK8vFAcrMUGNG6y8gxGsDKjKeLP5/ArEEpgRVZLxPMFwBKcNFDZuA9ll
 Usn7SL38VK8aQHKOgoTNi4Pab6EqlrEQi0LvDKf95fZEB+JYG5RDvaC6ny+e/Lg+Xmsm
 miMAXVIsrjSIsUQcvdUkptB/brXAQnpnOVrv531ChhU2U06p3nceJcJJYuoOQ2Gf/qzr
 2yDhmq6XYSf/fnc51zT7QmMYkM31aSLx8sgdw1Q10htnrzTs1lJqAYddNQKUW1go/InI
 cPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4u2wlK4FTK14LlP8kQiJ4Lh7UZlA5Lx6PefT4tEMbYU=;
 b=FvK7omlWnJyA3gB7dohk1rWE+qjobBhTE7o3FkjDGurzqxSMGc6pboy34h8SW8f8ae
 1MJEk21SynwPAngvSDE5e2kOTV0aC979q96pTqmngOHBOMyHjN9W09o4eWsTV8Ihu51B
 vmMMTf5lz/cc6n5CCSk70Xt6KnTUsUNTpDF/fpt0UzQG5Rf5tHLRMqU7qrGUHcgN/Ojo
 d8dVsgE3K5QklQHdcW1ogdDPpaXTZHfGUn7x3JGl1+oaqqgpTHVIq8NXLJi+l35HBAP2
 MrqlO/hjXdCXS6NE4u2ApMyUFmCPSR2KKTwtsc5Q4GOuOZgbE0j9q6A4JICni2i3Ok66
 9UUg==
X-Gm-Message-State: ABuFfohKhzRIYb6ACtf8opLMNJmilala32vYTCM7JotgSCrJakENXHxC
 XYxXpOk6FLzq1Gepj35oNw4=
X-Google-Smtp-Source: ACcGV62UaGAP1BxyHOIZ8SbZiGagtAHp/pvbYxPnYKnjL1lK04Y6G58L8s0D2e3qBHAibW4Z1X5wSg==
X-Received: by 2002:a63:e749:: with SMTP id
 j9-v6mr11162332pgk.246.1538538525202; 
 Tue, 02 Oct 2018 20:48:45 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (60-240-189-67.tpgi.com.au. [60.240.189.67])
 by smtp.gmail.com with ESMTPSA id 70-v6sm115414pfz.27.2018.10.02.20.48.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 02 Oct 2018 20:48:44 -0700 (PDT)
Date: Wed, 3 Oct 2018 13:48:36 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Anton Blanchard <anton@ozlabs.org>
Subject: Re: [PATCH] powerpc: Add doorbell tracepoints
Message-ID: <20181003134836.0dd85200@roar.ozlabs.ibm.com>
In-Reply-To: <20181003002957.7711-1-anton@ozlabs.org>
References: <20181003002957.7711-1-anton@ozlabs.org>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed,  3 Oct 2018 10:29:57 +1000
Anton Blanchard <anton@ozlabs.org> wrote:

> When analysing sources of OS jitter, I noticed that doorbells cannot be
> traced.
> 
> Signed-off-by: Anton Blanchard <anton@ozlabs.org>

Acked-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  arch/powerpc/include/asm/trace.h | 16 ++++++++++++++++
>  arch/powerpc/kernel/dbell.c      |  3 +++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/trace.h b/arch/powerpc/include/asm/trace.h
> index d018e8602694..eb9aa0f1561e 100644
> --- a/arch/powerpc/include/asm/trace.h
> +++ b/arch/powerpc/include/asm/trace.h
> @@ -54,6 +54,22 @@ DEFINE_EVENT(ppc64_interrupt_class, timer_interrupt_exit,
>  	TP_ARGS(regs)
>  );
>  
> +#ifdef CONFIG_PPC_DOORBELL
> +DEFINE_EVENT(ppc64_interrupt_class, doorbell_exception_entry,
> +
> +	TP_PROTO(struct pt_regs *regs),
> +
> +	TP_ARGS(regs)
> +);
> +
> +DEFINE_EVENT(ppc64_interrupt_class, doorbell_exception_exit,
> +
> +	TP_PROTO(struct pt_regs *regs),
> +
> +	TP_ARGS(regs)
> +);
> +#endif
> +
>  #ifdef CONFIG_PPC_PSERIES
>  extern int hcall_tracepoint_regfunc(void);
>  extern void hcall_tracepoint_unregfunc(void);
> diff --git a/arch/powerpc/kernel/dbell.c b/arch/powerpc/kernel/dbell.c
> index b6fe883b1016..5ec3b3835925 100644
> --- a/arch/powerpc/kernel/dbell.c
> +++ b/arch/powerpc/kernel/dbell.c
> @@ -18,6 +18,7 @@
>  #include <asm/dbell.h>
>  #include <asm/irq_regs.h>
>  #include <asm/kvm_ppc.h>
> +#include <asm/trace.h>
>  
>  #ifdef CONFIG_SMP
>  
> @@ -81,6 +82,7 @@ void doorbell_exception(struct pt_regs *regs)
>  	struct pt_regs *old_regs = set_irq_regs(regs);
>  
>  	irq_enter();
> +	trace_doorbell_entry(regs);
>  
>  	ppc_msgsync();
>  
> @@ -91,6 +93,7 @@ void doorbell_exception(struct pt_regs *regs)
>  
>  	smp_ipi_demux_relaxed(); /* already performed the barrier */
>  
> +	trace_doorbell_exit(regs);
>  	irq_exit();
>  	set_irq_regs(old_regs);
>  }
> -- 
> 2.17.1
> 

