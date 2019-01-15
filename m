Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2600DC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 20:59:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95CE520657
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 20:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95CE520657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fN4g3mJrzDqVk
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 07:59:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.68; helo=mail-ot1-f68.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fN2v4L9hzDqDM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 07:57:59 +1100 (AEDT)
Received: by mail-ot1-f68.google.com with SMTP id i20so3906363otl.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 12:57:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=u6pLGx/0+vlD0wl7xUqGgJTpR0eVUVsQyd1A8iOPGJ0=;
 b=Ks/wt3tA/CU69oHxJml+BgFY/R/3gf49uTCSKJRmF5zWMATlh4RuNwbTD3njwYDqOT
 4SqBPaEmVfiLXnozWYv+2AhDPhQiC0EIdUea1lCBQ1JrbghWPDh3dB37S7wXdNTRsHq0
 /8t9DVk/w7QeaM6V+havf7R9GkLRg2pgknU6Be+jzmK9gK55kHVMotU5cme/HJOSH0Hx
 7tfyeZJURPIoNOQyinXfnLXdgLtAE3KjCT3JulzIsmJ7pXe8CziO1drGDDhBImZn2cSC
 wte7GaWVd59Fn94II6/amO9Qz7Dx8CXKZRr/KGoQvizvjeSWjJ03GucHFl22/aEjZjw0
 fB3w==
X-Gm-Message-State: AJcUukeDD5w0BLUyV+6lZ7s5zLvv2rF9GOpnj6K56GlN9R/IJskPdDbH
 XThjEw39WUHnftVShrMecg==
X-Google-Smtp-Source: ALg8bN4DnB1ZctWsoIpCgu7SPhAARg68Cr1r0PsowhlSBI5gqsjqHrsrJM5VAEbY7eR/hsxtYH0c9A==
X-Received: by 2002:a9d:641:: with SMTP id 59mr3203321otn.215.1547585877058;
 Tue, 15 Jan 2019 12:57:57 -0800 (PST)
Received: from localhost ([70.231.7.113])
 by smtp.gmail.com with ESMTPSA id 62sm1906363otu.42.2019.01.15.12.57.56
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 15 Jan 2019 12:57:56 -0800 (PST)
Date: Tue, 15 Jan 2019 14:57:55 -0600
From: Rob Herring <robh@kernel.org>
To: Viorel Suman <viorel.suman@nxp.com>
Subject: Re: [PATCH v2 4/4] ASoC: add imx-audmix DT binding documentation
Message-ID: <20190115205755.GA4022@bogus>
References: <1546952716-2743-1-git-send-email-viorel.suman@nxp.com>
 <1546952716-2743-5-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546952716-2743-5-git-send-email-viorel.suman@nxp.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "S.j. Wang" <shengjiu.wang@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Cosmin Samoila <cosmin.samoila@nxp.com>,
 Mark Brown <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Viorel Suman <viorel.suman@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Jaroslav Kysela <perex@perex.cz>, Daniel Baluta <daniel.baluta@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jan 08, 2019 at 01:05:51PM +0000, Viorel Suman wrote:
> Add the DT binding documentation for Audio Mixer
> machine driver.
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---
>  .../devicetree/bindings/sound/imx-audmix.txt       | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/imx-audmix.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/imx-audmix.txt b/Documentation/devicetree/bindings/sound/imx-audmix.txt
> new file mode 100644
> index 0000000..6ac1230
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/imx-audmix.txt
> @@ -0,0 +1,24 @@
> +NXP Audio Mixer (AUDMIX) machine driver.
> +
> +Required properties:
> +===================================
> +  - compatible		: Compatible list, contains "fsl,imx-audmix"
> +
> +  - model		: Short audio card description.
> +
> +  - dais		: Must contain a list of phandles to AUDMIX connected
> +			  DAIs. The current implementation requires two phandles
> +			  to SAI interfaces to be provided, the first SAI in the
> +			  list being used to route the AUDMIX output.
> +
> +  - audmix-controller	: Must contain the phandle to the AUDMIX device node.

I don't think you need 2 nodes for this as this one is just a virtual 
device. Just add the dais property to the audmix node.

Rob
