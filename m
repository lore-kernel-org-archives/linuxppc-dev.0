Return-Path: <SRS0=Hg4A=QZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6931DC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 02:10:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9348A218C3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 02:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vnxAbPEB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9348A218C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 442nQY3th8zDqLD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 13:10:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=2a01:111:f400:fe0e::601;
 helo=eur04-vi1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="vnxAbPEB"; 
 dkim-atps=neutral
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on0601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 442nNY2nXrzDqF1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 13:08:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iQlMXXjIvloclGzWosZB9XBmOnE23A7TU25Ts488XM=;
 b=vnxAbPEB0c/WiQSU37eISluS1Zh/Eypj00plYy2gz801OkII5y6/UJOz9zH3usARZwbrelNV47JdQqk06ImdOTvsnKNoYspb2IllKkibFZL9EQkku4jWNTKCpZeXGvmjfI2bDki9LBYrq9fop8+p0RU7iMZq8MyMM+fE4HU9dII=
Received: from AM0PR0402MB3379.eurprd04.prod.outlook.com (52.133.45.12) by
 AM0PR0402MB3698.eurprd04.prod.outlook.com (52.133.38.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Mon, 18 Feb 2019 02:08:52 +0000
Received: from AM0PR0402MB3379.eurprd04.prod.outlook.com
 ([fe80::d41a:d251:f86b:d114]) by AM0PR0402MB3379.eurprd04.prod.outlook.com
 ([fe80::d41a:d251:f86b:d114%2]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 02:08:52 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: [PATCH V2] ASoC: fsl_esai: fix register setting issue in RIGHT_J mode
Thread-Topic: [PATCH V2] ASoC: fsl_esai: fix register setting issue in RIGHT_J
 mode
Thread-Index: AQHUxy7krEjmtZwkZU2ieefZbngvWg==
Date: Mon, 18 Feb 2019 02:08:52 +0000
Message-ID: <2a1997c2cd213ebfde70a2b325644de51e77d159.1550455620.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK0PR03CA0006.apcprd03.prod.outlook.com
 (2603:1096:203:2e::18) To AM0PR0402MB3379.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 035676a0-7de4-4ec1-bf16-08d69546073c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR0402MB3698; 
x-ms-traffictypediagnostic: AM0PR0402MB3698:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; AM0PR0402MB3698;
 23:vF5Y1aQwz4s1xzse9daAupH2zbaMEmyk5htJH?=
 =?iso-8859-1?Q?PlMza7ne6gTu3J9LbuvnS4fJOyh4JkXvmQO9PsKV1T6IhNTKoKynyfp1MN?=
 =?iso-8859-1?Q?gGs2PpmWG1pijCzcVCNzOkD598TkdZwrsTgzNaki4fOp1GW3+xcnIidSJ9?=
 =?iso-8859-1?Q?pf9bczfWGS4Usm/oYYRiXlAnneBQjuiyArL3vXqkeu2lT4Acnlfuwo8SCh?=
 =?iso-8859-1?Q?3wfKyvIrL89+8KK01ft/KtMOfzvpEP7L/9r8NsULxgN91uAXi6tFXLT/k0?=
 =?iso-8859-1?Q?SjBjrKsWRQUIhQxfJoDP15NbBkFth+9074AxJClApmkIOMUsu1YOA0h4I/?=
 =?iso-8859-1?Q?07N2WZfRRNRuW7ekWTKh8IZxum9XTrChB6cx2DpzzV30fkXjHZ8H8ayhNz?=
 =?iso-8859-1?Q?6d4bWigAaptqPc6GgY0K8kJOa/+zX0h17a9kUQZ7iOKGcAEeEbmKTr1LbO?=
 =?iso-8859-1?Q?N+Ep19jjWKTvCulK8BeK91tDANQj9e6VSUm2yZmYiDW1Jv3n+864+ErllE?=
 =?iso-8859-1?Q?zsJ5ai4bQtUFDebNU7oA13FbO8X5KiaoSUu23DdpdFfZD25QLEjHstQv09?=
 =?iso-8859-1?Q?gmNS+fQiWsXSketqKSqb1b2VcrFnPZFpl839glDdUpgkBBWaE6gMG95CkP?=
 =?iso-8859-1?Q?gPEcNV7ZhQU+3dHtFNZP7RGtHk/pFO4V+GoT8TRsDtf8xqik+84BkLZ7yS?=
 =?iso-8859-1?Q?OPgTMhe57WnTm80uZX9STZDUffdzQbdzuVeyE96Ch4LOnMXUGaiiI7k59B?=
 =?iso-8859-1?Q?PS8au1z/ZE1Ydyoauk1OWlGjWbTtKadHhVYRdCedsp08l8lc5CR+N6RBgp?=
 =?iso-8859-1?Q?zhu/3LUvdy724XL4XrLNfx4ielonBJsiHPFKmKsySQ2aWSLAj+MlWLE0Ii?=
 =?iso-8859-1?Q?OwZJhq1NFhLnK3eWxibzJWQESnqH/XjW9uT+NaqrjOHPgi3tUvNvYCuCev?=
 =?iso-8859-1?Q?kh3by0WubLQw/aggoY8jac4oy/gcgQxgYWFk3yf7h5dd9HVUNsfBseZfLf?=
 =?iso-8859-1?Q?AvvVw3E1+Cpcb+kWDIpJrQS8kCaMCbooC03cc9De47jeTKufkLgheLzQAl?=
 =?iso-8859-1?Q?k7HXb5PmFERzJb4YCvw0+y4nW8hAziWXRKfXaXZW5+ST3VdWXwESKU+1NL?=
 =?iso-8859-1?Q?WCub/huUAadHFeSBp7IuoHjjYeXK+qqvbGfQLT6HzZzM6ZJzIn6vRW4Jv2?=
 =?iso-8859-1?Q?ixuCL3KQTLNQka8M+XTt/ChvL0Ga5yr6f4KCmmma9lK6JUk1IOICUnKw1+?=
 =?iso-8859-1?Q?NE/e7Peeum7ja89kY2T?=
x-microsoft-antispam-prvs: <AM0PR0402MB3698D08FAE723E6EC864B5FCE3630@AM0PR0402MB3698.eurprd04.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(346002)(396003)(136003)(376002)(39860400002)(199004)(189003)(105586002)(6436002)(6486002)(86362001)(102836004)(66066001)(186003)(25786009)(97736004)(6512007)(478600001)(2616005)(476003)(8676002)(8936002)(81166006)(2201001)(81156014)(305945005)(106356001)(68736007)(53936002)(26005)(50226002)(52116002)(99286004)(486006)(316002)(36756003)(54906003)(6116002)(7736002)(3846002)(2906002)(5660300002)(14444005)(71200400001)(110136005)(71190400001)(386003)(6506007)(4326008)(14454004)(118296001)(2501003)(256004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR0402MB3698;
 H:AM0PR0402MB3379.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j3K+JReCXYJmdA3pGKOmE57TvZpPS0u0WF/5PI+qtZuT3SF6EkEBMMPB3UfU0xicpV2YBPUuKSKQUj41pqlHJfHAz8OuDtPScHxlh6QVNfAXUfxsz9EslplZTCLToXweTz4MSG1y3fh57wOlQJS2S6ohFPrsflgkYThzP4FUEPeAVxMMP6OjkwsVlupVKFGQv+6sHc1onvL8T0kjajkoFCVXIUyavoD2IBtbxl0RfeQBxJQjgvEjj1la97bXoObeajBTvKmYT5Q2s9fuG8hOtjcspaVmAisEqIcsobkaybsD/1m1kgTDoOB2khTbxlSyz/LMKfZRGm0cfwMLimQHwMavbZUDrnrRplw9OjMPuuLu2BJ0kbtNEKHGKBD1v14wytX598VOe6YuJd0QO/LaXxC5goswm3x4XsLxV9iDO5o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 035676a0-7de4-4ec1-bf16-08d69546073c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 02:08:49.1624 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3698
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Fixes commit 43d24e76b698 ("ASoC: fsl_esai: Add ESAI CPU DAI driver")

The ESAI_xCR_xWA is xCR's bit, not the xCCR's bit, driver set it to
wrong register, correct it.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Ackedy-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changes in v2
- add Fixes tag and cc stable kernel.

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

