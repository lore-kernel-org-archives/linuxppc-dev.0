Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D73606A336
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QTDp2qmk
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLh9S6D5gz2xVY;
	Sat, 07 Nov 2026 01:18:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793974700;
	cv=none; b=c66/9zSHuJTcEidG6LdHw736q45cGYK6iIU0vCyEKV3Kws/8+i6oyBNSUnJHFgsveA5hbQSTbAFYH1Z8F4iRxglayDj5ixWrtnSGlvQPCPVm5rXmOD1e7XWE/+e5U69mWzyj6N3ioUoqxs2lcQO5EnO3qdedKefAcLSQzDQyn08Sg0K46K8d3bNR/BYuPMt4qH273csyDEWRXdfkb3PmBs+nsNfWqZSt42o+1XF9H99l55RloW8K+/6cK8PUSLoSmbAq1uW3la6OgpNMP3S3IFsNlQjEMHvFmXFIbbZIA67OUFLA8cMI3TJP5oXGhPiJ4QBXGNwTuVO7mDvBIRB0uw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793974700; c=relaxed/relaxed;
	bh=IhULN3ktpaMu4YatjnUsQ9HCtFmBLfNxCrZootrxffo=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Czz0q9XeoVmogfmVkSPyy2aILXhFrkFlZlUjbKZWRQ9eLwCpRIU3w0DvpFKcTOTzLFlhH2MSSZxPjkiRLpTjkQoSTmG3gy3+K/CvPe2Q34Q+o1gNJFfTwIkBqDtLegGHrhQeuztQ9a57iZ3sv4K6279/RrnZOLsGnWVi/4vtfKk2PohS/E1hqiadB6+b6oYDY8J9k+nU1UN+LvGVyzj8AYRvnerRRk5WuFnlr89NXn3L6gxFlZ979BBKxaVx677pM0ks2GQniKl1gH1zY1gv9GJ32QAtAh67zL19YlaBkCso9RiiGUI5Z87gHu2h8OCEO4O34tSsvqRUTPRmimbM1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QTDp2qmk; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QTDp2qmk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLh9R6jHgz2xSS
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 01:18:19 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7E3FA417FC;
	Fri,  6 Nov 2026 14:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2000C1F008A5;
	Fri,  6 Nov 2026 14:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793974697;
	bh=IhULN3ktpaMu4YatjnUsQ9HCtFmBLfNxCrZootrxffo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=QTDp2qmkVvdQ02SbQ9L8Q5K0DOYMChy/MuiXBJehbjuYnAbu2Z7F4uzxaNCTYW76K
	 +Bhg33+LKLhb9PNW9mlJxBox8MzloibsMLDvZgHQurRkrBRDObDkT1gJI1MtqRSNDk
	 Y8khwZL5f4X/kLSlYVtbEZzyTqpmFdatcKwL260aIAP0PX3X2DMfdqCrYIMD5ndCMJ
	 vOvRFl/mgjEkOszakwROajPAEm63EiEE4B6WyfyyCwyor58xLUxvNaogZQK3JOvaoP
	 Wz+2fcrmLd5cp7WBbBNu6/+TLlOTZqHLiVbq3eCMiH8/YIVu6QxJurb/BAAxkNKUdv
	 Xpv7LZLaFfb3g==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 12EA828090D0;
	Fri, 06 Nov 2026 14:18:03 +0000 (GMT)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 06/10] ASoC: fsl_sai: Warn if TE/RE does not clear
 on disable
From: Mark Brown <broonie@kernel.org>
To: phucduc.bui@gmail.com
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>, 
 Shengjiu Wang <shengjiu.wang@nxp.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261105104237.38542-7-phucduc.bui@gmail.com>
References: <20261105104237.38542-1-phucduc.bui@gmail.com>
 <20261105104237.38542-7-phucduc.bui@gmail.com>
Date: Fri, 06 Nov 2026 14:18:01 +0000
Message-Id: <179397468198.3073895.13432289481715460817.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=833; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/cONIyCvIrg9WSjNsvebqxT2+yWptNc/Khax3J5dOII=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLePpyVLhObx+v7u31ztKiexbw9zIwZd3hnTdiuXehzQ
 2b59Oj2jlIWBjEuBlkxRZa4LO6X9SWv1/AdXNgGM4eVCWQIAxenAExkrg8jw/0jW34riQgb8zrq
 RO8xMNrer7J97a+J56d85RQMssua08vwm13r+t4foo8umJcvPDBvb+fb8PsRGwx2BSTW/eW62v+
 HkxUA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> fsl_sai_config_disable() polls TE/RE with an open-coded loop and
> continues silently if the bit does not clear within 1ms. Also, if
> regmap_read() fails, the loop condition evaluates xcsr uninitialized.

>  	/* TERE will remain set till the end of current frame */
> -	do {
> -		udelay(10);
> -		regmap_read(sai->regmap, FSL_SAI_xCSR(tx, ofs), &xcsr);
> -	} while (--count && xcsr & FSL_SAI_CSR_TERE);
> +	ret = regmap_read_poll_timeout_atomic(sai->regmap, FSL_SAI_xCSR(tx, ofs),
> +					      xcsr, !(xcsr & FSL_SAI_CSR_TERE),
> +					      10, 1000);
> +	if (ret == -ETIMEDOUT)
> +		dev_warn(&sai->pdev->dev, "%cx not disabled at frame end\n",

There wasn't a warning before...

> +	else if (ret)
> +		dev_err(&sai->pdev->dev, "failed to read %cSCR : %d\n",

%cCSR.

-- 
Mark Brown <broonie@kernel.org>

