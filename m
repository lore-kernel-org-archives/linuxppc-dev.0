Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5871FC43610
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 18:58:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F365822504
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 18:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="dPH7BNza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F365822504
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42v0QK0VHxzDr4h
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 05:58:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="dPH7BNza";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=ndesaulniers@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="dPH7BNza"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42v0Mq1MqPzF3Ft
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 05:56:07 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id w3-v6so4446188pgs.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 10:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=D7zJOfAchvRNktzeAWQkae2R/fEUK7VwwkzZ8LQ4i/E=;
 b=dPH7BNzaoiRjfH6sTPW5q8GWsRlrsp4wuWUspJF3mphlpQ5Qk4GApMJM3HthT7iRld
 qJWWhjqxPkC6uG9FQF3My1wxYSUU/l+WvlJUI5CncULx1aEIx4vhCs62XnhUrDj8aFMW
 IVtPfpQXe0bSrxT6/4crKHJJOAlq8oYS4pTOfHcgE+FWMd+vzyESiNQrCLttKTd4elaO
 pRqa0ILAAp7BISlhydp50AVOHhp552eXAlGIVWWoTvS5G5Oj8rw2Cmkc0WIepPEGgkkw
 7QUEFdvFoerVXN3eBIfNf6RQCrpwPv9meYDVWQKUCi/kW3Mduebuh1LI2Ukqnczmk0G/
 Apkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D7zJOfAchvRNktzeAWQkae2R/fEUK7VwwkzZ8LQ4i/E=;
 b=R99Vi9Xog9TlPMMAH8swBjQ9bu8jNwemnp1jcEdJXfXF8pyX4PgKnTzc4HEPQkQWPk
 tHjWWdRlxeFhmOUZ7Be65ZNZdSaYT3dQEZE49ZmQTslkvP5FBwRnq0p/0WuL/9ZwZ1Uc
 N+0NmxGY09vZqLonSBYEzzgaMeANau03Vc4c5SStq5h9MZCsgmk4i8oi3/G8P34/pIou
 tF6KT3941t12Azy1yBcdqUCX3GeWQK7c/ZaVx2FvzHQag/NkjCxeMrjl/IXiZi7SuD5x
 0+NzaeFLrKPEj5fSmOZFp+u+wMmxbWXSpF9QOUp5JF3q+Vhprellk2tsesljrDmcDMyj
 Su5w==
X-Gm-Message-State: AGRZ1gIG3O33W488romZqZrHPsxbdRlqA+M5if/1EKzGISl8A+nyEhMK
 YyplEm44TiNSZIFv+fT/yFr2qDQlmed/ZjNgo2HvRw==
X-Google-Smtp-Source: AJdET5dlj72dkILax3Mhs9zY8pCeVi8qBTCkLko0bMkImG68ygOgCEWX7t0ijeuZ3n/XDrVC395qAdiE5xFknc6TkKc=
X-Received: by 2002:a63:42c1:: with SMTP id p184mr1809818pga.202.1542048964587; 
 Mon, 12 Nov 2018 10:56:04 -0800 (PST)
MIME-Version: 1.0
References: <20181112042116.5271-1-joel@jms.id.au>
 <20181112042116.5271-2-joel@jms.id.au>
In-Reply-To: <20181112042116.5271-2-joel@jms.id.au>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 12 Nov 2018 10:55:53 -0800
Message-ID: <CAKwvOdnBMFYXvS+GH0cUiczgkpLWtBinPRjkTJBQGrKjxktUUg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Makefile: Export clang toolchain variables
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
 Masahiro Yamada <yamada.masahiro@socionext.com>, linuxppc-dev@lists.ozlabs.org,
 dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Nov 11, 2018 at 8:21 PM Joel Stanley <joel@jms.id.au> wrote:
>
> The powerpc makefile will use these in it's boot wrapper.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Makefile b/Makefile
> index 09278330282d..840efe6eb54c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -495,6 +495,7 @@ endif
>  ifneq ($(GCC_TOOLCHAIN),)
>  CLANG_FLAGS    += --gcc-toolchain=$(GCC_TOOLCHAIN)
>  endif
> +export CLANG_FLAGS
>  CLANG_FLAGS    += -no-integrated-as

Does this export CLANG_FLAGS before `-no-integrated-as` is set?
Either way, I think it would be clearer to export this after all the
relevant flags are set.

>  KBUILD_CFLAGS  += $(CLANG_FLAGS)
>  KBUILD_AFLAGS  += $(CLANG_FLAGS)
> --
> 2.19.1
>


-- 
Thanks,
~Nick Desaulniers
