Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFE6C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 05:58:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A20BB2184A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 05:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xrYe8bB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20BB2184A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4492194ntnzDqJg
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 16:58:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.13.51; helo=eur01-he1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="xrYe8bB4"; 
 dkim-atps=neutral
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr130051.outbound.protection.outlook.com [40.107.13.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4491yd59kczDqKT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 16:56:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvUjlQoUofmDrGApjwYJI5TNUDnP1SoTs12GkAcUhE8=;
 b=xrYe8bB4bsdca6DPCppjkwkmgEnEO05BGC5eNZF+ELzfIMCrobrysDOiurMsEHJ5bSVKPLix3yKeT7mKWvNLbtKeVRUE29tdoNjp3smNAYKVlUfA3R9URRHTG8pDonvkUiMcB14at/YGYnHS3tX2XRbEOzXYfcYpq5rhRu8+Zhw=
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com (52.134.1.153) by
 VI1PR0402MB3374.eurprd04.prod.outlook.com (52.134.1.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Thu, 28 Feb 2019 05:56:31 +0000
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22]) by VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22%3]) with mapi id 15.20.1643.022; Thu, 28 Feb 2019
 05:56:31 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: [PATCH] ASoC: cs42xx8: Remove S32_LE in format list
Thread-Topic: [PATCH] ASoC: cs42xx8: Remove S32_LE in format list
Thread-Index: AQHUzypa4n8NriEugUOXybmAqJXINg==
Date: Thu, 28 Feb 2019 05:56:31 +0000
Message-ID: <1551333389-22791-1-git-send-email-shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:202:2e::28) To VI1PR0402MB3392.eurprd04.prod.outlook.com
 (2603:10a6:803:3::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e299352f-1576-4e33-a401-08d69d417ca2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3374; 
x-ms-traffictypediagnostic: VI1PR0402MB3374:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR0402MB3374;
 23:xx2wTZgtmqUZ4yy5DQ5sKSEg4OLHinC9RHAii?=
 =?iso-8859-1?Q?fNbNPWFruy0ebPtCXi3AL+7bx/l9jqWrXYdhnZf9ZG+hAQAuHvPyYwO3Vm?=
 =?iso-8859-1?Q?N2/6LoU06AJRiTVsxf8IDwMjYs8NAPiALbnYSX7zr1DlXvyA23W7UZFA4U?=
 =?iso-8859-1?Q?WHY1AqUTNPj6VVWqejbvZt/pAxjXPveFKs0RNw+rhm0O6QWQCaXF0rJa0J?=
 =?iso-8859-1?Q?AU67HpYkPocsgHh3zbaDkIc1Y51nIcmrYPBSXlWmsxmERtNkTPe/j/YOY0?=
 =?iso-8859-1?Q?lMPS4UMHxRxk1rNOZ5aqCxyx/Uvg4XXzcR6Tt3GZ36hA6c/HUSzCNwcpFk?=
 =?iso-8859-1?Q?nJIkRl8pwjb+G6pPQi766UAiMQaMQjVtKWFogUIiDXhbuCr+Yi/cI4J7Oc?=
 =?iso-8859-1?Q?Ske+AUruwb3ZnNLmZqQS4ThUTUBt7SCampoJO38RIL9fYExARufowAaF+O?=
 =?iso-8859-1?Q?wvloL66KzrGzGSFIDDQXXTqmIZuhcuPNDu+Zj1iXMTk2JMqnWe5f9ZBGqF?=
 =?iso-8859-1?Q?wqx+h/JYQ1w6jwT07Hd/OSn1FFgOKwvJQY+LpRhiYG3RTIUlTyhygk2HR2?=
 =?iso-8859-1?Q?kfxjXjWeK0/3QBTHZizEb77c8zLEYwGQmApx+pQkJmATxvaloKFRc/6daD?=
 =?iso-8859-1?Q?h0GBR2Enbf/hOQ8rI06IWAfUFziHDK17l8cAytcwzGLIVF6fYjlVsv8krg?=
 =?iso-8859-1?Q?B4Hws0KTOAny1UfyfE6Gv+4EAVY8KB0SAEL78DNI3xAA0x2SjyQn4FDF0Z?=
 =?iso-8859-1?Q?eo+p54gKDY207rmxcwF/2eHyKSm/XMK/M5r+i0CUqo3uh8Q+79TZ0c8gSd?=
 =?iso-8859-1?Q?z76qk1fhMBVvEZK/HblCs24pyte5yZ8Eyb08i62yBN0Sb8S+2Eh4GYtnaZ?=
 =?iso-8859-1?Q?B69zQaeht6BKwTaH5LKGI7yRE9mfFY66N1qi/3hHb0I8mMX2B9TAIcE+g5?=
 =?iso-8859-1?Q?hK/si7FEZIwseq+3Lpu9J+9z3PnJNMuhsIzj2thEUUNBIkgoT6ZKP9EISY?=
 =?iso-8859-1?Q?3697VgKvx6SsYTP9t1zbp79xqo1F5oy7MMS62Ul54FieViFGAQDOkk8Og1?=
 =?iso-8859-1?Q?o59OpzDd52iFMSxnBb4ivbFiXQAPRVmPRUizuO+DGA1f3aVJOATRY3d1Qm?=
 =?iso-8859-1?Q?r4umO61hH7l+s8vF+GyAwuHAG0K8ehJgOl4YFPN0PQqzXFS57rpT92OG89?=
 =?iso-8859-1?Q?D+AL1uGlnkoSW9E7tp9bDxxf0J/oZ7yrHG294CoV2S30CbVCVbWtqjdlGl?=
 =?iso-8859-1?Q?MtzOhL0/kqKNi/8QgSH87gr4D/3c6cLJrs73i03R3i/uNMi3fLSoSDxVo3?=
 =?iso-8859-1?Q?k6+JbT+TY+Tvnh2VOAEW/Uw++?=
x-microsoft-antispam-prvs: <VI1PR0402MB337436BED85D2322FB358552E3750@VI1PR0402MB3374.eurprd04.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(39860400002)(396003)(346002)(376002)(136003)(366004)(189003)(199004)(52116002)(106356001)(8676002)(305945005)(105586002)(99286004)(102836004)(6506007)(386003)(50226002)(186003)(81156014)(2201001)(81166006)(97736004)(8936002)(4326008)(68736007)(26005)(25786009)(5660300002)(86362001)(71200400001)(478600001)(71190400001)(476003)(486006)(316002)(2501003)(256004)(2906002)(110136005)(6486002)(7736002)(3846002)(6116002)(53936002)(66066001)(6512007)(14454004)(36756003)(4744005)(6436002)(2616005)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3374;
 H:VI1PR0402MB3392.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lh4y4bgWWqqPLnSnPw5elUvAIgMlNRs0TmXwYG8Xl66VQwUsMu+JoZr2yd5vJ3Dj3xcSdOuMYclQy1hN62nrZL+KIuUXX6b7yC7Ra3BOn3vPpNRQGgxAlaBKsrzk/YHh1Js0j4KBASN7IZvse8RakVbRjmPG+QQyY9hZTB4TKt/gw+eCaK0/CNY+XPPdKko+UjpxpVv0/c9WgVk3U/B2UdBvWlvtnM6ZUuKX6odhM2JrqhV3O4+UK6L094J1Z0WlznllGq9oVsDA67qWHsi8HC8mMkb6lQDVfKuZXsl8wZpeWVd9z/e4mZJ4z9C1yFkWBUV+429JDvK12ETuZqQpn0RqHicod27SViUwK4OshruELIgfK1H4ULI3IN+kNHP2PagxbyW7B2LdLyvfGTJniTyreCVOIyCL3tRg5KJLPXM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e299352f-1576-4e33-a401-08d69d417ca2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 05:56:28.4784 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3374
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

cs42xx8 is a 24-bit A/D and 24-bit D/A device, so the S32_LE
should not be in the supported format list.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/codecs/cs42xx8.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42xx8.c b/sound/soc/codecs/cs42xx8.c
index ebb9e0cf8364..271972337d23 100644
--- a/sound/soc/codecs/cs42xx8.c
+++ b/sound/soc/codecs/cs42xx8.c
@@ -32,8 +32,7 @@
=20
 #define CS42XX8_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
 			 SNDRV_PCM_FMTBIT_S20_3LE | \
-			 SNDRV_PCM_FMTBIT_S24_LE | \
-			 SNDRV_PCM_FMTBIT_S32_LE)
+			 SNDRV_PCM_FMTBIT_S24_LE)
=20
 /* codec private data */
 struct cs42xx8_priv {
--=20
1.9.1

