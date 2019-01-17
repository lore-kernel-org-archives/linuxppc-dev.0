Return-Path: <SRS0=IbMY=PZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B1CC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 17:45:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57B3A20652
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 17:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odqiWu2X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B3A20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43gWgL1MgKzDqWL
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 04:45:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::141; helo=mail-lf1-x141.google.com;
 envelope-from=jrdr.linux@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="odqiWu2X"; 
 dkim-atps=neutral
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com
 [IPv6:2a00:1450:4864:20::141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43gWdM2gxGzDqs1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 04:43:16 +1100 (AEDT)
Received: by mail-lf1-x141.google.com with SMTP id u18so8430315lff.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 09:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bPK3vpUMsa41+yGP3TZAcnaVmjICNGsm5A82VYsal8k=;
 b=odqiWu2XPvyQ1HQzXKrPOVYPd4XAJpD4kqAUDSGhyldYzvfX+00KualOUDg1acdJAG
 4A2inNnT9K0Lq+SvozS4Oo1nuoCvMZR2GZv6SgWTFl2hLFujxvvyX9Wkx3RN1cHJpd+v
 JBKTLAYGc0yDD4/0MrJHgPVTSrim01ax2Q+Co8DtSG1pTBAu5D7YYJmY3aGG2/o5bOEp
 roi8obZLsYt3JD3PkFft1gkmeaV1/KdLzzw3W9PKAmY39o+vcbCw9qncep8KzNhJsKLD
 +BSLFGUxADJMIEHIxbPExQEI1by7ypyiiTb0wB4pvfa8AoBxIw0NIQ3KZJ0zIFpCcJ8p
 peBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bPK3vpUMsa41+yGP3TZAcnaVmjICNGsm5A82VYsal8k=;
 b=jMZjw5RybsGLFpzcRjgsyKcQKXNUBQ78SsGPxqb2VM/NH5GvOo2aApqHi1qAnQDgg0
 BNHWibqER1WyDXf9hFMukTRKePGqVqnEYYkik4n9sCOIlch9S82cxNvX7frugiSrik3q
 VpwQRCrKWVjHiqAaQMQHbLwmShIrrPffL+5/5cPd7Ofgb4PTmeSSeZZ0+jfWv1pZgUV0
 +uSmMV+8aYpEctMtyS+x5tdLLPYJ7RVjWmPH9Sc4jb007tpYhfQV1A4OmF8dcGKPN/jz
 3eQNhK5Em4U7DhoDve9C80Dr0HtkXsIZKV391oUVFyXjU60KHSVRTN7aHbHVJH63v4UI
 8/Vw==
X-Gm-Message-State: AJcUukfZ5/TsPPM6RkBzAzxy6PsaSahPjG4UhlBb/UsITPifqnSO8kjH
 FUJ1O59XTteKyIXj1exttfKjCNdxD5vcDrhCxZ4=
X-Google-Smtp-Source: ALg8bN4O4+46Yqxa1wZM6HnuSfhAGcKP6UY6DguBT/Qu1QdMPVFO7HFZqo1wwGV9WrGGsa1RzSFVsUiUS2P1nIVI9Io=
X-Received: by 2002:a19:d90c:: with SMTP id q12mr10430027lfg.24.1547746993042; 
 Thu, 17 Jan 2019 09:43:13 -0800 (PST)
MIME-Version: 1.0
References: <5c40aafc.1c69fb81.a0ba0.67a7@mx.google.com>
In-Reply-To: <5c40aafc.1c69fb81.a0ba0.67a7@mx.google.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Thu, 17 Jan 2019 23:17:09 +0530
Message-ID: <CAFqt6zZPXcX+Qk_CMNaBhs9=dTJuzv4nQzoj09xWLbMuT6NvDQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/cell: Remove duplicate header
To: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
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
Cc: Arnd Bergmann <arnd@arndb.de>, Brajeswar Ghosh <brajeswar.linux@gmail.com>,
 linux-kernel@vger.kernel.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 17, 2019 at 9:49 PM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> Remove linux/syscalls.h which is included more than once
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  arch/powerpc/platforms/cell/spu_syscalls.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/cell/spu_syscalls.c b/arch/powerpc/platforms/cell/spu_syscalls.c
> index 263413a..b95d6af 100644
> --- a/arch/powerpc/platforms/cell/spu_syscalls.c
> +++ b/arch/powerpc/platforms/cell/spu_syscalls.c
> @@ -26,7 +26,6 @@
>  #include <linux/syscalls.h>
>  #include <linux/rcupdate.h>
>  #include <linux/binfmts.h>
> -#include <linux/syscalls.h>
>
>  #include <asm/spu.h>
>
> --
> 2.7.4
>
