Return-Path: <SRS0=+v6T=6S=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D594C3A5A9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2020 07:35:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36F8D20735
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2020 07:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F8D20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49FvlH3qdczDqf3
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2020 17:35:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.167.194;
 helo=mail-oi1-f194.google.com; envelope-from=geert.uytterhoeven@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49FvhW626vzDqXX
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2020 17:32:41 +1000 (AEST)
Received: by mail-oi1-f194.google.com with SMTP id m10so5858200oie.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 May 2020 00:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ooc31C0HVG+wuFWk6i8TyXlbS7UT7v67DJlPvfFWyqk=;
 b=YXMuC+Bjsnt//4N29SR958s72UNUHxMhObVvJ9UhmtW/E24dfWNyFAAs6ZiKwjFv3R
 di934bDs7ViIzJSGJwPveRHDTOiZGDZeKzTUTTA4kXFCn22SCScszpnRBT/izkKDOe0h
 VPTctMjlUwfvzUggFXy+qd7A/4IrXob21fcOQfgP4CLyJYQmumCvotVi0JdCFeuUV2Pa
 d6LCEU1RY8FR/cOclr1I+Zqti/3A0RR63G4dE2d5EemWmyBhYw6MeKz/mKQJYlcuz5du
 swBwmdgWMxE3KvVIn9x8a6vV0bPYy9BcjmV7NyaYRuRgsIw7NMOE89BmMBjDlgocK3f7
 64Jw==
X-Gm-Message-State: AGi0PuauLaKz5+8fpE2Qi6gBLx93iiP7jHusuzwmxZ0YDZosvPLowgry
 JKKc7iIqF7aXLjxWkOS4g5hyFP8PY4EkPGpBQYk=
X-Google-Smtp-Source: APiQypLEE+zhkdSnfmZtRrT0AndiKSIR8Yc7ujLR9NAOfft9X24jtxxKzLyC0ok06W7mvA6Q4E3ASrRaa3/UBThdJ1c=
X-Received: by 2002:aca:895:: with SMTP id 143mr7666525oii.153.1588577558483; 
 Mon, 04 May 2020 00:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200504072229.31214-1-geert@linux-m68k.org>
In-Reply-To: <20200504072229.31214-1-geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 4 May 2020 09:32:27 +0200
Message-ID: <CAMuHMdV3mWTcrVhut01Tt3j58QY5-UqaDYh4SSQwgk-=7TX80A@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.7-rc4
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Timothy Pearson <tpearson@raptorengineering.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, May 4, 2020 at 9:24 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.7-rc4[1] to v5.7-rc3[3], the summaries are:
>   - build errors: +3/-123

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/0e698dfa282211e414076f9dc7e83c1c288314fd/ (all 239 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/6a8b55ed4056ea5559ebe4f6a4b247f627870d4c/ (all 239 configs)

It's back:

  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:
error: implicit declaration of function 'cpu_has_feature'
[-Werror=implicit-function-declaration]:  => 626:2
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:
error: implicit declaration of function 'disable_kernel_vsx'
[-Werror=implicit-function-declaration]:  => 662:2
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:
error: implicit declaration of function 'enable_kernel_vsx'
[-Werror=implicit-function-declaration]:  => 626:2

powerpc-gcc4.6/ppc64_book3e_allmodconfig

powerpc-gcc9/ppc64_book3e_allmodconfig builds fine, as it doesn't have
DRM_AMD_DC_DCN, enabled due to:

    select DRM_AMD_DC_DCN if (X86 || PPC64) && !(KCOV_INSTRUMENT_ALL
&& KCOV_ENABLE_COMPARISONS)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
