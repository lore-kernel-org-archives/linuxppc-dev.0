Return-Path: <SRS0=KHR7=NP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF04C4338F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Aug 2021 14:48:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 782D26127B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Aug 2021 14:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 782D26127B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GvBnT5rRzz2yKM
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Aug 2021 00:48:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.a=rsa-sha256 header.s=20150623 header.b=wvdmGiCM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=paul-moore.com
 (client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com;
 envelope-from=paul@paul-moore.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=paul-moore-com.20150623.gappssmtp.com
 header.i=@paul-moore-com.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=wvdmGiCM; dkim-atps=neutral
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GvBmm2ytTz2xb8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Aug 2021 00:48:06 +1000 (AEST)
Received: by mail-ej1-x62b.google.com with SMTP id x11so45018341ejv.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Aug 2021 07:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YnPUVfUgYHSOqP3q+uA993Pwu7eBA1Aa+0lCfjRXQXc=;
 b=wvdmGiCMZOR/4dUX6jTk0PRzMkxcXwKO+u9ksozwcU3gZu4J6vrO1h3lhyVdbQ5zf2
 y6AZGFe2x3XJDft1AvQhWGewc1mXepvTnS6D1h4zMJm5o64B9NOGxg5VGhn+vQbDIkH3
 NCWU48hDd1JeV8fVtc9as5+f8hSr+OGBPHu08basolmrcnOyxVrd40vxBYHwmCA7NtIK
 SFi9e42xBS00Puy5lK8vRveNaIspZfdRiJ92ff9LUuBa9KZI/55adtF8KVoRu4oBMxsB
 ghDxErVWQWiClWpoEtx650mpFCQf0my+3zbNb+PWwV+M0mfWVj02yQl5JW/YWYapk4XV
 ruvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YnPUVfUgYHSOqP3q+uA993Pwu7eBA1Aa+0lCfjRXQXc=;
 b=o03NefRgkrHnAAqUChfmvlr7vpb1dA4ru2hino3Oyd/ZBMpIqtFkxWyTbqLlAKkb9Y
 XlKCwA3gi5RT3Mk4pNNuHGko0ij3EfuDJlRtxoLT3Nyv0F+L1q44Easwv9h23YKxFUa6
 f1baQlJy9i6WRbuhUGAycBTg1jmyBj1V9+pzk+qx95Ctk5hAkoT2rrcApN77ICqWk0mB
 hK2PeCqjn+c7hTm6E6ekdUZMXN/unYItJuQyMT2xLwAJPplkDGT03IxvqxhRbd7xFAAM
 5JpsLraxNZxCYqwCdCWl28p2gFil7IDRdEOKUVDohCqh5pcc7M2ytK4tA8NMQRuR3US5
 nT+Q==
X-Gm-Message-State: AOAM533H0DjZya9jqFzSzTtR31F8UwTIRXtOjw26beIw547sA0WNOFPh
 dw9k+YuAp9U9ZAQs81VidaDcpuJJlHE2DmOywmiW
X-Google-Smtp-Source: ABdhPJxxDRaVp902LyjVDf+++7H1g3lySJYE9BZ6QHXVbA1LPabtUCfvWTFh7RVPbzZMkPo7LlN4qe4Aq61ZtmMifrk=
X-Received: by 2002:a17:906:2755:: with SMTP id
 a21mr40640335ejd.488.1629816480152; 
 Tue, 24 Aug 2021 07:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <a4b3951d1191d4183d92a07a6097566bde60d00a.1629812058.git.christophe.leroy@csgroup.eu>
In-Reply-To: <a4b3951d1191d4183d92a07a6097566bde60d00a.1629812058.git.christophe.leroy@csgroup.eu>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 24 Aug 2021 10:47:49 -0400
Message-ID: <CAHC9VhR3E6=5HmRaWMWbp4WHsua02niwnzaRGM3tLqd4Y4LA6w@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] powerpc/audit: Convert powerpc to
 AUDIT_ARCH_COMPAT_GENERIC
To: Christophe Leroy <christophe.leroy@csgroup.eu>
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
Cc: linux-kernel@vger.kernel.org, Eric Paris <eparis@redhat.com>,
 linux-audit@redhat.com, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Aug 24, 2021 at 9:36 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> Commit e65e1fc2d24b ("[PATCH] syscall class hookup for all normal
> targets") added generic support for AUDIT but that didn't include
> support for bi-arch like powerpc.
>
> Commit 4b58841149dc ("audit: Add generic compat syscall support")
> added generic support for bi-arch.
>
> Convert powerpc to that bi-arch generic audit support.
>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Eric Paris <eparis@redhat.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> Resending v2 with Audit people in Cc
>
> v2:
> - Missing 'git add' for arch/powerpc/include/asm/unistd32.h
> - Finalised commit description
> ---
>  arch/powerpc/Kconfig                |  5 +-
>  arch/powerpc/include/asm/unistd32.h |  7 +++
>  arch/powerpc/kernel/Makefile        |  3 --
>  arch/powerpc/kernel/audit.c         | 84 -----------------------------
>  arch/powerpc/kernel/compat_audit.c  | 44 ---------------
>  5 files changed, 8 insertions(+), 135 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/unistd32.h
>  delete mode 100644 arch/powerpc/kernel/audit.c
>  delete mode 100644 arch/powerpc/kernel/compat_audit.c

Can you explain, in detail please, the testing you have done to verify
this patch?

-- 
paul moore
www.paul-moore.com
