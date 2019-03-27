Return-Path: <SRS0=MnD0=R6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A679C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 09:31:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6295B2075E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 09:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iqqquzAB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6295B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TjS86RC9zDqP5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 20:31:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.4.50; helo=eur03-db5-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="iqqquzAB"; 
 dkim-atps=neutral
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr40050.outbound.protection.outlook.com [40.107.4.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TjQ62bzvzDqGF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 20:29:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5unYHKtMDUDeG4xLPNpLUg7JC8nwYOMXovA+iDGX/M=;
 b=iqqquzAB5kez5asWl3ctgC2AM0zsvVrnr8BDvwXWK8LQC4yFUJpDsOGKJR7g1HxOuwLQiV6nLzta4EBo7dxscoFP+WRp57XvPCK1rrYH5GlgGPl47Hm4W9W12DUo8JSyxEtkaStLKv2ZNSgxmTwlJff1ECMAWKkO49ihNmFKdk8=
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com (20.177.48.157) by
 VI1PR04MB5022.eurprd04.prod.outlook.com (20.177.50.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Wed, 27 Mar 2019 09:29:38 +0000
Received: from VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888]) by VI1PR04MB4704.eurprd04.prod.outlook.com
 ([fe80::2594:3cf0:20a2:8888%3]) with mapi id 15.20.1750.014; Wed, 27 Mar 2019
 09:29:38 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timur Tabi
 <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li
 <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Viorel Suman
 <viorel.suman@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta
 <daniel.baluta@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>
Subject: [PATCH] ASoC: fsl_audmix: Fix kbuild failure
Thread-Topic: [PATCH] ASoC: fsl_audmix: Fix kbuild failure
Thread-Index: AQHU5H+Za4taWNTOpUOEdsHqnsjN/w==
Date: Wed, 27 Mar 2019 09:29:38 +0000
Message-ID: <1553678953-31228-1-git-send-email-viorel.suman@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR02CA0057.eurprd02.prod.outlook.com
 (2603:10a6:802:14::28) To VI1PR04MB4704.eurprd04.prod.outlook.com
 (2603:10a6:803:52::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca4440bf-59b1-426e-7c53-08d6b296bb81
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5022; 
x-ms-traffictypediagnostic: VI1PR04MB5022:
x-microsoft-antispam-prvs: <VI1PR04MB50229C84456A739C87B62B8692580@VI1PR04MB5022.eurprd04.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(366004)(199004)(189003)(99286004)(4744005)(66066001)(256004)(14444005)(6116002)(3846002)(44832011)(6512007)(106356001)(86362001)(6436002)(71190400001)(71200400001)(7416002)(6486002)(105586002)(186003)(486006)(102836004)(8676002)(26005)(386003)(4326008)(5660300002)(53936002)(476003)(2616005)(316002)(110136005)(54906003)(478600001)(6506007)(50226002)(8936002)(81156014)(97736004)(36756003)(2906002)(7736002)(6636002)(305945005)(81166006)(14454004)(68736007)(52116002)(25786009)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5022;
 H:VI1PR04MB4704.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y8Rj6gvpmM4QpUcWXG8KZbbPsxA+S/5C6kIcSa3FlcFLrf7u2vn9oTRemPgkXODNl0DdzX4zcA9A/U9PvLFhYt+z5qO2Qx1KiuXZubnDWmfvqxu2jommPWH8WkyVwgcAHWo1RDC0dNfhh0ST5mp5QKHSyYO26rHBNYeMZMNd1R1qE7s/qmB0pzd58sz5dusesOqLq6QqpJMKj8enqVQWrWxTNgcrWPR6kJfiVAT2o+wyoET5p5RuveD+77oA6lmRdC+6ip5I53SvNOaxXuhditpl0u7t4/hlqM1yzZ4yg51FUjnIkqIzc+0d/nOL/eTni8mIvavND4OMVBiNLGA0+OQzb1NFBTNIXJG/hyjxGzFVQxCZwXdaf0zlV+5+bm4tbKnjlktxcyVVexY+OZRRrAZgoG0jiJj7bfifQHsNru8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4440bf-59b1-426e-7c53-08d6b296bb81
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 09:29:38.3249 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5022
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Viorel Suman <viorel.suman@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The format in dev_dbg function must be a constant.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 sound/soc/fsl/fsl_audmix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
index 3356cb6..dabde03 100644
--- a/sound/soc/fsl/fsl_audmix.c
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -90,7 +90,7 @@ static int fsl_audmix_state_trans(struct snd_soc_componen=
t *comp,
 	struct fsl_audmix *priv =3D snd_soc_component_get_drvdata(comp);
 	/* Enforce all required TDMs are started */
 	if ((priv->tdms & prm.tdms) !=3D prm.tdms) {
-		dev_dbg(comp->dev, prm.msg);
+		dev_dbg(comp->dev, "%s", prm.msg);
 		return -EINVAL;
 	}
=20
--=20
2.7.4

