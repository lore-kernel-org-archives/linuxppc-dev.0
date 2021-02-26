Return-Path: <SRS0=07gb=H4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951C3C433DB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Feb 2021 05:45:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF09C601FD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Feb 2021 05:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF09C601FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DmzC61k9Tz3cnF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Feb 2021 16:45:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256 header.s=google header.b=A5KVh2kK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=axtens.net (client-ip=2607:f8b0:4864:20::52b;
 helo=mail-pg1-x52b.google.com; envelope-from=dja@axtens.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256
 header.s=google header.b=A5KVh2kK; dkim-atps=neutral
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DmzBX2g0Nz3cKP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2021 16:44:49 +1100 (AEDT)
Received: by mail-pg1-x52b.google.com with SMTP id o63so5580630pgo.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2021 21:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=E/dfagB4FaG4H2fCz24vVII4im/B44PZDtiXI570grU=;
 b=A5KVh2kKRgNRTjIZanwgr4I0zLaNYz+l4K8cZlpLknBHHs/8lzXfineS6EgtyHJyCK
 tonT4LUtOZEigF0UBUBj0D4OCH3oPpAkyceZl85i8H9OIFdltN8KAy7WRaFdCV6hsW6y
 iNLjCVZu5ul/FsSwNWe2t5d+CLugy1vSmIPQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=E/dfagB4FaG4H2fCz24vVII4im/B44PZDtiXI570grU=;
 b=ar3/SYhbOZm02xfGG2Bb1FgeGPftkgobYcTHDHynTcT6IFfiYbgfvVcqUITvSZI8lk
 otExmxAM+NVGzqCyyYi3jpy2qiEa0M9/6uZF7gwM3O63iqUZ+anhdftxg9fn2SJvioY1
 Ofx/VCEJ822OmKOai3ISfNjYdZRSTPpOPcaig8eNc/K6OCsgo+i5AYtmlaPgFyB1JN7K
 9wyLULIhV0y3g9LtGJ+XWoGrnO8uZKsa0/d8+hUq7+PVqzxGtjyVmzEqP4TdCRwNLZqG
 SiCSUBMgl4INlKjmARXmGr5x8EAiYY7F6Pw7QR1YDV54yaTIHI6uQpAE1YVY7Tt9cGki
 10iQ==
X-Gm-Message-State: AOAM532+If/Gzrhfih5Uwy0ghTVZ9KS332It1+uzQzH9v4lp5xBBagE1
 om2ORYiT7+D5zCCPLtaowmBGsw==
X-Google-Smtp-Source: ABdhPJwVMnjoMt72/ETIQr7b7Q2dwRDbkG/lb415Nm/jLHog2PYuZIsYRMlxff9LXLs4nPwtJHyVkA==
X-Received: by 2002:aa7:88c7:0:b029:1d1:4f1f:5fb6 with SMTP id
 k7-20020aa788c70000b02901d14f1f5fb6mr1647850pff.14.1614318287301; 
 Thu, 25 Feb 2021 21:44:47 -0800 (PST)
Received: from localhost
 (2001-44b8-1113-6700-7ad2-5bb3-4fd4-d737.static.ipv6.internode.on.net.
 [2001:44b8:1113:6700:7ad2:5bb3:4fd4:d737])
 by smtp.gmail.com with ESMTPSA id u3sm8772342pfm.144.2021.02.25.21.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Feb 2021 21:44:46 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Nicholas Piggin <npiggin@gmail.com>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v2 04/37] powerpc/64s: remove KVM SKIP test from
 instruction breakpoint handler
In-Reply-To: <20210225134652.2127648-5-npiggin@gmail.com>
References: <20210225134652.2127648-1-npiggin@gmail.com>
 <20210225134652.2127648-5-npiggin@gmail.com>
Date: Fri, 26 Feb 2021 16:44:39 +1100
Message-ID: <8735xj9yd4.fsf@linkitivity.dja.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> The code being executed in KVM_GUEST_MODE_SKIP is hypervisor code with
> MSR[IR]=0, so the faults of concern are the d-side ones caused by access
> to guest context by the hypervisor.
>
> Instruction breakpoint interrupts are not a concern here. It's unlikely
> any good would come of causing breaks in this code, but skipping the
> instruction that caused it won't help matters (e.g., skip the mtmsr that
> sets MSR[DR]=0 or clears KVM_GUEST_MODE_SKIP).

I'm not entirely clear on the example here, but the patch makes sense
and I can follow your logic for removing the IKVM_SKIP handler from the
instruction breakpoint exception.

On that basis:
Reviewed-by: Daniel Axtens <dja@axtens.net>

Kind regards,
Daniel

>
> Reviewed-by: Fabiano Rosas <farosas@linux.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/kernel/exceptions-64s.S | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index a027600beeb1..0097e0676ed7 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -2553,7 +2553,6 @@ EXC_VIRT_NONE(0x5200, 0x100)
>  INT_DEFINE_BEGIN(instruction_breakpoint)
>  	IVEC=0x1300
>  #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
> -	IKVM_SKIP=1
>  	IKVM_REAL=1
>  #endif
>  INT_DEFINE_END(instruction_breakpoint)
> -- 
> 2.23.0
