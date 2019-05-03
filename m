Return-Path: <SRS0=37tr=TD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF9AC43219
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2019 00:40:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 296A42070B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2019 00:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="NaUy02ST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296A42070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44wCwb0md3zDqS6
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 May 2019 10:40:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::744; helo=mail-qk1-x744.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=jms.id.au header.i=@jms.id.au header.b="NaUy02ST"; 
 dkim-atps=neutral
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44wCs173WczDqJ5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2019 10:37:41 +1000 (AEST)
Received: by mail-qk1-x744.google.com with SMTP id z128so167792qkb.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 May 2019 17:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zYYNIRym+jRf/kiQQ0neIJi0585WWfL/gXMs7HG4low=;
 b=NaUy02STg1f6ePk/C+ewzo2g9ooygVmlovGl3/qBuEPd/mSDguMWKFWHEPYcirnOgo
 fkwUCAvmVqLegf2vK+a3UBbIt9uQ/TkEN87wtY2lp175pnWojkGdafyQCZbirdLSQQpq
 Rly0+v3oPLnfsMiELZY/gECfNQ41sAj5ybB/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zYYNIRym+jRf/kiQQ0neIJi0585WWfL/gXMs7HG4low=;
 b=dK+kvpOWJj/rKi4WmOaz41KnC64vU54Yd52zlhmbkBrRkpPg/6281IJlTCltShD++f
 GgMJuNMVCsycxOt+AkSNM0Tggx6jq6E6RdPaJ6Z/LQw/vaRsh6glHN616GVBiDqdqjzs
 gumcSrvR3lm5F3ExsjGnJ4OftkLr5k7FzTlbPI8N8PYpRtCvt83bW3nLLZuHrpsQY1jE
 ARdjCA4K7xAZRwy/AFonjHSaB5VYsk4ACNiGLfI+gHEY+xZPsa8VH/bHIvzgYN2A3xOs
 +WGcDy3uNEmJmN3b0kqHisuNSbawz6ziz64rwRHAwuBhprk3kswnnWW0ZTguP25bc3mF
 BX1g==
X-Gm-Message-State: APjAAAXQ7YJsvvrCRRnJfAjXlsODHDgCa7FtxY//RbC6Y+M6xeJNxcBm
 Y5hiKs+qogxIn2+wn3V9+VDqgu9OqiLPMO/9MnE=
X-Google-Smtp-Source: APXvYqwEkBap2Yusk1qQs7PCgSHLOCDElCtK52KGuOy1c6fh4Fdt4tI/+NTC6GlKOpH/05CIc4WAlUWtZB2WiNEspGs=
X-Received: by 2002:a37:88b:: with SMTP id 133mr5700321qki.25.1556843858024;
 Thu, 02 May 2019 17:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190502073947.6481-1-ruscur@russell.cc>
 <20190502073947.6481-2-ruscur@russell.cc>
In-Reply-To: <20190502073947.6481-2-ruscur@russell.cc>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 3 May 2019 00:37:26 +0000
Message-ID: <CACPK8XeGD85Yt1bZvuDo4LnYwn0xg15eDJoOep1JC3bg0s0uXA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] powerpc/mm: Warn if W+X pages found on boot
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
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, Rashmica Gupta <rashmica.g@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2 May 2019 at 07:42, Russell Currey <ruscur@russell.cc> wrote:
>
> Implement code to walk all pages and warn if any are found to be both
> writable and executable.  Depends on STRICT_KERNEL_RWX enabled, and is
> behind the DEBUG_WX config option.
>
> This only runs on boot and has no runtime performance implications.
>
> Very heavily influenced (and in some cases copied verbatim) from the
> ARM64 code written by Laura Abbott (thanks!), since our ptdump
> infrastructure is similar.
>
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> ---
> v2: A myriad of fixes and cleanups thanks to Christophe Leroy
>
>  arch/powerpc/Kconfig.debug         | 19 ++++++++++++++
>  arch/powerpc/include/asm/pgtable.h |  6 +++++
>  arch/powerpc/mm/pgtable_32.c       |  3 +++
>  arch/powerpc/mm/pgtable_64.c       |  3 +++
>  arch/powerpc/mm/ptdump/ptdump.c    | 41 +++++++++++++++++++++++++++++-
>  5 files changed, 71 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> index 4e00cb0a5464..9e8bcddd8b8f 100644
> --- a/arch/powerpc/Kconfig.debug
> +++ b/arch/powerpc/Kconfig.debug
> @@ -361,6 +361,25 @@ config PPC_PTDUMP
>
>           If you are unsure, say N.
>
> +config PPC_DEBUG_WX

The other architectures call this DEBUG_WX, in case you wanted to name
it the same.

> +       bool "Warn on W+X mappings at boot"
> +       select PPC_PTDUMP
> +       help
> +         Generate a warning if any W+X mappings are found at boot.
