Return-Path: <SRS0=OBm5=SH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36290C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:53:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A582520700
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gy7P4AjA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A582520700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bKWB4kBtzDqPP
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 23:53:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::144; helo=mail-lf1-x144.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="gy7P4AjA"; 
 dkim-atps=neutral
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com
 [IPv6:2a00:1450:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bKRV6z9zzDqCW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 23:50:30 +1100 (AEDT)
Received: by mail-lf1-x144.google.com with SMTP id r25so4276009lfn.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Apr 2019 05:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=q30enJ9r4hJQLvpL7crdhRUM7DMqIQDzCsUD5EV14XU=;
 b=gy7P4AjAAE3Uj6i5QXZhwe9nTdcgY9sJM0lYXLBNy1wIlBZ36wyPv7qhToVSV7lOMi
 DDqbSPQ7zIN3amcvztHnB4NALPmyip8WE1RauhnWhmHZyJIXm0HAgN5n9AGvLmGAVAaL
 tmdp3iWbWMNiR1VmJHQdOiI8n6pxCDYFiEMrSykbLDxqpDKvqVu2rB42r4TJd5tsCOri
 cv2WWVGfiyjbrRcXYF0euO41YTnG4Gvl4xhsxMw2KC107ocmJiKVbDEWxLGHUHkgRCmW
 Wt6RtmrkrlkOxjMKNW90v7JfrRWQS0wRbX7NSeYa17tp7oCVUEi+ieqDDzIPV4+6m4WJ
 JiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=q30enJ9r4hJQLvpL7crdhRUM7DMqIQDzCsUD5EV14XU=;
 b=btRSct/K8bCHDQom1VnrMmad0xrWYPpJ5fZdc6+kOxhPK4BDEJeO9bbF4eOg2kOERe
 X29+KmaEwErgtbNdVdQfZopil2YspPFHiqS0ySUKYDxhfS7hYwnC54o9Zn4KvOKz2805
 iGebL042l9dNBsEemEuUvQB/vVAoOW8VpEb2ciDfJN1o4nKBsmbPsPflxsg+NbBKKQUh
 ootO07+jeyJaIgz/um9nh3c6z+agSWnFep19rVx1zX4f/eMQumeIA5ZMzEOQ27U1zMNY
 7W3JQBYLc556XugcnMsgk7mm/w8OZnSrR84GEvZCqsXxXqb+aYnA6USyH1ZLolT5bd0V
 q0wg==
X-Gm-Message-State: APjAAAVErIqLs3q243zphsj0W3GFamWqcGlZUneN+piCIKWVH1iEb9om
 7GxYAOI8QbbtxSofabHFsDtiWm41FKaZ9zWY1iY=
X-Google-Smtp-Source: APXvYqzHXbc6MbD809ZAR4zrh5oBvA+uQDxbdiZIi2xUV+hpgfO8tb9Y848HNjRqC4FQ/NrqugJrhFLVCEaHcEPznTg=
X-Received: by 2002:a19:c51a:: with SMTP id w26mr6497268lfe.59.1554468625958; 
 Fri, 05 Apr 2019 05:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190405115010.28838-1-andradanciu1997@gmail.com>
 <20190405115010.28838-3-andradanciu1997@gmail.com>
 <8e16e9f5-2c0f-a1e6-df0d-67b982db294a@codeaurora.org>
In-Reply-To: <8e16e9f5-2c0f-a1e6-df0d-67b982db294a@codeaurora.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 5 Apr 2019 09:50:17 -0300
Message-ID: <CAOMZO5CZtJq65iUDN2Ao9zt=0_L0iXy-5eRCrHAzQb+3s5rxBA@mail.gmail.com>
Subject: Re: [PATCH 02/20] ASoC: efika-audio-fabric.c: Switch to SPDX
 identifier
To: Mukesh Ojha <mojha@codeaurora.org>
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
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
 Andra Danciu <andradanciu1997@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, timur@kernel.org,
 Xiubo Li <Xiubo.Lee@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Sascha Hauer <s.hauer@pengutronix.de>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>,
 Linux-ALSA <alsa-devel@alsa-project.org>, Shawn Guo <shawnguo@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 5, 2019 at 9:47 AM Mukesh Ojha <mojha@codeaurora.org> wrote:

> Don't change entire thing with //. only above line with the license is
> enough.
>
> Please apply this rule every patch of yours.

Not really. This is the style preferred in this subsystem.
