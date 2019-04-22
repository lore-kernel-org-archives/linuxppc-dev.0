Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CE0C10F14
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 01:21:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF3982075A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 01:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1+8h9SI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF3982075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nTM64XGDzDqRn
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 11:21:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="E1+8h9SI"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nTKQ2SrnzDqNg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 11:20:25 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id z5so4939200pfn.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Apr 2019 18:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=+4T9osTIaYcEG3Jpu+4MnJ8Kx526Y6fIP1TYF6wab5o=;
 b=E1+8h9SIN6TOR8HthrY4iVTKnGaRoSKmf917JfgPybxyIqlcABLTgmCYyH8rPcI8b5
 BRnN9YnRoaLSNENo1qleqNfAT0tsVGf+2CDuhGXz1ByWvk6Fx1sZWpGeTfJW+diNbTDb
 jXNs8wXKXRTes24cvXjnLaGRHi1fNMMslgRqQg6lEGDl+ySpWaBy6ujfSo9/2iOHIPyb
 uOEjDx+S7Cbeu/2fwlj4qddf5dAf6YnWjzrLgB3PaR7alUuEZtRbLTLItnW4pGs0buOH
 W9XC1cyOWNUvDiE4MI7h6LQyiohcOm2IsrVW3OL+2Um1lZaM54HPsCnPmB6CV1NAgfJ5
 gRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=+4T9osTIaYcEG3Jpu+4MnJ8Kx526Y6fIP1TYF6wab5o=;
 b=P3iAgBn8AxMhtr6SYnZsfHrXGq+UhVazvjhVCg0eTcvO6gxrcBd48Shh/gQoemD3IO
 3O+6pggi5cLb39hCNe3L2QiXI3Tj4DzyluG/AEpprHf+7M65wT9JAkxY69WZYfrwOQrl
 NQx+nfFYhiZBWn7qDuOe2IkqfbTHbQ9O77FoEGqO4rt0PWvia+CdQFI7bSczThgnV+VH
 +4N0aN0RgkV34n5U17VVdQc3SmNlmGERTes4jeuK1+OkhxGlACG1LGDR77W9N1z+Iodb
 IiojCTuDeBteLNJkXscgZeCCrf+uYHLSbTyulb4+BhjJIBKSo6yKMFBy30PBD8pbaqlJ
 0ewg==
X-Gm-Message-State: APjAAAU+mp6nf5LLSEJrgXnMieN8W7jAqPDm9ibEjenYGmPskdh/YZLx
 rHqIJfnbFmgMNKQRf5x2C+0=
X-Google-Smtp-Source: APXvYqxNTUGam6v9UkbLLk79znfD79PeYEHi8gq7z71DBmfiF74Y3imut97y2oSm8Nv6lZ5X3dCjOQ==
X-Received: by 2002:aa7:8c13:: with SMTP id c19mr17273412pfd.225.1555896022323; 
 Sun, 21 Apr 2019 18:20:22 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
 by smtp.gmail.com with ESMTPSA id
 d11sm12672773pgq.6.2019.04.21.18.20.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 21 Apr 2019 18:20:22 -0700 (PDT)
Date: Sun, 21 Apr 2019 18:20:17 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH 3/3 v3] ASoC: fsl_sai: Move clock operation to PM runtime
Message-ID: <20190422012017.GC8364@Asurada>
References: <20190421193853.10188-1-daniel.baluta@nxp.com>
 <20190421193853.10188-4-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190421193853.10188-4-daniel.baluta@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "S.j. Wang" <shengjiu.wang@nxp.com>, "tiwai@suse.com" <tiwai@suse.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>,
 "broonie@kernel.org" <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Apr 21, 2019 at 07:39:10PM +0000, Daniel Baluta wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
> 
> Turn off/on clocks when device enters suspend/resume. This
> can help saving power.
> 
> As a further optimization, we turn off/on mclk only when SAI
> is in master mode because otherwise mclk is externally provided.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks
