Return-Path: <SRS0=QKeg=YJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AA5FA3728
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Oct 2019 16:28:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8FC521D7A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Oct 2019 16:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LgzC5Cn/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8FC521D7A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46td5n5MNzzDr84
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Oct 2019 03:28:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=baylibre.com (client-ip=2607:f8b0:4864:20::541;
 helo=mail-pg1-x541.google.com; envelope-from=khilman@baylibre.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="LgzC5Cn/"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46td3Z33zlzDqR6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2019 03:26:48 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id p30so14600527pgl.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Oct 2019 09:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=2XIK6irSOUYOqaT55Cb2rTG7oY2nstdNhyuJ62jJp1w=;
 b=LgzC5Cn/xPt2olUE60N4pEOt4RSI2ZpcK9ac3jR5QUoHjfZ6KopcgFKySrAzfqZTLK
 xw/GP4Ayp98mwvf5lXiBtokVwF22c/go7Jq2fmAHO3+z/dfZ4UGj2h2lSPA4WPi3wTu5
 kx2xY3EISo3KDeawhuE8CoFt6RS3ckhddrTpZUBfj85vPWLuQ5gjqKgIodSgMg2Z8UOE
 QLXiWAtlZnMJukqaX13llRVWRA5GhM1++i+VT2hv2z7Jz1d1zTL4o+yZm0aV0tI5Dor3
 5/Lm+xvgudiyUXI4Q4b3d+P6YU/hlFTOozKWQPwvl5Qs3pkxxAMSoh8rHBJCZr+G0LNL
 AJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=2XIK6irSOUYOqaT55Cb2rTG7oY2nstdNhyuJ62jJp1w=;
 b=jatij4kQemeq1cCdX6NgpKPzQL4lGaklu9vmzgCfwd5qu/bnNct3w5dvxVzQx4pe2N
 2GhoqdlxbEA5/dkx17kocNePcFu/C9o758phOW/Y/XFR0lpWySkf/6N8hL3Sj6zBaaXt
 O84K+zkK1uewHWDzXpe1+485lhu1jlUUqEwewtDNgWimaeH34giQpPjDTjYO+T30cOQw
 Wji+p2PrmWwLm27A9+0NZS+yry8UTzjCE3oddLubgW29cxNsc4U58LE7ZVIAExGNZ9Yz
 6pGONUQhbg1rlznoe7uRQpSoN6GwPIyed8BRN4CIyTxfZ7QvGKgFg/+Izd3FNa0ZR1Kq
 QQIQ==
X-Gm-Message-State: APjAAAUu/dAJh/vAd5KyYJHNlLpqScimz/PKmY8rnbfFhLNKGp//17or
 fB+6+14BnjHTH2AxSGmX3v5hXQ==
X-Google-Smtp-Source: APXvYqygm5XuOYj8EY825cN0gcWiXGpwZtxv9FetNVUXLKyxWccm3GGuLgq33/o/9nNMAg3YUL0DMw==
X-Received: by 2002:a63:4705:: with SMTP id u5mr24757808pga.317.1571243205298; 
 Wed, 16 Oct 2019 09:26:45 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152])
 by smtp.gmail.com with ESMTPSA id c16sm3155360pja.2.2019.10.16.09.26.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 16 Oct 2019 09:26:44 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: YueHaibing <yuehaibing@huawei.com>, herbert@gondor.apana.org.au,
 mpm@selenic.com, arnd@arndb.de, gregkh@linuxfoundation.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 ludovic.desroches@microchip.com, f.fainelli@gmail.com, rjui@broadcom.com,
 sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, eric@anholt.net,
 wahrenst@gmx.net, l.stelmach@samsung.com, kgene@kernel.org, krzk@kernel.org,
 dsaxena@plexity.net, patrice.chotard@st.com
Subject: Re: [PATCH -next 06/13] hwrng: meson - use
 devm_platform_ioremap_resource() to simplify code
In-Reply-To: <20191016104621.26056-7-yuehaibing@huawei.com>
References: <20191016104621.26056-1-yuehaibing@huawei.com>
 <20191016104621.26056-7-yuehaibing@huawei.com>
Date: Wed, 16 Oct 2019 09:26:43 -0700
Message-ID: <7h4l08hd18.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linux-samsung-soc@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
 linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

YueHaibing <yuehaibing@huawei.com> writes:

> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
