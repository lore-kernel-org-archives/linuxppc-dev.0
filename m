Return-Path: <SRS0=+31F=RA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C028DC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 02:49:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D283C20989
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 02:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KU6PqEUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D283C20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4475yW22BVzDqQf
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 13:49:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=2a01:111:f400:fe02::616;
 helo=eur01-db5-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="KU6PqEUy"; 
 dkim-atps=neutral
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::616])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4475wn28XBzDqPY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 13:48:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFBIAYB2fLNowTYUmSAslKMJnDADeImgirFtgTecDWA=;
 b=KU6PqEUybDRT0omfvW8eBb/3Lbe+IOKuXnGW923kIV4LemKVibMqMnWzfDAJm7vrPRfavn4AnTR6pIqKfBqkJqTVoGseqcUeNi3QIOlznqPpLT0Ow5LPxWBlUJdZtJWdtudifyYOX98kX/VGn+nb5WZwYiyrN0dXfATMLpLHQQk=
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com (52.134.1.153) by
 VI1PR0402MB3696.eurprd04.prod.outlook.com (52.134.15.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.20; Mon, 25 Feb 2019 02:48:18 +0000
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22]) by VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22%3]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 02:48:18 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: [PATCH V2] ASoC: fsl_esai: fix channel swap issue when stream starts
Thread-Topic: [PATCH V2] ASoC: fsl_esai: fix channel swap issue when stream
 starts
Thread-Index: AQHUzLSQvgZScKxEQk2/qwsWCp5NqQ==
Date: Mon, 25 Feb 2019 02:48:18 +0000
Message-ID: <e31c31acb3c62d16e6b32682e8226c7dbc05f147.1551062751.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK0PR03CA0086.apcprd03.prod.outlook.com
 (2603:1096:203:72::26) To VI1PR0402MB3392.eurprd04.prod.outlook.com
 (2603:10a6:803:3::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b520516-9207-4894-883f-08d69acbb241
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3696; 
x-ms-traffictypediagnostic: VI1PR0402MB3696:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR0402MB3696;
 23:Lt7eVnHx56XmNPNhfC8a0G3MJEJzvHuVLXrfy?=
 =?iso-8859-1?Q?ZlO4Fh4FIHjOBuctnY296/uHRiRHGI2+R59+wvgwK+vVpD2YWcwwDB9sTD?=
 =?iso-8859-1?Q?5eUy3Ft8NzJLcvv0fneT5/pkUU7HXXK4RanlU9iaAvR9Nf7gXZfcfOnYV6?=
 =?iso-8859-1?Q?0vIFGJ+gr/jlPjCMS2+isY/XC7hjuhl5B35FZ3HujacVfNkoLpnzwV6G6a?=
 =?iso-8859-1?Q?/5R3IcoEmft1gF728cm0BGvb3HXhiHh0faR4Bh9iV4jScMr/RtktGeeWXA?=
 =?iso-8859-1?Q?Ev0thU2339I5w84ecyBnIFDXPH19lQfOJtIpTbz1PvJikK2zByqcG2qmSY?=
 =?iso-8859-1?Q?KuA6fTc6YzreE8xstUmMCsWHdUUwyyxY9I/zr6BKV3tLVhn0NzJoewwuw5?=
 =?iso-8859-1?Q?Hmc7vgDO3xPMkJ7SPvFXBFZJTiWG6dwwnXVPYK7qxX4SE5/yKOzrkRXagX?=
 =?iso-8859-1?Q?wF/W+pJlfoAUiS7HvNB57NFQ7abSiVVuiYDwCrNdYMUg+V25RbpUSCOnOt?=
 =?iso-8859-1?Q?8c1KsvDd0sdROkeSyxvCH69kIm+YRxXR5K79IaNDUiobl6tDr9adp2OwVg?=
 =?iso-8859-1?Q?/XUWgaQ7Bg0LIxLP0fjDcjfRh4mldRoyLfVnGn/0SejRwxZ4/0R7hB+JZw?=
 =?iso-8859-1?Q?DBIWOZM3ggNoah/ifDfQ705N0Nfat+3mr4yZyp05ee/82M9SK+f44V9GQz?=
 =?iso-8859-1?Q?Bv4TqjYEuYZ5Yu53p5aPX/cDdXITo3irvfNFSHdzPrEqef6i3m+RiZaAsv?=
 =?iso-8859-1?Q?nB6GthvmbcLljBMihi7nEM7uOAwHtF+yR2mPeF6TCXZq1A2qixxCrUAIxo?=
 =?iso-8859-1?Q?LyFHBhFPX01xjUOGn8Y2kH9IekHptalbSf3yzqhk5j550JWoeQt/4t1gL4?=
 =?iso-8859-1?Q?PU96nv4CVCsVTENX4YN168QTFzYULzzuftYzyFoh1giGsGe2wixiHG0SV8?=
 =?iso-8859-1?Q?nUZMxxR01RKwsxPpuSGHuviKlsxp5guvjsQtEDV62+dbUKxOKWqD1g4bhO?=
 =?iso-8859-1?Q?8/40xopiHeGEOs4iV75YtL8JXp1gFa7sLYoMCuz1pE9VCQkAn+izbOMFQW?=
 =?iso-8859-1?Q?p1KRIdq3JzbAeF4RITpyyetxLBBRNQiyljNezbDkCaNlU9rMohI9q3cSvP?=
 =?iso-8859-1?Q?yBzOVA7EeiAiei5GNr7qTbmnGi/EOwD/Ml9w7C+eb/nN1i8ytNPk3DdxXs?=
 =?iso-8859-1?Q?oVvrlEYolAOfIeVCc5f+Wp7vYZS42oE59g/YSl8yRzYV4O4yHen3Xlk4?=
 =?iso-8859-1?Q?=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB3696A299C988D54A4A7ADF71E37A0@VI1PR0402MB3696.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(346002)(136003)(39860400002)(376002)(199004)(189003)(2201001)(110136005)(66066001)(71200400001)(71190400001)(386003)(8936002)(102836004)(478600001)(6512007)(2906002)(50226002)(5660300002)(97736004)(6506007)(99286004)(2501003)(53936002)(52116002)(6436002)(316002)(86362001)(68736007)(2616005)(36756003)(486006)(305945005)(7736002)(186003)(476003)(81166006)(8676002)(81156014)(3846002)(6116002)(6486002)(118296001)(4326008)(25786009)(256004)(14444005)(106356001)(26005)(105586002)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3696;
 H:VI1PR0402MB3392.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1TTS6LXJfI5m6/Q1NeafiJ9pUmjAHKL3lPtQOR4ddDUVl5sE8d/SuVmVh7mi2tZa3sFnpdaIQTKzld42OF0v5L77KCmaaMYJO2hAE+15Eq82bkPPi7jT+8u3n7dfl3J+D7Q4npRnUAqHts+NFYNkgWlOiY+gdF3m2BfGnOiOYv93KNGZrEN6ac65WV43oEX97NcSg8Z1chqdnhhc8K24ZptpxFaTC4lDnyPtPKRq107qQN2JU+wmOXnffhP0Y3lcjifoC10kCx0QeMy6E0N/EPaAuTb+bm6bdA54AtjNlkcOjm7c35QF8eFxhCG8l7xiS3n+7JE9OM29v1TymeqmyWI5jaUINiWn+WE/azELbQhTANElTFSLXrbJ/idPjhAX4eearLovbDLi9FdzBThnaYydMxtQ6TBKI6YcLUI+3aw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b520516-9207-4894-883f-08d69acbb241
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 02:48:14.9880 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3696
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

There is very low possibility ( < 0.1% ) that channel swap happened
in beginning when multi output/input pin is enabled. The issue is
that hardware can't send data to correct pin in the beginning with
the normal enable flow.

This is hardware issue, but there is no errata, the workaround flow
is that: Each time playback/recording, firstly clear the xSMA/xSMB,
then enable TE/RE, then enable xSMB and xSMA (xSMB must be enabled
before xSMA). Which is to use the xSMA as the trigger start register,
previously the xCR_TE or xCR_RE is the bit for starting.

Fixes 43d24e76b698 ("ASoC: fsl_esai: Add ESAI CPU DAI driver")
Cc: <stable@vger.kernel.org>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
Changes in v2
- update commit comments.

 sound/soc/fsl/fsl_esai.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index afe67c865330..23bd0ad4ac31 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -54,6 +54,8 @@ struct fsl_esai {
 	u32 fifo_depth;
 	u32 slot_width;
 	u32 slots;
+	u32 tx_mask;
+	u32 rx_mask;
 	u32 hck_rate[2];
 	u32 sck_rate[2];
 	bool hck_dir[2];
@@ -361,21 +363,13 @@ static int fsl_esai_set_dai_tdm_slot(struct snd_soc_d=
ai *dai, u32 tx_mask,
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCCR,
 			   ESAI_xCCR_xDC_MASK, ESAI_xCCR_xDC(slots));
=20
-	regmap_update_bits(esai_priv->regmap, REG_ESAI_TSMA,
-			   ESAI_xSMA_xS_MASK, ESAI_xSMA_xS(tx_mask));
-	regmap_update_bits(esai_priv->regmap, REG_ESAI_TSMB,
-			   ESAI_xSMB_xS_MASK, ESAI_xSMB_xS(tx_mask));
-
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCCR,
 			   ESAI_xCCR_xDC_MASK, ESAI_xCCR_xDC(slots));
=20
-	regmap_update_bits(esai_priv->regmap, REG_ESAI_RSMA,
-			   ESAI_xSMA_xS_MASK, ESAI_xSMA_xS(rx_mask));
-	regmap_update_bits(esai_priv->regmap, REG_ESAI_RSMB,
-			   ESAI_xSMB_xS_MASK, ESAI_xSMB_xS(rx_mask));
-
 	esai_priv->slot_width =3D slot_width;
 	esai_priv->slots =3D slots;
+	esai_priv->tx_mask    =3D tx_mask;
+	esai_priv->rx_mask    =3D rx_mask;
=20
 	return 0;
 }
@@ -596,6 +590,7 @@ static int fsl_esai_trigger(struct snd_pcm_substream *s=
ubstream, int cmd,
 	bool tx =3D substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK;
 	u8 i, channels =3D substream->runtime->channels;
 	u32 pins =3D DIV_ROUND_UP(channels, esai_priv->slots);
+	u32 mask;
=20
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -611,12 +606,23 @@ static int fsl_esai_trigger(struct snd_pcm_substream =
*substream, int cmd,
 		regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
 				   tx ? ESAI_xCR_TE_MASK : ESAI_xCR_RE_MASK,
 				   tx ? ESAI_xCR_TE(pins) : ESAI_xCR_RE(pins));
+		mask =3D tx ? esai_priv->tx_mask : esai_priv->rx_mask;
+
+		regmap_update_bits(esai_priv->regmap, REG_ESAI_xSMB(tx),
+				   ESAI_xSMB_xS_MASK, ESAI_xSMB_xS(mask));
+		regmap_update_bits(esai_priv->regmap, REG_ESAI_xSMA(tx),
+				   ESAI_xSMA_xS_MASK, ESAI_xSMA_xS(mask));
+
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
 				   tx ? ESAI_xCR_TE_MASK : ESAI_xCR_RE_MASK, 0);
+		regmap_update_bits(esai_priv->regmap, REG_ESAI_xSMA(tx),
+				   ESAI_xSMA_xS_MASK, 0);
+		regmap_update_bits(esai_priv->regmap, REG_ESAI_xSMB(tx),
+				   ESAI_xSMB_xS_MASK, 0);
=20
 		/* Disable and reset FIFO */
 		regmap_update_bits(esai_priv->regmap, REG_ESAI_xFCR(tx),
@@ -906,6 +912,12 @@ static int fsl_esai_probe(struct platform_device *pdev=
)
 		return ret;
 	}
=20
+	/* Clear the TSMA, TSMB, RSMA, RSMB */
+	regmap_write(esai_priv->regmap, REG_ESAI_TSMA, 0);
+	regmap_write(esai_priv->regmap, REG_ESAI_TSMB, 0);
+	regmap_write(esai_priv->regmap, REG_ESAI_RSMA, 0);
+	regmap_write(esai_priv->regmap, REG_ESAI_RSMB, 0);
+
 	ret =3D devm_snd_soc_register_component(&pdev->dev, &fsl_esai_component,
 					      &fsl_esai_dai, 1);
 	if (ret) {
--=20
1.9.1

