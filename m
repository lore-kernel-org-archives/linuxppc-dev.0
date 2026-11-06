Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A5D606D818
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jrx1tx1p
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLh9T10K2z2xlj;
	Sat, 07 Nov 2026 01:18:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793974701;
	cv=none; b=ao75yP57WKFdUOMTxX2STOmGKHaRnAe2yxGf6I2ZiRfh2DqsfyFlW6rXRpya6qOHBxZq4FDX8D7Yggs9GtiHflNyHzx+/D9QzbuwWW7bXr97vK/0+FBQOSMkF1JtiAnw/FSj7LaPvALwsWuzisrBQrtNm3o5cBdyqTAjPnAObS2G2hNzgg1+rH4RMPAcz30/H467KY/00kHAHzv+wfujF4rsijKh320r4hcN77ywFoM+bvh5vuKP9590Tx29wX1XfemqLqJFyr0RU7akezSuUhxdVWY3tXoIf5PDorjJkJWkRQMsodb9oZA160q46rNrjNBV6rekI7MGxpOdV6qPOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793974701; c=relaxed/relaxed;
	bh=NMEUU0nssRZdoXn3hRpYxlPnd+BCkFyCH0PpMWHSR8c=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Vnk58Sd0glzF+A9uxNsWxQXaOfyx9hO0TtqFsCwrmD8wNnDB0RJKjip64/GdsYiGVckVSWmzFnZ8oT0u95bCjdk6Ev5Zo+9/rJdQmGkLq5PndixeRIK5O+s38MUWNzUpqGV7Sy6/oMmTcGE6QI0OHRU7eG9Q3Ca0fjCXnWmcYXpeaF6wLh76pBpmvjqv06hFPEGVnD4drTn8vP1i8sPXVAOURndgq5y/7Q+Oq+yeC63GCIA5fcFPiXuv5RUOKLKkuGUG3tiO06jl07Ra/SgsCJ3ONCEKN1YLFewqW9+K1TwH8RnNwGBXa5Lux0LmK5xloh3QCl6N1Tpb3UVmKWr7KA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jrx1tx1p; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jrx1tx1p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLh9S33x9z2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 01:18:20 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A6305609F5;
	Fri,  6 Nov 2026 14:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A37D1F008A3;
	Fri,  6 Nov 2026 14:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793974697;
	bh=NMEUU0nssRZdoXn3hRpYxlPnd+BCkFyCH0PpMWHSR8c=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Jrx1tx1pWVylKjvtmCH4+8CQq+BXHkZvb940EOnKARH/rc5R8O/0uwPhbArCWiTdc
	 UtegVKcUCfDPwLc9wZu1lzqujuIjXRluhjPYPHXG2OZXoNi0K+qLAdS8nmMvvcC4wz
	 xs/HLqqXhIhNm9xRG0wkSUzP/GIib5IbYH1hZGwrNnKQIJrB/MRTjBjYDbgy0Bfo7H
	 elt6RMDNpw0LqgElYJWA1FQIdiWGcmbklpX9FF60bEhnQ5kngOJtGkZIv/sBCVpYrB
	 jnGNJ2YN7RCaNfiiMWirxcLfzOCq0p6WwcOI7s2oZkZ/Ap5dqgoZs6eBKKeKbFwULH
	 2F+K7ixJnLbaQ==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 100EC28090CF;
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
Subject: Re: [PATCH v2 03/10] ASoC: fsl_sai: Remove redundant error
 messages
From: Mark Brown <broonie@kernel.org>
To: phucduc.bui@gmail.com
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>, 
 Shengjiu Wang <shengjiu.wang@nxp.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261105104237.38542-4-phucduc.bui@gmail.com>
References: <20261105104237.38542-1-phucduc.bui@gmail.com>
 <20261105104237.38542-4-phucduc.bui@gmail.com>
Date: Fri, 06 Nov 2026 14:18:01 +0000
Message-Id: <179397468197.3073895.1522608204443678480.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=919; i=broonie@kernel.org;
 h=from:subject:message-id; bh=hx8mgggRFuXY0KieYJpuHVL6+8FlwuH5JDHh9FUgOkE=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLePpx16MPf6H3lCwqOt+ZnfsufVy/QZfz93ZqaNbX9K
 2XE497HdpSyMIhxMciKKbLEZXG/rC95vYbv4MI2mDmsTCBDGLg4BWAiJ7sZ/rubf+RXKF7jdfar
 hs5el/gX0etiZp83z9cyfenYF++vy8Dwi/n/fJuJb30Duh6fTZotU66nH3AvrFh8qY3I3wrpzMt
 17AA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> The errors are either reported directly by these functions
> or already reported deeper in the call chain, so additional
> dev_err() and dev_warn() calls are unnecessary.

> @@ -1698,9 +1696,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		dev_warn(dev, "Error reading SAI version: %d\n", ret);
>  
> -	ret = fsl_sai_reset_hw(dev);
> -	if (ret < 0)
> -		dev_warn(dev, "Failed to reset hardware: %d\n", ret);
> +	fsl_sai_reset_hw(dev);

This is the only caller of fsl_sai_reset_hw(), it could just return void
now.

>  	ret = devm_request_irq(dev, irq, fsl_sai_isr, IRQF_SHARED,
>  			       np->name, sai);
> -	if (ret) {
> -		dev_err(dev, "failed to claim irq %u\n", irq);
> +	if (ret)
>  		goto err_pm_get_sync;
> -	}

This will only print an error for a subset of errors, things like -EBUSY
will now silently fail.

-- 
Mark Brown <broonie@kernel.org>

