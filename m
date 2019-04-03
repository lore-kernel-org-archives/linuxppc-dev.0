Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A033C4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 10:10:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 096432084C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 10:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NGoJ0pYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096432084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Z1zJ5j46zDqS0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 21:10:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.2.64; helo=eur02-ve1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="NGoJ0pYV"; 
 dkim-atps=neutral
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20064.outbound.protection.outlook.com [40.107.2.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Z1wf4f3MzDq9W
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 21:07:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCGHXORDcMH5K0hUkeI0SSotT92d7d7dY8+3F6bCfH4=;
 b=NGoJ0pYVm6t69CgF1mqWTvH2XMJvCdnGMDSwac/J2n/9n6fYvA+kk9BsbIY88CGcEqpAzIF3LgzDThdTXSMtEM2q8ZSWBEIWljSC0BFFS3gMOgeDwchklV7n0apuHA9cw0T1wfR5QFMiAnqYlTwep2f3VrzbtT9+ngOdX7DFzB8=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6605.eurprd04.prod.outlook.com (20.179.234.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.13; Wed, 3 Apr 2019 10:07:40 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::59c9:fbfe:c41a:59ef]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::59c9:fbfe:c41a:59ef%4]) with mapi id 15.20.1750.017; Wed, 3 Apr 2019
 10:07:40 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: [PATCH V2] ASoC: fsl_esai: Support synchronous mode
Thread-Topic: [PATCH V2] ASoC: fsl_esai: Support synchronous mode
Thread-Index: AQHU6gUSBPA5LkR8lUK0D8ynBBQe8A==
Date: Wed, 3 Apr 2019 10:07:40 +0000
Message-ID: <dac7c52215b4bb09f3548bcb9246f8fe21799e38.1554285839.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK0PR01CA0069.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::33) To VE1PR04MB6479.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ac2777a-45ad-457a-8af3-08d6b81c349e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:VE1PR04MB6605; 
x-ms-traffictypediagnostic: VE1PR04MB6605:
x-microsoft-antispam-prvs: <VE1PR04MB6605A36A69DAC15063F78CDFE3570@VE1PR04MB6605.eurprd04.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(396003)(366004)(136003)(39860400002)(189003)(199004)(97736004)(68736007)(8936002)(2201001)(6486002)(86362001)(25786009)(14444005)(256004)(6436002)(36756003)(305945005)(71200400001)(71190400001)(50226002)(14454004)(8676002)(81156014)(478600001)(81166006)(5660300002)(7736002)(486006)(105586002)(6116002)(106356001)(52116002)(3846002)(186003)(118296001)(4326008)(386003)(6506007)(2906002)(26005)(102836004)(2616005)(476003)(99286004)(316002)(110136005)(66066001)(2501003)(6512007)(53936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6605;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5Uv5hukTpGtd/UFZq/UBDfpQY0UedpTEZH78Z5K+P6O02aXpTDK0JrwipHZ4Yh3fi2v1mOoTrnODsJmQfWAIYtE6l4yeLLBU7s2Nly8Vwp9aEZhVACO/YJnA+JwhGhkVBEpJDwItmVvvHYC/qLgZ1wHSqgGwyT17Euy+B7cJoG3ylxEmiGlAzk3iqYk5c4axvTt5/cd2LwGz5ShtHOut3OwfMgMrqWUewrKraPKyOCpC9Mt10DeIYXvt8A1LUxyX/IgUy7WosMh3GyWAgXVllzOMYFxQHiiFFILsVYAVM9vBZu2hLATeKyZaUlx3Qh3rpIlJXTbBQVG7M3pUQqAXNQvo9fzTk2daEGA9PF+XbNoW6EF1PCywWUMGSvx1IU0H3/Z2vALakEPA/U962/SNbGNu45QmCtNYAjgfbz7ASAY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac2777a-45ad-457a-8af3-08d6b81c349e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 10:07:40.4927 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6605
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

In ESAI synchronous mode, the clock is generated by Tx, So
we should always set registers of Tx which relate with the
bit clock and frame clock generation (TCCR, TCR, ECR), even
there is only Rx is working.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changes in v2
- refine the patch according Nicolin's comments
- merge plain setting.

 sound/soc/fsl/fsl_esai.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 3623aa9a6f2e..f2e7b27f8447 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -218,7 +218,7 @@ static int fsl_esai_set_dai_sysclk(struct snd_soc_dai *=
dai, int clk_id,
 {
 	struct fsl_esai *esai_priv =3D snd_soc_dai_get_drvdata(dai);
 	struct clk *clksrc =3D esai_priv->extalclk;
-	bool tx =3D clk_id <=3D ESAI_HCKT_EXTAL;
+	bool tx =3D (clk_id <=3D ESAI_HCKT_EXTAL || esai_priv->synchronous);
 	bool in =3D dir =3D=3D SND_SOC_CLOCK_IN;
 	u32 ratio, ecr =3D 0;
 	unsigned long clk_rate;
@@ -253,7 +253,7 @@ static int fsl_esai_set_dai_sysclk(struct snd_soc_dai *=
dai, int clk_id,
 		ecr |=3D ESAI_ECR_ETI;
 		/* fall through */
 	case ESAI_HCKR_EXTAL:
-		ecr |=3D ESAI_ECR_ERI;
+		ecr |=3D esai_priv->synchronous ? ESAI_ECR_ETI : ESAI_ECR_ERI;
 		break;
 	default:
 		return -EINVAL;
@@ -537,10 +537,18 @@ static int fsl_esai_hw_params(struct snd_pcm_substrea=
m *substream,
=20
 	bclk =3D params_rate(params) * slot_width * esai_priv->slots;
=20
-	ret =3D fsl_esai_set_bclk(dai, tx, bclk);
+	ret =3D fsl_esai_set_bclk(dai, esai_priv->synchronous || tx, bclk);
 	if (ret)
 		return ret;
=20
+	mask =3D ESAI_xCR_xSWS_MASK;
+	val =3D ESAI_xCR_xSWS(slot_width, width);
+
+	regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx), mask, val);
+	/* Recording in synchronous mode needs to set TCR also */
+	if (!tx && esai_priv->synchronous)
+		regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR, mask, val);
+
 	/* Use Normal mode to support monaural audio */
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
 			   ESAI_xCR_xMOD_MASK, params_channels(params) > 1 ?
@@ -556,10 +564,9 @@ static int fsl_esai_hw_params(struct snd_pcm_substream=
 *substream,
=20
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_xFCR(tx), mask, val);
=20
-	mask =3D ESAI_xCR_xSWS_MASK | (tx ? ESAI_xCR_PADC : 0);
-	val =3D ESAI_xCR_xSWS(slot_width, width) | (tx ? ESAI_xCR_PADC : 0);
-
-	regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx), mask, val);
+	if (tx)
+		regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
+					ESAI_xCR_PADC, ESAI_xCR_PADC);
=20
 	/* Remove ESAI personal reset by configuring ESAI_PCRC and ESAI_PRRC */
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_PRRC,
--=20
1.9.1

