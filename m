Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BE2C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 11:49:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E3721929
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 11:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lHvRSCNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E3721929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 441BQ25hX6zDqg8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 22:49:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.15.83; helo=eur01-db5-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="lHvRSCNH"; 
 dkim-atps=neutral
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr150083.outbound.protection.outlook.com [40.107.15.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4419Q706qZzDqSj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 22:04:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EU+fVLOUScavXJ7/jXqsNloQXwyignaqvGCCbgaPLNY=;
 b=lHvRSCNHj28nxnjKU1GwrjWqjZKHb0qYRlHBzUxu5l2Gyn+C2loAY4J7SlxBPoboCp0E0x9sh68Ol6eHMgzf5/UdTPKCwyhllI1H0HB60FCb5oy/OyDyI4DSJTKfSVMWHggW+acZBQpE1vZRoetWF+kq2j3v5RrEMURPN31Po9I=
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com (52.134.1.153) by
 VI1SPR00MB252.eurprd04.prod.outlook.com (10.172.82.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Fri, 15 Feb 2019 11:04:38 +0000
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22]) by VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22%3]) with mapi id 15.20.1601.023; Fri, 15 Feb 2019
 11:04:38 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl_esai: fix register setting issue in RIGHT_J mode
Thread-Topic: [PATCH] ASoC: fsl_esai: fix register setting issue in RIGHT_J
 mode
Thread-Index: AQHUxR4+6Wc4kuLC9ka8ByRRTCTzrw==
Date: Fri, 15 Feb 2019 11:04:38 +0000
Message-ID: <1550228637-5675-1-git-send-email-shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK0PR03CA0092.apcprd03.prod.outlook.com
 (2603:1096:203:72::32) To VI1PR0402MB3392.eurprd04.prod.outlook.com
 (2603:10a6:803:3::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f4de077-ada4-4245-c989-08d69335607d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1SPR00MB252; 
x-ms-traffictypediagnostic: VI1SPR00MB252:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1SPR00MB252;
 23:Qe/ENaEFKlh8VAd5IsEQK70JI+MZaQfgoJuejEs?=
 =?iso-8859-1?Q?GGmPKWDLxkKmB/rMt3jHnLhUzVSiB5iav8TfQAD+C7v+UBZJ8A5+znUJwI?=
 =?iso-8859-1?Q?7XP39i7BYc07Riqywjya5O3s77w9Lk27nvjxIapgh6peWjzLZtqiAHqVE5?=
 =?iso-8859-1?Q?3q5zAV73xx/K5uRqekAnHH0Ul+WW71Ylc0P6WrvThmdpqnIYRAtTJLXRbB?=
 =?iso-8859-1?Q?SUu5Yk8axXkTyk5/FmVSouuvK0rFlwjEUjKv2ZQM6LIAKx5l0sN0KN4TVE?=
 =?iso-8859-1?Q?TN8upG0EmXYaXHESGDVP1koYpFe2699bbq57nrxZ9dlpQ1rrCiNtyq1uOR?=
 =?iso-8859-1?Q?hSLEgc+URsWBPZ8jMls4L88aZpf7XQngqGIkkjqz1vE8m8LoKwXB7rcTlu?=
 =?iso-8859-1?Q?PF1HbMn2YRw0Kmd7YlD13ikBleY6RQ4x/9EGVdrH18vtwf1Kuu8MR5Xn7C?=
 =?iso-8859-1?Q?SwR5Ov/4dfEb2xulmNduq93D4X+O5+gJ0cI/4xeFkpoLX3PYc5+qFm0Uh0?=
 =?iso-8859-1?Q?GrgTzNUPqQfj05m0h8bu+rM+PRTbaA6r8I7GTCBWP3do5BuSVa4zuAzc6I?=
 =?iso-8859-1?Q?+9Pq8c+aFuG7zTdCi72CcV2tvuvuqn9jTQ/5BHWPxS0GtrvO7Zhvl7TDM6?=
 =?iso-8859-1?Q?/75Lzv7Fo2lJtxx7hDrMJNMolyxFL/vafGw9Io8fvMf66pwNqRYcM/GQhf?=
 =?iso-8859-1?Q?965d1642b2m7Ju12YziOQhrPy/SoLiWe2BiqArWUqsdbEPQ1Cc2FxXlilP?=
 =?iso-8859-1?Q?rjnJmG5ts/h2Xb9hGNRuCvTxrpbhyF0lNVVKeOWteHd0nByFmBzADGNKbs?=
 =?iso-8859-1?Q?Q/1Bp95Nx0ZhTsylMTlHvJXyxsgD5olp1Up2KpmDP45mM+6nOZhBLcGwqb?=
 =?iso-8859-1?Q?ROMLZz5hr/X6L7Kc3dYXSY0zuVK8ZE37bIomF/s2fQk2vVEadVvao4MGyj?=
 =?iso-8859-1?Q?0nv5U0xNOK0a6nnmsIx9Zl755VMTDHnO9/Q3aC78rNFCVlSQKAwn0pF2ot?=
 =?iso-8859-1?Q?w3BDq1GaOsMLOUoDX8bnTmcdfVt19kcJyKV6cmav+XjcZZx4u2xlc2jSwT?=
 =?iso-8859-1?Q?I8IHW6jEioNaDJILGuhnbEomJcPBTYrdK3qh3X+Mi13EKLCbMvhKEAiqdC?=
 =?iso-8859-1?Q?ByI3QmhHMMPAjSiGtaOPVPp5JZa7EJ9Ol7Q9t9K91Q0DXFusvVc8EyQOst?=
 =?iso-8859-1?Q?wXoiTPzUIyOWZQAcsoudlttXtQVIQBOdg=3D=3D?=
x-microsoft-antispam-prvs: <VI1SPR00MB252C9D1B3D5529F2F853555E3600@VI1SPR00MB252.eurprd04.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(136003)(346002)(396003)(366004)(376002)(199004)(189003)(478600001)(316002)(14454004)(256004)(14444005)(26005)(68736007)(186003)(99286004)(52116002)(66066001)(7736002)(6486002)(50226002)(6512007)(2906002)(2201001)(86362001)(305945005)(81166006)(81156014)(6436002)(8936002)(8676002)(71200400001)(71190400001)(36756003)(3846002)(6116002)(105586002)(106356001)(476003)(2616005)(97736004)(53936002)(6506007)(386003)(102836004)(486006)(2501003)(4326008)(25786009)(54906003)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1SPR00MB252;
 H:VI1PR0402MB3392.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DWUxwwSXeFsBjz4WaLkdm8YqSFedEjBvjEiQfKat9axBVV04cGxS7riI+LSR1/YydyfM/p1cs6YLuzUzwMg3YXeUUrLVC8ktDoPGVzi9hG2fXOA8Gu4c1WJvv+uvWnlKwrK4Blnp2Clog6uVpff1jf5JiGzcOYC/jPY+vH/NDklYOejESbhiRoMPlrg1t0iBUEV4zDwg7M0x1fCAl9YJHp+jSPNNOT27XNX9UlcRIlxK+tVdfxPQY3DBleb+4a4tAg0MODP7r0Qx9LeVfAl9bB3AL3BmzO71a3heWr6eOEvCy6f/juSXSsDB6nWmSRODAt7YQ7rJZELnCVk5nb/CL+/wp0Tp5MBxzx1+va9CYPFemCeZWCVi5pFMr/i1lRS0YPbHnhFW3Y7nAxfukxtq35wnebsgkpr1i1Un0cAuAlk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4de077-ada4-4245-c989-08d69335607d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 11:04:35.9504 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1SPR00MB252
X-Mailman-Approved-At: Fri, 15 Feb 2019 22:47:40 +1100
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
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The ESAI_xCR_xWA is xCR's bit, not the xCCR's bit, driver set it to
wrong register, correct it.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_esai.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 57b484768a58..afe67c865330 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -398,7 +398,8 @@ static int fsl_esai_set_dai_fmt(struct snd_soc_dai *dai=
, unsigned int fmt)
 		break;
 	case SND_SOC_DAIFMT_RIGHT_J:
 		/* Data on rising edge of bclk, frame high, right aligned */
-		xccr |=3D ESAI_xCCR_xCKP | ESAI_xCCR_xHCKP | ESAI_xCR_xWA;
+		xccr |=3D ESAI_xCCR_xCKP | ESAI_xCCR_xHCKP;
+		xcr  |=3D ESAI_xCR_xWA;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
 		/* Data on rising edge of bclk, frame high, 1clk before data */
@@ -455,12 +456,12 @@ static int fsl_esai_set_dai_fmt(struct snd_soc_dai *d=
ai, unsigned int fmt)
 		return -EINVAL;
 	}
=20
-	mask =3D ESAI_xCR_xFSL | ESAI_xCR_xFSR;
+	mask =3D ESAI_xCR_xFSL | ESAI_xCR_xFSR | ESAI_xCR_xWA;
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR, mask, xcr);
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCR, mask, xcr);
=20
 	mask =3D ESAI_xCCR_xCKP | ESAI_xCCR_xHCKP | ESAI_xCCR_xFSP |
-		ESAI_xCCR_xFSD | ESAI_xCCR_xCKD | ESAI_xCR_xWA;
+		ESAI_xCCR_xFSD | ESAI_xCCR_xCKD;
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_TCCR, mask, xccr);
 	regmap_update_bits(esai_priv->regmap, REG_ESAI_RCCR, mask, xccr);
=20
--=20
1.9.1

