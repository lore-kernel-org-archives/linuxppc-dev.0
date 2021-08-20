Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B21BC4338F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Aug 2021 12:15:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55E9B6108F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Aug 2021 12:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 55E9B6108F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GrgZv6y2Cz3cXg
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Aug 2021 22:15:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=f9PP9ngn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=f9PP9ngn; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GrgZ84bCBz30FB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Aug 2021 22:15:12 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4GrgZ76jtVz9sSs;
 Fri, 20 Aug 2021 22:15:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1629461712;
 bh=609cs8/ZKSokRrE5mm7yk2+EH7BrmOScRj51bRNnHGc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=f9PP9ngn8mbR1XFMZkHqpg+kv5siFN27WlLpKJIciuS1c5jsP3d7q1Z80nfJDoUgP
 KzEkad0pPoYc6Gl45PfQ7OFetPHwpu+qU+K8wiCC7LZ8sIQzFhahLu1BohB5gPqG7f
 2d+HNjE2Sc7P0ojy3h+xUBOknEsCkFwOP5xQwySZRWJpx1N0257yV2GAqElDMvy9uo
 r2FwlCIRx/Xu5r0OAojiYEh7qJxaDn0VLDJDj/l376Z/bWt9O3lHzBc3tJ7y7ulqb9
 flrfj2Gqi4w9Q+3jCoIuMoEblOwyein3gZLuAqdJ+WP/mLHCxizfkK94S/x3Z28vy8
 980Kas9oeGpow==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc/32: indirect function call use bctrl rather
 than blrl in ret_from_kernel_thread
In-Reply-To: <91b1d242525307ceceec7ef6e832bfbacdd4501b.1629436472.git.christophe.leroy@csgroup.eu>
References: <91b1d242525307ceceec7ef6e832bfbacdd4501b.1629436472.git.christophe.leroy@csgroup.eu>
Date: Fri, 20 Aug 2021 22:15:11 +1000
Message-ID: <871r6oe2i8.fsf@mpe.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Copied from commit 89bbe4c798bc ("powerpc/64: indirect function call
> use bctrl rather than blrl in ret_from_kernel_thread")
>
> blrl is not recommended to use as an indirect function call, as it may
> corrupt the link stack predictor.

Do we know if any 32-bit CPUs have a link stack predictor or similar?

cheers

> This is not a performance critical path but this should be fixed for
> consistency.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/kernel/entry_32.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
> index 0273a1349006..61fdd53cdd9a 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -161,10 +161,10 @@ ret_from_fork:
>  ret_from_kernel_thread:
>  	REST_NVGPRS(r1)
>  	bl	schedule_tail
> -	mtlr	r14
> +	mtctr	r14
>  	mr	r3,r15
>  	PPC440EP_ERR42
> -	blrl
> +	bctrl
>  	li	r3,0
>  	b	ret_from_syscall
>  
> -- 
> 2.25.0
