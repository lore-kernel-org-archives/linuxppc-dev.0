Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34D1C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 02:34:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 292B820643
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 02:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PMmJSZnC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292B820643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449YQz1WBszDqNn
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 13:34:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=2a01:111:f400:fe07::603;
 helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="PMmJSZnC"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02on0603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe07::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449YP23wylzDqK6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 13:32:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ec5/tzUrU74NIXHH3f6ma3eJeRAyv0SS40J38BP96g=;
 b=PMmJSZnCADwP5S87Pgh9hkN1Reu5ouOosgFt1uB+w3mNoyJO8eFDb9aj0FZeoGeONS2zFl5T4bxHk/ikrDYUOmD2q+6dQRFooMjDoauqRJWtK5HuAFK9AKvNj/5jpH6Q6sT4uVa07ZXts0nPvBRAIj+DQob9xrOhw8iUZplWDPs=
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com (52.134.1.153) by
 VI1PR0402MB2702.eurprd04.prod.outlook.com (10.175.22.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Fri, 1 Mar 2019 02:32:38 +0000
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22]) by VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22%3]) with mapi id 15.20.1643.022; Fri, 1 Mar 2019
 02:32:38 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com"
 <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org"
 <broonie@kernel.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>
Subject: [PATCH] ASoC: fsl_asrc: add protection for the asrc of older version
Thread-Topic: [PATCH] ASoC: fsl_asrc: add protection for the asrc of older
 version
Thread-Index: AQHUz9cJhoJPvCZVnE6C6u5MyrK9cA==
Date: Fri, 1 Mar 2019 02:32:38 +0000
Message-ID: <1551407560-29950-1-git-send-email-shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK0PR03CA0054.apcprd03.prod.outlook.com
 (2603:1096:203:52::18) To VI1PR0402MB3392.eurprd04.prod.outlook.com
 (2603:10a6:803:3::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 069613c1-f85d-42f5-10c0-08d69dee2bb2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB2702; 
x-ms-traffictypediagnostic: VI1PR0402MB2702:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR0402MB2702;
 23:alcYpGSvM4Asidj86H2xTHjFKQPbBmEPuPHRG?=
 =?iso-8859-1?Q?05zRxb6kMVrHuo1Fm7TYbKRQnp/+efEBiOA7FkTiki29DU6nZOdhRJXIxz?=
 =?iso-8859-1?Q?jwHUZltBghz9pV+ezd2GjChd4WRAWfx3ZMQ8M4ngUT6sdzlCY3Hvb/i9mF?=
 =?iso-8859-1?Q?BwEn2IibHhJVv9GyassN6OCPPid7XSftSjqUsg8SeQlfaWsES6M89imZDL?=
 =?iso-8859-1?Q?DCm2F2rxpncUYg5LrqPRqH78OGkWQ2m+fTzOwaMkXMHac7Rw7Z+qgzARu3?=
 =?iso-8859-1?Q?IFoIGONpdRpp6qpWcPD3+7Yc0R5SL6sb59C24ueVUkaIgkRQBn8oUv0+q3?=
 =?iso-8859-1?Q?hih8hnLLp/53Ct6AyPx0evCp2dziLjSCG03N+QJLg60w4+D/dseMbuSY+G?=
 =?iso-8859-1?Q?rleG+K8fY+scFKKymuUgMTVqzo2TWfIgbBANvY4YNA5v9FOu5naTI5UoT6?=
 =?iso-8859-1?Q?P9/idxbxmcxh5LFS7buU1y1EC9XSm4P/joxInNuyEDkO3dHPRD5gr77g2M?=
 =?iso-8859-1?Q?7kgK/ErFWDKvlQWtVtTfZKBB4oRUeuD3bGqYqthjalwqpVS0EVQFnTcQ5z?=
 =?iso-8859-1?Q?Z6buT4lWeIq7o7a6/k3l9t8T2FFNaXwvHjvwy60jJ6naviRy9cBNHHDHnU?=
 =?iso-8859-1?Q?1DLYZaVZHw67q/WBxwoZLwheH0Thv7GMWVjoW1NzKsAi6zYGs8UKQnQSpb?=
 =?iso-8859-1?Q?uvvhOcAK1r6ePChu/NkW30rO19oI6GDj2LxeWQGIQrWIB1FbgB5bjNpxRl?=
 =?iso-8859-1?Q?GPgWNNDHSVxeN4o/MVoMHN3jxr9Q1rM2eTWg5t/TwWGS/8flSSUcH4ZlQz?=
 =?iso-8859-1?Q?q1a3KObPXl0lRp3sXWeWf3sIGPlLtVQ1rjBvxnkXDRqiUz6WmkXgIyhxIC?=
 =?iso-8859-1?Q?ZmE4VOF/5yhJ3t3OZiify4SGCQG1aaRWwntXSKxhwNdEBXROfeqz3wvuKm?=
 =?iso-8859-1?Q?ydTlaw0nRludwjyFxcZ9Gic/lWn+zR7fimRVSDaGFG/+Qj6Qnp9pA8Vevj?=
 =?iso-8859-1?Q?E9BDbKLaKe0LnetCeQ6tm8dbyZOie09HUlxMrL7myMUYZkDrlNQjQb8FLi?=
 =?iso-8859-1?Q?puex/wXDvRXYp+F7dpx+3cOyV79Z8NVKxEVjtONqx7s3A7NkpzmzkJWL3g?=
 =?iso-8859-1?Q?WIob/lptJxMcYOjtXrdQrMUigIllN+F81Y/yZN7zAVmlDpETBze1CSTtqq?=
 =?iso-8859-1?Q?TaIzSAaG8gJGUe8MzQcPny6d3erjRIFjnPVGGkl57fmpy27g061Aywo0?=
 =?iso-8859-1?Q?=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB27026D92A5F5A59371BD5094E3760@VI1PR0402MB2702.eurprd04.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(346002)(376002)(396003)(136003)(39860400002)(199004)(189003)(386003)(53936002)(71200400001)(50226002)(86362001)(256004)(6506007)(8936002)(14454004)(99286004)(102836004)(2906002)(36756003)(97736004)(110136005)(52116002)(6486002)(14444005)(71190400001)(66066001)(2501003)(81156014)(2201001)(81166006)(8676002)(26005)(305945005)(478600001)(6512007)(486006)(4744005)(476003)(6116002)(3846002)(186003)(5660300002)(316002)(105586002)(25786009)(68736007)(4326008)(2616005)(7736002)(6436002)(106356001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB2702;
 H:VI1PR0402MB3392.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oEv5sN5a4DOf4eGyYAT7E0pvRL8S1ap0a0KeCNhqziMlpCo9+m8VYy33bLZ1nZi6YomkkJQEL9bbuFmrdELNyZOnheqSwvbuSjHbASTOfXX5vijAWMYvkKO/k/mMCmtJnRBHpZAt0+eKmkX/85Q54h+lqqLtgJYh2UCxGAEgTaI5DlSwpRytyQUCfa/NT3cTtrFWy4gob8g5oNP6o/zKbgRpFaO6pwPcltQtGmsbqiozNNKdvsWlAr0dLIBWy8zKerj/2stXBdqJ/t9TvzO8YvbHRTBicvIf9J05C/Ajy7jZlEvkby3rTtWbq0vgTNcsKvNw3hxyJEheP3vPxOcvaUGeoyyibZp7cBUOExN63bkCxFhQvXQHHH4vPNvW9AlPiDdljvqVuk450fR8RaKkZirz3x6c2ipYWODrDlASWkA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 069613c1-f85d-42f5-10c0-08d69dee2bb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 02:32:35.6724 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2702
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

There is a constraint for the channel number setting on the
asrc of older version (e.g. imx35), the channel number should
be even, odd number isn't valid.

So add protection when the asrc of older version is used.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_asrc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 528e8b108422..b3b3c5e15ef1 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -109,7 +109,8 @@ static int fsl_asrc_request_pair(int channels, struct f=
sl_asrc_pair *pair)
 	if (index =3D=3D ASRC_INVALID_PAIR) {
 		dev_err(dev, "all pairs are busy now\n");
 		ret =3D -EBUSY;
-	} else if (asrc_priv->channel_avail < channels) {
+	} else if (asrc_priv->channel_avail < channels ||
+		(asrc_priv->channel_bits < 4 && channels % 2 !=3D 0)) {
 		dev_err(dev, "can't afford required channels: %d\n", channels);
 		ret =3D -EINVAL;
 	} else {
--=20
1.9.1

