Return-Path: <SRS0=1fX1=YX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE83BCA9EC5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Oct 2019 11:39:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F92A2083E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Oct 2019 11:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="JcbMjt25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F92A2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47361k259tzF47Z
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Oct 2019 22:39:38 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4735yn2ppmzF3YD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2019 22:37:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.b="JcbMjt25"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4735ym2XKNz9sPL;
 Wed, 30 Oct 2019 22:37:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1572435424;
 bh=Ukmow9kPMiVR7CRBSSLkfrTkYl/luRkDY70O/Ez8ScE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=JcbMjt25mjAa/p5TQmHhbYsbMDLQNAWLBgG+KisPaucipwHOlReXn1BMxdr8jiuF/
 TQEhrhfC6nyl4bbiSf04t8hQnvbWd1H4WYlJbNB+6bCe8Xjl1a5dHMhJVaA95XvaTa
 Ctkb/6vSdbVW+3EVC6zycS/u152N053ziA5BCVcW/Mvl0h8h2tEoAjTpvVgorhkZp8
 2Ap8Eh1+sYtQBgpbanoEYCf1FXizsuVA7Iqet41OaDAY0WovQWeV9v+oCfpkBPC9v3
 H4A2rbF05lv18BITDGxmR8CpVkPcCXCSePbv9QWGgcskjrfXANv0wPUA2DKxHv0ONE
 8COwKqErc3MZQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Richard Henderson <richard.henderson@linaro.org>,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH 5/6] powerpc: Mark archrandom.h functions __must_check
In-Reply-To: <20191028210559.8289-6-rth@twiddle.net>
References: <20191028210559.8289-1-rth@twiddle.net>
 <20191028210559.8289-6-rth@twiddle.net>
Date: Wed, 30 Oct 2019 22:37:01 +1100
Message-ID: <87v9s6bh2a.fsf@mpe.ellerman.id.au>
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
Cc: linux-s390@vger.kernel.org, x86@kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Richard Henderson <richard.henderson@linaro.org> writes:
> We cannot use the pointer output without validating the
> success of the random read.

You _can_, but you must not. </pedant>

> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/archrandom.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> diff --git a/arch/powerpc/include/asm/archrandom.h b/arch/powerpc/include/asm/archrandom.h
> index f8a887c8b7f8..ee214b153a71 100644
> --- a/arch/powerpc/include/asm/archrandom.h
> +++ b/arch/powerpc/include/asm/archrandom.h
> @@ -6,17 +6,17 @@
>  
>  #include <asm/machdep.h>
>  
> -static inline bool arch_get_random_long(unsigned long *v)
> +static inline bool __must_check arch_get_random_long(unsigned long *v)
>  {
>  	return false;
>  }
>  
> -static inline bool arch_get_random_int(unsigned int *v)
> +static inline bool __must_check arch_get_random_int(unsigned int *v)
>  {
>  	return false;
>  }
>  
> -static inline bool arch_get_random_seed_long(unsigned long *v)
> +static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
>  {
>  	if (ppc_md.get_random_seed)
>  		return ppc_md.get_random_seed(v);
> @@ -24,7 +24,7 @@ static inline bool arch_get_random_seed_long(unsigned long *v)
>  	return false;
>  }
>  
> -static inline bool arch_get_random_seed_int(unsigned int *v)
> +static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
>  {
>  	unsigned long val;
>  	bool rc;
> -- 
> 2.17.1
