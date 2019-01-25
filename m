Return-Path: <SRS0=E5N6=QB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB3BC282C0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 19:44:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 210D1218B0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 19:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7bpzApd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210D1218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43mTxz1VsQzDqQn
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jan 2019 06:44:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="l7bpzApd"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43mTwD4ZqPzDqFs
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Jan 2019 06:43:24 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id v28so4604729pgk.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2019 11:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=bQO1PTT0Ok9BIQryVdeo//V3RAzC/JEpl5AvgvqLqys=;
 b=l7bpzApdN9NPb6OoWIHMYZiqAx2uDx1DAYOPd0ahUNey1d36c3CtEDQTzjnYX16mui
 jWbKPEpXUmA4wn/blIvUMnZq6MZSFRe0af3uGfdNAlNl8MX27ux4mNeOw7PhVOY4qRK6
 g/vzafBRorEE/udMhWBxLesngZSjE8WKMu0fJvHrdwmX54DCQ6Ycgoc3IDotqNHAiXhy
 TXyQnAtgTSLWpLTnEyRIRymh1w6AWYrzZc3uPZQzHiaEZm5bx/qSVHNo8g+0JgtJSWf6
 wvxyjVxT3oS8n9P9x2l/Nl0+MRK7bxBMij3yy6bQIurRSy8o/Pwr7CN1A64hpeGh6bRG
 qjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=bQO1PTT0Ok9BIQryVdeo//V3RAzC/JEpl5AvgvqLqys=;
 b=irSDxZN5haVQzzH8kefe9zAkjP1D3EPsq3GDEh+hDSAGC5b0Gj1rcnKMsBFoHr1Zia
 P9xWtrT4/x/adOrJWNSQDt/2tchYsPOapksePtdcwLhYwEXcYBrHsht6vZaUBpgeuJNd
 Y5ahX2FqJtkaLDzKrnlaY7Uy7aNz+nurqPKWHJ1gZqchLCmKR7rBVcxQBCGZGxNtmKuN
 8IlfsOg7Ma8TS6UolYyGLxfRdSEhukS5HLg6TumGS2SsM9DlUYi1+pFeOL3UYu0veq6x
 0JFlX3ZoZUssryh5tNCpQKRCUb3lyhIV8M2FbnYSrkzXmnsmW8GdkWE9NexJp+bTybmd
 RvWQ==
X-Gm-Message-State: AJcUukfR4Oig6z08SmzWfUKk+Ng3IYWSmYZ6vjz3TEX7cPAE+DoY6UVq
 fZvf9wLLIJl2ub+qADv2lvo=
X-Google-Smtp-Source: ALg8bN4O2ycBQh2rVYGKCrxCoq6doUgi0JJE+oV5NaaDWpueqTo5VDWdFgr4OBP2puzxLxQdWX12qg==
X-Received: by 2002:a63:7512:: with SMTP id q18mr10242712pgc.231.1548445401729; 
 Fri, 25 Jan 2019 11:43:21 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id n78sm51193550pfk.19.2019.01.25.11.43.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 25 Jan 2019 11:43:21 -0800 (PST)
Date: Fri, 25 Jan 2019 11:43:16 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Viorel Suman <viorel.suman@nxp.com>
Subject: Re: [PATCH v4 2/3] ASoC: add fsl_audmix DT binding documentation
Message-ID: <20190125194315.GA21222@Asurada-Nvidia.nvidia.com>
References: <1548155654-12985-1-git-send-email-viorel.suman@nxp.com>
 <1548155654-12985-3-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548155654-12985-3-git-send-email-viorel.suman@nxp.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "S.j. Wang" <shengjiu.wang@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Viorel Suman <viorel.suman@gmail.com>,
 Cosmin Samoila <cosmin.samoila@nxp.com>, Mark Brown <broonie@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Jaroslav Kysela <perex@perex.cz>, Daniel Baluta <daniel.baluta@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jan 22, 2019 at 11:14:27AM +0000, Viorel Suman wrote:
> Add the DT binding documentation for NXP Audio Mixer
> CPU DAI driver.
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,audmix.txt       | 54 ++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,audmix.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,audmix.txt b/Documentation/devicetree/bindings/sound/fsl,audmix.txt
> new file mode 100644
> index 0000000..45f807e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,audmix.txt
> @@ -0,0 +1,54 @@
> +NXP Audio Mixer (AUDMIX).
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
> +The output of Audio Mixer can be selected from any of the three streams
> + - serial audio input 1
> + - serial audio input 2
> + - mixed audio
> +
> +Mixing operation is independent of audio sample rate but the two audio
> +input streams must have same audio sample rate with same number of channels
> +in TDM frame to be eligible for mixing.
> +
> +Device driver required properties:
> +=================================
> +  - compatible		: Compatible list, contains "fsl,imx8qm-audmix"
> +
> +  - reg			: Offset and length of the register set for the device.
> +
> +  - clocks		: Must contain an entry for each entry in clock-names.
> +
> +  - clock-names		: Must include the "ipg" for register access.
> +
> +  - power-domains	: Must contain the phandle to AUDMIX power domain node
> +
> +  - dais		: Must contain a list of phandles to AUDMIX connected
> +			  DAIs. The current implementation requires two phandles
> +			  to SAI interfaces to be provided, the first SAI in the
> +			  list being used to route the AUDMIX output.
> +
> +  - model		: Must contain machine driver name which will configure
> +			  and instantiate the appropriate audio card.

I don't feel this is necessary for DT node. The driver should be
able to figure out a proper name for the machine driver: it could
use the compatible string to get "imx8qm-audmix" as the name like
fsl_ssi; Or it could have built-in "imx-audmix" of_device_id data
corresponding to "fsl,imx8qm-audmix" compatible string -- for any
non-imx compatible in the future, use something else.

Thanks
Nic

> +
> +Device driver configuration example:
> +======================================
> +  audmix: audmix@59840000 {
> +    compatible = "fsl,imx8qm-audmix";
> +    reg = <0x0 0x59840000 0x0 0x10000>;
> +    clocks = <&clk IMX8QXP_AUD_AUDMIX_IPG>;
> +    clock-names = "ipg";
> +    power-domains = <&pd_audmix>;
> +    dais = <&sai4>, <&sai5>;
> +    model = "imx-audmix";
> +  };
> -- 
> 2.7.4
> 
