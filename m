Return-Path: <SRS0=EHb9=YY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D93CA9EC7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Oct 2019 00:08:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1148D20856
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Oct 2019 00:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="AnCAfDD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1148D20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 473Qdh5TJ0zF59c
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Oct 2019 11:08:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::744;
 helo=mail-qk1-x744.google.com; envelope-from=joel.stan@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=jms.id.au header.i=@jms.id.au header.b="AnCAfDD6"; 
 dkim-atps=neutral
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 473Qb2115VzF54V
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2019 11:06:05 +1100 (AEDT)
Received: by mail-qk1-x744.google.com with SMTP id d13so4954724qko.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2019 17:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0li8VzqpFsQ/b63Xcg1C+N/uk9Yevq8DwZDh1ZCAyPg=;
 b=AnCAfDD6kapseXRPfRWQDvND9gyAVElPT6h62DxuGk1VF6vrQbrA1sXw/bMHkt9ycY
 yp6kuNymmX/ATYi8WGP7tfxs+V64ZKBAO+hQs6KWYth2G9QLwIs2F2puS+R4kOFZi8+j
 g9J/M23rZ39yYeXas5iRE8U/lSWKuIqe/XmdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0li8VzqpFsQ/b63Xcg1C+N/uk9Yevq8DwZDh1ZCAyPg=;
 b=MBfhFNipLXYgZKeFmWbcNEcFAIbr5X2irWUSioDSpHbL14OcsyTcbhPotPH2GPn/zX
 hGMokZSTLALZHydCvLRJVOsHDjsghf7AoKBmP/s4C/4jVPWqaScgsgrIB/0ZRSdi8wgp
 kp+r0dNSsC5zJyWRl+Ww6rmb9dRQkTvwBTy7fjUTVoRRpsECDI4I+ME/ex49WWTOHUhw
 SbDHWytknbFxTasIMwu1pvPAO1+L61WaY/LOIk6oN6DuzZpJPhziQC7l1/7SwbnlN9tW
 pwouZhopa5fcbaTWF/yjq+14myZ+yuz0mZI+P06+izxKUwA8BodCzVYLd1cXHmvbCC+k
 gMwA==
X-Gm-Message-State: APjAAAU9XMlNTJVFVNcY5uiP1nBD0D/q7JWMoUQ5emjqvHdHqSGZd34h
 Bjb1BQ8jTUz9sZeRM8VCshIVeoIM8vphEBxHcew=
X-Google-Smtp-Source: APXvYqxp1tJqDjfdpxPoNT94F1nQa51ElslA+sMSYvW++gja95tY+RNagmDf2v3YySCW1F3BZflwcasyPdjX/DYa0WE=
X-Received: by 2002:a05:620a:1244:: with SMTP id
 a4mr2740405qkl.208.1572480361858; 
 Wed, 30 Oct 2019 17:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191030073111.140493-1-ruscur@russell.cc>
 <20191030073111.140493-6-ruscur@russell.cc>
In-Reply-To: <20191030073111.140493-6-ruscur@russell.cc>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 31 Oct 2019 00:05:49 +0000
Message-ID: <CACPK8XfOLfpq6Em7nPe7ef-5D2U-feN4A5u_+K=RrBGX2x=5ew@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] powerpc/configs: Enable STRICT_MODULE_RWX in
 skiroot_defconfig
To: Russell Currey <ruscur@russell.cc>
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
Cc: ajd@linux.ibm.com, kernel-hardening@lists.openwall.com,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 30 Oct 2019 at 07:31, Russell Currey <ruscur@russell.cc> wrote:
>
> skiroot_defconfig is the only powerpc defconfig with STRICT_KERNEL_RWX
> enabled, and if you want memory protection for kernel text you'd want it
> for modules too, so enable STRICT_MODULE_RWX there.
>
> Signed-off-by: Russell Currey <ruscur@russell.cc>

Acked-by: Joel Stanley <joel@jms.id.au>

> ---
>  arch/powerpc/configs/skiroot_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/configs/skiroot_defconfig
> index 1253482a67c0..719d899081b3 100644
> --- a/arch/powerpc/configs/skiroot_defconfig
> +++ b/arch/powerpc/configs/skiroot_defconfig
> @@ -31,6 +31,7 @@ CONFIG_PERF_EVENTS=y
>  CONFIG_SLAB_FREELIST_HARDENED=y
>  CONFIG_JUMP_LABEL=y
>  CONFIG_STRICT_KERNEL_RWX=y
> +CONFIG_STRICT_MODULE_RWX=y
>  CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
>  CONFIG_MODULE_SIG=y
> --
> 2.23.0
>
