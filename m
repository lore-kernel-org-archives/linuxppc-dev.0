Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAD_ENC_HEADER,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BC4C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 10:19:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EF5D20684
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 10:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Aw7PpfGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF5D20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447vv76bK2zDqW3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 21:19:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.0.73; helo=eur02-am5-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="Aw7PpfGU"; 
 dkim-atps=neutral
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00073.outbound.protection.outlook.com [40.107.0.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447vjG5GVlzDqLV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 21:11:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6yx9+XmqFPikl/HnGKaf00f5Dt+SvH1gw7tqvo/SxY=;
 b=Aw7PpfGU0KjthGZMl3Gi5WSTtyULdxmUco6FGV3JuSmEkRj/WH3Y/gZpDsZz+3+6YSasPnZ07GiALNkbXsRshTRO2EzyAh6lSbZzAF+K8oQ6pi0z66NmSqvYIyNkTtrvNTeUhEQIZQHSlm0Gh4QAJ6JEZzQkSyX5ajY5zd7+x1Q=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB5277.eurprd04.prod.outlook.com (20.177.51.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Tue, 26 Feb 2019 10:11:08 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::7437:2195:ffd3:a33a]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::7437:2195:ffd3:a33a%5]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 10:11:08 +0000
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
Subject: [PATCH v1 4/4] clk: qoriq: Add clockgen support for lx2160a
Thread-Topic: [PATCH v1 4/4] clk: qoriq: Add clockgen support for lx2160a
Thread-Index: AQHUzbuXu37W8f+1a0WjYnXw55qsUA==
Date: Tue, 26 Feb 2019 10:11:08 +0000
Message-ID: <1551132245-6089-5-git-send-email-vabhav.sharma@nxp.com>
References: <1551132245-6089-1-git-send-email-vabhav.sharma@nxp.com>
In-Reply-To: <1551132245-6089-1-git-send-email-vabhav.sharma@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::21) To VI1PR04MB4800.eurprd04.prod.outlook.com
 (2603:10a6:803:53::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [92.120.1.65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c12fabf-c1da-4a60-45a3-08d69bd2b974
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5277; 
x-ms-traffictypediagnostic: VI1PR04MB5277:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; VI1PR04MB5277;
 23:SgYx5HX5dVEQmQxbXrmsPJJRryBsJkZmdVa/ePW?=
 =?iso-8859-1?Q?7RJLb1yCrrTA3/h4JLL5Uw0JoQ8JHs1Olkx4IXqZZIk6eCP2+2KC06QK9z?=
 =?iso-8859-1?Q?N51Vwd1lEcDfPfneCwluJ40IeHS+J1TppPgOPpNymH93t8j6SuRdx7WpsI?=
 =?iso-8859-1?Q?eZfNAp5LDl+gfys/Btwjbsn0yG5uQsShEfcZgFcEo6bw57mH1bS/v+OKs8?=
 =?iso-8859-1?Q?3NmbyUIfvxDjljdRVBbQA1ol5P97uSRshotDvybA7ghIQ2eTAdme8XomXb?=
 =?iso-8859-1?Q?nVaLiTbmNxd7+LO4qBDicJxMlSI+tybxf07Z48hwH8yAPST+KgjPf4q67w?=
 =?iso-8859-1?Q?ONJEtedL7BOkCQ8jIlDVJr5L1mskppI69HNGoOVu4k3p16jVvYwWvHnQFV?=
 =?iso-8859-1?Q?Pa71T5wdl7STztfx1RK/+Q/26X5c36KREOErPLdI4pI4EvB6yBHSyPtxB2?=
 =?iso-8859-1?Q?2IL1531lyqumNL+iGzFLzOUGS27CYS5CXIk5F6XJFTeF0H7LZhgPwLKj+T?=
 =?iso-8859-1?Q?e5hqQfUisB+3t+7ZuotTWl44jkau7qmJcn66A0oKD4w6A0vNIC16h2YoWw?=
 =?iso-8859-1?Q?D+lk0EX20fYcyXErm10zrHX1Y8QJX2uCZkC7kq2ooCue5wRGyCItLFKlNP?=
 =?iso-8859-1?Q?NfEVIGY+/Pbg8JRR/xzUOz3FPKRfISWCujlCDF5JayRb7q9r4JNjtYun0+?=
 =?iso-8859-1?Q?TltNLm48t8efdV5Z61xs8ZQ+m4aSyvUhH+gYczN4/F0BFyj3OdGRLl203N?=
 =?iso-8859-1?Q?+a6q7FABM05NaBOu2hPydp6SwXJBVKZrwvXgXqpSXSwi8JrpsEkq1zZxCb?=
 =?iso-8859-1?Q?L04ErjnyqynXdMMkQj7q+s04wHWHuxmDw2GLOZh225Hg/J6RkXZ8BmOlOq?=
 =?iso-8859-1?Q?hOFqnViNGf2d/FTI+nK+KyCkkuGX3W8N4TeqnTmR4whS8w7tFT6mcwKHEg?=
 =?iso-8859-1?Q?t2JNmUX5szEgHs/Pt6nlUw0RII5bQHSRmYGAhNwYDkmiafuHMxUZ6ZdqZz?=
 =?iso-8859-1?Q?W8MX9XilvN49/QHntVNR232ksZ/wm6GnivfhX0UsyXWN/KlCbtmymnQYoi?=
 =?iso-8859-1?Q?GoPCczGbtocPhb+Ftyy7bazX4Bn+Tv4rnkRYK36LaOIN9AuFAPOFEpGyUV?=
 =?iso-8859-1?Q?ZheztAN/P5iEcbha7jB+bEAZrsR3v8T0TG6es4gnzgdeth+XwQAEU4OTBt?=
 =?iso-8859-1?Q?tHQJllw9kSZF887oZ2LlhIEfi75BJNpvYDabuZzFCkcmOdqL0eslZZsUiA?=
 =?iso-8859-1?Q?yBsbv+QlRgVVqWqRNMcQgJfAzu9n6jci4WjVc7xITr+RRptxRYvnRKnFsS?=
 =?iso-8859-1?Q?O11gAUYWhZkkmZxuMm6U2PKwhu2BILtPuVll1lLcm8jKg=3D=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB527754FF34E5149AB97BD95AF37B0@VI1PR04MB5277.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(136003)(366004)(39860400002)(376002)(396003)(189003)(199004)(81156014)(81166006)(6512007)(8676002)(386003)(52116002)(53936002)(76176011)(6506007)(26005)(6486002)(6436002)(4326008)(102836004)(36756003)(50226002)(25786009)(2501003)(99286004)(66066001)(8936002)(105586002)(14454004)(106356001)(2906002)(256004)(6116002)(3846002)(305945005)(478600001)(7736002)(486006)(86362001)(44832011)(11346002)(476003)(2616005)(446003)(7416002)(68736007)(5660300002)(71190400001)(71200400001)(316002)(2201001)(186003)(97736004)(110136005)(54906003)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5277;
 H:VI1PR04MB4800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RrOEwimNC0lzv2V3L7yH4eNc0iQw/iSfAXF/HpYnfsgtqUDz4EIou/HMtWFZF1Q8bpUKWUE6t95LwieM7UVMgdlZXZ5LykCbmreysh//VxZ6mDdbsx3AqCxaHG1tYzjlBwbJT076V74Aftb4OnHTDQRSysxF8jDn/3FZvSBqIohGbjgQGcrarZEAOijDeoTsrZyU8Pb/QfeGM113M9v2z7KMl9I9CTJpbihoOTkSr3pqiOPcG0gp2HQYls2ajpb5YgUB6Se0LbmA7fh3rbxAneeqlVRZkPnhwoVLYCeKn19nwpq7shzVJrJ0IyVag3l9zhQjfx5FOIf5DMvIMoGFiOgW6MxWFSlrhc+R4IW9AzyqDfJKyi+XNTrPii4yht0yrsaHhNxooLAT/3mYgeuZxMMZYEPAfcGnt2mW0fHQhzU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c12fabf-c1da-4a60-45a3-08d69bd2b974
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 10:11:02.7292 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5277
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
 Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 Andy Tang <andy.tang@nxp.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 Vabhav Sharma <vabhav.sharma@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>

Add clockgen support for lx2160a.
Added entry for compat 'fsl,lx2160a-clockgen'.

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clk/clk-qoriq.c         | 12 ++++++++++++
 drivers/cpufreq/qoriq-cpufreq.c |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index e75194a..288e8f0c 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -570,6 +570,17 @@ static const struct clockgen_chipinfo chipinfo[] =3D {
 		.flags =3D CG_VER3 | CG_LITTLE_ENDIAN,
 	},
 	{
+		.compat =3D "fsl,lx2160a-clockgen",
+		.cmux_groups =3D {
+			&clockgen2_cmux_cga12, &clockgen2_cmux_cgb
+		},
+		.cmux_to_group =3D {
+			0, 0, 0, 0, 1, 1, 1, 1, -1
+		},
+		.pll_mask =3D 0x37,
+		.flags =3D CG_VER3 | CG_LITTLE_ENDIAN,
+	},
+	{
 		.compat =3D "fsl,p2041-clockgen",
 		.guts_compat =3D "fsl,qoriq-device-config-1.0",
 		.init_periph =3D p2041_init_periph,
@@ -1426,6 +1437,7 @@ CLK_OF_DECLARE(qoriq_clockgen_ls1043a, "fsl,ls1043a-c=
lockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1046a, "fsl,ls1046a-clockgen", clockgen_in=
it);
 CLK_OF_DECLARE(qoriq_clockgen_ls1088a, "fsl,ls1088a-clockgen", clockgen_in=
it);
 CLK_OF_DECLARE(qoriq_clockgen_ls2080a, "fsl,ls2080a-clockgen", clockgen_in=
it);
+CLK_OF_DECLARE(qoriq_clockgen_lx2160a, "fsl,lx2160a-clockgen", clockgen_in=
it);
 CLK_OF_DECLARE(qoriq_clockgen_p2041, "fsl,p2041-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_p3041, "fsl,p3041-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_p4080, "fsl,p4080-clockgen", clockgen_init);
diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufre=
q.c
index 3d773f6..83921b7 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -295,6 +295,7 @@ static const struct of_device_id node_matches[] __initc=
onst =3D {
 	{ .compatible =3D "fsl,ls1046a-clockgen", },
 	{ .compatible =3D "fsl,ls1088a-clockgen", },
 	{ .compatible =3D "fsl,ls2080a-clockgen", },
+	{ .compatible =3D "fsl,lx2160a-clockgen", },
 	{ .compatible =3D "fsl,p4080-clockgen", },
 	{ .compatible =3D "fsl,qoriq-clockgen-1.0", },
 	{ .compatible =3D "fsl,qoriq-clockgen-2.0", },
--=20
2.7.4

