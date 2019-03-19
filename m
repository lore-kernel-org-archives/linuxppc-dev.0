Return-Path: <SRS0=MfaX=RW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765F9C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 02:10:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A808020989
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 02:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="O/YW1jTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A808020989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Nc2K2486zDqJk
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 13:10:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.8.84; helo=eur04-vi1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="O/YW1jTo"; 
 dkim-atps=neutral
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80084.outbound.protection.outlook.com [40.107.8.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Nc0b3TFpzDqJ3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 13:08:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkW/TTYu01N1zz/THXWv7Z7fLEWhDe6bkoUuF3ehLxM=;
 b=O/YW1jTopswYBOHFtzDs3cSwXhe6EMePvlZwD+GYq0rpZUp4Y++o4fVk9pS5XSkLf1zZdhPt8h5k+60fkFVlCnPPBdMi7POymYXESZQGr8PFjdQSAR89VyvVYEkziLH54maE7QKMdywMGQkP+6m2lTXDz7CfAE02+gA67Ns7Bb8=
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com (52.134.1.153) by
 VI1PR0402MB3504.eurprd04.prod.outlook.com (52.134.4.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.15; Tue, 19 Mar 2019 02:08:20 +0000
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::b8c7:9d4a:acdd:23be]) by VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::b8c7:9d4a:acdd:23be%4]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 02:08:20 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>, "timur@kernel.org"
 <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com"
 <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: RE: [alsa-devel] [PATCH V4] ASoC: fsl_esai: fix channel swap issue
 when	stream starts
Thread-Topic: [alsa-devel] [PATCH V4] ASoC: fsl_esai: fix channel swap issue
 when	stream starts
Thread-Index: AQHU3fifuQ2TP5Uh3UmOyX4tz+XmHg==
Date: Tue, 19 Mar 2019 02:08:20 +0000
Message-ID: <VI1PR0402MB3392C426C2F5D65322A04253E3400@VI1PR0402MB3392.eurprd04.prod.outlook.com>
References: <f05c95e5371336a8e3b0c395dc4cef70922f0caa.1551248985.git.shengjiu.wang@nxp.com>
In-Reply-To: <f05c95e5371336a8e3b0c395dc4cef70922f0caa.1551248985.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c81dcce4-fb9a-4242-05f4-08d6ac0fc245
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3504; 
x-ms-traffictypediagnostic: VI1PR0402MB3504:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR0402MB350478BB5325E1F89272745EE3400@VI1PR0402MB3504.eurprd04.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(39860400002)(376002)(396003)(136003)(366004)(189003)(199004)(45080400002)(33656002)(53936002)(478600001)(105586002)(106356001)(66066001)(3846002)(6306002)(6116002)(9686003)(256004)(966005)(14444005)(52536014)(71190400001)(14454004)(55016002)(229853002)(68736007)(2501003)(6436002)(476003)(486006)(76176011)(11346002)(446003)(7696005)(6506007)(4326008)(5660300002)(316002)(2906002)(25786009)(6246003)(110136005)(97736004)(8936002)(102836004)(86362001)(2201001)(26005)(81156014)(7736002)(81166006)(74316002)(305945005)(99286004)(186003)(71200400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3504;
 H:VI1PR0402MB3392.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: idl/yyg4BbETbMAfA/gu7D4x57pBr3N6bukRsfOVj4fuqt9Pb2NkXttzoEVl0OIoN8H+mfoH9kwRYSmpfVwNLIRDQMOSHz8+7xo2iIx//vEU0IzGe5FxFVwv7Bea1ynpLeNqADJk9N4LqOV3N5wvNuNc76R76JIjlJfDRogr7EYANdHi3SVwu10xiSCEvWfMwmpdKVby+RUBZXjHTympMti+6qs8Etp3vCy6d3a1T5/ZXWsW4jeOXR8PF/gAqW5Gl8MTFGi93eRSB0xtPwedk6YMWcodO0h7WnCAvWD25sYDj5duxlMcojqvNWFjBrVH0C/1MjoDfv7yXUg8CnMVuWu8xP1LUN1qN4Jcah2CXMgdA8kbdKIDFIHNy4dFELSnB6atq/QWfZW/Y0+PmGoy1YnL6Zoz2BnW3hRWijPcuXk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c81dcce4-fb9a-4242-05f4-08d6ac0fc245
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 02:08:20.2463 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3504
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Mark

    Can this patch be accepted?  Or need I do any update?

Best regards
Wang shengjiu
>=20
> There is very low possibility ( < 0.1% ) that channel swap happened in
> beginning when multi output/input pin is enabled. The issue is that
> hardware can't send data to correct pin in the beginning with the normal
> enable flow.
>=20
> This is hardware issue, but there is no errata, the workaround flow is th=
at:
> Each time playback/recording, firstly clear the xSMA/xSMB, then enable
> TE/RE, then enable xSMB and xSMA (xSMB must be enabled before xSMA).
> Which is to use the xSMA as the trigger start register, previously the xC=
R_TE
> or xCR_RE is the bit for starting.
>=20
> Fixes commit 43d24e76b698 ("ASoC: fsl_esai: Add ESAI CPU DAI driver")
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_esai.c | 47 +++++++++++++++++++++++++++++++++++++---
> -------
>  1 file changed, 37 insertions(+), 10 deletions(-)
>=20
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c index
> afe67c865330..3623aa9a6f2e 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -54,6 +54,8 @@ struct fsl_esai {
>  	u32 fifo_depth;
>  	u32 slot_width;
>  	u32 slots;
> +	u32 tx_mask;
> +	u32 rx_mask;
>  	u32 hck_rate[2];
>  	u32 sck_rate[2];
>  	bool hck_dir[2];
> @@ -361,21 +363,13 @@ static int fsl_esai_set_dai_tdm_slot(struct
> snd_soc_dai *dai, u32 tx_mask,
>  	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCCR,
>  			   ESAI_xCCR_xDC_MASK, ESAI_xCCR_xDC(slots));
>=20
> -	regmap_update_bits(esai_priv->regmap, REG_ESAI_TSMA,
> -			   ESAI_xSMA_xS_MASK, ESAI_xSMA_xS(tx_mask));
> -	regmap_update_bits(esai_priv->regmap, REG_ESAI_TSMB,
> -			   ESAI_xSMB_xS_MASK, ESAI_xSMB_xS(tx_mask));
> -
>  	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCCR,
>  			   ESAI_xCCR_xDC_MASK, ESAI_xCCR_xDC(slots));
>=20
> -	regmap_update_bits(esai_priv->regmap, REG_ESAI_RSMA,
> -			   ESAI_xSMA_xS_MASK, ESAI_xSMA_xS(rx_mask));
> -	regmap_update_bits(esai_priv->regmap, REG_ESAI_RSMB,
> -			   ESAI_xSMB_xS_MASK, ESAI_xSMB_xS(rx_mask));
> -
>  	esai_priv->slot_width =3D slot_width;
>  	esai_priv->slots =3D slots;
> +	esai_priv->tx_mask =3D tx_mask;
> +	esai_priv->rx_mask =3D rx_mask;
>=20
>  	return 0;
>  }
> @@ -596,6 +590,7 @@ static int fsl_esai_trigger(struct snd_pcm_substream
> *substream, int cmd,
>  	bool tx =3D substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK;
>  	u8 i, channels =3D substream->runtime->channels;
>  	u32 pins =3D DIV_ROUND_UP(channels, esai_priv->slots);
> +	u32 mask;
>=20
>  	switch (cmd) {
>  	case SNDRV_PCM_TRIGGER_START:
> @@ -608,15 +603,38 @@ static int fsl_esai_trigger(struct
> snd_pcm_substream *substream, int cmd,
>  		for (i =3D 0; tx && i < channels; i++)
>  			regmap_write(esai_priv->regmap, REG_ESAI_ETDR,
> 0x0);
>=20
> +		/*
> +		 * When set the TE/RE in the end of enablement flow, there
> +		 * will be channel swap issue for multi data line case.
> +		 * In order to workaround this issue, we switch the bit
> +		 * enablement sequence to below sequence
> +		 * 1) clear the xSMB & xSMA: which is done in probe and
> +		 *                           stop state.
> +		 * 2) set TE/RE
> +		 * 3) set xSMB
> +		 * 4) set xSMA:  xSMA is the last one in this flow, which
> +		 *               will trigger esai to start.
> +		 */
>  		regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
>  				   tx ? ESAI_xCR_TE_MASK :
> ESAI_xCR_RE_MASK,
>  				   tx ? ESAI_xCR_TE(pins) :
> ESAI_xCR_RE(pins));
> +		mask =3D tx ? esai_priv->tx_mask : esai_priv->rx_mask;
> +
> +		regmap_update_bits(esai_priv->regmap,
> REG_ESAI_xSMB(tx),
> +				   ESAI_xSMB_xS_MASK,
> ESAI_xSMB_xS(mask));
> +		regmap_update_bits(esai_priv->regmap,
> REG_ESAI_xSMA(tx),
> +				   ESAI_xSMA_xS_MASK,
> ESAI_xSMA_xS(mask));
> +
>  		break;
>  	case SNDRV_PCM_TRIGGER_SUSPEND:
>  	case SNDRV_PCM_TRIGGER_STOP:
>  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>  		regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
>  				   tx ? ESAI_xCR_TE_MASK :
> ESAI_xCR_RE_MASK, 0);
> +		regmap_update_bits(esai_priv->regmap,
> REG_ESAI_xSMA(tx),
> +				   ESAI_xSMA_xS_MASK, 0);
> +		regmap_update_bits(esai_priv->regmap,
> REG_ESAI_xSMB(tx),
> +				   ESAI_xSMB_xS_MASK, 0);
>=20
>  		/* Disable and reset FIFO */
>  		regmap_update_bits(esai_priv->regmap, REG_ESAI_xFCR(tx),
> @@ -906,6 +924,15 @@ static int fsl_esai_probe(struct platform_device
> *pdev)
>  		return ret;
>  	}
>=20
> +	esai_priv->tx_mask =3D 0xFFFFFFFF;
> +	esai_priv->rx_mask =3D 0xFFFFFFFF;
> +
> +	/* Clear the TSMA, TSMB, RSMA, RSMB */
> +	regmap_write(esai_priv->regmap, REG_ESAI_TSMA, 0);
> +	regmap_write(esai_priv->regmap, REG_ESAI_TSMB, 0);
> +	regmap_write(esai_priv->regmap, REG_ESAI_RSMA, 0);
> +	regmap_write(esai_priv->regmap, REG_ESAI_RSMB, 0);
> +
>  	ret =3D devm_snd_soc_register_component(&pdev->dev,
> &fsl_esai_component,
>  					      &fsl_esai_dai, 1);
>  	if (ret) {
> --
> 1.9.1
>=20
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fma
> ilman.alsa-project.org%2Fmailman%2Flistinfo%2Falsa-
> devel&amp;data=3D02%7C01%7Cshengjiu.wang%40nxp.com%7Ce2940159f310
> 4473866a08d69c7d6c1e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> %7C636868459834438771&amp;sdata=3DWdeHv2JxOBqb0mQ%2B%2FrRISAt64
> JZ6ATY2u02IzzFDaEY%3D&amp;reserved=3D0
