Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1769C282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 08:05:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C223222B5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 08:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Il8S2LIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C223222B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zsWj3SNszDqVq
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 19:05:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2a00:1450:4864:20::341; helo=mail-wm1-x341.google.com;
 envelope-from=lee.jones@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="Il8S2LIQ"; 
 dkim-atps=neutral
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zrhC3wJGzDqKW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 18:27:23 +1100 (AEDT)
Received: by mail-wm1-x341.google.com with SMTP id x10so1205181wmg.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 23:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=ougDmMsACf0IXoScSd8bSpPQfh5iP2Vt3unj4CIa8E8=;
 b=Il8S2LIQg33Qcq8+uP7U/u3imYzP54lQZDAEEM5CF+kzID+q9sgm0f1PMHhfWqZiXS
 sh4DwdtHssUQrTbvsgx/oN/zcldkDP8Y8AeZzzRpPf1/injx//G+/Cf2r9GxWr4arkMl
 qCn6fydje/0+xe2IbXvOI0key5mboqPkQuUJ2aw8uOlM4sJVE1UARhZIKvW7hordAhSn
 +mVl08ksWPLgh21Ba7GdUgWYDOSD17cDkb57YKWs1Q69ULviavQangrTgmzX8DKCm5F1
 2hv9/wSO2ZgTfUhXjLdT/7j08glaH7922e9zMgNG7RB4Gf+HoF3hv0LQiWm+LqwXzCuu
 0qiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=ougDmMsACf0IXoScSd8bSpPQfh5iP2Vt3unj4CIa8E8=;
 b=LxVeww967i+O5L4y6ff7kxFLOQzh2laGrKuHa6nAEkImqu3WyXx+ddDoCaJnr4SIFI
 ZlIn0SFbRFm8oYpjJ8LWHbOKMygk6ld99tiqFatVNCE+nE4zk1lyduEu6ehsLXTyaksc
 3mSQ1pjGc8rAkhyIQu2fkGuuD8CQakG8T3Fy7ymRgIMasZdUsDCqbo8L2f9+Sk9f3Ki8
 z27VnLiol+tP2JdDydm6YN/LeIy1/xi8rWTnS5O4Ue3oqPaQjDjC8MShlhOnRx0E4NKL
 wXxI6kTVnV2HQ6fq3Qucz/yBD8TOsh4HeAFTRc+svaukiso4J+S5nB50yqBf64KDPv/I
 Eocw==
X-Gm-Message-State: AHQUAubMaLJlz8Ta64r2ymJ4UBPhYBJ7bR3WPa5Mem+Ted/vp6I+CvR/
 nK6get2RpaWovQfZwtu08t7svA==
X-Google-Smtp-Source: AHgI3IbW4eZ4PSEG6OMXvEyDow8gFmlqHoPShqVgICSkNax3h+8NXljNYO2fYKDgGUm+UxblAX9GyA==
X-Received: by 2002:a1c:c441:: with SMTP id u62mr2202451wmf.69.1550042838527; 
 Tue, 12 Feb 2019 23:27:18 -0800 (PST)
Received: from dell ([2.27.35.171])
 by smtp.gmail.com with ESMTPSA id n9sm12417168wrx.80.2019.02.12.23.27.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Feb 2019 23:27:17 -0800 (PST)
Date: Wed, 13 Feb 2019 07:27:16 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 06/12] dma-mapping: improve selection of
 dma_declare_coherent availability
Message-ID: <20190213072716.GC1863@dell>
References: <20190211133554.30055-1-hch@lst.de>
 <20190211133554.30055-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190211133554.30055-7-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: linux-xtensa@linux-xtensa.org, linux-sh@vger.kernel.org,
 devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-riscv@lists.infradead.org,
 linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 11 Feb 2019, Christoph Hellwig wrote:

> This API is primarily used through DT entries, but two architectures
> and two drivers call it directly.  So instead of selecting the config
> symbol for random architectures pull it in implicitly for the actual
> users.  Also rename the Kconfig option to describe the feature better.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arc/Kconfig            | 1 -
>  arch/arm/Kconfig            | 2 +-
>  arch/arm64/Kconfig          | 1 -
>  arch/csky/Kconfig           | 1 -
>  arch/mips/Kconfig           | 1 -
>  arch/riscv/Kconfig          | 1 -
>  arch/sh/Kconfig             | 2 +-
>  arch/unicore32/Kconfig      | 1 -
>  arch/x86/Kconfig            | 1 -

>  drivers/mfd/Kconfig         | 2 ++

If everyone else is happy with these changes, then so am I.

  Acked-by: Lee Jones <lee.jones@linaro.org>

>  drivers/of/Kconfig          | 3 ++-
>  include/linux/device.h      | 2 +-
>  include/linux/dma-mapping.h | 8 ++++----
>  kernel/dma/Kconfig          | 2 +-
>  kernel/dma/Makefile         | 2 +-
>  15 files changed, 13 insertions(+), 17 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
