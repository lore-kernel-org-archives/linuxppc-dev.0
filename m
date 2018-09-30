Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193B4C004D2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 00:47:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83CCB2083C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 00:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LO9vwx2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83CCB2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42NkBp3vgpzF381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 10:47:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LO9vwx2d";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::b41; helo=mail-yb1-xb41.google.com;
 envelope-from=andy.gross@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="LO9vwx2d"; 
 dkim-atps=neutral
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com
 [IPv6:2607:f8b0:4864:20::b41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42NX1c0BYFzF31V
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2018 03:08:31 +1000 (AEST)
Received: by mail-yb1-xb41.google.com with SMTP id w7-v6so4666365ybm.7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Sep 2018 10:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=6CQNURMYAT7I1fWXPU3pC/e50rp/jv2fWdgEqarYD/8=;
 b=LO9vwx2d8xoRY/WWFNcI3PUsw84pjIN+fACo++nowB5K7y248a+YNURNY7gSIl3Dez
 loAOor7q0kYo6UaKzYfSlaG6UbKQYuBwKgXGXvFPPuK2llm3ZMGUpe3mPpJf79rf8xew
 IdMOFE626K9EHN0hMxMkPOY9FVvBtB46FfAP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=6CQNURMYAT7I1fWXPU3pC/e50rp/jv2fWdgEqarYD/8=;
 b=HSzWLDfsEL14HqxUTyjBMbPmvOf8jb6dERDrgAvmuASVLUW/Xx997ePUGp/Da9C6nH
 QJ1zomJogFj0T2+fpEiC2qikg5kwF3tZ9svmx6XfxylYJdC9uLLKQSASiksKUyjam8+2
 c3peIIVyFkl4dKl5OKGJZs1036O43Q3CxzCLm44MPi7u7cIrRELJWKRycqERf64chr4k
 hnbAe34dNLo1cQ//qeCH+2fYYITp+heRNtDfdUTm8/h5t1MTwaw0sbiSfZg02n5soX+4
 IyeLKg3m8KXswcYEvd/ILRPI0/TYuI0Aa6FC94SIDgGxMy4kUh6XY40v3ifz29KXggkC
 +gng==
X-Gm-Message-State: ABuFfoh8KVY62xyU3qqwiybXZNtAm80TJuWao59d5LC0KtYFKAdSpNZi
 8dcHvN2rzwv50mhRYvMDlbdr/Q==
X-Google-Smtp-Source: ACcGV61TlOprfCSaW/Okkd6EwUZs8qMuvHFUNcFGmGRtT/ZPvyJFLpqw3RlC2bUDAT6+/s6t8EaPOA==
X-Received: by 2002:a25:cec9:: with SMTP id
 x192-v6mr4168122ybe.319.1538327309379; 
 Sun, 30 Sep 2018 10:08:29 -0700 (PDT)
Received: from localhost ([2600:1700:141:4960:b19b:8662:2992:bdd8])
 by smtp.gmail.com with ESMTPSA id w201-v6sm1346247ywa.79.2018.09.30.10.08.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 30 Sep 2018 10:08:28 -0700 (PDT)
Date: Sun, 30 Sep 2018 12:08:26 -0500
From: Andy Gross <andy.gross@linaro.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] soc: Convert to using %pOFn instead of device_node.name
Message-ID: <20180930170826.GA2955@hector.attlocal.net>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-43-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828015252.28511-43-robh@kernel.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
X-Mailman-Approved-At: Mon, 01 Oct 2018 10:41:47 +1000
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
Cc: Heiko Stuebner <heiko@sntech.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
 David Brown <david.brown@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Qiang Zhao <qiang.zhao@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Aug 27, 2018 at 08:52:44PM -0500, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: Li Yang <leoyang.li@nxp.com>
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: David Brown <david.brown@linaro.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-soc@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Andy Gross <andy.gross@linaro.org>
