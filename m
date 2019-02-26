Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01FCC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 08:47:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2976D2147C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 08:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fraZWQd+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2976D2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447sr971f7zDqBt
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 19:47:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.74; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="fraZWQd+"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00074.outbound.protection.outlook.com [40.107.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447sZ26DWtzDqQC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 19:34:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Tw12xB1ajkqPXg0EQ6CyGxy6i6KHRsX+WOfIzWGsZE=;
 b=fraZWQd+qRWc2gXUZskz+9+5DzRR1LAMkXNxPDs0UQ74KYk3DSXQZSJz5Kmn34jvPmW7i3uW0JiQIgGB43BLgLeG+DONU0lAL7R0dtgldTY20U0UIdyegwEJQJFcgrcZc6YTD/llOdCd9QGK1LNRdZmyeygSocBe2tf6wUQKcy0=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB5645.eurprd04.prod.outlook.com (20.178.125.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Tue, 26 Feb 2019 08:34:35 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::7437:2195:ffd3:a33a]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::7437:2195:ffd3:a33a%5]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 08:34:35 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
To: "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "oss@buserror.net"
 <oss@buserror.net>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "mturquette@baylibre.com"
 <mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org"
 <viresh.kumar@linaro.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "linux-kernel-owner@vger.kernel.org"
 <linux-kernel-owner@vger.kernel.org>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de"
 <arnd@arndb.de>, "kstewart@linuxfoundation.org"
 <kstewart@linuxfoundation.org>, "yamada.masahiro@socionext.com"
 <yamada.masahiro@socionext.com>, Leo Li <leoyang.li@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: [PATCH 2/4] soc/fsl/guts: Add definition for LX2160A
Thread-Topic: [PATCH 2/4] soc/fsl/guts: Add definition for LX2160A
Thread-Index: AQHUza4aeDqtR2umI0q7E04i1k47GQ==
Date: Tue, 26 Feb 2019 08:34:35 +0000
Message-ID: <1551126463-5341-3-git-send-email-vabhav.sharma@nxp.com>
References: <1551126463-5341-1-git-send-email-vabhav.sharma@nxp.com>
In-Reply-To: <1551126463-5341-1-git-send-email-vabhav.sharma@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::23) To VI1PR04MB4800.eurprd04.prod.outlook.com
 (2603:10a6:803:53::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [92.120.1.65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a37faaeb-8425-4db1-1b1a-08d69bc53ca0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5645; 
x-ms-traffictypediagnostic: VI1PR04MB5645:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB5645;
 23:eFBT/RqV/JsWqK4V7QnX6qTiZDzLi48eIdOC92R?=
 =?iso-8859-1?Q?dWhP/HPMf3KAHKCMBZ2BNUL2wNPWUEe4CmSV+Yn9pUY0PkZYnJ3UPnjWg0?=
 =?iso-8859-1?Q?w2ZtX1fKTT2DtJgV9E3qAobvRrO+STuHzHaGKKe9fSsPLlV94+oTf2Xznz?=
 =?iso-8859-1?Q?kU7c7RoN7R8FaRAgSLRVrAKsFD0BcreYMAWX9O7jZWmYC265p3tk9RJ22u?=
 =?iso-8859-1?Q?QSb8uLRtr7rk3CzfWttJUsvPefQ+qxNNi6CXHGl6Hnya8OTTbOhlG3dEuq?=
 =?iso-8859-1?Q?+bO1t1us1s9G3tsgfP75qRcnkgDceaOOxU5EtcBA6dtFen0psH6nkbCA2B?=
 =?iso-8859-1?Q?EuD9R5mAB+iyBYYTqGaxdsxs7pJ2AHbSN4L2ZygVzgVtxrVt8rLd59iotE?=
 =?iso-8859-1?Q?End45VyjC0h1S6jlYTB7zc+XEj+msbsxZIiR7bmQphNysu9/o9+w0RsSwo?=
 =?iso-8859-1?Q?E1rVwHOrSFPjMeMWeDIlA7/7+Gm4FlCEts0TwFZcZRrtdj5xTyaaz1GBsY?=
 =?iso-8859-1?Q?t3Ejby0OPMgd3wcfdbbcF36mcVF2R05vTwZFodefFLLa2I1btvMQ9jbHmd?=
 =?iso-8859-1?Q?z4id2NfZhbZj2ampYjm8gG0n2HlZom6BBZnZAM21fFZ22qfr3Tl3wEXZQN?=
 =?iso-8859-1?Q?lR899LSRaVDMlzfgOS3FlD7lXWuvdBQ/HfPT+tM1OZpW3sdU46nJneSPRk?=
 =?iso-8859-1?Q?GpMfiMEJOTAchnDP71QziqemKWg8RlsasuWq+ZXbfpq5l+2mhEWGPShhC0?=
 =?iso-8859-1?Q?UpjsIZnUGd30OGg4rhUqGUaZXYoLp/m3mYuIEh8C08YIPRahKq4sVITc3h?=
 =?iso-8859-1?Q?Ol0BBLpEAtLbYgeUmbhlRK5N5EjVT4fbYpGJ3HS2EFmFF+4zG815kkea9z?=
 =?iso-8859-1?Q?Ze7qeVoI5spS8nii/nJC5JdLsGdXZ5c0CNFuRzijCw594ysDVlWnpg/734?=
 =?iso-8859-1?Q?1ePXWpgfF5Hs+eNRmob3XyLXlEpGu9JoAR9Og98k9fde2CkdNKioAv2S12?=
 =?iso-8859-1?Q?tSaONgELu8M1s6bKiwxxKn111fGRH0EiLv0Bc6edpm3GXBqMaxeVLbjs/u?=
 =?iso-8859-1?Q?7Vl3RQPGqPVu4w2y9ACGKpeG+owiVJ7vAkuo27MTHs4N98LepW3BD5N2w6?=
 =?iso-8859-1?Q?dG2Bwxx1Ymr1+lmiJ6qAt/YUAi9qsO+AOBdquLBrQdkGmbDs5H9STC/e5M?=
 =?iso-8859-1?Q?jZ2kYUqMwq8dFgGWCKlAxaCYJD9jCitNqZxzQM9UX/Sy56RVy8/YjlXzdX?=
 =?iso-8859-1?Q?Kl+do+bHq8kCRqZu7kj5p0jNCwgLFiFWv8zSEYeVBJ7U2/xPVsmyQNYgRe?=
 =?iso-8859-1?Q?Y+R67G2DveTM8HbFPI+WwFvIT0COhcQbx6sHGhDhQH1G8Asy4nedPDXmTE?=
 =?iso-8859-1?Q?ZvbpC4hb8upADINZromj5jQAZZg8s?=
x-microsoft-antispam-prvs: <VI1PR04MB5645E912C971FE6A7E2E4A33F37B0@VI1PR04MB5645.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(396003)(136003)(39860400002)(376002)(199004)(189003)(66066001)(71200400001)(71190400001)(2906002)(478600001)(97736004)(6512007)(50226002)(8936002)(5660300002)(54906003)(6506007)(99286004)(386003)(76176011)(102836004)(2501003)(53936002)(110136005)(2201001)(52116002)(86362001)(68736007)(4744005)(316002)(6436002)(2616005)(11346002)(476003)(486006)(7416002)(7736002)(44832011)(186003)(81166006)(8676002)(81156014)(3846002)(6116002)(446003)(6486002)(4326008)(25786009)(256004)(106356001)(36756003)(305945005)(26005)(105586002)(14454004)(921003)(1121003)(473944003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5645;
 H:VI1PR04MB4800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fA9p7Q6NZuPcAZ2PQFnX/fimZcMYDiVLzpdCv++rJoD8Rkb/qEgsr5QXGMgbp9nxOkZua6IXNuryWbFbAyNntHBSLwFeGLFWeL6cBGpll9hZxiUCtVI2AlKVjClNsDDLZRco1ABma+zBCunS4cby3HaRAs7nwoGdhufXyKYUaMEhHRFc0MgqvghS0Oxe1hicJEPAD6YEHFpHl+Y2VHEubYFaEF31CpQDUJWX23ufmt9GEKYw/73mv4aVpXVRK+Q+2dcQj2JtoF0WXLJmCvGzWyQve5o4RvbTb2borqz0sNbgv27BHJqoUA259eNF5nSVuvjjxTn2jXBWArBZA0IkUPazZy+zYNSbMRJ8JaGAX4IintKkvJX0jY3OJHyJkX6zyLguvsoWlFCBN0z6sVZMouYUgMrdqx7KQ2PH2ClbE/E=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a37faaeb-8425-4db1-1b1a-08d69bc53ca0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 08:34:29.7163 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5645
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
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 Yinbo Zhu <yinbo.zhu@nxp.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 Vabhav Sharma <vabhav.sharma@nxp.com>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Adding compatible string "lx2160a-dcfg" to
initialize guts driver for lx2160 and SoC die
attribute definition for LX2160A

Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
Acked-by: Li Yang <leoyang.li@nxp.com>
---
 drivers/soc/fsl/guts.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 302e0c8..bcab1ee 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -100,6 +100,11 @@ static const struct fsl_soc_die_attr fsl_soc_die[] =3D=
 {
 	  .svr		=3D 0x87000000,
 	  .mask		=3D 0xfff70000,
 	},
+	/* Die: LX2160A, SoC: LX2160A/LX2120A/LX2080A */
+	{ .die          =3D "LX2160A",
+	  .svr          =3D 0x87360000,
+	  .mask         =3D 0xff3f0000,
+	},
 	{ },
 };
=20
@@ -222,6 +227,7 @@ static const struct of_device_id fsl_guts_of_match[] =
=3D {
 	{ .compatible =3D "fsl,ls1088a-dcfg", },
 	{ .compatible =3D "fsl,ls1012a-dcfg", },
 	{ .compatible =3D "fsl,ls1046a-dcfg", },
+	{ .compatible =3D "fsl,lx2160a-dcfg", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fsl_guts_of_match);
--=20
2.7.4

