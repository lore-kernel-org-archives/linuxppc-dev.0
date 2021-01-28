Return-Path: <SRS0=s+PL=G7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6100FC433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Jan 2021 08:01:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAB6864DD6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Jan 2021 08:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB6864DD6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DRCZz4J9tzDrgs
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Jan 2021 19:00:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.210.44; helo=mail-ot1-f44.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
 [209.85.210.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DRCXR4tR1zDrfX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2021 18:58:45 +1100 (AEDT)
Received: by mail-ot1-f44.google.com with SMTP id i20so4378766otl.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2021 23:58:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VFvlavdQj3vCTWkwoAVwJZYrgCNBuE8sgIQdKiGhY+w=;
 b=UzwxzAKSP4kkJgoJH06frpYBVIslLSZhjlkwAKGcF/foKG/gt3O6NBRwF+mF7tk4zL
 zNlVsuyMnqhVtpTvTgSkdjUWarfTU7n6OLmQGXA06gttfjmyuiWjQHpkxRy+VlEs5gkP
 UbeXuUqK34MneJLHQKr4BInx8QcaNHqFU/aYnYvzTsMCOZfhbKVSUbaVM5w0kc/fDk1O
 CJmVIdshrg7boviIJmsHBDYqmMOxW0G1pOCAqKvwSejRNx+uL7XL2zNq/xjoc3wGKVwu
 fuBshxa31eiUH1Svt9xmeMxIpiAm/bC0RG9AdWqDiYtLlP1epMMaxw9E+HpdOZql8LpB
 bjBg==
X-Gm-Message-State: AOAM532CxDgKOgnIDW45YlqLW9GajyOCgH2H9J4Sr7JKlomppClrskUj
 STAjkD4Y6GIpqCPfAYlnaSAVi7aYiEDN9jdVkTo=
X-Google-Smtp-Source: ABdhPJznIX8Ez5rT0eH2kPu8lo8LgYhmVvO6LoHIL5yF3kdkazjNHo5u99kdHiTbtJ4IH8g890LINaHfxGpj5ywaFPQ=
X-Received: by 2002:a9d:c01:: with SMTP id 1mr10464911otr.107.1611820723093;
 Wed, 27 Jan 2021 23:58:43 -0800 (PST)
MIME-Version: 1.0
References: <20210128005110.2613902-1-masahiroy@kernel.org>
 <20210128005110.2613902-12-masahiroy@kernel.org>
In-Reply-To: <20210128005110.2613902-12-masahiroy@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 28 Jan 2021 08:58:32 +0100
Message-ID: <CAMuHMdWTK7Xa-6E2yLHxv8sGkD-VYgDF2SMRCj4_tDTVS2Uw1A@mail.gmail.com>
Subject: Re: [PATCH 11/27] m68k: add missing FORCE and fix 'targets' to make
 if_changed work
To: Masahiro Yamada <masahiroy@kernel.org>
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
Cc: Linux-Arch <linux-arch@vger.kernel.org>,
 "open list:TENSILICA XTENSA PORT \(xtensa\)"
 <linux-xtensa@linux-xtensa.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Parisc List <linux-parisc@vger.kernel.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 linux-um <linux-um@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 alpha <linux-alpha@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 28, 2021 at 1:54 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> The rules in this Makefile cannot detect the command line change because
> the prerequisite 'FORCE' is missing.
>
> Adding 'FORCE' will result in the headers being rebuilt every time
> because the 'targets' addition is also wrong; the file paths in
> 'targets' must be relative to the current Makefile.
>
> Fix all of them so the if_changed rules work correctly.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
