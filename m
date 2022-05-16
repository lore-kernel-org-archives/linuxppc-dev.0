Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2B3C433EF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 May 2022 11:19:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L1xbk3jRKz3c8t
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 May 2022 21:19:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=LYQ5Gtiw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::634;
 helo=mail-ej1-x634.google.com; envelope-from=festevam@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=LYQ5Gtiw; dkim-atps=neutral
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L1xb351M1z3brW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 May 2022 21:18:54 +1000 (AEST)
Received: by mail-ej1-x634.google.com with SMTP id n10so27999380ejk.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 May 2022 04:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pmfsIHbJLueJ35bgeNRJJDeDJTrJmP4/XqfMWtgXDDU=;
 b=LYQ5GtiwSVm7LNB+PreZgfk443WWrmBicaCw3pTCFbG34FCjiXhosbAYFm87ix7mRR
 DJbuykytG5jHe5EG6osBFZxVeuf8Z9hE8BDt9SzTkRybx6abf40mMW5G+xJSRv/p/a1f
 qTRa7keeTPtp1GGGOXHQM8N0eQoLXj7ea7UHeT88fG/iZdc4Xg9jPafY821hsfF0XHEy
 zJoRgyRZjzvJpPyk/BgrDPkinijKPpOc1RW0z0SVAEEADPXcaVQInavPQMoLhiRkc7Qu
 2Crt2OFfk1vkgIzdYsOgdea//NZRgRHX6lwxGlINBvHBd7IctLjbcdlueThFG4D5/uMU
 o+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pmfsIHbJLueJ35bgeNRJJDeDJTrJmP4/XqfMWtgXDDU=;
 b=lP3KIxYPnTK+jCFzbg84TIHh4gViHqO+rYB2KJ8AwjsgtHO6Hcqr9SovLw7uOqLHMt
 jsaN9UKhMkv8cx5um7UaG4uvAnRJ/Fmq40uAkaqcksHMJGM3WCnNKiUua9AS0aOxPOMe
 GUS1OFz0uJbZxh6D6FI3e9TAzPcnFrszK7weHL0OSJG/jHxUK2rU7e0XuNp0v9Ei/l3O
 l8yssdrbzOWuKv+UFzLJ9B4DO4r10GcbsaZdWO3XE7jsPBiJh5QweYxu7Ryx9OAnB73b
 5rzaD8jJWDINgiQmAI95v8Zv0RF1B9rcbbMNbHohZBlloAufh1dGRHIKOifVP32uHstx
 hZOw==
X-Gm-Message-State: AOAM530jcMm6Uqj6cEHalwVwqeJjJyvjyCv1TbfTIQg7SLrR6GQt8itp
 s67qwv/urV3YAKpr3kw4Ed9Hy/HTLw6wirFvQXI=
X-Google-Smtp-Source: ABdhPJwgrDSEMVCmTZL7/2CDNe+hDmsyDMJ6mbkGGNi7nbYA9oDjQdMYkNNbKIpX/huxznQlvqJnWRbR8UjgvHonpTk=
X-Received: by 2002:a17:907:7b9f:b0:6f4:d8c5:392c with SMTP id
 ne31-20020a1709077b9f00b006f4d8c5392cmr14484077ejc.652.1652699928032; Mon, 16
 May 2022 04:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <1652688372-10274-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1652688372-10274-1-git-send-email-shengjiu.wang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 16 May 2022 08:18:38 -0300
Message-ID: <CAOMZO5DB9xNfdqffk6k8vLaC6efvGPtUx7NaA5AF1BYL37yaOw@mail.gmail.com>
Subject: Re: [PATCH 0/3] ASoC: fsl_sai: Add support for i.MX8MM, MP, ULP
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 Shengjiu Wang <shengjiu.wang@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Shengjiu,

On Mon, May 16, 2022 at 5:18 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> ASoC: fsl_sai: Add support for i.MX8MM, MP, ULP platforms
>
> Shengjiu Wang (3):
>   ASoC: fsl_sai: Add support for i.MX8MM
>   ASoC: fsl_sai: Add support for i.MX8M Plus
>   ASoC: fsl_sai: Add support for i.MX8ULP

For the series:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
