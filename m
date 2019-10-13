Return-Path: <SRS0=uEoI=YG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22782C4360C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Oct 2019 06:31:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EB55206B7
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Oct 2019 06:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ShHctQMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB55206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46rX0V607ZzDqjk
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Oct 2019 17:31:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2a00:1450:4864:20::342; helo=mail-wm1-x342.google.com;
 envelope-from=ard.biesheuvel@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="ShHctQMI"; 
 dkim-atps=neutral
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46rWyG28XQzDqjX
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Oct 2019 17:29:52 +1100 (AEDT)
Received: by mail-wm1-x342.google.com with SMTP id b24so13677071wmj.5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Oct 2019 23:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KcJ7Kv1ST9YbGxqx4tgfEVL19WmMfSIFjEryHkrxqaM=;
 b=ShHctQMIAMUEsc4GsPIKwVo7BaxtA/IH8w/7Imj4tm0mGBrIFwVfV7ELQaSvJSlEjc
 r6G/5eGmPT4AmRnsFXTU4hud3uI5T8lcoG6t5Au5+2XmTznxgF7jdxBXqGCwcPofCqiN
 K8ePCjmhAVEQSOS48hJ3Ap0yr4Ev4qvnWlpkyPNwMoYW65uFF7td0WNt8yC+znjxNxhf
 f87SIcJ/405TP5H1YSlhz/FYH42vWWIP+YIzS6Fm4lGkEVwyJHIVSgmli91yQqv2xHrr
 6JCiVL8HkhUVImkuKO9S/LYvzH8u8opYzoSE8JUpL4OTKI0HYsQenqJNA0qkll1KaqGB
 luZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KcJ7Kv1ST9YbGxqx4tgfEVL19WmMfSIFjEryHkrxqaM=;
 b=HGv7Wt9FFvZfJX5tGHXglTgIEn24aeab8jG3rYKHO7jRQScSjQWnbiwnU52PcwYETU
 Wj6Bk9UxyzMkx/tuih3vOLkjybhdopJGunRXnqV4dttuK5iBdsLq1Zp5V5I5JttQdfQy
 aRMrQS7hT/BMzFoYH/qOfGbUKRzSLjmXn4Eq5lz6oMDbFwzMbWD46FKyt3IMsb4Z0kg8
 xt802gdwWCcLaGADV1D/RypzTqr0FIeFRBjiwOgWxhQk8wpI8DaP5evTKjSYY1OrvGRX
 nIhJYNnSHm9i5CRmuLgBw1uQ3+cBkhDM5ZOokzXhAToMl0+rsg7UYDli2uW6gU0HrJpI
 aM1Q==
X-Gm-Message-State: APjAAAXr3lXSxFCqftmkzs77vyy2YosTrauaepBPot/g9emNDSY2BT9j
 MmvafHz5jvEOeXjQI9/13WIi1Wk2LapqAfgQE5wP5A==
X-Google-Smtp-Source: APXvYqxQOJKzj7kLS8VKcVx0K23FigMu5lWnFTg7n8/Dbq+Wi535YTj5c3SXPfhU3OGjcDrK5VwCQXY8VlhZG3vRdGQ=
X-Received: by 2002:a7b:ce01:: with SMTP id m1mr9465516wmc.136.1570948187865; 
 Sat, 12 Oct 2019 23:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20191013043918.337113-1-ebiggers@kernel.org>
In-Reply-To: <20191013043918.337113-1-ebiggers@kernel.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sun, 13 Oct 2019 08:29:35 +0200
Message-ID: <CAKv+Gu8nN48aWoeW-aA_1OA_s8Qw0nUbyg+GCZ9DsUA3tDNprg@mail.gmail.com>
Subject: Re: [PATCH 0/4] crypto: nx - convert to skcipher API
To: Eric Biggers <ebiggers@kernel.org>
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Nayna Jain <nayna@linux.ibm.com>,
 Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>,
 =?UTF-8?Q?Breno_Leit=C3=A3o?= <leitao@debian.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 13 Oct 2019 at 06:40, Eric Biggers <ebiggers@kernel.org> wrote:
>
> This series converts the PowerPC Nest (NX) implementations of AES modes
> from the deprecated "blkcipher" API to the "skcipher" API.  This is
> needed in order for the blkcipher API to be removed.
>
> This patchset is compile-tested only, as I don't have this hardware.
> If anyone has this hardware, please test this patchset with
> CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y.
>
> Eric Biggers (4):
>   crypto: nx - don't abuse blkcipher_desc to pass iv around
>   crypto: nx - convert AES-ECB to skcipher API
>   crypto: nx - convert AES-CBC to skcipher API
>   crypto: nx - convert AES-CTR to skcipher API
>
>  drivers/crypto/nx/nx-aes-cbc.c | 81 ++++++++++++++-----------------
>  drivers/crypto/nx/nx-aes-ccm.c | 40 ++++++----------
>  drivers/crypto/nx/nx-aes-ctr.c | 87 +++++++++++++++-------------------
>  drivers/crypto/nx/nx-aes-ecb.c | 76 +++++++++++++----------------
>  drivers/crypto/nx/nx-aes-gcm.c | 24 ++++------
>  drivers/crypto/nx/nx.c         | 64 ++++++++++++++-----------
>  drivers/crypto/nx/nx.h         | 19 ++++----
>  7 files changed, 176 insertions(+), 215 deletions(-)
>

Hi Eric,

Thanks for taking this on. I'll look in more detail at these patches
during the week. In the meantime, I may have a stab at converting ccp,
virtio-crypto and omap aes/des myself, since i have the hardware to
test those.

Thanks,
Ard.
