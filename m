Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FB7C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 09:36:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2282520659
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 09:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="cG3zM3rO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2282520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dSzW36QczDqR5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 20:36:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::d41; helo=mail-io1-xd41.google.com;
 envelope-from=dvyukov@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="cG3zM3rO"; 
 dkim-atps=neutral
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43dSxY1nxYzDqQx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 20:35:06 +1100 (AEDT)
Received: by mail-io1-xd41.google.com with SMTP id m19so17099209ioh.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 01:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Pn0/rZ2B5GkSLOkvstRq19Y+ZB+KVKjQ5D4UTrTEcFQ=;
 b=cG3zM3rOJqP9xq8n8LMwEKTXJUQ4xh2O+zaaNyos6gkTdiT0UhD5YRj4zebrVQCK79
 lTszCU7lJZs+wRyNh/NZEjWDrwgO2XiRVx6xv0Ra/FQU9iclaLSOhmErIuO/HUVBzWr2
 nP3swD1jtKwthtzn03IXwPV9QFMWMIlVuHp1iQ0d6KMQztjWe8TBkSZdAUMrRjMh6WUN
 nStPiAZ/dUsrozxjVmfHco6C7wBa+7K1swBrAUHWvFubg/nw/9+fY4NJgHI7e9+NBb5/
 WSU1YAmgtOKm2strY0meX98AhNuQy8M3JmpV81bLo/b6PGT3C4i+VArU5y5WdeeW+yk+
 q0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Pn0/rZ2B5GkSLOkvstRq19Y+ZB+KVKjQ5D4UTrTEcFQ=;
 b=fGkNyEvallsDxVNqHpqUlTazAhCY4uf9cYjLO4Koc8aKCB2GT3wr1QIIzTxOfI9sEm
 EUi/vH13gteAQeB6gvkFDPIlqgRlhXkKwKlB0iugWC892FcG4FUaImTZJJu+0XObI/Mg
 5XvIRmmKsiWYtlQKhjqKchtsEwFLLQFYpI4F7SdJScRcMJPcgeqRXT7kbpofITGKnGGk
 YQzdPstgUxMEWyoBrnA7CD94rc0ayoVl7XO9ZMXk7iodG4Q1cOo4/RJmH2j+Pw6mOGlt
 TL/CBn4X7f+eOO9R3NNsVpjyrGYAwUka7E9nprhMFoRkYEi0howZyGa2C6mg1g0zX6l9
 EQyQ==
X-Gm-Message-State: AJcUukcl78sAlaakSKNEQ+2tWw6EyVxbXRavWQjIhL+fc/n77X61RYfW
 ReAYrOrvLSbT4lFzdskjcfOVgUd3n4v1camIbecQOA==
X-Google-Smtp-Source: ALg8bN4Izjtfz8Gtik6EdgfSYlWSdQko5wrdsb98M1TQUO3p0k+tlZJCo9+xkTjkJb9IBNvEfs6/1WGPTInaXLkvDLg=
X-Received: by 2002:a6b:fa01:: with SMTP id p1mr9451772ioh.271.1547458504276; 
 Mon, 14 Jan 2019 01:35:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1547289808.git.christophe.leroy@c-s.fr>
 <0c854dd6b110ac2b81ef1681f6e097f59f84af8b.1547289808.git.christophe.leroy@c-s.fr>
In-Reply-To: <0c854dd6b110ac2b81ef1681f6e097f59f84af8b.1547289808.git.christophe.leroy@c-s.fr>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 14 Jan 2019 10:34:52 +0100
Message-ID: <CACT4Y+aEsLWqhJmXETNsGtKdbfHDFL1NF8ofv3KwvQPraXdFyw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] powerpc/mm: prepare kernel for KAsan on PPC32
To: Christophe Leroy <christophe.leroy@c-s.fr>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Linux-MM <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>,
 kasan-dev <kasan-dev@googlegroups.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Jan 12, 2019 at 12:16 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
&gt;
&gt; In kernel/cputable.c, explicitly use memcpy() in order
&gt; to allow GCC to replace it with __memcpy() when KASAN is
&gt; selected.
&gt;
&gt; Since commit 400c47d81ca38 ("powerpc32: memset: only use dcbz once cache is
&gt; enabled"), memset() can be used before activation of the cache,
&gt; so no need to use memset_io() for zeroing the BSS.
&gt;
&gt; Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
&gt; ---
&gt;  arch/powerpc/kernel/cputable.c | 4 ++--
&gt;  arch/powerpc/kernel/setup_32.c | 6 ++----
&gt;  2 files changed, 4 insertions(+), 6 deletions(-)
&gt;
&gt; diff --git a/arch/powerpc/kernel/cputable.c
b/arch/powerpc/kernel/cputable.c
&gt; index 1eab54bc6ee9..84814c8d1bcb 100644
&gt; --- a/arch/powerpc/kernel/cputable.c
&gt; +++ b/arch/powerpc/kernel/cputable.c
&gt; @@ -2147,7 +2147,7 @@ void __init set_cur_cpu_spec(struct cpu_spec *s)
&gt;         struct cpu_spec *t = &amp;the_cpu_spec;
&gt;
&gt;         t = PTRRELOC(t);
&gt; -       *t = *s;
&gt; +       memcpy(t, s, sizeof(*t));

Hi Christophe,

I understand why you are doing this, but this looks a bit fragile and
non-scalable. This may not work with the next version of compiler,
just different than yours version of compiler, clang, etc.

Does using -ffreestanding and/or -fno-builtin-memcpy (-memset) help?
If it helps, perhaps it makes sense to add these flags to
KASAN_SANITIZE := n files.


>         *PTRRELOC(&cur_cpu_spec) = &the_cpu_spec;
>  }
> @@ -2162,7 +2162,7 @@ static struct cpu_spec * __init setup_cpu_spec(unsigned long offset,
>         old = *t;
>
>         /* Copy everything, then do fixups */
> -       *t = *s;
> +       memcpy(t, s, sizeof(*t));
>
>         /*
>          * If we are overriding a previous value derived from the real
> diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
> index 947f904688b0..5e761eb16a6d 100644
> --- a/arch/powerpc/kernel/setup_32.c
> +++ b/arch/powerpc/kernel/setup_32.c
> @@ -73,10 +73,8 @@ notrace unsigned long __init early_init(unsigned long dt_ptr)
>  {
>         unsigned long offset = reloc_offset();
>
> -       /* First zero the BSS -- use memset_io, some platforms don't have
> -        * caches on yet */
> -       memset_io((void __iomem *)PTRRELOC(&__bss_start), 0,
> -                       __bss_stop - __bss_start);
> +       /* First zero the BSS */
> +       memset(PTRRELOC(&__bss_start), 0, __bss_stop - __bss_start);
>
>         /*
>          * Identify the CPU type and fix up code sections
> --
> 2.13.3
>
