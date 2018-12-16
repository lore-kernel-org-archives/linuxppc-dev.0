Return-Path: <SRS0=MdcX=OZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2193C43387
	for <linuxppc-dev@archiver.kernel.org>; Sun, 16 Dec 2018 00:17:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5F922171F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 16 Dec 2018 00:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RlMoGDpL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F922171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43HPxk0bLTzDqWb
	for <linuxppc-dev@archiver.kernel.org>; Sun, 16 Dec 2018 11:17:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RlMoGDpL";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2a00:1450:4864:20::241; helo=mail-lj1-x241.google.com;
 envelope-from=linus.walleij@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="RlMoGDpL"; 
 dkim-atps=neutral
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com
 [IPv6:2a00:1450:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43HPtn0ptSzDqW2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Dec 2018 11:15:11 +1100 (AEDT)
Received: by mail-lj1-x241.google.com with SMTP id t9-v6so7970283ljh.6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Dec 2018 16:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kaJUjhireTSJd5qGmM0k3oHxv5G0DZYtKI5l31H90S8=;
 b=RlMoGDpLPLuaQLGUbXO5gYsA099s4rrT/kxukisvcP74dk46IahU5Ru7EjijesgHQV
 t1LJIbPaArZO8rC18No7QG30REq6p+oSVTI7BpYLAF579+8n/3Y1BEOUdEKiWmilta2i
 6dhEIUUSVB84c/8+eWA7IzZ1ZOEGECpFxmEWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kaJUjhireTSJd5qGmM0k3oHxv5G0DZYtKI5l31H90S8=;
 b=PVMkW1XCANgygWM8ugWe98Py4CCZsZZLrKpcqJ7MsgWdERqWgK8qqVeVvxScxbLmQh
 qG7eg5t7IsM8MxLRnrOZyuzQ72mcQ1vP9lmFAXNCU2Q96kgBtr3YS5SQcX1RrHYGol/0
 KLaoZ+D6QhV6EyiNgJ3qzH/vAYK81PQyYJvHtOnKG2dzqi5Ga0bsnXSSMZlXKGE1LHd2
 xhKNwRM5wn+UX5s+/7zFc+JNjzGkyy9WHTqevxd30cfMK9tb/s+Lh8IrJcOIx5ifwRqj
 iBnyl3yB+/3SOMKU+t2qpY/4zb7Z85jLXZIp5+lbkyl9LawF3I8WaOZ9sYsb+iTXYJX2
 gNSg==
X-Gm-Message-State: AA+aEWaoO2BJNlzsYlZI0xf3lvzlmaIa4YXaWPvIHKZTB+kLjZoxI/tL
 GYlDVgpwXbPgFYCbkr5LdoRgB9E55Uem5FrHTyFtlA==
X-Google-Smtp-Source: AFSGD/VIgWUvSIZF81NTOi6KJxvqipGZFyBjiMrFPbOHcQ1n20gaGNpZp3a0ZsXyX4ZJi+ovPB5vbPT6LnrB1+nbefU=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr4629589ljj.9.1544919306999; 
 Sat, 15 Dec 2018 16:15:06 -0800 (PST)
MIME-Version: 1.0
References: <3f9179c9a1c8e2486cdd15d28530cd2e381a8830.1544152023.git.christophe.leroy@c-s.fr>
In-Reply-To: <3f9179c9a1c8e2486cdd15d28530cd2e381a8830.1544152023.git.christophe.leroy@c-s.fr>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 16 Dec 2018 01:14:55 +0100
Message-ID: <CACRpkdahnp42c1vT6JHLDVWerCqUH9ugSE4i9Xiu+y49xHE76g@mail.gmail.com>
Subject: Re: [PATCH] gpio: max7301: fix driver for use with CONFIG_VMAP_STACK
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Dec 7, 2018 at 2:07 PM Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> spi_read() and spi_write() require DMA-safe memory. When
> CONFIG_VMAP_STACK is selected, those functions cannot be used
> with buffers on stack.
>
> This patch replaces calls to spi_read() and spi_write() by
> spi_write_then_read() which doesn't require DMA-safe buffers.
>
> Fixes: 0c36ec314735 ("gpio: gpio driver for max7301 SPI GPIO expander")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Patch applied for fixes.

Yours,
Linus Walleij
