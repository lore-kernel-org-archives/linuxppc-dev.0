Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A770DC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 06:34:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16458218D0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 06:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hRldBZ5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16458218D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448QrV0Vp1zDqNG
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 17:34:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.6.85; helo=eur04-db3-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="hRldBZ5R"; 
 dkim-atps=neutral
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60085.outbound.protection.outlook.com [40.107.6.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448Qn32qb6zDqN1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 17:31:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rc/2/CeF+Unank6iDzO9PN2zqLJ4ySDiDnxhpiUx6jA=;
 b=hRldBZ5RnGKYTxgsmm220feB3f2lfXXGF5Rzi4t/fRBkz1Cw1i4eiksDBSw+CFRVQiGhxB7eFAC4dO/lHysnG3kn3XpmsBV1/ZvRweHEf1981Cy0DneuXOjjctv23YDYTXGophnbI8Mre7Lpi/t+ddlOJmrYhOsz4Z5KaCRzlC8=
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com (52.134.1.153) by
 VI1PR0402MB3326.eurprd04.prod.outlook.com (52.134.8.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Wed, 27 Feb 2019 06:31:13 +0000
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22]) by VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22%3]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 06:31:13 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: [PATCH V4] ASoC: fsl_esai: fix channel swap issue when stream starts
Thread-Topic: [PATCH V4] ASoC: fsl_esai: fix channel swap issue when stream
 starts
Thread-Index: AQHUzmYIt8jQIersxU2uVCJkVAZpag==
Date: Wed, 27 Feb 2019 06:31:12 +0000
Message-ID: <f05c95e5371336a8e3b0c395dc4cef70922f0caa.1551248985.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK2PR06CA0019.apcprd06.prod.outlook.com
 (2603:1096:202:2e::31) To VI1PR0402MB3392.eurprd04.prod.outlook.com
 (2603:10a6:803:3::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ebf6ad0-6fb9-4685-5d4d-08d69c7d2ae2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3326; 
x-ms-traffictypediagnostic: VI1PR0402MB3326:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR0402MB3326;
 23:Uuf65fcjYsU1uo0e08YBz+hDjzyjVbxVMu4QK?=
 =?iso-8859-1?Q?z2LPA3JsFFvzh92Goz653p8nbl8YzfL1xfOW6H4z0O6fk7wvX4j5wJt3Sb?=
 =?iso-8859-1?Q?54w+qT63ublebPdjHaaYTqPbhj2vhHT0Cy/z7ORCO0gntOODq0f70bk3ZN?=
 =?iso-8859-1?Q?qv5h5KzZNT9nNPEuqGyHVekm/jzu2zkVnZQn2115mobIuS3P2BhMusAtPX?=
 =?iso-8859-1?Q?g2SXDSKjRBvqrAF1x9Hg+oHgx0z+Qnusp1Add41uYaG17Vkhi/Hx6K/SpP?=
 =?iso-8859-1?Q?FdI5mHHO0TB568/DwUsgegpWZ5QVs70VPwsYURA6dTQd11brijBxwCju8k?=
 =?iso-8859-1?Q?w0Z8a7UGY6QcXCdpVUlaHIBi1ArpH/i3skAQr/ytmcfahyOiTWE/zW9gJp?=
 =?iso-8859-1?Q?mqoNYwIQZIQVxMQX9nkVVET/7l/CZW+GKzwy6Qy9DddQN+qhyS9/QUuTWF?=
 =?iso-8859-1?Q?/mxB/Q0XiKz4hF2sH9V1RUNovY+IjJL0xpq/5F29jLjR2oOInbwxWKRFMT?=
 =?iso-8859-1?Q?OuYU/j0Jq34Ap2dVNJLltu/9hoPm9pRbPiah1hdC0Ca8l+8AAIXYzw87Wq?=
 =?iso-8859-1?Q?ckWW3NigUBXBa7xXFfKmqdBRoSXnDfUVJ4J95zI/BCM/F4meG/yn/httfB?=
 =?iso-8859-1?Q?BSBE41FkExJRKyLOHAAiR2jgW4JZhC7CBjc7QXaq/cBDghE0TMTTmpgEkf?=
 =?iso-8859-1?Q?UhtozofTfsBlpoeU5gc0EHrSY3S/uEtcNkUv6/UTDi2Pm7vnk1I0EwBo0/?=
 =?iso-8859-1?Q?0Qf17BQaLEx6TeNO9QEfApAts0AVpQh62zf7BvxjX3CVjXa3VPeVfnohP2?=
 =?iso-8859-1?Q?vcjznFAVEnMSd1tcExQlY+XyWFVWjAKQC3f3PngCDJXpsFWA4Bdu8+NEuf?=
 =?iso-8859-1?Q?O1oAqxKAOyTwGK3K+lOrwJjuJoJfopQ5+ckVuDNAf6qGjZR6fByG4LTnGc?=
 =?iso-8859-1?Q?34BERXzZAOAoVg957AGUZykAkiFGOcUn461QIPlierNCPqOgU6bprb8hzt?=
 =?iso-8859-1?Q?i/qlu7BN9szdLX0LWLY2fQgLnA2rxCzKfQrwqYycLFb6UNRJp70GIw+Pyc?=
 =?iso-8859-1?Q?AkCXHtLKCieSK4rhyKodAZPvtXKkIG3BoXzWStRSo6ag/UKrNh4gTlYWiq?=
 =?iso-8859-1?Q?/uZG71ykH4tBQor567Upo4pXIuaiv9oWlNiPGKFYlUb3SVjbW0r6/xJqrQ?=
 =?iso-8859-1?Q?VeFY5bt6mdU6qdtDBXNo6DLiUm/OUESG4bPJoE0P8T9f4JUKuuPmU9BQ?=
 =?iso-8859-1?Q?=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB3326D69EEA968846FE3DB149E3740@VI1PR0402MB3326.eurprd04.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(136003)(39860400002)(366004)(396003)(189003)(199004)(86362001)(6486002)(6436002)(478600001)(68736007)(71200400001)(6512007)(71190400001)(2201001)(476003)(2616005)(105586002)(106356001)(4326008)(486006)(66066001)(25786009)(305945005)(2501003)(7736002)(186003)(26005)(97736004)(256004)(14454004)(81166006)(81156014)(2906002)(110136005)(8676002)(36756003)(14444005)(50226002)(3846002)(6116002)(386003)(6506007)(118296001)(102836004)(52116002)(8936002)(99286004)(316002)(5660300002)(53936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3326;
 H:VI1PR0402MB3392.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7XMbdGRJW1OCrY1wiokf4BvIapV//3kWB6/rOX2T8QPCjPZMUKwDeFQf9WFawTi/k2tAgOP3tMjMuvXMwpRHw9oTeo2gHQUvkO5jVLxlK9HZND0e8mObW5rn6cmk1ikZqiifo/Ts4Q40/D8syuIHvWcMYLF6Sp5bPf4VhDgNYs98RVxlBw6mgUzRMoW6Gm6IkGWsFldobRZEMO1rGM0QGPRfVMacz2ZEjrkFtQVbNvN1/bhQiPMWkixTfUj4BCjruvKT2+Deq94BwLC5lDGdRyNKwFuQ8ZHkIm4d9gjORQsc51S3+2i/pxddrdVln3oxsZoFeEk0/vYHv+0JAjn79OmOYzA83t1kCBDmsFaqkFxHmi65zSjuYNUjA5gciz8tvGTlD6zX5m1S+UwKh3jYFipCKWaH/nEzKsUzFMdwopw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ebf6ad0-6fb9-4685-5d4d-08d69c7d2ae2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 06:31:09.5886 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3326
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
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_esai.c | 47 +++++++++++++++++++++++++++++++++++++-------=
---
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index afe67c865330..3623aa9a6f2e 100644
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
+	esai_priv->tx_mask =3D tx_mask;
+	esai_priv->rx_mask =3D rx_mask;
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
@@ -608,15 +603,38 @@ static int fsl_esai_trigger(struct snd_pcm_substream =
*substream, int cmd,
 		for (i =3D 0; tx && i < channels; i++)
 			regmap_write(esai_priv->regmap, REG_ESAI_ETDR, 0x0);
=20
+		/*
+		 * When set the TE/RE in the end of enablement flow, there
+		 * will be channel swap issue for multi data line case.
+		 * In order to workaround this issue, we switch the bit
+		 * enablement sequence to below sequence
+		 * 1) clear the xSMB & xSMA: which is done in probe and
+		 *                           stop state.
+		 * 2) set TE/RE
+		 * 3) set xSMB
+		 * 4) set xSMA:  xSMA is the last one in this flow, which
+		 *               will trigger esai to start.
+		 */
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
@@ -906,6 +924,15 @@ static int fsl_esai_probe(struct platform_device *pdev=
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

