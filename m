Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B77C0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 22:40:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9744D2084F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 22:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="loEgC+Mm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9744D2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pngY24PGzF35Q
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 09:40:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="loEgC+Mm";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=ndesaulniers@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="loEgC+Mm"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pnd171V6zDrDT
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 09:37:57 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id b5-v6so5153916pla.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Nov 2018 14:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zZACWSjZ3Q5WmL3kd7vzGZGnEgREaoyhBQDYpK6S+ic=;
 b=loEgC+MmKhvc+amScuS9dM5DJuIjeijXRkGzrHvznv1L1xh8fEOiGHlsA3KUaRSpSn
 nvyUZ1aFvl569emwknlhHLGKX6/yKNVZAkC8Rt780SXDenj8TsPuPS6SP8fjKRxHlN0/
 LYQvrL1/KZ+t1pEjjcVHhpt/jPFKXhPMPGitMczYSed1HZc6zMKGrORz25qb3iIwyZ6o
 AftCaGr7p0zaCVr3pSk94kXOYmaL7Apt70iDc6HfXQopyg8KbvFggkfmeaZ8PsL5YqOQ
 VcM4bq689GYryayC9wihFIwVuE4+S1KUnCwvVQqyt+XMd0W+Z7afkDq2tIvJlKXP64/v
 Gmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zZACWSjZ3Q5WmL3kd7vzGZGnEgREaoyhBQDYpK6S+ic=;
 b=cKzHsfsXAdsn2WbazhUW+lPuvRl2mHAQqRpME0MQ48lUssD06ajGdcmLya8QYJo+zN
 OWL9mB0pzjNqtfeVeDkaXwS2ZdRctulXmWTKxLgl5U7SYs8X8wKI3HPBJuXEad10TZtk
 dwoIHLRyHPofmd65XU1Fm/PUMVaFEibo4uQOsHCGnQMQLPsJFfrnmAQXlhwZ9aBJfzUh
 Nj/WC6fHMEx6itnaKI8HNFGvPLv9EV08ueaynZqsUY0FJzBB6FtUKIePum8qENd757cI
 lrIyM0jpTNmPqLK3dntB0mvLhiVPcZAgpTTnH777NBcr1O7ZW5nK/x2CAq5boJFC6/oJ
 wl+w==
X-Gm-Message-State: AGRZ1gLy+cS2d2q379/E0CLwpFeAPbbN4LuOZzahxEawEUq+anEOpfZ+
 xXCnYdio52afmIrV0oWgomXHYFQvd8pUsg95EUNHQQ==
X-Google-Smtp-Source: AJdET5c/9016aIchIGgGORthwYlI6HydHAI0r9WmpRvkHSoVNHhTUQH+OEg6T5jxuTNUaRbfSCfJcUja1WDdx8NskpU=
X-Received: by 2002:a17:902:9897:: with SMTP id
 s23-v6mr5297812plp.229.1541457475475; 
 Mon, 05 Nov 2018 14:37:55 -0800 (PST)
MIME-Version: 1.0
References: <20181104231133.30848-1-joel@jms.id.au>
In-Reply-To: <20181104231133.30848-1-joel@jms.id.au>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 5 Nov 2018 14:37:44 -0800
Message-ID: <CAKwvOdm8WZTeB_wxkO2nN7PW=v=2z7tdVapTq-TiB18nZZfS=A@mail.gmail.com>
Subject: Re: [PATCH 0/2] poewrpc/Boot: Fix cross compiling with clang
To: joel@jms.id.au
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
Cc: Michal Marek <michal.lkml@markovi.net>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Nov 4, 2018 at 3:11 PM Joel Stanley <joel@jms.id.au> wrote:
>
> Hello,
>
> These patches allow clang to cross-compile the powerpc boot wrapper.
> The boot wrapper constructs it's own compiler flags as it may not be
> built for the same arch as the kernel.

Hi Joel, thanks for the series!  I'm just curious, how does the boot
wrapper run on a different arch than the kernel?

>
> The powerpc64le kernel builds natively with clang and with this patch it
> can cross compile too.
>
> Joel Stanley (2):
>   Makefile: Export clang toolchain variables
>   powerpc/boot: Set target when cross-compiling for clang
>
>  Makefile                   | 3 +++
>  arch/powerpc/boot/Makefile | 7 +++++++
>  2 files changed, 10 insertions(+)
>
> --
> 2.19.1
>


-- 
Thanks,
~Nick Desaulniers
