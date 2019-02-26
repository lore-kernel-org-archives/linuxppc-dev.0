Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B843FC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 03:14:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3B8B217F5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 03:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aRwZKVpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B8B217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447kS21StBzDqNK
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 14:14:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.4.48; helo=eur03-db5-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="aRwZKVpU"; 
 dkim-atps=neutral
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr40048.outbound.protection.outlook.com [40.107.4.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447kQC34PmzDqM4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 14:12:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMijb/44lgRkrsRp9Kmr/g3Wxe/fUSywPN1K5JZrDzQ=;
 b=aRwZKVpUnmAw2X+3gWztwvtEBvdExYQZBVLU8cNr+05Ahcd8LURecj88eViUKbGwgU6NYUYlsxYjAlxhf1iUolVuSQcCUpYdDs3the/QD39iqfEqozZ4Itll/dJmwjsLLKnAiMs64z4ZZRyZujVdSfVgs1OtxqEwZ9r28EgwAgk=
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com (52.134.1.153) by
 VI1PR0402MB3805.eurprd04.prod.outlook.com (52.134.16.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Tue, 26 Feb 2019 03:12:26 +0000
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22]) by VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22%3]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 03:12:26 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: [PATCH V3] ASoC: fsl_esai: fix channel swap issue when stream starts
Thread-Topic: [PATCH V3] ASoC: fsl_esai: fix channel swap issue when stream
 starts
Thread-Index: AQHUzYEZNqiYMhmT3kyzaOJ9QeioVA==
Date: Tue, 26 Feb 2019 03:12:25 +0000
Message-ID: <6a5f6ddf5c1683106b0cadd5691cd2d9cfe2c997.1551150582.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK2PR04CA0056.apcprd04.prod.outlook.com
 (2603:1096:202:14::24) To VI1PR0402MB3392.eurprd04.prod.outlook.com
 (2603:10a6:803:3::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b54777f-c12e-4f52-51c8-08d69b983b72
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3805; 
x-ms-traffictypediagnostic: VI1PR0402MB3805:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR0402MB3805;
 23:Pcp+S7gAxcOG5lqdTU6rb1Ila3ojXnkNaOvDY?=
 =?iso-8859-1?Q?W3BmpBveiU7rcInw4M2Z90+jb+/JgMnmgzzxWyJRDvYhh0QCYZ74iP+Lvb?=
 =?iso-8859-1?Q?WWJnPNfgUdc+DF5HE/nltLCWGJT8c9DIMh/7qEVxAkfKs43OihN3KmR/y5?=
 =?iso-8859-1?Q?8j2J4gLYHbu+2Gxv6/sGCXHU2ztSZzoIz3buVdFuj6Jilm2tGSR0wVhcdn?=
 =?iso-8859-1?Q?Chqk+EwoGq59LvY5YfJuNByF5RN+j9CnHtsKpKehJVizehY0K79TxImNE8?=
 =?iso-8859-1?Q?Kajum+qIaq9v0q6eweKZYZsHKl0VQ2a0Q9Dy3vhvf0M40qvoQRNcssP//7?=
 =?iso-8859-1?Q?0Qesu4hjo2TR74it8025G75/LOSWSaCw8RS3nsuEUll+UfH0qkWxizl2Yc?=
 =?iso-8859-1?Q?dFNg5NnmqtB9VM/glCxPXEP8PKVnOHMpPka0cGlErId6fm+Gn+G23kNcEN?=
 =?iso-8859-1?Q?OrHqFFucTjU1q6kEEF5ZH8aozrcNFNYXq/S9yIBkz78dV0JvSiKV/VSqkh?=
 =?iso-8859-1?Q?+pU6PO559fHwO2cMOU1yJTiV7ip6Rpfm1jlfBzEXOU+1jZTGB6VeJYHStY?=
 =?iso-8859-1?Q?rKVE9IQhPThZ6Cd8Q4Lwlfc1YRZgNhYBbKOR4HF9JkZYos7tzaLSvYGCXp?=
 =?iso-8859-1?Q?KUYWVJ6HpEUQPcXN/G7tYFM9TpI63/TbPAD1DjbT6DR3EuWsQp5s0XVS/K?=
 =?iso-8859-1?Q?Er2N+tPZlJRdugunjewWfmJNcdKCHGc9sxPDJWVccVQtikEbeUAOD4zzx/?=
 =?iso-8859-1?Q?rCGGp5wnG4iKYY1Z1Ip0+P8m5lhWMr7xY9EZFgOuKctVZbDYF6QiuRElGM?=
 =?iso-8859-1?Q?G7Wy3BMQpYJIPTcRg3J1ZzpiKNY38VhP/ZdH6OkoK63cMCXhnlIz/eKB8O?=
 =?iso-8859-1?Q?tHGImjs1K7BSmtbc2nbYjUWfjzuLlQVt9ghSknntWkU4MFvRA8TDik23R9?=
 =?iso-8859-1?Q?/k4NwUGbJiacVOCTLcyYX+35PoMDO2wjk3kiZoKgquimAjeDqTsKPvGFV8?=
 =?iso-8859-1?Q?ZjMAx3sBGqv5uxaZ7WkYTedn99WPveVW1EwvG+NcfVqRvHLp9zH9sr9Zus?=
 =?iso-8859-1?Q?NiuS4TbUd6lUoNYphfgFDQ65Uw/dX4CkD01aOZaolqCFkrJbdfP/3kPgU9?=
 =?iso-8859-1?Q?r2quiVIb0tgwqK70qilf4dBwMSn+D53kgfx0YoOynoT06RQrVysaI147Q5?=
 =?iso-8859-1?Q?NG8S2CwRMfq0oS+huuTA7Kt0tqmEUrTvjvwRdGFecvau8s2fZMcHtpBg?=
 =?iso-8859-1?Q?=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB380531760C9936B474D03822E37B0@VI1PR0402MB3805.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(366004)(396003)(346002)(39860400002)(376002)(199004)(189003)(53936002)(6486002)(7736002)(305945005)(99286004)(14444005)(6512007)(97736004)(50226002)(6436002)(256004)(106356001)(86362001)(105586002)(2501003)(2201001)(316002)(8676002)(110136005)(8936002)(102836004)(81156014)(71190400001)(81166006)(36756003)(2906002)(478600001)(26005)(4326008)(68736007)(25786009)(486006)(476003)(6116002)(3846002)(2616005)(118296001)(5660300002)(71200400001)(52116002)(186003)(14454004)(66066001)(6506007)(386003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3805;
 H:VI1PR0402MB3392.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lSBqMmXvH9t89F7eYPYbwT+TyzmuyEJCslO5KSSiZj4yXi0Lui/BQ1J9FPpKKLuM5JpyXVGJ8pZJbDDEQnQfsPljkTAqdajiuwAPgWR08+zqfI7HwxTqBKqrXhoWvM3Q7V8SJAkDrEdNNe6Z84ZicK2kzpEMRbApavuzuaLkszrGgKBb66PDrE/fLVUbQkSVHhLXUg0FreUBOVHcEQtlXdsjz7CSm2qSSOIHP9rNGhMIC0MzQzO+aAOSqUzhiOvTtXfNqgDKZWgUjRDoN/3Ye9n/MiI/min8het61nyNGgB82WvBmAxCiZe6FkOg1JRweuHsI6K1wAniFFbJQPmHEYrUKxs03Agp3CC1hfPPyf7zAAPa+RQs1zZvAWsPC1d1FuuONIjO+ME8217s6gpJd6xSkJ1+ORQlk5FMaF4hQgs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b54777f-c12e-4f52-51c8-08d69b983b72
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 03:12:22.9818 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3805
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

Fixes commit 43d24e76b698 ("ASoC: fsl_esai: Add ESAI CPU DAI driver")
Cc: <stable@vger.kernel.org>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changes in v3
- initialize tx_mask and rx_mask in probe

 sound/soc/fsl/fsl_esai.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index afe67c865330..7ee91c28b636 100644
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
@@ -906,6 +912,15 @@ static int fsl_esai_probe(struct platform_device *pdev=
)
 		return ret;
 	}
=20
+	esai_priv->tx_mask =3D 0xFFFFFFFF;
+	esai_priv->rx_mask =3D 0xFFFFFFFF;
+
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

