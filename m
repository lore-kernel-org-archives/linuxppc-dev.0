Return-Path: <SRS0=Hg4A=QZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41308C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 08:31:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB992184E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 08:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ux39ohlm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB992184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 442xsH4l3kzDqJ3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 19:30:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.5.72; helo=eur03-ve1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="ux39ohlm"; 
 dkim-atps=neutral
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50072.outbound.protection.outlook.com [40.107.5.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 442xqK3W3wzDq99
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 19:29:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyxXtkXP5YCWFH3tIGQswjm55puIOWCCggnrgWoBSTw=;
 b=ux39ohlmLujFYZNqgFx3EIhyldkqyt+WP6O7KrzBgiHiBZvAyXQoRZd6lbOnbAimoZ65YiE2mxXw9JIE2DJHr6h+oIcLs9HQYPq4s3Myijxo9nzw/w2dgwo5v8eFBy3A7nX75iQt/pU9gDKFyMCCjQJZlGcwtc3vdCPpnGlVIRc=
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com (52.134.1.153) by
 VI1PR0402MB3775.eurprd04.prod.outlook.com (52.134.15.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 08:29:11 +0000
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22]) by VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22%3]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 08:29:11 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: [PATCH V3] ASoC: fsl_esai: fix register setting issue in RIGHT_J mode
Thread-Topic: [PATCH V3] ASoC: fsl_esai: fix register setting issue in RIGHT_J
 mode
Thread-Index: AQHUx2QG4koWp80wBUKbYM2+f0bVZQ==
Date: Mon, 18 Feb 2019 08:29:11 +0000
Message-ID: <40b6cb9135dc5ec23f10d8f036ff7906daf223c2.1550478160.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK0PR01CA0062.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::26) To VI1PR0402MB3392.eurprd04.prod.outlook.com
 (2603:10a6:803:3::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f8dff07-5818-46c0-0fa4-08d6957b2863
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3775; 
x-ms-traffictypediagnostic: VI1PR0402MB3775:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR0402MB3775;
 23:dtTOpSb5s7OqBceAPty3INNnkeCUflmDCbYLx?=
 =?iso-8859-1?Q?NjSGIG6XIo1yycciy3QMfiHmj4zKxMTyNIfDZD3cQGUGLbLQoBtw6DobJW?=
 =?iso-8859-1?Q?P+K7f6vhoIOHfE2TtNqiL1qE0xGI+3re+9/trOYnfDeMy8u7eA9tWidKV8?=
 =?iso-8859-1?Q?6GRQQ0A4F9s2olqBmrb9ztGd8y1apR+veNgs4CTL0tkG7NiradSdzo4ROg?=
 =?iso-8859-1?Q?N9KT/CGB8EiFjzIbcgmgxWulGk+0ck1peQeb2qz6YXZLEvCZccGEUVFlyC?=
 =?iso-8859-1?Q?pwxHUlh/JmHS/j6EpgBH/6LaiBWEA7/6jrcUTDINxj/xu13+KBf+iCtzgA?=
 =?iso-8859-1?Q?GfwiKz1rpCUQ5XUouAJ6rhkDDWjyBWKvHMZWlPD9yMMhzVfAxm62+6ddU0?=
 =?iso-8859-1?Q?CzkpHv4v2JLtk29b0KqioYs8E8dt/J0n09iL3TeKWmeB29bjnyjblfws9B?=
 =?iso-8859-1?Q?qUlqZkk6JWBgrw+NiwU7DacXeCM1On6EbFR+WbCMKWgeEvl/Kzx9Am2Tpo?=
 =?iso-8859-1?Q?SOkuzsnUQPSa6m7NnF1PZ89T88mifEF3xgWw2sfWRCL/6eqv7m4ucvTPzc?=
 =?iso-8859-1?Q?EAkbMiSyqwJbhkKDcTMhcOeFhLU5bZ5pGYUFhVTW924ikSLqs8j/kpGc7q?=
 =?iso-8859-1?Q?q/I/DStUJ5Vxou2XDSAXUteAA/Z6qa7DSTGbcnC+UvkAZ74BjhQBiCGJxf?=
 =?iso-8859-1?Q?M04tkizQqfNiz898YiyN5Ezz0OJYgl6d/BjeNheZweRMymBlSiflY1M+6e?=
 =?iso-8859-1?Q?R+xDdViTNuYo6s3Z5kpebuOYa3IlMQ6/WYIHLeetGPXc3Z3a2NCJ12O/ta?=
 =?iso-8859-1?Q?65xvc4o2y8sodv2Sy3VUaW/sxTIRxMMeAiLcsr/qgGhlJ/asMErlrimkBS?=
 =?iso-8859-1?Q?wTLnzSCZ8vuWXDaDdUwdkZseDz8Ftmo3Y4m3sBGN7OmJ0UAhFK8IGgEGlJ?=
 =?iso-8859-1?Q?laQ47dgH3LgZ0jpjHwdpTaajA6ylumyjZWWephSXadBrOBxpYK6xu3dRe3?=
 =?iso-8859-1?Q?hPVbu5qqIM/y73sPN9OSusjZpBrwwyIBY4/YFOdH/6AspOVtthgOj2PGAh?=
 =?iso-8859-1?Q?bNbSqM+8RWPPF5mxsV9NpivgwsK/OnqTH1UZ9atS4T0JkSoYTyjhqczFxe?=
 =?iso-8859-1?Q?AQ+XLZYSslA41jjmkGwlAlMp00Y0T1IvFCM6K2Djqfwk2JhQLXbmtCIJVl?=
 =?iso-8859-1?Q?cCtYfeMzBt23A+ojNpJqAvNrzMTmdx5K/cgCMlTpDCckMJHIbJJ7lm7ZsI?=
 =?iso-8859-1?Q?XZuyq0tXydhhR7y954J?=
x-microsoft-antispam-prvs: <VI1PR0402MB3775962D9326090191582937E3630@VI1PR0402MB3775.eurprd04.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(136003)(366004)(396003)(39860400002)(199004)(189003)(5660300002)(486006)(2906002)(478600001)(8936002)(25786009)(97736004)(50226002)(110136005)(316002)(6486002)(2501003)(2201001)(86362001)(118296001)(2616005)(476003)(256004)(36756003)(53936002)(6436002)(6512007)(14454004)(26005)(14444005)(7736002)(6346003)(3846002)(186003)(6116002)(386003)(99286004)(102836004)(6506007)(81166006)(52116002)(66066001)(105586002)(81156014)(8676002)(106356001)(4326008)(71190400001)(68736007)(71200400001)(305945005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3775;
 H:VI1PR0402MB3392.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A3r6ZqvcucfHyD9DQeM0BagZMNKa8hjOHwt4pBjDiMr2EVkbTodbMFUF1kofH+GbVNGuv98JdQHL3j0JlIkllqIzditTe5xiQodU65iwpgE0euzkZWqLyRPuGUoD5tvYH6q0J/aYUB7lF5nY8FAZQ1UR6rCSZfb1IdbgXukc6xlF/JtyrCe5Y/TghfFTKIQDOudByfcYJmtQu6dxNhjadpIA81c8jJDIDpaYLSSD1Rhh6Cg11Wjy19nxy/fTs6j3JnWBJ/I/OfuieBpY3J0oGQbeorhtdoEXdxuLzyJ7jKzmkR3QRP8LKx+yjkhsSlF1MGstGuFMviIG77RrltDBceZmRHtBbW59j8Fe3lNLcnboV1E1WpwXXdsNKZO04mSz2/YwrC2Q5O58LDtJBG09osIC0+dWPPA/IP4Xyhi5l3Q=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8dff07-5818-46c0-0fa4-08d6957b2863
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 08:29:08.6353 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3775
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

The ESAI_xCR_xWA is xCR's bit, not the xCCR's bit, driver set it to
wrong register, correct it.

Fixes 43d24e76b698 ("ASoC: fsl_esai: Add ESAI CPU DAI driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Ackedy-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changes in v3
- Add Cc: <stable@vger.kernel.org>

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

