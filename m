Return-Path: <SRS0=LND+=BN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4984C433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2020 09:59:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 546A020678
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2020 09:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 546A020678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BKtf440NfzDqW5
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2020 19:59:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.161.67; helo=mail-oo1-f67.google.com;
 envelope-from=geert.uytterhoeven@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
Received: from mail-oo1-f67.google.com (mail-oo1-f67.google.com
 [209.85.161.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BKtcG1bqCzDqTs
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2020 19:58:05 +1000 (AEST)
Received: by mail-oo1-f67.google.com with SMTP id x6so434723ooe.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2020 02:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YdwftEG62tf67WwZTXwWotQmRllGZsxvggFDPPsmbhs=;
 b=qi1F/bJC6K7TOvd5ybhsIDmyxC+cU0ublyp49RbRdRnuTDvrUQrVksiT3uTGkw3mCk
 v1N+32j9LR0tvW24D6KamdXu51eiacnddkBCGnIAJLiXoNzfjXlHHlEG4QKEA3j3l6Rf
 ePdjl2zMnjltGX9xHiBbW2YEcgJ2Ne4njS2W8hBoeYPwLObh58vZZUBZKNxlC3QxHxe8
 Hn75YHSM2omROF0yGyaH9AI+PpVG4o7pw7+o5ulNoNow0UiB24igIm8nWYE0L8QOWstJ
 UrNsYMU+Vx3US+q1SQsAfcOgOr8v6hEwIJKh4kK6fho3tN6Fh6hXwj23uUZz4Hx6my0j
 H/Pw==
X-Gm-Message-State: AOAM530SaALYJ/H9CKZjXHt8KfupYpZRmb5eLLbykQ6F15/0qThuHQB5
 KnE9DA4H1DqDVDsVyCQ1Vb1gu/d5Fbqeb9DTad0=
X-Google-Smtp-Source: ABdhPJyp942dhOYiRWw/Ts3ez6GHKnKxf4Kyj0csAXGvzraMsVztqRa5+R5NqTxvQCTBztJz+f8Cju+TIrThf0vMgqc=
X-Received: by 2002:a4a:275e:: with SMTP id w30mr13404242oow.40.1596448682394; 
 Mon, 03 Aug 2020 02:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200803095048.20102-1-geert@linux-m68k.org>
In-Reply-To: <20200803095048.20102-1-geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 3 Aug 2020 11:57:51 +0200
Message-ID: <CAMuHMdW=tzsK=bsQHQmFAUF041XZ8-msfgNZPpKQurxq1dsjGg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.8
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
Cc: sparclinux <sparclinux@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Aug 3, 2020 at 11:53 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.8[1] to v5.8-rc7[3], the summaries are:
>   - build errors: +2/-3

  + /kisskb/src/arch/powerpc/include/asm/mmu.h: error: unknown type
name 'next_tlbcam_idx':  => 139:22

v5.8/powerpc-gcc4.9/corenet64_smp_defconfig
v5.8/powerpc-gcc4.9/ppc64_book3e_allmodconfig
v5.8/powerpc-gcc4.9/ppc64e_defconfig
v5.8/powerpc-gcc9/ppc64_book3e_allmodconfig
(fix available)

  + /kisskb/src/arch/sparc/include/asm/trap_block.h: error: 'NR_CPUS'
undeclared here (not in a function):  => 54:39

v5.8/sparc64/sparc64-allmodconfig
v5.8/sparc64/sparc64-defconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/bcf876870b95592b52519ed4aafcf9d95999bc9c/ (192 out of 194 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/92ed301919932f777713b9172e525674157e983d/ (192 out of 194 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
