Return-Path: <SRS0=odmM=FU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C24C4361B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Dec 2020 11:31:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3449E23382
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Dec 2020 11:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3449E23382
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CwtHn1THczDqLH
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Dec 2020 22:31:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::130;
 helo=mail-lf1-x130.google.com; envelope-from=festevam@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=VubTArQy; dkim-atps=neutral
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CwtBJ2QP9zDqQ8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2020 22:26:47 +1100 (AEDT)
Received: by mail-lf1-x130.google.com with SMTP id u18so47417198lfd.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2020 03:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A1HTWkrMiCWdXjch8Wdo2LEnpiN677jiCEapc6u0XM0=;
 b=VubTArQyVKuBy9L0rcU2Q1ai7i/hMZSI0M3LocyMZkbn40L9Pa4IE3DCjUd3BePaJk
 HIPrW2ucNhY60O1nQ+wubUIaRpxry4wVQkGLP1LMST3busHi10lTW3pOvVWG13o5r6a6
 h+tU2Gxt3mbmvTTsnjz6MZkurzo93qEug9iioXyMdQ0jHJGUS/29ssxKUB0mzkx+aGYk
 QjGN5XJzxIlC5dc/tL/ZoaXGJMHkgpTYh3Gq1TKLPnJhAHoYNAqdWwweISe+/QbkUkZH
 4Y9H8NOwsLkfLLN7A/TBdlNmKUGweFK+vUwFI4z5ZwWoxObXUjq7aE62sRtn8VEvivD9
 kHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A1HTWkrMiCWdXjch8Wdo2LEnpiN677jiCEapc6u0XM0=;
 b=YvkYTWHEBQ0pLVsUlFPdmsxMGAO3yn4QggzJDDouXBAmAykamq5LKMa1ly0qyOPgYp
 xouebjiYjjcnfsEDAOj1lLEdVU0fxSkt9NTsGBrQqZ1LTI1rfKb0PDzGwiEf2Akg8W5K
 gR3XgFElzLLCaxXH3NWOt61YX3NQnhB2CL1wiwCTPnZIMtwZQqAf4/Db5JWTRkUBGaU+
 yca2TBCHaqH5Z7uW+b7N0+UDJ4aPSAUVl3FmlmI7aBDElHS4fSh3/WZrSdOzVwbrHc9U
 wCVy5AND3niwkqs2GnQEc9VfXMZuG8PjKbF6wCjFPTffbMgm+5+YDzX7KdgZaJuZtZ21
 Mabw==
X-Gm-Message-State: AOAM530RAYdVCvIzeXd0+p3u2lV60No4wT6Yl4AxzdBpL+mmUAxg91LL
 MT5q9bBg/mNeAZk3siY58ho7oLPa/N9N4DIGBa8=
X-Google-Smtp-Source: ABdhPJzk/F6xIDInXWPZPHeXBh5fRXip+E/mflmi6fxiAaY9HM5oFMwVy4lMd60HPoOAvl0PjA0S0EIA+xOtADyK5iA=
X-Received: by 2002:a2e:8416:: with SMTP id z22mr14917310ljg.347.1608118002624; 
 Wed, 16 Dec 2020 03:26:42 -0800 (PST)
MIME-Version: 1.0
References: <1608115464-18710-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1608115464-18710-1-git-send-email-shengjiu.wang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 16 Dec 2020 08:26:31 -0300
Message-ID: <CAOMZO5AgZhJL-wPXwAt0J=fCt+RA-Toj56X6t9W+HaWuat5VMg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: imx-hdmi: Fix warning of the uninitialized variable
 ret
To: Shengjiu Wang <shengjiu.wang@nxp.com>
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
 Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Shengjiu,

On Wed, Dec 16, 2020 at 7:52 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> From: shengjiu wang <shengjiu.wang@nxp.com>
>
> When condition ((hdmi_out && hdmi_in) || (!hdmi_out && !hdmi_in))
> is true, then goto fail, the uninitialized variable ret will be
> returned.
>
> Signed-off-by: shengjiu wang <shengjiu.wang@nxp.com>
> Reported-by: kernel test robot <lkp@intel.com>

Thanks for the fix.

This should have:

Fixes: 6a5f850aa83a ("ASoC: fsl: Add imx-hdmi machine driver")

Reviewed-by: Fabio Estevam <festevam@gmail.com>
