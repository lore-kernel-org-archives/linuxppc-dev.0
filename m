Return-Path: <SRS0=Kv2y=OJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D9FC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 16:44:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33D7320645
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 16:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izC5STTH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D7320645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4360b90rwGzDrPt
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 Dec 2018 03:44:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="izC5STTH";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::e2f; helo=mail-vs1-xe2f.google.com;
 envelope-from=rsalvaterra@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="izC5STTH"; 
 dkim-atps=neutral
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4360XL3d4nzDrPs
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Dec 2018 03:41:38 +1100 (AEDT)
Received: by mail-vs1-xe2f.google.com with SMTP id v10so3686568vsv.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2018 08:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UonJ2PnWAjB2Lr4NKEazI7qZi6rlUyiK/EF/W9x9mDc=;
 b=izC5STTHUztYtFKMkSv7/wO5b5Tr1Zbfu6oJP7vg4NFAb6p4e1GAi4tXTIMZiGRHH/
 chxM6JrdseicNOaOZA8RvgchVOcmLRW6+bh4B3k5Uit1hDUeX+yLsc8FtqiQRpdFGXDJ
 WPKfP3cT2oVSaoKkLtMtGQPV9naP3JDVlre9cEg4OqE7EN5XAwhqMsj7jD6stXvrntsl
 TG00dW3Uf9zQG91raLg8hVVAI5s3B3KxuCxNJ8duD6dua5fZmh8iu90TgL2Kmjm86qhb
 x9508U4PZAacoJAHSa8zaR8Ev4sGTI2iKfULc/L6K1ZH9TZNoK+R4PCRvUTTWRRlmNjI
 rXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UonJ2PnWAjB2Lr4NKEazI7qZi6rlUyiK/EF/W9x9mDc=;
 b=T3kmUGQdRZ7wjNSoYalAVQmKbyBzIVFvfkrI/bYMndFtTnTyKtgYFpBMic6l1BQeZ2
 kV9uOVgHp3j1t7nmeWUg8VUKAmGBkAlj7yNdS1DnGOkuazEXuLlQPfYPoIkLa/Gv+270
 AvsUEsZHH/3bscJqaGe4xZOjhgsKNc43Yf9oRJmpJm0m5mLEPTJt9/E++q1asgm2orL2
 rGo1jiPRHlIKLTvjevTMYpbBsq0imf61MZb+VYlNYpIMNHT0/WKeWFOamruBOcHGmp+B
 UTYBkobALbk1LXsZUah5ZZ3iZKyX3daDjr2W4mLRlu4xXjtom2uav6M5YjKlFqFX/2iY
 kzWA==
X-Gm-Message-State: AA+aEWangqp82/OZdbA/LvRuj7U5MiJyfYR10legiguiV0k1zyhE5WKH
 xyXoIlccdnBuZTm007nVS0C5BSe9yKWwVFGz1w==
X-Google-Smtp-Source: AFSGD/WsmY4yrV/82QY40O4D53hrtZYVKpSFfy8oL4vbv0OOPMLVxFT566TTktCGjGesF/XZ3EaxdSYCtIPCy5O/eWA=
X-Received: by 2002:a67:87cf:: with SMTP id j198mr2591475vsd.104.1543596095487; 
 Fri, 30 Nov 2018 08:41:35 -0800 (PST)
MIME-Version: 1.0
References: <CALjTZvZzHSZ=s0W0Pd-MVd7OA0hYxu0LzsZ+GxYybXKoUQQR6Q@mail.gmail.com>
 <20181130103222.GA23393@lst.de>
 <CALjTZvZsk0qA+Yxu7S+8pfa5y6rpihnThrHiAKkZMWsdyC-tVg@mail.gmail.com>
In-Reply-To: <CALjTZvZsk0qA+Yxu7S+8pfa5y6rpihnThrHiAKkZMWsdyC-tVg@mail.gmail.com>
From: Rui Salvaterra <rsalvaterra@gmail.com>
Date: Fri, 30 Nov 2018 16:41:21 +0000
Message-ID: <CALjTZvbhNbKRZuwoAy5Uons_xfKcxOpA79=GZKsDs-Md8YBwsw@mail.gmail.com>
Subject: Re: use generic DMA mapping code in powerpc V4
To: hch@lst.de
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi, Christoph,

Your powerpc-dma.5 branch seems to be working fine on my G5, so

Tested-by: Rui Salvaterra <rsalvaterra@gmail.com>

Thanks again!
Rui
