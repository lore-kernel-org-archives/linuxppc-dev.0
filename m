Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B9DC636CC
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Feb 2023 10:11:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PBbPw5Krxz3f4k
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Feb 2023 21:11:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=l4/w1SeX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::b35; helo=mail-yb1-xb35.google.com; envelope-from=elver@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=l4/w1SeX;
	dkim-atps=neutral
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PBbNw0fGtz3ccq
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2023 21:10:55 +1100 (AEDT)
Received: by mail-yb1-xb35.google.com with SMTP id a1so21562884ybj.9
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Feb 2023 02:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Op++DrLjBuho6HgooSKOxTkUUIr0y4lZWy3anVxopdI=;
        b=l4/w1SeXkHNFoOx+e8L+WaLSVTLRGynMjqoTgT1s8uwsM4wHdYFsbynJwYMfCywWja
         JxJw+T47wPYeKNzg0nuUA1kAFnXO1PuvEkSKoQCUUj1sXz4qRN2zW01+lBPEu66ZB9pI
         ifRNmgeUb8hTC28rhGuI+eZy9uTWagV1NUFGstCJ529/7tBj1F9hv24ztygYanGJ2158
         xzvULcJCbN0vd+VQiL9YYqj1EjOnkZMBNKk/54kH5NlxEvBRW24aNNcByWPf9TLm960+
         EIa7sE3LvE0MlPCF5dzM15M+J/8mUL/Fm5WQMvh5DK6eY00zhy29WqqKuITxcm8tJgO/
         I9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Op++DrLjBuho6HgooSKOxTkUUIr0y4lZWy3anVxopdI=;
        b=rsC7CE+d0Ip9Y8Z8js6HVi/HUxTPshgLm3Nc89A+1sTSLj58g2+EPDr+wb8IsM812B
         sUCGqYQiC3Pi+WoXXpkUI3HmF5iGZniJo6PcuNxoTNNOdEqfDxX1RyZKNgR6eLYw8O+z
         TbM3VC0SyXR9wZ9geIfTFcOrqN/2UprGFusZmX8W49VKHDGHUJwyckWd26i8RoK/eWN3
         Z/olSKIz0EqIsYlTFrDXWxAhTk/YiF3QnGl0u3J9l7E05yzfp5OtJTzkknsBrerstnLO
         lmwNS4G10lv+lNOhhJowQVsHXWzY5ElS81L/6fx78Yzaio3W1qpqK9kCgGS2OLu5daL+
         gYMQ==
X-Gm-Message-State: AO0yUKVBVE3fSUKSEQgJvjXtKbaJ0U5SYswnlIWGxmLOBnWwVfnHDQ/8
	Nw7MO1ssiMmdeOGbD6qvj80/epl5AUYmaRrSvZBZxQ==
X-Google-Smtp-Source: AK7set9HxWcHOwQvLaHJ3cQAJOOWODmAvV9ulagehqprztN6jvwbt4ESIPybbSd3UReE6z5oZ7mkch4LmJ4jo84nEXA=
X-Received: by 2002:a5b:4cf:0:b0:87d:c01e:2205 with SMTP id
 u15-20020a5b04cf000000b0087dc01e2205mr1139020ybp.179.1675851052907; Wed, 08
 Feb 2023 02:10:52 -0800 (PST)
MIME-Version: 1.0
References: <20230208032202.1357949-1-rmclure@linux.ibm.com> <20230208032202.1357949-8-rmclure@linux.ibm.com>
In-Reply-To: <20230208032202.1357949-8-rmclure@linux.ibm.com>
From: Marco Elver <elver@google.com>
Date: Wed, 8 Feb 2023 11:10:16 +0100
Message-ID: <CANpmjNNHmMX+-UhuE0aq-2-iMpA6zo4MCnNsqeCpq1LXC-H9Ug@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] powerpc: kcsan: Add KCSAN Support
To: Rohan McLure <rmclure@linux.ibm.com>
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
Cc: chris@zankel.net, linux-xtensa@linux.xtensa.org, npiggin@gmail.com, jcmvbkbc@gmail.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 8 Feb 2023 at 04:23, Rohan McLure <rmclure@linux.ibm.com> wrote:
>
> Enable HAVE_ARCH_KCSAN on all powerpc platforms, permitting use of the
> kernel concurrency sanitiser through the CONFIG_KCSAN_* kconfig options.
> KCSAN requires compiler builtins __atomic_* 64-bit values, and so only
> report support on PPC64.

I thought the stubs solve that?

In general the whole builtin atomic support is only there to support
some odd corner cases today (Clang GCOV generates builtin atomic ops,
occasionally some driver sneaks in a builtin atomic although it's
technically strongly discouraged, and probably Rust stuff in future).
So I'd like to keep them, although they shouldn't cause issues.

> See documentation in Documentation/dev-tools/kcsan.rst for more
> information.

Do the tests pass?

> Signed-off-by: Rohan McLure <rmclure@linux.ibm.com>
> ---
> v3: Restrict support to 64-bit, as TSAN expects 64-bit __atomic_* compiler
> built-ins.
> ---
>  arch/powerpc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index b8c4ac56bddc..55bc2d724c73 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -198,6 +198,7 @@ config PPC
>         select HAVE_ARCH_KASAN                  if PPC_RADIX_MMU
>         select HAVE_ARCH_KASAN                  if PPC_BOOK3E_64
>         select HAVE_ARCH_KASAN_VMALLOC          if HAVE_ARCH_KASAN
> +       select HAVE_ARCH_KCSAN            if PPC64
>         select HAVE_ARCH_KFENCE                 if ARCH_SUPPORTS_DEBUG_PAGEALLOC
>         select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
>         select HAVE_ARCH_KGDB
> --
> 2.37.2
>
