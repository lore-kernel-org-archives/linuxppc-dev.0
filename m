Return-Path: <linuxppc-dev+bounces-16719-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3759E7C708
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Feb 2026 07:50:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f8cM05MMzz2yFm;
	Mon, 09 Feb 2026 18:50:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770623452;
	cv=none; b=YdHzn5/tqi03hAUdl9uK9EkVLMi4suhkGK/Fk01RQg41dQilbzqTLH44b6xj29xpLqTa9FvJMue4frM+uspZ1sXbq8waxZ1HDb6BfhbtrmZpdZksU4gLJU8JvwRfsvb41DB9ZtGJDRa+ltpxn/VrGTmAsgI3NgrSetxYJf5UefjVPfqL28xXZZOFX8ukL4S0fGxxnLTEJ7M1fuYnU2mdyGn+wmCAmcQJ7Yqbnwjd/uCe2HfSKAph+mxxPPkBluAluu9Kiga9dmp5C4megzfXcRzGBYWpN8QjGi08j840SO3N+dqoFqOR+KidpAHWU4pZgjXUTQxmFZ4dFZlnQ4srpg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770623452; c=relaxed/relaxed;
	bh=8i56GTaGC/9+4V5YZ5iJPhAgIdFBtU7C0Akhyek3/LY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3CDdelXL9sAPQXerQqkk/AR6YEhCxy3TV4sshTCsDBUc9EQrY6lvJTvql3RPHkdlCNoUWfMUEQGwnWZorHbXKuZ9diStYu/4Zeu1/lbhhg/ON3i5AM0RdLAfH3tfr4LqEMyKkJ9Fa2VQEOVmJuX4KamL2msZaN03fqlBa7w7r+4yDlEOaiOhsS95Dn7w/7uuxNeGPU+BtHegvAqW16s/489al2bbNJlEAbvSrjV3vHIv4MwHc9o+qZPhTFRFWmxgusgKcEZb4XHCX0/ApIYmwdSoWpDqxNAfurcefzjA8kvTbrX5FnWGQnrEJ0YSsHmcPe2MQ2KvJB6DEWP5za7LQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=2PrvtuiD; dkim-atps=neutral; spf=pass (client-ip=185.246.84.56; helo=smtpout-02.galae.net; envelope-from=herve.codina@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=2PrvtuiD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.84.56; helo=smtpout-02.galae.net; envelope-from=herve.codina@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f8cLy5gFBz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Feb 2026 18:50:48 +1100 (AEDT)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 259AF1A2CAC;
	Mon,  9 Feb 2026 07:50:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E43686074B;
	Mon,  9 Feb 2026 07:50:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 36883119D14CA;
	Mon,  9 Feb 2026 08:50:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770623442; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8i56GTaGC/9+4V5YZ5iJPhAgIdFBtU7C0Akhyek3/LY=;
	b=2PrvtuiDY6gwTtoHPX1LiFaakxuI+sc52SUFwWRWHLSbLs1lFfcIXKcjtFyt92kfYmDe1H
	N/NFH/orRCnrW2cbOy1t4qx+hrAoRV88T3XYIrlfiWc4qj34Ib9NxWNHSKv3CN4Qle8BT/
	XeO1CYtdVM7PItm4Pg1OQuTe9Q5I4cQtyM+JPPY0sQafefaoVf/sW3QPF1J4SRzhtwCqv+
	SEgk5KZl93jdSPvWu7VqAJ31XX5d8l3gEwU792jRZaNgfdpmt3zIrDvF6Qbdc4hobV/LnJ
	VjV5cfcrJJ/+xfdkYDBRjGS5N27mT+iua0aUGJ9CqPaqiF2wKO8YIEv3TM8b4Q==
Date: Mon, 9 Feb 2026 08:50:35 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: qiang.zhao@nxp.com, chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: fsl: cpm1: qmc: Fix error check for
 devm_ioremap_resource() in qmc_qe_init_resources()
Message-ID: <20260209085035.1d7db80a@bootlin.com>
In-Reply-To: <20260209015904.871269-1-nichen@iscas.ac.cn>
References: <20260209015904.871269-1-nichen@iscas.ac.cn>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Chen,

On Mon,  9 Feb 2026 09:59:04 +0800
Chen Ni <nichen@iscas.ac.cn> wrote:

> Fix wrong variable used for error checking after devm_ioremap_resource()
> call. The function checks qmc->scc_pram instead of qmc->dpram, which
> could lead to incorrect error handling.
> 
> Fixes: eb680d563089 ("soc: fsl: cpm1: qmc: Add support for QUICC Engine (QE) implementation")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/soc/fsl/qe/qmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
> index c4587b32a59b..672adff8e35f 100644
> --- a/drivers/soc/fsl/qe/qmc.c
> +++ b/drivers/soc/fsl/qe/qmc.c
> @@ -1790,8 +1790,8 @@ static int qmc_qe_init_resources(struct qmc *qmc, struct platform_device *pdev)
>  		return -EINVAL;
>  	qmc->dpram_offset = res->start - qe_muram_dma(qe_muram_addr(0));
>  	qmc->dpram = devm_ioremap_resource(qmc->dev, res);
> -	if (IS_ERR(qmc->scc_pram))
> -		return PTR_ERR(qmc->scc_pram);
> +	if (IS_ERR(qmc->dpram))
> +		return PTR_ERR(qmc->dpram);
>  
>  	return 0;
>  }

Yes, indeed.

Thanks for the fix.

Acked-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé

