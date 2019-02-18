Return-Path: <SRS0=Hg4A=QZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A2AC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 14:18:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0073C2177E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 14:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="r/V7Xfmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0073C2177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4435Yv68FdzDqDt
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 01:18:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.2.53; helo=eur02-ve1-obe.outbound.protection.outlook.com;
 envelope-from=viorel.suman@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="r/V7Xfmb"; 
 dkim-atps=neutral
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20053.outbound.protection.outlook.com [40.107.2.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4435RF4kNzzDqBS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 01:12:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nB+yGhEMgxaLfkNdQL5sKx/hEWR2mj5E6rJg2KkcPnI=;
 b=r/V7XfmbN7tUEHN0dWSrdaVnq0Sd4B6Ks4gxKISt83Cp8aJlEfiryz96xGYygGmrykpNN4gsoKiyWIOyW8xUFU6bpzpQKBYPa7ZpkSCUvonloH3XHQtxiMowNpy5Xawtz8HmhdIamvPVl6MamRJJxpA5umj767fun2rHK5dDXCQ=
Received: from AM6PR04MB4693.eurprd04.prod.outlook.com (20.177.33.222) by
 AM6PR04MB4437.eurprd04.prod.outlook.com (20.177.39.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.20; Mon, 18 Feb 2019 14:12:17 +0000
Received: from AM6PR04MB4693.eurprd04.prod.outlook.com
 ([fe80::78b6:cae3:86df:a936]) by AM6PR04MB4693.eurprd04.prod.outlook.com
 ([fe80::78b6:cae3:86df:a936%4]) with mapi id 15.20.1622.018; Mon, 18 Feb 2019
 14:12:17 +0000
From: Viorel Suman <viorel.suman@nxp.com>
To: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] ASoC: fsl_spdif: fix TXCLK_DF mask
Thread-Topic: [PATCH] ASoC: fsl_spdif: fix TXCLK_DF mask
Thread-Index: AQHUx5P0SUgTLkuWIUOONEXl4qIxvw==
Date: Mon, 18 Feb 2019 14:12:17 +0000
Message-ID: <1550499117-11801-1-git-send-email-viorel.suman@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR02CA0003.eurprd02.prod.outlook.com
 (2603:10a6:20b:6e::16) To AM6PR04MB4693.eurprd04.prod.outlook.com
 (2603:10a6:20b:7::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=viorel.suman@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74bc0aab-73c9-4ee6-6f34-08d695ab16ce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4437; 
x-ms-traffictypediagnostic: AM6PR04MB4437:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; AM6PR04MB4437;
 23:pg+aUh8k43Z/Hl9IIi/HHsUSQN6wLWU9XUkAJ5V?=
 =?iso-8859-1?Q?XvNVsNfVZ37iayHCbuKgif2Cjx9naq8Dy9sl3tz3g0gXuwhUhRlxaWukV2?=
 =?iso-8859-1?Q?V27uaSv2mga1uyPk5qbhLwMsbVIszgLXCrpqN2irXoaK45aYITkUIb3tlK?=
 =?iso-8859-1?Q?1KEXpJHodsccQcfF5QW+a0ARTAKclcyZ00t25IAhdLZbpyH+SLlBXOvKqF?=
 =?iso-8859-1?Q?tyz44c23uPwetCkdHuc80l37xSfeMMUOnGHozdlT6Nj4xd0BVL99gpHfqV?=
 =?iso-8859-1?Q?wW2mIltmri1EslBXj6G+9CtLmDm9pFZqSlW1vBXDJjHOhp5XoTbBbOd3Oe?=
 =?iso-8859-1?Q?/NTgDvbHU40gMO9WCW6VOw6k4bXOqYtLQ0Fgo4jnQc4bZTsO46LzVm2JcJ?=
 =?iso-8859-1?Q?PEi37ZmF9qf5wED7nXN/fuNdgqdgJTU8SVfAk1dSdpi3/aOIWhXnDqQvcJ?=
 =?iso-8859-1?Q?1OcVD0GcCuAYiJEYtgewvd0XTf49+zYDLqQl6ZfuOmgN8j+E8a7m2tsTt4?=
 =?iso-8859-1?Q?L4p2i62jM+odzMDM2NyO/SZ58e/m0ETBkkcVAL8HmLm1D80Yj3tEfSWXss?=
 =?iso-8859-1?Q?SJGaBSv+nncbs4ymUcpuWtm1FE2J6YHyxm8hadc3vV0TGUOjRs1Yc+T10m?=
 =?iso-8859-1?Q?fn9RyW4h+etE6FgjUlEx5mvCt8r/WGgxAmeQO6xHNyw3NihfmKedIfUQuU?=
 =?iso-8859-1?Q?1VqcKHq6jeIT2TmfTlISo6NcGJNAHrxKGedA3986GLB9tw6+jfeqk7LfH8?=
 =?iso-8859-1?Q?Brtk2Qt+07f9UiuDwLLFIlVfZcZy4ivlwJ5eCXctYQA8n5aZLo7rWiZbiz?=
 =?iso-8859-1?Q?Jk8f2UvYKZhOgUK6eTJLZKidBJEoNIH5uGMDPBFCWTzPnb0WFq7oLaYzPp?=
 =?iso-8859-1?Q?oloyk+nB0pQSSBa1mNQVRO7oPUrZ6GUhRnmfnbYRGHM8EhHsBtOeIpAm+Y?=
 =?iso-8859-1?Q?HB7nJYexloFfRNNmMQPn+V/uaS+j7hMUd+IRtW5io/Fw6ONhG3zeeIPGhR?=
 =?iso-8859-1?Q?pBqz64TwhclZLqJ+MZdzo7fbPZIagu+94J17U46V6BzEdhtemsRn/Aavrx?=
 =?iso-8859-1?Q?WlYQDsA1s0BK3M8Fu4Kkqs+3HPHIJ/QKoYUDMSRQUR285VIkwpYKhjG+S+?=
 =?iso-8859-1?Q?8YjIjF3mS5/4LLVWlrYhfCfjVwln6qVsfds+j/0lkcMowE6fZm8bTU0zpm?=
 =?iso-8859-1?Q?cR2bIASyOlIPlHGf2f55i00beBYoinJMklS/T63cfg9I0dMD7O7ANE+6CK?=
 =?iso-8859-1?Q?iV16IRB5dDrH2tB26?=
x-microsoft-antispam-prvs: <AM6PR04MB4437366202A5D1F533C41B0292630@AM6PR04MB4437.eurprd04.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(136003)(366004)(39860400002)(396003)(199004)(189003)(2616005)(476003)(2906002)(5660300002)(44832011)(486006)(7736002)(71190400001)(71200400001)(14454004)(14444005)(97736004)(26005)(7416002)(186003)(50226002)(68736007)(256004)(4744005)(386003)(6506007)(102836004)(8936002)(81166006)(66066001)(81156014)(8676002)(52116002)(99286004)(36756003)(86362001)(110136005)(54906003)(3846002)(106356001)(6116002)(316002)(305945005)(478600001)(105586002)(6486002)(25786009)(4326008)(6512007)(53936002)(6436002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4437;
 H:AM6PR04MB4693.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7MycdNLERyqXMInAwdZ0BQqitLyrPgDA0brPH43B2NI+dklilN9tdq6dlX3o1kP6jkWUzrUZyQ6n9dpcuPbWMN5bXaiIVHrL9mUCCjlch8R2j28yybMNHAC6sNOWGFH1ikuON07wbuM8q7TfHNhKOeZ1xAqKzxrrFlKeY1AiRg2NQBgx1Um1DfcXDqXfzE1naKMX+h/kDq16ytQrployjlNDwAP5Ab3H22C1s+ZB3wP4xrhz5agWedfYQl8l87gVN/tm2r4RiUZjxtGuV6rGDlnZ7+5tX7V6roiA8OGtRYFh+pigDx9QXBwWUpPBbpKqj5kDpvU3T7aWtb+ScpD3guBXc+2b0nlVz9xqaqcWsG4J/a2dSz05SftIQDZG2pM5HLluMQgmc2KRBfNYv8wq0oxGUIb3kbnvjjWkvqdYqBI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74bc0aab-73c9-4ee6-6f34-08d695ab16ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 14:12:16.8063 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4437
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
Cc: Viorel Suman <viorel.suman@gmail.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

According to RM SPDIF TXCLK_DF mask is 7-bit wide.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 sound/soc/fsl/fsl_spdif.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_spdif.h b/sound/soc/fsl/fsl_spdif.h
index 7666dab..e6c61e0 100644
--- a/sound/soc/fsl/fsl_spdif.h
+++ b/sound/soc/fsl/fsl_spdif.h
@@ -152,7 +152,7 @@ enum spdif_gainsel {
 #define STC_TXCLK_ALL_EN_MASK		(1 << STC_TXCLK_ALL_EN_OFFSET)
 #define STC_TXCLK_ALL_EN		(1 << STC_TXCLK_ALL_EN_OFFSET)
 #define STC_TXCLK_DF_OFFSET		0
-#define STC_TXCLK_DF_MASK		(0x7ff << STC_TXCLK_DF_OFFSET)
+#define STC_TXCLK_DF_MASK		(0x7f << STC_TXCLK_DF_OFFSET)
 #define STC_TXCLK_DF(x)		((((x) - 1) << STC_TXCLK_DF_OFFSET) & STC_TXCLK_D=
F_MASK)
 #define STC_TXCLK_SRC_MAX		8
=20
--=20
2.7.4

