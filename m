Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60F5C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 02:03:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6CF521841
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 02:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="keTN7kA2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6CF521841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447hsx5GGfzDqPT
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 13:03:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.3.68; helo=eur03-am5-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="keTN7kA2"; 
 dkim-atps=neutral
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30068.outbound.protection.outlook.com [40.107.3.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447hr62sg2zDq64
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 13:01:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39mSVwAwK3dem5xlmbnuqUkuFxpokVlfd4NPW0VY/yI=;
 b=keTN7kA26Zkh7NdWHdmwrtOfFr/f8c/fs4PdgJX1uVVvMyeeTCI0Qqf896UdbXRK7HbeBh+cyu3vfEz50YS2Ijf74p30JFsdHwj4u6T5ZExIJzUGhg+yLGSRMJrPtNkLUuKE5kTMz7E7k2ouryMVSQNNJucBNzJz2iCfd7MUpJg=
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com (52.134.1.153) by
 VI1PR0402MB3951.eurprd04.prod.outlook.com (52.134.17.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Tue, 26 Feb 2019 02:01:14 +0000
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22]) by VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22%3]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 02:01:14 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: RE: [PATCH V2] ASoC: fsl_esai: fix channel swap issue when stream
 starts
Thread-Topic: [PATCH V2] ASoC: fsl_esai: fix channel swap issue when stream
 starts
Thread-Index: AQHUzLSQvgZScKxEQk2/qwsWCp5NqaXxBNWAgABOkWA=
Date: Tue, 26 Feb 2019 02:01:14 +0000
Message-ID: <VI1PR0402MB3392A0477A1C8CE66C47960EE37B0@VI1PR0402MB3392.eurprd04.prod.outlook.com>
References: <e31c31acb3c62d16e6b32682e8226c7dbc05f147.1551062751.git.shengjiu.wang@nxp.com>
 <20190225211440.GA20734@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20190225211440.GA20734@Asurada-Nvidia.nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d94371dd-4a78-48f5-cd08-08d69b8e49b6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3951; 
x-ms-traffictypediagnostic: VI1PR0402MB3951:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1; VI1PR0402MB3951;
 23:IQpQw1ohr1Ce0ONImaVT3zuyRs4Y+X8JZv2hNwr?=
 =?us-ascii?Q?aHr7Gfy1APpF48UYeviZZyRHm3CF3zFRvSGEQ2VOfPmpajGhYnJPqnR+p/O9?=
 =?us-ascii?Q?4b/lfecpVzbg/0OXEiJqlgOusP8FdOB5nN8i52GxlCYRkwVICArFSTHmq+v6?=
 =?us-ascii?Q?GcrJwIdwW3ly5UhbTyzJdiMd3OxlCoV4PRSMGWPgclLXlzJIUKmC4c3Svqer?=
 =?us-ascii?Q?KmLPC0ueMSm/1ZBMwTVTiTJ3byOQN6RF7UbB5KzkieMPHAiG993BHSZGQb0G?=
 =?us-ascii?Q?pM0rHfIhsPNxRr2mOMP7XjukzQneLDpaDeNxbl/UNObfrydGNfzzKwv3Rf4A?=
 =?us-ascii?Q?tc4WvUUJA19Fihj07hsuU+bXTCLom4Jp0Ob2HB7DMFuT49pbPpPJndcNmpN8?=
 =?us-ascii?Q?mLY3pyxuADJSdnP5u2vjz2NfqGjImA69g+7IsLO/6vXNOC6dpL/WgEhPRi5s?=
 =?us-ascii?Q?hEvEOuZUooA3hc7F1I5X7x+vS4M6QcenKbRCxZ52APoyT5L0eZZGRoIvLX5q?=
 =?us-ascii?Q?T3b7GW0B35Sz95gg8t8g9FRQ+YMWMpA2123xdU08URQ/SafVKP8w9aCMF/IP?=
 =?us-ascii?Q?IYaoo2CW/2M3uO2JMrSXbwKJNm3CiXiIha9geu7vr7ptZAW0FojnxZC5cCWu?=
 =?us-ascii?Q?75yi6GgNS9a1m/eK/hEDXg0CjmWO9zj/UsaE6IbgE09qoVkQXdejyHCJlZE1?=
 =?us-ascii?Q?Ag4Yrm5O2APfNMJFlohUaGXzN1nIYBYV9VpnhKmhvUujrOzDNzHpQuybWgPF?=
 =?us-ascii?Q?2IAg+pzN84yAKRn9Z1AKuctUvz/aeJwETUGoQWS0aIL76bRXfs145uHUgpF8?=
 =?us-ascii?Q?+SCHw1yAZ5RP0mKpCwjdP+A7cYVJPlNYhHqXY+RwagidFcjNFSbrx0KGio1F?=
 =?us-ascii?Q?ctFnVqQ5mCdi7ZiKemCWk0mLkN7rMK6w75i4JwQfmlovXCzSMJ8rhlb2NWz0?=
 =?us-ascii?Q?JZ0hdMVQeTI0/CBShnE2me1wAuRhyRyFitvRiLxvKuKARmWNCExRhtqEVFkn?=
 =?us-ascii?Q?VeSrhUAsjv3w4lcE0Ul4RR53Q538GM/+bD0Wtf2zPTD5R9ZMHaTlhApzrOPL?=
 =?us-ascii?Q?W1ODqCb4IXPe4/MTgg56n1wvYTWnj0CV8D4hUMLLkmHwsKoZaYXC3zHTpAjh?=
 =?us-ascii?Q?zzutqnLCPawfNuE/LZkqww7U+zzJBpXmW4oQ/CRTej1yGJblCtOwahwy8lA7?=
 =?us-ascii?Q?bcAXCksambZxDyPmIzzP8g0G9l2HjWkOTTDH3EieCMdIL1RVyxJan9vT80e5?=
 =?us-ascii?Q?SaCn3gCBk17wTg8O2QdY=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB395177937D890397C855B5FCE37B0@VI1PR0402MB3951.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(39860400002)(346002)(366004)(136003)(189003)(199004)(316002)(86362001)(7696005)(6246003)(8676002)(81156014)(81166006)(76176011)(54906003)(25786009)(478600001)(55016002)(7736002)(8936002)(1411001)(99286004)(14454004)(66066001)(4326008)(68736007)(71190400001)(71200400001)(97736004)(256004)(14444005)(3846002)(305945005)(102836004)(6116002)(6506007)(229853002)(486006)(26005)(9686003)(6436002)(446003)(186003)(11346002)(33656002)(476003)(53936002)(106356001)(52536013)(105586002)(2906002)(74316002)(6916009)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3951;
 H:VI1PR0402MB3392.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Aot1PnKx3BJQ2ogM4UaHNpvg4ZsOqcNwiF/DPuPHToriZ3giw61tRKeaSqJUILHIiYASlYysNgCuMpDqK5Qm+o9yBjaqGEgKbkLOxvhDmBrlXIw9A9fAgID/aFsXajGwxJ9AKn54azxFKP0Ot2ifNV1ZivvdULTetuwVaMw9eniqFUPDLpTZfKqiGBysFvTPKKTignSm245RRRNjHweH5gfzsO/Co6QTb2TgsvDwzNPhPaQf+ecrD6ms6XaYBjjC6ujGk8u7H56lAtGXz1a2xfJTjeagy30PKdqkCw9dX31E1FaT4V95Y9DLZ51VyyGae/Cc0m8FHFtx1hXm6NGNBFMMP5bo8n3WChZznpaVn7yxmDidy/WugJEtHGZyxlgRCLQxgexpvbV1jyoadKA/jT7Ag97y/hsRFHvvY+7gZWg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d94371dd-4a78-48f5-cd08-08d69b8e49b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 02:01:14.2350 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3951
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
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



>=20
> On Mon, Feb 25, 2019 at 02:48:18AM +0000, S.j. Wang wrote:
> > There is very low possibility ( < 0.1% ) that channel swap happened in
> > beginning when multi output/input pin is enabled. The issue is that
> > hardware can't send data to correct pin in the beginning with the
> > normal enable flow.
> >
> > This is hardware issue, but there is no errata, the workaround flow is
> > that: Each time playback/recording, firstly clear the xSMA/xSMB, then
> > enable TE/RE, then enable xSMB and xSMA (xSMB must be enabled
> before
> > xSMA). Which is to use the xSMA as the trigger start register,
> > previously the xCR_TE or xCR_RE is the bit for starting.
> >
> > Fixes 43d24e76b698 ("ASoC: fsl_esai: Add ESAI CPU DAI driver")
> > Cc: <stable@vger.kernel.org>
> > Reviewed-by: Fabio Estevam <festevam@gmail.com>
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> > Changes in v2
> > - update commit comments.
> >
> >  sound/soc/fsl/fsl_esai.c | 32 ++++++++++++++++++++++----------
> >  1 file changed, 22 insertions(+), 10 deletions(-)
> >
> > diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c index
> > afe67c865330..23bd0ad4ac31 100644
> > --- a/sound/soc/fsl/fsl_esai.c
> > +++ b/sound/soc/fsl/fsl_esai.c
> > @@ -54,6 +54,8 @@ struct fsl_esai {
> >  	u32 fifo_depth;
> >  	u32 slot_width;
> >  	u32 slots;
> > +	u32 tx_mask;
> > +	u32 rx_mask;
> >  	u32 hck_rate[2];
> >  	u32 sck_rate[2];
> >  	bool hck_dir[2];
> > @@ -361,21 +363,13 @@ static int fsl_esai_set_dai_tdm_slot(struct
> snd_soc_dai *dai, u32 tx_mask,
> >  	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCCR,
> >  			   ESAI_xCCR_xDC_MASK, ESAI_xCCR_xDC(slots));
> >
> > -	regmap_update_bits(esai_priv->regmap, REG_ESAI_TSMA,
> > -			   ESAI_xSMA_xS_MASK, ESAI_xSMA_xS(tx_mask));
> > -	regmap_update_bits(esai_priv->regmap, REG_ESAI_TSMB,
> > -			   ESAI_xSMB_xS_MASK, ESAI_xSMB_xS(tx_mask));
> > -
> >  	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCCR,
> >  			   ESAI_xCCR_xDC_MASK, ESAI_xCCR_xDC(slots));
> >
> > -	regmap_update_bits(esai_priv->regmap, REG_ESAI_RSMA,
> > -			   ESAI_xSMA_xS_MASK, ESAI_xSMA_xS(rx_mask));
> > -	regmap_update_bits(esai_priv->regmap, REG_ESAI_RSMB,
> > -			   ESAI_xSMB_xS_MASK, ESAI_xSMB_xS(rx_mask));
> > -
> >  	esai_priv->slot_width =3D slot_width;
> >  	esai_priv->slots =3D slots;
> > +	esai_priv->tx_mask    =3D tx_mask;
> > +	esai_priv->rx_mask    =3D rx_mask;
>=20
> The two masks only got values here. If a machine driver doesn't have a
> set_dai_tdm_slot() call, they will be remained as 0 and then will seemly
> clean those four registers.
>=20
> Thanks
> Nicolin

Then I think we need to add default value for tx_mask and rx_mask, that is
In the probe function to add:
esai_priv->tx_mask    =3D  0xFFFFFFFF;
esai_priv->rx_mask    =3D  0xFFFFFFFF;


best regards
wang shengjiu
>=20
> >
> >  	return 0;
> >  }
> > @@ -596,6 +590,7 @@ static int fsl_esai_trigger(struct
> snd_pcm_substream *substream, int cmd,
> >  	bool tx =3D substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK;
> >  	u8 i, channels =3D substream->runtime->channels;
> >  	u32 pins =3D DIV_ROUND_UP(channels, esai_priv->slots);
> > +	u32 mask;
> >
> >  	switch (cmd) {
> >  	case SNDRV_PCM_TRIGGER_START:
> > @@ -611,12 +606,23 @@ static int fsl_esai_trigger(struct
> snd_pcm_substream *substream, int cmd,
> >  		regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
> >  				   tx ? ESAI_xCR_TE_MASK :
> ESAI_xCR_RE_MASK,
> >  				   tx ? ESAI_xCR_TE(pins) :
> ESAI_xCR_RE(pins));
> > +		mask =3D tx ? esai_priv->tx_mask : esai_priv->rx_mask;
> > +
> > +		regmap_update_bits(esai_priv->regmap,
> REG_ESAI_xSMB(tx),
> > +				   ESAI_xSMB_xS_MASK,
> ESAI_xSMB_xS(mask));
> > +		regmap_update_bits(esai_priv->regmap,
> REG_ESAI_xSMA(tx),
> > +				   ESAI_xSMA_xS_MASK,
> ESAI_xSMA_xS(mask));
> > +
> >  		break;
> >  	case SNDRV_PCM_TRIGGER_SUSPEND:
> >  	case SNDRV_PCM_TRIGGER_STOP:
> >  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> >  		regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
> >  				   tx ? ESAI_xCR_TE_MASK :
> ESAI_xCR_RE_MASK, 0);
> > +		regmap_update_bits(esai_priv->regmap,
> REG_ESAI_xSMA(tx),
> > +				   ESAI_xSMA_xS_MASK, 0);
> > +		regmap_update_bits(esai_priv->regmap,
> REG_ESAI_xSMB(tx),
> > +				   ESAI_xSMB_xS_MASK, 0);
> >
> >  		/* Disable and reset FIFO */
> >  		regmap_update_bits(esai_priv->regmap, REG_ESAI_xFCR(tx),
> @@ -906,6
> > +912,12 @@ static int fsl_esai_probe(struct platform_device *pdev)
> >  		return ret;
> >  	}
> >
> > +	/* Clear the TSMA, TSMB, RSMA, RSMB */
> > +	regmap_write(esai_priv->regmap, REG_ESAI_TSMA, 0);
> > +	regmap_write(esai_priv->regmap, REG_ESAI_TSMB, 0);
> > +	regmap_write(esai_priv->regmap, REG_ESAI_RSMA, 0);
> > +	regmap_write(esai_priv->regmap, REG_ESAI_RSMB, 0);
> > +
> >  	ret =3D devm_snd_soc_register_component(&pdev->dev,
> &fsl_esai_component,
> >  					      &fsl_esai_dai, 1);
> >  	if (ret) {
> > --
> > 1.9.1
> >
