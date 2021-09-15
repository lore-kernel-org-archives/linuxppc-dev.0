Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D987C433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Sep 2021 08:20:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 813BE61179
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Sep 2021 08:20:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 813BE61179
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H8Y6r0n1wz2yPZ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Sep 2021 18:20:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; secure) header.d=jms.id.au header.i=@jms.id.au header.a=rsa-sha256 header.s=google header.b=J0DDJu/c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::729;
 helo=mail-qk1-x729.google.com; envelope-from=joel.stan@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=jms.id.au header.i=@jms.id.au header.a=rsa-sha256
 header.s=google header.b=J0DDJu/c; dkim-atps=neutral
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H8Y666Gvcz2yHj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2021 18:19:26 +1000 (AEST)
Received: by mail-qk1-x729.google.com with SMTP id f22so2564247qkm.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2021 01:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kIBJ8wNlSomcWlEfQCfLH6DKLYq1ryWRKSRlIoGRw/g=;
 b=J0DDJu/cRLkXZjoOitMkM2qlhZpouO9rhijAawdOY717LRDIIGz3oM/KZ9QC7XZIxD
 Lc/11iC0GPg+HsCx6CeWS+OKG3Az6WDdGqM3PHL6zaxhWX0aqSZyrKHbyiV/8BT605Ny
 7o3Q02tZVtcwDPkQcC7mCJVyku5hqzMgFkRXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kIBJ8wNlSomcWlEfQCfLH6DKLYq1ryWRKSRlIoGRw/g=;
 b=Ru/Oq+278q9agYVnN0KbJOC+EdKctxZYgfFTg2SyWK0zuW1NJZ3Q0F2EmLnnu7kkd/
 g7I852+LYOJjKkqT2rXUETL+xyJ32x/KFJa2GsuRw19nj+WCZUiWbEmemF1zBg4VDZuC
 qhYZ3+6z586PDFvchFT4k31MAnpO6D5FfEKdCnx0+B4+mXqbc/Ee3yonsysGkyvtabbJ
 cSIC8aBGTf/SCecO/aqZZowKcqdAgZN5aIcxEhbrJo3KnnzOKNV/A0oRsjDX4Au3f45I
 3BmR8Rry2fD0VC0w1dpetYpaQfqipAKfu9h/kXq9GdwuV3dIJGaI1UMtfuMsXqcohmSq
 txXw==
X-Gm-Message-State: AOAM533tp108DJ0HpKG8BUpOWqbpW1QHFtk5p7wkjdZqcm0aED4Tvawe
 /vQhDSafZOz6RO/+KtDMKja41RqBa9ZI8xl+Ey1m/79Q2NA=
X-Google-Smtp-Source: ABdhPJz7ot6EFXk++shTcxF35oqEaXM3cFUvWNkimv5c7JlnzqTZDJb/DdtxT2iSbhrdp4/KtrnIIwm2/1LDPOTZTE4=
X-Received: by 2002:a37:64cc:: with SMTP id y195mr9089425qkb.291.1631693961280; 
 Wed, 15 Sep 2021 01:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210914143802.54325-1-hegdevasant@linux.vnet.ibm.com>
In-Reply-To: <20210914143802.54325-1-hegdevasant@linux.vnet.ibm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 15 Sep 2021 08:19:09 +0000
Message-ID: <CACPK8Xc2YLPzgTEJcwoiSsYzc6oe+ow-ULP+8zACnzjb_sVhKg@mail.gmail.com>
Subject: Re: [PATCH trivial v2] powerpc/powernv/dump: Fix typo in comment
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 14 Sept 2021 at 14:38, Vasant Hegde
<hegdevasant@linux.vnet.ibm.com> wrote:
>
> Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  arch/powerpc/platforms/powernv/opal-dump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/powernv/opal-dump.c b/arch/powerpc/platforms/powernv/opal-dump.c
> index 00c5a59d82d9..717d1d30ade5 100644
> --- a/arch/powerpc/platforms/powernv/opal-dump.c
> +++ b/arch/powerpc/platforms/powernv/opal-dump.c
> @@ -419,7 +419,7 @@ void __init opal_platform_dump_init(void)
>         int rc;
>         int dump_irq;
>
> -       /* ELOG not supported by firmware */
> +       /* Dump not supported by firmware */
>         if (!opal_check_token(OPAL_DUMP_READ))
>                 return;
>
> --
> 2.31.1
>
