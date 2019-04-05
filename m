Return-Path: <SRS0=OBm5=SH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331E5C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:41:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7896E20700
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 12:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dmPFvv74";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mtfGayFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7896E20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bKFR3xz0zDqLD
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 23:41:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=codeaurora.org
 (client-ip=198.145.29.96; helo=smtp.codeaurora.org;
 envelope-from=mojha@codeaurora.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=codeaurora.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=codeaurora.org header.i=@codeaurora.org
 header.b="dmPFvv74"; 
 dkim=pass (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org
 header.b="mtfGayFl"; dkim-atps=neutral
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bJYz32MczDqBx
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 23:11:03 +1100 (AEDT)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 7A00061B51; Fri,  5 Apr 2019 12:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1554466261;
 bh=PkDkxY6JlcVrOZdN2LV1ttq74DT8+wLBsYSqUzu8L7k=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=dmPFvv74xWembXcIV9WPQsYhRszDt7iU7SfhKrNWagyKs9KKEiktUZxHI4TYRuPju
 JkTQB5XTuroaMkOXB8NVybc2+vnx2TIEd/72B9sJlRuAKtu1GC8ikFXBcURuReV9yI
 LYN3BpNApOwT6AN6VY3pXRbMMaVclZbhQZi+kP5s=
Received: from [10.204.79.83]
 (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: mojha@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 0226561B54;
 Fri,  5 Apr 2019 12:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1554466239;
 bh=PkDkxY6JlcVrOZdN2LV1ttq74DT8+wLBsYSqUzu8L7k=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=mtfGayFlGRNyJw+VP4XgTML+qMbi50hpUWUUOS/5BxLXNPKwUdBeNvhRTdFTV3X+r
 BOZGR9Na0TM+w6fQkITPUMdLNNTTXmJOzHWH2UBNVkOaj3FMR5I6EtFyDC/QCBw4nN
 qIRBye/+sSrQNwanwbd8WDwVueTglUzgKibxLEss=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0226561B54
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 01/20] ASoC: imx-pcm: Switch to SPDX identifier
To: Andra Danciu <andradanciu1997@gmail.com>, timur@kernel.org,
 nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
 lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 linux-imx@nxp.com, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20190405115010.28838-1-andradanciu1997@gmail.com>
 <20190405115010.28838-2-andradanciu1997@gmail.com>
From: Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <200227b8-5e03-4676-7371-92a3641fde3e@codeaurora.org>
Date: Fri, 5 Apr 2019 17:40:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405115010.28838-2-andradanciu1997@gmail.com>
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
Cc: daniel.baluta@nxp.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


On 4/5/2019 5:19 PM, Andra Danciu wrote:
> Adopt the SPDX license identifier headers to ease license compliance
> management.
>
> Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   sound/soc/fsl/imx-pcm.h | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/sound/soc/fsl/imx-pcm.h b/sound/soc/fsl/imx-pcm.h
> index 133c4470acad..5dd406774d3e 100644
> --- a/sound/soc/fsl/imx-pcm.h
> +++ b/sound/soc/fsl/imx-pcm.h
> @@ -1,13 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
>   /*
>    * Copyright 2009 Sascha Hauer <s.hauer@pengutronix.de>
>    *
>    * This code is based on code copyrighted by Freescale,
>    * Liam Girdwood, Javier Martin and probably others.
> - *
> - * This program is free software; you can redistribute  it and/or modify it
> - * under  the terms of  the GNU General  Public License as published by the
> - * Free Software Foundation;  either version 2 of the  License, or (at your
> - * option) any later version.
>    */
>   
>   #ifndef _IMX_PCM_H
