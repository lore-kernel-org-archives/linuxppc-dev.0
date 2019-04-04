Return-Path: <SRS0=99u2=SG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB88BC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 09:43:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCA1A20693
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 09:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="W74ExDUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA1A20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZdLg3rWyzDqC9
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 20:43:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.15.78; helo=eur01-db5-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="W74ExDUr"; 
 dkim-atps=neutral
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr150078.outbound.protection.outlook.com [40.107.15.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ZdHS2YjCzDqFv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 20:41:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dU4KxQD7u8yoGgoDpzUgUWJzznuQJJ50HgVGw3v0DiM=;
 b=W74ExDUrMkyxIfs3t/Clh7I4pD6wd7V2RRfZHDIeo1JPJzYKM1yBmuncRIIJ6GQyQ13iKo+pQ3I19PzXdW/HSr/Q0VfGcvqcjqmqeAypVIb5fWnL3WGWx+dsVnCXT07XTNgzYeTfGmSOtruR0MHefERl3sfldyFqQbdVYJ/46BU=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6719.eurprd04.prod.outlook.com (20.179.235.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Thu, 4 Apr 2019 09:40:57 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::59c9:fbfe:c41a:59ef]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::59c9:fbfe:c41a:59ef%4]) with mapi id 15.20.1750.017; Thu, 4 Apr 2019
 09:40:57 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: [PATCH V3] ASoC: fsl_esai: Support synchronous mode
Thread-Topic: [PATCH V3] ASoC: fsl_esai: Support synchronous mode
Thread-Index: AQHU6sqBPAjM1VYiq06aHRLyPL2amg==
Date: Thu, 4 Apr 2019 09:40:56 +0000
Message-ID: <a24d5493c392d39aefc6239e3dd97f9dd5fff1a1.1554370750.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK0PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::36) To VE1PR04MB6479.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1b58ea0-7961-4b71-8eb1-08d6b8e1a348
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:VE1PR04MB6719; 
x-ms-traffictypediagnostic: VE1PR04MB6719:
x-microsoft-antispam-prvs: <VE1PR04MB6719A5CF7BFC8C6867B51F68E3500@VE1PR04MB6719.eurprd04.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(136003)(346002)(376002)(39860400002)(189003)(199004)(50226002)(81166006)(305945005)(106356001)(478600001)(6116002)(6486002)(8936002)(25786009)(71190400001)(6512007)(2201001)(68736007)(86362001)(7736002)(4326008)(118296001)(3846002)(2906002)(186003)(81156014)(105586002)(97736004)(386003)(66066001)(14454004)(14444005)(26005)(110136005)(53936002)(52116002)(316002)(8676002)(2501003)(99286004)(102836004)(476003)(2616005)(71200400001)(5660300002)(486006)(6506007)(6436002)(256004)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6719;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JSrJnueYdPbxwqq4rpsu0ISR+yfRr62hkgBNUR5RL0PrCBCBe0weOm4Uo+1EQkjtcUKbutHmLZIj/fePyTeSBYll/TTKqGflAjnO+q93B3Zp8Z9a3081M08FsaclK5UXWll+duE0lCQ6HBWzA1piDYTnlVUlvPNw4Yna9YfL2+F9i1PqJupMvOOv0/+7jRffVQwQf2mRJ0//2mJMd45aiAev2A3v7GAJEMCudGx5ZiFrjMBfw5CnmuDmo7tWzYPj6TgRJbb9M/QRQO/z+4VE4dwt1myGNfQeAEt94nJYzHK+Fw+XZs2x9gnWZRlAyH7ZMozwD/h5ne4XSAHiFeorMzaVWy0wYLtkloGG/cIbePiHTFsoWIircturmYuokHObeTeWyt4npySaEkRjIRoHIY6qGJLZ+Asl9oq5JNTOmoU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b58ea0-7961-4b71-8eb1-08d6b8e1a348
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 09:40:56.9990 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6719
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
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changes in v3
- fix the indentation

 sound/soc/fsl/fsl_esai.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 3623aa9a6f2e..c7410bbfd2af 100644
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
+				ESAI_xCR_PADC, ESAI_xCR_PADC);
=20
 	/* Remove ESAI personal reset by configuring ESAI_PCRC and ESAI_PRRC */
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_PRRC,
--=20
1.9.1

