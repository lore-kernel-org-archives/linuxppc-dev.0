Return-Path: <SRS0=9RGo=SD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B60DC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 11:41:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54B992086C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 11:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XLBLpuR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B992086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Xr5Y10cqzDqNd
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 22:41:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.14.87; helo=eur01-ve1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="XLBLpuR8"; 
 dkim-atps=neutral
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr140087.outbound.protection.outlook.com [40.107.14.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Xr3C4SSKzDqJL
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Apr 2019 22:39:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MzZ1NHT14KNRmuFbejScAaLntMzlvN940vg61irdtk=;
 b=XLBLpuR874jnGtI6Y7atb0Z14ekaxLiuXShZkrS5TP/UJs8kHLEEvFS9Kn45CRvduHECUt9dLQHJO5sipFeCcAInK9sv7Fyj6zijGg1R/KhX3Dm0txVRgno9Py4ihOIg7aJ81L7iWbMjzWk1vlVfI9PxxU7WyOOq6/EqfyatQ1A=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6368.eurprd04.prod.outlook.com (10.255.118.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Mon, 1 Apr 2019 11:39:10 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::59c9:fbfe:c41a:59ef]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::59c9:fbfe:c41a:59ef%4]) with mapi id 15.20.1750.017; Mon, 1 Apr 2019
 11:39:10 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: [PATCH] ASoC: fsl_esai: Support synchronous mode
Thread-Topic: [PATCH] ASoC: fsl_esai: Support synchronous mode
Thread-Index: AQHU6H+FV+jTCNs14EK84w0THEahmQ==
Date: Mon, 1 Apr 2019 11:39:10 +0000
Message-ID: <1554118759-2403-1-git-send-email-shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK2PR04CA0086.apcprd04.prod.outlook.com
 (2603:1096:202:15::30) To VE1PR04MB6479.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 099759b7-a93f-4af7-0c8c-08d6b696a82d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VE1PR04MB6368; 
x-ms-traffictypediagnostic: VE1PR04MB6368:
x-microsoft-antispam-prvs: <VE1PR04MB636871E13CF5C0580472FF0EE3550@VE1PR04MB6368.eurprd04.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(346002)(136003)(39860400002)(366004)(199004)(189003)(4326008)(99286004)(6486002)(6506007)(486006)(386003)(476003)(2616005)(36756003)(2501003)(2906002)(3846002)(71200400001)(102836004)(52116002)(14454004)(71190400001)(26005)(6512007)(6116002)(5660300002)(14444005)(256004)(66066001)(6436002)(8936002)(86362001)(2201001)(305945005)(81166006)(186003)(50226002)(478600001)(106356001)(81156014)(105586002)(110136005)(25786009)(7736002)(316002)(8676002)(68736007)(53936002)(97736004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6368;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: B7NPQkVJbGHwt5y+M3hUBxvTlDGvHlzRS3na+sSR9yg6hhTitWsLU+5Nx1e2dKpkHojYOSiLhEAU2NWMXahjTkdfaGeiWWm1koBZ6TuEFKkDkcWqoXfG0OKYywFzOgVstta1BpTqrmb+arPFUtTge9LV8cAKVNhvkojS/LjO1i9bWhygOIxaL6E9KP7n4bIBJPnHat1gzDUPqwwHAyaxZshqBzdr0TqA9q1yVoWXhAiQFRXmcPukfVWF9igj0KZ7eLXgF+p3ehJ5kXvp5wrHtqRPXb/2VeHCijYHWoCxFFxcUxMp4zHUsjLJfpIRtIa5gXLeL8uVV6D8yspvsOC9sxjhoth21N4moIL+mlWpoG4gm2jbsrPIgAI7gTzm4SmdI4a/tZ1PPj9FCx4bQjiEPfIS9gv0OunjIyhk9wmg6/I=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 099759b7-a93f-4af7-0c8c-08d6b696a82d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 11:39:10.6260 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6368
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
 sound/soc/fsl/fsl_esai.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 3623aa9a6f2e..d9fcddd55c02 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -230,6 +230,21 @@ static int fsl_esai_set_dai_sysclk(struct snd_soc_dai =
*dai, int clk_id,
 		return -EINVAL;
 	}
=20
+	if (esai_priv->synchronous && !tx) {
+		switch (clk_id) {
+		case ESAI_HCKR_FSYS:
+			fsl_esai_set_dai_sysclk(dai, ESAI_HCKT_FSYS,
+								freq, dir);
+			break;
+		case ESAI_HCKR_EXTAL:
+			fsl_esai_set_dai_sysclk(dai, ESAI_HCKT_EXTAL,
+								freq, dir);
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
 	/* Bypass divider settings if the requirement doesn't change */
 	if (freq =3D=3D esai_priv->hck_rate[tx] && dir =3D=3D esai_priv->hck_dir[=
tx])
 		return 0;
@@ -537,10 +552,21 @@ static int fsl_esai_hw_params(struct snd_pcm_substrea=
m *substream,
=20
 	bclk =3D params_rate(params) * slot_width * esai_priv->slots;
=20
-	ret =3D fsl_esai_set_bclk(dai, tx, bclk);
+	ret =3D fsl_esai_set_bclk(dai, esai_priv->synchronous ? true : tx, bclk);
 	if (ret)
 		return ret;
=20
+	if (esai_priv->synchronous && !tx) {
+		/* Use Normal mode to support monaural audio */
+		regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
+			   ESAI_xCR_xMOD_MASK, params_channels(params) > 1 ?
+			   ESAI_xCR_xMOD_NETWORK : 0);
+
+		mask =3D ESAI_xCR_xSWS_MASK | ESAI_xCR_PADC;
+		val =3D ESAI_xCR_xSWS(slot_width, width) | ESAI_xCR_PADC;
+		regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR, mask, val);
+	}
+
 	/* Use Normal mode to support monaural audio */
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
 			   ESAI_xCR_xMOD_MASK, params_channels(params) > 1 ?
--=20
1.9.1

