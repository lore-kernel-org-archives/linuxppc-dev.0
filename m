Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C845C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 09:55:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8FD020880
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 09:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MNHVxrJe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8FD020880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444qbT5QJXzDqBY
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 20:55:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.69; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="MNHVxrJe"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00069.outbound.protection.outlook.com [40.107.0.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444qXm1n3jzDq5Y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 20:53:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoNp5mjQP/OLqlcP86W2iW4a2yHyRVQvjxVQm3xfNOw=;
 b=MNHVxrJeQjUAoa4VFSH73wmk0Kux4/QOn9cgDxBn9XnOY/s+Owdl3SBMgBqpk85+TcwMRCzttD1R5DvE3zG0012k/n5zQtAjZz0sUwXWv3iHAdRPejcXzJYY/lYnJ62VAJH35tQcR6oM3uV2tuH1yHMWEK82JksIr+i3fZkaIvs=
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com (52.134.1.153) by
 VI1PR0402MB2720.eurprd04.prod.outlook.com (10.175.22.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Thu, 21 Feb 2019 09:53:04 +0000
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22]) by VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22%3]) with mapi id 15.20.1622.018; Thu, 21 Feb 2019
 09:53:04 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: [PATCH] ASoC: fsl_esai: fix channel swap issue when stream starts
Thread-Topic: [PATCH] ASoC: fsl_esai: fix channel swap issue when stream starts
Thread-Index: AQHUycs9fdqkcg+Cg0iNVs6jgStKdg==
Date: Thu, 21 Feb 2019 09:53:04 +0000
Message-ID: <1550742787-3268-1-git-send-email-shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK0PR03CA0079.apcprd03.prod.outlook.com
 (2603:1096:203:72::19) To VI1PR0402MB3392.eurprd04.prod.outlook.com
 (2603:10a6:803:3::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 851839d0-7bc2-4ff9-47df-08d697e25f6d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB2720; 
x-ms-traffictypediagnostic: VI1PR0402MB2720:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR0402MB2720;
 23:loQDTmUCHMLws6tNSDWGoz7ZM6CLqyU9DCVn4?=
 =?iso-8859-1?Q?r9E84ubVTtpQDQl3RsLxqQi0l10IvtkDxi+bCGjgOsVrsvx2M9Zn+Ke76p?=
 =?iso-8859-1?Q?iBimt5aw1IxMqy5QUC8G/azOx7Us2A39CFTJovhqKRGRxEhBQBoihyRbDV?=
 =?iso-8859-1?Q?7K5gBCW+QLS6BXXqz5IPzpvnLhx1KvWK2J9zMFaqT5nXExGMqpWSs7aTJb?=
 =?iso-8859-1?Q?043DU9aN3Fegq1k6dS86mPgImJzrdEeFrrBY6tp0rH1e8TsRt3lbR+KHBx?=
 =?iso-8859-1?Q?jYfDGj1G6AP/6nQAF3kfVgVTiwuryLgT/rwESyWh7ZTwzV2g10QB2yySJ2?=
 =?iso-8859-1?Q?S80/tR2e/3EI6WMBDLVwZAaH7DvHVIaTQ7YmqkgBAaVksqc8Ur80Iu/3qf?=
 =?iso-8859-1?Q?unnC6wTK40+1E2CWu6WN5bYahEji7EQSNMngzhze12XD6UZBSJxmfhDeN2?=
 =?iso-8859-1?Q?FCV2nDiS9Yye3Ncwoxn5VLcsAD1otymDsoSho7y0Bi9sGW4IxgPW81OHEw?=
 =?iso-8859-1?Q?xuNDyOP5n6mqNNIL4HydsRkOJM5bbKPSKaM95o5AtaqSUjKNOnWeoxgse5?=
 =?iso-8859-1?Q?tZ5pn8QOrSfaPL3p7Wcrld1igPAd7noLbbVJkJtjRO4KCMBHpd4MCv5MSG?=
 =?iso-8859-1?Q?IqlzyxgZwDv9ICEXo9Wp/dOT2t1FKxNKymTW1oiYKFC4jOWLrPJ/lQaIRz?=
 =?iso-8859-1?Q?4CTwIlFXluiS6uBKCN06Q1y/tUyMkhYzvRf+bNCYYiP06gz3ZMLaLx246c?=
 =?iso-8859-1?Q?UbilroOIm/KPjn7vDe8FMNp76dXhDV7gVenZLtkRxHzCHif0gaT6grSqyP?=
 =?iso-8859-1?Q?0ZV5m6X+rn22ttVGydyNjqhuNE7ptphF8Owm6O21tsY+heQF8GbwEkg4FP?=
 =?iso-8859-1?Q?EeMsW4QXMLvTAeOrWHBFIabR8cSCBL3/Uwi9Kbprr5RgjYk2VucneOgdsL?=
 =?iso-8859-1?Q?MU+fFjzwkHDDg4IpNNOJcfaTWnzjx4NNYY/ze0JN/yD7FUcy0X+8GUAkAA?=
 =?iso-8859-1?Q?NZT+8auUSiMDr3ErZehV4VIXv4t8mxHjaSLRZ9IJ0ztV2qblPM0xw7NndN?=
 =?iso-8859-1?Q?/UCdzKsmwhSTIPLQrhEpi+SrPCKh+/prp3yV8xmo8y3ajT2BWVYXLnyFaK?=
 =?iso-8859-1?Q?0Xe+WqQ5AOskJP+Z3LIrpoMegHfgcAepcyvuZ11VruRfNpoxrXegWh1Tvq?=
 =?iso-8859-1?Q?jLL8+899v3NntiIBU1hubpeHu1LSrtocdcA=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB2720B4DF05CE9F4859B253CFE37E0@VI1PR0402MB2720.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(366004)(189003)(199004)(81166006)(81156014)(106356001)(86362001)(316002)(8676002)(26005)(186003)(7736002)(105586002)(305945005)(2501003)(71190400001)(71200400001)(256004)(478600001)(14444005)(5660300002)(8936002)(14454004)(53936002)(50226002)(2201001)(25786009)(476003)(36756003)(6512007)(4326008)(6506007)(486006)(386003)(2616005)(110136005)(2906002)(52116002)(66066001)(6116002)(3846002)(97736004)(99286004)(6486002)(6436002)(102836004)(68736007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB2720;
 H:VI1PR0402MB3392.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oQvpNx9awX7DWTdNLY2S8dOyWroaeXDySw0Q8yu3kaq0evHK4smX1eRnI0t594bI79mi4t7li8tBnp11Q7WDksdLMhos8JUICqYH2CalCbSxa7WKr1x9WkYqLoVrHjnoPEzH2X7FJlfFR49NuWNgsftkXvbb161BvTy9u6NCTafmz0C+Z1JhP4ES/USa2FnVyRgHLYmDVdnfGl8iVCo8Fd0tSCk6NME5o4+kT5kDqEsSYsH0uqQVTTkKcZeXTh/AxgIY61nTt8tku2oQHrVVc07HNBCmbAyMCvmsRCm/qqe0ZpXJlP0IIRHl6O9VkyqLQIpVaE2CHvU6GOtZtSxkA0+CAh52iMDbA+7w6MvOms9B4HiZZ9+g1vdC4eE5mCri7f4Rys6uY3IWzbxTZ7kdomow3h3clhJWn1+rQoKcTK8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 851839d0-7bc2-4ff9-47df-08d697e25f6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 09:53:01.5007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2720
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

From: Shengjiu Wang <shengjiu.wang@freescale.com>

There is very low possibility ( < 0.1% ) that channel swap happened
in beginning when multi output/input pin is enabled. The issue is
that hardware can't send data to correct pin in the begginning with
the normal enable flow.

This is hardware issue, the workaround flow is that: Each time
playback/recording, firstly clear the xSMA/xSMB, then enable TE/RE,
then enable xSMB and xSMA (xSMB must be enabled before xSMA).
Which is to use the xSMA as the trigger start register, previously
the xCR_TE or xCR_RE is the bit for starting

Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
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

