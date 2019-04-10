Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107CAC10F14
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 03:52:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35C3A2133D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 03:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5aeI6Lg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C3A2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44f9Gd5pRMzDqLw
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 13:52:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="e5aeI6Lg"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44f9Dt0XLTzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 13:51:08 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id 188so562547pfd.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Apr 2019 20:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=SLkJscVq0uyJLY5NlqUC/qrKm34P3JAkNB06N2tQOcs=;
 b=e5aeI6Lg+n9LI4NtPt1x/on1FsCH8C02wkpygfeAoTaADBG0tlU2dKjydeLnhYGAAA
 CQzXT/PBCBN9dXyLGgvIwgn11BLgl2yAb6vUy2/6+k3ii3PiWZmt4xH+HtPZ1Hgn9Yfc
 6cbVIrsZuzm1DX6RsBJ8+OQieJbn18qV3Yr7PyNqReVLH7F1BJYphjFBxm5muXh6aErB
 EUsUi+6aC+IVJvClkBcD9tUmetbO1oxTDai4NwcdP1AyaHIjY0yvDwoYkFNvVRPiaM+G
 LPu5UsLDntqDSEFs180A9n2KbC9V8hxIt/A1QwxPRxtIo7p7hN9MiRSjDidB7blHU9nA
 /YpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=SLkJscVq0uyJLY5NlqUC/qrKm34P3JAkNB06N2tQOcs=;
 b=irI1SMIK0XgchQjsZEh8qsZpzt4Y5mcMMkRpbzEolWhZGm/eR3pps7VaGSBjS7U2cD
 fMrBiK8g0RFND7Vqp53LuD4R10Y+yIiCehT5RD1EMXsSn/y4zphjQ5zgnltj7hxJZ5V+
 zDKSCaat35wKdTlfjBe9F5UJBYI1rtuJxu3MbjtnLySJc2KZzoa+BUuNm4iYTHnwYViW
 CQOIQgafPNHXO4FDizy+Q6Bq/FwaQ6taUHgExssnTVBhuLaSCvdr1wVpxTmukCHScXEL
 hDNtYknFD432n6gYAJBkYCYK6kwR4vhF1cg8m0PoQ4DgjhF9NUMJT/QnrwYILqRbej9i
 tjwQ==
X-Gm-Message-State: APjAAAUAQd2P2CpUtux6yp+8M8m9riS//Brr3GUZAy6ddgEflxu8MOC5
 hug26Msp9Z/IUd/nd6YQAUA=
X-Google-Smtp-Source: APXvYqxcUzpitqgB47bac/lbPRL/8czr6QSMMCUbMaPs0v/lKXBvUNAJjnQvqd6UZM+6PQWO5t5YPw==
X-Received: by 2002:a65:6410:: with SMTP id a16mr24956390pgv.315.1554868265377; 
 Tue, 09 Apr 2019 20:51:05 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
 by smtp.gmail.com with ESMTPSA id
 w3sm75406075pfn.179.2019.04.09.20.51.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Apr 2019 20:51:04 -0700 (PDT)
Date: Tue, 9 Apr 2019 20:51:00 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V1] ASoC: fsl_esai: replace fall-through with break
Message-ID: <20190410035059.GA8844@Asurada>
References: <66c117128f300b0ec5f278f538412789c78b60a6.1554715589.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66c117128f300b0ec5f278f538412789c78b60a6.1554715589.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "festevam@gmail.com" <festevam@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Apr 08, 2019 at 09:28:06AM +0000, S.j. Wang wrote:
> case ESAI_HCKT_EXTAL and case ESAI_HCKR_EXTAL should be independent of
> each other, so replace fall-through with break.
> 
> Fixes: 16bbeb2b43c3 ("ASoC: fsl_esai: Mark expected switch fall-through")
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks
