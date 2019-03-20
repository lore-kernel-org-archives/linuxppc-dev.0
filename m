Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4635C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 13:39:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1845F2184D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 13:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1845F2184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PWHG5Wg0zDqFs
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 00:39:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.195; helo=mail-qt1-f195.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PW9W1VCFzDq9L
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 00:34:22 +1100 (AEDT)
Received: by mail-qt1-f195.google.com with SMTP id z17so1418582qts.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 06:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lxb+cto02BIatCH7Gsn3jweAO4W1kfw2CVhMuPz2fqU=;
 b=AP8uYY6p9VCbrHEUhBUzcRubBkM+uKl4Go3S9wWUcvI/kI/Vp2PRBT4J0itRJ+Lh51
 XfrlByCYuwFn3T25fAuDAnioMKdwc4UqQ6HeLpr4fPKtxp7Q9KCXM/CeH6LOfjuTbBVE
 Kgr9OeA/fCw1tRVyrZRaG6aC/k/rDv1FGlei8Rg3YoW6YjucTxMCZ25aRSR9i/ciThMN
 I1FwGB0roOqR5966TR331Yusw5jne5olGsG+P8EkA9ErwSqkpWvjx2/r66nChwHeZGUp
 jvqB9VUr4b5gDCSgXzT3CaOPALMpXqxuNbS6A4BNs+a12Xm3xmoU2klb2AXjOlx8BVRg
 GcnQ==
X-Gm-Message-State: APjAAAWA2o0KAGtWz+k5BJZxpg0xi5UqEla2uv+QZRYAoKVRCKdtLpNC
 uTrUvP/OgtMOPlbTRwXQMvampU7ePpp+qLZGASE=
X-Google-Smtp-Source: APXvYqz9MW7CJwO9dJ+S+7Q1aJsu3zP2Bpyeyex9t6Dgx6Q7wQ4uZyS7kKe5y9Us8CNX6vU0d8jy9lg1/AmI+RSWdPc=
X-Received: by 2002:a0c:9487:: with SMTP id j7mr1278926qvj.180.1553088860133; 
 Wed, 20 Mar 2019 06:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK8P3a3BG_mxYxxCx4S_+ZKAer_+5FpmkzLk0VrACZekuD=2GQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3BG_mxYxxCx4S_+ZKAer_+5FpmkzLk0VrACZekuD=2GQ@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 20 Mar 2019 14:34:02 +0100
Message-ID: <CAK8P3a0GEYTbw5XCwzVeZe_-pGF=7e=1kXhH3U+fidnMZeP0CA@mail.gmail.com>
Subject: Re: [PATCH] compiler: allow all arches to enable
 CONFIG_OPTIMIZE_INLINING
To: Masahiro Yamada <yamada.masahiro@socionext.com>
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
Cc: linux-arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>, Dave Hansen <dave@sr71.net>,
 the arch/x86 maintainers <x86@kernel.org>, linux-mips@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@redhat.com>,
 linux-mtd <linux-mtd@lists.infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Mar 20, 2019 at 10:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> I've added your patch to my randconfig test setup and will let you
> know if I see anything noticeable. I'm currently testing clang-arm32,
> clang-arm64 and gcc-x86.

This is the only additional bug that has come up so far:

`.exit.text' referenced in section `.alt.smp.init' of
drivers/char/ipmi/ipmi_msghandler.o: defined in discarded section
`exit.text' of drivers/char/ipmi/ipmi_msghandler.o

diff --git a/arch/arm/kernel/atags.h b/arch/arm/kernel/atags.h
index 201100226301..84b12e33104d 100644
--- a/arch/arm/kernel/atags.h
+++ b/arch/arm/kernel/atags.h
@@ -5,7 +5,7 @@ void convert_to_tag_list(struct tag *tags);
 const struct machine_desc *setup_machine_tags(phys_addr_t __atags_pointer,
        unsigned int machine_nr);
 #else
-static inline const struct machine_desc *
+static __always_inline const struct machine_desc *
 setup_machine_tags(phys_addr_t __atags_pointer, unsigned int machine_nr)
 {
        early_print("no ATAGS support: can't continue\n");
