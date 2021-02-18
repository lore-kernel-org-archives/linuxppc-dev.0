Return-Path: <SRS0=eBaR=HU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A53C433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Feb 2021 06:30:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 212F764E0F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Feb 2021 06:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212F764E0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dh4Zh2NgSz3cHr
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Feb 2021 17:30:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=TOewui0l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::434;
 helo=mail-pf1-x434.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=TOewui0l; dkim-atps=neutral
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dh4Z64Q8tz30Jd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2021 17:29:49 +1100 (AEDT)
Received: by mail-pf1-x434.google.com with SMTP id z6so638201pfq.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2021 22:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=yHtGxWfPAIZEvBnGmWjlN6rdZWQnYSnX/GzqtFWIJg0=;
 b=TOewui0lXbhSkNw7mI+ljNrV0hf31Mu/TsPD3Fa99a3Vr6Wnm9DSIF/fn+PxPmZ2lm
 tCnpqmbQxbbYKPyZ2OPqkaj6iPF5hyQ8q2gKRvD3mQhYO7RH1mLUtxn0q/rU7DEZh/Tk
 8UXeYOMrr6MU7miSrQLfrsEcrdOWVSbATP8L3D3gyfXYo7wZnYkAhxBTipoRQKbDk3C9
 GWgh7s/u/U+rg2KvPgji7XIDuKTEWX5JjU/XkNK/F9/9u/QFi4SWv15o96VYRaiH1GLh
 PnbZTKe0NUeT9DyLjPVv8Z0CAbWHpNI0B+WwpKg6cj6gGW/F5oeygzONeFkGEguL2F2M
 n/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=yHtGxWfPAIZEvBnGmWjlN6rdZWQnYSnX/GzqtFWIJg0=;
 b=CSjO0iCaQWlYx2mGqSPpMsYjLPB9r4HGpUuk5re6XIClN/2evpG8+/CAmdT5klj3HW
 r+Gz+XZIM3TjMb1mUkpwPbUry6uVTBn/2VoxIafCi9zSrTy93Lt5OBIKXqLEo8jbZdNI
 zFgZVYrot1ATwk5gN544dMDoT2RCG90uAp6efpQ6odn5dRHFhrPvT9S9Dqx0qtqZbl9R
 c4LeYsEUGDZ2Qj101YMQ6eI411n4wB1omGPhTQgNAE7aHih4+tr56jOwnPi6nCjtK3Yn
 LE5/jr95KX4yUAT3LfidKgyOPz2siM5E52ihgH35S7lgVV+PsdVm/Bpny6uEt5Z3qDrb
 yl8w==
X-Gm-Message-State: AOAM530zYOTJcPUz/j00NyRuDHXYLqZ17cKiAZKks9l4Yb/3mYAdxH7Z
 Lk1Mg3LZ+sqzAMaKGCV003o=
X-Google-Smtp-Source: ABdhPJz8GKaArYRWqmtdtU85HLb1nnRXNt3gTtJ3OrKL0M5imqMeyfTUhg3Lq3SEzz53Npy/tWIGpA==
X-Received: by 2002:a63:547:: with SMTP id 68mr2736959pgf.196.1613629786117;
 Wed, 17 Feb 2021 22:29:46 -0800 (PST)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id l144sm4436954pfd.104.2021.02.17.22.29.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 17 Feb 2021 22:29:45 -0800 (PST)
Date: Wed, 17 Feb 2021 22:30:39 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH 4/4] ASoC: fsl: drop unneeded snd_soc_dai_set_drvdata
Message-ID: <20210218063038.GB13668@Asurada-Nvidia>
References: <20210213101907.1318496-1-Julia.Lawall@inria.fr>
 <20210213101907.1318496-5-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210213101907.1318496-5-Julia.Lawall@inria.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Feb 13, 2021 at 11:19:07AM +0100, Julia Lawall wrote:
> snd_soc_dai_set_drvdata is not needed when the set data comes from
> snd_soc_dai_get_drvdata or dev_get_drvdata.  The problem was fixed
> usingthe following semantic patch: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression x,y,e;
> @@
> 	x = dev_get_drvdata(y->dev)
> 	... when != x = e
> -	snd_soc_dai_set_drvdata(y,x);
> 
> @@
> expression x,y,e;
> @@
> 	x = snd_soc_dai_get_drvdata(y)
> 	... when != x = e
> -	snd_soc_dai_set_drvdata(y,x);
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
