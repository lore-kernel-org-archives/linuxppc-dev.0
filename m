Return-Path: <SRS0=H+zi=E5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373FEC2D0E4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2020 19:45:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F088020719
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2020 19:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="tHBe5JSJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F088020719
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CfyL64PvkzDqQM
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2020 06:45:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::641;
 helo=mail-ej1-x641.google.com; envelope-from=morbo@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=tHBe5JSJ; dkim-atps=neutral
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com
 [IPv6:2a00:1450:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CfyJ91NwlzDqPn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2020 06:43:28 +1100 (AEDT)
Received: by mail-ej1-x641.google.com with SMTP id bo9so19248491ejb.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2020 11:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZHBLhDzp7+DVEyAbuaHAJOVsPtTRr9vyE8lLg45JPOY=;
 b=tHBe5JSJZhVXtPML0zFQ6IoXIA0EDrPJKOBljZH/eQH8BY71Tt/9qt3YFMZBXJSrta
 HqFxZ3gJRXRZGMkiN9XYkfrvZxw8aiMWb/J02wpvzY/MYT3rQk6z9VHoMcZa49ROXkjT
 7fCcs/wStgb29lLXLBlZZmIV40mA6NpJmQrA4BrIzV0bg42gkIqJXUrgSjHtKGqpPrbK
 ZmS27pv/GGkcVax6jMR2GDku9ctLTymLHLJsQdWJd9UmSpIi+WafXGZF1zrdSpL9z91x
 lYIZG4VMvfPy/AS5kaHaFz+Yw45WlzLseb3Z8EwQhlBcHPTVDu2nHRwaCIWLhe047e1p
 27GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZHBLhDzp7+DVEyAbuaHAJOVsPtTRr9vyE8lLg45JPOY=;
 b=K9s8eakYjMBGx7orAjFBklHwpJCArMT/XPbdrFS5FgIEZf5KIsgXMVocxHSkKA1cKg
 8K4qy+yuETI/ro1sfd6AMMUH1pjihqb8OIa0RK/EOZxQYpjrqgezaW07q2ONpVoKb2Ru
 SDLUn46V8nj525P3bzHfTz+dKOw2vJ+ZfBi9N/30x59SsVjiMhF4if4C7bwvkI5HcFaY
 nNU5YaY+HNZULlbVTkI2+M3VC5vuLdJHEprM9gGLRtbOKVhS2vUT4DB70xjctbuEa47c
 KWt0cEiMK36L7SE/f7PQTzd1vSiYXjyBkEIuPWZU7K81dXD+PCKYlpRzNKf1f3WBvxLN
 Vt0A==
X-Gm-Message-State: AOAM532hUXwrTRWQGv1S64PBmRdzfLN0HNG9jZdRYaD29k6luHuZqDGq
 Yl067v4NIXowpfsdj8dY2WG6ZXx2BjF7Imw/s8V0REdFRcSG
X-Google-Smtp-Source: ABdhPJy5Zh1KM1ok3fNAXP3NahKc8/UW1qNsCRxFjcX1q9GyonG8RMxr47leMgrUAWMD4mxzTpLn/O7yM3RdKbd8Ljo=
X-Received: by 2002:a17:906:1752:: with SMTP id
 d18mr1004287eje.529.1606160604241; 
 Mon, 23 Nov 2020 11:43:24 -0800 (PST)
MIME-Version: 1.0
References: <20201118223513.2704722-1-morbo@google.com>
 <20201120224034.191382-1-morbo@google.com>
 <20201120224034.191382-4-morbo@google.com> <87d0041vaf.fsf@mpe.ellerman.id.au>
 <20201123063432.GG2672@gate.crashing.org>
In-Reply-To: <20201123063432.GG2672@gate.crashing.org>
From: Bill Wendling <morbo@google.com>
Date: Mon, 23 Nov 2020 11:43:11 -0800
Message-ID: <CAGG=3QVjSAwU+ebvH=Lk5YVMxW7=ThvkJXGPw+95nYxxuurMig@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] powerpc/64s: feature: Work around inline asm issues
To: Segher Boessenkool <segher@kernel.crashing.org>
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
Cc: Nick Desaulniers <ndesaulniers@google.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

What Segher said. :-) Also, if you reverse the comparison, you'll get
a build error.

On Sun, Nov 22, 2020 at 10:36 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Mon, Nov 23, 2020 at 04:44:56PM +1100, Michael Ellerman wrote:
> > If I hard code:
> >
> >       .org . - (1);
> >
> > It fails as expected.
> >
> > But if I hard code:
> >
> >       .org . - (1 > 0);
> >
> > It builds?
>
> "true" (as a result of a comparison) in as is -1, not 1.
>
>
> Segher
