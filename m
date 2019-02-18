Return-Path: <SRS0=Hg4A=QZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563B7C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 15:26:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 420FA217F5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 15:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RC4/vMbc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 420FA217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44375C1SYyzDqKX
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 02:26:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.3.56; helo=eur03-am5-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="RC4/vMbc"; 
 dkim-atps=neutral
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30056.outbound.protection.outlook.com [40.107.3.56])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4437391XCRzDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 02:25:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWKPaf2jF/kciS0KBtUJjSvvYpofoLLLsHtskMy7AOY=;
 b=RC4/vMbcRM0b7BUF+Cbfq/s0S5xBpm5WfH6KVOiVBV5OdpkI4b6kEl3KO1kaQqwXwbWuo52weKhiaLGMEbR6UfOfPFo0RPduUE0t9lUBpg0LfRGC92xit3ktU8Wkw+6psL9rY7m9b0RmJfKiSDW7K02BE9IM+7BBqYmKbfM7X6U=
Received: from AM6PR04MB4693.eurprd04.prod.outlook.com (20.177.33.222) by
 AM6PR04MB4533.eurprd04.prod.outlook.com (20.177.38.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Mon, 18 Feb 2019 15:25:00 +0000
Received: from AM6PR04MB4693.eurprd04.prod.outlook.com
 ([fe80::78b6:cae3:86df:a936]) by AM6PR04MB4693.eurprd04.prod.outlook.com
 ([fe80::78b6:cae3:86df:a936%4]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 15:25:00 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl_spdif: fix sysclk_df type
Thread-Topic: [PATCH] ASoC: fsl_spdif: fix sysclk_df type
Thread-Index: AQHUx54cV0e+cjZqWUucEsNTrxgp8Q==
Date: Mon, 18 Feb 2019 15:25:00 +0000
Message-ID: <1550503474-18865-1-git-send-email-viorel.suman@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P189CA0013.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:206:15::26) To AM6PR04MB4693.eurprd04.prod.outlook.com
 (2603:10a6:20b:7::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfca4032-1908-4cac-ef41-08d695b53f1a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4533; 
x-ms-traffictypediagnostic: AM6PR04MB4533:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; AM6PR04MB4533;
 23:0tKOhhWx3KQ6/7xkBy7/0F4KkCr4NS10Ca646U1?=
 =?iso-8859-1?Q?5yq53MEi5VmPQuDYFrx4jAu1TyNAse6he3rAsnU/1JtUL53mfbz6h/jtMK?=
 =?iso-8859-1?Q?7IbWmLS48taqS2cJOloqFmGxkUeKOV2Zs4TroQsqPPQHIpagBD2nTa9zm+?=
 =?iso-8859-1?Q?peDiuz1o2KhKYksq3F3CshbOOMxCnbICwcf8zwn0IcDwUTKp0IWRtCOzNo?=
 =?iso-8859-1?Q?EMZMR+vBfLwVMaBJ+npvtYI/Ovepgy2UAw5ePnkFs7s7byBqtGollY0Jl3?=
 =?iso-8859-1?Q?BYmvXtfWFTldtNvO7b58Ri6j/MmiTuqFAW/XQPZmZomXkN/0TVDb6zx9CW?=
 =?iso-8859-1?Q?KoeMmUUQuZUOaE6tY+2EKYxQjbQiOH0fVnhzfKWxf7zelS/bEzLaqIRMsy?=
 =?iso-8859-1?Q?M+FQCyiHw0XX5ArA77tGJf4jBH6Awi4o0ZXKCBn7CEjlywogDemE9exjNx?=
 =?iso-8859-1?Q?wnn5WIUOn7K/oZwqs/ugqUXho7BnCRtK0JPIE9Y4yMwkfBrXfMSUNwWRRc?=
 =?iso-8859-1?Q?alUzs1kx74/SvrpGMjO0R2CCL51NKd2cuvzzp/m1TUTbNv2uMU2r8w8gby?=
 =?iso-8859-1?Q?aqBS3/C+pyXyvGAq4vuuV5eaQl7B5r6zi/3FHbuQ/9XCNdz3sPnmgABoz6?=
 =?iso-8859-1?Q?xRZfImu4Fe5TCwyqIE0GbkIWS78rohQ/HVRzjNAWTjgmjmGz/TlG2RNzGQ?=
 =?iso-8859-1?Q?/tX7WFxsIIfxU6rOYtOUsB9euaj11ycN2vM8TD+FO6dbULqxGg+xnhmxgw?=
 =?iso-8859-1?Q?+hWUdZcNPsmMM0Z4scrUOq/cN+5WTr5mqg4JCLCNOLp/XBYqF2Qyyjy9Bq?=
 =?iso-8859-1?Q?KD/tUVtfnNTnwVc6NFl1XKpw5cO+R8qP8bdtPYc04lpDQy8Shq7ZBxpBJl?=
 =?iso-8859-1?Q?bPD/5z1YYc7nwx5e120duV3FVcAiFEdmrb70aAB8b7eoBrAdyfozP5zbyD?=
 =?iso-8859-1?Q?NvWQG6p/103/DRSrpjEIqTghnyBAxd2iVQSwRpY+rtuYhnLv+QHHTikbVc?=
 =?iso-8859-1?Q?uotneF6nQm+4zfwjCiNH7MlLULjMbC0yWnZ2bOCLLwtxU4TwgMgnq2DOSD?=
 =?iso-8859-1?Q?GqlY2MrhpoFBb5VIMzze7t3Bp6ZWKyy+nGbpHqCqMSPBT1UVkQKcp05Dcw?=
 =?iso-8859-1?Q?xTbxoG7vrvqnPz9s/i2M6Frj8PBFilmY1Y8HZm61IxGay6zMQXXKR7nur0?=
 =?iso-8859-1?Q?KiEAdHMF+Bc93Oss6ytkOGN77MGJFLI+61hMhIQgDpEqdIMn6oEy0I=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB45339DD53A092195E207E88C92630@AM6PR04MB4533.eurprd04.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(136003)(346002)(376002)(366004)(396003)(189003)(199004)(6512007)(2616005)(5660300002)(8676002)(36756003)(26005)(81156014)(7416002)(8936002)(81166006)(86362001)(25786009)(7736002)(4326008)(2906002)(305945005)(476003)(486006)(97736004)(53936002)(14444005)(110136005)(50226002)(256004)(6436002)(66066001)(99286004)(68736007)(6486002)(52116002)(186003)(6506007)(71200400001)(54906003)(386003)(478600001)(14454004)(44832011)(316002)(106356001)(105586002)(6116002)(3846002)(102836004)(71190400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4533;
 H:AM6PR04MB4693.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pSxKWc02S85XakGHFhnFONMpx+PbALMoLXwW4+rworsWz8OiQcIURnjH5L9l8c5/NEJDQxsbPm/cELca2Xr13Bcp8FnOmq8zNIui9skybTpQb7Hc9YB2sNv9JeeHdjNqCq8TJHY9Kbu9Lan7UrM48yBaGYyF8KCC+zi3K4hsyyjz3EshssQF4Qmj8WIvKsKrW3KdVXItAAEXy45BCzKxJ+Hix8w+cPFTs2SYnRIa4CYRErGmn6zE4WGS4i1eaYW3KAz/yq2bjWv0ttCg4YGmy5bGMS+9NtBsszX/vBGwdsBn2USPm++Jbn7xh9Br4Qz/DCD6C07lwCUmygNHzascBTgd8MVWrgidZ6OXiDTpykfPf4UyZVCdNEZB5TOpao32Urnqct0BChTK980+yh1Y+IGIPk1xI30/ZkCzBczQ6uU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfca4032-1908-4cac-ef41-08d695b53f1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 15:24:59.2557 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4533
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Viorel Suman <viorel.suman@gmail.com>, Mark Brown <broonie@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Jaroslav Kysela <perex@perex.cz>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

According to RM SPDIF STC SYSCLK_DF field is 9-bit wide, values
being in 0..511 range. Use a proper type to handle sysclk_df.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 sound/soc/fsl/fsl_spdif.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index a26686e..4842e6d 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -96,7 +96,7 @@ struct fsl_spdif_priv {
 	bool dpll_locked;
 	u32 txrate[SPDIF_TXRATE_MAX];
 	u8 txclk_df[SPDIF_TXRATE_MAX];
-	u8 sysclk_df[SPDIF_TXRATE_MAX];
+	u16 sysclk_df[SPDIF_TXRATE_MAX];
 	u8 txclk_src[SPDIF_TXRATE_MAX];
 	u8 rxclk_src;
 	struct clk *txclk[SPDIF_TXRATE_MAX];
@@ -376,7 +376,8 @@ static int spdif_set_sample_rate(struct snd_pcm_substre=
am *substream,
 	struct platform_device *pdev =3D spdif_priv->pdev;
 	unsigned long csfs =3D 0;
 	u32 stc, mask, rate;
-	u8 clk, txclk_df, sysclk_df;
+	u16 sysclk_df;
+	u8 clk, txclk_df;
 	int ret;
=20
 	switch (sample_rate) {
@@ -1109,8 +1110,9 @@ static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_pr=
iv *spdif_priv,
 	static const u32 rate[] =3D { 32000, 44100, 48000, 96000, 192000 };
 	bool is_sysclk =3D clk_is_match(clk, spdif_priv->sysclk);
 	u64 rate_ideal, rate_actual, sub;
-	u32 sysclk_dfmin, sysclk_dfmax;
-	u32 txclk_df, sysclk_df, arate;
+	u32 arate;
+	u16 sysclk_dfmin, sysclk_dfmax, sysclk_df;
+	u8 txclk_df;
=20
 	/* The sysclk has an extra divisor [2, 512] */
 	sysclk_dfmin =3D is_sysclk ? 2 : 1;
--=20
2.7.4

