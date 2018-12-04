Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED8AC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 04:52:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A19DF208A3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 04:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eX3Z2FAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19DF208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4388cX0Rp5zDqRL
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 15:52:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eX3Z2FAP";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=viresh.kumar@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="eX3Z2FAP"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4388Yn4dsbzDqRL
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 15:50:19 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id c73so7554498pfe.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 20:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=aYO/z386VNta4UctSXviaV0eojIktFtruslaGj5T1jA=;
 b=eX3Z2FAPyiFwfJg39MtL+iaSaMbHj5OFaKHUeBBI8VONTld5bQeEl+26bNkGxuU51S
 XgvuDbL7HxBHD4gIz7si8AJ1OMQaQrIlKubdmm3qn0v/MscqixrDa2z8djLd5QBXT61F
 ApycqKdmLQDS/PHpC7Epk0rLYyUaBd9M++tcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=aYO/z386VNta4UctSXviaV0eojIktFtruslaGj5T1jA=;
 b=Unzo/QmWz3mcpon977AoyaR6J/xhzbV9OYu4HJLu2P6j06WC/P1Xv+5G9meEzIYxFk
 O7KptV0/PJQF0sVdB7lF7q2+ckkoVuWHY/cCy0vSpWizeC+f9x3R4f5UThSQth7NzUdA
 nd8VVWwkxYxfwT5i5VuGv7nuoNLhjUECcoEGBTpub0n121gE2EIJJY3Q2li70LADpXqu
 4FRppL7ehxenejKdeksSYf/K4ypIzUrgfdIRUnRBoyVzAqOZx32TRobU+3nzI6XafSRN
 3Vv3+Ev/+Pflf1fi/76vrrjaI+R4OqDBBFK5s8bLLFculnIGLcKysAn/Va+3UlhvThWp
 8eug==
X-Gm-Message-State: AA+aEWaPEIk7rBnwgblOkyMKDuFjDn88NZF/iJXFmxcemKXh3oTg7ONF
 OVEBy6wjrNoUOZAjd9GXSpSUjw==
X-Google-Smtp-Source: AFSGD/UAX0MAs8RNeAxBsaKCfBK/eDrOFZA8RfH7eX2u6cmuW/MmsP/VKckyuTCgd4W1+CBAkzYiDA==
X-Received: by 2002:a63:df50:: with SMTP id h16mr15715043pgj.421.1543899016897; 
 Mon, 03 Dec 2018 20:50:16 -0800 (PST)
Received: from localhost ([122.172.23.29])
 by smtp.gmail.com with ESMTPSA id v184sm19346547pfb.182.2018.12.03.20.50.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 20:50:15 -0800 (PST)
Date: Tue, 4 Dec 2018 10:20:12 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 28/34] dt-bindings: arm: Convert SPEAr board/soc
 bindings to json-schema
Message-ID: <20181204045012.gy6xs7nggtcurdu5@vireshk-i7>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-29-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203213223.16986-29-robh@kernel.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
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
 Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 linux-kernel@vger.kernel.org, Grant Likely <grant.likely@arm.com>,
 Viresh Kumar <vireshk@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 03-12-18, 15:32, Rob Herring wrote:
> Convert SPEAr SoC bindings to DT schema format using json-schema.
> 
> Cc: Viresh Kumar <vireshk@kernel.org>
> Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/spear.txt         | 26 -------------------
>  .../devicetree/bindings/arm/spear.yaml        | 25 ++++++++++++++++++
>  2 files changed, 25 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/spear.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/spear.yaml

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
