Return-Path: <SRS0=g46S=2F=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77373C43603
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Dec 2019 11:59:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D762620663
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Dec 2019 11:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D762620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47bNHg6cv0zDqC9
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Dec 2019 22:59:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.208.67; helo=mail-ed1-f67.google.com;
 envelope-from=k.kozlowski.k@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47bNFH6ZbhzDq5t
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Dec 2019 22:57:34 +1100 (AEDT)
Received: by mail-ed1-f67.google.com with SMTP id cm12so2717540edb.11
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Dec 2019 03:57:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=3bFRjA9UFM72dx5MZDZ0tLg6rOZz8LMmXjc51eyWHQw=;
 b=REwVdZSfoybJnRiG0TbYA09Fa0Nj45uTjzKm390wI4h0ixmFj/nxBd829wIRkHRGIv
 Y/QqKE8QczKY/vY8z7kKVuelEZbJIhPw0luvi03LANnaZAhHIUpxROnl7N8S9y5W6FVy
 CIm3ipxxJcvpJWvgH9IuGRlPXP9hjeJfsHUStr4kpRHj90ZFP4Q/qJvHmUNPvZfDjRvP
 +LGZdiR6eTvBPAx1ea3GQN5h9YYUcFSJiYfhPG9OcDYTeyzIB/ajqbs1Ps0nUWjwxJFy
 xXec/1MQwPztZL9Ib1Bk0qenIC/59J0QI6NiiyR9NdLGZjMQV5UEYJAeLJ5sWAa1wOHD
 S7rA==
X-Gm-Message-State: APjAAAWOBj+IhegleWCYiBq0tql6XL91LgpNLEAl6sOym2zKaodmfMfS
 9Hico2O5JlTuMynZO7TdGBs=
X-Google-Smtp-Source: APXvYqwZaqP3BPfUD1WWLgwtYw1XJJ7Zy4zkrjF1M4qRiNjNshTKEWnoyc7zscsZ5R0wuEWiJvnvIw==
X-Received: by 2002:aa7:d306:: with SMTP id p6mr26042390edq.72.1576411050586; 
 Sun, 15 Dec 2019 03:57:30 -0800 (PST)
Received: from kozik-lap ([194.230.155.234])
 by smtp.googlemail.com with ESMTPSA id l18sm663825edw.59.2019.12.15.03.57.28
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 15 Dec 2019 03:57:29 -0800 (PST)
Date: Sun, 15 Dec 2019 12:57:27 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH 02/10] soc: samsung: convert to
 devm_platform_ioremap_resource
Message-ID: <20191215115727.GB30973@kozik-lap>
References: <20191214175447.25482-1-tiny.windzz@gmail.com>
 <20191214175447.25482-2-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191214175447.25482-2-tiny.windzz@gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
 khilman@baylibre.com, linux-arm-msm@vger.kernel.org, ssantosh@kernel.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 mripard@kernel.org, leoyang.li@nxp.com, linux-samsung-soc@vger.kernel.org,
 wens@csie.org, agross@kernel.org, khalasa@piap.pl, kgene@kernel.org,
 john@phrozen.org, matthias.bgg@gmail.com, linux-amlogic@lists.infradead.org,
 jun.nie@linaro.org, bjorn.andersson@linaro.org, shawnguo@kernel.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Dec 14, 2019 at 05:54:39PM +0000, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/soc/samsung/exynos-pmu.c | 4 +---

Thanks, applied.

Best regards,
Krzysztof

