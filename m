Return-Path: <SRS0=c12Q=ID=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692A3C433DB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Mar 2021 06:04:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8623564ECF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Mar 2021 06:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8623564ECF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DsHHR0nFbz3dCy
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Mar 2021 17:04:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256 header.s=google header.b=ptEg+Kpz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=axtens.net (client-ip=2607:f8b0:4864:20::534;
 helo=mail-pg1-x534.google.com; envelope-from=dja@axtens.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256
 header.s=google header.b=ptEg+Kpz; dkim-atps=neutral
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DsHGz0N1nz3ckT
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Mar 2021 17:03:36 +1100 (AEDT)
Received: by mail-pg1-x534.google.com with SMTP id o38so636548pgm.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Mar 2021 22:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=rdp7PWtpXvmUGn3d3PjdggcXQvhRMcWQXUln99EH/9I=;
 b=ptEg+KpzK5q7G5e8Xc5XAj2KGg5K8RBpO0pSyKdxJFfxxUtzZ2k+onRAyIpuTWzg/z
 fUTLvxyoMDID/zJyxx1xQPyvw3ymbnUpJtF0nTbGSMvG8kXIWfhHhd+HBMMj4f2HgHwf
 y4qD+fJnU/a7TEotEBuNJKw2M1PnNDeTABg/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=rdp7PWtpXvmUGn3d3PjdggcXQvhRMcWQXUln99EH/9I=;
 b=UoN/4AM4j6gfO8edv5RXaZjvZh+3AxPwkqqA7oeSrLStY0nE+q++2vxPzr93VS5FBU
 kOZH/tQMNbY3lB/+wDIXuq0kREAPz6cVl9ppD3NM542VfmfS6ej7q2iP7DKtjWtjx1IU
 BEfOtuu8+fSqcfidMs1BfR36HwF7m0btb7Xh0uBX6aX4dxglygT2ALLbZ1qZkWZGQreE
 P5UkWmjExk/G/SV1xuBW6govd85W2mC5oluspX0doKL3ib5B8QQ1fRINHM2Mm99Xy6Mg
 tF9gZmWdBAONGPfVVQtUnql1Z/gJUS9zwIYs6OFgW3dfuUl+bWm2MXTRgzk3Hwb2+PvK
 Ih5Q==
X-Gm-Message-State: AOAM533VJwTlO7vf/xkkHA9vwuoA6dkJxiWGHL6VN39ZBqlsxiy1AFov
 pouPmu0C/1prze4FUXVeCoKSzw==
X-Google-Smtp-Source: ABdhPJzobPGfgfjOJ1ogHKuAyIGpCQ2a0M1OEPiYJqbfNPUPoJghFDf9SgyhPjVYsXkZDIoWh81vLg==
X-Received: by 2002:a63:2164:: with SMTP id s36mr7096239pgm.268.1614924211873; 
 Thu, 04 Mar 2021 22:03:31 -0800 (PST)
Received: from localhost
 (2001-44b8-1113-6700-7ad2-5bb3-4fd4-d737.static.ipv6.internode.on.net.
 [2001:44b8:1113:6700:7ad2:5bb3:4fd4:d737])
 by smtp.gmail.com with ESMTPSA id a19sm1111262pff.186.2021.03.04.22.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Mar 2021 22:03:31 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Nicholas Piggin <npiggin@gmail.com>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v2 08/37] KVM: PPC: Book3S 64: add hcall interrupt handler
In-Reply-To: <20210225134652.2127648-9-npiggin@gmail.com>
References: <20210225134652.2127648-1-npiggin@gmail.com>
 <20210225134652.2127648-9-npiggin@gmail.com>
Date: Fri, 05 Mar 2021 17:03:28 +1100
Message-ID: <87lfb287db.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 Fabiano Rosas <farosas@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Nick,

> Add a separate hcall entry point. This can be used to deal with the
> different calling convention.

Looks good to me, makes sense, passes checkpatch.

Reviewed-by: Daniel Axtens <dja@axtens.net>

Kind regards,
Daniel


> Reviewed-by: Fabiano Rosas <farosas@linux.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/kernel/exceptions-64s.S | 4 ++--
>  arch/powerpc/kvm/book3s_64_entry.S   | 6 +++++-
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index d956dd9ed61f..9ae463e8522b 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -1992,13 +1992,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
>  	 * Requires __LOAD_FAR_HANDLER beause kvmppc_interrupt lives
>  	 * outside the head section.
>  	 */
> -	__LOAD_FAR_HANDLER(r10, kvmppc_interrupt)
> +	__LOAD_FAR_HANDLER(r10, kvmppc_hcall)
>  	mtctr   r10
>  	ld	r10,PACA_EXGEN+EX_R10(r13)
>  	bctr
>  #else
>  	ld	r10,PACA_EXGEN+EX_R10(r13)
> -	b       kvmppc_interrupt
> +	b       kvmppc_hcall
>  #endif
>  #endif
>  
> diff --git a/arch/powerpc/kvm/book3s_64_entry.S b/arch/powerpc/kvm/book3s_64_entry.S
> index c1276f616af4..9572f759255c 100644
> --- a/arch/powerpc/kvm/book3s_64_entry.S
> +++ b/arch/powerpc/kvm/book3s_64_entry.S
> @@ -7,9 +7,13 @@
>  #include <asm/reg.h>
>  
>  /*
> - * This is branched to from interrupt handlers in exception-64s.S which set
> + * These are branched to from interrupt handlers in exception-64s.S which set
>   * IKVM_REAL or IKVM_VIRT, if HSTATE_IN_GUEST was found to be non-zero.
>   */
> +.global	kvmppc_hcall
> +.balign IFETCH_ALIGN_BYTES
> +kvmppc_hcall:
> +
>  .global	kvmppc_interrupt
>  .balign IFETCH_ALIGN_BYTES
>  kvmppc_interrupt:
> -- 
> 2.23.0
