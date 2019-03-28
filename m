Return-Path: <SRS0=U6gC=R7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA69C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 10:20:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93A65206B8
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 10:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VRhHpNrV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Drhn/Uxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A65206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44VLTn52ClzDqNL
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 21:20:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=codeaurora.org
 (client-ip=198.145.29.96; helo=smtp.codeaurora.org;
 envelope-from=mojha@codeaurora.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=codeaurora.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=codeaurora.org header.i=@codeaurora.org
 header.b="VRhHpNrV"; 
 dkim=pass (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org
 header.b="Drhn/Uxh"; dkim-atps=neutral
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44VLS30lqjzDqNC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 21:18:42 +1100 (AEDT)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id A1E9F61BCB; Thu, 28 Mar 2019 10:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1553768319;
 bh=bK6Sf2HApUV7EdOwGFUFkVAHdGlzyq0/CUNAgsIAxBs=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=VRhHpNrVhnSYHjLnfjHEZ8Q9Yd70BlLRIcBw8NK6y2pIZsGAQ8tDI0GBVyCKzkiz0
 JiAzf543fUO0WUqz834+lXAtn9fBqTwQDlsHhVUubggA64aOTWR0402S1bx6Po3d5E
 BMidNSL7QbWzVl5UklDBo7n5BAnRktyYGE+3abwo=
Received: from [10.204.79.83]
 (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: mojha@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 5D7DF6194E;
 Thu, 28 Mar 2019 10:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1553768317;
 bh=bK6Sf2HApUV7EdOwGFUFkVAHdGlzyq0/CUNAgsIAxBs=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Drhn/UxhQ+kyjSSlDhgpz8sdFSVcbineJBgoqtoyGk6HhFk/P37sU9VdOr3LqEHvp
 vsBvf4uuVooemiyGc2NChK79kYSvGDzfr7cY5zwAH3oSCPsHKF+qig4ym0M/LQALz8
 dXNq9DD0Hn17wK5hQhNlMHULEs8Seta/8dlSV/3w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5D7DF6194E
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH][next] ASoC: fsl: fix spelling mistake: "missign" ->
 "missing"
To: Colin King <colin.king@canonical.com>, Timur Tabi <timur@kernel.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20190328092816.12883-1-colin.king@canonical.com>
From: Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <acedd6b3-9234-390d-1626-ac02223c93cd@codeaurora.org>
Date: Thu, 28 Mar 2019 15:48:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190328092816.12883-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


On 3/28/2019 2:58 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a dev_err message. Fix this.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

> ---
>   sound/soc/fsl/imx-audmix.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
> index 72e37ca6cfbb..7983bd339c01 100644
> --- a/sound/soc/fsl/imx-audmix.c
> +++ b/sound/soc/fsl/imx-audmix.c
> @@ -161,7 +161,7 @@ static int imx_audmix_probe(struct platform_device *pdev)
>   	}
>   
>   	if (!audmix_np) {
> -		dev_err(&pdev->dev, "Missign DT node for parent device.\n");
> +		dev_err(&pdev->dev, "Missing DT node for parent device.\n");
>   		return -EINVAL;
>   	}
>   
