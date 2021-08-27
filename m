Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B35C432BE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Aug 2021 06:15:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA6BD60F6F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Aug 2021 06:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EA6BD60F6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GwqFq0Kn6z307x
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Aug 2021 16:15:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=NHZ1G+5i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::832;
 helo=mail-qt1-x832.google.com; envelope-from=shengjiu.wang@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=NHZ1G+5i; dkim-atps=neutral
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GwqF14j30z2yHD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Aug 2021 16:14:43 +1000 (AEST)
Received: by mail-qt1-x832.google.com with SMTP id t9so4549215qtp.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Aug 2021 23:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=J6wH6VQ81UagFZrBDuQfg5acAy2kFwSXlQ1BsRDUlyk=;
 b=NHZ1G+5iMYP+XgOXH5UWH9rl5MgrCTsw24zUz0jzVVBz+Xmrufgkm+tVgv6ucD2UWG
 S74VU3T8byNcrBZ2G9VlqPDsKNIlVcW/r7j+CkdQxc+++4BXjItHwYo0t3ILCKB/wnAp
 CEKmr9AqAKKl9+MtHquG8IriOb8ywV+JJXsBmM4iUSnhM+hUfB9rj8osl8FsghWTCPB0
 Ed0v7eB71ig5k51ZQTX8nfHtVuy+Qq6tE+lYQcDGYTg2vpU35rphOC1jKOIDR2H4eiDT
 x2wJV28v4xylCa/M7SwI2380goxX5k+D7RH3VvD14mxt3AKl2gBkdxxTn6eiGYI3K//B
 0PEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=J6wH6VQ81UagFZrBDuQfg5acAy2kFwSXlQ1BsRDUlyk=;
 b=l3S+ty25AiY5GYNVQvH9fAGiXnE921EceFm0DI31oV0nCzMuYx00hbDAjw8bJdOw2l
 Rig8qq/Yg8hHoeMcLRbbcGzPHPJSPKThMaMWaB7oS2v6bUfMQqgceD+Xs02fZXGmfc/U
 R0LhqVOBmPC0XZMEydGf+39gFqFYV37V/pWp1gkUb4QAcdeocsJz8AUfznvly8YK2JUi
 lJjW5wtfuVvSm7jJok1+6/yc/emZJupfjRaSydINydyCffh4IS8aTuqn2ByGr4HblYwK
 oM/RzZ3vqwxT7ofarc2DbQ+gnYhNJ1A0KFkpP5UCrLWU2jQybMMiGvrPveG1VA9w+zD4
 rNdw==
X-Gm-Message-State: AOAM530Hnkgs83N8AVNrNfMppaxxSQ9fFRN5Qo/pbu8EHwPV7BrEdEGd
 ng35fJUIcgHXToypm6SmsswTUc9ugsHmZfiZ/Vc=
X-Google-Smtp-Source: ABdhPJyrAdL7K8XPjqcwtnfWW1RsdpvIxn2uSbruNkxA69ge/iKoWUvnFJynkt+EtCBZhj7XUF4HWM80qKarwD1AKt8=
X-Received: by 2002:ac8:5805:: with SMTP id g5mr6951210qtg.360.1630044880150; 
 Thu, 26 Aug 2021 23:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <1629975460-17990-1-git-send-email-shengjiu.wang@nxp.com>
 <CAOMZO5BCsTMjJJPtLN6_seVcWb24A2ms11FP3HzR0i7t3GLSuA@mail.gmail.com>
In-Reply-To: <CAOMZO5BCsTMjJJPtLN6_seVcWb24A2ms11FP3HzR0i7t3GLSuA@mail.gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 27 Aug 2021 14:14:29 +0800
Message-ID: <CAA+D8AOTAL9H8mr819v9VTQmJvNyKjnRNGPOX64LekjvXXGEcg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: fsl_rpmsg: add soc specific data structure
To: Fabio Estevam <festevam@gmail.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Aug 26, 2021 at 7:54 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Shengjiu,
>
> On Thu, Aug 26, 2021 at 8:19 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> > +       rpmsg->soc_data = of_device_get_match_data(&pdev->dev);
> > +       if (rpmsg->soc_data) {
>
> This check is not necessary, because rpmsg->soc_data is always non-NULL.
>
> Other than that:
>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thanks, I will update in v2.

Best regards
wang shengjiu
