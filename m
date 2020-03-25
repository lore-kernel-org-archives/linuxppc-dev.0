Return-Path: <SRS0=ePRe=5K=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7798C1975A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2020 05:24:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47DAD20719
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2020 05:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="gNq40aGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47DAD20719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48nGkp3jXDzDqPv
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2020 16:24:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::844;
 helo=mail-qt1-x844.google.com; envelope-from=joel.stan@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=jms.id.au header.i=@jms.id.au header.a=rsa-sha256
 header.s=google header.b=gNq40aGl; dkim-atps=neutral
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48nGj60gSlzDqDt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2020 16:22:48 +1100 (AEDT)
Received: by mail-qt1-x844.google.com with SMTP id c14so1279992qtp.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2020 22:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4vuy5iMbkWzUJjs5KXWHmrZOeilRi4q9EUgRXcNEaaU=;
 b=gNq40aGlGB4hsfq2Di6iLMdX1ZaqtpB1gnUdRWPKpWP6lxhRZi+o02yFp1wBV9yTCA
 rxFAJdeUKlK/ySZJz0n+78TCOM1asqTGu3DE/o/nic0ORqN09M+4g9KNnNvbreLiGHl2
 nbEbvj7fZ/Q1PmDHzOy86czR1J2yT7lQOrIM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4vuy5iMbkWzUJjs5KXWHmrZOeilRi4q9EUgRXcNEaaU=;
 b=bFJcL69pOoy/MBjK0ki7Sn29hArjbkKNZJZBsKHKrUOlZOrRFv7LQ1pDTELOsVDvfL
 Ayj0/VuHMz310ZMIV1U1S9v6ffeeiaD3giC9CvOFrxl60caQv641Gg/DM0r77X4CmDY5
 /GD9E4O44QKn50rC4KZp8kiaBrpV+rHbeus9mdjgJk3K9UOyyGCwbGY7A2/f3Jl2Wim+
 Cp+NBjVBIlb4joU+YwVpxHgAYwqPzptXo8thqxVH9XsbuIx1xJpZz2A3B5UVdNeH3uRX
 UFvNERbLXJxBz8z/Q/pJfqhgMVk3Au6y7TIsv3BWDg6kTJ7ryc/lddWkEk52QkvbWTww
 0N2Q==
X-Gm-Message-State: ANhLgQ22UtYsWG3v9zhLOgoQr/dO55c0k7zNFzh9jKsXBbllskpHN2Pg
 fhObzjFZxoat7UWTVgBSRm3n8yizAZ4S2iQkcRg=
X-Google-Smtp-Source: ADFU+vvMWQ1p60Vc3tJK855J5SWCk9Vtt3xGC3RWhBtm1eodZiPaWSl2uuZmi5tzzkSd7OsPgHrn5MEaWbf0Y3b+hac=
X-Received: by 2002:ac8:18a4:: with SMTP id s33mr1369964qtj.220.1585113763638; 
 Tue, 24 Mar 2020 22:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200325051820.163253-1-maskray@google.com>
In-Reply-To: <20200325051820.163253-1-maskray@google.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 25 Mar 2020 05:22:31 +0000
Message-ID: <CACPK8Xf70Yq2szW110G_2f2Q3J6inVqQY4Y-y0tggkVmT7tmfw@mail.gmail.com>
Subject: Re: [PATCH] powerpc/boot: Delete unneeded .globl _zimage_start
To: Fangrui Song <maskray@google.com>, Alan Modra <amodra@gmail.com>
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
Cc: Nick Desaulniers <ndesaulniers@google.com>, linuxppc-dev@lists.ozlabs.org,
 clang-built-linux@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 25 Mar 2020 at 05:19, Fangrui Song <maskray@google.com> wrote:
>
> .globl sets the symbol binding to STB_GLOBAL while .weak sets the
> binding to STB_WEAK. They should not be used together. It is accidetal
> rather then intentional that GNU as let .weak override .globl while
> clang integrated assembler let the last win.
>
> Fixes: cd197ffcf10b "[POWERPC] zImage: Cleanup and improve zImage entry point"
> Fixes: ee9d21b3b358 "powerpc/boot: Ensure _zimage_start is a weak symbol"
> Link: https://github.com/ClangBuiltLinux/linux/issues/937
> Signed-off-by: Fangrui Song <maskray@google.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: clang-built-linux@googlegroups.com
> ---
>  arch/powerpc/boot/crt0.S | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/arch/powerpc/boot/crt0.S b/arch/powerpc/boot/crt0.S
> index 92608f34d312..1d83966f5ef6 100644
> --- a/arch/powerpc/boot/crt0.S
> +++ b/arch/powerpc/boot/crt0.S
> @@ -44,9 +44,6 @@ p_end:                .long   _end
>  p_pstack:      .long   _platform_stack_top
>  #endif
>
> -       .globl  _zimage_start
> -       /* Clang appears to require the .weak directive to be after the symbol
> -        * is defined. See https://bugs.llvm.org/show_bug.cgi?id=38921  */
>         .weak   _zimage_start
>  _zimage_start:

Your explanation makes sense to me. I've added Alan to cc for his review.

Reviewed-by: Joel Stanley <joel@jms.id.au>

Thanks for the patch.

Cheers,

Joel

>         .globl  _zimage_start_lib
> --
> 2.25.1.696.g5e7596f4ac-goog
>
