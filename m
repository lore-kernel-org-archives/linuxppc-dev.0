Return-Path: <SRS0=+pA4=RK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F264C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 12:05:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB1272081B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 12:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t8m9aVN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1272081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44FTpf2KYfzDqG0
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 23:05:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=vilhelm.gray@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="t8m9aVN1"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44FTlP66JFzDqCX
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Mar 2019 23:02:25 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id j3so11076804pgm.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Mar 2019 04:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=cCcMg5pc+2dNLPmNs9eB2iLJmfA5xUcfuYlcrGmXBtI=;
 b=t8m9aVN1NyLjx3zvRRZW/3NykwiPUA78aCbsbuDmMg6BeqZP3fQukxDil6iSqzp+R1
 VRJ/qnURD8zjBcIyT69Dp0Mx4S944f0JkP01+J2Xx6VAwtkqbKD6qAvtXJXhcr5tMwQW
 xBMNXZqsvI717a1lUa3mLvRl5eRL3dOImbNicA6T8lKqEoXpUIYdekx+r18WEfehXGQI
 L+VQu35YuFAx+cuAp7OOALV89YItWnm49WZwajN4fZhPPkrzUrBJ5+WQOPhG2RvOgULZ
 GrNR3Bl3xDnlOd5k3ILm3W0jdoR+3vSph4aS7SDa1diIi0acPY+fQZis2rmNX7DOwEok
 b6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=cCcMg5pc+2dNLPmNs9eB2iLJmfA5xUcfuYlcrGmXBtI=;
 b=B5jCSARshrb75lQVtJliCPXgElB+NuwP8w5NgBxvILxMXv3ydjQOuloapaVtRRy39C
 QzD0tV5Oy55UlGF46Y6dr0soQkDNNAayeMqB2m1l0CqbYoBlib0ENbklTHE1yjUc0hg4
 UJ9NAJ649hfPn4JCkJfsSBw03zqBDK2d+FOt94ZH78BJAKez8LEH/cjD7/oZkrB07/K+
 lCXs1+EppBCMess2GmyscQhB0b0LoyELX+HA79e7FboeR0KIDxCKImWlkQzr9heNkLwh
 ytdTEfTPZMgmv3pVFsOXoMvZefgyKPDRRxt1ZIb12QNy6MNR0IFItYb4PmWWllI+GkhT
 /slQ==
X-Gm-Message-State: APjAAAUY49A5TKXBZ27s2h6Ni8LFpDs+8FGLBe9IqQFZTnxFZtS+cfvK
 Nwyq1ZhV5QNTWx0OfOrP5cY=
X-Google-Smtp-Source: APXvYqx5MhCcSKXMxnG5wwoct3amjub16sCaozTvfpqlDSxmpqAhXnq4a3i6NMkiQbsgY16Cg59N1A==
X-Received: by 2002:a65:64d9:: with SMTP id t25mr11165549pgv.244.1551960141488; 
 Thu, 07 Mar 2019 04:02:21 -0800 (PST)
Received: from icarus ([2001:268:c0a4:120d:c70:4af9:86e2:2])
 by smtp.gmail.com with ESMTPSA id q62sm14179288pfi.183.2019.03.07.04.02.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Mar 2019 04:02:20 -0800 (PST)
Date: Thu, 7 Mar 2019 21:03:13 +0900
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Patrick Havelange <patrick.havelange@essensium.com>, jic23@kernel.org
Subject: Re: [PATCH v2 0/7] FlexTimer Module Quadrature decoder counter
Message-ID: <20190307120224.GC7851@icarus>
References: <20190306111208.7454-1-patrick.havelange@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190306111208.7454-1-patrick.havelange@essensium.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
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
 linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
 Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Esben Haabendal <esben@haabendal.dk>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Mar 06, 2019 at 12:12:01PM +0100, Patrick Havelange wrote:
> This patch serie is to be applied on top of 
> https://patchwork.kernel.org/project/linux-iio/list/?series=147
> (a more recent version of the serie is available here : 
> https://gitlab.com/vilhelmgray/iio/tree/generic_counter_v10 )
> 
> Main changes in v2: 
> The code is a bit simpler, thanks to more use of devm_* functions.
> The polling/32bit signed version has been dropped, as not needed and
> no other driver is doing that.
> 
> 
> Patrick Havelange (7):
>   include/fsl: add common FlexTimer #defines in a separate header.
>   drivers/pwm: pwm-fsl-ftm: use common header for FlexTimer #defines
>   drivers/clocksource: timer-fsl-ftm: use common header for FlexTimer
>     #defines
>   dt-bindings: counter: ftm-quaddec
>   counter: add FlexTimer Module Quadrature decoder counter driver
>   counter: ftm-quaddec: Documentation: Add specific counter sysfs
>     documentation
>   LS1021A: dtsi: add ftm quad decoder entries
> 
>  .../ABI/testing/sysfs-bus-counter-ftm-quaddec |  16 +
>  .../bindings/counter/ftm-quaddec.txt          |  18 +
>  arch/arm/boot/dts/ls1021a.dtsi                |  28 ++
>  drivers/clocksource/timer-fsl-ftm.c           |  15 +-
>  drivers/counter/Kconfig                       |   9 +
>  drivers/counter/Makefile                      |   1 +
>  drivers/counter/ftm-quaddec.c                 | 356 ++++++++++++++++++
>  drivers/pwm/pwm-fsl-ftm.c                     |  44 +--
>  include/linux/fsl/ftm.h                       |  88 +++++
>  9 files changed, 519 insertions(+), 56 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-ftm-quaddec
>  create mode 100644 Documentation/devicetree/bindings/counter/ftm-quaddec.txt
>  create mode 100644 drivers/counter/ftm-quaddec.c
>  create mode 100644 include/linux/fsl/ftm.h
> 
> -- 
> 2.19.1

Patrick,

I see you dropped the polling support in this version. If the need
arises in the future, we can discuss a possible ways of resolving your
latency issues; I imagine interrupts during overflow/underflow events to
be a common behavior among counter devices so those too may result in
latency issues as you discovered in your case.

Jonathan,

If you are satisfied with the changes in this patchset, let me know
which patches you like and I'll add respective Reviewed-by tags for you
for the next Counter subsystem introduction patchset submission.

William Breathitt Gray
