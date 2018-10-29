Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68ADC2BC61
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 09:12:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55A3F20664
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 09:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GqRNTl6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A3F20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42k84c3DkLzDrHZ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Oct 2018 20:12:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="GqRNTl6q";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=104.47.0.44; helo=eur01-he1-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="GqRNTl6q"; 
 dkim-atps=neutral
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0044.outbound.protection.outlook.com [104.47.0.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42k7lz1YY5zDrMm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Oct 2018 19:57:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MALEO5ltLd+Bp7OEryabJF+FlyngHm0DrJeZKbB87sM=;
 b=GqRNTl6qTOmGLhLMMSVcIBH3nxZk+vdzoK/x6DIJT/qo9FCsovjI7v5JFpWUrAkCRHYhGvn20RsXI3kklEnEw95CVJ9OcMJRXBd+9NbLAKgas00hvUVhZlgYpzPPMJqQjWvPFlY8Dxbo4WXZEaaMSMWiJBecBIu6r5CNQzC0jE0=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB4125.eurprd04.prod.outlook.com (52.133.14.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.18; Mon, 29 Oct 2018 08:57:47 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::c9af:2da0:2fc4:1aca]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::c9af:2da0:2fc4:1aca%3]) with mapi id 15.20.1273.027; Mon, 29 Oct 2018
 08:57:47 +0000
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
Subject: [PATCH v7 4/6] clk: qoriq: Add clockgen support for lx2160a
Thread-Topic: [PATCH v7 4/6] clk: qoriq: Add clockgen support for lx2160a
Thread-Index: AQHUb2V2fdiYZfrH3kSMzqsJmyAK6w==
Date: Mon, 29 Oct 2018 08:57:47 +0000
Message-ID: <1540759926-3641-5-git-send-email-vabhav.sharma@nxp.com>
References: <1540759926-3641-1-git-send-email-vabhav.sharma@nxp.com>
In-Reply-To: <1540759926-3641-1-git-send-email-vabhav.sharma@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::14) To VI1PR04MB4800.eurprd04.prod.outlook.com
 (2603:10a6:803:53::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB4125;
 6:xilpQNb0f3m647I7vKU6L25fs2Z2/kbec8oCmQP9wYrKF/PeQVl9W9dy/rjngHiRXqNaRL2wEO6wEyAHtl2AKU1mTMvnDvgJw1Meu2Lsbn2nR6MXOtLJVGkx3IUzmclbOBDXDv7kPsO4V37gay+3eL/X0DjdYcKFlAY/PTEg3zF2N+3lfwzhJXqgGWlzupGiDLEfPPdnpdWXJmmtzKHhAFFdmA0EoJ4RmtaMX+Oicp2xWXtY+JfbuUOnDr5M1oMhO1sCLmkdtQA737VnOQwvcPQf9EgLuI1iPPwf+bZT3HEUMO4UfB/lGa3VTMmY/nts8X/CeIVRAciDDGx9C4V+lu3Bu2lk8Xmyc/5E+LVbyKyc5GZeg/oVuz60EWjIpouYsb/1CRv4oSJx95+YXDkBBbHpK4R3hBqVC8Z8numuMuDI63mWZsXN5XCo9kPgs6sDTfR2PNGPOssshrPZd2zSFA==;
 5:llEAlFQHdT6uM+s6dPaTRICONZrxXoX57gXi5uli8RarwMVI81gVw21DJ1yv+FC1WMAX6XfpnCOCDc5Feso07OxB5TwOBkvVFjZ2MxdaSscMZbJY7apE7rZr3ek41y13KAirfSJZmNpUIraXzObUYNefvaz3AD4tWBqTed/kFY8=;
 7:mmtt3p3U3khODb89UdH25x+E4XCi1NONkZm4J6DpsgDyQv2TXPh78dZTJYRy0MExTuqaCnFaTeaIl2FuWnn7ce8ZNhk7aSydwfumKtoAdl6D7wqAIBLc4kGykOWlmq71b4yBXs+qxOCN+kEnPciDAw==
x-ms-office365-filtering-correlation-id: 916cc28c-8e2a-4139-3fb5-08d63d7c98f2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4125; 
x-ms-traffictypediagnostic: VI1PR04MB4125:
x-microsoft-antispam-prvs: <VI1PR04MB41250940BEDDC2342E131BC2F3F30@VI1PR04MB4125.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB4125; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB4125; 
x-forefront-prvs: 084080FC15
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(346002)(396003)(376002)(39860400002)(366004)(199004)(189003)(316002)(44832011)(86362001)(106356001)(5250100002)(2501003)(305945005)(11346002)(7736002)(71190400001)(446003)(8936002)(2616005)(476003)(71200400001)(2201001)(486006)(105586002)(186003)(76176011)(81156014)(81166006)(2906002)(110136005)(6512007)(54906003)(26005)(99286004)(6116002)(14454004)(25786009)(256004)(7416002)(36756003)(4326008)(53936002)(6436002)(3846002)(102836004)(6486002)(5660300001)(97736004)(52116002)(66066001)(2900100001)(68736007)(478600001)(8676002)(55236004)(386003)(6506007)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4125;
 H:VI1PR04MB4800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gsqK9s+N0Dm82zOwzWkHrUvsX2A1geJWOUEHTD7HO0raIzJDH0rTWqGYbZ3X84E47Bs+kByyI/BZA3xbKid0sicB+v2NjeOdb3aWyivB1ZG24a/O0S500oSzpxotoHvaM/Ybs+Zjr+yc/386noXbM/NJDWDVYODbriAJawQUIiPNKFS4wTihYkfIg7nmi3m2SrMV62qzqmGHmy8qcWtcKexs9eUO741BoiYkd+LLHKHnvvaA8AAsjd/Batv/jm7na8k8QNKZK8yjt/iqdDNwTdOXG/PUM8x4z9sw30jwKwJSPChdQXGtfNyHBB+zq6pY9srgeTRnN3QjL9qSV0hJAMzYv5NIE66Yh1VtRR7ZNuI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916cc28c-8e2a-4139-3fb5-08d63d7c98f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 08:57:47.5130 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4125
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
 Andy Tang <andy.tang@nxp.com>, Udit Kumar <udit.kumar@nxp.com>,
 Pankaj Bansal <pankaj.bansal@nxp.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 Varun Sethi <V.Sethi@nxp.com>, Vabhav Sharma <vabhav.sharma@nxp.com>
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
index e152bfb..99675de 100644
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
@@ -1424,6 +1435,7 @@ CLK_OF_DECLARE(qoriq_clockgen_ls1043a, "fsl,ls1043a-c=
lockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1046a, "fsl,ls1046a-clockgen", clockgen_in=
it);
 CLK_OF_DECLARE(qoriq_clockgen_ls1088a, "fsl,ls1088a-clockgen", clockgen_in=
it);
 CLK_OF_DECLARE(qoriq_clockgen_ls2080a, "fsl,ls2080a-clockgen", clockgen_in=
it);
+CLK_OF_DECLARE(qoriq_clockgen_lx2160a, "fsl,lx2160a-clockgen", clockgen_in=
it);
=20
 /* Legacy nodes */
 CLK_OF_DECLARE(qoriq_sysclk_1, "fsl,qoriq-sysclk-1.0", sysclk_init);
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

