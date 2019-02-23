Return-Path: <SRS0=sHkL=Q6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1770EC43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 13:51:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54BB620684
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 13:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WB2ISXs7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54BB620684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4468kv4dRMzDqW3
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 Feb 2019 00:51:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=thesven73@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="WB2ISXs7"; 
 dkim-atps=neutral
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4468hk0n9CzDqV9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Feb 2019 00:49:40 +1100 (AEDT)
Received: by mail-ot1-x342.google.com with SMTP id q24so4317690otk.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Feb 2019 05:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iZZakDu9hyOqK8hRWEKSEsLDrqvPzSeiJJ+1UaxV8jA=;
 b=WB2ISXs7Y94/hcwyLpwakIYbddW4QjAEdYeTy2e53bIsIZnslnepSOivwTw/8+DAxV
 7thO5hf9DzW0797GlbEIqxN2TRTm+d3907POGB7UfS3M1bkYtnsSBTaxAO+r2OzWnjiG
 DJgJvb5omsI9QrwNKN9G9+MbFTdLOmpr0qG9jR2dZeKrgGYcETwj3VtcQXOFGYglGHY3
 DtdsPM3gQIcnIgaTrBaLpf/2te8c7dAgDx6JkAFnlWvq8L4FOQ+aWOP1Qog8YsmdhzF7
 a0uSPrb006eGHXV//17rChdM7XjcXnhnL0K6Ekcw3r8gaofQu80hDT1GdehplJHlqc+J
 8Cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iZZakDu9hyOqK8hRWEKSEsLDrqvPzSeiJJ+1UaxV8jA=;
 b=WVphYlL2KZa8nMNGOvDXNiUvhcLc1aXBJyXVbBvZTOUKnEw28qwaTntxIPX4u+LqKY
 juREnoMn2Lqew3ubJzuDlwdYojZo1P+b1bjQDhFEnwEXPlTX55FI168vbPcn8HvyL07v
 xq3mxyYrq2M/ngIIScROB5e0cS9o8JQlyMYG1qSK+cV8aKLSHp7fIljtHs/K4ELI18Rz
 +S45f8Ci77UFpIIzVdVzbVP/s92y5si6aHZktTUjSj70/3PytA/QzOejhptqbdNaySOB
 126b4m4TF4fcj6KWW/CLDtWczeKhOZ5xFYzvxmvNIcDb8JU7VcXzha0hPJ+D4JASIqsk
 37uQ==
X-Gm-Message-State: AHQUAuZerKPMFPuGyAEdv3HpZmKknNk5Dc6vVkWoSYszggAuhGH7hXqY
 yp//jxQpvPt2wj5VOAO8dZFSsTmAsLRZLmAC3NU=
X-Google-Smtp-Source: AHgI3IajCwXp5fSnoPl4W4Q5+DBXPq8184+8maQNEL0KaLIBw+g9z0Ol+2YtKUO+8saKN0YsWu7LBvPwRluiBtZ4SdE=
X-Received: by 2002:a05:6830:1255:: with SMTP id
 s21mr6012932otp.18.1550929778642; 
 Sat, 23 Feb 2019 05:49:38 -0800 (PST)
MIME-Version: 1.0
References: <20190221153550.1932-1-TheSven73@gmail.com>
In-Reply-To: <20190221153550.1932-1-TheSven73@gmail.com>
From: Sven Van Asbroeck <thesven73@gmail.com>
Date: Sat, 23 Feb 2019 08:49:27 -0500
Message-ID: <CAGngYiXx9_iaeRJdfT2O=PPUaWJOr=pbWBgOfTmP8EcRU+MGvg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: remove unsupported formats in i2s master
 mode
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Xiubo Li <Xiubo.Lee@gmail.com>
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
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 Takashi Iwai <tiwai@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Fabio Estevam <festevam@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 21, 2019 at 10:35 AM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> Fix by constraining the frame bits in i2s master mode
> to 32 * channels. This will filter out those formats
> that the ssi cannot support.
>

Russell King (ARM Linux) informs me that this is not correct, and that
the problem
should be approached differently.

Please remove from consideration if you hadn't done so already.
Thanks :)
