Return-Path: <SRS0=mtN4=HE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EEEC433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Feb 2021 02:36:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B836864EAA
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Feb 2021 02:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B836864EAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DV87s3bHXzDqwp
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Feb 2021 13:36:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::832;
 helo=mail-qt1-x832.google.com; envelope-from=shengjiu.wang@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=JvYNweR+; dkim-atps=neutral
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DV86339B7zDqvj
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Feb 2021 13:34:33 +1100 (AEDT)
Received: by mail-qt1-x832.google.com with SMTP id n8so5600672qtp.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Feb 2021 18:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sjpJNs0J12vp1IhfE1UDS+GBxWHaPxs/MJ4w9Q0NI04=;
 b=JvYNweR+f9nFJL+a49zw+w4LD5s+2syVVDuDOHSRvHkCHLFGIMyYDWbWkf5fbjU2CO
 wsls7x8LXSclZD+BZvmtobTH1BqmGUi02ejI7YhnV0jzjab/WhL2Wc+46Ia9ErE3hcGm
 h5DSgwfoPk5/9z4d8cxR10/1pnkrNVMzFwWJYl89cd6SzB4Xo82Q75u4PRoTavfDgQer
 16MJPawwfwF7XrmzeUghiNv+55Mf7pxjxvMyo3gDGPbrny0dU03ARtxudtzPRooYuY6B
 +lFE6zioMVtYH9ceA89q2cuDcIUQJVuzDaKHeE8ILjAxQoIQODLZh80gOJWZoj/tDqjl
 +6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sjpJNs0J12vp1IhfE1UDS+GBxWHaPxs/MJ4w9Q0NI04=;
 b=X3ZoLHz3l5CtG2ejH0B9cc4HPb6QZqLJ3HzlXR+GyTgaAZK9vBh5nMmGeV58ZGNr7Q
 Ept86zv7AZUZZtLfuno1+RzNh+R3+7z8Buzx/bj0L2No/PIvZzBkg9xCCjVYdPFVSbu2
 +r7YkTanqSynYqfHH1N9RPHMD+EB3jWg9TuK5GbgCgjYm5RO47YBS8dkpY9EmH19U7B7
 HZoheCKZCSz/NBzljiCrtjf273SSAplEp4zprnngxrPhES6zTDldh1xsQD9X0xO50N4J
 uXfXEOmZmseOIBE5V+2Xm+O2rqHIVAtV8c5tkQNhSSvKgn6hQbtb1EC59zDOVBbS7j35
 8iag==
X-Gm-Message-State: AOAM5313CSu3N5c4h+ExZhXC/mZrEK6ncrmZfbGUOzXeDDfIrjrrDMv/
 J4O20OuqF2voyaT5hyV6N35siILfzYaC2SufTUk=
X-Google-Smtp-Source: ABdhPJyefunSNBjc33jM0hiZCz2tsvHkqwoJ3p0w2/HJkrB9lJcKW/qY+D7/0W5nvugdLhtFGClyj3y0HT/DvJN4uz4=
X-Received: by 2002:ac8:b0e:: with SMTP id e14mr17833369qti.360.1612233269172; 
 Mon, 01 Feb 2021 18:34:29 -0800 (PST)
MIME-Version: 1.0
References: <20210128112714.16324-1-tangbin@cmss.chinamobile.com>
In-Reply-To: <20210128112714.16324-1-tangbin@cmss.chinamobile.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 2 Feb 2021 10:34:17 +0800
Message-ID: <CAA+D8AN-E7HDHLOO_rnu3spwNS5GczPDMAsM+A3J66Zfhd6G-Q@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Utilize the defined parameter to clear
 code
To: Tang Bin <tangbin@cmss.chinamobile.com>
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
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 perex@perex.cz, Nicolin Chen <nicoleotsuka@gmail.com>,
 Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 28, 2021 at 7:28 PM Tang Bin <tangbin@cmss.chinamobile.com> wrote:
>
> Utilize the defined parameter 'dev' to make the code cleaner.
>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>
