Return-Path: <SRS0=nAMm=V2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15DCC76186
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jul 2019 20:48:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50B99206A2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jul 2019 20:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="WPJlgbNE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B99206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45yBby041NzDqSB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jul 2019 06:48:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=ndesaulniers@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="WPJlgbNE"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45yBXv1hMGzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2019 06:45:49 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id b13so28616271pfo.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jul 2019 13:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lMrEHRmz/SUwhMpEhzoL0Mw6xHn5eIa1ccchwHTfCGg=;
 b=WPJlgbNETipOyujtvKlH6HINt+YFjSa9gIvaQ65HBAN1terVNMqFdGfYjK9JTqalZP
 CTfan8DoLaM9dEydbVrYnrw3wyespEYa/zlntrZle7b4z2W09X/wDDCuqWS2UUqbhJJg
 1Zx4tSK7eXqtwpKxKBNvBgPc7uMUUD/ijctUCPOVT4sSd5lUf4kXTZuo6iHyEpLA3vU7
 dZAdaweB0GNydgKkVAGwGo149b+embU5Riiavkl9V0ax1ElqlMOOkxN8jS6N6/JoXH6n
 34Fujg9hV2KQNRr8s70fbftl5r9c+zb9K7PaC4Wo5aAdsI2ot3DR17Ied4PU9bUvBqbB
 EFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lMrEHRmz/SUwhMpEhzoL0Mw6xHn5eIa1ccchwHTfCGg=;
 b=jdc5wVC5pkx/5oYxYTG9gkF0Gky13pKnpfh7bxlF48kF9kOwHolEyuuJd0OKciFj7J
 DzraDdjraJordvcg1NtxAS5WRqi5eUZLjfJr6TTogljm+6r28K8v4cegTZ+s9ZXTcs5g
 EB81VMKrMyEil7FG/LGwpS1DOYoVxgcu0nNskMAba5wYq8fm9OIOX+LpZhaChCiKRyKT
 QKF6YKkFPWq2wREPUJTaxI5W0K4FmEH0osSXNT7pOdKX+1SK5BINXEC2Yckbg6FOjmHE
 VBdlahJBlsLsr+SXunbQDI4wxLa9LuYZNYdKJnZ28KSOji/mgbYbnv9NLXFAEL+Ev3TB
 D7zA==
X-Gm-Message-State: APjAAAVPhUdVQ4mWwdBoa7buTGwp7hy7cVIw2e7mOtszGXcFltuhSZzt
 BpQCWL24rjkVzyASH/Gf84N5Mw5mmQL5fs6BKHTuMg==
X-Google-Smtp-Source: APXvYqwRBA++ZLki3FCDkYfIOm4fZxAqwQa+t0nQs1TnfuIBjlaC+SunAk9780W7jSAo9r9g92a851AjfhqU0PQo/9M=
X-Received: by 2002:a17:90a:ac11:: with SMTP id
 o17mr115215537pjq.134.1564433146243; 
 Mon, 29 Jul 2019 13:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190729202542.205309-1-ndesaulniers@google.com>
 <20190729203246.GA117371@archlinux-threadripper>
In-Reply-To: <20190729203246.GA117371@archlinux-threadripper>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 29 Jul 2019 13:45:35 -0700
Message-ID: <CAKwvOdm7GRBWYhPy4Ni2jbsXJp8gDF-AqaAxeLbZ03+LvHxADQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: workaround clang codegen bug in dcbz
To: Nathan Chancellor <natechancellor@gmail.com>
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
Cc: Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kbuild test robot <lkp@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jul 29, 2019 at 1:32 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Mon, Jul 29, 2019 at 01:25:41PM -0700, Nick Desaulniers wrote:
> > But I'm not sure how the inlined code generated would be affected.
>
> For the record:
>
> https://godbolt.org/z/z57VU7
>
> This seems consistent with what Michael found so I don't think a revert
> is entirely unreasonable.

Thanks for debugging/reporting/testing and the Godbolt link which
clearly shows that the codegen for out of line versions is no
different.  The case I can't comment on is what happens when those
`static inline` functions get inlined (maybe the original patch
improves those cases?).
-- 
Thanks,
~Nick Desaulniers
