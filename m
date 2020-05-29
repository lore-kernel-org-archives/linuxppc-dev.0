Return-Path: <SRS0=W4Hs=7L=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65472C433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2020 04:05:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC2F320723
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2020 04:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="nX3d4InQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC2F320723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Y9w86Dj7zDqbD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2020 14:05:44 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49Y9sn3SJszDqZF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2020 14:03:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=nX3d4InQ; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49Y9sj5HBgz9sSp;
 Fri, 29 May 2020 14:03:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1590725021;
 bh=vH7zLNvGS4BorTtKtZ0BBnktSfHbH6n56wdkXjECHz8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=nX3d4InQK8Spy3nzTCnyC/tJh184bN8xV/DKJUXBHc+k91/ltQT0HX1oj9OKljgJR
 OLBlxEdkOMO2UH1U/HXyF59BNbJ1RlJvukmPZiqTcBC3xgs2VkgbFhx8ixuSyr2KAT
 M0lkxxj9Oty+elmuy31hudyP/Ep7VWnZf9VzI9CiFbT5otkmKHKXv7l6h/LaaV/QzN
 8eO407IHRENzXzexTNDi6CRDn32/fao2j1rE4WSG2wgP+/1wTTIHfV4mjUT2E7Gg8H
 GjOPSpJ7fYmHNQQ7hYnWNHJ/KLadbDTjUeMNQ6aqugzEkMlpaXsWHPtlHP9aGiwJVt
 kRxxe8XPoB1jw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Yi Wang <wang.yi59@zte.com.cn>
Subject: Re: [PATCH] powerpc/nvram: Replace kmalloc with kzalloc in the error
 message
In-Reply-To: <1590714135-15818-1-git-send-email-wang.yi59@zte.com.cn>
References: <1590714135-15818-1-git-send-email-wang.yi59@zte.com.cn>
Date: Fri, 29 May 2020 14:04:01 +1000
Message-ID: <87r1v3idzi.fsf@mpe.ellerman.id.au>
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
Cc: wang.yi59@zte.com.cn, tony.luck@intel.com, keescook@chromium.org,
 wang.liang82@zte.com.cn, gregkh@linuxfoundation.org, anton@enomsg.org,
 linux-kernel@vger.kernel.org, paulus@samba.org,
 Liao Pingfang <liao.pingfang@zte.com.cn>, xue.zhihong@zte.com.cn,
 ccross@android.com, tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org,
 allison@lohutok.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Yi Wang <wang.yi59@zte.com.cn> writes:
> From: Liao Pingfang <liao.pingfang@zte.com.cn>
>
> Use kzalloc instead of kmalloc in the error message according to
> the previous kzalloc() call.

Please just remove the message instead, it's a tiny allocation that's
unlikely to ever fail, and the caller will print an error anyway.

cheers

> diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
> index fb4f610..c3a0c8d 100644
> --- a/arch/powerpc/kernel/nvram_64.c
> +++ b/arch/powerpc/kernel/nvram_64.c
> @@ -892,7 +892,7 @@ loff_t __init nvram_create_partition(const char *name, int sig,
>  	/* Create our OS partition */
>  	new_part = kzalloc(sizeof(*new_part), GFP_KERNEL);
>  	if (!new_part) {
> -		pr_err("%s: kmalloc failed\n", __func__);
> +		pr_err("%s: kzalloc failed\n", __func__);
>  		return -ENOMEM;
>  	}
>  
> -- 
> 2.9.5
