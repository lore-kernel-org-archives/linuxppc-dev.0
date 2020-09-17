Return-Path: <SRS0=KYNf=C2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4661FC433E2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 01:56:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C63F20684
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 01:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaaDzjuN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C63F20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BsKpC5CQ7zF1vZ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 11:56:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.215.194;
 helo=mail-pg1-f194.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=QaaDzjuN; dkim-atps=neutral
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BsKl06VRXzDqDZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2020 11:54:03 +1000 (AEST)
Received: by mail-pg1-f194.google.com with SMTP id j34so415329pgi.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2020 18:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=HptUpY5ZPADmDsSUpnGfz+yVn/Le7O8Q8dkxi5ZCrro=;
 b=QaaDzjuN6yqg0oJMsY/Y8x631w+CTfJ4VNFORoGX9SW+khthjq4WzrPjaGfPtnq++e
 IofEvC/PRtKxxjc96qjz5bDiR8kJ60bw1cx9fLbSRX+s0hny8xYMUQu/ddhSQN2W0ehg
 Eu5u7ZDFSD/PpoxmOQFGa7FGDbFe3m+xkHDN2LonWO+/jepBGo/3QE9DGlz7XjBMikLQ
 9EmlNDFnKCzM1DBC2FhcRh2IOsK3RoPXdONnJIlA3axHKclhC1ad1psBqAmgwC54f+Pf
 wZ8jHySqSd1npPylBy3OXSZdkD37m2RKIgragrm2n3kGDG01GLix9bICsEdHu7tIYibm
 RBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=HptUpY5ZPADmDsSUpnGfz+yVn/Le7O8Q8dkxi5ZCrro=;
 b=MoULmtbE7i8P9+h5I4WmfYx8PBi7gmdlJI/jwPekfKeIG0OBrsSBrBMCICVfwua/Wm
 0K7iwIkRQ0pnrjS/zf5bHsh+V6T94TYQMjt/THDQelxq3hRrmRWWZfys3ZvVOWvadlh1
 pQUJ4JMBZa5Hqdhn4m4OHVcWZwb+MOo5cCr8eDYcI4wBfCO/HTvSlwC779VqGJMmOSqt
 1BBEip26kRGH5Ovn9HL4EhOpjjQeJjtCBQqYz00b7bRdwBzdpBh/LSp8KlInBkwpRL4u
 pVowYqwbDxOBeHR2E8DsLHophj6vhYd1e1V8U3IF+5hNW/h2/BQ5NZFB3x2k3v5+8afe
 XrFw==
X-Gm-Message-State: AOAM533fR2bIvpjKwXmMnZFchFhokAwMbxEnl//qJSHMxHRsMe19bZjS
 67Eb6gYh4xgO71pNEn4tkFY=
X-Google-Smtp-Source: ABdhPJx+w+YmbG8KZTbXzCyyEZZW96lMymsa7Uwppk+tAqf+WdxJ6BKWfJGYZi9hjgXeMN4Kh0mOHw==
X-Received: by 2002:a63:595a:: with SMTP id j26mr21319515pgm.406.1600307580770; 
 Wed, 16 Sep 2020 18:53:00 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id g21sm18500564pfh.30.2020.09.16.18.53.00
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 16 Sep 2020 18:53:00 -0700 (PDT)
Date: Wed, 16 Sep 2020 18:49:49 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH 2/3] ASoC: fsl_sai: Add fsl_sai_check_version function
Message-ID: <20200917014949.GC22566@Asurada-Nvidia>
References: <1600251387-1863-1-git-send-email-shengjiu.wang@nxp.com>
 <1600251387-1863-3-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600251387-1863-3-git-send-email-shengjiu.wang@nxp.com>
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
Cc: alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 lgirdwood@gmail.com, linuxppc-dev@lists.ozlabs.org, tiwai@suse.com,
 perex@perex.cz, broonie@kernel.org, festevam@gmail.com,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Sep 16, 2020 at 06:16:26PM +0800, Shengjiu Wang wrote:
> fsl_sai_check_version can help to parse the version info
> in VERID and PARAM registers.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_sai.c | 47 +++++++++++++++++++++++++++++++++++++++++
>  sound/soc/fsl/fsl_sai.h | 28 ++++++++++++++++++++++++
>  2 files changed, 75 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 24ca528ca2be..738b4dda7847 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -946,6 +946,48 @@ static struct regmap_config fsl_sai_regmap_config = {
>  	.cache_type = REGCACHE_FLAT,
>  };
>  
> +static int fsl_sai_check_version(struct device *dev)
> +{
> +	struct fsl_sai *sai = dev_get_drvdata(dev);
> +	unsigned char ofs = sai->soc_data->reg_offset;
> +	unsigned int val;
> +	int ret;
> +
> +	if (FSL_SAI_TCSR(ofs) == FSL_SAI_VERID)
> +		return 0;
> +
> +	ret = regmap_read(sai->regmap, FSL_SAI_VERID, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	dev_dbg(dev, "VERID: 0x%016X\n", val);
> +
> +	sai->verid.major = (val & FSL_SAI_VERID_MAJOR_MASK) >>
> +			   FSL_SAI_VERID_MAJOR_SHIFT;
> +	sai->verid.minor = (val & FSL_SAI_VERID_MINOR_MASK) >>
> +			   FSL_SAI_VERID_MINOR_SHIFT;
> +	sai->verid.feature = val & FSL_SAI_VERID_FEATURE_MASK;
> +
> +	ret = regmap_read(sai->regmap, FSL_SAI_PARAM, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	dev_dbg(dev, "PARAM: 0x%016X\n", val);
> +
> +	/* Max slots per frame, power of 2 */
> +	sai->param.slot_num = 1 <<
> +		((val & FSL_SAI_PARAM_SPF_MASK) >> FSL_SAI_PARAM_SPF_SHIFT);
> +
> +	/* Words per fifo, power of 2 */
> +	sai->param.fifo_depth = 1 <<
> +		((val & FSL_SAI_PARAM_WPF_MASK) >> FSL_SAI_PARAM_WPF_SHIFT);
> +
> +	/* Number of datalines implemented */
> +	sai->param.dataline = val & FSL_SAI_PARAM_DLN_MASK;
> +
> +	return 0;
> +}
> +
>  static int fsl_sai_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> @@ -1070,6 +1112,11 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, sai);
>  
> +	/* Get sai version */
> +	ret = fsl_sai_check_version(&pdev->dev);
> +	if (ret < 0)
> +		dev_warn(&pdev->dev, "Error reading SAI version: %d\n", ret);
> +
>  	pm_runtime_enable(&pdev->dev);
>  	regcache_cache_only(sai->regmap, true);
>  
> diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
> index d16fc4241f41..ba7425a9e217 100644
> --- a/sound/soc/fsl/fsl_sai.h
> +++ b/sound/soc/fsl/fsl_sai.h
> @@ -223,6 +223,32 @@ struct fsl_sai_soc_data {
>  	unsigned int reg_offset;
>  };
>  
> +/**
> + * struct fsl_sai_verid - version id data
> + * @major: major version number
> + * @minor: minor version number
> + * @feature: feature specification number
> + *           0000000000000000b - Standard feature set
> + *           0000000000000000b - Standard feature set
> + */
> +struct fsl_sai_verid {
> +	u32 major;
> +	u32 minor;
> +	u32 feature;
> +};
> +
> +/**
> + * struct fsl_sai_param - parameter data
> + * @slot_num: The maximum number of slots per frame
> + * @fifo_depth: The number of words in each FIFO (depth)
> + * @dataline: The number of datalines implemented
> + */
> +struct fsl_sai_param {
> +	u32 slot_num;
> +	u32 fifo_depth;
> +	u32 dataline;
> +};
> +
>  struct fsl_sai {
>  	struct platform_device *pdev;
>  	struct regmap *regmap;
> @@ -243,6 +269,8 @@ struct fsl_sai {
>  	const struct fsl_sai_soc_data *soc_data;
>  	struct snd_dmaengine_dai_dma_data dma_params_rx;
>  	struct snd_dmaengine_dai_dma_data dma_params_tx;
> +	struct fsl_sai_verid verid;
> +	struct fsl_sai_param param;
>  };
>  
>  #define TX 1
> -- 
> 2.27.0
> 
