Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B178C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 23:38:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8AE9213A2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 23:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vfYXoioL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8AE9213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RmRW5mggzF3dW
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 09:38:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="vfYXoioL";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="vfYXoioL"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RmNw2dZ0zF3ck
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 09:36:32 +1000 (AEST)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com
 [209.85.160.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 90BC0213A2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 23:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1538782589;
 bh=aqMFIdyTeV1767+9gTuv9gezKvMfSjBHgc/hdUtMveU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=vfYXoioL/IOJZLUbq1BxmTgIg1b8v2qrg1pMaJuGrPZFrWdN9ErOBhX8V243dRb4X
 fk36G6kjjxi4N+5SvwDo6zcvC1XWB6gyYqiqdRi85Mh0ECUY8BprApRVmm5m4WG0Os
 SrVf34rl9o3DxKMI+EUSUCc0j7p6zIQBLAlhwH84=
Received: by mail-qt1-f179.google.com with SMTP id d14-v6so7009854qto.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 16:36:29 -0700 (PDT)
X-Gm-Message-State: ABuFfogAg15Pf6X/a/jge1UTjRkm/BH1Tedrr4inygV7CJVUlbPsnHym
 OxqNK1Y8QYsPoEyF3nVXHsm9MmuhyBYlglBJZg==
X-Google-Smtp-Source: ACcGV62VFMhbwnUifoyIaDmqfgz2PiDP9zN87wHeG1wmofoje728hI4bK+93kHF9L/pjttxfl1eRO8xZPWE8pxcK2iM=
X-Received: by 2002:a0c:8c86:: with SMTP id
 p6-v6mr11319328qvb.246.1538782588825; 
 Fri, 05 Oct 2018 16:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-34-robh@kernel.org>
 <1538777991.28477.6.camel@toradex.com>
In-Reply-To: <1538777991.28477.6.camel@toradex.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 5 Oct 2018 18:36:17 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+pV6HMs25JxFKwfX7_Cj1z2vT1eGWvqPzx7+Wu3-SPeQ@mail.gmail.com>
Message-ID: <CAL_Jsq+pV6HMs25JxFKwfX7_Cj1z2vT1eGWvqPzx7+Wu3-SPeQ@mail.gmail.com>
Subject: Re: [PATCH 33/36] dt-bindings: arm: Convert Tegra board/soc bindings
 to json-schema
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <glikely@secretlab.ca>,
 Arnd Bergmann <arnd@arndb.de>, Tom Rini <trini@konsulko.com>,
 Frank Rowand <frowand.list@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Olof Johansson <olof@lixom.net>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 5, 2018 at 5:20 PM Marcel Ziswiler
<marcel.ziswiler@toradex.com> wrote:
>
> Hi Rob
>
> On Fri, 2018-10-05 at 11:58 -0500, Rob Herring wrote:
> > Convert Tegra SoC bindings to DT schema format using json-schema.
> >

[...]

> Are you aware that -next already features a few updating commits
> thereof from around the beginning of September one of which even bears
> your reviewed-by.

I'm not targeting 4.20, but rather early in the 4.21 cycle. So I'll be
rebasing on rc1 and will update with any changes. I've been doing that
a couple of cycles already.

Rob
