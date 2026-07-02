Return-Path: <linuxppc-dev+bounces-23439-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCBEC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 17:41:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grkhx48CWz2xJT;
	Fri, 03 Jul 2026 03:41:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783014113;
	cv=none; b=SSLNj0ShzH+TeR0z1Ru7Rtko0kgUABtJahj0Gp3tfkLXqDyOVOTILzrIi7hMPJ0vD9H+GxmI/06IEa0dsx/zuZv30xX/5l3RyxHzdQlL7SXzD37Dv1jpQdhhd23gbLIPd3yhgqFWdsYBt5MObrG7eTmTcwSfpinIq/AVzMLz8TW/YjkkX2mnk47jJVYMAFYhD5rJt6q6fz/fb14yjyMq4SR3QRSKR5L2hUfo8yeBgJwdcDOUlzaTPC6vfhdMYeLsi6KDta1qYaNbfwZAnXPoBSXLAnMz5zyX9Uo2Y/Bm6bFIEYGRk8mpm0buYUl5St7RCEJVpDXw9OV6Cersx4iH4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783014113; c=relaxed/relaxed;
	bh=333yUrvHkRG3UJz4DC6yymWTSQQMoVp1nOXtAD9WMA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hrpUjmepEzem+YswL3UmxlaS2KFovhFDvXg/hsvIAX2F0wgBU/KMaUmYFWmRm47VaaDZR8fVG1jNRh4gRojw1m9yVxCMyeam2wrJXdgPwelE4mMOwP0Ui19hgd6xwFA0ICMT8hmwzfN7LWpPC4S5wnoLjL7jd+TN734hxOa/eG1ISM4RqCX4Zu2uhigV8ZW5rCfxrjnz56jnpq1kogWxIh+HX1KSZtk3M79hWtwGxJP1nBHG7ZMwLV6eWzyc9gczXL5OrB2KUjb4mFQ99EJ4Dc/tR019yXGH5o89NQSsLGMclqsFRtTZiLZPdQ5Jh8XOLl5tJptB9y8vLqQ6CTr7CA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=QwGsMLQ+; dkim-atps=neutral; spf=pass (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=maxime.chevallier@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=QwGsMLQ+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.171.202.116; helo=smtpout-04.galae.net; envelope-from=maxime.chevallier@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grkhw61nDz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 03:41:52 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AB58CC4FEE7;
	Thu,  2 Jul 2026 17:32:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 30144602EE;
	Thu,  2 Jul 2026 17:32:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 64165104C958B;
	Thu,  2 Jul 2026 19:32:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783013561; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=333yUrvHkRG3UJz4DC6yymWTSQQMoVp1nOXtAD9WMA8=;
	b=QwGsMLQ+DqpF5JZ+NnixOA+M8lmYER25GoqwC0efJeFI0li+g/47xhqrpPpCeLvv327DAE
	H8HwO/7xTB7AH1gUwp11SVVjBeRshE5MhDuDpPb8c/El1c7KTm9PKcOr6qQ9nUvyp/B+9R
	tLOgnqi/DPNBZKDVb7arIdKD2Hx9Q5URaDh53087/pgZqz2FrqV/8wERH2Glm5T/Thple1
	tZWwgzwEqkxA5ot/XUWLMut4saogTMrBQx//J/c13GvTIjHdynI5qNjsM5FFtNYv0KEJ/c
	zc5/cVQcwpmIcdGov9DBCe7VYlxhX7oNK7xfiVqg7vZ5vwelkHxac1OX2CoEuQ==
Message-ID: <74b45119-46d8-42c2-afea-e0f0bc340304@bootlin.com>
Date: Thu, 2 Jul 2026 19:32:36 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 06/14] net: enetc: simplify
 enetc4_set_port_speed()
To: wei.fang@oss.nxp.com, claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
 xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, wei.fang@nxp.com, chleroy@kernel.org
Cc: imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
References: <20260702025714.456233-1-wei.fang@oss.nxp.com>
 <20260702025714.456233-7-wei.fang@oss.nxp.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260702025714.456233-7-wei.fang@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 7/2/26 04:57, wei.fang@oss.nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> Since phylink only passes valid speed values to mac_link_up, the switch
> statement with its default fallback to SPEED_10 is unnecessary. Replace
> it with a direct call to PCR_PSPEED_VAL(). Also update PCR_PSPEED_VAL()
> to use FIELD_PREP() for proper field masking instead of an open-coded
> shift.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


