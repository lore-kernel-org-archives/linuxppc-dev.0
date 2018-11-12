Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F45EC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 19:19:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 599CD2245E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 19:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="cHplupk6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 599CD2245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42v0tl6pJZzF3S4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 06:19:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="cHplupk6";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com;
 envelope-from=ndesaulniers@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="cHplupk6"; 
 dkim-atps=neutral
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42v0rH6fYXzF3J6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 06:17:19 +1100 (AEDT)
Received: by mail-pg1-x52b.google.com with SMTP id 17so4229709pgg.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 11:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LZUN9sxIe3uEyYYqFzmApiPoqJLPwlZ/1ewBoWPnFCM=;
 b=cHplupk6QuKfafoELRwMdMTnzPSCSp1i352CPDF2x84fhb3lToHOTRkQkH29ZPsGi7
 AuBoGVvEzXe3gZLBct3iWteZrwdXLotW3Nnxl/Ze/c8+/KtRTFbIzVEqvVMhIHGVHa7x
 SW1GRwTxouBaPeTp/1Hn54pnCYTf2tzv7Ql/x+alXU1l+KZ6a4XX+uXBSYgMxRG9HFdJ
 o0IGsuBkqmZhk26C8ILrMWKNgglSL6UnfjQndRWSyl0oce14WyhyGWoZ5y/QITqeB5PP
 ZflxUwVvGjp51ONpydgJ6sKi2JuFpdzaBWSB/8pxssg3eQpHobxLq6xSKuLqM1WUf0LB
 cZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LZUN9sxIe3uEyYYqFzmApiPoqJLPwlZ/1ewBoWPnFCM=;
 b=C6iSAIY4SGr3E8UDAu4PNUcNCqCH+IjhV9qBHwZmrlSSF2xV0rXOIyOR7SmpSGXoDN
 4l2QKtzv/ZovZLEO0u0wodWP8qIC1DiKfHXS2mZxvdMh8D4RWERX+ebdbfB+eXSyBZwF
 41sWgBJlwPlF4y/8fITsuyaB811y9L0KwaBVm+0xqtsbdzysUH7kAkipXPpGn9JUsi2n
 EPHMIJ1XTNbAE9n0rGh6/gBJ5VrSROSmDI+nrrftxVwfGai5B7AWVCD2RNMPkMxrFBV6
 ZjvcsmkngOwqvZNseHV17QV8m40EjodFMXe9sHNPMzhjmkwP2v55yFC4m2SSSR4RwwLG
 Xw/g==
X-Gm-Message-State: AGRZ1gKd0Jk2TzBFzQjoHK1ORP3pEbyL/YLueSJ+g9VKuUDbmOi4BP2f
 N+jq3lY4FzNiJvN4nDUTzm5Wms33VVk4RHbEV5nGQw==
X-Google-Smtp-Source: AJdET5cRe/di0c3ie7MCG3OaOjnmoGyrYZ3QEspYRWeL61fXE3BS90xDpy+3wa4SqBD7QQFH26v7X9NV/4iwsxIDuBM=
X-Received: by 2002:a62:1095:: with SMTP id
 21-v6mr2005116pfq.227.1542050236542; 
 Mon, 12 Nov 2018 11:17:16 -0800 (PST)
MIME-Version: 1.0
References: <20181102033713.31916-1-joel@jms.id.au>
 <CAKwvOdnVr8_bg-ND29PWihzdD_YVcGH6z+0zHZhK8nEv-k0-2A@mail.gmail.com>
 <CACPK8XcPxOot2-Abn-o0-5ECyz6KfmkUfKSh6L5+pok7eNtCFQ@mail.gmail.com>
In-Reply-To: <CACPK8XcPxOot2-Abn-o0-5ECyz6KfmkUfKSh6L5+pok7eNtCFQ@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 12 Nov 2018 11:17:04 -0800
Message-ID: <CAKwvOd=f9OOR=i10q_auQuQCVH657neQtjt51UA176p_PMOHVw@mail.gmail.com>
Subject: Re: [PATCH] powerpc/math-emu: Fix building with clang
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 12, 2018 at 3:33 AM Joel Stanley <joel@jms.id.au> wrote:
> > On Thu, Nov 1, 2018 at 8:37 PM Joel Stanley <joel@jms.id.au> wrote:
> > >
> > >   arch/powerpc/math-emu/fnmsub.c:46:2: error: invalid use of a cast in a
> > >   inline asm context requiring an l-value: remove the cast or build with
> > >   -fheinous-gnu-extensions

> ./arch/powerpc/include/asm/sfp-machine.h:283:27: note: expanded from
> macro 'sub_ddmmss'
>                : "=r" ((USItype)(sh)),                                  \
>                        ~~~~~~~~~~^~~

Eek, I can of think that add_ssaaaa(), sub_ddmmss(), and umul_ppmm()
should be rewritten from the form:

asm("..." : "=r" (USItype)(arg) : ...);

to the form:

USItype temp = (USItype) arg;
asm("..." : "=r" (temp) : ...);
arg = (typeof(arg)) temp;

Rather than the flag being added.
-- 
Thanks,
~Nick Desaulniers
