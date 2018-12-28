Return-Path: <SRS0=XWqB=PF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC28C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Dec 2018 23:34:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBB79217F9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Dec 2018 23:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB79217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43RNMn0CgczDqDQ
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Dec 2018 10:34:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.166.193; helo=mail-it1-f193.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-it1-f193.google.com (mail-it1-f193.google.com
 [209.85.166.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43RNKV73WLzDqD2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Dec 2018 10:32:30 +1100 (AEDT)
Received: by mail-it1-f193.google.com with SMTP id b5so28628415iti.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2018 15:32:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=bDHG4WxsQ4XcgMtdWfJAeEhz4qeg/bC5OHWrj6fBTQ4=;
 b=Wd8aoQznCvKYQaxz2iR5qkrd+ReEPVhmTxe21azgxRZr+XnYIcKG7L74mCUjxq9ziA
 mpuvW1Oxi/gynY+5oBQMbaX+2lc05zmrx/FID+zDpg1fbN+aF5y1Egs5Z1bemGtofR3r
 POkGutR2lEFGYkIwZp25wWEy2YJAbt2sDbs+XkvJLJspKja3IrpUoqkpccZ5FI5iCjr/
 XZJCxvmQfK/ZKQpH0MigR4aXA3Pwh+AI5h3ZhiDJ0KQ3DB4WAV02RYgpO647ddBfLfTA
 pvcwjeEoQUkwCZlauZqpxACSJfDdEQW+jPDOYU+Msl0pXxJ58/0nrsMHzFtKIMnpvzbw
 G+vw==
X-Gm-Message-State: AA+aEWZKS0rTUREbbGE1CAOpx8ARzm+k0BtKIg1Y9RdAhkAT8MIftu4K
 hzRKOBq6Kuox4iyj42FrDg==
X-Google-Smtp-Source: ALg8bN6z03ibk7/wIHYgokFtoipKXTDtOTPpHFbT3hE5X6kN/QXKAkjKhQf4ozc2gpaP4JQTwhqQHA==
X-Received: by 2002:a05:660c:741:: with SMTP id
 a1mr17915815itl.100.1546039948287; 
 Fri, 28 Dec 2018 15:32:28 -0800 (PST)
Received: from localhost ([24.51.61.172])
 by smtp.gmail.com with ESMTPSA id w16sm17487750ita.38.2018.12.28.15.32.27
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 28 Dec 2018 15:32:27 -0800 (PST)
Date: Fri, 28 Dec 2018 17:32:26 -0600
From: Rob Herring <robh@kernel.org>
To: Viorel Suman <viorel.suman@nxp.com>
Subject: Re: [RFC PATCH] ASoC: fsl: Add Audio Mixer CPU DAI driver
Message-ID: <20181228233226.GA11728@bogus>
References: <1545150569-14897-1-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545150569-14897-1-git-send-email-viorel.suman@nxp.com>
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
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Jaroslav Kysela <perex@perex.cz>, Daniel Baluta <daniel.baluta@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Dec 18, 2018 at 04:30:01PM +0000, Viorel Suman wrote:
> This patch implements Audio Mixer CPU DAI driver for NXP iMX8 SOCs.
> The Audio Mixer is a on-chip functional module that allows mixing of
> two audio streams into a single audio stream.
> 
> Audio Mixer datasheet is available here:
> https://www.nxp.com/docs/en/reference-manual/IMX8DQXPRM.pdf
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,amix.txt         |  45 ++

This should be a separate patch.

>  sound/soc/fsl/Kconfig                              |   7 +
>  sound/soc/fsl/Makefile                             |   3 +
>  sound/soc/fsl/fsl_amix.c                           | 554 +++++++++++++++++++++
>  sound/soc/fsl/fsl_amix.h                           | 101 ++++
>  5 files changed, 710 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,amix.txt
>  create mode 100644 sound/soc/fsl/fsl_amix.c
>  create mode 100644 sound/soc/fsl/fsl_amix.h
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,amix.txt b/Documentation/devicetree/bindings/sound/fsl,amix.txt
> new file mode 100644
> index 0000000..049144f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,amix.txt
> @@ -0,0 +1,45 @@
> +NXP Audio Mixer (AMIX).
> +
> +The Audio Mixer is a on-chip functional module that allows mixing of two
> +audio streams into a single audio stream. Audio Mixer has two input serial
> +audio interfaces. These are driven by two Synchronous Audio interface
> +modules (SAI). Each input serial interface carries 8 audio channels in its
> +frame in TDM manner. Mixer mixes audio samples of corresponding channels
> +from two interfaces into a single sample. Before mixing, audio samples of
> +two inputs can be attenuated based on configuration. The output of the
> +Audio Mixer is also a serial audio interface. Like input interfaces it has
> +the same TDM frame format. This output is used to drive the serial DAC TDM
> +interface of audio codec and also sent to the external pins along with the
> +receive path of normal audio SAI module for readback by the CPU.
> +
> +The output of Audio mixer can be selected from any of the three streams
> + - serial audio input 1
> + - serial audio input 2
> + - Mixed audio
> +
> +Mixing operation is independent of audio sample rate but the two audio
> +input streams must have same audio sample rate with same number of channels
> +in TDM frame to be eligible for mixing.
> +
> +Device driver required properties:
> +=================================
> +  - compatible		: Compatible list, contains "fsl,imx8qm-amix"
> +
> +  - reg			: Offset and length of the register set for the device.
> +
> +  - clocks		: Must contain an entry for each entry in clock-names.
> +
> +  - clock-names		: Must include the "ipg" for register access.

Humm, no audio related clocks? 

> +
> +  - power-domains	: Must contain the phandle to the AMIX power domain node
> +
> +Device driver configuration example:
> +======================================
> +  amix: amix@59840000 {
> +    compatible = "fsl,imx8qm-amix";
> +    reg = <0x0 0x59840000 0x0 0x10000>;
> +    clocks = <&clk IMX8QXP_AUD_AMIX_IPG>;
> +    clock-names = "ipg";
> +    power-domains = <&pd_amix>;
> +  };
> +
