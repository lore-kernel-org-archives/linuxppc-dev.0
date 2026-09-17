Return-Path: <linuxppc-dev+bounces-27630-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC893C88E72
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 17:50:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hm3Dw5FMXz2y8G;
	Fri, 18 Sep 2026 03:50:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789667408;
	cv=none; b=Tj0UXYesnW4ZUiDj0+BvCnrGJ0xf5o/nXeNx7icL/lly3Hs8/ifYAvII/AdjGCAlqo5aH88KCtjXAqCAZhSRZVsfsw15pa0nPM5vmKunXxRzOOq56BqFJzzYRqu/FI/ymlgHE2Wds06qfx9x5WRfnvzGv3rNVR+vgqZLl3GjcnKlXrkHLI16Tpl8M86TguXV2Fkb+L6DM4vOGV342kcWQKNCmsUA15H8NU/n30E2M/WHE5OWlhdAeD73Z8phKtpGQHH+HZmUJamgVImUVTwovBcH7QHFlaZEYzSTB7+/kec4yLqz+XunYDAZjEilEgtX8bgW+gVsUoi/zeXu64doWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789667408; c=relaxed/relaxed;
	bh=koYHEmHF992hOO59AVBGv9/ygNafcPNBRRwBEev9dCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AXWiHrFmL4iPcxWLS0styJzb6LSONa9sSSRPQ7ReV3bIBWyEC7hjEbJsAqmazyGJiIAwb8Q+yhAiCYVJKZIBCkbeC3aDT5nbG0OUNLDm3monQVf5XKy6ISLq8x6b+5UTskEMh161RmAxj5yun/TcEGdLI56xpSbz8GR+M9hubUXcNJanHwUs7Zawch2mj0f0ly4dVE4r46NzS2ViZ48eLPEz4HH6ZPi2uDLs9sEqBl+AceqJ6ivmFvQMWWaHygYlx16IbM8EDVgp9z+ijziVLQsfY2Y5MsU2+ypITpiLhD1W5/758fRmp1TyQe3eKR9Hy1T9hQq3vFTfB/Q9pB2Uzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=G4/CgNPz; dkim-atps=neutral; spf=pass (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=herve.codina@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=G4/CgNPz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=herve.codina@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hm3Dv2SYVz2y2W
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 03:50:05 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id AB9E34E407BD;
	Thu, 17 Sep 2026 17:50:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 69E0F60580;
	Thu, 17 Sep 2026 17:50:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 43EE011C787D7;
	Thu, 17 Sep 2026 19:49:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789667399; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=koYHEmHF992hOO59AVBGv9/ygNafcPNBRRwBEev9dCQ=;
	b=G4/CgNPzK5E12/9/EmIjENcc7TwannYkXgttdS+iILgEN7rNK/7/lxeRP4Rs239QsVgmen
	Rp3kNHvYHrs3mGRmJrvApN9xaKwcGKQuTpPWV6yz2JLBGdat02GKuHEFpEGQrQ747dGkU+
	MrXIpL/cxj/qtmOthtuu5m8HTGt7YKHhmsyZXx3xMQh/Z+CDaceLZMKhx9wW6l55R7Ma1m
	9QBma3nANPpD6Zct7/pj8wZZXCkxDgSTTzq2drihxjgANR+lqsFWiErbW2qWKmiX5ShCFX
	J1M84qWKPQFODr/Hpe24iPlkSckPc6Tzx+smdmz9A8gYEIG7KlS1SsWJnRGs5g==
Date: Thu, 17 Sep 2026 19:49:53 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: broonie@kernel.org, chleroy@kernel.org, leoyang.li@nxp.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, qiang.zhao@nxp.com, stable@vger.kernel.org
Subject: Re: [PATCH] soc: fsl: cpm1: tsa: Fix clock leak in
 tsa_of_parse_tdms()
Message-ID: <20260917194953.69dfd873@bootlin.com>
In-Reply-To: <20260917152719.2160395-1-vulab@iscas.ac.cn>
References: <20260917152719.2160395-1-vulab@iscas.ac.cn>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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

Hi Wentao,

On Thu, 17 Sep 2026 15:27:19 +0000
Wentao Liang <vulab@iscas.ac.cn> wrote:

> The error cleanup loop puts l1rsync_clk and l1rclk_clk a second time
> and never puts l1tsync_clk or l1tclk_clk, because the branches that
> guard the transmit clocks use the receive clock field names.
> 
> Use the matching field in each branch so every clock acquired by
> tsa_of_parse_tdms() is released exactly once.
> 
> Fixes: 1d4ba0b81c1c ("soc: fsl: cpm1: Add support for TSA")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/soc/fsl/qe/tsa.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/tsa.c b/drivers/soc/fsl/qe/tsa.c
> index 4a88e54d25b9..94691369353e 100644
> --- a/drivers/soc/fsl/qe/tsa.c
> +++ b/drivers/soc/fsl/qe/tsa.c
> @@ -865,12 +865,12 @@ static int tsa_of_parse_tdms(struct tsa *tsa, struct device_node *np)
>  			clk_put(tsa->tdm[i].l1rclk_clk);
>  		}
>  		if (tsa->tdm[i].l1tsync_clk) {
> -			clk_disable_unprepare(tsa->tdm[i].l1rsync_clk);
> -			clk_put(tsa->tdm[i].l1rsync_clk);
> +			clk_disable_unprepare(tsa->tdm[i].l1tsync_clk);
> +			clk_put(tsa->tdm[i].l1tsync_clk);
>  		}
>  		if (tsa->tdm[i].l1tclk_clk) {
> -			clk_disable_unprepare(tsa->tdm[i].l1rclk_clk);
> -			clk_put(tsa->tdm[i].l1rclk_clk);
> +			clk_disable_unprepare(tsa->tdm[i].l1tclk_clk);
> +			clk_put(tsa->tdm[i].l1tclk_clk);
>  		}
>  	}
>  	return ret;

Indeed, good catch!

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé

