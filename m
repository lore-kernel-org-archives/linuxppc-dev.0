Return-Path: <SRS0=IFQS=LJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1538C48BE5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 13:42:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4038661369
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 13:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4038661369
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G48db4lWmz3cNM
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 23:42:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=rUlE1M2G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=rUlE1M2G; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G48YQ01lsz3ddh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jun 2021 23:39:05 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4G48YK4nstz9t54;
 Tue, 15 Jun 2021 23:39:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1623764341;
 bh=RwiNM5CQW9h5uaDmsze6JyeYY756VrLGT8x+mRIP0jo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=rUlE1M2GuK/gAHQlqr4VAnqBjlYFW5s8cyDCb0hCVNiYi58bfCjMTpVgx8S9SWrZI
 /g1tHJ0jkv4IoTon+sS1dHPA956yGuc9AJ0UOcCdY0VttHcNF2s5XrkuTCMopDn1q1
 52pwyUjbmOcQ78PHqJgIDPuoYvQwHxthp4FpX5rkJiKBRUr3x8CwoNNZFeYjUDQyGw
 iccwwwAzL0Bl40IkvpKjPkNzWXdOMRURBzO+QXBLAkhbSyvS5Ml+VJe8pIx8MvfhuD
 qE0RufpMcSJUxygYb7IcrVIgLYdqgu0BpnWAZmTP68NoJ8ceCyZzndMSojDO7/R1o4
 onhiApeZdbIZw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 03/11] powerpc/64s: avoid reloading (H)SRR registers
 if they are still valid
In-Reply-To: <20210610130921.706938-4-npiggin@gmail.com>
References: <20210610130921.706938-1-npiggin@gmail.com>
 <20210610130921.706938-4-npiggin@gmail.com>
Date: Tue, 15 Jun 2021 23:39:00 +1000
Message-ID: <87eed3tfgr.fsf@mpe.ellerman.id.au>
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin <npiggin@gmail.com> writes:
> diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
> index 2c57ece6671c..44526c157bff 100644
> --- a/arch/powerpc/kernel/fpu.S
> +++ b/arch/powerpc/kernel/fpu.S
> @@ -103,6 +103,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
>  	ori	r12,r12,MSR_FP
>  	or	r12,r12,r4
>  	std	r12,_MSR(r1)
> +	li	r4,0
> +	stb	r4,PACASRR_VALID(r13)
>  #endif
>  	li	r4,1
>  	stb	r4,THREAD_LOAD_FP(r5)

This didn't build for 64e. I changed it to:

#ifdef CONFIG_PPC_BOOK3S_64
	li	r4,0
	stb	r4,PACASRR_VALID(r13)
#endif


And similarly for vector.S.

cheers
