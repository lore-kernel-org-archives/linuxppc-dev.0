Return-Path: <SRS0=UcJ4=Y5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758A4C5DF60
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Nov 2019 22:08:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5019217F4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Nov 2019 22:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5019217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4773hM27FCzF1P7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Nov 2019 09:08:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.210.68; helo=mail-ot1-f68.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4773f22sl5zF54y
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2019 09:06:17 +1100 (AEDT)
Received: by mail-ot1-f68.google.com with SMTP id n23so8803115otr.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Nov 2019 14:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Gisrq4TxhtoP8Q30cWa1tTfB7XNXHFmOi8fXi53w+bM=;
 b=K0N9rOHyDxHBkAUfKjcPvqn/P8DVnTQgBSryC6dyVmUUMqFrX1zoej1Kb4+VvirTVB
 RsdAAbI1EufoIDgiAX/3vr+Og0gmm1ah35rkNU7UsRLPUhz6eEIYbrx/vmJMtJaCN630
 qydYwaVKkDzxRaTbbl1YWq0kLZ66CmXODppEh5rBt6nBnmQlmvqrIIm5GaAdsN6tqKW2
 yu+WB8v1MVSqi2N2N3+6bl9MzJKYAViwZrf1lXRAp3j1IhmeAHqRwnlF5y/l9bGpY2FQ
 TjRZBUCUmTecSvMSxbdjVR6/KVndA9+pyxCWAJ0V1aMyZfK6zOmJbUGOg+zhBPiyJvEq
 pFtw==
X-Gm-Message-State: APjAAAWhrihQX1+L+H9wSKB3igqru/4K6FSBxJBUdvJORQgSJyGHTsdc
 5D6gfcyyg9tsPBN2eiPNIw==
X-Google-Smtp-Source: APXvYqziXsft0r6jrafQ9WzZOixRtOGMfgoIJWpJT32hv2BnJtDlqlWeelJ4ao+H8Pht1CzipcEy0A==
X-Received: by 2002:a9d:6a50:: with SMTP id h16mr5137307otn.370.1572991575309; 
 Tue, 05 Nov 2019 14:06:15 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id b12sm5910543oie.52.2019.11.05.14.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2019 14:06:14 -0800 (PST)
Date: Tue, 5 Nov 2019 16:06:14 -0600
From: Rob Herring <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V2 1/2] ASoC: dt-bindings: fsl_asrc: add compatible
 string for imx8qm
Message-ID: <20191105220614.GA12397@bogus>
References: <6465fb7dfaa68b6693584bcfa696894628d45fe9.1572435604.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6465fb7dfaa68b6693584bcfa696894628d45fe9.1572435604.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, lgirdwood@gmail.com,
 perex@perex.cz, nicoleotsuka@gmail.com, broonie@kernel.org, festevam@gmail.com,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Oct 30, 2019 at 07:41:26PM +0800, Shengjiu Wang wrote:
> In order to support the two asrc modules in imx8qm, we need to
> add compatible string "fsl,imx8qm-asrc0" and "fsl,imx8qm-asrc1"

Are the blocks different in some way?

If not, why do you need to distinguish them?

> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,asrc.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> index 1d4d9f938689..cd2bd3daa7e1 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
> @@ -8,7 +8,8 @@ three substreams within totally 10 channels.
>  
>  Required properties:
>  
> -  - compatible		: Contains "fsl,imx35-asrc" or "fsl,imx53-asrc".
> +  - compatible		: Contains "fsl,imx35-asrc", "fsl,imx53-asrc",
> +			  "fsl,imx8qm-asrc0" or "fsl,imx8qm-asrc1".
>  
>    - reg			: Offset and length of the register set for the device.
>  
> -- 
> 2.21.0
> 
