Return-Path: <SRS0=n52k=JZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA1AC433B4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Apr 2021 21:08:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D5DE613CE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Apr 2021 21:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5DE613CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FVrnn3rSvz30FX
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Apr 2021 07:08:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=j9k8nqkB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::231;
 helo=mail-oi1-x231.google.com; envelope-from=youling257@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=j9k8nqkB; dkim-atps=neutral
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FVrnG4KV6z2yYd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Apr 2021 07:07:44 +1000 (AEST)
Received: by mail-oi1-x231.google.com with SMTP id i11so2447483oig.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Apr 2021 14:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=afGdW1IegFhA3S/ZCkNtm7XrIKzqvmxIjHYY2ZANXy8=;
 b=j9k8nqkBdnuGNgOj+Rh3eCch737NivoSBjCBKqwSjeKk35/Iab5yY6IULHN7fin/DF
 q0HClLqrQFlegmr0lbsMQyLcbn/hDM3SbyLkv4PohpL1LZf6CfaNM4XUGGEGjvqtsdSx
 bg0pjSaS63r7Jj87jHvHreCTBlwwWqMpcW7XTX2zoAns70/hU0vPw8Dy+l6/L0lAeUzj
 IiQZX7bQaP0qeRM7l35eX2fB2wNkmjCH+tSMG3F3JXJqjQG6zwQ5kmPrZ4zkL2L+YyFO
 OyR5GvEdAptwUdxZe8OeohXHe23YEeMMoxlt81fIlckuPyXnrdrX7pZijaE8YccYTK+E
 0gHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=afGdW1IegFhA3S/ZCkNtm7XrIKzqvmxIjHYY2ZANXy8=;
 b=VYB1YAjm1alo/pOtTvKDYMIQPxSsI4XS0YKZZCQ/IhqsAnACzjCr14WnXKqrIso289
 B7M04c6nHNflUE1pbabDuqyrQojj4U/HXpOvRH4q7F7xuEQkr7+PgxcckLqpoH7/i5qe
 QPhvTLqPOKON/2l60rUSnp+CZw+FyhHjqFc1+V8uCndiOGfRIwbplOKhQkF64Wp5iP+D
 HQ3ASudD1B/+9thLUXv3CvqvrGkOGJTgn8MEZWrIdgVXLvHfyQoqCnkRgO+9AsJ0ecW7
 551oKnsubV4PvX3+vJ1Dwr+3e2LorSsxUt949A6WfDaCvlhS2hVf5ZiR9ACa2TgaScQK
 skIQ==
X-Gm-Message-State: AOAM531tKmR1N5x0JBREwqRAIYJ/W9dkJU5i5MJnydZbgZ4FZJPXNxrM
 wfPUVKsoU/Xbgm47S4U1l54y3Ow+ijY6fR0xs2w=
X-Google-Smtp-Source: ABdhPJz3hDhinOWSyOY7CmIXZ4pP5mqTg5SpsT+T8+gCAX93KMLvIxceeL73x9ixEeHY5VlbMG/zE9bVlBaMUBjNIls=
X-Received: by 2002:aca:3e05:: with SMTP id l5mr2353627oia.39.1619644060566;
 Wed, 28 Apr 2021 14:07:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:2103:0:0:0:0 with HTTP; Wed, 28 Apr 2021 14:07:39
 -0700 (PDT)
In-Reply-To: <YInDdgd2r1SDdv4k@piout.net>
References: <20210110231752.1418816-5-alexandre.belloni@bootlin.com>
 <20210428184946.23999-1-youling257@gmail.com> <YInDdgd2r1SDdv4k@piout.net>
From: youling 257 <youling257@gmail.com>
Date: Thu, 29 Apr 2021 05:07:39 +0800
Message-ID: <CAOzgRdbWKDxAHjUZLemsNBZsctYssyEdfMiF5YpC=nTbjsoSLg@mail.gmail.com>
Subject: Re: [PATCH 04/17] rtc: cmos: remove cmos_rtc_ops_no_alarm
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
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
Cc: linux-rtc@vger.kernel.org, a.zummo@towertech.it,
 linux-kernel@vger.kernel.org, hdegoede@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

test this patch can fix my problem.

2021-04-29 4:20 GMT+08:00, Alexandre Belloni <alexandre.belloni@bootlin.com>:
> Hello,
>
> On 29/04/2021 02:49:46+0800, youling257 wrote:
>> this patch cause suspend failed on my Bay trail z3735f tablet.
>>
>> [  162.038713] PM: dpm_run_callback(): platform_pm_suspend+0x0/0x40
>> returns -22
>> [  162.038760] alarmtimer alarmtimer.0.auto: PM: failed to suspend: error
>> -22
>
> I think I know what is happening, there is one patch I wanted to send
> this cycle but didn't, can you test it?
>
> https://github.com/alexandrebelloni/linux/commit/50641a5a19cedf7561410d7db614da46c228bacc
>
> Thanks for the report!
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
