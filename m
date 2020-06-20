Return-Path: <SRS0=Ft5T=AB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224D6C433E0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Jun 2020 20:50:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E5062469E
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Jun 2020 20:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TEHM9w8J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5062469E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49q78j1kqczDqvj
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Jun 2020 06:49:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::144;
 helo=mail-lf1-x144.google.com; envelope-from=linus.walleij@linaro.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=TEHM9w8J; dkim-atps=neutral
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com
 [IPv6:2a00:1450:4864:20::144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49q75v2H9fzDqfS
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Jun 2020 06:47:30 +1000 (AEST)
Received: by mail-lf1-x144.google.com with SMTP id y13so7492156lfe.9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jun 2020 13:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XjItgRxlCwG7kM4tiHMGmFaM+sKcdbDC0+Nnh8enW9M=;
 b=TEHM9w8J5DL8WMBxSWXMSM7g3AT8WZqQ4MmUuryQGW2mHrRezqSiaa+ubCi+VIz8vW
 vGzQ/6aRajbJCPJJk/zYEwvOZ0K9UkWyBcLLNgn94SMpzNHl5YwAoHTw96JAy8/UYwJH
 /SlGZU4qpC3HoFZczOdETesk2RJN2bPxqtZ7ptyf7srcAIwRSlQFhF1Zy0AYM7Qe0WzG
 KoyChVvpkjkTFsaS/k0q7vntqsGXYyYNxLjBoQjdT8/sgEb8tR4EWipi2mitTnDXTPd1
 jQNXQehKHBIdSrYpwdd7+J881kyAdAwXyX/KAd6UufTwjyZIO3flFkPiAKLKIDB2moK3
 cFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XjItgRxlCwG7kM4tiHMGmFaM+sKcdbDC0+Nnh8enW9M=;
 b=nxGQqe07LGQPWqWFE2yQILb4p78aNBzs6iw9kplKr9M0Pknqzj5/KZl7W9SKUYkpOd
 A4CiGzcl603iatO8zikCUoo6A5qNphoBjHpHLhwMzptWpoj+CPbQHCU/l4ahQcEjLxyq
 DVlpsttZa6p3wwUJVEyvRUJ31BWjsZkenUhhqN7yXp9VQ1+87rV7bEzUJgnBS0+ltURX
 O61gP1ujR1Lim4iBJY5BK1lYEhoouASGh0GpoertfewRL706ByJp522JPnQogDaUhg8G
 8IJT9nF0GrNot3ug12/D7c2gshmqlQMW9qb1WoyEMJMJg3ErZJdtAIqnL5+toTFCtHLV
 CE5A==
X-Gm-Message-State: AOAM530FqqvWJCjZpIZRQ17JAZ4KShtKHaE5DymgKSfa6U9rJOjx0ZJZ
 IK0llkmbZavK3RzalzZ0Y/8cQyNN+b1qofvgtAhOBQ==
X-Google-Smtp-Source: ABdhPJylVUTQr8IvfKLH+J/M5vlpR1eJjw41oHLgdp91Fm0bMUP/KIJnEc359B0WLIAjdK0jFVDfSoek4c+gTfVpwzE=
X-Received: by 2002:ac2:5473:: with SMTP id e19mr5435603lfn.21.1592686045343; 
 Sat, 20 Jun 2020 13:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <694a25fdce548c5ee8b060ef6a4b02746b8f25c0.1591986307.git.christophe.leroy@csgroup.eu>
In-Reply-To: <694a25fdce548c5ee8b060ef6a4b02746b8f25c0.1591986307.git.christophe.leroy@csgroup.eu>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 20 Jun 2020 22:47:14 +0200
Message-ID: <CACRpkdYbOAnZb2H1jmD_QCgT7bkFYtpJ8cEGDFDDkJDG6aMhbQ@mail.gmail.com>
Subject: Re: [PATCH v2] tty: serial: cpm_uart: Fix behaviour for non existing
 GPIOs
To: Christophe Leroy <christophe.leroy@csgroup.eu>
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
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
 Jiri Slaby <jslaby@suse.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jun 12, 2020 at 8:26 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:

> devm_gpiod_get_index() doesn't return NULL but -ENOENT when the
> requested GPIO doesn't exist,  leading to the following messages:
>
> [    2.742468] gpiod_direction_input: invalid GPIO (errorpointer)
> [    2.748147] can't set direction for gpio #2: -2
> [    2.753081] gpiod_direction_input: invalid GPIO (errorpointer)
> [    2.758724] can't set direction for gpio #3: -2
> [    2.763666] gpiod_direction_output: invalid GPIO (errorpointer)
> [    2.769394] can't set direction for gpio #4: -2
> [    2.774341] gpiod_direction_input: invalid GPIO (errorpointer)
> [    2.779981] can't set direction for gpio #5: -2
> [    2.784545] ff000a20.serial: ttyCPM1 at MMIO 0xfff00a20 (irq = 39, base_baud = 8250000) is a CPM UART
>
> Use devm_gpiod_get_index_optional() instead.
>
> At the same time, handle the error case and properly exit
> with an error.
>
> Fixes: 97cbaf2c829b ("tty: serial: cpm_uart: Convert to use GPIO descriptors")
> Cc: stable@vger.kernel.org
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v2: Using devm_gpiod_get_index_optional() and exiting if error

Excellent!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
