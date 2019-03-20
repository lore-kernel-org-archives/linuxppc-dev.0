Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3EFC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 09:43:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7827F2175B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 09:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7827F2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PQ3B21MgzDqGB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 20:43:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.196; helo=mail-qk1-f196.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
 [209.85.222.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PQ1R3Sm2zDqCk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 20:42:02 +1100 (AEDT)
Received: by mail-qk1-f196.google.com with SMTP id s81so916229qke.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 02:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Wcem8o0HHIzqutiHXBbDWombZs0tH1uJm1IkFEOS1gM=;
 b=YPNviy95AAXFH1e/BLjlr6UoEbGW8VULVceXJXl0ckdNtTD4J7a83K055SiYcql172
 oGcawjCvZjnic26KYH1WzrVnZBHodkFriOzXt3eSMUwrwehTEuImd5jNipNWKVzFmzg+
 1/Xr4O1CwHiS+8wyEwilrFPbPXhU1qKKuy3Y3QzvHYzWz5e9Cn71Ob08MXnjX3N3EQgF
 4PXTjj4/Ax4BVzaR+57OLn9fjm6zgpbHOFX0dGtybHDZ+vs8c6aiXBRafqKzzzZkc2eb
 SDLGJB25rcWr9M4RHQXavT1HTNaiVShkyHZ7f0RpXFUr1Y78s8v2j3/UfIfXy81YkCbb
 2EUA==
X-Gm-Message-State: APjAAAVm+gQpPa8aBVCXjaQ4RVJzGZupKM2nZZxHIo3W/1g/dflspCjt
 3iVTPXjvcaicIQM1s72aorqhIQIl0u6CzSlXhSQ=
X-Google-Smtp-Source: APXvYqzQSLM2qs76g1mPFR6+NFZQ+VxO7eK9lVtHjHmQgwnJhO043jU8NlghsFKH8kP1B/2Ljhps92bIbDCGPPfMWi4=
X-Received: by 2002:ae9:dec2:: with SMTP id s185mr5394316qkf.107.1553074920561; 
 Wed, 20 Mar 2019 02:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 20 Mar 2019 10:41:43 +0100
Message-ID: <CAK8P3a3BG_mxYxxCx4S_+ZKAer_+5FpmkzLk0VrACZekuD=2GQ@mail.gmail.com>
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

On Wed, Mar 20, 2019 at 7:21 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Commit 60a3cdd06394 ("x86: add optimized inlining") introduced
> CONFIG_OPTIMIZE_INLINING, but it has been available only for x86.
>
> The idea is obviously arch-agnostic although we need some code fixups.
> This commit moves the config entry from arch/x86/Kconfig.debug to
> lib/Kconfig.debug so that all architectures (except MIPS for now) can
> benefit from it.
>
> At this moment, I added "depends on !MIPS" because fixing 0day bot reports
> for MIPS was complex to me.
>
> I tested this patch on my arm/arm64 boards.
>
> This can make a huge difference in kernel image size especially when
> CONFIG_OPTIMIZE_FOR_SIZE is enabled.
>
> For example, I got 3.5% smaller arm64 kernel image for v5.1-rc1.
>
>   dec       file
>   18983424  arch/arm64/boot/Image.before
>   18321920  arch/arm64/boot/Image.after
>
> This also slightly improves the "Kernel hacking" Kconfig menu.
> Commit e61aca5158a8 ("Merge branch 'kconfig-diet' from Dave Hansen')
> mentioned this config option would be a good fit in the "compiler option"
> menu. I did so.

I think this is a good idea in general, but it is likely to cause a lot of
new warnings. Especially the -Wmaybe-uninitialized warnings get
new false positives every time we get substantially different inlining
decisions.

I've added your patch to my randconfig test setup and will let you
know if I see anything noticeable. I'm currently testing clang-arm32,
clang-arm64 and gcc-x86.

      Arnd
