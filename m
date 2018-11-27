Return-Path: <SRS0=Iv+L=OG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39984C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 17:06:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7080620817
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 17:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nxXUEc6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7080620817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4349Cx0rYbzDqlX
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 04:06:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nxXUEc6v";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=chromium.org
 (client-ip=2607:f8b0:4864:20::b43; helo=mail-yb1-xb43.google.com;
 envelope-from=keescook@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="nxXUEc6v";
 dkim-atps=neutral
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com
 [IPv6:2607:f8b0:4864:20::b43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43498x6Nr3zDqk5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 04:03:29 +1100 (AEDT)
Received: by mail-yb1-xb43.google.com with SMTP id u103-v6so9355076ybi.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 09:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=pCmeLuXJSDXfNzUsGzoSyKWtmeU8tplKcwFZMo1YlKg=;
 b=nxXUEc6vWaU6mNMECZJ1fXTnroIfnEApi6zht7wz6n+D22WRtLOW3r9UWOoPF2EkVG
 xyCPV8ik8VhY4FR2RtfkaE8AJgUUu/a3gHm90PsFqlSUP55g3URcVMK4tbc97Mxw4FEd
 6mO3GttmYPW/VPrDYh338BYNwsu++VultqYpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=pCmeLuXJSDXfNzUsGzoSyKWtmeU8tplKcwFZMo1YlKg=;
 b=SnCN+0S8hWWBxywU8fHd35liFagYYD6zlI2Wro63LNtgancJ1VCYAXzFkBzZZh/gmr
 ZAc39g0l1zdJxWB//dIi9HOJS+Rax+Cevg9DFpUy/WjBNvtq8uqIl7to9xnYpEHVGGI1
 s+zJES4ms36A9Wv2Fohd0+76sfGjIrZYZlgz2JP8NkdYG7ATwlhPakamR7e+dcXITokI
 CdvG3RZPuKgb9kwu0QYgZVslr04w/IDIyWixHx2vla/AbKHC072EmhYwnG58h7+W0m7H
 tVv3LtxDG+jbB9Da7Qk+QZLxiNnwagbrWf/q4eB6sgN/Z7KX+6mQfXY9pKX6iJRSVRFI
 dD5Q==
X-Gm-Message-State: AA+aEWb2XkNHiI8lzd6kpFunU+s6fndi8FUinMaAqxFZ72QQfBEXv/st
 ozC6xgiB9QZVVQveQ1n4ZsZ0LrseiJA=
X-Google-Smtp-Source: AFSGD/XXEVqOVGZ5M7RzveD1PuB5kWlwxIuncFfYTBDX2ulqC63OQGrOhJXzwGbQMmg1qPGdo31l5g==
X-Received: by 2002:a25:20c5:: with SMTP id
 g188-v6mr34231510ybg.509.1543338206284; 
 Tue, 27 Nov 2018 09:03:26 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com.
 [209.85.219.180])
 by smtp.gmail.com with ESMTPSA id u4sm3451601ywl.29.2018.11.27.09.03.24
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Nov 2018 09:03:24 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id a67-v6so7821010ybg.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 09:03:24 -0800 (PST)
X-Received: by 2002:a25:a445:: with SMTP id
 f63-v6mr32715170ybi.171.1543338204257; 
 Tue, 27 Nov 2018 09:03:24 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Tue, 27 Nov 2018 09:03:23
 -0800 (PST)
In-Reply-To: <8daf27d0-0f58-2dd6-c1bb-7b634494212a@c-s.fr>
References: <ca27a073c872e243be1d17a89afb4b4aeb9a298b.1541714054.git.christophe.leroy@c-s.fr>
 <20181127074316.GC13965@kroah.com>
 <8daf27d0-0f58-2dd6-c1bb-7b634494212a@c-s.fr>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Nov 2018 09:03:23 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLcur2cL8xvpmYOzQ-FZJk35_LSaOhv-ony5sFj6mcGVQ@mail.gmail.com>
Message-ID: <CAGXu5jLcur2cL8xvpmYOzQ-FZJk35_LSaOhv-ony5sFj6mcGVQ@mail.gmail.com>
Subject: Re: [PATCH] lkdtm: do not depend on CONFIG_BLOCK
To: Christophe Leroy <christophe.leroy@c-s.fr>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Nov 27, 2018 at 7:59 AM, Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
>
> On 11/27/2018 07:43 AM, Greg Kroah-Hartman wrote:
>>
>> On Fri, Nov 09, 2018 at 07:05:51AM +0000, Christophe Leroy wrote:
>>>
>>> Most parts of lkdtm don't require CONFIG_BLOCK.
>>>
>>> This patch limits dependency to CONFIG_BLOCK in order to give embedded
>>> platforms which don't select CONFIG_BLOCK the opportunity to use LKDTM.
>>>
>>> Fixes: fddd9cf82c9f ("make LKDTM depend on BLOCK")
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Actually, I don't think any of this is needed, actually. The switch to
kprobes from jprobes meant that the symbols are resolved at runtime
now, so there's no need for the headers at all (nor the Kconfig line).
I'll spin something and send it out...

-- 
Kees Cook
