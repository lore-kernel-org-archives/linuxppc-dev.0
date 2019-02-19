Return-Path: <SRS0=lgwO=Q2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85B2C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 18:57:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDB9F2147C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 18:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6iqVvlE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB9F2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443qjy4dlLzDqJs
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 05:57:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y6iqVvlE"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443qhG1dVbzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 05:56:14 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id i20so218942pfo.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 10:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=eCJsi/sClMlcGZSq/RzjhArlVntOHBohk5vpJvo7ZjM=;
 b=Y6iqVvlEO/r1Y5Dwp65PqH+aKevXK9DYc8MX1wthWIyEg4LRTrkVqzH+CtXq/FHdg6
 DMBmKqcIxWwqjpr7R2ZBBN2L6JEC7Vn7uvWVwBcsYqTRxxBQRbyoDubTAtMfAlutq/jx
 0n/52RLdCorJ+zjlCIreYyN5/EeENNsKUI67oFSUVc0FL9qvxVyzPxT9uzg0k9Ktxixn
 XudFdFC/jhKJWejH3OgbnB54z7DuH/5Nh0t6rkZTjI6Lrw38K3AxDx4sdKjESRHrbch2
 SjXHuURWHFUMzlYzh2VFs4IEjAOUvv/O4RDGsyV8Btz+wsPpvJblGE0zLxemae3Gh0yh
 tvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=eCJsi/sClMlcGZSq/RzjhArlVntOHBohk5vpJvo7ZjM=;
 b=n0N8rRQfPDkPpFKR6RK8polGlkUMSZn+vyOerZxJgjOfDrqY/S+jKE0Wt6OuDSDY4Q
 bI2eEXG/y4Gc7mYworEEe0eKI7b72fh4a6CCFavIKgwNA68e1Uy1BUQ0thiPB2ql9Uyk
 v4I70zKdys0gk7HK1PjKhEaFADeSXZGU7ufUk8cHCtZnSP59T5VsilDfJ8VUMyXGISRz
 IHilDsV0ON3at4N7O5jzROtw9Gr24TXeTUyLLqvnWlMmFCI6RjAT7PmmP2ZZikypDttD
 0RIT2pvzrBggppeo2bIsLjHAgYIgr7Jmd6yKuL6fWiwJDUHmQGMgCXzI2ZBA1FX464f2
 B5hg==
X-Gm-Message-State: AHQUAuaiSAir9YbGZVGpzAv06DSqfsFikHXKgkY9NIkJm59YikFHqYTY
 TiNbR6ZNiuTB5FnywiYItew=
X-Google-Smtp-Source: AHgI3Ia8YGCOHNXxfyPw+ya7GUVeO9IAeGhZymLzD9yXk+drMvtXm3p9oSvcW81vx75zs4BQcHnOUA==
X-Received: by 2002:a65:628e:: with SMTP id f14mr25326479pgv.193.1550602572110; 
 Tue, 19 Feb 2019 10:56:12 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id w10sm18334151pgr.42.2019.02.19.10.56.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 19 Feb 2019 10:56:11 -0800 (PST)
Date: Tue, 19 Feb 2019 10:56:07 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Viorel Suman <viorel.suman@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: fix TXCLK_DF mask
Message-ID: <20190219185606.GA13373@Asurada-Nvidia.nvidia.com>
References: <1550499117-11801-1-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550499117-11801-1-git-send-email-viorel.suman@nxp.com>
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
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Viorel Suman <viorel.suman@gmail.com>,
 Mark Brown <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Feb 18, 2019 at 02:12:17PM +0000, Viorel Suman wrote:
> According to RM SPDIF TXCLK_DF mask is 7-bit wide.
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_spdif.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_spdif.h b/sound/soc/fsl/fsl_spdif.h
> index 7666dab..e6c61e0 100644
> --- a/sound/soc/fsl/fsl_spdif.h
> +++ b/sound/soc/fsl/fsl_spdif.h
> @@ -152,7 +152,7 @@ enum spdif_gainsel {
>  #define STC_TXCLK_ALL_EN_MASK		(1 << STC_TXCLK_ALL_EN_OFFSET)
>  #define STC_TXCLK_ALL_EN		(1 << STC_TXCLK_ALL_EN_OFFSET)
>  #define STC_TXCLK_DF_OFFSET		0
> -#define STC_TXCLK_DF_MASK		(0x7ff << STC_TXCLK_DF_OFFSET)
> +#define STC_TXCLK_DF_MASK		(0x7f << STC_TXCLK_DF_OFFSET)
>  #define STC_TXCLK_DF(x)		((((x) - 1) << STC_TXCLK_DF_OFFSET) & STC_TXCLK_DF_MASK)
>  #define STC_TXCLK_SRC_MAX		8
>  
> -- 
> 2.7.4
> 
