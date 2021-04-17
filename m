Return-Path: <SRS0=JxsT=JO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCB0C433B4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Apr 2021 12:36:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F5AA611AF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Apr 2021 12:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F5AA611AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FMsyj6jXcz3bp8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Apr 2021 22:36:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Q4RIughh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=Q4RIughh; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FMsyH2N0Rz2yx3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Apr 2021 22:36:23 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4FMsyG48Tfz9vG3;
 Sat, 17 Apr 2021 22:36:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1618662982;
 bh=VKZMySyOCrG8pbMyLfSSW/LSXdZWDZsO77f8t7ttDrs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Q4RIughheHFi3MTHZsfPqc5dwJP5WBjLLnmxr8mp8WE5lvd6z/NiEQKyRZUvz8GCE
 Otsx9ID43jyAw7WMBSkrwLrl/q2uKvndN0XV3K7ZdV3WGrSbisCvrZlXnl/8K8y/ne
 rO/K1go15ilF62jbul45FqZhOCFY88OJO8rkNGFBg0jnfZS6xCtQ1J2isMN36P5vE5
 EYLsCep29oZ6guG6jfvRO3lkGwEEGn/8mEPzmjKheTodoOnygWmb0W10XedI+4mD1o
 bDR+ohPuyjnDaXJNmKGfhSFyks05FJKIAb6pS7bAcgniZSzGiy1JPYAmx4Lu2xNqcN
 3v0FuFzangdIg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ganesh Goudar <ganeshgr@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/pseries/mce: Fix a typo in error type assignment
In-Reply-To: <20210416125750.49550-1-ganeshgr@linux.ibm.com>
References: <20210416125750.49550-1-ganeshgr@linux.ibm.com>
Date: Sat, 17 Apr 2021 22:36:21 +1000
Message-ID: <87fszpdr5m.fsf@mpe.ellerman.id.au>
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
Cc: Ganesh Goudar <ganeshgr@linux.ibm.com>, mahesh@linux.ibm.com,
 npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Ganesh Goudar <ganeshgr@linux.ibm.com> writes:
> The error type is ICACHE and DCACHE, for case MCE_ERROR_TYPE_ICACHE.

Do you mean "is ICACHE not DCACHE" ?

cheers

> Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/ras.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
> index f8b390a9d9fb..9d4ef65da7f3 100644
> --- a/arch/powerpc/platforms/pseries/ras.c
> +++ b/arch/powerpc/platforms/pseries/ras.c
> @@ -699,7 +699,7 @@ static int mce_handle_err_virtmode(struct pt_regs *regs,
>  		mce_err.error_type = MCE_ERROR_TYPE_DCACHE;
>  		break;
>  	case MC_ERROR_TYPE_I_CACHE:
> -		mce_err.error_type = MCE_ERROR_TYPE_DCACHE;
> +		mce_err.error_type = MCE_ERROR_TYPE_ICACHE;
>  		break;
>  	case MC_ERROR_TYPE_UNKNOWN:
>  	default:
> -- 
> 2.26.2
