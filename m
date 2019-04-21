Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7A8C10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 05:45:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35ABA20869
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 05:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lw2scfNo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35ABA20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44mzFg3PgxzDqC9
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 15:45:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lw2scfNo"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44mzCz3z0TzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Apr 2019 15:43:58 +1000 (AEST)
Received: by mail-pl1-x642.google.com with SMTP id y6so4367264plt.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Apr 2019 22:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Vf9ZzTVGOZz/x/u6WwRzdjPAr0AAJXLHnSaULvX/H/w=;
 b=Lw2scfNo0pCLDnHe5tKXI1aDx1dZBT/8nWeqC51fPd20ooRM+ZfjnszD4D/nYW7qSk
 0LpDxFryk6cwbS+Q32nl4Af42GqFAkTGySqiSOskY9GAviCBk+icX3wzVH9xpVY/eu1l
 hYRITCuzQjo02Fld1Cgc0ZB90ItGXdVksFYCSzyO/K26Z9CEDL3nnS0jv2cMuY56G9sR
 gDPuG40RHiFBEF6tKCWtZ35NgdmsyU6AbVMb45gbBILuggu4rWJ8i05YaiBIgHtPbzl3
 roHL5VU5HxAJbcdA0xGH75qrE7ffR5u1LskYviPH4PG63AuP9lMON24OXolIK4XCqBbN
 NMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Vf9ZzTVGOZz/x/u6WwRzdjPAr0AAJXLHnSaULvX/H/w=;
 b=HnslaFKd2nnKVe4HdiIgpInblrdByTvJMfnSgsyv6ojVTyKTQTFfqpb7D03+boEBe3
 bSfofQOURGJLgKJ5BjSCws239Xm945xLPNpqBEBE4zdapUFtn2k4aWpE3fMGXpzIS+f2
 mpd5hMNR2rThSNvuLCo+5DS8L2F0BYLVVFC1bGRBfMMpRmPbtP8eU7uZf4cuSW+4mze1
 ZxqXrrQHc8Z3fA9Il+igXDlHihbyH6cVNBzFnER7smJcK1iSPPDB2oWPx2rtA0RUTil0
 Gz+i29SUCqMwyt9VIfGm84TNmMpdmun+ulQeQk4hvBWvEzQQeAiMMTe97wKNCVogQJUq
 HpdQ==
X-Gm-Message-State: APjAAAWASALysBEJWS3My+igyCCKcuOwedM9icSmW9ZzS+kVvam76qMk
 hSrZjn11HhM9e1XNy2c89fE=
X-Google-Smtp-Source: APXvYqycOfv25+7ZxLuykBETWy3HEdjzEHq93wNZ6mycPKFc0cEIlLQ9t0k9gcZp9nUbTt7WXyaEpw==
X-Received: by 2002:a17:902:70ca:: with SMTP id
 l10mr4608591plt.228.1555825435519; 
 Sat, 20 Apr 2019 22:43:55 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id r87sm15461428pfa.71.2019.04.20.22.43.54
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 20 Apr 2019 22:43:55 -0700 (PDT)
Date: Sat, 20 Apr 2019 22:43:52 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH 1/2] ASoC: fsl: sai: Add support for runtime pm
Message-ID: <20190421054352.GB683@Asurada-Nvidia.nvidia.com>
References: <20190420155846.10027-1-daniel.baluta@nxp.com>
 <20190420155846.10027-2-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190420155846.10027-2-daniel.baluta@nxp.com>
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

On Sat, Apr 20, 2019 at 03:59:04PM +0000, Daniel Baluta wrote:
> @@ -898,6 +899,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, sai);
>  
> +	pm_runtime_enable(&pdev->dev);

You will need pm_runtime_disable() somewhere, like remove().

Thanks
