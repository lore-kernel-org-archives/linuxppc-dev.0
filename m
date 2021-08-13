Return-Path: <SRS0=Hff1=NE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6DEC4338F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Aug 2021 14:14:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0202760EE4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Aug 2021 14:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0202760EE4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GmQXT1Clxz3blF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Aug 2021 00:14:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256 header.s=google header.b=dKp0vQV7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=axtens.net (client-ip=2607:f8b0:4864:20::629;
 helo=mail-pl1-x629.google.com; envelope-from=dja@axtens.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256
 header.s=google header.b=dKp0vQV7; dkim-atps=neutral
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GmQWh6GyXz3bWT
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Aug 2021 00:13:19 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id a5so12147546plh.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Aug 2021 07:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=qX/JChnLXlyObYVqGeKWhDoJp7v9J6Kqnss11iHK/7U=;
 b=dKp0vQV7R1+npo6tAVzsGn8tYIalp1aIGDIPOj3XmQYMJya9hzE08a+ZWBpKKiYTru
 +O5TGgbcdtY9uQxh7Rq4R3T/+azsUKqW104KC8XF3KXhgREOts+nhk4Pld1YCcTORRO4
 Qe0NFO7ZRWBNGQyf087+bJBxHSq1ZZfGVxAPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=qX/JChnLXlyObYVqGeKWhDoJp7v9J6Kqnss11iHK/7U=;
 b=OKzKy3XDD0w+5LJqXFTO8KP0MECWUfwUoc8t7G4q6MrXmiesYtFcB01EfKssHUFyM0
 rvwTDCjmOeWvDc0+6CNDJBgyWAadI2L5+3UGCra8R5530Rqi6i1yyDaeNvsDImYD80V0
 8dgmTURw/KCAKe/XjpZBYKusheWEpwYkVU/nPEiFFTNA9RCsirUvYpeK2/md2S5kwF9W
 9VdYQK9rEe/npQ640MixdKpXldBWJB0dQU0AC5wzLqQviSZiiR9hWP2q1QRj0sIoEHVg
 kN51JUwge/qL/rY6rxgnohTZkY96MGRZtdwXRjV9OGBHe2jZas46/DFkG3L+JRRarhn9
 A6RQ==
X-Gm-Message-State: AOAM532zAtuFV4C3gO/Wzu4dWD4J9vf4iPqb2+amhFdLCGsMjpqW2qgz
 beIyQu9nTyMwcvObiTjn3UZJQw==
X-Google-Smtp-Source: ABdhPJwF8LJN/sdYnjZyTEuBKiH/d5kecrBt7FUxTDbZIMxbarCsexTwnCvXt76At8sb3Tp8OJrJbg==
X-Received: by 2002:a63:4d18:: with SMTP id a24mr2462947pgb.324.1628863995693; 
 Fri, 13 Aug 2021 07:13:15 -0700 (PDT)
Received: from localhost ([2001:4479:e200:df00:e80c:91ad:1614:aeef])
 by smtp.gmail.com with ESMTPSA id k3sm2611155pfc.16.2021.08.13.07.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Aug 2021 07:13:15 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Bill Wendling <morbo@google.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] ppc: add "-z notext" flag to disable diagnostic
In-Reply-To: <20210812204951.1551782-1-morbo@google.com>
References: <20210812204951.1551782-1-morbo@google.com>
Date: Sat, 14 Aug 2021 00:13:11 +1000
Message-ID: <87sfzde8lk.fsf@linkitivity.dja.id.au>
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
Cc: Bill Wendling <morbo@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Bill Wendling <morbo@google.com> writes:

> The "-z notext" flag disables reporting an error if DT_TEXTREL is set on
> PPC with CONFIG=kdump:
>
>   ld.lld: error: can't create dynamic relocation R_PPC64_ADDR64 against
>     local symbol in readonly segment; recompile object files with -fPIC
>     or pass '-Wl,-z,notext' to allow text relocations in the output
>   >>> defined in built-in.a(arch/powerpc/kernel/misc.o)
>   >>> referenced by arch/powerpc/kernel/misc.o:(.text+0x20) in archive
>       built-in.a
>
> The BFD linker disables this by default (though it's configurable in
> current versions). LLD enables this by default. So we add the flag to
> keep LLD from emitting the error.

You didn't provide a huge amount of context but I was able to reproduce
a similar set of errors with pseries_le_defconfig and

make ARCH=powerpc CROSS_COMPILE=powerpc64-linux-gnu- CC="ccache clang-11" LD=ld.lld-11 AR=llvm-ar-11 -j4 vmlinux

I also checked the manpage, and indeed the system ld does not issue this
warning/error by default.

> ---
>  arch/powerpc/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 6505d66f1193..17a9fbf9b789 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -122,6 +122,7 @@ endif
>  
>  LDFLAGS_vmlinux-y := -Bstatic
>  LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) := -pie
> +LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) += -z notext

Is there any reason this should be gated on CONFIG_RELOCATABLE? (I tried
without it and got different but possibly related linker errors...)

Also, is this behaviour new?

Kind regards,
Daniel

>  LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-y)
>  
>  ifdef CONFIG_PPC64
> -- 
> 2.33.0.rc1.237.g0d66db33f3-goog
